Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE59C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908F21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBSQ3t (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfBSQ3t (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7C3958E5C;
        Tue, 19 Feb 2019 16:29:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637575D970;
        Tue, 19 Feb 2019 16:29:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/43] vfs_get_tree(): evict the call of
 security_sb_kern_mount()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:46 +0000
Message-ID: <155059378660.12449.1465968920527134556.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 16:29:48 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Right now vfs_get_tree() calls security_sb_kern_mount() (i.e.
mount MAC) unless it gets MS_KERNMOUNT or MS_SUBMOUNT in flags.
Doing it that way is both clumsy and imprecise.

Consider the callers' tree of vfs_get_tree():
vfs_get_tree()
        <- do_new_mount()
	<- vfs_kern_mount()
		<- simple_pin_fs()
		<- vfs_submount()
		<- kern_mount_data()
		<- init_mount_tree()
		<- btrfs_mount()
			<- vfs_get_tree()
		<- nfs_do_root_mount()
			<- nfs4_try_mount()
				<- nfs_fs_mount()
					<- vfs_get_tree()
			<- nfs4_referral_mount()

do_new_mount() always does need MAC (we are guaranteed that neither
MS_KERNMOUNT nor MS_SUBMOUNT will be passed there).

simple_pin_fs(), vfs_submount() and kern_mount_data() pass explicit
flags inhibiting that check.  So does nfs4_referral_mount() (the
flags there are ulimately coming from vfs_submount()).

init_mount_tree() is called too early for anything LSM-related; it
doesn't matter whether we attempt those checks, they'll do nothing.

Finally, in case of btrfs_mount() and nfs_fs_mount(), doing MAC
is pointless - either the caller will do it, or the flags are
such that we wouldn't have done it either.

In other words, the one and only case when we want that check
done is when we are called from do_new_mount(), and there we
want it unconditionally.

So let's simply move it there.  The superblock is still locked,
so nobody is going to get access to it (via ustat(2), etc.)
until we get a chance to apply the checks - we are free to
move them to any point up to where we drop ->s_umount (in
do_new_mount_fc()).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/fs_context.c |    8 ++++++++
 fs/internal.h   |    1 +
 fs/namespace.c  |   12 +++++++-----
 fs/super.c      |   15 +++------------
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 4294091b689d..857cd46a687b 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -90,6 +90,14 @@ struct fs_context *fs_context_for_mount(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(fs_context_for_mount);
 
+void fc_drop_locked(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	dput(fc->root);
+	fc->root = NULL;
+	deactivate_locked_super(sb);
+}
+
 static void legacy_fs_context_free(struct fs_context *fc);
 /**
  * put_fs_context - Dispose of a superblock configuration context.
diff --git a/fs/internal.h b/fs/internal.h
index f85c3212d25d..6af26d897034 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -57,6 +57,7 @@ extern void __init chrdev_init(void);
  */
 extern int legacy_get_tree(struct fs_context *fc);
 extern int parse_monolithic_mount_data(struct fs_context *, void *);
+extern void fc_drop_locked(struct fs_context *);
 
 /*
  * namei.c
diff --git a/fs/namespace.c b/fs/namespace.c
index f629e1c7f3cc..750500c6c33d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2536,11 +2536,13 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	struct super_block *sb = fc->root->d_sb;
 	int error;
 
-	if (mount_too_revealing(sb, &mnt_flags)) {
-		dput(fc->root);
-		fc->root = NULL;
-		deactivate_locked_super(sb);
-		return -EPERM;
+	error = security_sb_kern_mount(sb);
+	if (!error && mount_too_revealing(sb, &mnt_flags))
+		error = -EPERM;
+
+	if (unlikely(error)) {
+		fc_drop_locked(fc);
+		return error;
 	}
 
 	up_write(&sb->s_umount);
diff --git a/fs/super.c b/fs/super.c
index b91b6df05b67..11e2a6cb3baf 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1277,13 +1277,9 @@ int vfs_get_tree(struct fs_context *fc)
 	sb->s_flags |= SB_BORN;
 
 	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
-	if (error)
-		goto out_sb;
-
-	if (!(fc->sb_flags & (MS_KERNMOUNT|MS_SUBMOUNT))) {
-		error = security_sb_kern_mount(sb);
-		if (error)
-			goto out_sb;
+	if (unlikely(error)) {
+		fc_drop_locked(fc);
+		return error;
 	}
 
 	/*
@@ -1296,11 +1292,6 @@ int vfs_get_tree(struct fs_context *fc)
 		"negative value (%lld)\n", fc->fs_type->name, sb->s_maxbytes);
 
 	return 0;
-out_sb:
-	dput(fc->root);
-	fc->root = NULL;
-	deactivate_locked_super(sb);
-	return error;
 }
 EXPORT_SYMBOL(vfs_get_tree);
 

