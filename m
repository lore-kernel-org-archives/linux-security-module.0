Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298BC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2274D20823
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfBSQeF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:34:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728688AbfBSQeF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:34:05 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7562AC0E4CE5;
        Tue, 19 Feb 2019 16:34:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3494C4;
        Tue, 19 Feb 2019 16:34:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 40/43] vfs: Implement logging through fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:34:00 +0000
Message-ID: <155059404031.12449.2777877374858164989.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 16:34:04 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Implement the ability for filesystems to log error, warning and
informational messages through the fs_context.  In the future, these will
be extractable by userspace by reading from an fd created by the fsopen()
syscall.

Error messages are prefixed with "e ", warnings with "w " and informational
messages with "i ".

In the future, inside the kernel, formatted messages will be malloc'd but
unformatted messages will not copied if they're either in the core .rodata
section or in the .rodata section of the filesystem module pinned by
fs_context::fs_type.  The messages will only be good till the fs_type is
released.

Note that the logging object will be shared between duplicated fs_context
structures.  This is so that such as NFS which do a mount within a mount
can get at least some of the errors from the inner mount.

Five logging functions are provided for this:

 (1) void logfc(struct fs_context *fc, const char *fmt, ...);

     This logs a message into the context.  If the buffer is full, the
     earliest message is discarded.

 (2) void errorf(fc, fmt, ...);

     This wraps logfc() to log an error.

 (3) void invalf(fc, fmt, ...);

     This wraps errorf() and returns -EINVAL for convenience.

 (4) void warnf(fc, fmt, ...);

     This wraps logfc() to log a warning.

 (5) void infof(fc, fmt, ...);

     This wraps logfc() to log an informational message.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/fs_context.c            |   30 ++++++++++++++++++++++++++++++
 include/linux/fs_context.h |   18 ++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 57f61833ac83..87e3546b9a52 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -378,6 +378,36 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 }
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
+#ifdef CONFIG_PRINTK
+/**
+ * logfc - Log a message to a filesystem context
+ * @fc: The filesystem context to log to.
+ * @fmt: The format of the buffer.
+ */
+void logfc(struct fs_context *fc, const char *fmt, ...)
+{
+	va_list va;
+
+	va_start(va, fmt);
+
+	switch (fmt[0]) {
+	case 'w':
+		vprintk_emit(0, LOGLEVEL_WARNING, NULL, 0, fmt, va);
+		break;
+	case 'e':
+		vprintk_emit(0, LOGLEVEL_ERR, NULL, 0, fmt, va);
+		break;
+	default:
+		vprintk_emit(0, LOGLEVEL_NOTICE, NULL, 0, fmt, va);
+		break;
+	}
+
+	pr_cont("\n");
+	va_end(va);
+}
+EXPORT_SYMBOL(logfc);
+#endif
+
 /**
  * put_fs_context - Dispose of a superblock configuration context.
  * @fc: The context to dispose of.
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 0db0b645c7b8..eaca452088fa 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -133,7 +133,17 @@ extern int vfs_get_super(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
 
-#define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
+extern const struct file_operations fscontext_fops;
+
+#ifdef CONFIG_PRINTK
+extern __attribute__((format(printf, 2, 3)))
+void logfc(struct fs_context *fc, const char *fmt, ...);
+#else
+static inline __attribute__((format(printf, 2, 3)))
+void logfc(struct fs_context *fc, const char *fmt, ...)
+{
+}
+#endif
 
 /**
  * infof - Store supplementary informational message
@@ -143,7 +153,7 @@ extern int vfs_get_super(struct fs_context *fc,
  * Store the supplementary informational message for the process if the process
  * has enabled the facility.
  */
-#define infof(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define infof(fc, fmt, ...) ({ logfc(fc, "i "fmt, ## __VA_ARGS__); })
 
 /**
  * warnf - Store supplementary warning message
@@ -153,7 +163,7 @@ extern int vfs_get_super(struct fs_context *fc,
  * Store the supplementary warning message for the process if the process has
  * enabled the facility.
  */
-#define warnf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define warnf(fc, fmt, ...) ({ logfc(fc, "w "fmt, ## __VA_ARGS__); })
 
 /**
  * errorf - Store supplementary error message
@@ -163,7 +173,7 @@ extern int vfs_get_super(struct fs_context *fc,
  * Store the supplementary error message for the process if the process has
  * enabled the facility.
  */
-#define errorf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+#define errorf(fc, fmt, ...) ({ logfc(fc, "e "fmt, ## __VA_ARGS__); })
 
 /**
  * invalf - Store supplementary invalid argument error message

