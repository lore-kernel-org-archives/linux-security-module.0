Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5EAC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D8B21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfBSQ2N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfBSQ2N (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 237A7820E9;
        Tue, 19 Feb 2019 16:28:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B719E1835A;
        Tue, 19 Feb 2019 16:28:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/43] fix cgroup_do_mount() handling of failure exits
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     stable@kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:28:06 +0000
Message-ID: <155059368597.12449.3144063971030696984.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 19 Feb 2019 16:28:13 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

same story as with last May fixes in sysfs (7b745a4e4051
"unfuck sysfs_mount()"); new_sb is left uninitialized
in case of early errors in kernfs_mount_ns() and papering
over it by treating any error from kernfs_mount_ns() as
equivalent to !new_ns ends up conflating the cases when
objects had never been transferred to a superblock with
ones when that has happened and resulting new superblock
had been dropped.  Easily fixed (same way as in sysfs
case).  Additionally, there's a superblock leak on
kernfs_node_dentry() failure *and* a dentry leak inside
kernfs_node_dentry() itself - the latter on probably
impossible errors, but the former not impossible to trigger
(as the matter of fact, injecting allocation failures
at that point *does* trigger it).

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/kernfs/mount.c      |    8 ++++++--
 kernel/cgroup/cgroup.c |    9 ++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index fdf527b6d79c..d71c9405874a 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -196,8 +196,10 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 		return dentry;
 
 	knparent = find_next_ancestor(kn, NULL);
-	if (WARN_ON(!knparent))
+	if (WARN_ON(!knparent)) {
+		dput(dentry);
 		return ERR_PTR(-EINVAL);
+	}
 
 	do {
 		struct dentry *dtmp;
@@ -206,8 +208,10 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 		if (kn == knparent)
 			return dentry;
 		kntmp = find_next_ancestor(kn, knparent);
-		if (WARN_ON(!kntmp))
+		if (WARN_ON(!kntmp)) {
+			dput(dentry);
 			return ERR_PTR(-EINVAL);
+		}
 		dtmp = lookup_one_len_unlocked(kntmp->name, dentry,
 					       strlen(kntmp->name));
 		dput(dentry);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f31bd61c9466..503bba3c4bae 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2033,7 +2033,7 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 			       struct cgroup_namespace *ns)
 {
 	struct dentry *dentry;
-	bool new_sb;
+	bool new_sb = false;
 
 	dentry = kernfs_mount(fs_type, flags, root->kf_root, magic, &new_sb);
 
@@ -2043,6 +2043,7 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 	 */
 	if (!IS_ERR(dentry) && ns != &init_cgroup_ns) {
 		struct dentry *nsdentry;
+		struct super_block *sb = dentry->d_sb;
 		struct cgroup *cgrp;
 
 		mutex_lock(&cgroup_mutex);
@@ -2053,12 +2054,14 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 		spin_unlock_irq(&css_set_lock);
 		mutex_unlock(&cgroup_mutex);
 
-		nsdentry = kernfs_node_dentry(cgrp->kn, dentry->d_sb);
+		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(dentry);
+		if (IS_ERR(nsdentry))
+			deactivate_locked_super(sb);
 		dentry = nsdentry;
 	}
 
-	if (IS_ERR(dentry) || !new_sb)
+	if (!new_sb)
 		cgroup_put(&root->cgrp);
 
 	return dentry;

