Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F5C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DA821738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbfBSQdr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfBSQdr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:33:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 50004AC61A;
        Tue, 19 Feb 2019 16:33:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D348F5D770;
        Tue, 19 Feb 2019 16:33:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 38/43] vfs: Remove kern_mount_data()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:33:45 +0000
Message-ID: <155059402497.12449.9115734348268644271.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:33:47 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The kern_mount_data() isn't used any more so remove it.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c     |    6 +++---
 include/linux/fs.h |    3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1a1ed2528f47..bb9b7db1c66c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3390,10 +3390,10 @@ void put_mnt_ns(struct mnt_namespace *ns)
 	free_mnt_ns(ns);
 }
 
-struct vfsmount *kern_mount_data(struct file_system_type *type, void *data)
+struct vfsmount *kern_mount(struct file_system_type *type)
 {
 	struct vfsmount *mnt;
-	mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, data);
+	mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
 	if (!IS_ERR(mnt)) {
 		/*
 		 * it is a longterm mount, don't release mnt until
@@ -3403,7 +3403,7 @@ struct vfsmount *kern_mount_data(struct file_system_type *type, void *data)
 	}
 	return mnt;
 }
-EXPORT_SYMBOL_GPL(kern_mount_data);
+EXPORT_SYMBOL_GPL(kern_mount);
 
 void kern_unmount(struct vfsmount *mnt)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9d05c128ccf6..3e85cb8e8c20 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2280,8 +2280,7 @@ mount_pseudo(struct file_system_type *fs_type, char *name,
 
 extern int register_filesystem(struct file_system_type *);
 extern int unregister_filesystem(struct file_system_type *);
-extern struct vfsmount *kern_mount_data(struct file_system_type *, void *data);
-#define kern_mount(type) kern_mount_data(type, NULL)
+extern struct vfsmount *kern_mount(struct file_system_type *);
 extern void kern_unmount(struct vfsmount *mnt);
 extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);

