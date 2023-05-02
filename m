Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B9C77B73
	for <linux-security-module@archiver.kernel.org>; Tue,  2 May 2023 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjEBRSN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 May 2023 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjEBRSM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 May 2023 13:18:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33872F5
        for <linux-security-module@vger.kernel.org>; Tue,  2 May 2023 10:18:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f833bda191so2512096f8f.1
        for <linux-security-module@vger.kernel.org>; Tue, 02 May 2023 10:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683047882; x=1685639882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS5NmcZD51mffglcosueyzTqn27LuICoPZ/rt9zOLWw=;
        b=GVw5Z7otZODOVuahEv0CIvjtNHl5hK6voyJVvgYD9T0CDGSv720ODqV+CLUHuXgUBr
         ovqDA28Z0HcNNNnSHbiz+08pK5Tv+C1BGvp7HpB2xiUTMXAkBpfbVLWfM/vTSHvyHBxa
         IPDrQ6RochIZVy1BPUgulgIHAQotv7SYsrQwnaiO1sx36EtzkivkVV/xih+hLguJAICR
         KPzE6PzyA1QVgQ7ehJaP9fugUa58d/Ewj/WrkuyV7wW8hY1PL/uXdGdqzzIwm8A0b/fx
         huelzankz2gvPaoAZN2CCsSvvfl5/Ejw5Jc53j4zfP98AypylK9gUjWALHLh7O/5BV1i
         UadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683047882; x=1685639882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS5NmcZD51mffglcosueyzTqn27LuICoPZ/rt9zOLWw=;
        b=V1qd6Si7RBXCG3H2JvyROfSdj0OgfYPiI3+0rmCRZKXMMOWaw8rwdwAulAfUecIAPr
         O/SSLnKvb3k1rE70zuUhV9w5JecLjmSbS4efFKdyjhUU7TfI7W/3YukWjwOLckFz7oUi
         /+fH5daQ3s/UGX/bSxBxmBvZkOM3LBcAGmytKsDtnS00nDOkwx80DGyl/ma0ljwo22Je
         cv8O+/RWbSmLlMx59T4ZVl78OW56dAXg7FHvHDkYTZwwYVirr7x3CSWezd3OquEirWwe
         xZBX4DZtOItHXiy72eYaW3JQdQ1XEaol1P4d0St3ULZT8+SoZxgQnh6cWQXBYxoNPhq5
         xVUQ==
X-Gm-Message-State: AC+VfDw57T6elaO0rt0MDxVrO5oyrMNaSlme6XrRofAZsTikcxJ/euYF
        8xm3tSTm2ZNXq/gjiQ049cM7CXlJuNc=
X-Google-Smtp-Source: ACHHUZ4Lz+qWkhKDX/INyq5WimtpnxeBaBVNxy+D6CMJjPBFHiE9OiQQOEZZZvX2VRWGz8PYE4TMgg==
X-Received: by 2002:adf:eb07:0:b0:303:2583:9635 with SMTP id s7-20020adfeb07000000b0030325839635mr11410218wrn.20.1683047882602;
        Tue, 02 May 2023 10:18:02 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6291000000b002c561805a4csm31427244wru.45.2023.05.02.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:18:02 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: [RFC 2/4] landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
Date:   Tue,  2 May 2023 19:17:53 +0200
Message-Id: <20230502171755.9788-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171755.9788-1-gnoack3000@gmail.com>
References: <20230502171755.9788-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Like the truncate right, this right is associated with a file
descriptor at the time of open(2), and gets respected even when the
file descriptor is used outside of the thread which it was originally
created in.

In particular, this happens for the commonly inherited file
descriptors stdin, stdout and stderr, if these are bound to a tty.
This means that programs using tty ioctls can drop the ioctl access
right, but continue using these ioctls on the already opened input and
output file descriptors.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 include/uapi/linux/landlock.h              | 19 ++++++++++++-------
 security/landlock/fs.c                     | 20 ++++++++++++++++++--
 security/landlock/limits.h                 |  2 +-
 tools/testing/selftests/landlock/fs_test.c |  5 +++--
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index f3223f96469..d87457a1c22 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -102,12 +102,16 @@ struct landlock_path_beneath_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` with
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in the
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version of the
+ *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` on the opened file.
+ *   This access right is available since the fourth version of the Landlock
+ *   ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories.  The
  * following access right is applied to the directory itself, and the
@@ -152,7 +156,7 @@ struct landlock_path_beneath_attr {
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -171,6 +175,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index adcea0fe7e6..b13c765733c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -147,7 +147,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 /* clang-format on */
 
 /*
@@ -1207,7 +1208,8 @@ static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE;
+	const access_mask_t optional_access = LANDLOCK_ACCESS_FS_TRUNCATE |
+					      LANDLOCK_ACCESS_FS_IOCTL;
 	const struct landlock_ruleset *const dom =
 		landlock_get_current_domain();
 
@@ -1280,6 +1282,19 @@ static int hook_file_truncate(struct file *const file)
 	return -EACCES;
 }
 
+static int hook_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	/*
+	 * It is the access rights at the time of opening the file which
+	 * determine whether ioctl can be used on the opened file later.
+	 *
+	 * The access right is attached to the opened file in hook_file_open().
+	 */
+	if (landlock_file(file)->allowed_access & LANDLOCK_ACCESS_FS_IOCTL)
+		return 0;
+	return -EACCES;
+}
+
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
 
@@ -1302,6 +1317,7 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 };
 
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 82288f0e9e5..40d8f17698b 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b6c4be3faf7..fdd7d439ce4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -446,9 +446,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.40.1

