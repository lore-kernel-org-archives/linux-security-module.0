Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6276837B3F6
	for <linux-security-module@vger.kernel.org>; Tue,  7 Apr 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592142; cv=none; b=GJlZKhfWh1UNn/VYebDgLaWnxH5o84A9I7MDtroDWQ7pHiDZfVKlSTR2+8MZ7Io1KCSEQetHHZ3rK2IfmSTT93sW1fnsudYL97K9UA+RNYUBUGIf5zKjVwJjs6qxHJhMr7zx/vPc4yWqEnP6+pueeu8034/Zj7/0LCWieLcdsP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592142; c=relaxed/simple;
	bh=TxTM6F1N7H2DtjjKI06cP0wJ5qOuJLMMiPRjlSy7Oa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnOkIlcE9I5Stux7eO6CFv5JqCvPOvet9z/5Lz45cYlMO5eyIqnQSRWjeiX0rke5XYVJOOIzxUzlwzCocCWC5Z1clh35t+EgVhiu4AwOXdZZhXqpPoxZxxTSWVgwBB/kJ0yfpHQLGJinzkmXKy2B1tB02EqGmY0GbgcaisUgE34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XapqU92G; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XapqU92G"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79db5e18ac6so3213907b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2026 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592137; x=1776196937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/loJFnjXSN783AYVg43XDm3Fgil2FddDxgAAf1bvBGc=;
        b=XapqU92G/1CwMVjfyXp8v9ihxutFMZ+VhtabRLfMwAdJYTClsSWCxpBkDVyYtkuoxl
         UNQe6WBIQMLxRRutXqI+Pq3cjYEvGpkRjoiIMDexKrap+8Ne8Fln4jZXDW9qeY3gMgqD
         8y+HTlevqyC14bRRMH6NDiHY+wc1XLeFW0vkapjuB76wjBnHGTsGHxrGHAb96RJaTk7m
         uDe8zxG2+3MUxthtnL5T2Vr2O6d+MCOG4WXuFekj+eKMFrAMf2NwsBkqZbLg2UvgIF3s
         FzJKMtXXBuYPaLmiBN/eT9DWnph6NhOWI4AQHxF1Div6GWF/vWxjX5XfUek0Pm1xod4K
         7U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592137; x=1776196937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/loJFnjXSN783AYVg43XDm3Fgil2FddDxgAAf1bvBGc=;
        b=q13w+cvVwxdNcmqMrKAGEda8q8pEiBDbliLwkkIOaENsyC0ZCh9NB1zSQBQTukZy4A
         17M+wXg01W7seJ6aYQdW/mcbF6qKfeAAbG2+Lw95XG+s62EqZA5tCdUFqSe2UGcVryFe
         FJarNZQzkub9ytNHYJh8sZteFP7BCnrxZJLVldolDKGCf0Rr5iN9CSQIZX/UxNbyMIgT
         NLt28UyH9fd2eEgCJ4SkpMNiTH/Jy+NSMfEIzKJ+Otab9Ts7WoRn0jKFwgFXnfcP6xCy
         aO/3jsD3iYOXklRp13c1bKz4soaH1rEods9I9SHfYyrETm8SEocnOl/CT36OiIt+OTwd
         bqAw==
X-Forwarded-Encrypted: i=1; AJvYcCWujsiXw+VxOnrwAIfRl0DcVSkVsZM0YG3ozRUOvZDyDzDXKOlZLCHfJFXECQ9/TrUDjN7ZS0HHupyOJA2P4mYMG69Br74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAh5TVvkc+yYXZd1XcOVn9zmAZ1BaxWXBqvFEtrhGV2Ff3+MS
	yJtlo/FiNJTRkso9xoo/v94fCpXfBnG0CKVPxG2YA529O7CZ9EJwSnbw
X-Gm-Gg: AeBDievoLaKXfSGDCkfYTzNAeyNNczyFLyxuv2KBIQ04hx3N4Ci/9uiyS2IadRJgFQI
	JrJU9rxPxYGh8Kr+c/qBX1OQuBUeZXX4Fv+enR0iBGSAKIfruA3sCUvMfk9W59+wR45peHwiU4O
	KtM9EZo4GJIF0IhbgHW8r2ZaXSyDUafGSS9dU+BpgdS5PsInvCTsdd+DkiJ48Z6WkvN8fIhMcAq
	+FsnSY4FkeT9XsJsTCq32vzOkHIUFsIMqXY1IWtApIiIviy0Y612u2a9bpVy6KtcVR/DjuJ2qkd
	4RfoIZJTijlPWviWbPVW/5HjcjDO3OHKPw6OqcGyux+3ic4EISP5KdrJ4NKmUHOcl692+r8cSRu
	wsA23CAlr036RhvL7ToYK68ssfoxB/gVnHqEZ4N/1O0/RCrdD3CXWP6RUgFOMbMsFCeGB0lo2Cd
	14fzppuVeQ4lBE5PddDZ5ZQNw2k4K8pFHa7dvZ3cFwJixkZB4L2vE7CfZ+ewFhvrsfgvKPWvDDu
	+nXGKDxH8E=
X-Received: by 2002:a05:690e:400b:b0:650:176f:1ae3 with SMTP id 956f58d0204a3-650480e71d0mr13922125d50.25.1775592136975;
        Tue, 07 Apr 2026 13:02:16 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:16 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 04/20] selftests/landlock: Cover LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Tue,  7 Apr 2026 16:01:26 -0400
Message-ID: <20260407200157.3874806-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to cover LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS.

Add a new field to the scoped domain variant specifying whether
the test is to be run by manually calling
prctl(PR_SET_NO_NEW_PRIVS,...) or to call it with this flag. Add
variants for the scoped domain tests validating the flag works
identically to the manual prctl call for userspace code.

Fix a small issue in restrict_self_checks_ordering which assumed
-1 was always an invalid flag by properly computing an invalid
flag from the last known flag.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/base_test.c  |   8 +-
 tools/testing/selftests/landlock/common.h     |  24 +++-
 tools/testing/selftests/landlock/fs_test.c    | 103 ++++++++++--------
 tools/testing/selftests/landlock/net_test.c   |  55 ++++++----
 .../testing/selftests/landlock/ptrace_test.c  |  14 +--
 .../landlock/scoped_abstract_unix_test.c      |  51 ++++++---
 .../selftests/landlock/scoped_base_variants.h |  23 ++++
 .../selftests/landlock/scoped_common.h        |   5 +-
 .../selftests/landlock/scoped_signal_test.c   |  30 +++--
 9 files changed, 206 insertions(+), 107 deletions(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 30d37234086c..a4c38541de70 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -244,6 +244,8 @@ TEST(restrict_self_checks_ordering)
 	};
 	const int ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	const int last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
+	const int invalid_flag = last_flag << 1;
 
 	ASSERT_LE(0, ruleset_fd);
 	path_beneath_attr.parent_fd =
@@ -255,7 +257,7 @@ TEST(restrict_self_checks_ordering)
 
 	/* Checks unprivileged enforcement without no_new_privs. */
 	drop_caps(_metadata);
-	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, invalid_flag));
 	ASSERT_EQ(EPERM, errno);
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	ASSERT_EQ(EPERM, errno);
@@ -265,7 +267,7 @@ TEST(restrict_self_checks_ordering)
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
 	/* Checks invalid flags. */
-	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(-1, landlock_restrict_self(-1, invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
 
 	/* Checks invalid ruleset FD. */
@@ -306,7 +308,7 @@ TEST(restrict_self_fd_logging_flags)
 
 TEST(restrict_self_logging_flags)
 {
-	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_TSYNC;
+	const __u32 last_flag = LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
 
 	/* Tests invalid flag combinations. */
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 90551650299c..f6d6a6a99c52 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -194,11 +194,27 @@ static int __maybe_unused send_fd(int usock, int fd_tx)
 	return 0;
 }
 
+/*
+ * Scoped domain options
+ */
+struct scoped_domain_opts {
+	bool use_restrict_self_no_new_privs;
+};
+
+static const struct scoped_domain_opts default_scoped_domain_opts = { 0 };
+
 static void __maybe_unused
-enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
+enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd,
+		const struct scoped_domain_opts opts)
 {
-	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
+	/* Skip the explicit prctl() when the syscall flag sets no_new_privs. */
+	if (!opts.use_restrict_self_no_new_privs)
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0,
+		  landlock_restrict_self(ruleset_fd,
+					 opts.use_restrict_self_no_new_privs ?
+					 LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS :
+					 0))
 	{
 		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
 	}
@@ -216,7 +232,7 @@ drop_access_rights(struct __test_metadata *const _metadata,
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cdb47fc1fc0a..b82b44405dbe 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -790,7 +790,18 @@ static void enforce_fs(struct __test_metadata *const _metadata,
 {
 	const int ruleset_fd = create_ruleset(_metadata, access_fs, rules);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+static void enforce_resolve_unix(struct __test_metadata *const _metadata,
+				 const struct rule rules[],
+				 const struct scoped_domain_opts opts)
+{
+	const int ruleset_fd =
+		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+
+	enforce_ruleset(_metadata, ruleset_fd, opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -805,14 +816,15 @@ TEST_F_FORK(layout0, proc_nsfs)
 		{},
 	};
 	struct landlock_path_beneath_attr path_beneath;
-	const int ruleset_fd = create_ruleset(
-		_metadata, rules[0].access | LANDLOCK_ACCESS_FS_READ_DIR,
-		rules);
+	const int ruleset_fd =
+		create_ruleset(_metadata,
+			       rules[0].access | LANDLOCK_ACCESS_FS_READ_DIR,
+			       rules);
 
 	ASSERT_LE(0, ruleset_fd);
 	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
 	ASSERT_EQ(EACCES, test_open("/dev", O_RDONLY));
@@ -862,7 +874,7 @@ TEST_F_FORK(layout0, unpriv)
 	ASSERT_EQ(EPERM, errno);
 
 	/* enforce_ruleset() calls prctl(no_new_privs). */
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
@@ -1289,7 +1301,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
@@ -1322,7 +1334,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * LANDLOCK_ACCESS_FS_WRITE_FILE must not be allowed because it would
 	 * be a privilege escalation.
 	 */
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	/* Same tests and results as above. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
@@ -1343,7 +1355,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 * directory: dir_s1d1.
 	 */
 	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	/* Same tests and results as above. */
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
@@ -1366,7 +1378,7 @@ TEST_F_FORK(layout1, inherit_subset)
 	 */
 	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
 			 dir_s1d3);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	/*
@@ -1404,7 +1416,7 @@ TEST_F_FORK(layout1, inherit_superset)
 	};
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	/* Readdir access is denied for dir_s1d2. */
 	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
@@ -1418,7 +1430,7 @@ TEST_F_FORK(layout1, inherit_superset)
 			 LANDLOCK_ACCESS_FS_READ_FILE |
 				 LANDLOCK_ACCESS_FS_READ_DIR,
 			 dir_s1d2);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Readdir access is still denied for dir_s1d2. */
@@ -1442,7 +1454,8 @@ TEST_F_FORK(layout0, max_layers)
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
 	for (i = 0; i < 16; i++)
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 
 	for (i = 0; i < 2; i++) {
 		err = landlock_restrict_self(ruleset_fd, 0);
@@ -1472,12 +1485,12 @@ TEST_F_FORK(layout1, empty_or_same_ruleset)
 	/* Nests a policy which denies read access to all directories. */
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, NULL);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
 
 	/* Enforces a second time with the same ruleset. */
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
@@ -1725,7 +1738,7 @@ TEST_F_FORK(layout1, release_inodes)
 	ASSERT_EQ(0, umount(dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
@@ -1766,7 +1779,7 @@ TEST_F_FORK(layout1, covered_rule)
 
 	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
@@ -1828,7 +1841,7 @@ static void test_relative_path(struct __test_metadata *const _metadata,
 	}
 
 	set_cap(_metadata, CAP_SYS_CHROOT);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	switch (rel) {
 	case REL_OPEN:
@@ -4402,9 +4415,9 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 	char buf[1];
 
 	if (variant->domain_both)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
+		enforce_resolve_unix(_metadata, NULL, variant->domain_opts);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+		enforce_resolve_unix(_metadata, rules, variant->domain_opts);
 
 	unlink(path);
 	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
@@ -4414,11 +4427,11 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 
 	if (child_pid == 0) {
 		if (variant->domain_child)
-			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-				   NULL);
+			enforce_resolve_unix(_metadata, NULL,
+					     variant->domain_opts);
 		else if (flags & ENFORCE_ALL)
-			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-				   rules);
+			enforce_resolve_unix(_metadata, rules,
+					     variant->domain_opts);
 
 		/* Wait for server to be available. */
 		EXPECT_EQ(0, close(readiness_pipe[1]));
@@ -4444,9 +4457,9 @@ static void test_connect_to_parent(struct __test_metadata *const _metadata,
 	}
 
 	if (variant->domain_parent)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
+		enforce_resolve_unix(_metadata, NULL, variant->domain_opts);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+		enforce_resolve_unix(_metadata, rules, variant->domain_opts);
 
 	srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
 
@@ -4485,9 +4498,9 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 	char buf[1];
 
 	if (variant->domain_both)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
+		enforce_resolve_unix(_metadata, NULL, variant->domain_opts);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+		enforce_resolve_unix(_metadata, rules, variant->domain_opts);
 
 	unlink(path);
 	ASSERT_EQ(0, pipe2(readiness_pipe, O_CLOEXEC));
@@ -4498,11 +4511,11 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 
 	if (child_pid == 0) {
 		if (variant->domain_child)
-			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-				   NULL);
+			enforce_resolve_unix(_metadata, NULL,
+					     variant->domain_opts);
 		else if (flags & ENFORCE_ALL)
-			enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
-				   rules);
+			enforce_resolve_unix(_metadata, rules,
+					     variant->domain_opts);
 
 		srv_fd = set_up_named_unix_server(_metadata, sock_type, path);
 
@@ -4526,9 +4539,9 @@ static void test_connect_to_child(struct __test_metadata *const _metadata,
 	}
 
 	if (variant->domain_parent)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
+		enforce_resolve_unix(_metadata, NULL, variant->domain_opts);
 	else if (flags & ENFORCE_ALL)
-		enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, rules);
+		enforce_resolve_unix(_metadata, rules, variant->domain_opts);
 
 	/* Wait for server to be available. */
 	EXPECT_EQ(0, close(readiness_pipe[1]));
@@ -5072,7 +5085,7 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 		create_ruleset(_metadata, ACCESS_RW, layer3_only_s1d2);
 	int bind_s1d3_fd;
 
-	enforce_ruleset(_metadata, ruleset_fd_l1);
+	enforce_ruleset(_metadata, ruleset_fd_l1, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd_l1));
 
 	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
@@ -5102,7 +5115,7 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 		  test_open_rel(bind_s1d3_fd, "..", O_RDONLY | O_DIRECTORY));
 
 	/* This should still work with a narrower rule. */
-	enforce_ruleset(_metadata, ruleset_fd_l2);
+	enforce_ruleset(_metadata, ruleset_fd_l2, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd_l2));
 
 	EXPECT_EQ(0, test_open(file1_s4d1, O_RDONLY));
@@ -5114,7 +5127,7 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 	EXPECT_EQ(EACCES, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));
 
-	enforce_ruleset(_metadata, ruleset_fd_l3);
+	enforce_ruleset(_metadata, ruleset_fd_l3, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd_l3));
 
 	EXPECT_EQ(EACCES, test_open(file1_s4d1, O_RDONLY));
@@ -5176,7 +5189,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	ruleset_fd_l2 = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
 				       layer2_only_s1d2);
 
-	enforce_ruleset(_metadata, ruleset_fd_l1);
+	enforce_ruleset(_metadata, ruleset_fd_l1, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd_l1));
 
 	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
@@ -5201,7 +5214,8 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		enforce_ruleset(_metadata, ruleset_fd_l2);
+		enforce_ruleset(_metadata, ruleset_fd_l2,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd_l2));
 		EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 		EXPECT_EQ(EACCES, test_open(file1_s4d2, O_RDONLY));
@@ -5238,7 +5252,8 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	child_pid = fork();
 	ASSERT_LE(0, child_pid);
 	if (child_pid == 0) {
-		enforce_ruleset(_metadata, ruleset_fd_l2);
+		enforce_ruleset(_metadata, ruleset_fd_l2,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd_l2));
 		EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 		EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
@@ -5290,7 +5305,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	}
 
 	/* Checks again that we can access it under l2. */
-	enforce_ruleset(_metadata, ruleset_fd_l2);
+	enforce_ruleset(_metadata, ruleset_fd_l2, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd_l2));
 	EXPECT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
 	EXPECT_EQ(0, test_open(file1_s1d3, O_RDONLY));
@@ -5914,7 +5929,7 @@ TEST_F_FORK(layout4_disconnected_leafs, read_rename_exchange)
 	EXPECT_EQ(ENOENT, test_open_rel(s1d41_bind_fd, "..", O_DIRECTORY));
 	EXPECT_EQ(ENOENT, test_open_rel(s1d42_bind_fd, "..", O_DIRECTORY));
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	EXPECT_EQ(variant->expected_read_result,
@@ -6430,7 +6445,7 @@ TEST_F_FORK(layout5_disconnected_branch, read_rename_exchange)
 	EXPECT_EQ(0, test_open_rel(s1d3_bind_fd, "..", O_DIRECTORY));
 	EXPECT_EQ(ENOENT, test_open_rel(s1d3_bind_fd, "../..", O_DIRECTORY));
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	EXPECT_EQ(variant->expected_read_result,
@@ -7201,7 +7216,7 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, TMP_DIR));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	/* Checks that access to the new mount point is denied. */
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 4c528154ea92..33a39a264f6b 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -671,7 +671,8 @@ TEST_F(protocol, bind)
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_connect_p1, 0));
 
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -721,7 +722,8 @@ TEST_F(protocol, connect)
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_p1, 0));
 
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -755,7 +757,8 @@ TEST_F(protocol, bind_unspec)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -788,7 +791,8 @@ TEST_F(protocol, bind_unspec)
 		ASSERT_LE(0, ruleset_fd);
 
 		/* Denies bind. */
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -874,7 +878,8 @@ TEST_F(protocol, connect_unspec)
 			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
 						       LANDLOCK_RULE_NET_PORT,
 						       &tcp_connect, 0));
-			enforce_ruleset(_metadata, ruleset_fd);
+			enforce_ruleset(_metadata, ruleset_fd,
+					default_scoped_domain_opts);
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
 
@@ -902,7 +907,8 @@ TEST_F(protocol, connect_unspec)
 			ASSERT_LE(0, ruleset_fd);
 
 			/* Denies connect. */
-			enforce_ruleset(_metadata, ruleset_fd);
+			enforce_ruleset(_metadata, ruleset_fd,
+					default_scoped_domain_opts);
 			EXPECT_EQ(0, close(ruleset_fd));
 		}
 
@@ -1034,7 +1040,8 @@ TEST_F(ipv4, from_unix_to_inet)
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_connect_p0, 0));
 
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1181,7 +1188,8 @@ TEST_F(tcp_layers, ruleset_overlap)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_connect, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1197,7 +1205,8 @@ TEST_F(tcp_layers, ruleset_overlap)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1213,7 +1222,8 @@ TEST_F(tcp_layers, ruleset_overlap)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_connect, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1244,7 +1254,8 @@ TEST_F(tcp_layers, ruleset_expand)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &bind_srv0, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1276,7 +1287,8 @@ TEST_F(tcp_layers, ruleset_expand)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_p1, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1298,7 +1310,8 @@ TEST_F(tcp_layers, ruleset_expand)
 		ASSERT_EQ(0,
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_p0, 0));
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1546,7 +1559,7 @@ TEST_F(mini, tcp_port_overflow)
 					&port_overflow4, 0));
 	EXPECT_EQ(EINVAL, errno);
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	test_bind_and_connect(_metadata, &srv_denied, true, true);
 	test_bind_and_connect(_metadata, &srv_max_allowed, false, false);
@@ -1611,7 +1624,7 @@ TEST_F(ipv4_tcp, port_endianness)
 				       &connect_big_endian_p0, 0));
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &bind_connect_host_endian_p1, 0));
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 
 	/* No restriction for big endinan CPU. */
 	test_bind_and_connect(_metadata, &self->srv0, false, little_endian);
@@ -1652,7 +1665,7 @@ TEST_F(ipv4_tcp, with_fs)
 	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 				       &tcp_bind, 0));
 
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	/* Tests file access. */
@@ -1766,7 +1779,8 @@ TEST_F(port_specific, bind_connect_zero)
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_connect_zero, 0));
 
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1843,7 +1857,8 @@ TEST_F(port_specific, bind_connect_1023)
 			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
 					    &tcp_bind_connect, 0));
 
-		enforce_ruleset(_metadata, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd,
+				default_scoped_domain_opts);
 		EXPECT_EQ(0, close(ruleset_fd));
 	}
 
@@ -1982,7 +1997,7 @@ TEST_F(audit, bind)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	sock_fd = socket_variant(&self->srv0);
@@ -2010,7 +2025,7 @@ TEST_F(audit, connect)
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	ASSERT_LE(0, ruleset_fd);
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, default_scoped_domain_opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 
 	sock_fd = socket_variant(&self->srv0);
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 1b6c8b53bf33..1c29cde8707a 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -25,7 +25,8 @@
 #define YAMA_SCOPE_DISABLED 0
 #define YAMA_SCOPE_RELATIONAL 1
 
-static void create_domain(struct __test_metadata *const _metadata)
+static void create_domain(struct __test_metadata *const _metadata,
+			  const struct scoped_domain_opts opts)
 {
 	int ruleset_fd;
 	struct landlock_ruleset_attr ruleset_attr = {
@@ -38,8 +39,7 @@ static void create_domain(struct __test_metadata *const _metadata)
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
-	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	enforce_ruleset(_metadata, ruleset_fd, opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
 
@@ -169,7 +169,7 @@ TEST_F(scoped_domains, trace)
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
-		create_domain(_metadata);
+		create_domain(_metadata, variant->domain_opts);
 		if (!__test_passed(_metadata))
 			/* Aborts before forking. */
 			return;
@@ -183,7 +183,7 @@ TEST_F(scoped_domains, trace)
 		ASSERT_EQ(0, close(pipe_parent[1]));
 		ASSERT_EQ(0, close(pipe_child[0]));
 		if (variant->domain_child)
-			create_domain(_metadata);
+			create_domain(_metadata, variant->domain_opts);
 
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
@@ -238,7 +238,7 @@ TEST_F(scoped_domains, trace)
 	ASSERT_EQ(0, close(pipe_child[1]));
 	ASSERT_EQ(0, close(pipe_parent[0]));
 	if (variant->domain_parent)
-		create_domain(_metadata);
+		create_domain(_metadata, variant->domain_opts);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -396,7 +396,7 @@ TEST_F(audit, trace)
 
 	ASSERT_EQ(0, close(pipe_child[1]));
 	ASSERT_EQ(0, close(pipe_parent[0]));
-	create_domain(_metadata);
+	create_domain(_metadata, default_scoped_domain_opts);
 
 	/* Signals that the parent is in a domain. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index c47491d2d1c1..d89f54edf9d5 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -88,7 +88,8 @@ TEST_F(scoped_domains, connect_to_parent)
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     variant->domain_opts);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -103,7 +104,8 @@ TEST_F(scoped_domains, connect_to_parent)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 		if (variant->domain_child)
 			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				variant->domain_opts);
 
 		stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_client);
@@ -138,7 +140,8 @@ TEST_F(scoped_domains, connect_to_parent)
 	EXPECT_EQ(0, close(pipe_parent[0]));
 	if (variant->domain_parent)
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     variant->domain_opts);
 
 	stream_server = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_server);
@@ -186,7 +189,8 @@ TEST_F(scoped_domains, connect_to_child)
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     variant->domain_opts);
 		if (!__test_passed(_metadata))
 			return;
 	}
@@ -200,7 +204,8 @@ TEST_F(scoped_domains, connect_to_child)
 		EXPECT_EQ(0, close(pipe_child[0]));
 		if (variant->domain_child)
 			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				variant->domain_opts);
 
 		/* Waits for the parent to be in a domain, if any. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf, 1));
@@ -231,7 +236,8 @@ TEST_F(scoped_domains, connect_to_child)
 
 	if (variant->domain_parent)
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     variant->domain_opts);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -344,7 +350,8 @@ TEST_F(scoped_audit, connect_to_child)
 	EXPECT_EQ(0, close(pipe_child[1]));
 	EXPECT_EQ(0, close(pipe_parent[0]));
 
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+			     default_scoped_domain_opts);
 
 	/* Signals that the parent is in a domain, if any. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
@@ -429,7 +436,8 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		create_fs_domain(_metadata);
 	else if (variant->domain_all == SCOPE_SANDBOX)
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     default_scoped_domain_opts);
 
 	child = fork();
 	ASSERT_LE(0, child);
@@ -444,7 +452,8 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 			create_fs_domain(_metadata);
 		else if (variant->domain_children == SCOPE_SANDBOX)
 			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				default_scoped_domain_opts);
 
 		grand_child = fork();
 		ASSERT_LE(0, grand_child);
@@ -461,7 +470,8 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 			else if (variant->domain_grand_child == SCOPE_SANDBOX)
 				create_scoped_domain(
 					_metadata,
-					LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+					LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+					default_scoped_domain_opts);
 
 			stream_client = socket(AF_UNIX, SOCK_STREAM, 0);
 			ASSERT_LE(0, stream_client);
@@ -525,7 +535,8 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 			create_fs_domain(_metadata);
 		else if (variant->domain_child == SCOPE_SANDBOX)
 			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				default_scoped_domain_opts);
 
 		stream_server_child = socket(AF_UNIX, SOCK_STREAM, 0);
 		ASSERT_LE(0, stream_server_child);
@@ -552,7 +563,8 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		create_fs_domain(_metadata);
 	else if (variant->domain_parent == SCOPE_SANDBOX)
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     default_scoped_domain_opts);
 
 	stream_server_parent = socket(AF_UNIX, SOCK_STREAM, 0);
 	ASSERT_LE(0, stream_server_parent);
@@ -656,7 +668,8 @@ TEST_F(outside_socket, socket_with_different_domain)
 
 		/* Client always has a domain. */
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     default_scoped_domain_opts);
 
 		if (variant->child_socket) {
 			int data_socket, passed_socket, stream_server;
@@ -713,7 +726,8 @@ TEST_F(outside_socket, socket_with_different_domain)
 	ASSERT_LE(0, server_socket);
 
 	/* Server always has a domain. */
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+			     default_scoped_domain_opts);
 
 	ASSERT_EQ(0, bind(server_socket, &self->address.unix_addr,
 			  self->address.unix_addr_len));
@@ -820,7 +834,8 @@ TEST_F(various_address_sockets, scoped_pathname_sockets)
 
 		if (variant->domain == SCOPE_SANDBOX)
 			create_scoped_domain(
-				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				_metadata, LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				default_scoped_domain_opts);
 		else if (variant->domain == OTHER_SANDBOX)
 			create_fs_domain(_metadata);
 
@@ -1027,7 +1042,8 @@ TEST(datagram_sockets)
 
 		/* Scopes the domain. */
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     default_scoped_domain_opts);
 
 		/*
 		 * Connected socket sends data to the receiver, but the
@@ -1108,7 +1124,8 @@ TEST(self_connect)
 	if (child == 0) {
 		/* Child's domain is scoped. */
 		create_scoped_domain(_metadata,
-				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
+				     LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+				     default_scoped_domain_opts);
 
 		/*
 		 * The child inherits the sockets, and cannot connect or
diff --git a/tools/testing/selftests/landlock/scoped_base_variants.h b/tools/testing/selftests/landlock/scoped_base_variants.h
index 7116728ebc68..bbdf19ef18ef 100644
--- a/tools/testing/selftests/landlock/scoped_base_variants.h
+++ b/tools/testing/selftests/landlock/scoped_base_variants.h
@@ -20,6 +20,7 @@ FIXTURE_VARIANT(scoped_domains)
 	bool domain_both;
 	bool domain_parent;
 	bool domain_child;
+	struct scoped_domain_opts domain_opts;
 };
 
 /*
@@ -54,6 +55,17 @@ FIXTURE_VARIANT_ADD(scoped_domains, child_domain) {
 	.domain_child = true,
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoped_domains, child_domain_restrict_self_no_new_privs) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+	.domain_opts = {
+		.use_restrict_self_no_new_privs = true,
+	},
+};
+
 /*
  *        Parent domain
  * .------.
@@ -70,6 +82,17 @@ FIXTURE_VARIANT_ADD(scoped_domains, parent_domain) {
 	.domain_child = false,
 };
 
+/* clang-format off */
+FIXTURE_VARIANT_ADD(scoped_domains, parent_domain_restrict_self_no_new_privs) {
+	/* clang-format on */
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+	.domain_opts = {
+		.use_restrict_self_no_new_privs = true,
+	},
+};
+
 /*
  *        Parent + child domain (siblings)
  * .------.
diff --git a/tools/testing/selftests/landlock/scoped_common.h b/tools/testing/selftests/landlock/scoped_common.h
index a9a912d30c4d..23990758eef8 100644
--- a/tools/testing/selftests/landlock/scoped_common.h
+++ b/tools/testing/selftests/landlock/scoped_common.h
@@ -10,7 +10,8 @@
 #include <sys/types.h>
 
 static void create_scoped_domain(struct __test_metadata *const _metadata,
-				 const __u16 scope)
+				 const __u16 scope,
+				 const struct scoped_domain_opts opts)
 {
 	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
@@ -23,6 +24,6 @@ static void create_scoped_domain(struct __test_metadata *const _metadata,
 	{
 		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
 	}
-	enforce_ruleset(_metadata, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd, opts);
 	EXPECT_EQ(0, close(ruleset_fd));
 }
diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
index d8bf33417619..dfda4a3e5374 100644
--- a/tools/testing/selftests/landlock/scoped_signal_test.c
+++ b/tools/testing/selftests/landlock/scoped_signal_test.c
@@ -111,7 +111,8 @@ TEST_F(scoping_signals, send_sig_to_parent)
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
 		EXPECT_EQ(0, close(pipe_parent[0]));
 
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     default_scoped_domain_opts);
 
 		/*
 		 * The child process cannot send signal to the parent
@@ -183,7 +184,8 @@ TEST_F(scoped_domains, check_access_signal)
 	can_signal_child = !variant->domain_parent;
 
 	if (variant->domain_both)
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     variant->domain_opts);
 
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
@@ -197,7 +199,8 @@ TEST_F(scoped_domains, check_access_signal)
 		EXPECT_EQ(0, close(pipe_parent[1]));
 
 		if (variant->domain_child)
-			create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+			create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+					     variant->domain_opts);
 
 		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
 		EXPECT_EQ(0, close(pipe_child[1]));
@@ -226,7 +229,8 @@ TEST_F(scoped_domains, check_access_signal)
 	EXPECT_EQ(0, close(pipe_child[1]));
 
 	if (variant->domain_parent)
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     variant->domain_opts);
 
 	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
 	EXPECT_EQ(0, close(pipe_child[0]));
@@ -280,7 +284,8 @@ TEST(signal_scoping_thread_before)
 				    &thread_pipe[0]));
 
 	/* Enforces restriction after creating the thread. */
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+			     default_scoped_domain_opts);
 
 	EXPECT_EQ(0, pthread_kill(no_sandbox_thread, 0));
 	EXPECT_EQ(1, write(thread_pipe[1], ".", 1));
@@ -302,7 +307,8 @@ TEST(signal_scoping_thread_after)
 	ASSERT_EQ(0, pipe2(thread_pipe, O_CLOEXEC));
 
 	/* Enforces restriction before creating the thread. */
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+			     default_scoped_domain_opts);
 
 	ASSERT_EQ(0, pthread_create(&scoped_thread, NULL, thread_sync,
 				    &thread_pipe[0]));
@@ -360,7 +366,8 @@ TEST(signal_scoping_thread_setuid)
 				    &arg));
 
 	/* Enforces restriction after creating the thread. */
-	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+	create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+			     default_scoped_domain_opts);
 
 	EXPECT_NE(arg.new_uid, getuid());
 	EXPECT_EQ(0, setuid(arg.new_uid));
@@ -469,7 +476,8 @@ TEST_F(fown, sigurg_socket)
 	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
 
 	if (variant->sandbox_setown == SANDBOX_BEFORE_FORK)
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     default_scoped_domain_opts);
 
 	child = fork();
 	ASSERT_LE(0, child);
@@ -531,7 +539,8 @@ TEST_F(fown, sigurg_socket)
 	ASSERT_LE(0, recv_socket);
 
 	if (variant->sandbox_setown == SANDBOX_BEFORE_SETOWN)
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     default_scoped_domain_opts);
 
 	/*
 	 * Sets the child to receive SIGURG for MSG_OOB.  This uncommon use is
@@ -540,7 +549,8 @@ TEST_F(fown, sigurg_socket)
 	ASSERT_EQ(0, fcntl(recv_socket, F_SETOWN, child));
 
 	if (variant->sandbox_setown == SANDBOX_AFTER_SETOWN)
-		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
+		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL,
+				     default_scoped_domain_opts);
 
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 
-- 
2.53.0

