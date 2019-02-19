Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB5C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408AC21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfBSQ3J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbfBSQ3J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33775C704B;
        Tue, 19 Feb 2019 16:29:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D577D19C68;
        Tue, 19 Feb 2019 16:29:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/43] saner handling of temporary namespaces
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:03 +0000
Message-ID: <155059374364.12449.13897776439989704741.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 19 Feb 2019 16:29:09 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

mount_subtree() creates (and soon destroys) a temporary namespace,
so that automounts could function normally.  These beasts should
never become anyone's current namespaces; they don't, but it would
be better to make prevention of that more straightforward.  And
since they don't become anyone's current namespace, we don't need
to bother with reserving procfs inums for those.

Teach alloc_mnt_ns() to skip inum allocation if told so, adjust
put_mnt_ns() accordingly, make mount_subtree() use temporary
(anon) namespace.  is_anon_ns() checks if a namespace is such.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/mount.h     |    5 ++++
 fs/namespace.c |   74 ++++++++++++++++++++++++++------------------------------
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index f39bc9da4d73..6250de544760 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -146,3 +146,8 @@ static inline bool is_local_mountpoint(struct dentry *dentry)
 
 	return __is_local_mountpoint(dentry);
 }
+
+static inline bool is_anon_ns(struct mnt_namespace *ns)
+{
+	return ns->seq == 0;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 9ed2f2930dfd..f0b8a8ca08df 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2873,7 +2873,8 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
-	ns_free_inum(&ns->ns);
+	if (!is_anon_ns(ns))
+		ns_free_inum(&ns->ns);
 	dec_mnt_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	kfree(ns);
@@ -2888,7 +2889,7 @@ static void free_mnt_ns(struct mnt_namespace *ns)
  */
 static atomic64_t mnt_ns_seq = ATOMIC64_INIT(1);
 
-static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns)
+static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool anon)
 {
 	struct mnt_namespace *new_ns;
 	struct ucounts *ucounts;
@@ -2898,28 +2899,27 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns)
 	if (!ucounts)
 		return ERR_PTR(-ENOSPC);
 
-	new_ns = kmalloc(sizeof(struct mnt_namespace), GFP_KERNEL);
+	new_ns = kzalloc(sizeof(struct mnt_namespace), GFP_KERNEL);
 	if (!new_ns) {
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(-ENOMEM);
 	}
-	ret = ns_alloc_inum(&new_ns->ns);
-	if (ret) {
-		kfree(new_ns);
-		dec_mnt_namespaces(ucounts);
-		return ERR_PTR(ret);
+	if (!anon) {
+		ret = ns_alloc_inum(&new_ns->ns);
+		if (ret) {
+			kfree(new_ns);
+			dec_mnt_namespaces(ucounts);
+			return ERR_PTR(ret);
+		}
 	}
 	new_ns->ns.ops = &mntns_operations;
-	new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
+	if (!anon)
+		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
 	atomic_set(&new_ns->count, 1);
-	new_ns->root = NULL;
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
-	new_ns->event = 0;
 	new_ns->user_ns = get_user_ns(user_ns);
 	new_ns->ucounts = ucounts;
-	new_ns->mounts = 0;
-	new_ns->pending_mounts = 0;
 	return new_ns;
 }
 
@@ -2943,7 +2943,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 
 	old = ns->root;
 
-	new_ns = alloc_mnt_ns(user_ns);
+	new_ns = alloc_mnt_ns(user_ns, false);
 	if (IS_ERR(new_ns))
 		return new_ns;
 
@@ -3003,37 +3003,25 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	return new_ns;
 }
 
-/**
- * create_mnt_ns - creates a private namespace and adds a root filesystem
- * @mnt: pointer to the new root filesystem mountpoint
- */
-static struct mnt_namespace *create_mnt_ns(struct vfsmount *m)
-{
-	struct mnt_namespace *new_ns = alloc_mnt_ns(&init_user_ns);
-	if (!IS_ERR(new_ns)) {
-		struct mount *mnt = real_mount(m);
-		mnt->mnt_ns = new_ns;
-		new_ns->root = mnt;
-		new_ns->mounts++;
-		list_add(&mnt->mnt_list, &new_ns->list);
-	} else {
-		mntput(m);
-	}
-	return new_ns;
-}
-
-struct dentry *mount_subtree(struct vfsmount *mnt, const char *name)
+struct dentry *mount_subtree(struct vfsmount *m, const char *name)
 {
+	struct mount *mnt = real_mount(m);
 	struct mnt_namespace *ns;
 	struct super_block *s;
 	struct path path;
 	int err;
 
-	ns = create_mnt_ns(mnt);
-	if (IS_ERR(ns))
+	ns = alloc_mnt_ns(&init_user_ns, true);
+	if (IS_ERR(ns)) {
+		mntput(m);
 		return ERR_CAST(ns);
+	}
+	mnt->mnt_ns = ns;
+	ns->root = mnt;
+	ns->mounts++;
+	list_add(&mnt->mnt_list, &ns->list);
 
-	err = vfs_path_lookup(mnt->mnt_root, mnt,
+	err = vfs_path_lookup(m->mnt_root, m,
 			name, LOOKUP_FOLLOW|LOOKUP_AUTOMOUNT, &path);
 
 	put_mnt_ns(ns);
@@ -3243,6 +3231,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
+	struct mount *m;
 	struct mnt_namespace *ns;
 	struct path root;
 	struct file_system_type *type;
@@ -3255,10 +3244,14 @@ static void __init init_mount_tree(void)
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	ns = create_mnt_ns(mnt);
+	ns = alloc_mnt_ns(&init_user_ns, false);
 	if (IS_ERR(ns))
 		panic("Can't allocate initial namespace");
-
+	m = real_mount(mnt);
+	m->mnt_ns = ns;
+	ns->root = m;
+	ns->mounts = 1;
+	list_add(&m->mnt_list, &ns->list);
 	init_task.nsproxy->mnt_ns = ns;
 	get_mnt_ns(ns);
 
@@ -3499,6 +3492,9 @@ static int mntns_install(struct nsproxy *nsproxy, struct ns_common *ns)
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	if (is_anon_ns(mnt_ns))
+		return -EINVAL;
+
 	if (fs->users != 1)
 		return -EINVAL;
 

