Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0AC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0770621738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfBSQaF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfBSQaF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B6D407D0CB;
        Tue, 19 Feb 2019 16:30:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6975061080;
        Tue, 19 Feb 2019 16:30:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/43] fs_context flavour for submounts
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:01 +0000
Message-ID: <155059380154.12449.5948045751612660590.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:30:04 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

This is an eventual replacement for vfs_submount() uses.  Unlike the
"mount" and "remount" cases, the users of that thing are not in VFS -
they are buried in various ->d_automount() instances and rather than
converting them all at once we introduce the (thankfully small and
simple) infrastructure here and deal with the prospective users in
afs, nfs, etc. parts of the series.

Here we just introduce a new constructor (fs_context_for_submount())
along with the corresponding enum constant to be put into fc->purpose
for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/fs_context.c            |   10 ++++++++++
 include/linux/fs_context.h |    3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 5e2c3aba1dd8..2bd652b6e848 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -69,6 +69,9 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 	case FS_CONTEXT_FOR_MOUNT:
 		fc->user_ns = get_user_ns(fc->cred->user_ns);
 		break;
+	case FS_CONTEXT_FOR_SUBMOUNT:
+		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
+		break;
 	case FS_CONTEXT_FOR_RECONFIGURE:
 		/* We don't pin any namespaces as the superblock's
 		 * subscriptions cannot be changed at this point.
@@ -106,6 +109,13 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 }
 EXPORT_SYMBOL(fs_context_for_reconfigure);
 
+struct fs_context *fs_context_for_submount(struct file_system_type *type,
+					   struct dentry *reference)
+{
+	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
+}
+EXPORT_SYMBOL(fs_context_for_submount);
+
 void fc_drop_locked(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 98772f882a3e..7feb018c7a9e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -25,6 +25,7 @@ struct user_namespace;
 
 enum fs_context_purpose {
 	FS_CONTEXT_FOR_MOUNT,		/* New superblock for explicit mount */
+	FS_CONTEXT_FOR_SUBMOUNT,	/* New superblock for automatic submount */
 	FS_CONTEXT_FOR_RECONFIGURE,	/* Superblock reconfiguration (remount) */
 };
 
@@ -61,6 +62,8 @@ extern struct fs_context *fs_context_for_mount(struct file_system_type *fs_type,
 extern struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 						unsigned int sb_flags,
 						unsigned int sb_flags_mask);
+extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_type,
+						struct dentry *reference);
 
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);

