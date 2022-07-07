Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB4DC43334
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Jul 2022 20:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiGGUHS (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 Jul 2022 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiGGUHQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBCC5C9F2
        for <linux-security-module@vger.kernel.org>; Thu,  7 Jul 2022 13:07:15 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e15so3561708edj.2
        for <linux-security-module@vger.kernel.org>; Thu, 07 Jul 2022 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E3loG4Dj7TEcYgvdiN65TxSPjRRrBmuLRNlMu/9j9wo=;
        b=jZfjn9dFFgyq20eeLKTKdv8qHj4e3mrs5d2wRgR1RcKL2htB9nCo95+q+kFjsC+NrH
         6qQKCP6QuvmFwOo7/RQFMEqIEuVbvlmU5TzW0MTp0GXFPcwfNqVdoKNVByR1JDLH1+Oy
         BKm9/OzNytBZIzAEt5mbjwYGElF6Ae2FkdvF/RJu1AM2fml5h9NX6lKYARaeuwJpmxuv
         j0I5TGgINje/6EH3SmtU+ERMiTbq4Zam+KfKl7QJswlnwaB3RkfaWWD9J6WnlcBbb8Xk
         ttqVLW4pZQr26myo1HCksZ73bSJtB8ExDNU69xeVUE9izxbusFYtrgipQYPKmtK293me
         Z1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3loG4Dj7TEcYgvdiN65TxSPjRRrBmuLRNlMu/9j9wo=;
        b=nQVfhVRxjFVqDhmoVRPoxItgIuPh7g8DjE31Ypkmm8kz2RxhAToMnoCVNMYQzFgIjw
         3wIreR8p7mbSTY5HEvrQfuFobvY7+d7pNDC+mLn14Jh1XoFcKwev23+8XnV2V176sQQO
         PppPd1ECXRufPY0IF7QNPCuPZ2LEZH4stVho/eJgGIpEuPPSSNXsh57kuK3Cj41NXbM9
         6HWtxrsYjiBBCog0cIsPB437DZHtIU6ZfcrX22IjwykJ6Zb0pfwN9z4kXRCib1qVaz1g
         ZqPaGFCS0FKO5FQHz5+hnowejS8K9/20eVCKorBuQAb/hmjf/SxfIRypPTJsvKuNTDQq
         97qA==
X-Gm-Message-State: AJIora+RMsBLU+jJt8vXiKIaclHI/nrid84GvAAsH8Zp7Q+sQlJ8Ycbe
        FB1vdjPHTtb4a6EeEvtQ/iFfC5+J74w=
X-Google-Smtp-Source: AGRyM1vY60gMW9H6fdE9fH6Z7k0+oNLOHxOP2oQdV9Hqwj/ft1OVv8NtFUpBgrB//D42G6aaAMwNjg==
X-Received: by 2002:aa7:d5d7:0:b0:43a:6eda:464a with SMTP id d23-20020aa7d5d7000000b0043a6eda464amr27723506eds.193.1657224434427;
        Thu, 07 Jul 2022 13:07:14 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402020d00b0043a71775903sm8397959edv.39.2022.07.07.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:14 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH 1/2] landlock: Support truncate(2).
Date:   Thu,  7 Jul 2022 22:06:12 +0200
Message-Id: <20220707200612.132705-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220707200612.132705-1-gnoack3000@gmail.com>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add support for restricting the use of the truncate(2) and
ftruncate(2) family of syscalls with Landlock.

This change also updates the Landlock ABI version and updates the
existing Landlock tests to match the new ABI version.

Technically, unprivileged processes can already restrict the use of
truncate(2) with seccomp-bpf.

Using Landlock instead of seccomp-bpf has the folowwing advantages:

- it doesn't require the use of BPF (conceptually simpler)

- callers don't need to keep track of lists of syscall numbers for
  different architectures and kernel versions

- the restriction policy can be configured per file hierarchy.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h                | 2 ++
 security/landlock/fs.c                       | 9 ++++++++-
 security/landlock/limits.h                   | 2 +-
 security/landlock/syscalls.c                 | 2 +-
 tools/testing/selftests/landlock/base_test.c | 2 +-
 tools/testing/selftests/landlock/fs_test.c   | 7 ++++---
 6 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..2351050d4773 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -134,6 +134,7 @@ struct landlock_path_beneath_attr {
  *   directory) parent.  Otherwise, such actions are denied with errno set to
  *   EACCES.  The EACCES errno prevails over EXDEV to let user space
  *   efficiently deal with an unrecoverable error.
+ * - %LANDLOCK_ACCESS_FS_TRUNCATE%: Truncate a file.
  *
  * .. warning::
  *
@@ -160,6 +161,7 @@ struct landlock_path_beneath_attr {
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
2.37.0

