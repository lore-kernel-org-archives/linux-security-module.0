Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F26C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDFD21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfBSQ2c (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbfBSQ2c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:28:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 291207CFCE;
        Tue, 19 Feb 2019 16:28:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E83BC101962A;
        Tue, 19 Feb 2019 16:28:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/43] kill kernfs_pin_sb()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:28:27 +0000
Message-ID: <155059370708.12449.16300336178932343753.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:28:32 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

unused now and impossible to use safely anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/kernfs/mount.c      |   30 ------------------------------
 include/linux/kernfs.h |    1 -
 2 files changed, 31 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d71c9405874a..4d303047a4f8 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -377,36 +377,6 @@ void kernfs_kill_sb(struct super_block *sb)
 	kfree(info);
 }
 
-/**
- * kernfs_pin_sb: try to pin the superblock associated with a kernfs_root
- * @kernfs_root: the kernfs_root in question
- * @ns: the namespace tag
- *
- * Pin the superblock so the superblock won't be destroyed in subsequent
- * operations.  This can be used to block ->kill_sb() which may be useful
- * for kernfs users which dynamically manage superblocks.
- *
- * Returns NULL if there's no superblock associated to this kernfs_root, or
- * -EINVAL if the superblock is being freed.
- */
-struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns)
-{
-	struct kernfs_super_info *info;
-	struct super_block *sb = NULL;
-
-	mutex_lock(&kernfs_mutex);
-	list_for_each_entry(info, &root->supers, node) {
-		if (info->ns == ns) {
-			sb = info->sb;
-			if (!atomic_inc_not_zero(&info->sb->s_active))
-				sb = ERR_PTR(-EINVAL);
-			break;
-		}
-	}
-	mutex_unlock(&kernfs_mutex);
-	return sb;
-}
-
 void __init kernfs_init(void)
 {
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5b36b1287a5a..44acb4c3659c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -357,7 +357,6 @@ struct dentry *kernfs_mount_ns(struct file_system_type *fs_type, int flags,
 			       struct kernfs_root *root, unsigned long magic,
 			       bool *new_sb_created, const void *ns);
 void kernfs_kill_sb(struct super_block *sb);
-struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns);
 
 void kernfs_init(void);
 

