Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3968C64EC4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBQD0p (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjBQD0n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:43 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D9B54D07
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:36 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b21so4247497qtr.13
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0lo3B9/QeQZeoOIGnka1zfsAIgh7trEh53zLCE3Y5g=;
        b=Elp5F+ORipYZu+MsFMqqtTklQmHaDUvbhz89D46Dd3zkIgE/W0CgSWKvHVx20qgHqm
         oDOfkivDRqf8gJWvkvWdRb+SrWDiWNYSMt86hRloT+UBbZ+PSg4sRZGfr4yofL8rvKhA
         cbMJyVGFp9Z8z/uHGypdspwgiZVFoeMPdOcSUB9iSvctgQCKg/Nt+/cZLNWm6h628Cd5
         MTy1BeqvwPw2bV1+HmrEyoOHzy1GsQVbzG4H5Gdr/0W+ESw+LdZ45tPwveOuRqKma+Cw
         bXgSMHXagJXxR1TNB89yWCQwyiqijW+UymSK90cTpwIJBLiczJfhJZZoAW9BUbl9aVMJ
         aDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0lo3B9/QeQZeoOIGnka1zfsAIgh7trEh53zLCE3Y5g=;
        b=GEbgb4URxAJE9h6s2X9lnGnLYjMUkWZPsGbLef2fmi8UaN+vOawAwsE2e2jzn3clS+
         GA3+MNPs00XBf/euIvQlmhqkRch9REOfLoOzDOoGXd8RWZO8wo3Bed+t7RfNk4i26gjN
         u1MHGPidLvVzLks8OhEowKRLnyRyM6u6QcUoAo1b++k4KRn0A0TPLYqTRHynQPdL8+0P
         oKBJ9dU6xWM/H3PAjkvmjS+8t1/D46tvly9YCuQ1HYxlrSYwQ7S5JLwYo1aKJ5HA7D93
         MS57gvGX/Lt5KQHuWdYNL6yVgdf4xOZOqFQyXIZtAoBv22PRN8E8xUbamAVeLmvhteOi
         7XqA==
X-Gm-Message-State: AO0yUKUhjDEIipt0J6ZpxaAe/NUPxJIle4+gLXLNIvblxXl8KQSsJGBR
        mcKZevzdPrPJBX2/lcnCAFgtwMjy0fvO5bE=
X-Google-Smtp-Source: AK7set/oKoNiu4drs/tSOVlFOtQMvUXcdrizRrGzmxAZwVISHQJsfnI7CaJHv3Hl6NAXBskEwv6ADg==
X-Received: by 2002:a05:622a:307:b0:3b8:6cb0:8d18 with SMTP id q7-20020a05622a030700b003b86cb08d18mr13899954qtw.5.1676604394013;
        Thu, 16 Feb 2023 19:26:34 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id l28-20020ac8459c000000b003b9bf862c04sm2548778qtn.55.2023.02.16.19.26.33
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:33 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 04/22] lsm: move the inode hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:07 -0500
Message-Id: <20230217032625.678457-5-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h | 303 ----------------------
 security/security.c       | 524 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 524 insertions(+), 303 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 04ab591a7e2b..3cdd58424796 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,309 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for inode operations.
- *
- * @inode_alloc_security:
- *	Allocate and attach a security structure to @inode->i_security.  The
- *	i_security field is initialized to NULL when the inode structure is
- *	allocated.
- *	@inode contains the inode structure.
- *	Return 0 if operation was successful.
- * @inode_free_security:
- *	@inode contains the inode structure.
- *	Deallocate the inode security structure and set @inode->i_security to
- *	NULL.
- * @inode_init_security:
- *	Obtain the security attribute name suffix and value to set on a newly
- *	created inode and set up the incore security field for the new inode.
- *	This hook is called by the fs code as part of the inode creation
- *	transaction and provides for atomic labeling of the inode, unlike
- *	the post_create/mkdir/... hooks called by the VFS.  The hook function
- *	is expected to allocate the name and value via kmalloc, with the caller
- *	being responsible for calling kfree after using them.
- *	If the security module does not use security attributes or does
- *	not wish to put a security attribute on this particular inode,
- *	then it should return -EOPNOTSUPP to skip this processing.
- *	@inode contains the inode structure of the newly created inode.
- *	@dir contains the inode structure of the parent directory.
- *	@qstr contains the last path component of the new object.
- *	@name will be set to the allocated name suffix (e.g. selinux).
- *	@value will be set to the allocated attribute value.
- *	@len will be set to the length of the value.
- *	Returns 0 if @name and @value have been successfully set,
- *	-EOPNOTSUPP if no security attribute is needed, or
- *	-ENOMEM on memory allocation failure.
- * @inode_init_security_anon:
- *      Set up the incore security field for the new anonymous inode
- *      and return whether the inode creation is permitted by the security
- *      module or not.
- *      @inode contains the inode structure.
- *      @name name of the anonymous inode class.
- *      @context_inode optional related inode.
- *	Returns 0 on success, -EACCES if the security module denies the
- *	creation of this inode, or another -errno upon other errors.
- * @inode_create:
- *	Check permission to create a regular file.
- *	@dir contains inode structure of the parent of the new file.
- *	@dentry contains the dentry structure for the file to be created.
- *	@mode contains the file mode of the file to be created.
- *	Return 0 if permission is granted.
- * @inode_link:
- *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing
- *	link to the file.
- *	@dir contains the inode structure of the parent directory
- *	of the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @path_link:
- *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing link
- *	to the file.
- *	@new_dir contains the path structure of the parent directory of
- *	the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @inode_unlink:
- *	Check the permission to remove a hard link to a file.
- *	@dir contains the inode structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @path_unlink:
- *	Check the permission to remove a hard link to a file.
- *	@dir contains the path structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @inode_symlink:
- *	Check the permission to create a symbolic link to a file.
- *	@dir contains the inode structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @path_symlink:
- *	Check the permission to create a symbolic link to a file.
- *	@dir contains the path structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @inode_mkdir:
- *	Check permissions to create a new directory in the existing directory
- *	associated with inode structure @dir.
- *	@dir contains the inode structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @path_mkdir:
- *	Check permissions to create a new directory in the existing directory
- *	associated with path structure @path.
- *	@dir contains the path structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @inode_rmdir:
- *	Check the permission to remove a directory.
- *	@dir contains the inode structure of parent of the directory
- *	to be removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @path_rmdir:
- *	Check the permission to remove a directory.
- *	@dir contains the path structure of parent of the directory to be
- *	removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @inode_mknod:
- *	Check permissions when creating a special file (or a socket or a fifo
- *	file created via the mknod system call).  Note that if mknod operation
- *	is being done for a regular file, then the create hook will be called
- *	and not this hook.
- *	@dir contains the inode structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the device number.
- *	Return 0 if permission is granted.
- * @path_mknod:
- *	Check permissions when creating a file. Note that this hook is called
- *	even if mknod operation is being done for a regular file.
- *	@dir contains the path structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the undecoded device number. Use new_decode_dev() to get
- *	the decoded device number.
- *	Return 0 if permission is granted.
- * @inode_rename:
- *	Check for permission to rename a file or directory.
- *	@old_dir contains the inode structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the inode structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	Return 0 if permission is granted.
- * @path_rename:
- *	Check for permission to rename a file or directory.
- *	@old_dir contains the path structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the path structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	@flags may contain rename options such as RENAME_EXCHANGE.
- *	Return 0 if permission is granted.
- * @path_chmod:
- *	Check for permission to change a mode of the file @path. The new
- *	mode is specified in @mode.
- *	@path contains the path structure of the file to change the mode.
- *	@mode contains the new DAC's permission, which is a bitmask of
- *	constants from <include/uapi/linux/stat.h>.
- *	Return 0 if permission is granted.
- * @path_chown:
- *	Check for permission to change owner/group of a file or directory.
- *	@path contains the path structure.
- *	@uid contains new owner's ID.
- *	@gid contains new group's ID.
- *	Return 0 if permission is granted.
- * @path_chroot:
- *	Check for permission to change root directory.
- *	@path contains the path structure.
- *	Return 0 if permission is granted.
- * @path_notify:
- *	Check permissions before setting a watch on events as defined by @mask,
- *	on an object at @path, whose type is defined by @obj_type.
- *	Return 0 if permission is granted.
- * @inode_readlink:
- *	Check the permission to read the symbolic link.
- *	@dentry contains the dentry structure for the file link.
- *	Return 0 if permission is granted.
- * @inode_follow_link:
- *	Check permission to follow a symbolic link when looking up a pathname.
- *	@dentry contains the dentry structure for the link.
- *	@inode contains the inode, which itself is not stable in RCU-walk.
- *	@rcu indicates whether we are in RCU-walk mode.
- *	Return 0 if permission is granted.
- * @inode_permission:
- *	Check permission before accessing an inode.  This hook is called by the
- *	existing Linux permission function, so a security module can use it to
- *	provide additional checking for existing Linux permission checks.
- *	Notice that this hook is called when a file is opened (as well as many
- *	other operations), whereas the file_security_ops permission hook is
- *	called when the actual read/write operations are performed.
- *	@inode contains the inode structure to check.
- *	@mask contains the permission mask.
- *	Return 0 if permission is granted.
- * @inode_setattr:
- *	Check permission before setting file attributes.  Note that the kernel
- *	call to notify_change is performed from several locations, whenever
- *	file attributes change (such as when a file is truncated, chown/chmod
- *	operations, transferring disk quotas, etc).
- *	@dentry contains the dentry structure for the file.
- *	@attr is the iattr structure containing the new file attributes.
- *	Return 0 if permission is granted.
- * @path_truncate:
- *	Check permission before truncating the file indicated by path.
- *	Note that truncation permissions may also be checked based on
- *	already opened files, using the @file_truncate hook.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_getattr:
- *	Check permission before obtaining file attributes.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_setxattr:
- *	Check permission before setting the extended attributes
- *	@value identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_post_setxattr:
- *	Update inode security field after successful setxattr operation.
- *	@value identified by @name for @dentry.
- * @inode_getxattr:
- *	Check permission before obtaining the extended attributes
- *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_listxattr:
- *	Check permission before obtaining the list of extended attribute
- *	names for @dentry.
- *	Return 0 if permission is granted.
- * @inode_removexattr:
- *	Check permission before removing the extended attribute
- *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_set_acl:
- *	Check permission before setting posix acls
- *	The posix acls in @kacl are identified by @acl_name.
- *	Return 0 if permission is granted.
- * @inode_get_acl:
- *	Check permission before getting osix acls
- *	The posix acls are identified by @acl_name.
- *	Return 0 if permission is granted.
- * @inode_remove_acl:
- *	Check permission before removing posix acls
- *	The posix acls are identified by @acl_name.
- *	Return 0 if permission is granted.
- * @inode_getsecurity:
- *	Retrieve a copy of the extended attribute representation of the
- *	security label associated with @name for @inode via @buffer.  Note that
- *	@name is the remainder of the attribute name after the security prefix
- *	has been removed. @alloc is used to specify if the call should return a
- *	value via the buffer or just the value length.
- *	Return size of buffer on success.
- * @inode_setsecurity:
- *	Set the security label associated with @name for @inode from the
- *	extended attribute value @value.  @size indicates the size of the
- *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
- *	Note that @name is the remainder of the attribute name after the
- *	security. prefix has been removed.
- *	Return 0 on success.
- * @inode_listsecurity:
- *	Copy the extended attribute names for the security labels
- *	associated with @inode into @buffer.  The maximum size of @buffer
- *	is specified by @buffer_size.  @buffer may be NULL to request
- *	the size of the buffer required.
- *	Returns number of bytes used/required on success.
- * @inode_need_killpriv:
- *	Called when an inode has been changed.
- *	@dentry is the dentry being changed.
- *	Return <0 on error to abort the inode change operation.
- *	Return 0 if inode_killpriv does not need to be called.
- *	Return >0 if inode_killpriv does need to be called.
- * @inode_killpriv:
- *	The setuid bit is being removed.  Remove similar security labels.
- *	Called with the dentry->d_inode->i_mutex held.
- *	@mnt_userns: user namespace of the mount.
- *	@dentry is the dentry being changed.
- *	Return 0 on success.  If error is returned, then the operation
- *	causing setuid bit removal is failed.
- * @inode_getsecid:
- *	Get the secid associated with the node.
- *	@inode contains a pointer to the inode.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
- * @inode_copy_up:
- *	A file is about to be copied up from lower layer to upper layer of
- *	overlay filesystem. Security module can prepare a set of new creds
- *	and modify as need be and return new creds. Caller will switch to
- *	new creds temporarily to create new file and release newly allocated
- *	creds.
- *	@src indicates the union dentry of file that is being copied up.
- *	@new pointer to pointer to return newly allocated creds.
- *	Returns 0 on success or a negative error code on error.
- * @inode_copy_up_xattr:
- *	Filter the xattrs being copied up when a unioned file is copied
- *	up from a lower layer to the union/overlay layer.
- *	@name indicates the name of the xattr.
- *	Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP if
- *	security module does not know about attribute or a negative error code
- *	to abort the copy up. Note that the caller is responsible for reading
- *	and writing the xattrs as this hook is merely a filter.
- * @d_instantiate:
- *	Fill in @inode security information for a @dentry if allowed.
- * @getprocattr:
- *	Read attribute @name for process @p and store it into @value if allowed.
- *	Return the length of @value on success, a negative value otherwise.
- * @setprocattr:
- *	Write (set) attribute @name to @value, size @size if allowed.
- *	Return written bytes on success, a negative value otherwise.
- *
  * Security hooks for kernfs node operations
  *
  * @kernfs_init_security:
diff --git a/security/security.c b/security/security.c
index 0ded74f5450b..8195f4e7293e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1286,12 +1286,33 @@ int security_move_mount(const struct path *from_path, const struct path *to_path
 	return call_int_hook(move_mount, 0, from_path, to_path);
 }
 
+/**
+ * security_path_notify() - Check if setting a watch is allowed
+ * @path: file path
+ * @mask: event mask
+ * @obj_type: file path type
+ *
+ * Check permissions before setting a watch on events as defined by @mask, on
+ * an object at @path, whose type is defined by @obj_type.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_notify(const struct path *path, u64 mask,
 				unsigned int obj_type)
 {
 	return call_int_hook(path_notify, 0, path, mask, obj_type);
 }
 
+/**
+ * security_inode_alloc() - Allocate an inode LSM blob
+ * @inode: the inode
+ *
+ * Allocate and attach a security structure to @inode->i_security.  The
+ * i_security field is initialized to NULL when the inode structure is
+ * allocated.
+ *
+ * Return: Return 0 if operation was successful.
+ */
 int security_inode_alloc(struct inode *inode)
 {
 	int rc = lsm_inode_alloc(inode);
@@ -1312,6 +1333,12 @@ static void inode_free_by_rcu(struct rcu_head *head)
 	kmem_cache_free(lsm_inode_cache, head);
 }
 
+/**
+ * security_inode_free() - Free an inode's LSM blob
+ * @inode: the inode
+ *
+ * Deallocate the inode security structure and set @inode->i_security to NULL.
+ */
 void security_inode_free(struct inode *inode)
 {
 	integrity_inode_free(inode);
@@ -1390,6 +1417,27 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
 }
 EXPORT_SYMBOL(security_dentry_create_files_as);
 
+/**
+ * security_inode_init_security() - Initialize an inode's LSM context
+ * @inode: the inode
+ * @dir: parent directory
+ * @qstr: last component of the pathname
+ * @initxattrs: callback function to write xattrs
+ * @fs_data: filesystem specific data
+ *
+ * Obtain the security attribute name suffix and value to set on a newly
+ * created inode and set up the incore security field for the new inode.  This
+ * hook is called by the fs code as part of the inode creation transaction and
+ * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
+ * hooks called by the VFS.  The hook function is expected to allocate the name
+ * and value via kmalloc, with the caller being responsible for calling kfree
+ * after using them.  If the security module does not use security attributes
+ * or does not wish to put a security attribute on this particular inode, then
+ * it should return -EOPNOTSUPP to skip this processing.
+ *
+ * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
+ * needed, or -ENOMEM on memory allocation failure.
+ */
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
@@ -1425,6 +1473,18 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+/**
+ * security_inode_init_security_anon() - Initialize an anonymous inode
+ * @inode: the inode
+ * @name: the anonymous inode class
+ * @context_inode: an optional related inode
+ *
+ * Set up the incore security field for the new anonymous inode and return
+ * whether the inode creation is permitted by the security module or not.
+ *
+ * Return: Returns 0 on success, -EACCES if the security module denies the
+ * creation of this inode, or another -errno upon other errors.
+ */
 int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode)
@@ -1445,6 +1505,18 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 EXPORT_SYMBOL(security_old_inode_init_security);
 
 #ifdef CONFIG_SECURITY_PATH
+/**
+ * security_path_mknod() - Check if creating a special file is allowed
+ * @dir: parent directory
+ * @dentry: new file
+ * @mode: new file mode
+ * @dev: device number
+ *
+ * Check permissions when creating a file. Note that this hook is called even
+ * if mknod operation is being done for a regular file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
 {
@@ -1454,6 +1526,16 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t m
 }
 EXPORT_SYMBOL(security_path_mknod);
 
+/**
+ * security_path_mkdir() - Check if creating a new directory is allowed
+ * @dir: parent directory
+ * @dentry: new directory
+ * @mode: new directory mode
+ *
+ * Check permissions to create a new directory in the existing directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
@@ -1462,6 +1544,15 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
+/**
+ * security_path_rmdir() - Check if removing a directory is allowed
+ * @dir: parent directory
+ * @dentry: directory to remove
+ *
+ * Check the permission to remove a directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
@@ -1469,6 +1560,15 @@ int security_path_rmdir(const struct path *dir, struct dentry *dentry)
 	return call_int_hook(path_rmdir, 0, dir, dentry);
 }
 
+/**
+ * security_path_unlink() - Check if removing a hard link is allowed
+ * @dir: parent directory
+ * @dentry: file
+ *
+ * Check the permission to remove a hard link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
@@ -1477,6 +1577,16 @@ int security_path_unlink(const struct path *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(security_path_unlink);
 
+/**
+ * security_path_symlink() - Check if creating a symbolic link is allowed
+ * @dir: parent directory
+ * @dentry: symbolic link
+ * @old_name: file pathname
+ *
+ * Check the permission to create a symbolic link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
@@ -1485,6 +1595,16 @@ int security_path_symlink(const struct path *dir, struct dentry *dentry,
 	return call_int_hook(path_symlink, 0, dir, dentry, old_name);
 }
 
+/**
+ * security_path_link - Check if creating a hard link is allowed
+ * @old_dentry: existing file
+ * @new_dir: new parent directory
+ * @new_dentry: new link
+ *
+ * Check permission before creating a new hard link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 		       struct dentry *new_dentry)
 {
@@ -1493,6 +1613,18 @@ int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
 	return call_int_hook(path_link, 0, old_dentry, new_dir, new_dentry);
 }
 
+/**
+ * security_path_rename() - Check if renaming a file is allowed
+ * @old_dir: parent directory of the old file
+ * @old_dentry: the old file
+ * @new_dir: parent directory of the new file
+ * @new_dentry: the new file
+ * @flags: flags
+ *
+ * Check for permission to rename a file or directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 			 const struct path *new_dir, struct dentry *new_dentry,
 			 unsigned int flags)
@@ -1506,6 +1638,16 @@ int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL(security_path_rename);
 
+/**
+ * security_path_truncate() - Check if truncating a file is allowed
+ * @path: file
+ *
+ * Check permission before truncating the file indicated by path.  Note that
+ * truncation permissions may also be checked based on already opened files,
+ * using the security_file_truncate() hook.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_truncate(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
@@ -1513,6 +1655,17 @@ int security_path_truncate(const struct path *path)
 	return call_int_hook(path_truncate, 0, path);
 }
 
+/**
+ * security_path_chmod() - Check if changing the file's mode is allowed
+ * @path: file
+ * @mode: new mode
+ *
+ * Check for permission to change a mode of the file @path. The new mode is
+ * specified in @mode which is a bitmask of constants from
+ * <include/uapi/linux/stat.h>.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_chmod(const struct path *path, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
@@ -1520,6 +1673,16 @@ int security_path_chmod(const struct path *path, umode_t mode)
 	return call_int_hook(path_chmod, 0, path, mode);
 }
 
+/**
+ * security_path_chown() - Check if changing the file's owner/group is allowed
+ * @path: file
+ * @uid: file owner
+ * @gid: file group
+ *
+ * Check for permission to change owner/group of a file or directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
@@ -1527,12 +1690,30 @@ int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid)
 	return call_int_hook(path_chown, 0, path, uid, gid);
 }
 
+/**
+ * security_path_chroot() - Check if changing the root directory is allowed
+ * @path: directory
+ *
+ * Check for permission to change root directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_path_chroot(const struct path *path)
 {
 	return call_int_hook(path_chroot, 0, path);
 }
 #endif
 
+/**
+ * security_inode_create() - Check if creating a file is allowed
+ * @dir: the parent directory
+ * @dentry: the file being created
+ * @mode: requested file mode
+ *
+ * Check permission to create a regular file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
@@ -1541,6 +1722,16 @@ int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+/**
+ * security_inode_link() - Check if creating a hard link is allowed
+ * @old_dentry: existing file
+ * @dir: new parent directory
+ * @new_dentry: new link
+ *
+ * Check permission before creating a new hard link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
@@ -1549,6 +1740,15 @@ int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 	return call_int_hook(inode_link, 0, old_dentry, dir, new_dentry);
 }
 
+/**
+ * security_inode_unlink() - Check if removing a hard link is allowed
+ * @dir: parent directory
+ * @dentry: file
+ *
+ * Check the permission to remove a hard link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1556,6 +1756,16 @@ int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 	return call_int_hook(inode_unlink, 0, dir, dentry);
 }
 
+/**
+ * security_inode_symlink() Check if creating a symbolic link is allowed
+ * @dir: parent directory
+ * @dentry: symbolic link
+ * @old_name: existing filename
+ *
+ * Check the permission to create a symbolic link to a file.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *old_name)
 {
@@ -1564,6 +1774,17 @@ int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 	return call_int_hook(inode_symlink, 0, dir, dentry, old_name);
 }
 
+/**
+ * security_inode_mkdir() - Check if creation a new director is allowed
+ * @dir: parent directory
+ * @dentry: new directory
+ * @mode: new directory mode
+ *
+ * Check permissions to create a new directory in the existing directory
+ * associated with inode structure @dir.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	if (unlikely(IS_PRIVATE(dir)))
@@ -1572,6 +1793,15 @@ int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
+/**
+ * security_inode_rmdir() - Check if removing a directory is allowed
+ * @dir: parent directory
+ * @dentry: directory to be removed
+ *
+ * Check the permission to remove a directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1579,6 +1809,20 @@ int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 	return call_int_hook(inode_rmdir, 0, dir, dentry);
 }
 
+/**
+ * security_inode_mknod() - Check if creating a special file is allowed
+ * @dir: parent directory
+ * @dentry: new file
+ * @mode: new file mode
+ * @dev: device number
+ *
+ * Check permissions when creating a special file (or a socket or a fifo file
+ * created via the mknod system call).  Note that if mknod operation is being
+ * done for a regular file, then the create hook will be called and not this
+ * hook.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	if (unlikely(IS_PRIVATE(dir)))
@@ -1586,6 +1830,18 @@ int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return call_int_hook(inode_mknod, 0, dir, dentry, mode, dev);
 }
 
+/**
+ * security_inode_rename() - Check if renaming a file is allowed
+ * @old_dir: parent directory of the old file
+ * @old_dentry: the old file
+ * @new_dir: parent directory of the new file
+ * @new_dentry: the new file
+ * @flags: flags
+ *
+ * Check for permission to rename a file or directory.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
@@ -1605,6 +1861,14 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 					   new_dir, new_dentry);
 }
 
+/**
+ * security_inode_readlink() - Check if reading a symbolic link is allowed
+ * @dentry: link
+ *
+ * Check the permission to read the symbolic link.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_readlink(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1612,6 +1876,17 @@ int security_inode_readlink(struct dentry *dentry)
 	return call_int_hook(inode_readlink, 0, dentry);
 }
 
+/**
+ * security_inode_follow_link() - Check if following a symbolic link is allowed
+ * @dentry: link dentry
+ * @inode: link inode
+ * @rcu: true if in RCU-walk mode
+ *
+ * Check permission to follow a symbolic link when looking up a pathname.  If
+ * @rcu is true, @inode is not stable.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 			       bool rcu)
 {
@@ -1620,6 +1895,20 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	return call_int_hook(inode_follow_link, 0, dentry, inode, rcu);
 }
 
+/**
+ * security_inode_permission() - Check if accessing an inode is allowed
+ * @inode: inode
+ * @mask: access mask
+ *
+ * Check permission before accessing an inode.  This hook is called by the
+ * existing Linux permission function, so a security module can use it to
+ * provide additional checking for existing Linux permission checks.  Notice
+ * that this hook is called when a file is opened (as well as many other
+ * operations), whereas the file_security_ops permission hook is called when
+ * the actual read/write operations are performed.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_permission(struct inode *inode, int mask)
 {
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1627,6 +1916,19 @@ int security_inode_permission(struct inode *inode, int mask)
 	return call_int_hook(inode_permission, 0, inode, mask);
 }
 
+/**
+ * security_inode_setattr() - Check if setting file attributes is allowed
+ * @mnt_userns: user namespace
+ * @dentry: file
+ * @attr: new attributes
+ *
+ * Check permission before setting file attributes.  Note that the kernel call
+ * to notify_change is performed from several locations, whenever file
+ * attributes change (such as when a file is truncated, chown/chmod operations,
+ * transferring disk quotas, etc).
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_setattr(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct iattr *attr)
 {
@@ -1641,6 +1943,14 @@ int security_inode_setattr(struct user_namespace *mnt_userns,
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
+/**
+ * security_inode_getattr() - Check if getting file attributes is allowed
+ * @path: file
+ *
+ * Check permission before obtaining file attributes.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_getattr(const struct path *path)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(path->dentry))))
@@ -1648,6 +1958,18 @@ int security_inode_getattr(const struct path *path)
 	return call_int_hook(inode_getattr, 0, path);
 }
 
+/**
+ * security_inode_setxattr() - Check if setting file xattrs is allowed
+ * @mnt_userns: user namespace
+ * @dentry: file
+ * @name: xattr name
+ * @value: xattr value
+ * @flags: flags
+ *
+ * Check permission before setting the extended attributes.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_setxattr(struct user_namespace *mnt_userns,
 			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
@@ -1673,6 +1995,18 @@ int security_inode_setxattr(struct user_namespace *mnt_userns,
 	return evm_inode_setxattr(mnt_userns, dentry, name, value, size);
 }
 
+/**
+ * security_inode_set_acl() - Check if setting posix acls is allowed
+ * @mnt_userns: user namespace
+ * @dentry: file
+ * @acl_name: acl name
+ * @kacl: acl struct
+ *
+ * Check permission before setting posix acls, the posix acls in @kacl are
+ * identified by @acl_name.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_set_acl(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl)
@@ -1691,6 +2025,17 @@ int security_inode_set_acl(struct user_namespace *mnt_userns,
 	return evm_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
 }
 
+/**
+ * security_inode_get_acl() - Check if reading posix acls is allowed
+ * @mnt_userns: user namespace
+ * @dentry: file
+ * @acl_name: acl name
+ *
+ * Check permission before getting osix acls, the posix acls are identified by
+ * @acl_name.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_get_acl(struct user_namespace *mnt_userns,
 			   struct dentry *dentry, const char *acl_name)
 {
@@ -1699,6 +2044,17 @@ int security_inode_get_acl(struct user_namespace *mnt_userns,
 	return call_int_hook(inode_get_acl, 0, mnt_userns, dentry, acl_name);
 }
 
+/**
+ * security_inode_remove_acl() - Check if removing a posix acl is allowed
+ * @mnt_userns: user namesapce
+ * @dentry: file
+ * @acl_name: acl name
+ *
+ * Check permission before removing posix acls, the posix acls are identified
+ * by @acl_name.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_remove_acl(struct user_namespace *mnt_userns,
 			      struct dentry *dentry, const char *acl_name)
 {
@@ -1715,6 +2071,16 @@ int security_inode_remove_acl(struct user_namespace *mnt_userns,
 	return evm_inode_remove_acl(mnt_userns, dentry, acl_name);
 }
 
+/**
+ * security_inode_post_setxattr() - Update the inode after a setxattr operation
+ * @dentry: file
+ * @name: xattr name
+ * @value: xattr value
+ * @size: xattr value size
+ * @flags: flags
+ *
+ * Update inode security field after successful setxattr operation.
+ */
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
@@ -1724,6 +2090,16 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
+/**
+ * security_inode_getxattr() - Check if xattr access is allowed
+ * @dentry: file
+ * @name: xattr name
+ *
+ * Check permission before obtaining the extended attributes identified by
+ * @name for @dentry.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1731,6 +2107,15 @@ int security_inode_getxattr(struct dentry *dentry, const char *name)
 	return call_int_hook(inode_getxattr, 0, dentry, name);
 }
 
+/**
+ * security_inode_listxattr() - Check if listing xattrs is allowed
+ * @dentry: file
+ *
+ * Check permission before obtaining the list of extended attribute names for
+ * @dentry.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_listxattr(struct dentry *dentry)
 {
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
@@ -1738,6 +2123,17 @@ int security_inode_listxattr(struct dentry *dentry)
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
 
+/**
+ * security_inode_removexattr() - Check if removing an xattr is allowed
+ * @mnt_userns: user namespace
+ * @dentry: file
+ * @name: xattr name
+ *
+ * Check permission before removing the extended attribute identified by @name
+ * for @dentry.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_inode_removexattr(struct user_namespace *mnt_userns,
 			       struct dentry *dentry, const char *name)
 {
@@ -1760,17 +2156,55 @@ int security_inode_removexattr(struct user_namespace *mnt_userns,
 	return evm_inode_removexattr(mnt_userns, dentry, name);
 }
 
+/**
+ * security_inode_need_killpriv() - Check if security_inode_killpriv() required
+ * @dentry: associated dentry
+ *
+ * Called when an inode has been changed to determine if
+ * security_inode_killpriv() should be called.
+ *
+ * Return: Return <0 on error to abort the inode change operation, return 0 if
+ *         security_inode_killpriv() does not need to be called, return >0 if
+ *         security_inode_killpriv() does need to be called.
+ */
 int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return call_int_hook(inode_need_killpriv, 0, dentry);
 }
 
+/**
+ * security_inode_killpriv() - The setuid bit is removed, update LSM state
+ * @mnt_userns: user namespace
+ * @dentry: associated dentry
+ *
+ * The @dentry's setuid bit is being removed.  Remove similar security labels.
+ * Called with the dentry->d_inode->i_mutex held.
+ *
+ * Return: Return 0 on success.  If error is returned, then the operation
+ *         causing setuid bit removal is failed.
+ */
 int security_inode_killpriv(struct user_namespace *mnt_userns,
 			    struct dentry *dentry)
 {
 	return call_int_hook(inode_killpriv, 0, mnt_userns, dentry);
 }
 
+/**
+ * security_inode_getsecurity() - Get the xattr security label of an inode
+ * @mnt_userns: user namespace
+ * @inode: inode
+ * @name: xattr name
+ * @buffer: security label buffer
+ * @alloc: allocation flag
+ *
+ * Retrieve a copy of the extended attribute representation of the security
+ * label associated with @name for @inode via @buffer.  Note that @name is the
+ * remainder of the attribute name after the security prefix has been removed.
+ * @alloc is used to specify if the call should return a value via the buffer
+ * or just the value length.
+ *
+ * Return: Returns size of buffer on success.
+ */
 int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       struct inode *inode, const char *name,
 			       void **buffer, bool alloc)
@@ -1791,6 +2225,21 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 	return LSM_RET_DEFAULT(inode_getsecurity);
 }
 
+/**
+ * security_inode_setsecurity() - Set the xattr security label of an inode
+ * @inode: inode
+ * @name: xattr name
+ * @value: security label
+ * @size: length of security label
+ * @flags: flags
+ *
+ * Set the security label associated with @name for @inode from the extended
+ * attribute value @value.  @size indicates the size of the @value in bytes.
+ * @flags may be XATTR_CREATE, XATTR_REPLACE, or 0. Note that @name is the
+ * remainder of the attribute name after the security. prefix has been removed.
+ *
+ * Return: Returns 0 on success.
+ */
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
 	struct security_hook_list *hp;
@@ -1810,6 +2259,19 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 	return LSM_RET_DEFAULT(inode_setsecurity);
 }
 
+/**
+ * security_inode_listsecurity() - List the xattr security label names
+ * @inode: inode
+ * @buffer: buffer
+ * @buffer_size: size of buffer
+ *
+ * Copy the extended attribute names for the security labels associated with
+ * @inode into @buffer.  The maximum size of @buffer is specified by
+ * @buffer_size.  @buffer may be NULL to request the size of the buffer
+ * required.
+ *
+ * Return: Returns number of bytes used/required on success.
+ */
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1818,17 +2280,49 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
+/**
+ * security_inode_getsecid() - Get an inode's secid
+ * @inode: inode
+ * @secid: secid to return
+ *
+ * Get the secid associated with the node.  In case of failure, @secid will be
+ * set to zero.
+ */
 void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	call_void_hook(inode_getsecid, inode, secid);
 }
 
+/**
+ * security_inode_copy_up() - Create new creds for an overlayfs copy-up op
+ * @src: union dentry of copy-up file
+ * @new: newly created creds
+ *
+ * A file is about to be copied up from lower layer to upper layer of overlay
+ * filesystem. Security module can prepare a set of new creds and modify as
+ * need be and return new creds. Caller will switch to new creds temporarily to
+ * create new file and release newly allocated creds.
+ *
+ * Return: Returns 0 on success or a negative error code on error.
+ */
 int security_inode_copy_up(struct dentry *src, struct cred **new)
 {
 	return call_int_hook(inode_copy_up, 0, src, new);
 }
 EXPORT_SYMBOL(security_inode_copy_up);
 
+/**
+ * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-up op
+ * @name: xattr name
+ *
+ * Filter the xattrs being copied up when a unioned file is copied up from a
+ * lower layer to the union/overlay layer.   The caller is responsible for
+ * reading and writing the xattrs, this hook is merely a filter.
+ *
+ * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
+ *         if the security module does not know about attribute, or a negative
+ *         error code to abort the copy up.
+ */
 int security_inode_copy_up_xattr(const char *name)
 {
 	struct security_hook_list *hp;
@@ -2404,6 +2898,13 @@ int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 	return call_int_hook(sem_semop, 0, sma, sops, nsops, alter);
 }
 
+/**
+ * security_d_instantiate() - Populate an inode's LSM state based on a dentry
+ * @dentry: dentry
+ * @inode: inode
+ *
+ * Fill in @inode security information for a @dentry if allowed.
+ */
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (unlikely(inode && IS_PRIVATE(inode)))
@@ -2412,6 +2913,17 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+/**
+ * security_getprocattr() - Read an attribute for a task
+ * @p: the task
+ * @lsm: LSM name
+ * @name: attribute name
+ * @value: attribute value
+ *
+ * Read attribute @name for task @p and store it into @value if allowed.
+ *
+ * Return: Returns the length of @value on success, a negative value otherwise.
+ */
 int security_getprocattr(struct task_struct *p, const char *lsm,
 			 const char *name, char **value)
 {
@@ -2425,6 +2937,18 @@ int security_getprocattr(struct task_struct *p, const char *lsm,
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
+/**
+ * security_setprocattr() - Set an attribute for a task
+ * @lsm: LSM name
+ * @name: attribute name
+ * @value: attribute value
+ * @size: attribute value size
+ *
+ * Write (set) the current task's attribute @name to @value, size @size if
+ * allowed.
+ *
+ * Return: Returns bytes written on success, a negative value otherwise.
+ */
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
-- 
2.39.2

