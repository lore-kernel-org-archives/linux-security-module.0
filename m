Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6E3D953C
	for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325815; cv=none; b=UxC3J7PuAOPTJ/fCw2MMl9apIb2z+LchUSWUOYYNn794hOPh6ZIRUQSbRn1IJ4sI7ijo6Rx1SYH8S6mexTKb//vtDTDQ+09GbMoMkl8y0NiyU8XTud99Tyuifo76ZNbWXRi/Xb/wD2uOXAjoKTyqFpbc6UNm9igOZG6rLoA9dhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325815; c=relaxed/simple;
	bh=m4Jclk5YNxQi2TwcRbnqEtYX1BSm+HxO+6jHh+k55kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riSUOje44aBOsWVaFEbsyt7JcfTwmX78xE8cOXPa0cRB/ER6QcH6VX9KHetjqaCtzA4QGbFHw2HGsbAyQQyizUZFpwiw8O9PbhiCgNsGBsWFsFvUOE2DwDtO41gDLaq58WhGBSGeZ3ikmMfNqToyvRNRJPoPDoO3Qyf8uI+GRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Scat0F; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Scat0F"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80dc4a68e4aso68176807b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 17 Jul 2026 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784325813; x=1784930613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ama0SVn97k9iAkAOQhRx4hyF+HPcsesIUw/q/aLtCKc=;
        b=T3Scat0F/iQVnQOFAwpJlHVZqMEsf1nndbhQt44fg6TARJaOyxEFMAPYv4tlVGAD0R
         1rXfH6gFy+nrTrobHjdoFPueE7m+Mk3NPh30RkE3p3EsdshM1yY6SdZ03pm7ereEsTy1
         CAFGrvrqN8DxcR0uar1g+i6fAxHnWKEVWFQmKDBO84bh21QyoPs4bGNmKThkK9mRq6fd
         0dyTNEsF3CVh+O9nFRF0hXDlFs6+CWRWKc12VtnD0iNN6kS+bzUfNl0dB8bDxATRVcPV
         AalnWW8+DRrHdTiGjy1gMgpZURLWwGH1FCcXs8ZvXVCz4W1DbVgYPAAXUoIuRLtsWTKs
         huMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784325813; x=1784930613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ama0SVn97k9iAkAOQhRx4hyF+HPcsesIUw/q/aLtCKc=;
        b=ZZTPIONGq3p+QTvbGvpvPZLLibVmRIYFU58NVjYCQo8UElcuwk9MpNp6S/0u6T0RKT
         VO93mFQYCmV1aCVJD54dyu1tdssYPt+arzWNAQllyvdVnTi8vFDMp7jS35la3ZlQEsZQ
         zQQ9ooWTRCBAownuHRosOlgTx2eSr/VWoVu3ywqfOAfqI1FuZC8YiTgq0Us3WCYuIKV/
         P8wrqW4L9+UEM2syzGgogb9Mq8vGs9VE4mYgrl5roARbnn8nLypzLa49fkz9pxotX8oB
         fvFxVRStCR/9dvSiDlWJaA/0fphpIVaiNk0DFBbZlePrVXUvhcBFjyUZu/IctavHagkR
         DbzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3CPQKLu/Gi1ISfOdFHSV+7iC5VHGaXoTQCDpzsPmk/O37TyW2AUg81xfjOYpIALcyYg1WW0aZG+7imz2hcPCDfzvNVok=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfcdfu7vWYA3ZE5lV/WpuSl4LBXZydyvy69Plx9bHAotS8U3oF
	aGrn3uiY4/tB/UDFSyh+QQnoxEEVG9vf1i1rULPpBVV19ADVFQZIRJC+
X-Gm-Gg: AfdE7cnlNjZ87Vacum6M+i8/opnWU+3Pc5HL8OU40dO89zngVnXna7Xg1by5L6wBSE3
	oU9LiiYP+jZsNWkwmj4TiQC59gTB/LMDFuvVHW0kRoxpdub0fBBW3/CoCoEPLQFrlcQsBk+8SM8
	OKg0jZGuacVM6cKzzpxwRrUNQdv5iwKHQT5oQKm8FWpeCfd4oUlKZSthVIoNz7jtFEZjhUgYuil
	gThm+X7k4fTyG+weGfjUE+RjqXmCPvOJMjcqQLdRnlrN9m25ZZTvTDP/WDvPfDESh1/lD7JM6Y4
	LXhZM0dSA1mXxkCpysEUOnlC46lnUmxMQnherfH5clTytt6hgL2v9dWjY4A1//5JZksQ2ZWDzlV
	JZI5C29EdjzBuizq/AvK2xM3kHimTXfZCSdGwALSC3kOkHJHmCOqbcgKwntE0PTYxT1H1a20C7q
	A0GHuLE6TAqAaXMn7Ycj7A0GKSjyVUXUKOkWQ=
X-Received: by 2002:a05:690c:e:b0:81e:3e2c:6fea with SMTP id 00721157ae682-81ef2697592mr15117697b3.70.1784325812642;
        Fri, 17 Jul 2026 15:03:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:ee56:9b10:53f4:188])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef401728asm20572037b3.9.2026.07.17.15.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 15:03:32 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: gnoack3000@gmail.com,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 2/3] selftests/landlock: Test LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Fri, 17 Jul 2026 18:03:18 -0400
Message-ID: <20260717220320.1030123-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717220320.1030123-1-utilityemal77@gmail.com>
References: <20260717220320.1030123-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that a successful landlock_restrict_self(2) call with
LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS sets no_new_privs without a prior
prctl(2) call nor CAP_SYS_ADMIN, that a failed call leaves the attribute
unchanged, and that LANDLOCK_RESTRICT_SELF_TSYNC extends it to sibling
threads.  Also check that this flag requires a ruleset, and update the
restrict_self_checks_ordering EPERM checks since this flag is now
checked before the flags validity.

Update the ABI version and last-flag checks accordingly.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c  | 65 +++++++++++++++++--
 tools/testing/selftests/landlock/tsync_test.c | 33 ++++++++++
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index cbd3c1669951..2d4903588903 100644
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
@@ -288,7 +295,7 @@ TEST(restrict_self_fd)
 	EXPECT_EQ(EBADFD, errno);
 }
 
-TEST(restrict_self_fd_logging_flags)
+TEST(restrict_self_fd_flags)
 {
 	int fd;
 
@@ -302,11 +309,16 @@ TEST(restrict_self_fd_logging_flags)
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
 
@@ -349,6 +361,18 @@ TEST(restrict_self_logging_flags)
 				      LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON));
 	EXPECT_EQ(EBADF, errno);
 
+	/* LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS requires a ruleset FD. */
+
+	EXPECT_EQ(-1, landlock_restrict_self(
+			      -1, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADF, errno);
+
+	EXPECT_EQ(-1,
+		  landlock_restrict_self(
+			  -1, LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF |
+				      LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS));
+	EXPECT_EQ(EBADF, errno);
+
 	/* Tests with an invalid ruleset_fd. */
 
 	EXPECT_EQ(-1, landlock_restrict_self(
@@ -359,6 +383,37 @@ TEST(restrict_self_logging_flags)
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
index 9cf1491bbaaf..d5336186b2c7 100644
--- a/tools/testing/selftests/landlock/tsync_test.c
+++ b/tools/testing/selftests/landlock/tsync_test.c
@@ -90,6 +90,39 @@ TEST(multi_threaded_success)
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
 TEST(multi_threaded_success_despite_diverging_domains)
 {
 	pthread_t t1, t2;
-- 
2.54.0

