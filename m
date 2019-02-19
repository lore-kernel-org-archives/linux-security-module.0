Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF320C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40A821738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfBSQ3m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbfBSQ3m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F97987638;
        Tue, 19 Feb 2019 16:29:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F241A5D6AA;
        Tue, 19 Feb 2019 16:29:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/43] new helper: do_new_mount_fc()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:39 +0000
Message-ID: <155059377923.12449.15324572719021896571.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 16:29:41 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Create an fs_context-aware version of do_new_mount().  This takes an
fs_context with a superblock already attached to it.

Make do_new_mount() use do_new_mount_fc() rather than do_new_mount(); this
allows the consolidation of the mount creation, check and add steps.

To make this work, mount_too_revealing() is changed to take a superblock
rather than a mount (which the fs_context doesn't have available), allowing
this check to be done before the mount object is created.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c |   65 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0354cb6ac2d3..f629e1c7f3cc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2523,7 +2523,37 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 	return err;
 }
 
-static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags);
+static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
+
+/*
+ * Create a new mount using a superblock configuration and request it
+ * be added to the namespace tree.
+ */
+static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags)
+{
+	struct vfsmount *mnt;
+	struct super_block *sb = fc->root->d_sb;
+	int error;
+
+	if (mount_too_revealing(sb, &mnt_flags)) {
+		dput(fc->root);
+		fc->root = NULL;
+		deactivate_locked_super(sb);
+		return -EPERM;
+	}
+
+	up_write(&sb->s_umount);
+
+	mnt = vfs_create_mount(fc);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
+	if (error < 0)
+		mntput(mnt);
+	return error;
+}
 
 /*
  * create a new mount for userspace and request it to be added into the
@@ -2533,7 +2563,6 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 			int mnt_flags, const char *name, void *data)
 {
 	struct file_system_type *type;
-	struct vfsmount *mnt;
 	struct fs_context *fc;
 	const char *subtype = NULL;
 	int err = 0;
@@ -2577,26 +2606,9 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err)
 		err = vfs_get_tree(fc);
-	if (err)
-		goto out;
-
-	up_write(&fc->root->d_sb->s_umount);
-	mnt = vfs_create_mount(fc);
-	if (IS_ERR(mnt)) {
-		err = PTR_ERR(mnt);
-		goto out;
-	}
-
-	if (mount_too_revealing(mnt, &mnt_flags)) {
-		mntput(mnt);
-		err = -EPERM;
-		goto out;
-	}
+	if (!err)
+		err = do_new_mount_fc(fc, path, mnt_flags);
 
-	err = do_add_mount(real_mount(mnt), path, mnt_flags);
-	if (err)
-		mntput(mnt);
-out:
 	put_fs_context(fc);
 	return err;
 }
@@ -3421,7 +3433,8 @@ bool current_chrooted(void)
 	return chrooted;
 }
 
-static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
+static bool mnt_already_visible(struct mnt_namespace *ns,
+				const struct super_block *sb,
 				int *new_mnt_flags)
 {
 	int new_flags = *new_mnt_flags;
@@ -3433,7 +3446,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 		struct mount *child;
 		int mnt_flags;
 
-		if (mnt->mnt.mnt_sb->s_type != new->mnt_sb->s_type)
+		if (mnt->mnt.mnt_sb->s_type != sb->s_type)
 			continue;
 
 		/* This mount is not fully visible if it's root directory
@@ -3484,7 +3497,7 @@ static bool mnt_already_visible(struct mnt_namespace *ns, struct vfsmount *new,
 	return visible;
 }
 
-static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
+static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
 {
 	const unsigned long required_iflags = SB_I_NOEXEC | SB_I_NODEV;
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
@@ -3494,7 +3507,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return false;
 
 	/* Can this filesystem be too revealing? */
-	s_iflags = mnt->mnt_sb->s_iflags;
+	s_iflags = sb->s_iflags;
 	if (!(s_iflags & SB_I_USERNS_VISIBLE))
 		return false;
 
@@ -3504,7 +3517,7 @@ static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags)
 		return true;
 	}
 
-	return !mnt_already_visible(ns, mnt, new_mnt_flags);
+	return !mnt_already_visible(ns, sb, new_mnt_flags);
 }
 
 bool mnt_may_suid(struct vfsmount *mnt)

