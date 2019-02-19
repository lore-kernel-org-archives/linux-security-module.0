Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD63C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B721738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfBSQbX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:31:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbfBSQbX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:31:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8404FD7819;
        Tue, 19 Feb 2019 16:31:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4A3101E5B1;
        Tue, 19 Feb 2019 16:31:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/43] convenience helpers: vfs_get_super() and sget_fc()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:31:20 +0000
Message-ID: <155059388041.12449.16262861562909897857.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 19 Feb 2019 16:31:22 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

the former is an analogue of mount_{single,nodev} for use in
->get_tree() instances, the latter - analogue of sget() for the
same.

These are fairly similar to the originals, but the callback signature
for sget_fc() is different from sget() ones, so getting bits and
pieces shared would be too convoluted; we might get around to that
later, but for now let's just remember to keep them in sync.  They
do live next to each other, and changes in either won't be hard
to spot.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/super.c                 |  171 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h         |    4 +
 include/linux/fs_context.h |   15 ++++
 3 files changed, 190 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 76b3181c782d..0ebb5c11fa56 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -476,6 +476,94 @@ void generic_shutdown_super(struct super_block *sb)
 
 EXPORT_SYMBOL(generic_shutdown_super);
 
+/**
+ * sget_fc - Find or create a superblock
+ * @fc:	Filesystem context.
+ * @test: Comparison callback
+ * @set: Setup callback
+ *
+ * Find or create a superblock using the parameters stored in the filesystem
+ * context and the two callback functions.
+ *
+ * If an extant superblock is matched, then that will be returned with an
+ * elevated reference count that the caller must transfer or discard.
+ *
+ * If no match is made, a new superblock will be allocated and basic
+ * initialisation will be performed (s_type, s_fs_info and s_id will be set and
+ * the set() callback will be invoked), the superblock will be published and it
+ * will be returned in a partially constructed state with SB_BORN and SB_ACTIVE
+ * as yet unset.
+ */
+struct super_block *sget_fc(struct fs_context *fc,
+			    int (*test)(struct super_block *, struct fs_context *),
+			    int (*set)(struct super_block *, struct fs_context *))
+{
+	struct super_block *s = NULL;
+	struct super_block *old;
+	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
+	int err;
+
+	if (!(fc->sb_flags & SB_KERNMOUNT) &&
+	    fc->purpose != FS_CONTEXT_FOR_SUBMOUNT) {
+		/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
+		 * over the namespace.
+		 */
+		if (!(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+			if (!capable(CAP_SYS_ADMIN))
+				return ERR_PTR(-EPERM);
+		} else {
+			if (!ns_capable(fc->user_ns, CAP_SYS_ADMIN))
+				return ERR_PTR(-EPERM);
+		}
+	}
+
+retry:
+	spin_lock(&sb_lock);
+	if (test) {
+		hlist_for_each_entry(old, &fc->fs_type->fs_supers, s_instances) {
+			if (test(old, fc))
+				goto share_extant_sb;
+		}
+	}
+	if (!s) {
+		spin_unlock(&sb_lock);
+		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
+		if (!s)
+			return ERR_PTR(-ENOMEM);
+		goto retry;
+	}
+
+	s->s_fs_info = fc->s_fs_info;
+	err = set(s, fc);
+	if (err) {
+		s->s_fs_info = NULL;
+		spin_unlock(&sb_lock);
+		destroy_unused_super(s);
+		return ERR_PTR(err);
+	}
+	fc->s_fs_info = NULL;
+	s->s_type = fc->fs_type;
+	strlcpy(s->s_id, s->s_type->name, sizeof(s->s_id));
+	list_add_tail(&s->s_list, &super_blocks);
+	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
+	spin_unlock(&sb_lock);
+	get_filesystem(s->s_type);
+	register_shrinker_prepared(&s->s_shrink);
+	return s;
+
+share_extant_sb:
+	if (user_ns != old->s_user_ns) {
+		spin_unlock(&sb_lock);
+		destroy_unused_super(s);
+		return ERR_PTR(-EBUSY);
+	}
+	if (!grab_super(old))
+		goto retry;
+	destroy_unused_super(s);
+	return old;
+}
+EXPORT_SYMBOL(sget_fc);
+
 /**
  *	sget_userns -	find or create a superblock
  *	@type:	filesystem type superblock should belong to
@@ -1103,6 +1191,89 @@ struct dentry *mount_ns(struct file_system_type *fs_type,
 
 EXPORT_SYMBOL(mount_ns);
 
+int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
+{
+	return set_anon_super(sb, NULL);
+}
+EXPORT_SYMBOL(set_anon_super_fc);
+
+static int test_keyed_super(struct super_block *sb, struct fs_context *fc)
+{
+	return sb->s_fs_info == fc->s_fs_info;
+}
+
+static int test_single_super(struct super_block *s, struct fs_context *fc)
+{
+	return 1;
+}
+
+/**
+ * vfs_get_super - Get a superblock with a search key set in s_fs_info.
+ * @fc: The filesystem context holding the parameters
+ * @keying: How to distinguish superblocks
+ * @fill_super: Helper to initialise a new superblock
+ *
+ * Search for a superblock and create a new one if not found.  The search
+ * criterion is controlled by @keying.  If the search fails, a new superblock
+ * is created and @fill_super() is called to initialise it.
+ *
+ * @keying can take one of a number of values:
+ *
+ * (1) vfs_get_single_super - Only one superblock of this type may exist on the
+ *     system.  This is typically used for special system filesystems.
+ *
+ * (2) vfs_get_keyed_super - Multiple superblocks may exist, but they must have
+ *     distinct keys (where the key is in s_fs_info).  Searching for the same
+ *     key again will turn up the superblock for that key.
+ *
+ * (3) vfs_get_independent_super - Multiple superblocks may exist and are
+ *     unkeyed.  Each call will get a new superblock.
+ *
+ * A permissions check is made by sget_fc() unless we're getting a superblock
+ * for a kernel-internal mount or a submount.
+ */
+int vfs_get_super(struct fs_context *fc,
+		  enum vfs_get_super_keying keying,
+		  int (*fill_super)(struct super_block *sb,
+				    struct fs_context *fc))
+{
+	int (*test)(struct super_block *, struct fs_context *);
+	struct super_block *sb;
+
+	switch (keying) {
+	case vfs_get_single_super:
+		test = test_single_super;
+		break;
+	case vfs_get_keyed_super:
+		test = test_keyed_super;
+		break;
+	case vfs_get_independent_super:
+		test = NULL;
+		break;
+	default:
+		BUG();
+	}
+
+	sb = sget_fc(fc, test, set_anon_super_fc);
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
+
+	if (!sb->s_root) {
+		int err = fill_super(sb, fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+
+		sb->s_flags |= SB_ACTIVE;
+	}
+
+	BUG_ON(fc->root);
+	fc->root = dget(sb->s_root);
+	return 0;
+}
+EXPORT_SYMBOL(vfs_get_super);
+
 #ifdef CONFIG_BLOCK
 static int set_bdev_super(struct super_block *s, void *data)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cf6e9ea161eb..9d05c128ccf6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2232,8 +2232,12 @@ void kill_litter_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
 int set_anon_super(struct super_block *s, void *data);
+int set_anon_super_fc(struct super_block *s, struct fs_context *fc);
 int get_anon_bdev(dev_t *);
 void free_anon_bdev(dev_t);
+struct super_block *sget_fc(struct fs_context *fc,
+			    int (*test)(struct super_block *, struct fs_context *),
+			    int (*set)(struct super_block *, struct fs_context *));
 struct super_block *sget_userns(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index d794b04e9fbb..b1a95db7a111 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -83,11 +83,13 @@ struct fs_context {
 	const char		*source;	/* The source name (eg. dev path) */
 	const char		*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* Linux S&M options */
+	void			*s_fs_info;	/* Proposed s_fs_info */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
 	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
 	enum fs_context_purpose	purpose:8;
 	bool			need_free:1;	/* Need to call ops->free() */
+	bool			global:1;	/* Goes into &init_user_ns */
 };
 
 struct fs_context_operations {
@@ -116,6 +118,19 @@ extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
 
+/*
+ * sget() wrapper to be called from the ->get_tree() op.
+ */
+enum vfs_get_super_keying {
+	vfs_get_single_super,	/* Only one such superblock may exist */
+	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
+	vfs_get_independent_super, /* Multiple independent superblocks may exist */
+};
+extern int vfs_get_super(struct fs_context *fc,
+			 enum vfs_get_super_keying keying,
+			 int (*fill_super)(struct super_block *sb,
+					   struct fs_context *fc));
+
 #define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
 
 /**

