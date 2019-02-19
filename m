Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AA8C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F982147A
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 17:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfBSRIu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:08:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfBSRIu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 12:08:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 809D9C007345;
        Tue, 19 Feb 2019 17:08:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 453D05D970;
        Tue, 19 Feb 2019 17:08:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/10] teach move_mount(2) to work with OPEN_TREE_CLONE
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 17:08:46 +0000
Message-ID: <155059612649.17079.7287713053194562461.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 19 Feb 2019 17:08:49 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
attached by move_mount(2).

If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
to handle detached source.

That gives us equivalents of mount --bind and mount --rbind.

Thanks also to Alan Jenkins <alan.christopher.jenkins@gmail.com> for
providing a whole bunch of ways to break things using this interface.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f10122028a11..56423c60ac7e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1840,10 +1840,16 @@ void dissolve_on_fput(struct vfsmount *mnt)
 	namespace_lock();
 	lock_mount_hash();
 	ns = real_mount(mnt)->mnt_ns;
-	umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
+	if (ns) {
+		if (is_anon_ns(ns))
+			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
+		else
+			ns = NULL;
+	}
 	unlock_mount_hash();
 	namespace_unlock();
-	free_mnt_ns(ns);
+	if (ns)
+		free_mnt_ns(ns);
 }
 
 void drop_collected_mounts(struct vfsmount *mnt)
@@ -2079,6 +2085,10 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
+		if (source_mnt->mnt_ns) {
+			/* move from anon - the caller will destroy */
+			list_del_init(&source_mnt->mnt_ns->list);
+		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		commit_tree(source_mnt);
 	}
@@ -2537,13 +2547,37 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 	return 0;
 }
 
+/*
+ * Check that there aren't references to earlier/same mount namespaces in the
+ * specified subtree.  Such references can act as pins for mount namespaces
+ * that aren't checked by the mount-cycle checking code, thereby allowing
+ * cycles to be made.
+ */
+static bool check_for_nsfs_mounts(struct mount *subtree)
+{
+	struct mount *p;
+	bool ret = false;
+
+	lock_mount_hash();
+	for (p = subtree; p; p = next_mnt(p, subtree))
+		if (mnt_ns_loop(p->mnt.mnt_root))
+			goto out;
+
+	ret = true;
+out:
+	unlock_mount_hash();
+	return ret;
+}
+
 static int do_move_mount(struct path *old_path, struct path *new_path)
 {
 	struct path parent_path = {.mnt = NULL, .dentry = NULL};
+	struct mnt_namespace *ns;
 	struct mount *p;
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
+	bool attached;
 
 	mp = lock_mount(new_path);
 	if (IS_ERR(mp))
@@ -2551,12 +2585,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
+	attached = mnt_has_parent(old);
+	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	if (!check_mnt(p) || !check_mnt(old))
+	/* The mountpoint must be in our namespace. */
+	if (!check_mnt(p))
 		goto out;
 
-	if (!mnt_has_parent(old))
+	/* The thing moved should be either ours or completely unattached. */
+	if (attached && !check_mnt(old))
+		goto out;
+
+	if (!attached && !is_anon_ns(ns))
 		goto out;
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
@@ -2571,7 +2612,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
-	if (IS_MNT_SHARED(old->mnt_parent))
+	if (attached && IS_MNT_SHARED(old->mnt_parent))
 		goto out;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
@@ -2580,12 +2621,14 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
 		goto out;
 	err = -ELOOP;
+	if (!check_for_nsfs_mounts(old))
+		goto out;
 	for (; mnt_has_parent(p); p = p->mnt_parent)
 		if (p == old)
 			goto out;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   &parent_path);
+				   attached ? &parent_path : NULL);
 	if (err)
 		goto out;
 
@@ -2594,8 +2637,11 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	list_del_init(&old->mnt_expire);
 out:
 	unlock_mount(mp);
-	if (!err)
+	if (!err) {
 		path_put(&parent_path);
+		if (!attached)
+			free_mnt_ns(ns);
+	}
 	return err;
 }
 
@@ -3289,6 +3335,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 
 /*
  * Move a mount from one place to another.
+ * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
+ * used to copy a mount subtree.
  *
  * Note the flags value is a combination of MOVE_MOUNT_* flags.
  */

