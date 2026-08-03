Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9334EEEA
	for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796280; cv=none; b=HWcEoV9k3Jeu3IFz3EiI4yByaNiTHYY8VJcms4qlkIWBmkQjKclCAMPbB1ZqPuQB1zSiMqc2tn7KjtxRKfrrm03uSQ9I6XWsImGLt6v0dNIohTFatl3iNWOjkiRXIunpTynCF8RGv35sCrLfzX6PBRcjRRIJ0SAG9v+MMW/2ykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796280; c=relaxed/simple;
	bh=UxdpIGw9oC6cf066AIC44wV6d6UfEMHFOIUEqqOu77U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBI/DSnqSLZ+C38QZZHOupwNXhoVc77etu08R8hra1xhBlnczkvQmc/IP7E2ljNnG4XhA5YMQSLRNgUKfoi+GpbJQM3jMC8bfW4XA1JvJRdnJxUhb/B+i8k+1tBAoHsV5tFhzyvcwOyNhMFdU1WErpvncxdq5Ui+Z5hX6DD7qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7rm7zbb; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7rm7zbb"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66843304cbaso5609032d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2026 15:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785796277; x=1786401077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TaCAksqvz2wcTu4zxzoqEsp14HvgIozMCnF+hHCjPoc=;
        b=j7rm7zbbPxYkyV2xndjM3PWtx59swOjSL8Vj1JUkTbgnFnAEr8ngh2R2a/YgCpqN9e
         HCJq3Gld21YP9AdUaGazbQWbQWM6Uq7WTdHNNXnli+As6UArGiqg63DYYCLfY3FRgpGT
         0/2autm5aL47beOF3hULE56zn5mFmYrDHBL391YCGIq50M9WxMsjCYkf78Y3RKZxjtOo
         hNT9nYTBqpZIZEJ3+8fTNrLzkhnVIYxvyFE3mja2YxqpdpL0/GgLe9SG5YYA9I+dGFA0
         Zw/nCmVBl/NhoJmTcy2ouj6Qy2xbimjUj4qc+Tu2XF9Q9jqYgswsdasrgmCW5TATeQvf
         MTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796277; x=1786401077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TaCAksqvz2wcTu4zxzoqEsp14HvgIozMCnF+hHCjPoc=;
        b=jrSbSBr19tGOxDh7O2JGmaYfRmbRH5agaJUSANAKYKwpv2AiModk62D7+Wr8e4eZzf
         rhiOn9CQ61+NPhB0KOytUOpDroy4FU0XwXqZhwlDGRk9MEBqd7tXDL1gejmn1zytTm/p
         fYaLGasVfrqn9H5/yJa66Xvgn9cAH4a2gVPz+yH8z7IgYOpTvECqYMrYkuJvaYmNPDL3
         2fi65sPvWX8eBEWq7tcw7vb13p8eJ5FBAKP89RljNeJpkgQoE/OAkCcNqkUPjuJ/Mg01
         EMgM7Fg6R8cayASmhNjKM2qQ58Nhc/kkCUEZU0bpv1jnzF64XSS+0FyfKte1Xb8GGUUC
         Cm8w==
X-Forwarded-Encrypted: i=1; AHgh+RqBMSKb0duPSnCelgAqGA32Qwzv5yoyLvRIp45gH3yBvffDw5ruYkyHge2sN+69fWQXwlUCT0QssmGITSorsdN8937US7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgSMDGVgc60bCi1DlCD4SLMoICUZoJDWgI9kb+nyFqnUvS4Xp
	nS+8an7l7eNWqMoMkJWf+B5fWDdrHow3ldxWM/NX99S8i3PwHwwUj61x
X-Gm-Gg: AR+sD132uLz/068VbVy+N5dzOtbNLSgdENNyNBYuPWbqxPAxhhO+V0okzA3xfdTGz5F
	Dp2hutjiUsM+grE7wYHMPBoyJig8c33KNfiy+LyOgXg9AOlbqcBfAWBCMoNIPsyFm+eomZbnkBP
	7zNe2U4DFrYhk6ujYJOiKPh6rZRZOExCw3VfnHsHHRmVYLQirLod4FsMBYHiJoyjtplKJEaDCYh
	IJYGZJu3Zh/1hVjxi9oMdBwHMutA7o5XpOpYc/50LRVQ7oCoYCOH0FmsvJ1f1fsaMgVUfX2OW9g
	nrAey2UemOwRPy4w9lvBJWH4zyEGPuv3rJxs7Onr8kzNVS5PuQwkKdRCPxGVpoF/Zb9XKPwYdZq
	SJSbZCsXWdah9W+H/L9IU6xNzwh+3LTtPCYF+7WwsQhnxRUJPBI9Fy05Cu0yK4ZOvaEM92OQuTp
	VtdSZ+yFDC3ToGkUtVzhPYYU78XvP1vx7rrxAlV5CE6I9bdFAnoUOdJVs/EupGqQS4Voxn8eXQ+
	xfV4zqHUCG0VvFKlo0ymaU=
X-Received: by 2002:a05:690e:155b:10b0:667:e04a:8a3f with SMTP id 956f58d0204a3-6694efcc215mr11327912d50.5.1785796277266;
        Mon, 03 Aug 2026 15:31:17 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6253:b407:801c:a745])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6694903782fsm6420774d50.21.2026.08.03.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 15:31:17 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v3 2/4] selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Mon,  3 Aug 2026 18:31:06 -0400
Message-ID: <20260803223109.707353-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803223109.707353-1-utilityemal77@gmail.com>
References: <20260803223109.707353-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a successful landlock_restrict_self(2) call with
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS sets no_new_privs without a prior
prctl(2) call nor CAP_SYS_ADMIN, that a failed call from both an
invalid ruleset and hitting the layer maximum leaves the attribute
unchanged, and that LANDLOCK_RESTRICT_SELF_TSYNC extends it to sibling
threads.  Also check that this flag requires a ruleset, and update the
restrict_self_checks_ordering EPERM checks since this flag is now
checked before the flags validity.

Finally, rename restrict_self_fd_logging_flags to
restrict_self_fd_flags, and restrict_self_logging_flags to
restrict_self_flags to indicate that non-logging flags are now tested.

Update the ABI version and last-flag checks accordingly.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
    - Run clang-format
    - Add max-layers tests (base_test and tsync_test) checking E2BIG and
      that a failed call leaves no_new_privs unchanged
    - Mention the test renames in the commit message
    - Match comment style of surrounding tests

 tools/testing/selftests/landlock/base_test.c  | 99 ++++++++++++++++++-
 tools/testing/selftests/landlock/tsync_test.c | 72 ++++++++++++++
 2 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..c8ed165a32ed 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -76,7 +76,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(10, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(11, landlock_create_ruleset(NULL, 0,
 					      LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
@@ -255,8 +255,15 @@ TEST(restrict_self_checks_ordering)
 
 	/* Checks unprivileged enforcement without no_new_privs. */
 	drop_caps(_metadata);
-	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(-1, landlock_restrict_self(
+			      -1, ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
 	ASSERT_EQ(EPERM, errno);
+	/*
+	 * LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS fulfills the no_new_privs /
+	 * CAP_SYS_ADMIN requirement, so the invalid flags are checked first.
+	 */
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(EINVAL, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
@@ -277,6 +284,41 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST(restrict_self_max_layers)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.parent_fd = -1,
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	path_beneath_attr.parent_fd =
+		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_attr.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath_attr, 0));
+	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+
+	/* Enforces the maximum number of allowed layers. */
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+
+	/* Enforces one too many rulesets. */
+	drop_caps(_metadata);
+	ASSERT_EQ(-1, landlock_restrict_self(
+			      ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	ASSERT_EQ(E2BIG, errno);
+
+	/* Checks that the failed call did not set no_new_privs. */
+	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
 TEST(restrict_self_fd)
 {
 	int fd;
@@ -288,7 +330,7 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
 
-TEST(restrict_self_fd_logging_flags)
+TEST(restrict_self_fd_flags)
 {
 	int fd;
 
@@ -302,11 +344,16 @@ TEST(restrict_self_fd_logging_flags)
 	EXPECT_EQ(-1, landlock_restrict_self(
 			      fd, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 	EXPECT_EQ(EBADFD, errno);
+
+	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADFD, errno);
 }
 
-TEST(restrict_self_logging_flags)
+TEST(restrict_self_flags)
 {
-	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 
 	/* Tests invalid flag combinations. */
 
@@ -349,6 +396,17 @@ TEST(restrict_self_logging_flags)
 				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
 	EXPECT_EQ(EBADF, errno);
 
+	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+					  LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADF, errno);
+
 	/* Tests with an invalid ruleset_fd. */
 
 	EXPECT_EQ(-1, landlock_restrict_self(
@@ -359,6 +417,37 @@ TEST(restrict_self_logging_flags)
 			     -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF));
 }
 
+TEST(restrict_self_no_new_privs)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/*
+	 * The calling thread does not need CAP_SYS_ADMIN nor an explicit
+	 * prctl(2) PR_SET_NO_NEW_PRIVS call.
+	 */
+	drop_caps(_metadata);
+	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	/* Checks that a failed call does not set no_new_privs. */
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADF, errno);
+	EXPECT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	/* Checks that a successful call sets no_new_privs. */
+	ASSERT_EQ(0, landlock_restrict_self(
+			     ruleset_fd, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(1, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
 TEST(ruleset_fd_io)
 {
 	struct landlock_ruleset_attr ruleset_attr = {
diff --git a/tools/testing/selftests/landlock/tsync_test.c b/tools/testing/selftests/landlock/tsync_test.c
index 9cf1491bbaaf..afa4a8222248 100644
--- a/tools/testing/selftests/landlock/tsync_test.c
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -90,6 +90,78 @@ TEST(multi_threaded_success)
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
+TEST(multi_threaded_no_new_privs)
+{
+	pthread_t t1, t2;
+	bool no_new_privs1, no_new_privs2;
+	const int ruleset_fd = create_ruleset(_metadata);
+
+	disable_caps(_metadata);
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
+	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
+
+	/* No prior prctl(2) PR_SET_NO_NEW_PRIVS call. */
+	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	EXPECT_EQ(0, landlock_restrict_self(
+			     ruleset_fd,
+			     LANDLOCK_RESTRICT_SELF_TSYNC |
+				     LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+
+	EXPECT_EQ(1, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_cancel(t2));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, pthread_join(t2, NULL));
+
+	/* The no_new_privs flag was enabled on all threads. */
+	EXPECT_TRUE(no_new_privs1);
+	EXPECT_TRUE(no_new_privs2);
+
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST(multi_threaded_no_new_privs_max_layers)
+{
+	pthread_t t1, t2;
+	bool no_new_privs1, no_new_privs2;
+	const int ruleset_fd = create_ruleset(_metadata);
+
+	/* Enforces the maximum number of allowed layers. */
+	for (int i = 0; i < LANDLOCK_MAX_NUM_LAYERS; i++)
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+
+	ASSERT_EQ(0, pthread_create(&t1, NULL, idle, &no_new_privs1));
+	ASSERT_EQ(0, pthread_create(&t2, NULL, idle, &no_new_privs2));
+
+	disable_caps(_metadata);
+
+	/* No prior prctl(2) PR_SET_NO_NEW_PRIVS call. */
+	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	ASSERT_EQ(-1,
+		  landlock_restrict_self(ruleset_fd,
+					 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS |
+						 LANDLOCK_RESTRICT_SELF_TSYNC));
+	ASSERT_EQ(E2BIG, errno);
+
+	/* Checks that the failed call did not set no_new_privs. */
+	ASSERT_EQ(0, prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0));
+
+	ASSERT_EQ(0, pthread_cancel(t1));
+	ASSERT_EQ(0, pthread_cancel(t2));
+	ASSERT_EQ(0, pthread_join(t1, NULL));
+	ASSERT_EQ(0, pthread_join(t2, NULL));
+
+	/* The no_new_privs flag was not enabled on any thread. */
+	EXPECT_FALSE(no_new_privs1);
+	EXPECT_FALSE(no_new_privs2);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
 TEST(multi_threaded_success_despite_diverging_domains)
 {
 	pthread_t t1, t2;
-- 
2.54.0

