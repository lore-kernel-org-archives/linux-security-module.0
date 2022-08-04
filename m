Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E903C25B06
	for <linux-security-module@archiver.kernel.org>; Thu,  4 Aug 2022 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiHDTiI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiHDTiE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 Aug 2022 15:38:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600EF6E2CF
        for <linux-security-module@vger.kernel.org>; Thu,  4 Aug 2022 12:38:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y13so1043567ejp.13
        for <linux-security-module@vger.kernel.org>; Thu, 04 Aug 2022 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=toXsI9XxqWdrSv518wl3p+yElTAYeu1SRBnVCWLQ8Kw=;
        b=NOhQ9+K3sagPW/EPopVhLnW0guOYEyrrzONrpEMMMh5xzgJ36lb5UNI5TRRmnrlEDg
         U9+JmEqZNNdoXbUnBEbQGmNjJ1LzkzpG5W+NdbTd8Rjy4MkwtWugLjP0uJPNOm+hNGOY
         uRQmo1nthE1jkn9eNxPeWtpR+1pSrCKGRmH2nfEaUBCFRFhdYyw2RS1fSa6dLLeFtJ9/
         MQqkSVi/mlHX3H5RlKAfz/pm66xSXxbHzHoMJoMdPHrt790fsfKF/vcAyeAf/tvuy1tj
         b+uS/ohFqI0Du3JJVXp4TkiSe59kuPj6h6fKtDBaBlJmPmnlqeKPfG8mEPcn8TkgOpn6
         AsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=toXsI9XxqWdrSv518wl3p+yElTAYeu1SRBnVCWLQ8Kw=;
        b=z8JOjba8mCKN87LFw/XokhNkDEn2b3h/oXGpOBGPgoI5QWurpz/zYV1CXgpKmAbDuK
         QlCFa8YO8Ev8YLsW9pMbhoyKEsYRdklB97Bra6+H3KzKcdbuO9sizOhIq6uM698+gXt0
         xt8ZktYVS41OAJTzhWBKMB2sJT4KXRf3//qwntEyW4sPEhOI2fUWtNxsQ1MSZSkODQFg
         lfw/etzhy0Iiv9eJd+Y4PfU3tWbJ9Wkj06Mdz4Aqt9UaSEDymFQywiIl31OJoi22m1aQ
         RuOu8tmI0SrLdg6hujicXUu87pdpro7E31sOJtPIK+cD2zNIus+l7z/JbO12nF5gp9OC
         8omA==
X-Gm-Message-State: ACgBeo2NTtNIVbIqWzEAPXEUWMFIWgBXvEXwFnldiDENR6N0AbX7TfrR
        H5ShnTpo3AOJywQpSNytuVnualC/MLQ=
X-Google-Smtp-Source: AA6agR4Qlo5B6l06nab4P4yPw87GU3sYd6qaojuTvwtwCqgP6nJKCAZ3SUK6GROrfI1j2Rt6CVP5wQ==
X-Received: by 2002:a17:906:8a6c:b0:730:a322:6f69 with SMTP id hy12-20020a1709068a6c00b00730a3226f69mr2516095ejc.585.1659641881514;
        Thu, 04 Aug 2022 12:38:01 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0072abb95c9f4sm631851ejh.193.2022.08.04.12.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 12:38:01 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v3 1/4] landlock: Support file truncation
Date:   Thu,  4 Aug 2022 21:37:43 +0200
Message-Id: <20220804193746.9161-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804193746.9161-1-gnoack3000@gmail.com>
References: <20220804193746.9161-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Introduce the LANDLOCK_ACCESS_FS_TRUNCATE flag for file truncation.

This flag hooks into the path_truncate LSM hook and covers file
truncation using truncate(2), ftruncate(2), open(2) with O_TRUNC, as
well as creat().

This change also increments the Landlock ABI version, updates
corresponding selftests, and includes minor documentation changes to
document the flag.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst     |  6 ++++++
 include/uapi/linux/landlock.h                | 17 ++++++++++++-----
 security/landlock/fs.c                       |  9 ++++++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  7 ++++---
 7 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8ea59493964..d92e335380d4 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -380,6 +380,12 @@ by the Documentation/admin-guide/cgroup-v1/memory.rst.
 Previous limitations
 ====================
 
+File truncation (ABI < 3)
+-------------------------
+
+File truncation could not be denied before the third Landlock ABI, so it is
+always allowed when using a kernel that only supports the first or second ABI.
+
 File renaming and linking (ABI 1)
 ---------------------------------
 
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..1beb8289708d 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -95,8 +95,15 @@ struct landlock_path_beneath_attr {
  * A file can only receive these access rights:
  *
  * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
- * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access. Note that
+ *   you might additionally need the LANDLOCK_ACCESS_FS_TRUNCATE right in order
+ *   to overwrite files with :manpage:`open(2)` using O_TRUNC or
+ *   :manpage:`creat(2)`.
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file through file truncation APIs
+ *   like :manpage:`truncate(2)`, :manpage:`ftruncate(2)`, or
+ *   :manpage:`open(2)` with O_TRUNC or :manpage:`creat(2)`. This access right
+ *   is available since the third version of the Landlock ABI.
  *
  * A directory can receive access rights related to files or directories.  The
  * following access right is applied to the directory itself, and the
@@ -139,10 +146,9 @@ struct landlock_path_beneath_attr {
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
- *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
- *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
- *   :manpage:`utime(2)`, :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
- *   :manpage:`access(2)`.
+ *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
+ *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
+ *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -160,6 +166,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 11)
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
+#define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index ec5a6247cd3e..c57f581a9cd5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -146,7 +146,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 /* clang-format on */
 
 /*
@@ -1140,6 +1141,11 @@ static int hook_path_rmdir(const struct path *const dir,
 	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
 }
 
+static int hook_path_truncate(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
+}
+
 /* File hooks */
 
 static inline access_mask_t get_file_access(const struct file *const file)
@@ -1192,6 +1198,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
+	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
 
 	LSM_HOOK_INIT(file_open, hook_file_open),
 };
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index b54184ab9439..82288f0e9e5e 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_REFER
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 735a0865ea11..f4d6fc7ed17f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 2
+#define LANDLOCK_ABI_VERSION 3
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index da9290817866..72cdae277b02 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(2, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 21a2ce8fa739..cb77eaa01c91 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -399,9 +399,10 @@ TEST_F_FORK(layout1, inval)
 #define ACCESS_FILE ( \
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
-	LANDLOCK_ACCESS_FS_READ_FILE)
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_TRUNCATE)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_REFER
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
@@ -415,7 +416,7 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
-	ACCESS_LAST)
+	LANDLOCK_ACCESS_FS_REFER)
 
 /* clang-format on */
 
-- 
2.37.1

