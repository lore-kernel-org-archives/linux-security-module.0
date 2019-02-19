Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E40C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05821738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfBSQbQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfBSQbQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:31:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37267A7865;
        Tue, 19 Feb 2019 16:31:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C546861460;
        Tue, 19 Feb 2019 16:31:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/43] vfs: Implement a filesystem superblock
 creation/configuration context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:04 +0000
Message-ID: <155059386422.12449.6531190148715512242.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 16:31:15 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[AV - unfuck kern_mount_data(); we want non-NULL ->mnt_ns on long-living
mounts]
[AV - reordering fs/namespace.c is badly overdue, but let's keep it
separate from that series]
[AV - drop simple_pin_fs() change]
[AV - clean vfs_kern_mount() failure exits up]

Implement a filesystem context concept to be used during superblock
creation for mount and superblock reconfiguration for remount.

The mounting procedure then becomes:

 (1) Allocate new fs_context context.

 (2) Configure the context.

 (3) Create superblock.

 (4) Query the superblock.

 (5) Create a mount for the superblock.

 (6) Destroy the context.

Rather than calling fs_type->mount(), an fs_context struct is created and
fs_type->init_fs_context() is called to set it up.  Pointers exist for the
filesystem and LSM to hang their private data off.

A set of operations has to be set by ->init_fs_context() to provide
freeing, duplication, option parsing, binary data parsing, validation,
mounting and superblock filling.

Legacy filesystems are supported by the provision of a set of legacy
fs_context operations that build up a list of mount options and then invoke
fs_type->mount() from within the fs_context ->get_tree() operation.  This
allows all filesystems to be accessed using fs_context.

It should be noted that, whilst this patch adds a lot of lines of code,
there is quite a bit of duplication with existing code that can be
eliminated should all filesystems be converted over.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/filesystems.c           |    4 +
 fs/fs_context.c            |  300 ++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c             |   25 +---
 include/linux/fs.h         |    2 
 include/linux/fs_context.h |    5 +
 5 files changed, 319 insertions(+), 17 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index b03f57b1105b..9135646e41ac 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/fs_parser.h>
 
 /*
  * Handling of filesystem drivers list.
@@ -73,6 +74,9 @@ int register_filesystem(struct file_system_type * fs)
 	int res = 0;
 	struct file_system_type ** p;
 
+	if (fs->parameters && !fs_validate_description(fs->parameters))
+		return -EINVAL;
+
 	BUG_ON(strchr(fs->name, '.'));
 	if (fs->next)
 		return -EBUSY;
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 825d1b2c8807..aa7e0ffb591a 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/nsproxy.h>
@@ -25,13 +26,217 @@
 #include "mount.h"
 #include "internal.h"
 
+enum legacy_fs_param {
+	LEGACY_FS_UNSET_PARAMS,
+	LEGACY_FS_MONOLITHIC_PARAMS,
+	LEGACY_FS_INDIVIDUAL_PARAMS,
+};
+
 struct legacy_fs_context {
 	char			*legacy_data;	/* Data page for legacy filesystems */
 	size_t			data_size;
+	enum legacy_fs_param	param_type;
 };
 
 static int legacy_init_fs_context(struct fs_context *fc);
 
+static const struct constant_table common_set_sb_flag[] = {
+	{ "dirsync",	SB_DIRSYNC },
+	{ "lazytime",	SB_LAZYTIME },
+	{ "mand",	SB_MANDLOCK },
+	{ "posixacl",	SB_POSIXACL },
+	{ "ro",		SB_RDONLY },
+	{ "sync",	SB_SYNCHRONOUS },
+};
+
+static const struct constant_table common_clear_sb_flag[] = {
+	{ "async",	SB_SYNCHRONOUS },
+	{ "nolazytime",	SB_LAZYTIME },
+	{ "nomand",	SB_MANDLOCK },
+	{ "rw",		SB_RDONLY },
+	{ "silent",	SB_SILENT },
+};
+
+static const char *const forbidden_sb_flag[] = {
+	"bind",
+	"dev",
+	"exec",
+	"move",
+	"noatime",
+	"nodev",
+	"nodiratime",
+	"noexec",
+	"norelatime",
+	"nostrictatime",
+	"nosuid",
+	"private",
+	"rec",
+	"relatime",
+	"remount",
+	"shared",
+	"slave",
+	"strictatime",
+	"suid",
+	"unbindable",
+};
+
+/*
+ * Check for a common mount option that manipulates s_flags.
+ */
+static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
+{
+	unsigned int token;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
+		if (strcmp(key, forbidden_sb_flag[i]) == 0)
+			return -EINVAL;
+
+	token = lookup_constant(common_set_sb_flag, key, 0);
+	if (token) {
+		fc->sb_flags |= token;
+		fc->sb_flags_mask |= token;
+		return 0;
+	}
+
+	token = lookup_constant(common_clear_sb_flag, key, 0);
+	if (token) {
+		fc->sb_flags &= ~token;
+		fc->sb_flags_mask |= token;
+		return 0;
+	}
+
+	return -ENOPARAM;
+}
+
+/**
+ * vfs_parse_fs_param - Add a single parameter to a superblock config
+ * @fc: The filesystem context to modify
+ * @param: The parameter
+ *
+ * A single mount option in string form is applied to the filesystem context
+ * being set up.  Certain standard options (for example "ro") are translated
+ * into flag bits without going to the filesystem.  The active security module
+ * is allowed to observe and poach options.  Any other options are passed over
+ * to the filesystem to parse.
+ *
+ * This may be called multiple times for a context.
+ *
+ * Returns 0 on success and a negative error code on failure.  In the event of
+ * failure, supplementary error information may have been set.
+ */
+int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	int ret;
+
+	if (!param->key)
+		return invalf(fc, "Unnamed parameter\n");
+
+	ret = vfs_parse_sb_flag(fc, param->key);
+	if (ret != -ENOPARAM)
+		return ret;
+
+	ret = security_fs_context_parse_param(fc, param);
+	if (ret != -ENOPARAM)
+		/* Param belongs to the LSM or is disallowed by the LSM; so
+		 * don't pass to the FS.
+		 */
+		return ret;
+
+	if (fc->ops->parse_param) {
+		ret = fc->ops->parse_param(fc, param);
+		if (ret != -ENOPARAM)
+			return ret;
+	}
+
+	/* If the filesystem doesn't take any arguments, give it the
+	 * default handling of source.
+	 */
+	if (strcmp(param->key, "source") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Non-string source");
+		if (fc->source)
+			return invalf(fc, "VFS: Multiple sources");
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	}
+
+	return invalf(fc, "%s: Unknown parameter '%s'",
+		      fc->fs_type->name, param->key);
+}
+EXPORT_SYMBOL(vfs_parse_fs_param);
+
+/**
+ * vfs_parse_fs_string - Convenience function to just parse a string.
+ */
+int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			const char *value, size_t v_size)
+{
+	int ret;
+
+	struct fs_parameter param = {
+		.key	= key,
+		.type	= fs_value_is_string,
+		.size	= v_size,
+	};
+
+	if (v_size > 0) {
+		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+		if (!param.string)
+			return -ENOMEM;
+	}
+
+	ret = vfs_parse_fs_param(fc, &param);
+	kfree(param.string);
+	return ret;
+}
+EXPORT_SYMBOL(vfs_parse_fs_string);
+
+/**
+ * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @ctx: The superblock configuration to fill in.
+ * @data: The data to parse
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+int generic_parse_monolithic(struct fs_context *fc, void *data)
+{
+	char *options = data, *key;
+	int ret = 0;
+
+	if (!options)
+		return 0;
+
+	ret = security_sb_eat_lsm_opts(options, &fc->security);
+	if (ret)
+		return ret;
+
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			if (value) {
+				if (value == key)
+					continue;
+				*value++ = 0;
+				v_len = strlen(value);
+			}
+			ret = vfs_parse_fs_string(fc, key, value, v_len);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(generic_parse_monolithic);
+
 /**
  * alloc_fs_context - Create a filesystem context.
  * @fs_type: The filesystem type.
@@ -166,7 +371,87 @@ EXPORT_SYMBOL(put_fs_context);
  */
 static void legacy_fs_context_free(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct legacy_fs_context *ctx = fc->fs_private;
+
+	if (ctx) {
+		if (ctx->param_type == LEGACY_FS_INDIVIDUAL_PARAMS)
+			kfree(ctx->legacy_data);
+		kfree(ctx);
+	}
+}
+
+/*
+ * Add a parameter to a legacy config.  We build up a comma-separated list of
+ * options.
+ */
+static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct legacy_fs_context *ctx = fc->fs_private;
+	unsigned int size = ctx->data_size;
+	size_t len = 0;
+
+	if (strcmp(param->key, "source") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Legacy: Non-string source");
+		if (fc->source)
+			return invalf(fc, "VFS: Legacy: Multiple sources");
+		fc->source = param->string;
+		param->string = NULL;
+		return 0;
+	}
+
+	if ((fc->fs_type->fs_flags & FS_HAS_SUBTYPE) &&
+	    strcmp(param->key, "subtype") == 0) {
+		if (param->type != fs_value_is_string)
+			return invalf(fc, "VFS: Legacy: Non-string subtype");
+		if (fc->subtype)
+			return invalf(fc, "VFS: Legacy: Multiple subtype");
+		fc->subtype = param->string;
+		param->string = NULL;
+		return 0;
+	}
+
+	if (ctx->param_type == LEGACY_FS_MONOLITHIC_PARAMS)
+		return invalf(fc, "VFS: Legacy: Can't mix monolithic and individual options");
+
+	switch (param->type) {
+	case fs_value_is_string:
+		len = 1 + param->size;
+		/* Fall through */
+	case fs_value_is_flag:
+		len += strlen(param->key);
+		break;
+	default:
+		return invalf(fc, "VFS: Legacy: Parameter type for '%s' not supported",
+			      param->key);
+	}
+
+	if (len > PAGE_SIZE - 2 - size)
+		return invalf(fc, "VFS: Legacy: Cumulative options too large");
+	if (strchr(param->key, ',') ||
+	    (param->type == fs_value_is_string &&
+	     memchr(param->string, ',', param->size)))
+		return invalf(fc, "VFS: Legacy: Option '%s' contained comma",
+			      param->key);
+	if (!ctx->legacy_data) {
+		ctx->legacy_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!ctx->legacy_data)
+			return -ENOMEM;
+	}
+
+	ctx->legacy_data[size++] = ',';
+	len = strlen(param->key);
+	memcpy(ctx->legacy_data + size, param->key, len);
+	size += len;
+	if (param->type == fs_value_is_string) {
+		ctx->legacy_data[size++] = '=';
+		memcpy(ctx->legacy_data + size, param->string, param->size);
+		size += param->size;
+	}
+	ctx->legacy_data[size] = '\0';
+	ctx->data_size = size;
+	ctx->param_type = LEGACY_FS_INDIVIDUAL_PARAMS;
+	return 0;
 }
 
 /*
@@ -175,9 +460,17 @@ static void legacy_fs_context_free(struct fs_context *fc)
 static int legacy_parse_monolithic(struct fs_context *fc, void *data)
 {
 	struct legacy_fs_context *ctx = fc->fs_private;
+
+	if (ctx->param_type != LEGACY_FS_UNSET_PARAMS) {
+		pr_warn("VFS: Can't mix monolithic and individual options\n");
+		return -EINVAL;
+	}
+
 	ctx->legacy_data = data;
+	ctx->param_type = LEGACY_FS_MONOLITHIC_PARAMS;
 	if (!ctx->legacy_data)
 		return 0;
+
 	if (fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA)
 		return 0;
 	return security_sb_eat_lsm_opts(ctx->legacy_data, &fc->security);
@@ -221,6 +514,7 @@ static int legacy_reconfigure(struct fs_context *fc)
 
 const struct fs_context_operations legacy_fs_context_ops = {
 	.free			= legacy_fs_context_free,
+	.parse_param		= legacy_parse_param,
 	.parse_monolithic	= legacy_parse_monolithic,
 	.get_tree		= legacy_get_tree,
 	.reconfigure		= legacy_reconfigure,
@@ -242,6 +536,10 @@ static int legacy_init_fs_context(struct fs_context *fc)
 int parse_monolithic_mount_data(struct fs_context *fc, void *data)
 {
 	int (*monolithic_mount_data)(struct fs_context *, void *);
+
 	monolithic_mount_data = fc->ops->parse_monolithic;
+	if (!monolithic_mount_data)
+		monolithic_mount_data = generic_parse_monolithic;
+
 	return monolithic_mount_data(fc, data);
 }
diff --git a/fs/namespace.c b/fs/namespace.c
index 931228d8518a..1a1ed2528f47 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -997,17 +997,15 @@ struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 	int ret = 0;
 
 	if (!type)
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(-EINVAL);
 
 	fc = fs_context_for_mount(type, flags);
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
-	if (name) {
-		fc->source = kstrdup(name, GFP_KERNEL);
-		if (!fc->source)
-			ret = -ENOMEM;
-	}
+	if (name)
+		ret = vfs_parse_fs_string(fc, "source",
+					  name, strlen(name));
 	if (!ret)
 		ret = parse_monolithic_mount_data(fc, data);
 	if (!ret)
@@ -2611,16 +2609,11 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (IS_ERR(fc))
 		return PTR_ERR(fc);
 
-	if (subtype) {
-		fc->subtype = kstrdup(subtype, GFP_KERNEL);
-		if (!fc->subtype)
-			err = -ENOMEM;
-	}
-	if (!err && name) {
-		fc->source = kstrdup(name, GFP_KERNEL);
-		if (!fc->source)
-			err = -ENOMEM;
-	}
+	if (subtype)
+		err = vfs_parse_fs_string(fc, "subtype",
+					  subtype, strlen(subtype));
+	if (!err && name)
+		err = vfs_parse_fs_string(fc, "source", name, strlen(name));
 	if (!err)
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8d578a9e1e8c..cf6e9ea161eb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -62,6 +62,7 @@ struct iov_iter;
 struct fscrypt_info;
 struct fscrypt_operations;
 struct fs_context;
+struct fs_parameter_description;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2175,6 +2176,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
+	const struct fs_parameter_description *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index d5ff3b0bc28d..d794b04e9fbb 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -92,6 +92,7 @@ struct fs_context {
 
 struct fs_context_operations {
 	void (*free)(struct fs_context *fc);
+	int (*parse_param)(struct fs_context *fc, struct fs_parameter *param);
 	int (*parse_monolithic)(struct fs_context *fc, void *data);
 	int (*get_tree)(struct fs_context *fc);
 	int (*reconfigure)(struct fs_context *fc);
@@ -108,6 +109,10 @@ extern struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_type,
 						struct dentry *reference);
 
+extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
+extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
+			       const char *value, size_t v_size);
+extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
 

