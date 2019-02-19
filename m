Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96ACC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A665721738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfBSQbb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:31:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbfBSQbb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BE94A786B;
        Tue, 19 Feb 2019 16:31:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A0CE19C57;
        Tue, 19 Feb 2019 16:31:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/43] introduce cloning of fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:27 +0000
Message-ID: <155059388775.12449.6588682823855626275.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 16:31:30 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

new primitive: vfs_dup_fs_context().  Comes with fs_context
method (->dup()) for copying the filesystem-specific parts
of fs_context, along with LSM one (->fs_context_dup()) for
doing the same to LSM parts.

[needs better commit message, and change of Author:, anyway]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/fs_context.c            |   67 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs_context.h |    2 +
 include/linux/lsm_hooks.h  |    7 +++++
 include/linux/security.h   |    6 ++++
 security/security.c        |    5 +++
 security/selinux/hooks.c   |   39 ++++++++++++++++++++++++++
 security/smack/smack_lsm.c |   49 ++++++++++++++++++++++++++++++++
 7 files changed, 175 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index aa7e0ffb591a..57f61833ac83 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -337,6 +337,47 @@ void fc_drop_locked(struct fs_context *fc)
 
 static void legacy_fs_context_free(struct fs_context *fc);
 
+/**
+ * vfs_dup_fc_config: Duplicate a filesystem context.
+ * @src_fc: The context to copy.
+ */
+struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
+{
+	struct fs_context *fc;
+	int ret;
+
+	if (!src_fc->ops->dup)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	fc = kmemdup(src_fc, sizeof(struct fs_context), GFP_KERNEL);
+	if (!fc)
+		return ERR_PTR(-ENOMEM);
+
+	fc->fs_private	= NULL;
+	fc->s_fs_info	= NULL;
+	fc->source	= NULL;
+	fc->security	= NULL;
+	get_filesystem(fc->fs_type);
+	get_net(fc->net_ns);
+	get_user_ns(fc->user_ns);
+	get_cred(fc->cred);
+
+	/* Can't call put until we've called ->dup */
+	ret = fc->ops->dup(fc, src_fc);
+	if (ret < 0)
+		goto err_fc;
+
+	ret = security_fs_context_dup(fc, src_fc);
+	if (ret < 0)
+		goto err_fc;
+	return fc;
+
+err_fc:
+	put_fs_context(fc);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(vfs_dup_fs_context);
+
 /**
  * put_fs_context - Dispose of a superblock configuration context.
  * @fc: The context to dispose of.
@@ -380,6 +421,31 @@ static void legacy_fs_context_free(struct fs_context *fc)
 	}
 }
 
+/*
+ * Duplicate a legacy config.
+ */
+static int legacy_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	struct legacy_fs_context *ctx;
+	struct legacy_fs_context *src_ctx = src_fc->fs_private;
+
+	ctx = kmemdup(src_ctx, sizeof(*src_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	if (ctx->param_type == LEGACY_FS_INDIVIDUAL_PARAMS) {
+		ctx->legacy_data = kmemdup(src_ctx->legacy_data,
+					   src_ctx->data_size, GFP_KERNEL);
+		if (!ctx->legacy_data) {
+			kfree(ctx);
+			return -ENOMEM;
+		}
+	}
+
+	fc->fs_private = ctx;
+	return 0;
+}
+
 /*
  * Add a parameter to a legacy config.  We build up a comma-separated list of
  * options.
@@ -514,6 +580,7 @@ static int legacy_reconfigure(struct fs_context *fc)
 
 const struct fs_context_operations legacy_fs_context_ops = {
 	.free			= legacy_fs_context_free,
+	.dup			= legacy_fs_context_dup,
 	.parse_param		= legacy_parse_param,
 	.parse_monolithic	= legacy_parse_monolithic,
 	.get_tree		= legacy_get_tree,
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index b1a95db7a111..0db0b645c7b8 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -94,6 +94,7 @@ struct fs_context {
 
 struct fs_context_operations {
 	void (*free)(struct fs_context *fc);
+	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
 	int (*parse_param)(struct fs_context *fc, struct fs_parameter *param);
 	int (*parse_monolithic)(struct fs_context *fc, void *data);
 	int (*get_tree)(struct fs_context *fc);
@@ -111,6 +112,7 @@ extern struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_type,
 						struct dentry *reference);
 
+extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47ba4db4d8fb..356e78fe90a8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -79,6 +79,11 @@
  * Security hooks for mount using fs_context.
  *	[See also Documentation/filesystems/mounting.txt]
  *
+ * @fs_context_dup:
+ *	Allocate and attach a security structure to sc->security.  This pointer
+ *	is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@src_fc indicates the original filesystem context.
  * @fs_context_parse_param:
  *	Userspace provided a parameter to configure a superblock.  The LSM may
  *	reject it with an error and may use it for itself, in which case it
@@ -1470,6 +1475,7 @@ union security_list_options {
 	void (*bprm_committing_creds)(struct linux_binprm *bprm);
 	void (*bprm_committed_creds)(struct linux_binprm *bprm);
 
+	int (*fs_context_dup)(struct fs_context *fc, struct fs_context *src_sc);
 	int (*fs_context_parse_param)(struct fs_context *fc, struct fs_parameter *param);
 
 	int (*sb_alloc_security)(struct super_block *sb);
@@ -1813,6 +1819,7 @@ struct security_hook_heads {
 	struct hlist_head bprm_check_security;
 	struct hlist_head bprm_committing_creds;
 	struct hlist_head bprm_committed_creds;
+	struct hlist_head fs_context_dup;
 	struct hlist_head fs_context_parse_param;
 	struct hlist_head sb_alloc_security;
 	struct hlist_head sb_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index 2da9336a987e..f28a1ebfd78e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -223,6 +223,7 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
@@ -521,6 +522,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_dup(struct fs_context *fc,
+					  struct fs_context *src_fc)
+{
+	return 0;
+}
 static inline int security_fs_context_parse_param(struct fs_context *fc,
 						  struct fs_parameter *param)
 {
diff --git a/security/security.c b/security/security.c
index e5519488327d..5759339319dc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -374,6 +374,11 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+}
+
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f99381e97d73..4ba83de5fa80 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2764,6 +2764,44 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+static int selinux_fs_context_dup(struct fs_context *fc,
+				  struct fs_context *src_fc)
+{
+	const struct selinux_mnt_opts *src = src_fc->security;
+	struct selinux_mnt_opts *opts;
+
+	if (!src)
+		return 0;
+
+	fc->security = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+
+	opts = fc->security;
+
+	if (src->fscontext) {
+		opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
+		if (!opts->fscontext)
+			return -ENOMEM;
+	}
+	if (src->context) {
+		opts->context = kstrdup(src->context, GFP_KERNEL);
+		if (!opts->context)
+			return -ENOMEM;
+	}
+	if (src->rootcontext) {
+		opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
+		if (!opts->rootcontext)
+			return -ENOMEM;
+	}
+	if (src->defcontext) {
+		opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
+		if (!opts->defcontext)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static const struct fs_parameter_spec selinux_param_specs[] = {
 	fsparam_string(CONTEXT_STR,	Opt_context),
 	fsparam_string(DEFCONTEXT_STR,	Opt_defcontext),
@@ -6745,6 +6783,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
+	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5f93c4f84384..03176f600a87 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -647,6 +647,54 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	return -EINVAL;
 }
 
+/**
+ * smack_fs_context_dup - Duplicate the security data on fs_context duplication
+ * @fc: The new filesystem context.
+ * @src_fc: The source filesystem context being duplicated.
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_dup(struct fs_context *fc,
+				struct fs_context *src_fc)
+{
+	struct smack_mnt_opts *dst, *src = src_fc->security;
+
+	if (!src)
+		return 0;
+
+	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+	dst = fc->security;
+
+	if (src->fsdefault) {
+		dst->fsdefault = kstrdup(src->fsdefault, GFP_KERNEL);
+		if (!dst->fsdefault)
+			return -ENOMEM;
+	}
+	if (src->fsfloor) {
+		dst->fsfloor = kstrdup(src->fsfloor, GFP_KERNEL);
+		if (!dst->fsfloor)
+			return -ENOMEM;
+	}
+	if (src->fshat) {
+		dst->fshat = kstrdup(src->fshat, GFP_KERNEL);
+		if (!dst->fshat)
+			return -ENOMEM;
+	}
+	if (src->fsroot) {
+		dst->fsroot = kstrdup(src->fsroot, GFP_KERNEL);
+		if (!dst->fsroot)
+			return -ENOMEM;
+	}
+	if (src->fstransmute) {
+		dst->fstransmute = kstrdup(src->fstransmute, GFP_KERNEL);
+		if (!dst->fstransmute)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static const struct fs_parameter_spec smack_param_specs[] = {
 	fsparam_string("fsdefault",	Opt_fsdefault),
 	fsparam_string("fsfloor",	Opt_fsfloor),
@@ -4626,6 +4674,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
+	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),

