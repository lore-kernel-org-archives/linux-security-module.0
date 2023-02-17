Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1F1C636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBQD1m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBQD1D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:27:03 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D9759731
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:58 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t16so1773388qto.3
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZDYE/D+C7/Nf8E9H+aCHM6gSe5lfLZoegwtT/8PIvI=;
        b=FfsohesZpdah0w7PtMZg2Ecq9Ymh9t836V+Pp4Aw0P8x2Wx+6v7+bgJA7lY6u2hIwI
         yGZIqKaDZg7zOqtlFNE24bpEtIlgNNnM51Dzdr0gdqq+g9RL9xUI0N7nOTzYg7br93kZ
         lJZbqbiSRuBoiT8epTuKZya5wXPAwXRAptiCzCQSyyWQJL0tCJERLNQYOqTUch+RRXNU
         XGP1c0yHwb34VarogpGF+IAaQLW0ts57XG1CKHBbIVLnY9jwTsUhYdyBik/H25XtBTS0
         2Z7CoIzpF7NoPY/oMTJa+07XtjrIVzrnPaA9tnQltsE9XIBulVDj2juuL5AyXQUn9H3T
         jIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZDYE/D+C7/Nf8E9H+aCHM6gSe5lfLZoegwtT/8PIvI=;
        b=PqSSLOU1X+rv55k3NDGHNY3MJsBQhga1kaGtGIYKmvqw3mmFU8IsYSl+QNOyCRUva4
         jJM/LsqOQq5IVRuYE2VjfkV8viw+y0CeacSvsfO4wXNNMCtGq95MRSHxN4Qr9GtNEixT
         WM3dKLAdXBSIeBg54DItETGiOT77gnHqF+gMdieNu+g2UzhIpKxRigv5rmEynmQg8Pxs
         cJqZT0Qwtz+hFhBYzfNQBKgwMY9MMIGfEpn8K3Xp0d6tzoic6//4I9ckMDpPrPc0xthJ
         JGAZ+cP8dPb0uAUESzp7FcP6rgQrctcszQR09lztXEOtnHMcczpqaa31bOo0P6enW8Pk
         ub8Q==
X-Gm-Message-State: AO0yUKWdgmE0ZU9ZKO2ryTPuJfGenDntg2JCw1ihXqKqz0oaqFWkudlB
        CnBKWdvnpJr8vrc2qgWk9mozLKOl8AP0yIE=
X-Google-Smtp-Source: AK7set+UoRnwsMYXa9csyj9WG+nK1kMsdtICGsm2n2nhOxJvTIiSVLIopoJbxt76okpxvhhpVzlKgw==
X-Received: by 2002:ac8:5b86:0:b0:3b8:4144:fe72 with SMTP id a6-20020ac85b86000000b003b84144fe72mr14459120qta.9.1676604417756;
        Thu, 16 Feb 2023 19:26:57 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id c186-20020a37b3c3000000b0072a375c291csm2494993qkf.30.2023.02.16.19.26.57
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:57 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 22/22] lsm: styling fixes to security/security.c
Date:   Thu, 16 Feb 2023 22:26:25 -0500
Message-Id: <20230217032625.678457-23-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

As we were already making massive changes to security/security.c by
moving all of the function header comments above the function
definitions, let's take the opportunity to fix various style crimes.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/security.c | 184 ++++++++++++++++++++++++--------------------
 1 file changed, 99 insertions(+), 85 deletions(-)

diff --git a/security/security.c b/security/security.c
index 4362d9b9140f..f5ff06868e0b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -42,7 +42,7 @@
  * all security modules to use the same descriptions for auditing
  * purposes.
  */
-const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
+const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
@@ -88,7 +88,7 @@ static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
 static __initdata const char *chosen_lsm_order;
 static __initdata const char *chosen_major_lsm;
 
-static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
+static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
 
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
@@ -332,7 +332,8 @@ static void __init report_lsm_order(void)
 	pr_info("initializing lsm=");
 
 	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info; early < __end_early_lsm_info; early++)
+	for (early = __start_early_lsm_info;
+	     early < __end_early_lsm_info; early++)
 		if (is_enabled(early))
 			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
 	for (lsm = ordered_lsms; *lsm; lsm++)
@@ -347,7 +348,7 @@ static void __init ordered_lsm_init(void)
 	struct lsm_info **lsm;
 
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
-				GFP_KERNEL);
+			       GFP_KERNEL);
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
@@ -420,9 +421,9 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	init_debug("legacy security=%s\n", chosen_major_lsm ?: " *unspecified*");
+	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
 	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ?: " *unspecified*");
+	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
@@ -510,7 +511,7 @@ static int lsm_append(const char *new, char **result)
  * Each LSM has to register its hooks with the infrastructure.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				const char *lsm)
+			       const char *lsm)
 {
 	int i;
 
@@ -887,12 +888,12 @@ int security_ptrace_traceme(struct task_struct *parent)
  * Return: Returns 0 if the capability sets were successfully obtained.
  */
 int security_capget(struct task_struct *target,
-		     kernel_cap_t *effective,
-		     kernel_cap_t *inheritable,
-		     kernel_cap_t *permitted)
+		    kernel_cap_t *effective,
+		    kernel_cap_t *inheritable,
+		    kernel_cap_t *permitted)
 {
 	return call_int_hook(capget, 0, target,
-				effective, inheritable, permitted);
+			     effective, inheritable, permitted);
 }
 
 /**
@@ -914,7 +915,7 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *permitted)
 {
 	return call_int_hook(capset, 0, new, old,
-				effective, inheritable, permitted);
+			     effective, inheritable, permitted);
 }
 
 /**
@@ -1348,7 +1349,7 @@ int security_sb_statfs(struct dentry *dentry)
  * Return: Returns 0 if permission is granted.
  */
 int security_sb_mount(const char *dev_name, const struct path *path,
-                       const char *type, unsigned long flags, void *data)
+		      const char *type, unsigned long flags, void *data)
 {
 	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
 }
@@ -1376,7 +1377,8 @@ int security_sb_umount(struct vfsmount *mnt, int flags)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_sb_pivotroot(const struct path *old_path, const struct path *new_path)
+int security_sb_pivotroot(const struct path *old_path,
+			  const struct path *new_path)
 {
 	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
 }
@@ -1393,13 +1395,13 @@ int security_sb_pivotroot(const struct path *old_path, const struct path *new_pa
  * Return: Returns 0 on success, error on failure.
  */
 int security_sb_set_mnt_opts(struct super_block *sb,
-				void *mnt_opts,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags)
+			     void *mnt_opts,
+			     unsigned long kern_flags,
+			     unsigned long *set_kern_flags)
 {
 	return call_int_hook(sb_set_mnt_opts,
-				mnt_opts ? -EOPNOTSUPP : 0, sb,
-				mnt_opts, kern_flags, set_kern_flags);
+			     mnt_opts ? -EOPNOTSUPP : 0, sb,
+			     mnt_opts, kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
@@ -1415,12 +1417,12 @@ EXPORT_SYMBOL(security_sb_set_mnt_opts);
  * Return: Returns 0 on success, error on failure.
  */
 int security_sb_clone_mnt_opts(const struct super_block *oldsb,
-				struct super_block *newsb,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags)
+			       struct super_block *newsb,
+			       unsigned long kern_flags,
+			       unsigned long *set_kern_flags)
 {
 	return call_int_hook(sb_clone_mnt_opts, 0, oldsb, newsb,
-				kern_flags, set_kern_flags);
+			     kern_flags, set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
@@ -1433,7 +1435,8 @@ EXPORT_SYMBOL(security_sb_clone_mnt_opts);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_move_mount(const struct path *from_path, const struct path *to_path)
+int security_move_mount(const struct path *from_path,
+			const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
 }
@@ -1450,7 +1453,7 @@ int security_move_mount(const struct path *from_path, const struct path *to_path
  * Return: Returns 0 if permission is granted.
  */
 int security_path_notify(const struct path *path, u64 mask,
-				unsigned int obj_type)
+			 unsigned int obj_type)
 {
 	return call_int_hook(path_notify, 0, path, mask, obj_type);
 }
@@ -1506,7 +1509,7 @@ void security_inode_free(struct inode *inode)
 	 */
 	if (inode->i_security)
 		call_rcu((struct rcu_head *)inode->i_security,
-				inode_free_by_rcu);
+			 inode_free_by_rcu);
 }
 
 /**
@@ -1535,7 +1538,8 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 	/*
 	 * Only one module will provide a security context.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security, list) {
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
 		rc = hp->hook.dentry_init_security(dentry, mode, name,
 						   xattr_name, ctx, ctxlen);
 		if (rc != LSM_RET_DEFAULT(dentry_init_security))
@@ -1565,7 +1569,7 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 				    const struct cred *old, struct cred *new)
 {
 	return call_int_hook(dentry_create_files_as, 0, dentry, mode,
-				name, old, new);
+			     name, old, new);
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
 
@@ -1607,9 +1611,9 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	memset(new_xattrs, 0, sizeof(new_xattrs));
 	lsm_xattr = new_xattrs;
 	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
+			    &lsm_xattr->name,
+			    &lsm_xattr->value,
+			    &lsm_xattr->value_len);
 	if (ret)
 		goto out;
 
@@ -1669,8 +1673,8 @@ EXPORT_SYMBOL(security_old_inode_init_security);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
-			unsigned int dev)
+int security_path_mknod(const struct path *dir, struct dentry *dentry,
+			umode_t mode, unsigned int dev)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
@@ -1688,7 +1692,8 @@ EXPORT_SYMBOL(security_path_mknod);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode)
+int security_path_mkdir(const struct path *dir, struct dentry *dentry,
+			umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
 		return 0;
@@ -1782,11 +1787,12 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 			 unsigned int flags)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-		     (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
+		     (d_is_positive(new_dentry) &&
+		      IS_PRIVATE(d_backing_inode(new_dentry)))))
 		return 0;
 
 	return call_int_hook(path_rename, 0, old_dir, old_dentry, new_dir,
-				new_dentry, flags);
+			     new_dentry, flags);
 }
 EXPORT_SYMBOL(security_path_rename);
 
@@ -1854,7 +1860,7 @@ int security_path_chroot(const struct path *path)
 {
 	return call_int_hook(path_chroot, 0, path);
 }
-#endif
+#endif /* CONFIG_SECURITY_PATH */
 
 /**
  * security_inode_create() - Check if creating a file is allowed
@@ -1866,7 +1872,8 @@ int security_path_chroot(const struct path *path)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
+int security_inode_create(struct inode *dir, struct dentry *dentry,
+			  umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
@@ -1885,7 +1892,7 @@ EXPORT_SYMBOL_GPL(security_inode_create);
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
-			 struct dentry *new_dentry)
+			struct dentry *new_dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry))))
 		return 0;
@@ -1919,7 +1926,7 @@ int security_inode_unlink(struct inode *dir, struct dentry *dentry)
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
-			    const char *old_name)
+			   const char *old_name)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
@@ -1975,7 +1982,8 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+int security_inode_mknod(struct inode *dir, struct dentry *dentry,
+			 umode_t mode, dev_t dev)
 {
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
@@ -1995,22 +2003,23 @@ int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
  * Return: Returns 0 if permission is granted.
  */
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
-			   struct inode *new_dir, struct dentry *new_dentry,
-			   unsigned int flags)
+			  struct inode *new_dir, struct dentry *new_dentry,
+			  unsigned int flags)
 {
-        if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
-            (d_is_positive(new_dentry) && IS_PRIVATE(d_backing_inode(new_dentry)))))
+	if (unlikely(IS_PRIVATE(d_backing_inode(old_dentry)) ||
+		     (d_is_positive(new_dentry) &&
+		      IS_PRIVATE(d_backing_inode(new_dentry)))))
 		return 0;
 
 	if (flags & RENAME_EXCHANGE) {
 		int err = call_int_hook(inode_rename, 0, new_dir, new_dentry,
-						     old_dir, old_dentry);
+					old_dir, old_dentry);
 		if (err)
 			return err;
 	}
 
 	return call_int_hook(inode_rename, 0, old_dir, old_dentry,
-					   new_dir, new_dentry);
+			     new_dir, new_dentry);
 }
 
 /**
@@ -2370,7 +2379,8 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
+		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name,
+						buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
@@ -2392,7 +2402,8 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
  *
  * Return: Returns 0 on success.
  */
-int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+int security_inode_setsecurity(struct inode *inode, const char *name,
+			       const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2404,7 +2415,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
-								flags);
+						flags);
 		if (rc != LSM_RET_DEFAULT(inode_setsecurity))
 			return rc;
 	}
@@ -2424,7 +2435,8 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
  *
  * Return: Returns number of bytes used/required on success.
  */
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+int security_inode_listsecurity(struct inode *inode,
+				char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -2486,7 +2498,7 @@ int security_inode_copy_up_xattr(const char *name)
 	 * any other error code incase of an error.
 	 */
 	hlist_for_each_entry(hp,
-		&security_hook_heads.inode_copy_up_xattr, list) {
+			     &security_hook_heads.inode_copy_up_xattr, list) {
 		rc = hp->hook.inode_copy_up_xattr(name);
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
@@ -2646,11 +2658,11 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
  * Return: Returns 0 if permission is granted.
  */
 int security_mmap_file(struct file *file, unsigned long prot,
-			unsigned long flags)
+		       unsigned long flags)
 {
 	int ret;
 	ret = call_int_hook(mmap_file, 0, file, prot,
-					mmap_prot(file, prot), flags);
+			    mmap_prot(file, prot), flags);
 	if (ret)
 		return ret;
 	return ima_file_mmap(file, prot);
@@ -2680,7 +2692,7 @@ int security_mmap_addr(unsigned long addr)
  * Return: Returns 0 if permission is granted.
  */
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-			    unsigned long prot)
+			   unsigned long prot)
 {
 	int ret;
 
@@ -2753,7 +2765,7 @@ void security_file_set_fowner(struct file *file)
  * Return: Returns 0 if permission is granted.
  */
 int security_file_send_sigiotask(struct task_struct *tsk,
-				  struct fown_struct *fown, int sig)
+				 struct fown_struct *fown, int sig)
 {
 	return call_int_hook(file_send_sigiotask, 0, tsk, fown, sig);
 }
@@ -3117,7 +3129,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
  * Return: Returns 0 on success.
  */
 int security_task_fix_setgid(struct cred *new, const struct cred *old,
-				 int flags)
+			     int flags)
 {
 	return call_int_hook(task_fix_setgid, 0, new, old, flags);
 }
@@ -3281,7 +3293,7 @@ int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
  * Return: Returns 0 if permission is granted.
  */
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
-		struct rlimit *new_rlim)
+			    struct rlimit *new_rlim)
 {
 	return call_int_hook(task_setrlimit, 0, p, resource, new_rlim);
 }
@@ -3342,7 +3354,7 @@ int security_task_movememory(struct task_struct *p)
  * Return: Returns 0 if permission is granted.
  */
 int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
-			int sig, const struct cred *cred)
+		       int sig, const struct cred *cred)
 {
 	return call_int_hook(task_kill, 0, p, info, sig, cred);
 }
@@ -3362,7 +3374,7 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
  *         to cause prctl() to return immediately with that value.
  */
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
+			unsigned long arg4, unsigned long arg5)
 {
 	int thisrc;
 	int rc = LSM_RET_DEFAULT(task_prctl);
@@ -3544,7 +3556,7 @@ int security_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
  * Return: Returns 0 if permission is granted.
  */
 int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
-			       struct msg_msg *msg, int msqflg)
+			      struct msg_msg *msg, int msqflg)
 {
 	return call_int_hook(msg_queue_msgsnd, 0, msq, msg, msqflg);
 }
@@ -3565,7 +3577,7 @@ int security_msg_queue_msgsnd(struct kern_ipc_perm *msq,
  * Return: Returns 0 if permission is granted.
  */
 int security_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *msg,
-			       struct task_struct *target, long type, int mode)
+			      struct task_struct *target, long type, int mode)
 {
 	return call_int_hook(msg_queue_msgrcv, 0, msq, msg, target, type, mode);
 }
@@ -3648,7 +3660,8 @@ int security_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_shm_shmat(struct kern_ipc_perm *shp, char __user *shmaddr, int shmflg)
+int security_shm_shmat(struct kern_ipc_perm *shp,
+		       char __user *shmaddr, int shmflg)
 {
 	return call_int_hook(shm_shmat, 0, shp, shmaddr, shmflg);
 }
@@ -3731,7 +3744,7 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd)
  * Return: Returns 0 if permission is granted.
  */
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
-			unsigned nsops, int alter)
+		       unsigned nsops, int alter)
 {
 	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
 }
@@ -4000,7 +4013,7 @@ int security_watch_key(struct key *key)
 {
 	return call_int_hook(watch_key, 0, key);
 }
-#endif
+#endif /* CONFIG_KEY_NOTIFICATIONS */
 
 #ifdef CONFIG_SECURITY_NETWORK
 /**
@@ -4024,7 +4037,8 @@ int security_watch_key(struct key *key)
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
+int security_unix_stream_connect(struct sock *sock, struct sock *other,
+				 struct sock *newsk)
 {
 	return call_int_hook(unix_stream_connect, 0, sock, other, newsk);
 }
@@ -4094,7 +4108,7 @@ int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
 	return call_int_hook(socket_post_create, 0, sock, family, type,
-						protocol, kern);
+			     protocol, kern);
 }
 
 /**
@@ -4125,7 +4139,8 @@ EXPORT_SYMBOL(security_socket_socketpair);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
+int security_socket_bind(struct socket *sock,
+			 struct sockaddr *address, int addrlen)
 {
 	return call_int_hook(socket_bind, 0, sock, address, addrlen);
 }
@@ -4141,7 +4156,8 @@ int security_socket_bind(struct socket *sock, struct sockaddr *address, int addr
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
+int security_socket_connect(struct socket *sock,
+			    struct sockaddr *address, int addrlen)
 {
 	return call_int_hook(socket_connect, 0, sock, address, addrlen);
 }
@@ -4335,7 +4351,8 @@ int security_socket_getpeersec_stream(struct socket *sock, sockptr_t optval,
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock,
+				     struct sk_buff *skb, u32 *secid)
 {
 	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
 			     skb, secid);
@@ -4427,7 +4444,7 @@ EXPORT_SYMBOL(security_sock_graft);
  * Return: Returns 0 if permission is granted.
  */
 int security_inet_conn_request(const struct sock *sk,
-			struct sk_buff *skb, struct request_sock *req)
+			       struct sk_buff *skb, struct request_sock *req)
 {
 	return call_int_hook(inet_conn_request, 0, sk, skb, req);
 }
@@ -4441,7 +4458,7 @@ EXPORT_SYMBOL(security_inet_conn_request);
  * Set that LSM state of @sock using the LSM state from @req.
  */
 void security_inet_csk_clone(struct sock *newsk,
-			const struct request_sock *req)
+			     const struct request_sock *req)
 {
 	call_void_hook(inet_csk_clone, newsk, req);
 }
@@ -4454,7 +4471,7 @@ void security_inet_csk_clone(struct sock *newsk,
  * Update @sock's LSM state to represent a new connection from @skb.
  */
 void security_inet_conn_established(struct sock *sk,
-			struct sk_buff *skb)
+				    struct sk_buff *skb)
 {
 	call_void_hook(inet_conn_established, sk, skb);
 }
@@ -4590,7 +4607,8 @@ EXPORT_SYMBOL(security_tun_dev_open);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_sctp_assoc_request(struct sctp_association *asoc, struct sk_buff *skb)
+int security_sctp_assoc_request(struct sctp_association *asoc,
+				struct sk_buff *skb)
 {
 	return call_int_hook(sctp_assoc_request, 0, asoc, skb);
 }
@@ -4655,7 +4673,6 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
 #endif	/* CONFIG_SECURITY_NETWORK */
 
 #ifdef CONFIG_SECURITY_INFINIBAND
-
 /**
  * security_ib_pkey_access() - Check if access to an IB pkey is allowed
  * @sec: LSM blob
@@ -4682,9 +4699,11 @@ EXPORT_SYMBOL(security_ib_pkey_access);
  *
  * Return: Returns 0 if permission is granted.
  */
-int security_ib_endport_manage_subnet(void *sec, const char *dev_name, u8 port_num)
+int security_ib_endport_manage_subnet(void *sec,
+				      const char *dev_name, u8 port_num)
 {
-	return call_int_hook(ib_endport_manage_subnet, 0, sec, dev_name, port_num);
+	return call_int_hook(ib_endport_manage_subnet, 0, sec,
+			     dev_name, port_num);
 }
 EXPORT_SYMBOL(security_ib_endport_manage_subnet);
 
@@ -4716,7 +4735,6 @@ EXPORT_SYMBOL(security_ib_free_security);
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
-
 /**
  * security_xfrm_policy_alloc() - Allocate a xfrm policy LSM blob
  * @ctxp: xfrm security context being added to the SPD
@@ -4747,7 +4765,7 @@ EXPORT_SYMBOL(security_xfrm_policy_alloc);
  * Return: Return 0 if operation was successful.
  */
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
-			      struct xfrm_sec_ctx **new_ctxp)
+			       struct xfrm_sec_ctx **new_ctxp)
 {
 	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
 }
@@ -4882,7 +4900,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * using the macro
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-				list) {
+			     list) {
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
 		break;
 	}
@@ -4906,16 +4924,14 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
 {
 	int rc = call_int_hook(xfrm_decode_session, 0, skb, &flic->flowic_secid,
-				0);
+			       0);
 
 	BUG_ON(rc);
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
-
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
 #ifdef CONFIG_KEYS
-
 /**
  * security_key_alloc() - Allocate and initialize a kernel key LSM blob
  * @key: key
@@ -4978,11 +4994,9 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 	*_buffer = NULL;
 	return call_int_hook(key_getsecurity, 0, key, _buffer);
 }
-
 #endif	/* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-
 /**
  * security_audit_rule_init() - Allocate and init an LSM audit rule struct
  * @field: audit action
-- 
2.39.2

