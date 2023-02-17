Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD3DC05027
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBQD0n (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBQD0g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:36 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90E4FC80
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id l4so25307qvv.7
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFhzhMwXRsw9I0hVZBlgcO+UcUqnkJD5EF5OksFeIRc=;
        b=P4uOlthVBSJLAZ+aCFwobTbDeObkv37moxeVE4F5Bc3GQiFKreD1LHxQU2wMtrSfv0
         MkmW3xvbwwGCjBpXNO4ufzxPcYFwo8sGY/jnLPNkG4t54ZPGPWmEJcy+XmhqEhi8xmse
         RJAp95kyMnTyX1U38URuJvQZil88cdA1P2Rtq3TuH1/InDHJYm04xcPVaZj6tvlR+uEN
         C9B2OvehNzdhF5Qlr+v2lQssCQFZjGzw5IJbB2mXsOh2JagQ8W/5iPG4accMpVjWZ7ah
         kl9MfVdI24EAGvQn4gU6zRfddWDVOHEKJRFi6cY0Bx2TEpqzZn+UDIDSmAp+jCB4eTG6
         Ux2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFhzhMwXRsw9I0hVZBlgcO+UcUqnkJD5EF5OksFeIRc=;
        b=RN/9idlcdAr0dJGEm1pGF1xMiqb4Vm7krfHbKQKnLEq4HsjsCiFfsem0v/mfWt9FJr
         WOL4sjTU+dGw1QdLXaGKf+vPHBPRvsdzsex/+SgIKvrI5/ynI2EbJBDyrp9J/N03vPWk
         fJQCPRUDFsXxl0I7YXtITuKB50uDx7LaHDrX7rewiC/DRex3Ndr62o7bDPZJU2LshIwQ
         kKJ0j8YVFEQDerjda/WJO9HLDn4Ttamlr4nviH444JZdx2WxSwxmqX/991ZYn7Q/O93g
         B009TjzeDm+yP90cpz48wvC8lvituBIvQrnqjlTpDzDyeY60+ORr70Vw22RcK1ku3ZIY
         Y9VQ==
X-Gm-Message-State: AO0yUKUUwqAKGHtaWu35e8wr6RyCHZkFAYnsKjaGqSy+VQsbHvqR6DHu
        bfaLQ6ONEc7IGiuDZB1lT+JOBXyw4htPY5M=
X-Google-Smtp-Source: AK7set/m661ZlR3DNZZlesIP26GzIslpK9FwqDSvtu1dPRRdAbgUWmLCWRHra/XumKFbkppuGurZvQ==
X-Received: by 2002:a05:6214:411b:b0:56b:7cb:bdcd with SMTP id kc27-20020a056214411b00b0056b07cbbdcdmr15993048qvb.39.1676604392617;
        Thu, 16 Feb 2023 19:26:32 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id d127-20020ae9ef85000000b0073ba92629e1sm577179qkg.23.2023.02.16.19.26.31
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:32 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 03/22] lsm: move the filesystem hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:06 -0500
Message-Id: <20230217032625.678457-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 106 ----------------------
 security/security.c       | 181 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 106 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84afd93b878f..04ab591a7e2b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,112 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for filesystem operations.
- *
- * @sb_alloc_security:
- *	Allocate and attach a security structure to the sb->s_security field.
- *	The s_security field is initialized to NULL when the structure is
- *	allocated.
- *	@sb contains the super_block structure to be modified.
- *	Return 0 if operation was successful.
- * @sb_delete:
- *	Release objects tied to a superblock (e.g. inodes).
- *	@sb contains the super_block structure being released.
- * @sb_free_security:
- *	Deallocate and clear the sb->s_security field.
- *	@sb contains the super_block structure to be modified.
- * @sb_free_mnt_opts:
- * 	Free memory associated with @mnt_ops.
- * @sb_eat_lsm_opts:
- * 	Eat (scan @orig options) and save them in @mnt_opts.
- *	Return 0 on success, negative values on failure.
- * @sb_statfs:
- *	Check permission before obtaining filesystem statistics for the @mnt
- *	mountpoint.
- *	@dentry is a handle on the superblock for the filesystem.
- *	Return 0 if permission is granted.
- * @sb_mount:
- *	Check permission before an object specified by @dev_name is mounted on
- *	the mount point named by @nd.  For an ordinary mount, @dev_name
- *	identifies a device if the file system type requires a device.  For a
- *	remount (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a
- *	loopback/bind mount (@flags & MS_BIND), @dev_name identifies the
- *	pathname of the object being mounted.
- *	@dev_name contains the name for object being mounted.
- *	@path contains the path for mount point object.
- *	@type contains the filesystem type.
- *	@flags contains the mount flags.
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_mnt_opts_compat:
- *	Determine if the new mount options in @mnt_opts are allowed given
- *	the existing mounted filesystem at @sb.
- *	@sb superblock being compared.
- *	@mnt_opts new mount options.
- *	Return 0 if options are compatible.
- * @sb_remount:
- *	Extracts security system specific mount options and verifies no changes
- *	are being made to those options.
- *	@sb superblock being remounted.
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_kern_mount:
- *	Mount this @sb if allowed by permissions.
- *	Return 0 if permission is granted.
- * @sb_show_options:
- * 	Show (print on @m) mount options for this @sb.
- *	Return 0 on success, negative values on failure.
- * @sb_umount:
- *	Check permission before the @mnt file system is unmounted.
- *	@mnt contains the mounted file system.
- *	@flags contains the unmount flags, e.g. MNT_FORCE.
- *	Return 0 if permission is granted.
- * @sb_pivotroot:
- *	Check permission before pivoting the root filesystem.
- *	@old_path contains the path for the new location of the
- *	current root (put_old).
- *	@new_path contains the path for the new root (new_root).
- *	Return 0 if permission is granted.
- * @sb_set_mnt_opts:
- *	Set the security relevant mount options used for a superblock
- *	@sb the superblock to set security mount options for.
- *	@opts binary data structure containing all lsm mount data.
- *	Return 0 on success, error on failure.
- * @sb_clone_mnt_opts:
- *	Copy all security options from a given superblock to another
- *	@oldsb old superblock which contain information to clone.
- *	@newsb new superblock which needs filled in.
- *	Return 0 on success, error on failure.
- * @move_mount:
- *	Check permission before a mount is moved.
- *	@from_path indicates the mount that is going to be moved.
- *	@to_path indicates the mountpoint that will be mounted upon.
- *	Return 0 if permission is granted.
- * @dentry_init_security:
- *	Compute a context for a dentry as the inode is not yet available
- *	since NFSv4 has no label backed by an EA anyway.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file.
- *	@xattr_name pointer to place the pointer to security xattr name.
- *		    Caller does not have to free the resulting pointer. Its
- *		    a pointer to static string.
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
- *	Return 0 on success, negative values on failure.
- * @dentry_create_files_as:
- *	Compute a context for a dentry as the inode is not yet available
- *	and set that context in passed in creds so that new files are
- *	created using that context. Context is calculated using the
- *	passed in creds and not the creds of the caller.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file.
- *	@old creds which should be used for context calculation.
- *	@new creds to modify.
- *	Return 0 on success, error on failure.
- *
- *
  * Security hooks for inode operations.
  *
  * @inode_alloc_security:
diff --git a/security/security.c b/security/security.c
index 3170df73a7cd..0ded74f5450b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1025,6 +1025,16 @@ int security_fs_context_parse_param(struct fs_context *fc,
 	return rc;
 }
 
+/**
+ * security_sb_alloc() - Allocate a super_block LSM blob
+ * @sb: filesystem superblock
+ *
+ * Allocate and attach a security structure to the sb->s_security field.  The
+ * s_security field is initialized to NULL when the structure is allocated.
+ * @sb contains the super_block structure to be modified.
+ *
+ * Return: Returns 0 if operation was successful.
+ */
 int security_sb_alloc(struct super_block *sb)
 {
 	int rc = lsm_superblock_alloc(sb);
@@ -1037,11 +1047,25 @@ int security_sb_alloc(struct super_block *sb)
 	return rc;
 }
 
+/**
+ * security_sb_delete() - Release super_block LSM associated objects
+ * @sb: filesystem superblock
+ *
+ * Release objects tied to a superblock (e.g. inodes).  @sb contains the
+ * super_block structure being released.
+ */
 void security_sb_delete(struct super_block *sb)
 {
 	call_void_hook(sb_delete, sb);
 }
 
+/**
+ * security_sb_free() - Free a super_block LSM blob
+ * @sb: filesystem superblock
+ *
+ * Deallocate and clear the sb->s_security field.  @sb contains the super_block
+ * structure to be modified.
+ */
 void security_sb_free(struct super_block *sb)
 {
 	call_void_hook(sb_free_security, sb);
@@ -1049,6 +1073,12 @@ void security_sb_free(struct super_block *sb)
 	sb->s_security = NULL;
 }
 
+/**
+ * security_free_mnt_opts() - Free memory associated with mount options
+ * @mnt_ops: LSM processed mount options
+ *
+ * Free memory associated with @mnt_ops.
+ */
 void security_free_mnt_opts(void **mnt_opts)
 {
 	if (!*mnt_opts)
@@ -1058,12 +1088,31 @@ void security_free_mnt_opts(void **mnt_opts)
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
 
+/**
+ * security_sb_eat_lsm_opts() - Consume LSM mount options
+ * @options: mount options
+ * @mnt_ops: LSM processed mount options
+ *
+ * Eat (scan @options) and save them in @mnt_opts.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
 	return call_int_hook(sb_eat_lsm_opts, 0, options, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
 
+/**
+ * security_sb_mnt_opts_compat() - Check if new mount options are allowed
+ * @sb: filesystem superblock
+ * @mnt_opts: new mount options
+ *
+ * Determine if the new mount options in @mnt_opts are allowed given the
+ * existing mounted filesystem at @sb.  @sb superblock being compared.
+ *
+ * Return: Returns 0 if options are compatible.
+ */
 int security_sb_mnt_opts_compat(struct super_block *sb,
 				void *mnt_opts)
 {
@@ -1071,6 +1120,16 @@ int security_sb_mnt_opts_compat(struct super_block *sb,
 }
 EXPORT_SYMBOL(security_sb_mnt_opts_compat);
 
+/**
+ * security_sb_remount() - Verify no incompatible mount changes during remount
+ * @sb: filesystem superblock
+ * @mnt_opts: (re)mount options
+ *
+ * Extracts security system specific mount options and verifies no changes are
+ * being made to those options.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_remount(struct super_block *sb,
 			void *mnt_opts)
 {
@@ -1078,37 +1137,109 @@ int security_sb_remount(struct super_block *sb,
 }
 EXPORT_SYMBOL(security_sb_remount);
 
+/**
+ * security_sb_kern_mount() - Check if a kernel mount is allowed
+ * @sb: filesystem superblock
+ *
+ * Mount this @sb if allowed by permissions.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_kern_mount(struct super_block *sb)
 {
 	return call_int_hook(sb_kern_mount, 0, sb);
 }
 
+/**
+ * security_sb_show_options() - Output the mount options for a superblock
+ * @m: output file
+ * @sb: filesystem superblock
+ *
+ * Show (print on @m) mount options for this @sb.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
 	return call_int_hook(sb_show_options, 0, m, sb);
 }
 
+/**
+ * security_sb_statfs() - Check if accessing fs stats is allowed
+ * @dentry: superblock handle
+ *
+ * Check permission before obtaining filesystem statistics for the @mnt
+ * mountpoint.  @dentry is a handle on the superblock for the filesystem.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_statfs(struct dentry *dentry)
 {
 	return call_int_hook(sb_statfs, 0, dentry);
 }
 
+/**
+ * security_sb_mount() - Check permission for mounting a filesystem
+ * @dev_name: filesystem backing device
+ * @path: mount point
+ * @type: filesystem type
+ * @flags: mount flags
+ * @data: filesystem specific data
+ *
+ * Check permission before an object specified by @dev_name is mounted on the
+ * mount point named by @nd.  For an ordinary mount, @dev_name identifies a
+ * device if the file system type requires a device.  For a remount
+ * (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a loopback/bind mount
+ * (@flags & MS_BIND), @dev_name identifies the	pathname of the object being
+ * mounted.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_mount(const char *dev_name, const struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
 	return call_int_hook(sb_mount, 0, dev_name, path, type, flags, data);
 }
 
+/**
+ * security_sb_umount() - Check permission for unmounting a filesystem
+ * @mnt: mounted filesystem
+ * @flags: unmount flags
+ *
+ * Check permission before the @mnt file system is unmounted.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
 	return call_int_hook(sb_umount, 0, mnt, flags);
 }
 
+/**
+ * security_sb_pivotroot() - Check permissions for pivoting the rootfs
+ * @old_path: new location for current rootfs
+ * @new_path: location of the new rootfs
+ *
+ * Check permission before pivoting the root filesystem.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_sb_pivotroot(const struct path *old_path, const struct path *new_path)
 {
 	return call_int_hook(sb_pivotroot, 0, old_path, new_path);
 }
 
+/**
+ * security_sb_set_mnt_opts() - Set the mount options for a filesystem
+ * @sb: filesystem superblock
+ * @mnt_opts: binary mount options
+ * @kern_flags: kernel flags (in)
+ * @set_kern_flags: kernel flags (out)
+ *
+ * Set the security relevant mount options used for a superblock.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sb_set_mnt_opts(struct super_block *sb,
 				void *mnt_opts,
 				unsigned long kern_flags,
@@ -1120,6 +1251,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
+/**
+ * security_sb_clone_mnt_opts() - Duplicate superblock mount options
+ * @olddb: source superblock
+ * @newdb: destination superblock
+ * @kern_flags: kernel flags (in)
+ * @set_kern_flags: kernel flags (out)
+ *
+ * Copy all security options from a given superblock to another.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb,
 				unsigned long kern_flags,
@@ -1130,6 +1272,15 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
+/**
+ * security_move_mount() - Check permissions for moving a mount
+ * @from_path: source mount point
+ * @to_path: destination mount point
+ *
+ * Check permission before a mount is moved.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
@@ -1179,6 +1330,21 @@ void security_inode_free(struct inode *inode)
 				inode_free_by_rcu);
 }
 
+/**
+ * security_dentry_init_security() - Perform dentry initialization
+ * @dentry: the dentry to initialize
+ * @mode: mode used to determine resource type
+ * @name: name of the last path component
+ * @xattr_name: name of the security/LSM xattr
+ * @ctx: pointer to the resulting LSM context
+ * @ctxlen: length of @ctx
+ *
+ * Compute a context for a dentry as the inode is not yet available since NFSv4
+ * has no label backed by an EA anyway.  It is important to note that
+ * @xattr_name does not need to be free'd by the caller, it is a static string.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
 				  const char **xattr_name, void **ctx,
@@ -1200,6 +1366,21 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
+/**
+ * security_dentry_create_files_as() - Perform dentry initialization
+ * @dentry: the dentry to initialize
+ * @mode: mode used to determine resource type
+ * @name: name of the last path component
+ * @old: creds to use for LSM context calculations
+ * @new: creds to modify
+ *
+ * Compute a context for a dentry as the inode is not yet available and set
+ * that context in passed in creds so that new files are created using that
+ * context. Context is calculated using the passed in creds and not the creds
+ * of the caller.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 				    struct qstr *name,
 				    const struct cred *old, struct cred *new)
-- 
2.39.2

