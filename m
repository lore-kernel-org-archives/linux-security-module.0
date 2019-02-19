Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB75C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FFB21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfBSQbi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfBSQbh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2033C049E24;
        Tue, 19 Feb 2019 16:31:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3180419C58;
        Tue, 19 Feb 2019 16:31:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 23/43] procfs: Move proc_fill_super() to fs/proc/root.c
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:35 +0000
Message-ID: <155059389539.12449.17955800242100461744.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 19 Feb 2019 16:31:37 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Move proc_fill_super() to fs/proc/root.c as that's where the other
superblock stuff is.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/proc/inode.c    |   51 +--------------------------------------------------
 fs/proc/internal.h |    4 +---
 fs/proc/root.c     |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index da649ccd6804..17b5261206dd 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -24,7 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
-#include <linux/magic.h>
 
 #include <linux/uaccess.h>
 
@@ -122,7 +121,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static const struct super_operations proc_sops = {
+const struct super_operations proc_sops = {
 	.alloc_inode	= proc_alloc_inode,
 	.destroy_inode	= proc_destroy_inode,
 	.drop_inode	= generic_delete_inode,
@@ -488,51 +487,3 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 	       pde_put(de);
 	return inode;
 }
-
-int proc_fill_super(struct super_block *s, void *data, int silent)
-{
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
-	struct inode *root_inode;
-	int ret;
-
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
-
-	/* User space would break if executables or devices appear on proc */
-	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
-	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
-	s->s_blocksize = 1024;
-	s->s_blocksize_bits = 10;
-	s->s_magic = PROC_SUPER_MAGIC;
-	s->s_op = &proc_sops;
-	s->s_time_gran = 1;
-
-	/*
-	 * procfs isn't actually a stacking filesystem; however, there is
-	 * too much magic going on inside it to permit stacking things on
-	 * top of it
-	 */
-	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
-	
-	/* procfs dentries and inodes don't require IO to create */
-	s->s_shrink.seeks = 0;
-
-	pde_get(&proc_root);
-	root_inode = proc_get_inode(s, &proc_root);
-	if (!root_inode) {
-		pr_err("proc_fill_super: get root inode failed\n");
-		return -ENOMEM;
-	}
-
-	s->s_root = d_make_root(root_inode);
-	if (!s->s_root) {
-		pr_err("proc_fill_super: allocate dentry failed\n");
-		return -ENOMEM;
-	}
-
-	ret = proc_setup_self(s);
-	if (ret) {
-		return ret;
-	}
-	return proc_setup_thread_self(s);
-}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5185d7f6a51e..97157c0410a2 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -205,13 +205,12 @@ struct pde_opener {
 	struct completion *c;
 } __randomize_layout;
 extern const struct inode_operations proc_link_inode_operations;
-
 extern const struct inode_operations proc_pid_link_inode_operations;
+extern const struct super_operations proc_sops;
 
 void proc_init_kmemcache(void);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
-extern int proc_fill_super(struct super_block *, void *data, int flags);
 extern void proc_entry_rundown(struct proc_dir_entry *);
 
 /*
@@ -269,7 +268,6 @@ static inline void proc_tty_init(void) {}
  * root.c
  */
 extern struct proc_dir_entry proc_root;
-extern int proc_parse_options(char *options, struct pid_namespace *pid);
 
 extern void proc_self_init(void);
 extern int proc_remount(struct super_block *, int *, char *);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index f4b1a9d2eca6..fe4f64b3250b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -23,6 +23,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/parser.h>
 #include <linux/cred.h>
+#include <linux/magic.h>
 
 #include "internal.h"
 
@@ -36,7 +37,7 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
-int proc_parse_options(char *options, struct pid_namespace *pid)
+static int proc_parse_options(char *options, struct pid_namespace *pid)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -78,6 +79,54 @@ int proc_parse_options(char *options, struct pid_namespace *pid)
 	return 1;
 }
 
+static int proc_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
+	struct inode *root_inode;
+	int ret;
+
+	if (!proc_parse_options(data, ns))
+		return -EINVAL;
+
+	/* User space would break if executables or devices appear on proc */
+	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
+	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = PROC_SUPER_MAGIC;
+	s->s_op = &proc_sops;
+	s->s_time_gran = 1;
+
+	/*
+	 * procfs isn't actually a stacking filesystem; however, there is
+	 * too much magic going on inside it to permit stacking things on
+	 * top of it
+	 */
+	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
+	
+	/* procfs dentries and inodes don't require IO to create */
+	s->s_shrink.seeks = 0;
+
+	pde_get(&proc_root);
+	root_inode = proc_get_inode(s, &proc_root);
+	if (!root_inode) {
+		pr_err("proc_fill_super: get root inode failed\n");
+		return -ENOMEM;
+	}
+
+	s->s_root = d_make_root(root_inode);
+	if (!s->s_root) {
+		pr_err("proc_fill_super: allocate dentry failed\n");
+		return -ENOMEM;
+	}
+
+	ret = proc_setup_self(s);
+	if (ret) {
+		return ret;
+	}
+	return proc_setup_thread_self(s);
+}
+
 int proc_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct pid_namespace *pid = sb->s_fs_info;

