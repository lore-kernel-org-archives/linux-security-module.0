Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36BC10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CFB2147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfBSRJg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:09:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfBSRJf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:09:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68E4CC007320;
        Tue, 19 Feb 2019 17:09:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F3F9560BE8;
        Tue, 19 Feb 2019 17:09:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/10] vfs: syscall: Add fspick() to select a superblock for
 reconfiguration
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:09:33 +0000
Message-ID: <155059617323.17079.2377064615299669557.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 17:09:35 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provide an fspick() system call that can be used to pick an existing
mountpoint into an fs_context which can thereafter be used to reconfigure a
superblock (equivalent of the superblock side of -o remount).

This looks like:

	int fd = fspick(AT_FDCWD, "/mnt",
			FSPICK_CLOEXEC | FSPICK_NO_AUTOMOUNT);
	fsconfig(fd, FSCONFIG_SET_FLAG, "intr", NULL, 0);
	fsconfig(fd, FSCONFIG_SET_FLAG, "noac", NULL, 0);
	fsconfig(fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);

At the point of fspick being called, the file descriptor referring to the
filesystem context is in exactly the same state as the one that was created
by fsopen() after fsmount() has been successfully called.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-api@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 fs/fsopen.c                            |   57 ++++++++++++++++++++++++++++++++
 include/linux/syscalls.h               |    1 +
 include/uapi/linux/mount.h             |    8 ++++
 5 files changed, 68 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c78b68256f8a..d1eb6c815790 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -403,3 +403,4 @@
 389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
 390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
+392	i386	fspick			sys_fspick			__ia32_sys_fspick
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d44ead5d4368..d3ab703c02bb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -348,6 +348,7 @@
 337	common	fsopen			__x64_sys_fsopen
 338	common	fsconfig		__x64_sys_fsconfig
 339	common	fsmount			__x64_sys_fsmount
+340	common	fspick			__x64_sys_fspick
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 65cc2f68f994..3bb9c0c8cbcc 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -156,6 +156,63 @@ SYSCALL_DEFINE2(fsopen, const char __user *, _fs_name, unsigned int, flags)
 	return ret;
 }
 
+/*
+ * Pick a superblock into a context for reconfiguration.
+ */
+SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
+{
+	struct fs_context *fc;
+	struct path target;
+	unsigned int lookup_flags;
+	int ret;
+
+	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if ((flags & ~(FSPICK_CLOEXEC |
+		       FSPICK_SYMLINK_NOFOLLOW |
+		       FSPICK_NO_AUTOMOUNT |
+		       FSPICK_EMPTY_PATH)) != 0)
+		return -EINVAL;
+
+	lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_SYMLINK_NOFOLLOW)
+		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & FSPICK_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (flags & FSPICK_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+	ret = user_path_at(dfd, path, lookup_flags, &target);
+	if (ret < 0)
+		goto err;
+
+	ret = -EINVAL;
+	if (target.mnt->mnt_root != target.dentry)
+		goto err_path;
+
+	fc = fs_context_for_reconfigure(target.dentry, 0, 0);
+	if (IS_ERR(fc)) {
+		ret = PTR_ERR(fc);
+		goto err_path;
+	}
+
+	fc->phase = FS_CONTEXT_RECONF_PARAMS;
+
+	ret = fscontext_alloc_log(fc);
+	if (ret < 0)
+		goto err_fc;
+
+	path_put(&target);
+	return fscontext_create_fd(fc, flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0);
+
+err_fc:
+	put_fs_context(fc);
+err_path:
+	path_put(&target);
+err:
+	return ret;
+}
+
 /*
  * Check the state and apply the configuration.  Note that this function is
  * allowed to 'steal' the value by setting param->xxx to NULL before returning.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a332a731a0e4..c3f9d865b91d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -934,6 +934,7 @@ asmlinkage long sys_fsopen(const char __user *fs_name, unsigned int flags);
 asmlinkage long sys_fsconfig(int fs_fd, unsigned int cmd, const char __user *key,
 			     const void __user *value, int aux);
 asmlinkage long sys_fsmount(int fs_fd, unsigned int flags, unsigned int ms_flags);
+asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 3888d3b91dc5..96a0240f23fe 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -77,6 +77,14 @@
  */
 #define FSOPEN_CLOEXEC		0x00000001
 
+/*
+ * fspick() flags.
+ */
+#define FSPICK_CLOEXEC		0x00000001
+#define FSPICK_SYMLINK_NOFOLLOW	0x00000002
+#define FSPICK_NO_AUTOMOUNT	0x00000004
+#define FSPICK_EMPTY_PATH	0x00000008
+
 /*
  * The type of fsconfig() call made.
  */

