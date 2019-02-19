Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C602C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A78F21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfBSQ2W (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbfBSQ2W (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7FCD8046D;
        Tue, 19 Feb 2019 16:28:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 147D119C57;
        Tue, 19 Feb 2019 16:28:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 02/43] cgroup: saner refcounting for cgroup_root
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:28:13 +0000
Message-ID: <155059369332.12449.14447911414340183902.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:28:21 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

* make the reference from superblock to cgroup_root counting -
do cgroup_put() in cgroup_kill_sb() whether we'd done
percpu_ref_kill() or not; matching grab is done when we allocate
a new root.  That gives the same refcounting rules for all callers
of cgroup_do_mount() - a reference to cgroup_root has been grabbed
by caller and it either is transferred to new superblock or dropped.

* have cgroup_kill_sb() treat an already killed refcount as "just
don't bother killing it, then".

* after successful cgroup_do_mount() have cgroup1_mount() recheck
if we'd raced with mount/umount from somebody else and cgroup_root
got killed.  In that case we drop the superblock and bugger off
with -ERESTARTSYS, same as if we'd found it in the list already
dying.

* don't bother with delayed initialization of refcount - it's
unreliable and not needed.  No need to prevent attempts to bump
the refcount if we find cgroup_root of another mount in progress -
sget will reuse an existing superblock just fine and if the
other sb manages to die before we get there, we'll catch
that immediately after cgroup_do_mount().

* don't bother with kernfs_pin_sb() - no need for doing that
either.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 kernel/cgroup/cgroup-internal.h |    2 +
 kernel/cgroup/cgroup-v1.c       |   58 +++++++++------------------------------
 kernel/cgroup/cgroup.c          |   16 +++++------
 3 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c950864016e2..c9a35f09e4b9 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -198,7 +198,7 @@ int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
 
 void cgroup_free_root(struct cgroup_root *root);
 void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts);
-int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags);
+int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask);
 int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask);
 struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 			       struct cgroup_root *root, unsigned long magic,
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 583b969b0c0e..f94a7229974e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -1116,13 +1116,11 @@ struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 			     void *data, unsigned long magic,
 			     struct cgroup_namespace *ns)
 {
-	struct super_block *pinned_sb = NULL;
 	struct cgroup_sb_opts opts;
 	struct cgroup_root *root;
 	struct cgroup_subsys *ss;
 	struct dentry *dentry;
 	int i, ret;
-	bool new_root = false;
 
 	cgroup_lock_and_drain_offline(&cgrp_dfl_root.cgrp);
 
@@ -1184,29 +1182,6 @@ struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 		if (root->flags ^ opts.flags)
 			pr_warn("new mount options do not match the existing superblock, will be ignored\n");
 
-		/*
-		 * We want to reuse @root whose lifetime is governed by its
-		 * ->cgrp.  Let's check whether @root is alive and keep it
-		 * that way.  As cgroup_kill_sb() can happen anytime, we
-		 * want to block it by pinning the sb so that @root doesn't
-		 * get killed before mount is complete.
-		 *
-		 * With the sb pinned, tryget_live can reliably indicate
-		 * whether @root can be reused.  If it's being killed,
-		 * drain it.  We can use wait_queue for the wait but this
-		 * path is super cold.  Let's just sleep a bit and retry.
-		 */
-		pinned_sb = kernfs_pin_sb(root->kf_root, NULL);
-		if (IS_ERR(pinned_sb) ||
-		    !percpu_ref_tryget_live(&root->cgrp.self.refcnt)) {
-			mutex_unlock(&cgroup_mutex);
-			if (!IS_ERR_OR_NULL(pinned_sb))
-				deactivate_super(pinned_sb);
-			msleep(10);
-			ret = restart_syscall();
-			goto out_free;
-		}
-
 		ret = 0;
 		goto out_unlock;
 	}
@@ -1232,15 +1207,20 @@ struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
-	new_root = true;
 
 	init_cgroup_root(root, &opts);
 
-	ret = cgroup_setup_root(root, opts.subsys_mask, PERCPU_REF_INIT_DEAD);
+	ret = cgroup_setup_root(root, opts.subsys_mask);
 	if (ret)
 		cgroup_free_root(root);
 
 out_unlock:
+	if (!ret && !percpu_ref_tryget_live(&root->cgrp.self.refcnt)) {
+		mutex_unlock(&cgroup_mutex);
+		msleep(10);
+		ret = restart_syscall();
+		goto out_free;
+	}
 	mutex_unlock(&cgroup_mutex);
 out_free:
 	kfree(opts.release_agent);
@@ -1252,25 +1232,13 @@ struct dentry *cgroup1_mount(struct file_system_type *fs_type, int flags,
 	dentry = cgroup_do_mount(&cgroup_fs_type, flags, root,
 				 CGROUP_SUPER_MAGIC, ns);
 
-	/*
-	 * There's a race window after we release cgroup_mutex and before
-	 * allocating a superblock. Make sure a concurrent process won't
-	 * be able to re-use the root during this window by delaying the
-	 * initialization of root refcnt.
-	 */
-	if (new_root) {
-		mutex_lock(&cgroup_mutex);
-		percpu_ref_reinit(&root->cgrp.self.refcnt);
-		mutex_unlock(&cgroup_mutex);
+	if (!IS_ERR(dentry) && percpu_ref_is_dying(&root->cgrp.self.refcnt)) {
+		struct super_block *sb = dentry->d_sb;
+		dput(dentry);
+		deactivate_locked_super(sb);
+		msleep(10);
+		dentry = ERR_PTR(restart_syscall());
 	}
-
-	/*
-	 * If @pinned_sb, we're reusing an existing root and holding an
-	 * extra ref on its sb.  Mount is complete.  Put the extra ref.
-	 */
-	if (pinned_sb)
-		deactivate_super(pinned_sb);
-
 	return dentry;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 503bba3c4bae..7fd9f22e406d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1927,7 +1927,7 @@ void init_cgroup_root(struct cgroup_root *root, struct cgroup_sb_opts *opts)
 		set_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags);
 }
 
-int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
+int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 {
 	LIST_HEAD(tmp_links);
 	struct cgroup *root_cgrp = &root->cgrp;
@@ -1944,7 +1944,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
 	root_cgrp->ancestor_ids[0] = ret;
 
 	ret = percpu_ref_init(&root_cgrp->self.refcnt, css_release,
-			      ref_flags, GFP_KERNEL);
+			      0, GFP_KERNEL);
 	if (ret)
 		goto out;
 
@@ -2121,18 +2121,16 @@ static void cgroup_kill_sb(struct super_block *sb)
 	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
 
 	/*
-	 * If @root doesn't have any mounts or children, start killing it.
+	 * If @root doesn't have any children, start killing it.
 	 * This prevents new mounts by disabling percpu_ref_tryget_live().
 	 * cgroup_mount() may wait for @root's release.
 	 *
 	 * And don't kill the default root.
 	 */
-	if (!list_empty(&root->cgrp.self.children) ||
-	    root == &cgrp_dfl_root)
-		cgroup_put(&root->cgrp);
-	else
+	if (list_empty(&root->cgrp.self.children) && root != &cgrp_dfl_root &&
+	    !percpu_ref_is_dying(&root->cgrp.self.refcnt))
 		percpu_ref_kill(&root->cgrp.self.refcnt);
-
+	cgroup_put(&root->cgrp);
 	kernfs_kill_sb(sb);
 }
 
@@ -5402,7 +5400,7 @@ int __init cgroup_init(void)
 	hash_add(css_set_table, &init_css_set.hlist,
 		 css_set_hash(init_css_set.subsys));
 
-	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0, 0));
+	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
 
 	mutex_unlock(&cgroup_mutex);
 

