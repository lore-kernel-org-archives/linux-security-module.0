Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C4C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0682C2083E
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfBSRJN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:09:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfBSRJN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:09:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 748B220B09;
        Tue, 19 Feb 2019 17:09:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E87F19C58;
        Tue, 19 Feb 2019 17:09:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/10] vfs: Implement logging through fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:09:10 +0000
Message-ID: <155059615036.17079.7832765121171328056.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 17:09:12 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Implement the ability for filesystems to log error, warning and
informational messages through the fs_context.  These can be extracted by
userspace by reading from an fd created by fsopen().

Error messages are prefixed with "e ", warnings with "w " and informational
messages with "i ".

Inside the kernel, formatted messages are malloc'd but unformatted messages
are not copied if they're either in the core .rodata section or in the
.rodata section of the filesystem module pinned by fs_context::fs_type.
The messages are only good till the fs_type is released.

Note that the logging object is shared between duplicated fs_context
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

 fs/fs_context.c            |  105 ++++++++++++++++++++++++++++++++++++++------
 fs/fsopen.c                |   67 ++++++++++++++++++++++++++++
 include/linux/fs_context.h |   22 ++++++---
 include/linux/module.h     |    6 +++
 4 files changed, 179 insertions(+), 21 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index eb806fae3117..dcf3786f90f9 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -11,6 +11,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/fs.h>
@@ -23,6 +24,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <net/net_namespace.h>
+#include <asm/sections.h>
 #include "mount.h"
 #include "internal.h"
 
@@ -365,6 +367,8 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 	get_net(fc->net_ns);
 	get_user_ns(fc->user_ns);
 	get_cred(fc->cred);
+	if (fc->log)
+		refcount_inc(&fc->log->usage);
 
 	/* Can't call put until we've called ->dup */
 	ret = fc->ops->dup(fc, src_fc);
@@ -382,7 +386,6 @@ struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
 }
 EXPORT_SYMBOL(vfs_dup_fs_context);
 
-#ifdef CONFIG_PRINTK
 /**
  * logfc - Log a message to a filesystem context
  * @fc: The filesystem context to log to.
@@ -390,27 +393,100 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
  */
 void logfc(struct fs_context *fc, const char *fmt, ...)
 {
+	static const char store_failure[] = "OOM: Can't store error string";
+	struct fc_log *log = fc ? fc->log : NULL;
+	const char *p;
 	va_list va;
+	char *q;
+	u8 freeable;
 
 	va_start(va, fmt);
-
-	switch (fmt[0]) {
-	case 'w':
-		vprintk_emit(0, LOGLEVEL_WARNING, NULL, 0, fmt, va);
-		break;
-	case 'e':
-		vprintk_emit(0, LOGLEVEL_ERR, NULL, 0, fmt, va);
-		break;
-	default:
-		vprintk_emit(0, LOGLEVEL_NOTICE, NULL, 0, fmt, va);
-		break;
+	if (!strchr(fmt, '%')) {
+		p = fmt;
+		goto unformatted_string;
 	}
+	if (strcmp(fmt, "%s") == 0) {
+		p = va_arg(va, const char *);
+		goto unformatted_string;
+	}
+
+	q = kvasprintf(GFP_KERNEL, fmt, va);
+copied_string:
+	if (!q)
+		goto store_failure;
+	freeable = 1;
+	goto store_string;
+
+unformatted_string:
+	if ((unsigned long)p >= (unsigned long)__start_rodata &&
+	    (unsigned long)p <  (unsigned long)__end_rodata)
+		goto const_string;
+	if (log && within_module_core((unsigned long)p, log->owner))
+		goto const_string;
+	q = kstrdup(p, GFP_KERNEL);
+	goto copied_string;
+
+store_failure:
+	p = store_failure;
+const_string:
+	q = (char *)p;
+	freeable = 0;
+store_string:
+	if (!log) {
+		switch (fmt[0]) {
+		case 'w':
+			printk(KERN_WARNING "%s\n", q + 2);
+			break;
+		case 'e':
+			printk(KERN_ERR "%s\n", q + 2);
+			break;
+		default:
+			printk(KERN_NOTICE "%s\n", q + 2);
+			break;
+		}
+		if (freeable)
+			kfree(q);
+	} else {
+		unsigned int logsize = ARRAY_SIZE(log->buffer);
+		u8 index;
+
+		index = log->head & (logsize - 1);
+		BUILD_BUG_ON(sizeof(log->head) != sizeof(u8) ||
+			     sizeof(log->tail) != sizeof(u8));
+		if ((u8)(log->head - log->tail) == logsize) {
+			/* The buffer is full, discard the oldest message */
+			if (log->need_free & (1 << index))
+				kfree(log->buffer[index]);
+			log->tail++;
+		}
 
-	pr_cont("\n");
+		log->buffer[index] = q;
+		log->need_free &= ~(1 << index);
+		log->need_free |= freeable << index;
+		log->head++;
+	}
 	va_end(va);
 }
 EXPORT_SYMBOL(logfc);
-#endif
+
+/*
+ * Free a logging structure.
+ */
+static void put_fc_log(struct fs_context *fc)
+{
+	struct fc_log *log = fc->log;
+	int i;
+
+	if (log) {
+		if (refcount_dec_and_test(&log->usage)) {
+			fc->log = NULL;
+			for (i = 0; i <= 7; i++)
+				if (log->need_free & (1 << i))
+					kfree(log->buffer[i]);
+			kfree(log);
+		}
+	}
+}
 
 /**
  * put_fs_context - Dispose of a superblock configuration context.
@@ -435,6 +511,7 @@ void put_fs_context(struct fs_context *fc)
 	put_user_ns(fc->user_ns);
 	put_cred(fc->cred);
 	kfree(fc->subtype);
+	put_fc_log(fc);
 	put_filesystem(fc->fs_type);
 	kfree(fc->source);
 	kfree(fc);
diff --git a/fs/fsopen.c b/fs/fsopen.c
index d256f1ac9ff1..5fce6347de7a 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -20,6 +20,52 @@
 #include <uapi/linux/mount.h>
 #include "mount.h"
 
+/*
+ * Allow the user to read back any error, warning or informational messages.
+ */
+static ssize_t fscontext_read(struct file *file,
+			      char __user *_buf, size_t len, loff_t *pos)
+{
+	struct fs_context *fc = file->private_data;
+	struct fc_log *log = fc->log;
+	unsigned int logsize = ARRAY_SIZE(log->buffer);
+	ssize_t ret;
+	char *p;
+	bool need_free;
+	int index, n;
+
+	ret = mutex_lock_interruptible(&fc->uapi_mutex);
+	if (ret < 0)
+		return ret;
+
+	if (log->head == log->tail) {
+		mutex_unlock(&fc->uapi_mutex);
+		return -ENODATA;
+	}
+
+	index = log->tail & (logsize - 1);
+	p = log->buffer[index];
+	need_free = log->need_free & (1 << index);
+	log->buffer[index] = NULL;
+	log->need_free &= ~(1 << index);
+	log->tail++;
+	mutex_unlock(&fc->uapi_mutex);
+
+	ret = -EMSGSIZE;
+	n = strlen(p);
+	if (n > len)
+		goto err_free;
+	ret = -EFAULT;
+	if (copy_to_user(_buf, p, n) != 0)
+		goto err_free;
+	ret = n;
+
+err_free:
+	if (need_free)
+		kfree(p);
+	return ret;
+}
+
 static int fscontext_release(struct inode *inode, struct file *file)
 {
 	struct fs_context *fc = file->private_data;
@@ -32,6 +78,7 @@ static int fscontext_release(struct inode *inode, struct file *file)
 }
 
 const struct file_operations fscontext_fops = {
+	.read		= fscontext_read,
 	.release	= fscontext_release,
 	.llseek		= no_llseek,
 };
@@ -50,6 +97,16 @@ static int fscontext_create_fd(struct fs_context *fc, unsigned int o_flags)
 	return fd;
 }
 
+static int fscontext_alloc_log(struct fs_context *fc)
+{
+	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
+	if (!fc->log)
+		return -ENOMEM;
+	refcount_set(&fc->log->usage, 1);
+	fc->log->owner = fc->fs_type->owner;
+	return 0;
+}
+
 /*
  * Open a filesystem by name so that it can be configured for mounting.
  *
@@ -62,6 +119,7 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	struct file_system_type *fs_type;
 	struct fs_context *fc;
 	const char *fs_name;
+	int ret;
 
 	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
@@ -84,5 +142,14 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 		return PTR_ERR(fc);
 
 	fc->phase = FS_CONTEXT_CREATE_PARAMS;
+
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
+		goto err_fc;
+
 	return fscontext_create_fd(fc, flags & FSOPEN_CLOEXEC ? O_CLOEXEC : 0);
+
+err_fc:
+	put_fs_context(fc);
+	return ret;
 }
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7ab8b44fab3e..1f966670c8dc 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -13,6 +13,7 @@
 #define _LINUX_FS_CONTEXT_H
 
 #include <linux/kernel.h>
+#include <linux/refcount.h>
 #include <linux/errno.h>
 #include <linux/security.h>
 #include <linux/mutex.h>
@@ -95,6 +96,7 @@ struct fs_context {
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
 	const struct cred	*cred;		/* The mounter's credentials */
+	struct fc_log		*log;		/* Logging buffer */
 	const char		*source;	/* The source name (eg. dev path) */
 	const char		*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* Linux S&M options */
@@ -151,15 +153,21 @@ extern int vfs_get_super(struct fs_context *fc,
 
 extern const struct file_operations fscontext_fops;
 
-#ifdef CONFIG_PRINTK
+/*
+ * Mount error, warning and informational message logging.  This structure is
+ * shareable between a mount and a subordinate mount.
+ */
+struct fc_log {
+	refcount_t	usage;
+	u8		head;		/* Insertion index in buffer[] */
+	u8		tail;		/* Removal index in buffer[] */
+	u8		need_free;	/* Mask of kfree'able items in buffer[] */
+	struct module	*owner;		/* Owner module for strings that don't then need freeing */
+	char		*buffer[8];
+};
+
 extern __attribute__((format(printf, 2, 3)))
 void logfc(struct fs_context *fc, const char *fmt, ...);
-#else
-static inline __attribute__((format(printf, 2, 3)))
-void logfc(struct fs_context *fc, const char *fmt, ...)
-{
-}
-#endif
 
 /**
  * infof - Store supplementary informational message
diff --git a/include/linux/module.h b/include/linux/module.h
index 8fa38d3e7538..902cbd0047d4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -693,6 +693,12 @@ static inline bool is_module_text_address(unsigned long addr)
 	return false;
 }
 
+static inline bool within_module_core(unsigned long addr,
+				      const struct module *mod)
+{
+	return false;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while (0)

