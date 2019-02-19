Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBFC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2583821738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbfBSQ3e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:29:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfBSQ3e (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:29:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08735599C2;
        Tue, 19 Feb 2019 16:29:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A90BE60C1D;
        Tue, 19 Feb 2019 16:29:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/43] teach vfs_get_tree() to handle subtype,
 switch do_new_mount() to it
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:29:30 +0000
Message-ID: <155059377086.12449.48912929800325479.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:29:34 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

Roll the handling of subtypes into do_new_mount() and vfs_get_tree().  The
former determines any subtype string and hangs it off the fs_context; the
latter applies it.

Make do_new_mount() create, parameterise and commit an fs_context and
create a mount for itself rather than calling vfs_kern_mount().

[AV -- missing kstrdup()]
[AV -- ... and no kstrdup() if we get to setting ->s_submount - we
simply transfer it from fc, leaving NULL behind]
[AV -- constify ->s_submount, while we are at it]

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c     |   77 +++++++++++++++++++++++++++++++---------------------
 fs/super.c         |    5 +++
 include/linux/fs.h |    2 +
 3 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 156771f5745a..0354cb6ac2d3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2479,29 +2479,6 @@ static int do_move_mount(struct path *path, const char *old_name)
 	return err;
 }
 
-static struct vfsmount *fs_set_subtype(struct vfsmount *mnt, const char *fstype)
-{
-	int err;
-	const char *subtype = strchr(fstype, '.');
-	if (subtype) {
-		subtype++;
-		err = -EINVAL;
-		if (!subtype[0])
-			goto err;
-	} else
-		subtype = "";
-
-	mnt->mnt_sb->s_subtype = kstrdup(subtype, GFP_KERNEL);
-	err = -ENOMEM;
-	if (!mnt->mnt_sb->s_subtype)
-		goto err;
-	return mnt;
-
- err:
-	mntput(mnt);
-	return ERR_PTR(err);
-}
-
 /*
  * add a mount into a namespace's mount tree
  */
@@ -2557,7 +2534,9 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 {
 	struct file_system_type *type;
 	struct vfsmount *mnt;
-	int err;
+	struct fs_context *fc;
+	const char *subtype = NULL;
+	int err = 0;
 
 	if (!fstype)
 		return -EINVAL;
@@ -2566,23 +2545,59 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (!type)
 		return -ENODEV;
 
-	mnt = vfs_kern_mount(type, sb_flags, name, data);
-	if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
-	    !mnt->mnt_sb->s_subtype)
-		mnt = fs_set_subtype(mnt, fstype);
+	if (type->fs_flags & FS_HAS_SUBTYPE) {
+		subtype = strchr(fstype, '.');
+		if (subtype) {
+			subtype++;
+			if (!*subtype) {
+				put_filesystem(type);
+				return -EINVAL;
+			}
+		} else {
+			subtype = "";
+		}
+	}
 
+	fc = fs_context_for_mount(type, sb_flags);
 	put_filesystem(type);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	if (IS_ERR(fc))
+		return PTR_ERR(fc);
+
+	if (subtype) {
+		fc->subtype = kstrdup(subtype, GFP_KERNEL);
+		if (!fc->subtype)
+			err = -ENOMEM;
+	}
+	if (!err && name) {
+		fc->source = kstrdup(name, GFP_KERNEL);
+		if (!fc->source)
+			err = -ENOMEM;
+	}
+	if (!err)
+		err = parse_monolithic_mount_data(fc, data);
+	if (!err)
+		err = vfs_get_tree(fc);
+	if (err)
+		goto out;
+
+	up_write(&fc->root->d_sb->s_umount);
+	mnt = vfs_create_mount(fc);
+	if (IS_ERR(mnt)) {
+		err = PTR_ERR(mnt);
+		goto out;
+	}
 
 	if (mount_too_revealing(mnt, &mnt_flags)) {
 		mntput(mnt);
-		return -EPERM;
+		err = -EPERM;
+		goto out;
 	}
 
 	err = do_add_mount(real_mount(mnt), path, mnt_flags);
 	if (err)
 		mntput(mnt);
+out:
+	put_fs_context(fc);
 	return err;
 }
 
diff --git a/fs/super.c b/fs/super.c
index fc3887277ad1..b91b6df05b67 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1262,6 +1262,11 @@ int vfs_get_tree(struct fs_context *fc)
 	sb = fc->root->d_sb;
 	WARN_ON(!sb->s_bdi);
 
+	if (fc->subtype && !sb->s_subtype) {
+		sb->s_subtype = fc->subtype;
+		fc->subtype = NULL;
+	}
+
 	/*
 	 * Write barrier is for super_cache_count(). We place it before setting
 	 * SB_BORN as the data dependency between the two functions is the
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c77743dad..36fff12ab890 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1447,7 +1447,7 @@ struct super_block {
 	 * Filesystem subtype.  If non-empty the filesystem type field
 	 * in /proc/mounts will be "type.subtype"
 	 */
-	char *s_subtype;
+	const char *s_subtype;
 
 	const struct dentry_operations *s_d_op; /* default d_op for dentries */
 

