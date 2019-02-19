Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50983C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E52070B
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfBSQ27 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfBSQ27 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71564C049E24;
        Tue, 19 Feb 2019 16:28:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F23E5D6AA;
        Tue, 19 Feb 2019 16:28:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/43] separate copying and locking mount tree on
 cross-userns copies
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:28:37 +0000
Message-ID: <155059371731.12449.5751025556744658291.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 16:28:58 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Rather than having propagate_mnt() check doing unprivileged copies,
lock them before commit_tree().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c |   59 +++++++++++++++++++++++++++++++++++---------------------
 fs/pnode.c     |    5 -----
 fs/pnode.h     |    3 +--
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a677b59efd74..9ed2f2930dfd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1013,27 +1013,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
 	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
-	/* Don't allow unprivileged users to change mount flags */
-	if (flag & CL_UNPRIVILEGED) {
-		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
-
-		if (mnt->mnt.mnt_flags & MNT_READONLY)
-			mnt->mnt.mnt_flags |= MNT_LOCK_READONLY;
-
-		if (mnt->mnt.mnt_flags & MNT_NODEV)
-			mnt->mnt.mnt_flags |= MNT_LOCK_NODEV;
-
-		if (mnt->mnt.mnt_flags & MNT_NOSUID)
-			mnt->mnt.mnt_flags |= MNT_LOCK_NOSUID;
-
-		if (mnt->mnt.mnt_flags & MNT_NOEXEC)
-			mnt->mnt.mnt_flags |= MNT_LOCK_NOEXEC;
-	}
-
-	/* Don't allow unprivileged users to reveal what is under a mount */
-	if ((flag & CL_UNPRIVILEGED) &&
-	    (!(flag & CL_EXPIRE) || list_empty(&old->mnt_expire)))
-		mnt->mnt.mnt_flags |= MNT_LOCKED;
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_sb = sb;
@@ -1837,6 +1816,33 @@ int iterate_mounts(int (*f)(struct vfsmount *, void *), void *arg,
 	return 0;
 }
 
+static void lock_mnt_tree(struct mount *mnt)
+{
+	struct mount *p;
+
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		int flags = p->mnt.mnt_flags;
+		/* Don't allow unprivileged users to change mount flags */
+		flags |= MNT_LOCK_ATIME;
+
+		if (flags & MNT_READONLY)
+			flags |= MNT_LOCK_READONLY;
+
+		if (flags & MNT_NODEV)
+			flags |= MNT_LOCK_NODEV;
+
+		if (flags & MNT_NOSUID)
+			flags |= MNT_LOCK_NOSUID;
+
+		if (flags & MNT_NOEXEC)
+			flags |= MNT_LOCK_NOEXEC;
+		/* Don't allow unprivileged users to reveal what is under a mount */
+		if (list_empty(&p->mnt_expire))
+			flags |= MNT_LOCKED;
+		p->mnt.mnt_flags = flags;
+	}
+}
+
 static void cleanup_group_ids(struct mount *mnt, struct mount *end)
 {
 	struct mount *p;
@@ -1954,6 +1960,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			struct mountpoint *dest_mp,
 			struct path *parent_path)
 {
+	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
 	struct mountpoint *smp;
@@ -2004,6 +2011,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				 child->mnt_mountpoint);
 		if (q)
 			mnt_change_mountpoint(child, smp, q);
+		/* Notice when we are propagating across user namespaces */
+		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
+			lock_mnt_tree(child);
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
@@ -2941,13 +2951,18 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	/* First pass: copy the tree topology */
 	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
-		copy_flags |= CL_SHARED_TO_SLAVE | CL_UNPRIVILEGED;
+		copy_flags |= CL_SHARED_TO_SLAVE;
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
 		free_mnt_ns(new_ns);
 		return ERR_CAST(new);
 	}
+	if (user_ns != ns->user_ns) {
+		lock_mount_hash();
+		lock_mnt_tree(new);
+		unlock_mount_hash();
+	}
 	new_ns->root = new;
 	list_add_tail(&new_ns->list, &new->mnt_list);
 
diff --git a/fs/pnode.c b/fs/pnode.c
index 1100e810d855..7ea6cfb65077 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -214,7 +214,6 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 }
 
 /* all accesses are serialized by namespace_sem */
-static struct user_namespace *user_ns;
 static struct mount *last_dest, *first_source, *last_source, *dest_master;
 static struct mountpoint *mp;
 static struct hlist_head *list;
@@ -260,9 +259,6 @@ static int propagate_one(struct mount *m)
 			type |= CL_MAKE_SHARED;
 	}
 		
-	/* Notice when we are propagating across user namespaces */
-	if (m->mnt_ns->user_ns != user_ns)
-		type |= CL_UNPRIVILEGED;
 	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
 	if (IS_ERR(child))
 		return PTR_ERR(child);
@@ -303,7 +299,6 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	 * propagate_one(); everything is serialized by namespace_sem,
 	 * so globals will do just fine.
 	 */
-	user_ns = current->nsproxy->mnt_ns->user_ns;
 	last_dest = dest_mnt;
 	first_source = source_mnt;
 	last_source = source_mnt;
diff --git a/fs/pnode.h b/fs/pnode.h
index dc87e65becd2..3960a83666cf 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -27,8 +27,7 @@
 #define CL_MAKE_SHARED 		0x08
 #define CL_PRIVATE 		0x10
 #define CL_SHARED_TO_SLAVE	0x20
-#define CL_UNPRIVILEGED		0x40
-#define CL_COPY_MNT_NS_FILE	0x80
+#define CL_COPY_MNT_NS_FILE	0x40
 
 #define CL_COPY_ALL		(CL_COPY_UNBINDABLE | CL_COPY_MNT_NS_FILE)
 

