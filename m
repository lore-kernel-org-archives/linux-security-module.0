Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA605EB64D7
	for <linux-security-module@archiver.kernel.org>; Fri, 23 Jun 2023 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFWOoM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjFWOoE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Jun 2023 10:44:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC61BFC
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso1001932276.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Jun 2023 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687531422; x=1690123422;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYy5fQURVzrf21RPiZ2pjS+KRs6Wq6G+dHPCrMSb3zQ=;
        b=1wp86LoyBViT81BjBGzKWJSTtPC05qZ78NrbMJjidxKwm/18n1rrzj1Ttrcl+5MJy+
         +DphEFxdMGhmFxYjRMxP6TQIelbQUfgVmsTx0Xw8ywAAArzMLe7zqZgtObNdgAP4Upt3
         /RIG8C5sr+9p4NBIeBSmW22pF7LZQlxP1nzQv9qwvbJvN1ZDSCUsquSVxwaw7ab0Xeuz
         8XjpY7XsOjDbk/O7BmKtz6qYwJ9ArlFy66qZVb2zEFruZ8QcO8Z240FmybIRIAVacyNY
         ir1vT9dBkueZ+Mtl1dzKrrr5wM5lfE17+vhHjSeOTqoVF/geFtc6Adi7kaSFIIhuPWqC
         cGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531422; x=1690123422;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYy5fQURVzrf21RPiZ2pjS+KRs6Wq6G+dHPCrMSb3zQ=;
        b=JYr/zxHNf3VTx48Q81STvME3V8qiJT65I0eB6+9FPwrNiOw+tXhqvqlMHMHD/LvkHW
         HLTbp1KgNi5lTVemBuD8pC61n1Bxm7wAfVAD60E4HCXOkpAlDAFTlmv4qyVj8xGVD79Y
         olWOZNyayfZqajpS7lWG9PjecJjs4KfIUvQjUunao1Hu+2NpOc8eUDgDybacclDc0cLa
         4/VMyncilv2Cq2lEMYjoyOhzgR0jX7jKxm7vsOcqR0wnxT2ZQd5VzwbzAyIoRKrY7zC/
         qpLQ7D32nThMoHiZdBPNG5ml/fhgxmgKtss4sS66nxrSisWjyT8EdhFRMkC2niAvyPtr
         70FQ==
X-Gm-Message-State: AC+VfDzjAj/bemU+NZwhcJ6M2QsBYhuRUODqEptjDw45IbkWo8e0lZyK
        b0CIQ4YfgyOo2lBy34Zd1WDkzIS8MgdNEC7s5f88ynl20ST+jEhl3IFY7vpP6vdSqotfKqFZQYQ
        A2pb4gPbQXc5bSbHX1zNvCjlwOwd3UEzDe1X+5P2dEZrJPmfTfki+qap4fF3z7AECIyLk9SNcja
        1athunDg==
X-Google-Smtp-Source: ACHHUZ4+ZnIYlSN87gv7zA7J83vQYckc04xHouEBLlzeWYdrUvG6i9fStoDYpJs+VeSzi66wCzKs3p0Gti4=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8b55:dee0:6991:c318])
 (user=gnoack job=sendgmr) by 2002:a25:b1a3:0:b0:bd6:7609:40a3 with SMTP id
 h35-20020a25b1a3000000b00bd6760940a3mr9632657ybj.12.1687531421782; Fri, 23
 Jun 2023 07:43:41 -0700 (PDT)
Date:   Fri, 23 Jun 2023 16:43:25 +0200
In-Reply-To: <20230623144329.136541-1-gnoack@google.com>
Message-Id: <20230623144329.136541-3-gnoack@google.com>
Mime-Version: 1.0
References: <20230623144329.136541-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 2/6] landlock: Add LANDLOCK_ACCESS_FS_IOCTL access right
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 include/uapi/linux/landlock.h              | 19 ++++++++++++-------
 security/landlock/fs.c                     | 21 +++++++++++++++++++--
 security/landlock/limits.h                 |  2 +-
 tools/testing/selftests/landlock/fs_test.c |  5 +++--
 4 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 81d09ef9aa50..57de1dc5869e 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -102,12 +102,16 @@ struct landlock_path_beneath_attr {
  * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
  * - %LANDLOCK_ACCESS_FS_TRUNCATE: Truncate a file with :manpage:`truncate=
(2)`,
  *   :manpage:`ftruncate(2)`, :manpage:`creat(2)`, or :manpage:`open(2)` w=
ith
- *   ``O_TRUNC``. Whether an opened file can be truncated with
- *   :manpage:`ftruncate(2)` is determined during :manpage:`open(2)`, in t=
he
- *   same way as read and write permissions are checked during
- *   :manpage:`open(2)` using %LANDLOCK_ACCESS_FS_READ_FILE and
- *   %LANDLOCK_ACCESS_FS_WRITE_FILE. This access right is available since =
the
- *   third version of the Landlock ABI.
+ *   ``O_TRUNC``.  This access right is available since the third version =
of the
+ *   Landlock ABI.
+ * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` on the opened f=
ile.
+ *   This access right is available since the fourth version of the Landlo=
ck
+ *   ABI.
+ *
+ * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or=
 used
+ * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same wa=
y as
+ * read and write permissions are checked during :manpage:`open(2)` using
+ * %LANDLOCK_ACCESS_FS_READ_FILE and %LANDLOCK_ACCESS_FS_WRITE_FILE.
  *
  * A directory can receive access rights related to files or directories. =
 The
  * following access right is applied to the directory itself, and the
@@ -168,7 +172,7 @@ struct landlock_path_beneath_attr {
  *   accessible through these syscall families: :manpage:`chdir(2)`,
  *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
  *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`fcntl(2)`, :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -187,6 +191,7 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_IOCTL			(1ULL << 15)
 /* clang-format on */
=20
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 1c0c198f6fdb..017863696610 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -147,7 +147,8 @@ static struct landlock_object *get_inode_object(struct =
inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
 /* clang-format on */
=20
 /*
@@ -1207,7 +1208,8 @@ static int hook_file_open(struct file *const file)
 {
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
 	access_mask_t open_access_request, full_access_request, allowed_access;
-	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
+	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE |
+					      LANDLOCK_ACCESS_FS_IOCTL;
 	const struct landlock_ruleset *const dom =3D
 		landlock_get_current_domain();
=20
@@ -1280,6 +1282,20 @@ static int hook_file_truncate(struct file *const fil=
e)
 	return -EACCES;
 }
=20
+static int hook_file_ioctl(struct file *file, unsigned int cmd,
+			   unsigned long arg)
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
 static struct security_hook_list landlock_hooks[] __ro_after_init =3D {
 	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
=20
@@ -1302,6 +1318,7 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
 	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
 	LSM_HOOK_INIT(file_open, hook_file_open),
 	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
+	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
 };
=20
 __init void landlock_add_fs_hooks(void)
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 82288f0e9e5e..40d8f17698b6 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
=20
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
=20
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 83d565569512..09dd1eaac8a9 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -523,9 +523,10 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL
=20
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
--=20
2.41.0.162.gfafddb0af9-goog

