Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1835DC433E9
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D316165275
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Mar 2021 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhCIPGd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:06:33 -0500
Received: from mailomta28-sa.btinternet.com ([213.120.69.34]:31451 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231272AbhCIPG0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Mar 2021 10:06:26 -0500
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20210309144004.CXPP32624.sa-prd-fep-042.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Tue, 9 Mar 2021 14:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1615300804; 
        bh=zrBFNMM+D+9IEwLePPctog25rTnrtLAAm3w/gYUpmo0=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=aY6NL00GnJx77tg53kPsHlMmU2JLCPbSW0QLUKJRrdjAzKKmvdq9X0bDNr/1VOhbUi4iIWVrZAPb+xhs0j3vOoN+bYGVwad32WoXbmaBJaHT4srMvx3Lxz3ASnzohZVO8sv9K1ARG+g3BYNi+koYxmXU6RAOFgjyZIyxQfDbpAbCkyUFv1AZLtZtv7QJi/HrJeZ0mM1RmQUjWpjywQzhLAO0TYzdnu/tF1S3bixoVq++Y9Jxgxqjv++QopQX0YUV5ZLDDGIVrxM9LBaE2AGAOXxXzhvbTsg8paUqgQLt7hrNlXcDo0qeaQ/lZ6BSAcPPsKwPAM1Rq9YaED8j0EN8xg==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 6038718301A653A3
X-Originating-IP: [86.133.207.84]
X-OWM-Source-IP: 86.133.207.84 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduledrudduiedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirddufeefrddvtdejrdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeefrddvtdejrdekgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoegtrghsvgihsehstghhrghufhhlvghrqdgtrgdrtghomheqpdhrtghpthhtohepoegtohhrsggvtheslhifnhdrnhgvtheqpdhrtghpthhtohepoehjmhhorhhrihhssehnrghmvghirdhorhhgqedprhgtphhtthhopeeolhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhn
        vghlrdhorhhgqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghrghgvsehhrghllhihnhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.133.207.84) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 6038718301A653A3; Tue, 9 Mar 2021 14:40:04 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 2/3] include/linux: Update LSM hook text part1
Date:   Tue,  9 Mar 2021 14:39:52 +0000
Message-Id: <20210309143953.142341-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309143953.142341-1-richard_c_haines@btinternet.com>
References: <20210309143953.142341-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

No hook definitions have been updated, only formatting to render
in kernel_docs.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 include/linux/lsm_hooks.h | 1173 +++++++++++++++++++++----------------
 1 file changed, 677 insertions(+), 496 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fb7f31937..b7fdab1e9 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,743 +32,924 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for program execution operations.
+ * **Security hooks for program execution operations:**
  *
- * @bprm_creds_for_exec:
- *	If the setup in prepare_exec_creds did not setup @bprm->cred->security
+ * int bprm_creds_for_exec(struct linux_binprm \*bprm)
+ *	If the setup in @prepare_exec_creds() did not setup @bprm->cred->security
  *	properly for executing @bprm->file, update the LSM's portion of
- *	@bprm->cred->security to be what commit_creds needs to install for the
- *	new program.  This hook may also optionally check permissions
+ *	@bprm->cred->security to be what @commit_creds() needs to install for
+ *	the new program.  This hook may also optionally check permissions
  *	(e.g. for transitions between security domains).
- *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
- *	request libc enable secure mode.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_creds_from_file:
- *	If @file is setpcap, suid, sgid or otherwise marked to change
- *	privilege upon exec, update @bprm->cred to reflect that change.
+ *	The hook must set @bprm->secureexec to %1 if %AT_SECURE should be set to
+ *	request %libc enable secure mode.
+ *
+ *	* @bprm contains the @linux_binprm structure.
+ *	* Return %0 if the hook is successful and permission is granted.
+ *
+ * int bprm_creds_from_file(struct linux_binprm \*bprm, struct file \*file)
+ *	If @file is %setpcap, %suid, %sgid or otherwise marked to change
+ *	privilege upon @exec, update @bprm->cred to reflect that change.
  *	This is called after finding the binary that will be executed.
  *	without an interpreter.  This ensures that the credentials will not
  *	be derived from a script that the binary will need to reopen, which
  *	when reopend may end up being a completely different file.  This
  *	hook may also optionally check permissions (e.g. for transitions
  *	between security domains).
- *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
- *	request libc enable secure mode.
+ *	The hook must set @bprm->secureexec to %1 if %AT_SECURE should be set to
+ *	request %libc enable secure mode.
  *	The hook must add to @bprm->per_clear any personality flags that
- * 	should be cleared from current->personality.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_check_security:
+ *	should be cleared from @current->personality.
+ *
+ *	* @bprm contains the @linux_binprm structure.
+ *	* Return %0 if the hook is successful and permission is granted.
+ *
+ * int bprm_check_security(struct linux_binprm \*bprm)
  *	This hook mediates the point when a search for a binary handler will
  *	begin.  It allows a check against the @bprm->cred->security value
- *	which was set in the preceding creds_for_exec call.  The argv list and
- *	envp list are reliably available in @bprm.  This hook may be called
- *	multiple times during a single execve.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_committing_creds:
+ *	which was set in the preceding @creds_for_exec() call.  The %argv list
+ *	and %envp list are reliably available in @bprm.  This hook may be called
+ *	multiple times during a single @execve.
+ *
+ *	* @bprm contains the @linux_binprm structure.
+ *	* Return %0 if the hook is successful and permission is granted.
+ *
+ * void bprm_committing_creds(struct linux_binprm \*bprm)
  *	Prepare to install the new security attributes of a process being
- *	transformed by an execve operation, based on the old credentials
+ *	transformed by an @execve operation, based on the old credentials
  *	pointed to by @current->cred and the information set in @bprm->cred by
- *	the bprm_creds_for_exec hook.  @bprm points to the linux_binprm
+ *	the @bprm_creds_for_exec() hook.  @bprm points to the @linux_binprm
  *	structure.  This hook is a good place to perform state changes on the
  *	process such as closing open file descriptors to which access will no
  *	longer be granted when the attributes are changed.  This is called
- *	immediately before commit_creds().
- * @bprm_committed_creds:
+ *	immediately before @commit_creds().
+ *
+ * void bprm_committed_creds(struct linux_binprm \*bprm)
  *	Tidy up after the installation of the new security attributes of a
- *	process being transformed by an execve operation.  The new credentials
+ *	process being transformed by an @execve operation.  The new credentials
  *	have, by this point, been set to @current->cred.  @bprm points to the
- *	linux_binprm structure.  This hook is a good place to perform state
+ *	@linux_binprm structure.  This hook is a good place to perform state
  *	changes on the process such as clearing out non-inheritable signal
- *	state.  This is called immediately after commit_creds().
+ *	state.  This is called immediately after @commit_creds().
+ *
+ * **Security hooks for mount using fs_context**
+ * (See also Documentation/filesystems/mount_api.rst):
+ *
+ * int fs_context_dup(struct fs_context \*fc, struct fs_context \*src_fc)
+ *	Allocate and attach a security structure to @sc->security.  This pointer
+ *	is initialised to %NULL by the caller.
  *
- * Security hooks for mount using fs_context.
- *	[See also Documentation/filesystems/mount_api.rst]
+ *	* @fc indicates the new filesystem context.
+ *	* @src_fc indicates the original filesystem context.
  *
- * @fs_context_dup:
- *	Allocate and attach a security structure to sc->security.  This pointer
- *	is initialised to NULL by the caller.
- *	@fc indicates the new filesystem context.
- *	@src_fc indicates the original filesystem context.
- * @fs_context_parse_param:
+ * int fs_context_parse_param(struct fs_context \*fc, struct fs_parameter \*param)
  *	Userspace provided a parameter to configure a superblock.  The LSM may
  *	reject it with an error and may use it for itself, in which case it
- *	should return 0; otherwise it should return -ENOPARAM to pass it on to
+ *	should Return %0; otherwise it should return %-ENOPARAM to pass it on to
  *	the filesystem.
- *	@fc indicates the filesystem context.
- *	@param The parameter
  *
- * Security hooks for filesystem operations.
+ *	* @fc indicates the filesystem context.
+ *	* @param The parameter
  *
- * @sb_alloc_security:
- *	Allocate and attach a security structure to the sb->s_security field.
- *	The s_security field is initialized to NULL when the structure is
+ * **Security hooks for filesystem operations:**
+ *
+ * int sb_alloc_security(struct super_block \*sb)
+ *	Allocate and attach a security structure to the @sb->s_security field.
+ *	The @s_security field is initialized to %NULL when the structure is
  *	allocated.
- *	@sb contains the super_block structure to be modified.
- *	Return 0 if operation was successful.
- * @sb_free_security:
- *	Deallocate and clear the sb->s_security field.
- *	@sb contains the super_block structure to be modified.
- * @sb_free_mnt_opts:
+ *
+ *	* @sb contains the @super_block structure to be modified.
+ *	* Return %0 if operation was successful.
+ *
+ * void sb_free_security(struct super_block \*sb)
+ *	Deallocate and clear the @sb->s_security field.
+ *
+ *	* @sb contains the @super_block structure to be modified.
+ *
+ * void sb_free_mnt_opts(void \*mnt_opts)
  * 	Free memory associated with @mnt_ops.
- * @sb_eat_lsm_opts:
+ *
+ * int sb_eat_lsm_opts(char \*orig, void \*\*mnt_opts)
  * 	Eat (scan @orig options) and save them in @mnt_opts.
- * @sb_statfs:
+ *
+ * int sb_statfs(struct dentry \*dentry)
  *	Check permission before obtaining filesystem statistics for the @mnt
  *	mountpoint.
- *	@dentry is a handle on the superblock for the filesystem.
- *	Return 0 if permission is granted.
- * @sb_mount:
+ *
+ *	* @dentry is a handle on the superblock for the filesystem.
+ *	* Return %0 if permission is granted.
+ *
+ * int sb_mount(const char \*dev_name, const struct path \*path, const char \*type, unsigned long flags, void \*data)
  *	Check permission before an object specified by @dev_name is mounted on
  *	the mount point named by @nd.  For an ordinary mount, @dev_name
  *	identifies a device if the file system type requires a device.  For a
- *	remount (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a
- *	loopback/bind mount (@flags & MS_BIND), @dev_name identifies the
+ *	remount (@flags & %MS_REMOUNT), @dev_name is irrelevant.  For a
+ *	loopback/bind mount (@flags & %MS_BIND), @dev_name identifies the
  *	pathname of the object being mounted.
- *	@dev_name contains the name for object being mounted.
- *	@path contains the path for mount point object.
- *	@type contains the filesystem type.
- *	@flags contains the mount flags.
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_copy_data:
+ *
+ *	* @dev_name contains the name for object being mounted.
+ *	* @path contains the path for mount point object.
+ *	* @type contains the filesystem type.
+ *	* @flags contains the mount flags.
+ *	* @data contains the filesystem-specific data.
+ *	* Return %0 if permission is granted.
+ *
+ * int sb_copy_data(char \*orig, char \*copy) - Deprecated
  *	Allow mount option data to be copied prior to parsing by the filesystem,
  *	so that the security module can extract security-specific mount
- *	options cleanly (a filesystem may modify the data e.g. with strsep()).
+ *	options cleanly (a filesystem may modify the data e.g. with @strsep()).
  *	This also allows the original mount data to be stripped of security-
  *	specific options to avoid having to make filesystems aware of them.
- *	@orig the original mount data copied from userspace.
- *	@copy copied data which will be passed to the security module.
- *	Returns 0 if the copy was successful.
- * @sb_remount:
+ *
+ *	* @orig the original mount data copied from userspace.
+ *	* @copy copied data which will be passed to the security module.
+ *	* Returns %0 if the copy was successful.
+ *
+ * int sb_remount(struct super_block \*sb, void \*mnt_opts)
  *	Extracts security system specific mount options and verifies no changes
  *	are being made to those options.
- *	@sb superblock being remounted
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_kern_mount:
+ *
+ *	* @sb superblock being remounted
+ *	* @data contains the filesystem-specific data.
+ *	* Return %0 if permission is granted.
+ *
+ * int sb_kern_mount(struct super_block \*sb)
  * 	Mount this @sb if allowed by permissions.
- * @sb_show_options:
+ *
+ * int sb_show_options(struct seq_file \*m, struct super_block \*sb)
  * 	Show (print on @m) mount options for this @sb.
- * @sb_umount:
+ *
+ * int sb_umount(struct vfsmount \*mnt, int flags)
  *	Check permission before the @mnt file system is unmounted.
- *	@mnt contains the mounted file system.
- *	@flags contains the unmount flags, e.g. MNT_FORCE.
- *	Return 0 if permission is granted.
- * @sb_pivotroot:
+ *
+ *	* @mnt contains the mounted file system.
+ *	* @flags contains the unmount flags, e.g. %MNT_FORCE.
+ *	* Return %0 if permission is granted.
+ *
+ * int sb_pivotroot(const struct path \*old_path, const struct path \*new_path)
  *	Check permission before pivoting the root filesystem.
- *	@old_path contains the path for the new location of the
- *	current root (put_old).
- *	@new_path contains the path for the new root (new_root).
- *	Return 0 if permission is granted.
- * @sb_set_mnt_opts:
- *	Set the security relevant mount options used for a superblock
- *	@sb the superblock to set security mount options for
- *	@opts binary data structure containing all lsm mount data
- * @sb_clone_mnt_opts:
+ *
+ *	* @old_path contains the path for the new location of the current root (put_old).
+ *	* @new_path contains the path for the new root (new_root).
+ *	* Return %0 if permission is granted.
+ *
+ * int sb_set_mnt_opts(struct super_block \*sb, void \*mnt_opts, unsigned long kern_flags, unsigned long \*set_kern_flags)
+ *	Set the security relevant mount options used for a superblock:
+ *
+ *	* @sb the superblock to set security mount options for
+ *	* @mnt_opts binary data structure containing all LSM mount data
+ *
+ * int sb_clone_mnt_opts(const struct super_block \*oldsb, struct super_block \*newsb, unsigned long kern_flags, unsigned long \*set_kern_flags)
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_add_mnt_opt:
+ *
+ * int sb_add_mnt_opt(const char \*option, const char \*val, int len, void \*\*mnt_opts)
  * 	Add one mount @option to @mnt_opts.
- * @sb_parse_opts_str:
+ *
+ * int sb_parse_opts_str(char \*options, struct security_mnt_opts \*opts) - Deprecated
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
  *	@opts binary data structure usable by the LSM
- * @move_mount:
+ *
+ * int move_mount(const struct path \*from_path, const struct path \*to_path)
  *	Check permission before a mount is moved.
- *	@from_path indicates the mount that is going to be moved.
- *	@to_path indicates the mountpoint that will be mounted upon.
- * @dentry_init_security:
+ *
+ *	* @from_path indicates the mount that is going to be moved.
+ *	* @to_path indicates the mountpoint that will be mounted upon.
+ *
+ * int dentry_init_security(struct dentry \*dentry, int mode, const struct qstr \*name, void \*\*ctx, u32 \*ctxlen)
  *	Compute a context for a dentry as the inode is not yet available
  *	since NFSv4 has no label backed by an EA anyway.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
- * @dentry_create_files_as:
+ *
+ *	* @dentry dentry to use in calculating the context.
+ *	* @mode mode used to determine resource type.
+ *	* @name name of the last path component used to create file
+ *	* @ctx pointer to place the pointer to the resulting context in.
+ *	* @ctxlen point to place the length of the resulting context.
+ *
+ * int dentry_create_files_as(struct dentry \*dentry, int mode, struct qstr \*name, const struct cred \*old, struct cred \*new)
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
  *	created using that context. Context is calculated using the
  *	passed in creds and not the creds of the caller.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
- *	@old creds which should be used for context calculation
- *	@new creds to modify
  *
+ *	* @dentry dentry to use in calculating the context.
+ *	* @mode mode used to determine resource type.
+ *	* @name name of the last path component used to create file
+ *	* @old creds which should be used for context calculation
+ *	* @new creds to modify
  *
- * Security hooks for inode operations.
+ * **Security hooks for inode operations:**
  *
- * @inode_alloc_security:
+ * int inode_alloc_security(struct inode \*inode)
  *	Allocate and attach a security structure to @inode->i_security.  The
- *	i_security field is initialized to NULL when the inode structure is
+ *	@i_security field is initialized to %NULL when the inode structure is
  *	allocated.
- *	@inode contains the inode structure.
- *	Return 0 if operation was successful.
- * @inode_free_security:
+ *
+ *	* @inode contains the inode structure.
+ *	* Return %0 if operation was successful.
+ *
+ * void inode_free_security(struct inode \*inode)
  *	@inode contains the inode structure.
  *	Deallocate the inode security structure and set @inode->i_security to
- *	NULL.
- * @inode_init_security:
+ *	%NULL.
+ *
+ * int inode_init_security(struct inode \*inode, struct inode \*dir, const struct qstr \*qstr, const char \*\*name, void \*\*value, size_t \*len)
  *	Obtain the security attribute name suffix and value to set on a newly
  *	created inode and set up the incore security field for the new inode.
  *	This hook is called by the fs code as part of the inode creation
  *	transaction and provides for atomic labeling of the inode, unlike
  *	the post_create/mkdir/... hooks called by the VFS.  The hook function
- *	is expected to allocate the name and value via kmalloc, with the caller
- *	being responsible for calling kfree after using them.
+ *	is expected to allocate the name and value via @kmalloc(), with the caller
+ *	being responsible for calling @kfree() after using them.
  *	If the security module does not use security attributes or does
  *	not wish to put a security attribute on this particular inode,
- *	then it should return -EOPNOTSUPP to skip this processing.
- *	@inode contains the inode structure of the newly created inode.
- *	@dir contains the inode structure of the parent directory.
- *	@qstr contains the last path component of the new object
- *	@name will be set to the allocated name suffix (e.g. selinux).
- *	@value will be set to the allocated attribute value.
- *	@len will be set to the length of the value.
- *	Returns 0 if @name and @value have been successfully set,
- *	-EOPNOTSUPP if no security attribute is needed, or
- *	-ENOMEM on memory allocation failure.
- * @inode_init_security_anon:
+ *	then it should return %-EOPNOTSUPP to skip this processing.
+ *
+ *	* @inode contains the inode structure of the newly created inode.
+ *	* @dir contains the inode structure of the parent directory.
+ *	* @qstr contains the last path component of the new object
+ *	* @name will be set to the allocated name suffix (e.g. selinux).
+ *	* @value will be set to the allocated attribute value.
+ *	* @len will be set to the length of the value.
+ *	* Returns %0 if @name and @value have been successfully set,
+ *	* %-EOPNOTSUPP if no security attribute is needed, or
+ *	* %-ENOMEM on memory allocation failure.
+ *
+ * int inode_init_security_anon(struct inode \*inode, const struct qstr \*name, const struct inode \*context_inode)
  *      Set up the incore security field for the new anonymous inode
  *      and return whether the inode creation is permitted by the security
  *      module or not.
- *      @inode contains the inode structure
- *      @name name of the anonymous inode class
- *      @context_inode optional related inode
- *	Returns 0 on success, -EACCES if the security module denies the
- *	creation of this inode, or another -errno upon other errors.
- * @inode_create:
+ *
+ *      * @inode contains the inode structure
+ *      * @name name of the anonymous inode class
+ *      * @context_inode optional related inode
+ *	* Returns %0 on success,
+ *	* %-EACCES if the security module denies the creation of this inode,
+ *	* or another %-errno upon other errors.
+ *
+ * int inode_create(struct inode \*dir, struct dentry \*dentry, umode_t mode)
  *	Check permission to create a regular file.
- *	@dir contains inode structure of the parent of the new file.
- *	@dentry contains the dentry structure for the file to be created.
- *	@mode contains the file mode of the file to be created.
- *	Return 0 if permission is granted.
- * @inode_link:
+ *
+ *	* @dir contains inode structure of the parent of the new file.
+ *	* @dentry contains the dentry structure for the file to be created.
+ *	* @mode contains the file mode of the file to be created.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_link(struct dentry \*old_dentry, struct inode \*dir, struct dentry \*new_dentry)
  *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing
- *	link to the file.
- *	@dir contains the inode structure of the parent directory
- *	of the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @path_link:
+ *
+ *	* @old_dentry contains the dentry structure for an existing link to the file.
+ *	* @dir contains the inode structure of the parent directory of the new link.
+ *	* @new_dentry contains the dentry structure for the new link.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_link(struct dentry \*old_dentry, const struct path \*new_dir, struct dentry \*new_dentry)
  *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing link
- *	to the file.
- *	@new_dir contains the path structure of the parent directory of
- *	the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @inode_unlink:
+ *
+ *	* @old_dentry contains the dentry structure for an existing link to the file.
+ *	* @new_dir contains the path structure of the parent directory of the new link.
+ *	* @new_dentry contains the dentry structure for the new link.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_unlink(struct inode \*dir, struct dentry \*dentry)
  *	Check the permission to remove a hard link to a file.
- *	@dir contains the inode structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @path_unlink:
+ *
+ *	* @dir contains the inode structure of parent directory of the file.
+ *	* @dentry contains the dentry structure for file to be unlinked.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_unlink(const struct path \*dir, struct dentry \*dentry)
  *	Check the permission to remove a hard link to a file.
- *	@dir contains the path structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @inode_symlink:
+ *
+ *	* @dir contains the path structure of parent directory of the file.
+ *	* @dentry contains the dentry structure for file to be unlinked.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_symlink(struct inode \*dir, struct dentry \*dentry, const char \*old_name)
  *	Check the permission to create a symbolic link to a file.
- *	@dir contains the inode structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @path_symlink:
+ *
+ *	* @dir contains the inode structure of parent directory of the symbolic link.
+ *	* @dentry contains the dentry structure of the symbolic link.
+ *	* @old_name contains the pathname of file.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_symlink(const struct path \*dir, struct dentry \*dentry, const char \*old_name)
  *	Check the permission to create a symbolic link to a file.
- *	@dir contains the path structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @inode_mkdir:
+ *
+ *	* @dir contains the path structure of parent directory of the symbolic link.
+ *	* @dentry contains the dentry structure of the symbolic link.
+ *	* @old_name contains the pathname of file.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_mkdir(struct inode \*dir, struct dentry \*dentry, umode_t mode)
  *	Check permissions to create a new directory in the existing directory
  *	associated with inode structure @dir.
- *	@dir contains the inode structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @path_mkdir:
+ *
+ *	* @dir contains the inode structure of parent of the directory to be created.
+ *	* @dentry contains the dentry structure of new directory.
+ *	* @mode contains the mode of new directory.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_mkdir(const struct path \*dir, struct dentry \*dentry, umode_t mode)
  *	Check permissions to create a new directory in the existing directory
  *	associated with path structure @path.
- *	@dir contains the path structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @inode_rmdir:
+ *
+ *	* @dir contains the path structure of parent of the directory to be created.
+ *	* @dentry contains the dentry structure of new directory.
+ *	* @mode contains the mode of new directory.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_rmdir(struct inode \*dir, struct dentry \*dentry)
  *	Check the permission to remove a directory.
- *	@dir contains the inode structure of parent of the directory
- *	to be removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @path_rmdir:
+ *
+ *	* @dir contains the inode structure of parent of the directory to be removed.
+ *	* @dentry contains the dentry structure of directory to be removed.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_rmdir(const struct path \*dir, struct dentry \*dentry)
  *	Check the permission to remove a directory.
- *	@dir contains the path structure of parent of the directory to be
- *	removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @inode_mknod:
+ *
+ *	* @dir contains the path structure of parent of the directory to be removed.
+ *	* @dentry contains the dentry structure of directory to be removed.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_mknod(struct inode \*dir, struct dentry \*dentry, umode_t mode, dev_t dev)
  *	Check permissions when creating a special file (or a socket or a fifo
- *	file created via the mknod system call).  Note that if mknod operation
+ *	file created via the @mknod() system call).  Note that if mknod operation
  *	is being done for a regular file, then the create hook will be called
  *	and not this hook.
- *	@dir contains the inode structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the device number.
- *	Return 0 if permission is granted.
- * @path_mknod:
+ *
+ *	* @dir contains the inode structure of parent of the new file.
+ *	* @dentry contains the dentry structure of the new file.
+ *	* @mode contains the mode of the new file.
+ *	* @dev contains the device number.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_mknod(const struct path \*dir, struct dentry \*dentry, umode_t mode, unsigned int dev)
  *	Check permissions when creating a file. Note that this hook is called
  *	even if mknod operation is being done for a regular file.
- *	@dir contains the path structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the undecoded device number. Use new_decode_dev() to get
- *	the decoded device number.
- *	Return 0 if permission is granted.
- * @inode_rename:
+ *
+ *	* @dir contains the path structure of parent of the new file.
+ *	* @dentry contains the dentry structure of the new file.
+ *	* @mode contains the mode of the new file.
+ *	* @dev contains the undecoded device number. Use new_decode_dev() to get the decoded device number.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_rename(struct inode \*old_dir, struct dentry \*old_dentry, struct inode \*new_dir, struct dentry \*new_dentry)
  *	Check for permission to rename a file or directory.
- *	@old_dir contains the inode structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the inode structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	Return 0 if permission is granted.
- * @path_rename:
+ *
+ *	* @old_dir contains the inode structure for parent of the old link.
+ *	* @old_dentry contains the dentry structure of the old link.
+ *	* @new_dir contains the inode structure for parent of the new link.
+ *	* @new_dentry contains the dentry structure of the new link.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_rename(const struct path \*old_dir, struct dentry \*old_dentry, const struct path \*new_dir, struct dentry \*new_dentry)
  *	Check for permission to rename a file or directory.
- *	@old_dir contains the path structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the path structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	Return 0 if permission is granted.
- * @path_chmod:
+ *
+ *	* @old_dir contains the path structure for parent of the old link.
+ *	* @old_dentry contains the dentry structure of the old link.
+ *	* @new_dir contains the path structure for parent of the new link.
+ *	* @new_dentry contains the dentry structure of the new link.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_chmod(const struct path \*path, umode_t mode)
  *	Check for permission to change a mode of the file @path. The new
  *	mode is specified in @mode.
- *	@path contains the path structure of the file to change the mode.
- *	@mode contains the new DAC's permission, which is a bitmask of
- *	constants from <include/uapi/linux/stat.h>
- *	Return 0 if permission is granted.
- * @path_chown:
+ *
+ *	* @path contains the path structure of the file to change the mode.
+ *	* @mode contains the new DAC's permission, which is a bitmask of constants from <include/uapi/linux/stat.h>
+ *	* Return %0 if permission is granted.
+ *
+ * int path_chown(const struct path \*path, kuid_t uid, kgid_t gid)
  *	Check for permission to change owner/group of a file or directory.
- *	@path contains the path structure.
- *	@uid contains new owner's ID.
- *	@gid contains new group's ID.
- *	Return 0 if permission is granted.
- * @path_chroot:
+ *
+ *	* @path contains the path structure.
+ *	* @uid contains new owner's ID.
+ *	* @gid contains new group's ID.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_chroot(const struct path \*path)
  *	Check for permission to change root directory.
- *	@path contains the path structure.
- *	Return 0 if permission is granted.
- * @path_notify:
+ *
+ *	* @path contains the path structure.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_notify(const struct path \*path, u64 mask, unsigned int obj_type)
  *	Check permissions before setting a watch on events as defined by @mask,
  *	on an object at @path, whose type is defined by @obj_type.
- * @inode_readlink:
+ *
+ * int inode_readlink(struct dentry \*dentry)
  *	Check the permission to read the symbolic link.
- *	@dentry contains the dentry structure for the file link.
- *	Return 0 if permission is granted.
- * @inode_follow_link:
+ *
+ *	* @dentry contains the dentry structure for the file link.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_follow_link(struct dentry \*dentry, struct inode \*inode,  bool rcu)
  *	Check permission to follow a symbolic link when looking up a pathname.
- *	@dentry contains the dentry structure for the link.
- *	@inode contains the inode, which itself is not stable in RCU-walk
- *	@rcu indicates whether we are in RCU-walk mode.
- *	Return 0 if permission is granted.
- * @inode_permission:
+ *
+ *	* @dentry contains the dentry structure for the link.
+ *	* @inode contains the inode, which itself is not stable in RCU-walk
+ *	* @rcu indicates whether we are in RCU-walk mode.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_permission(struct inode \*inode, int mask)
  *	Check permission before accessing an inode.  This hook is called by the
  *	existing Linux permission function, so a security module can use it to
  *	provide additional checking for existing Linux permission checks.
  *	Notice that this hook is called when a file is opened (as well as many
- *	other operations), whereas the file_security_ops permission hook is
+ *	other operations), whereas the @file_security_ops() permission hook is
  *	called when the actual read/write operations are performed.
- *	@inode contains the inode structure to check.
- *	@mask contains the permission mask.
- *	Return 0 if permission is granted.
- * @inode_setattr:
+ *
+ *	* @inode contains the inode structure to check.
+ *	* @mask contains the permission mask.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_setattr(struct dentry \*dentry, struct iattr \*attr)
  *	Check permission before setting file attributes.  Note that the kernel
- *	call to notify_change is performed from several locations, whenever
+ *	call to @notify_change() is performed from several locations, whenever
  *	file attributes change (such as when a file is truncated, chown/chmod
  *	operations, transferring disk quotas, etc).
- *	@dentry contains the dentry structure for the file.
- *	@attr is the iattr structure containing the new file attributes.
- *	Return 0 if permission is granted.
- * @path_truncate:
+ *
+ *	* @dentry contains the dentry structure for the file.
+ *	* @attr is the @iattr structure containing the new file attributes.
+ *	* Return %0 if permission is granted.
+ *
+ * int path_truncate(const struct path \*path)
  *	Check permission before truncating a file.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_getattr:
+ *
+ *	* @path contains the path structure for the file.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_getattr(const struct path \*path)
  *	Check permission before obtaining file attributes.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_setxattr:
+ *
+ *	* @path contains the path structure for the file.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_setxattr(struct user_namespace \*mnt_userns, struct dentry \*dentry, const char \*name, const void \*value, size_t size, int flags)
  *	Check permission before setting the extended attributes
- *	@value identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_post_setxattr:
- *	Update inode security field after successful setxattr operation.
- *	@value identified by @name for @dentry.
- * @inode_getxattr:
+ *
+ *	* @value identified by @name for @dentry.
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_post_setxattr(struct dentry \*dentry, const char \*name, const void \*value, size_t size, int flags)
+ *	Update inode security field after successful @setxattr operation.
+ *
+ *	* @value identified by @name for @dentry.
+ *
+ * int inode_getxattr(struct dentry \*dentry, const char \*name)
  *	Check permission before obtaining the extended attributes
  *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_listxattr:
+ *
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_listxattr(struct dentry \*dentry)
  *	Check permission before obtaining the list of extended attribute
  *	names for @dentry.
- *	Return 0 if permission is granted.
- * @inode_removexattr:
+ *
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_removexattr(struct user_namespace \*mnt_userns, struct dentry \*dentry, const char \*name)
  *	Check permission before removing the extended attribute
  *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_getsecurity:
+ *
+ *	* Return %0 if permission is granted.
+ *
+ * int inode_getsecurity(struct user_namespace \*mnt_userns, struct inode \*inode, const char \*name, void \*\*buffer, bool alloc)
  *	Retrieve a copy of the extended attribute representation of the
  *	security label associated with @name for @inode via @buffer.  Note that
  *	@name is the remainder of the attribute name after the security prefix
  *	has been removed. @alloc is used to specify of the call should return a
  *	value via the buffer or just the value length Return size of buffer on
  *	success.
- * @inode_setsecurity:
+ *
+ * int inode_setsecurity(struct inode \*inode, const char \*name, const void \*value, size_t size, int flags)
  *	Set the security label associated with @name for @inode from the
  *	extended attribute value @value.  @size indicates the size of the
- *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
+ *	@value in bytes.  @flags may be %XATTR_CREATE, %XATTR_REPLACE, or %0.
  *	Note that @name is the remainder of the attribute name after the
  *	security. prefix has been removed.
- *	Return 0 on success.
- * @inode_listsecurity:
+ *
+ *	* Return %0 on success.
+ *
+ * int inode_listsecurity(struct inode \*inode, char \*buffer, size_t buffer_size)
  *	Copy the extended attribute names for the security labels
  *	associated with @inode into @buffer.  The maximum size of @buffer
- *	is specified by @buffer_size.  @buffer may be NULL to request
+ *	is specified by @buffer_size.  @buffer may be %NULL to request
  *	the size of the buffer required.
- *	Returns number of bytes used/required on success.
- * @inode_need_killpriv:
+ *
+ *	* Returns number of bytes used/required on success.
+ *
+ * int inode_need_killpriv(struct dentry \*dentry)
  *	Called when an inode has been changed.
- *	@dentry is the dentry being changed.
- *	Return <0 on error to abort the inode change operation.
- *	Return 0 if inode_killpriv does not need to be called.
- *	Return >0 if inode_killpriv does need to be called.
- * @inode_killpriv:
- *	The setuid bit is being removed.  Remove similar security labels.
- *	Called with the dentry->d_inode->i_mutex held.
- *	@mnt_userns: user namespace of the mount
- *	@dentry is the dentry being changed.
- *	Return 0 on success.  If error is returned, then the operation
- *	causing setuid bit removal is failed.
- * @inode_getsecid:
- *	Get the secid associated with the node.
- *	@inode contains a pointer to the inode.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
- * @inode_copy_up:
+ *
+ *	* @dentry is the dentry being changed.
+ *	* Return %<0 on error to abort the inode change operation.
+ *	* Return %0 if @inode_killpriv() does not need to be called.
+ *	* Return %>0 if @inode_killpriv() does need to be called.
+ *
+ * int inode_killpriv(struct user_namespace \*mnt_userns, struct dentry \*dentry)
+ *	The %setuid bit is being removed.  Remove similar security labels.
+ *	Called with the @dentry->d_inode->i_mutex held.
+ *
+ *	* @mnt_userns: user namespace of the mount
+ *	* @dentry is the dentry being changed.
+ *	* Return %0 on success.
+ *	* If error is returned, then the operation causing %setuid bit removal is failed.
+ *
+ * void inode_getsecid(struct inode \*inode, u32 \*secid)
+ *	Get the %secid associated with the node.
+ *
+ *	* @inode contains a pointer to the inode.
+ *	* @secid contains a pointer to the location where result will be saved.
+ *	* In case of failure, @secid will be set to zero.
+ *
+ * int inode_copy_up(struct dentry \*src, struct cred \*\*new)
  *	A file is about to be copied up from lower layer to upper layer of
  *	overlay filesystem. Security module can prepare a set of new creds
  *	and modify as need be and return new creds. Caller will switch to
  *	new creds temporarily to create new file and release newly allocated
  *	creds.
- *	@src indicates the union dentry of file that is being copied up.
- *	@new pointer to pointer to return newly allocated creds.
- *	Returns 0 on success or a negative error code on error.
- * @inode_copy_up_xattr:
+ *
+ *	* @src indicates the union @dentry of file that is being copied up.
+ *	* @new pointer to pointer to return newly allocated creds.
+ *	* Returns %0 on success or a negative error code on error.
+ *
+ * int inode_copy_up_xattr(const char \*name)
  *	Filter the xattrs being copied up when a unioned file is copied
  *	up from a lower layer to the union/overlay layer.
- *	@name indicates the name of the xattr.
- *	Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP if
- *	security module does not know about attribute or a negative error code
- *	to abort the copy up. Note that the caller is responsible for reading
- *	and writing the xattrs as this hook is merely a filter.
- * @d_instantiate:
+ *	Note that the caller is responsible for reading and writing the
+ *	xattrs as this hook is merely a filter.
+ *
+ *	* @name indicates the name of the xattr.
+ *	* Returns %0 to accept the xattr,
+ *	* Returns %1 to discard the xattr,
+ *	* Returns %-EOPNOTSUPP if security module does not know about attribute or a negative error code to abort the copy up.
+ *
+ * void d_instantiate(struct dentry \*dentry, struct inode \*inode)
  * 	Fill in @inode security information for a @dentry if allowed.
- * @getprocattr:
+ *
+ * int getprocattr(struct task_struct \*p, char \*name, char \*\*value)
  * 	Read attribute @name for process @p and store it into @value if allowed.
- * @setprocattr:
+ *
+ * int setprocattr(const char \*name, void \*value, size_t size)
  * 	Write (set) attribute @name to @value, size @size if allowed.
  *
- * Security hooks for kernfs node operations
+ * **Security hooks for kernfs node operations:**
  *
- * @kernfs_init_security:
- *	Initialize the security context of a newly created kernfs node based
+ * int kernfs_init_security(struct kernfs_node \*kn_dir, struct kernfs_node \*kn)
+ *	Initialize the security context of a newly created @kernfs node based
  *	on its own and its parent's attributes.
  *
- *	@kn_dir the parent kernfs node
- *	@kn the new child kernfs node
+ *	* @kn_dir the parent kernfs node
+ *	* @kn the new child kernfs node
  *
- * Security hooks for file operations
+ * **Security hooks for file operations:**
  *
- * @file_permission:
+ * int file_permission(struct file \*file, int mask)
  *	Check file permissions before accessing an open file.  This hook is
  *	called by various operations that read or write files.  A security
  *	module can use this hook to perform additional checking on these
  *	operations, e.g.  to revalidate permissions on use to support privilege
  *	bracketing or policy changes.  Notice that this hook is used when the
  *	actual read/write operations are performed, whereas the
- *	inode_security_ops hook is called when a file is opened (as well as
+ *	@inode_security_ops() hook is called when a file is opened (as well as
  *	many other operations).
  *	Caveat:  Although this hook can be used to revalidate permissions for
  *	various system call operations that read or write files, it does not
  *	address the revalidation of permissions for memory-mapped files.
  *	Security modules must handle this separately if they need such
  *	revalidation.
- *	@file contains the file structure being accessed.
- *	@mask contains the requested permissions.
- *	Return 0 if permission is granted.
- * @file_alloc_security:
- *	Allocate and attach a security structure to the file->f_security field.
- *	The security field is initialized to NULL when the structure is first
+ *
+ *	* @file contains the file structure being accessed.
+ *	* @mask contains the requested permissions.
+ *	* Return %0 if permission is granted.
+ *
+ * int file_alloc_security(struct file \*file)
+ *	Allocate and attach a security structure to the @file->f_security field.
+ *	The security field is initialized to %NULL when the structure is first
  *	created.
- *	@file contains the file structure to secure.
- *	Return 0 if the hook is successful and permission is granted.
- * @file_free_security:
- *	Deallocate and free any security structures stored in file->f_security.
+ *
+ *	* @file contains the file structure to secure.
+ *	* Return %0 if the hook is successful and permission is granted.
+ *
+ * void file_free_security(struct file \*file)
+ *	Deallocate and free any security structures stored in @file->f_security.
+ *
  *	@file contains the file structure being modified.
- * @file_ioctl:
- *	@file contains the file structure.
- *	@cmd contains the operation to perform.
- *	@arg contains the operational arguments.
+ *
+ * int file_ioctl(struct file \*file, unsigned int cmd, unsigned long arg)
  *	Check permission for an ioctl operation on @file.  Note that @arg
  *	sometimes represents a user space pointer; in other cases, it may be a
  *	simple integer value.  When @arg represents a user space pointer, it
  *	should never be used by the security module.
- *	Return 0 if permission is granted.
- * @mmap_addr :
+ *
+ *	* @file contains the file structure.
+ *	* @cmd contains the operation to perform.
+ *	* @arg contains the operational arguments.
+ *	* Return %0 if permission is granted.
+ *
+ * int mmap_addr(unsigned long addr)
  *	Check permissions for a mmap operation at @addr.
- *	@addr contains virtual address that will be used for the operation.
- *	Return 0 if permission is granted.
- * @mmap_file :
- *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
+ *
+ *	* @addr contains virtual address that will be used for the operation.
+ *	* Return %0 if permission is granted.
+ *
+ * int mmap_file(struct file \*file, unsigned long reqprot, unsigned long prot, unsigned long flags)
+ *	Check permissions for a @mmap operation.  The @file may be %NULL, e.g.
  *	if mapping anonymous memory.
- *	@file contains the file structure for file to map (may be NULL).
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @file_mprotect:
+ *
+ *	* @file contains the file structure for file to map (may be %NULL).
+ *	* @reqprot contains the protection requested by the application.
+ *	* @prot contains the protection that will be applied by the kernel.
+ *	* @flags contains the operational flags.
+ *	* Return %0 if permission is granted.
+ *
+ * int file_mprotect(struct vm_area_struct \*vma, unsigned long reqprot, unsigned long prot)
  *	Check permissions before changing memory access permissions.
- *	@vma contains the memory region to modify.
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	Return 0 if permission is granted.
- * @file_lock:
+ *
+ *	* @vma contains the memory region to modify.
+ *	* @reqprot contains the protection requested by the application.
+ *	* @prot contains the protection that will be applied by the kernel.
+ *	* Return %0 if permission is granted.
+ *
+ * int file_lock(struct file \*file, unsigned int cmd)
  *	Check permission before performing file locking operations.
  *	Note the hook mediates both flock and fcntl style locks.
- *	@file contains the file structure.
- *	@cmd contains the posix-translated lock operation to perform
- *	(e.g. F_RDLCK, F_WRLCK).
- *	Return 0 if permission is granted.
- * @file_fcntl:
+ *
+ *	* @file contains the file structure.
+ *	* @cmd contains the posix-translated lock operation to perform (e.g. %F_RDLCK, %F_WRLCK).
+ *	* Return %0 if permission is granted.
+ *
+ * int file_fcntl(struct file \*file, unsigned int cmd, unsigned long arg)
  *	Check permission before allowing the file operation specified by @cmd
  *	from being performed on the file @file.  Note that @arg sometimes
  *	represents a user space pointer; in other cases, it may be a simple
  *	integer value.  When @arg represents a user space pointer, it should
  *	never be used by the security module.
- *	@file contains the file structure.
- *	@cmd contains the operation to be performed.
- *	@arg contains the operational arguments.
- *	Return 0 if permission is granted.
- * @file_set_fowner:
- *	Save owner security information (typically from current->security) in
- *	file->f_security for later use by the send_sigiotask hook.
- *	@file contains the file structure to update.
- *	Return 0 on success.
- * @file_send_sigiotask:
- *	Check permission for the file owner @fown to send SIGIO or SIGURG to the
+ *
+ *	* @file contains the file structure.
+ *	* @cmd contains the operation to be performed.
+ *	* @arg contains the operational arguments.
+ *	* Return %0 if permission is granted.
+ *
+ * void file_set_fowner(struct file \*file)
+ *	Save owner security information (typically from @current->security) in
+ *	@file->f_security for later use by the @send_sigiotask() hook.
+ *
+ *	* @file contains the file structure to update.
+ *
+ * int file_send_sigiotask(struct task_struct \*tsk, struct fown_struct \*fown, int sig)
+ *	Check permission for the file owner @fown to send %SIGIO or %SIGURG to the
  *	process @tsk.  Note that this hook is sometimes called from interrupt.
- *	Note that the fown_struct, @fown, is never outside the context of a
+ *	Note that the @fown_struct, @fown, is never outside the context of a
  *	struct file, so the file structure (and associated security information)
  *	can always be obtained: container_of(fown, struct file, f_owner)
- *	@tsk contains the structure of task receiving signal.
- *	@fown contains the file owner information.
- *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
- *	Return 0 if permission is granted.
- * @file_receive:
+ *
+ *	* @tsk contains the structure of task receiving signal.
+ *	* @fown contains the file owner information.
+ *	* @sig is the signal that will be sent.  When 0, kernel sends %SIGIO.
+ *	* Return %0 if permission is granted.
+ *
+ * int file_receive(struct file \*file)
  *	This hook allows security modules to control the ability of a process
  *	to receive an open file descriptor via socket IPC.
- *	@file contains the file structure being received.
- *	Return 0 if permission is granted.
- * @file_open:
+ *
+ *	* @file contains the file structure being received.
+ *	* Return %0 if permission is granted.
+ *
+ * int file_open(struct file \*file)
  *	Save open-time permission checking state for later use upon
- *	file_permission, and recheck access if anything has changed
- *	since inode_permission.
+ *	@file_permission(), and recheck access if anything has changed
+ *	since @inode_permission().
  *
- * Security hooks for task operations.
+ * **Security hooks for task operations:**
  *
- * @task_alloc:
- *	@task task being allocated.
- *	@clone_flags contains the flags indicating what should be shared.
+ * int task_alloc(struct task_struct \*task, unsigned long clone_flags)
  *	Handle allocation of task-related resources.
- *	Returns a zero on success, negative values on failure.
- * @task_free:
- *	@task task about to be freed.
+ *
+ *	* @task task being allocated.
+ *	* @clone_flags contains the flags indicating what should be shared.
+ *	* Returns a zero on success, negative values on failure.
+ *
+ * void task_free(struct task_struct \*task)
  *	Handle release of task-related resources. (Note that this can be called
  *	from interrupt context.)
- * @cred_alloc_blank:
- *	@cred points to the credentials.
- *	@gfp indicates the atomicity of any memory allocations.
+ *
+ *	* @task task about to be freed.
+ *
+ * int cred_alloc_blank(struct cred \*cred, gfp_t gfp)
  *	Only allocate sufficient memory and attach to @cred such that
- *	cred_transfer() will not get ENOMEM.
- * @cred_free:
- *	@cred points to the credentials.
- *	Deallocate and clear the cred->security field in a set of credentials.
- * @cred_prepare:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
- *	@gfp indicates the atomicity of any memory allocations.
+ *	@cred_transfer() will not get %ENOMEM.
+ *
+ *	* @cred points to the credentials.
+ *	* @gfp indicates the atomicity of any memory allocations.
+ *
+ * void cred_free(struct cred \*cred)
+ *	Deallocate and clear the @cred->security field in a set of credentials.
+ *
+ *	* @cred points to the credentials.
+ *
+ * int cred_prepare(struct cred \*new, const struct cred \*old, gfp_t gfp)
  *	Prepare a new set of credentials by copying the data from the old set.
- * @cred_transfer:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
+ *
+ *	* @new points to the new credentials.
+ *	* @old points to the original credentials.
+ *	* @gfp indicates the atomicity of any memory allocations.
+ *
+ * void cred_transfer(cred_transfer, struct cred \*new, const struct cred \*old)
  *	Transfer data from original creds to new creds
- * @cred_getsecid:
+ *
+ *	* @new points to the new credentials.
+ *	* @old points to the original credentials.
+ *
+ * void cred_getsecid(const struct cred \*c, u32 \*secid)
  *	Retrieve the security identifier of the cred structure @c
  *	@c contains the credentials, secid will be placed into @secid.
  *	In case of failure, @secid will be set to zero.
- * @kernel_act_as:
+ *
+ * int kernel_act_as(struct cred \*new, u32 secid)
  *	Set the credentials for a kernel service to act as (subjective context).
- *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set
  *	The current task must be the one that nominated @secid.
- *	Return 0 if successful.
- * @kernel_create_files_as:
+ *
+ *	* @new points to the credentials to be modified.
+ *	* @secid specifies the security ID to be set
+ *	* Return %0 if successful.
+ *
+ * int kernel_create_files_as(struct cred \*new, struct inode \*inode)
  *	Set the file creation context in a set of credentials to be the same as
  *	the objective context of the specified inode.
- *	@new points to the credentials to be modified.
- *	@inode points to the inode to use as a reference.
  *	The current task must be the one that nominated @inode.
- *	Return 0 if successful.
- * @kernel_module_request:
+ *
+ *	* @new points to the credentials to be modified.
+ *	* @inode points to the inode to use as a reference.
+ *	* Return %0 if successful.
+ *
+ * int kernel_module_request(char \*kmod_name)
  *	Ability to trigger the kernel to automatically upcall to userspace for
  *	userspace to load a kernel module with the given name.
- *	@kmod_name name of the module requested by the kernel
- *	Return 0 if successful.
- * @kernel_load_data:
+ *
+ *	* @kmod_name name of the module requested by the kernel
+ *	* Return %0 if successful.
+ *
+ * int kernel_load_data(enum kernel_load_data_id id, bool contents)
  *	Load data provided by userspace.
- *	@id kernel load data identifier
- *	@contents if a subsequent @kernel_post_load_data will be called.
- *	Return 0 if permission is granted.
- * @kernel_post_load_data:
+ *
+ *	* @id kernel load data identifier
+ *	* @contents if a subsequent @kernel_post_load_data will be called.
+ *	* Return %0 if permission is granted.
+ *
+ * int kernel_post_load_data(char \*buf, loff_t size, enum kernel_load_data_id id, char \*description)
  *	Load data provided by a non-file source (usually userspace buffer).
- *	@buf pointer to buffer containing the data contents.
- *	@size length of the data contents.
- *	@id kernel load data identifier
- *	@description a text description of what was loaded, @id-specific
- *	Return 0 if permission is granted.
  *	This must be paired with a prior @kernel_load_data call that had
  *	@contents set to true.
- * @kernel_read_file:
+ *
+ *	* @buf pointer to buffer containing the data contents.
+ *	* @size length of the data contents.
+ *	* @id kernel load data identifier
+ *	* @description a text description of what was loaded, id-specific
+ *	* Return %0 if permission is granted.
+ *
+ * int kernel_read_file(struct file \*file, enum kernel_read_file_id id, bool contents)
  *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@id kernel read file identifier
- *	@contents if a subsequent @kernel_post_read_file will be called.
- *	Return 0 if permission is granted.
- * @kernel_post_read_file:
+ *
+ *	* @file contains the file structure pointing to the file being read by the kernel.
+ *	* @id kernel read file identifier
+ *	* @contents if a subsequent @kernel_post_read_file will be called.
+ *	* Return %0 if permission is granted.
+ *
+ * int kernel_post_read_file(struct file \*file, char \*buf, loff_t size, enum kernel_read_file_id id)
  *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@buf pointer to buffer containing the file contents.
- *	@size length of the file contents.
- *	@id kernel read file identifier
- *	This must be paired with a prior @kernel_read_file call that had
- *	@contents set to true.
- *	Return 0 if permission is granted.
- * @task_fix_setuid:
+ *
+ *	* @file contains the file structure pointing to the file being read by the kernel.
+ *	* @buf pointer to buffer containing the file contents.
+ *	* @size length of the file contents.
+ *	* @id kernel read file identifier. This must be paired with a prior @kernel_read_file() call that had @contents set to true.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_fix_setuid(struct cred \*new, const struct cred \*old, int flags)
  *	Update the module's state after setting one or more of the user
  *	identity attributes of the current process.  The @flags parameter
  *	indicates which of the set*uid system calls invoked this hook.  If
  *	@new is the set of credentials that will be installed.  Modifications
  *	should be made to this rather than to @current->cred.
  *	@old is the set of credentials that are being replaces
- *	@flags contains one of the LSM_SETID_* values.
- *	Return 0 on success.
- * @task_fix_setgid:
+ *	@flags contains one of the %LSM_SETID_\* values.
+ *
+ *	* Return %0 on success.
+ *
+ * int task_fix_setgid(struct cred \*new, const struct cred \*old, int flags)
  *	Update the module's state after setting one or more of the group
  *	identity attributes of the current process.  The @flags parameter
- *	indicates which of the set*gid system calls invoked this hook.
- *	@new is the set of credentials that will be installed.  Modifications
- *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaced.
- *	@flags contains one of the LSM_SETID_* values.
- *	Return 0 on success.
- * @task_setpgid:
+ *	indicates which of the set\*gid() system calls invoked this hook.
+ *
+ *	* @new is the set of credentials that will be installed.  Modifications should be made to this rather than to @current->cred.
+ *	* @old is the set of credentials that are being replaced.
+ *	* @flags contains one of the %LSM_SETID_\* values.
+ *	* Return %0 on success.
+ *
+ * int task_setpgid(struct task_struct \*p, pid_t pgid)
  *	Check permission before setting the process group identifier of the
  *	process @p to @pgid.
- *	@p contains the task_struct for process being modified.
- *	@pgid contains the new pgid.
- *	Return 0 if permission is granted.
- * @task_getpgid:
+ *
+ *	* @p contains the task_struct for process being modified.
+ *	* @pgid contains the new @pgid.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_getpgid(struct task_struct \*p)
  *	Check permission before getting the process group identifier of the
  *	process @p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @task_getsid:
+ *
+ *	* @p contains the task_struct for the process.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_getsid(struct task_struct \*p)
  *	Check permission before getting the session identifier of the process
  *	@p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @task_getsecid:
+ *
+ *	* @p contains the task_struct for the process.
+ *	* Return %0 if permission is granted.
+ *
+ * void task_getsecid(struct task_struct \*p, u32 \*secid)
  *	Retrieve the security identifier of the process @p.
- *	@p contains the task_struct for the process and place is into @secid.
- *	In case of failure, @secid will be set to zero.
  *
- * @task_setnice:
+ *	* @p contains the task_struct for the process and place is into @secid.
+ *	* In case of failure, @secid will be set to zero.
+ *
+ * int task_setnice(struct task_struct \*p, int nice)
  *	Check permission before setting the nice value of @p to @nice.
- *	@p contains the task_struct of process.
- *	@nice contains the new nice value.
- *	Return 0 if permission is granted.
- * @task_setioprio:
+ *
+ *	* @p contains the task_struct of process.
+ *	* @nice contains the new nice value.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_setioprio(struct task_struct \*p, int ioprio)
  *	Check permission before setting the ioprio value of @p to @ioprio.
- *	@p contains the task_struct of process.
- *	@ioprio contains the new ioprio value
- *	Return 0 if permission is granted.
- * @task_getioprio:
+ *
+ *	* @p contains the task_struct of process.
+ *	* @ioprio contains the new @ioprio value
+ *	* Return %0 if permission is granted.
+ *
+ * int task_getioprio(struct task_struct \*p)
  *	Check permission before getting the ioprio value of @p.
- *	@p contains the task_struct of process.
- *	Return 0 if permission is granted.
- * @task_prlimit:
+ *
+ *	* @p contains the task_struct of process.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_prlimit(const struct cred \*cred, const struct cred \*tcred, unsigned int flags)
  *	Check permission before getting and/or setting the resource limits of
  *	another task.
- *	@cred points to the cred structure for the current task.
- *	@tcred points to the cred structure for the target task.
- *	@flags contains the LSM_PRLIMIT_* flag bits indicating whether the
- *	resource limits are being read, modified, or both.
- *	Return 0 if permission is granted.
- * @task_setrlimit:
+ *
+ *	* @cred points to the @cred structure for the current task.
+ *	* @tcred points to the @cred structure for the target task.
+ *	* @flags contains the %LSM_PRLIMIT_\* flag bits indicating whether the resource limits are being read, modified, or both.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_setrlimit(struct task_struct \*p, unsigned int resource, struct rlimit \*new_rlim)
  *	Check permission before setting the resource limits of process @p
  *	for @resource to @new_rlim.  The old resource limit values can
  *	be examined by dereferencing (p->signal->rlim + resource).
- *	@p points to the task_struct for the target task's group leader.
- *	@resource contains the resource whose limit is being set.
- *	@new_rlim contains the new limits for @resource.
- *	Return 0 if permission is granted.
- * @task_setscheduler:
+ *
+ *	* @p points to the task_struct for the target task's group leader.
+ *	* @resource contains the resource whose limit is being set.
+ *	* @new_rlim contains the new limits for @resource.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_setscheduler(struct task_struct \*p)
  *	Check permission before setting scheduling policy and/or parameters of
  *	process @p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_getscheduler:
+ *
+ *	* @p contains the task_struct for process.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_getscheduler(struct task_struct \*p)
  *	Check permission before obtaining scheduling information for process
  *	@p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_movememory:
+ *
+ *	* @p contains the task_struct for process.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_movememory(struct task_struct \*p)
  *	Check permission before moving memory owned by process @p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_kill:
- *	Check permission before sending signal @sig to @p.  @info can be NULL,
- *	the constant 1, or a pointer to a kernel_siginfo structure.  If @info is 1 or
+ *
+ *	* @p contains the task_struct for process.
+ *	* Return %0 if permission is granted.
+ *
+ * int task_kill(struct task_struct \*p, struct kernel_siginfo \*info, int sig, const struct cred \*cred)
+ *	Check permission before sending signal @sig to @p.  @info can be %NULL,
+ *	the constant %1, or a pointer to a @kernel_siginfo structure.  If @info is %1 or
  *	SI_FROMKERNEL(info) is true, then the signal should be viewed as coming
  *	from the kernel and should typically be permitted.
- *	SIGIO signals are handled separately by the send_sigiotask hook in
- *	file_security_ops.
- *	@p contains the task_struct for process.
- *	@info contains the signal information.
- *	@sig contains the signal value.
- *	@cred contains the cred of the process where the signal originated, or
- *	NULL if the current task is the originator.
- *	Return 0 if permission is granted.
+ *	%SIGIO signals are handled separately by the @send_sigiotask() hook in
+ *	@file_security_ops().
+ *
+ *	* @p contains the task_struct for process.
+ *	* @info contains the signal information.
+ *	* @sig contains the signal value.
+ *	* @cred contains the cred of the process where the signal originated, or %NULL if the current task is the originator.
+ *	* Return %0 if permission is granted.
  * @task_prctl:
  *	Check permission before performing a process control operation on the
  *	current process.
-- 
2.29.2

