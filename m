Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B30DC43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50ED320823
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfBSQeV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:34:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfBSQeV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:34:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1EFE31B33E;
        Tue, 19 Feb 2019 16:34:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42D6D53;
        Tue, 19 Feb 2019 16:34:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 42/43] afs: Add fs_context support
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:34:18 +0000
Message-ID: <155059405847.12449.6597467845812805111.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 19 Feb 2019 16:34:21 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add fs_context support to the AFS filesystem, converting the parameter
parsing to store options there.

This will form the basis for namespace propagation over mountpoints within
the AFS model, thereby allowing AFS to be used in containers more easily.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/afs/internal.h |    8 -
 fs/afs/mntpt.c    |    1 
 fs/afs/super.c    |  460 +++++++++++++++++++++++++++++------------------------
 fs/afs/volume.c   |    4 
 4 files changed, 259 insertions(+), 214 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 8871b9e8645f..3ed0550a2e29 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -36,15 +36,15 @@
 struct pagevec;
 struct afs_call;
 
-struct afs_mount_params {
+struct afs_fs_context {
 	bool			rwpath;		/* T if the parent should be considered R/W */
 	bool			force;		/* T to force cell type */
 	bool			autocell;	/* T if set auto mount operation */
 	bool			dyn_root;	/* T if dynamic root */
+	bool			no_cell;	/* T if the source is "none" (for dynroot) */
 	afs_voltype_t		type;		/* type of volume requested */
-	int			volnamesz;	/* size of volume name */
+	unsigned int		volnamesz;	/* size of volume name */
 	const char		*volname;	/* name of volume to mount */
-	struct net		*net_ns;	/* Network namespace in effect */
 	struct afs_net		*net;		/* the AFS net namespace stuff */
 	struct afs_cell		*cell;		/* cell in which to find volume */
 	struct afs_volume	*volume;	/* volume record */
@@ -1274,7 +1274,7 @@ static inline struct afs_volume *__afs_get_volume(struct afs_volume *volume)
 	return volume;
 }
 
-extern struct afs_volume *afs_create_volume(struct afs_mount_params *);
+extern struct afs_volume *afs_create_volume(struct afs_fs_context *);
 extern void afs_activate_volume(struct afs_volume *);
 extern void afs_deactivate_volume(struct afs_volume *);
 extern void afs_put_volume(struct afs_cell *, struct afs_volume *);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 2e51c6994148..b3f41d27590b 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -17,6 +17,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/gfp.h>
+#include <linux/fs_context.h>
 #include "internal.h"
 
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dcd07fe99871..e1a7a8085262 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -1,6 +1,6 @@
 /* AFS superblock handling
  *
- * Copyright (c) 2002, 2007 Red Hat, Inc. All rights reserved.
+ * Copyright (c) 2002, 2007, 2018 Red Hat, Inc. All rights reserved.
  *
  * This software may be freely redistributed under the terms of the
  * GNU General Public License.
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/statfs.h>
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
@@ -30,21 +30,22 @@
 #include "internal.h"
 
 static void afs_i_init_once(void *foo);
-static struct dentry *afs_mount(struct file_system_type *fs_type,
-		      int flags, const char *dev_name, void *data);
 static void afs_kill_super(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static int afs_statfs(struct dentry *dentry, struct kstatfs *buf);
 static int afs_show_devname(struct seq_file *m, struct dentry *root);
 static int afs_show_options(struct seq_file *m, struct dentry *root);
+static int afs_init_fs_context(struct fs_context *fc);
+static const struct fs_parameter_description afs_fs_parameters;
 
 struct file_system_type afs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "afs",
-	.mount		= afs_mount,
-	.kill_sb	= afs_kill_super,
-	.fs_flags	= 0,
+	.owner			= THIS_MODULE,
+	.name			= "afs",
+	.init_fs_context	= afs_init_fs_context,
+	.parameters		= &afs_fs_parameters,
+	.kill_sb		= afs_kill_super,
+	.fs_flags		= 0,
 };
 MODULE_ALIAS_FS("afs");
 
@@ -63,22 +64,28 @@ static const struct super_operations afs_super_ops = {
 static struct kmem_cache *afs_inode_cachep;
 static atomic_t afs_count_active_inodes;
 
-enum {
-	afs_no_opt,
-	afs_opt_cell,
-	afs_opt_dyn,
-	afs_opt_rwpath,
-	afs_opt_vol,
-	afs_opt_autocell,
+enum afs_param {
+	Opt_autocell,
+	Opt_cell,
+	Opt_dyn,
+	Opt_rwpath,
+	Opt_source,
+	Opt_vol,
 };
 
-static const match_table_t afs_options_list = {
-	{ afs_opt_cell,		"cell=%s"	},
-	{ afs_opt_dyn,		"dyn"		},
-	{ afs_opt_rwpath,	"rwpath"	},
-	{ afs_opt_vol,		"vol=%s"	},
-	{ afs_opt_autocell,	"autocell"	},
-	{ afs_no_opt,		NULL		},
+static const struct fs_parameter_spec afs_param_specs[] = {
+	fsparam_flag  ("autocell",	Opt_autocell),
+	fsparam_string("cell",		Opt_cell),
+	fsparam_flag  ("dyn",		Opt_dyn),
+	fsparam_flag  ("rwpath",	Opt_rwpath),
+	fsparam_string("source",	Opt_source),
+	fsparam_string("vol",		Opt_vol),
+	{}
+};
+
+static const struct fs_parameter_description afs_fs_parameters = {
+	.name		= "kAFS",
+	.specs		= afs_param_specs,
 };
 
 /*
@@ -190,71 +197,10 @@ static int afs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 /*
- * parse the mount options
- * - this function has been shamelessly adapted from the ext3 fs which
- *   shamelessly adapted it from the msdos fs
- */
-static int afs_parse_options(struct afs_mount_params *params,
-			     char *options, const char **devname)
-{
-	struct afs_cell *cell;
-	substring_t args[MAX_OPT_ARGS];
-	char *p;
-	int token;
-
-	_enter("%s", options);
-
-	options[PAGE_SIZE - 1] = 0;
-
-	while ((p = strsep(&options, ","))) {
-		if (!*p)
-			continue;
-
-		token = match_token(p, afs_options_list, args);
-		switch (token) {
-		case afs_opt_cell:
-			rcu_read_lock();
-			cell = afs_lookup_cell_rcu(params->net,
-						   args[0].from,
-						   args[0].to - args[0].from);
-			rcu_read_unlock();
-			if (IS_ERR(cell))
-				return PTR_ERR(cell);
-			afs_put_cell(params->net, params->cell);
-			params->cell = cell;
-			break;
-
-		case afs_opt_rwpath:
-			params->rwpath = true;
-			break;
-
-		case afs_opt_vol:
-			*devname = args[0].from;
-			break;
-
-		case afs_opt_autocell:
-			params->autocell = true;
-			break;
-
-		case afs_opt_dyn:
-			params->dyn_root = true;
-			break;
-
-		default:
-			printk(KERN_ERR "kAFS:"
-			       " Unknown or invalid mount option: '%s'\n", p);
-			return -EINVAL;
-		}
-	}
-
-	_leave(" = 0");
-	return 0;
-}
-
-/*
- * parse a device name to get cell name, volume name, volume type and R/W
- * selector
- * - this can be one of the following:
+ * Parse the source name to get cell name, volume name, volume type and R/W
+ * selector.
+ *
+ * This can be one of the following:
  *	"%[cell:]volume[.]"		R/W volume
  *	"#[cell:]volume[.]"		R/O or R/W volume (rwpath=0),
  *					 or R/W (rwpath=1) volume
@@ -263,11 +209,11 @@ static int afs_parse_options(struct afs_mount_params *params,
  *	"%[cell:]volume.backup"		Backup volume
  *	"#[cell:]volume.backup"		Backup volume
  */
-static int afs_parse_device_name(struct afs_mount_params *params,
-				 const char *name)
+static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_cell *cell;
-	const char *cellname, *suffix;
+	const char *cellname, *suffix, *name = param->string;
 	int cellnamesz;
 
 	_enter(",%s", name);
@@ -278,69 +224,174 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 	}
 
 	if ((name[0] != '%' && name[0] != '#') || !name[1]) {
+		/* To use dynroot, we don't want to have to provide a source */
+		if (strcmp(name, "none") == 0) {
+			ctx->no_cell = true;
+			return 0;
+		}
 		printk(KERN_ERR "kAFS: unparsable volume name\n");
 		return -EINVAL;
 	}
 
 	/* determine the type of volume we're looking for */
-	params->type = AFSVL_ROVOL;
-	params->force = false;
-	if (params->rwpath || name[0] == '%') {
-		params->type = AFSVL_RWVOL;
-		params->force = true;
+	ctx->type = AFSVL_ROVOL;
+	ctx->force = false;
+	if (ctx->rwpath || name[0] == '%') {
+		ctx->type = AFSVL_RWVOL;
+		ctx->force = true;
 	}
 	name++;
 
 	/* split the cell name out if there is one */
-	params->volname = strchr(name, ':');
-	if (params->volname) {
+	ctx->volname = strchr(name, ':');
+	if (ctx->volname) {
 		cellname = name;
-		cellnamesz = params->volname - name;
-		params->volname++;
+		cellnamesz = ctx->volname - name;
+		ctx->volname++;
 	} else {
-		params->volname = name;
+		ctx->volname = name;
 		cellname = NULL;
 		cellnamesz = 0;
 	}
 
 	/* the volume type is further affected by a possible suffix */
-	suffix = strrchr(params->volname, '.');
+	suffix = strrchr(ctx->volname, '.');
 	if (suffix) {
 		if (strcmp(suffix, ".readonly") == 0) {
-			params->type = AFSVL_ROVOL;
-			params->force = true;
+			ctx->type = AFSVL_ROVOL;
+			ctx->force = true;
 		} else if (strcmp(suffix, ".backup") == 0) {
-			params->type = AFSVL_BACKVOL;
-			params->force = true;
+			ctx->type = AFSVL_BACKVOL;
+			ctx->force = true;
 		} else if (suffix[1] == 0) {
 		} else {
 			suffix = NULL;
 		}
 	}
 
-	params->volnamesz = suffix ?
-		suffix - params->volname : strlen(params->volname);
+	ctx->volnamesz = suffix ?
+		suffix - ctx->volname : strlen(ctx->volname);
 
 	_debug("cell %*.*s [%p]",
-	       cellnamesz, cellnamesz, cellname ?: "", params->cell);
+	       cellnamesz, cellnamesz, cellname ?: "", ctx->cell);
 
 	/* lookup the cell record */
-	if (cellname || !params->cell) {
-		cell = afs_lookup_cell(params->net, cellname, cellnamesz,
+	if (cellname) {
+		cell = afs_lookup_cell(ctx->net, cellname, cellnamesz,
 				       NULL, false);
 		if (IS_ERR(cell)) {
-			printk(KERN_ERR "kAFS: unable to lookup cell '%*.*s'\n",
+			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
 			       cellnamesz, cellnamesz, cellname ?: "");
 			return PTR_ERR(cell);
 		}
-		afs_put_cell(params->net, params->cell);
-		params->cell = cell;
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
 	}
 
 	_debug("CELL:%s [%p] VOLUME:%*.*s SUFFIX:%s TYPE:%d%s",
-	       params->cell->name, params->cell,
-	       params->volnamesz, params->volnamesz, params->volname,
-	       suffix ?: "-", params->type, params->force ? " FORCE" : "");
+	       ctx->cell->name, ctx->cell,
+	       ctx->volnamesz, ctx->volnamesz, ctx->volname,
+	       suffix ?: "-", ctx->type, ctx->force ? " FORCE" : "");
+
+	fc->source = param->string;
+	param->string = NULL;
+	return 0;
+}
+
+/*
+ * Parse a single mount parameter.
+ */
+static int afs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_cell *cell;
+	int opt;
+
+	opt = fs_parse(fc, &afs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cell:
+		if (param->size <= 0)
+			return -EINVAL;
+		if (param->size > AFS_MAXCELLNAME)
+			return -ENAMETOOLONG;
+
+		rcu_read_lock();
+		cell = afs_lookup_cell_rcu(ctx->net, param->string, param->size);
+		rcu_read_unlock();
+		if (IS_ERR(cell))
+			return PTR_ERR(cell);
+		afs_put_cell(ctx->net, ctx->cell);
+		ctx->cell = cell;
+		break;
+
+	case Opt_source:
+		return afs_parse_source(fc, param);
+
+	case Opt_autocell:
+		ctx->autocell = true;
+		break;
+
+	case Opt_dyn:
+		ctx->dyn_root = true;
+		break;
+
+	case Opt_rwpath:
+		ctx->rwpath = true;
+		break;
+
+	case Opt_vol:
+		return invalf(fc, "'vol' param is obsolete");
+
+	default:
+		return -EINVAL;
+	}
+
+	_leave(" = 0");
+	return 0;
+}
+
+/*
+ * Validate the options, get the cell key and look up the volume.
+ */
+static int afs_validate_fc(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx = fc->fs_private;
+	struct afs_volume *volume;
+	struct key *key;
+
+	if (!ctx->dyn_root) {
+		if (ctx->no_cell) {
+			pr_warn("kAFS: Can only specify source 'none' with -o dyn\n");
+			return -EINVAL;
+		}
+
+		if (!ctx->cell) {
+			pr_warn("kAFS: No cell specified\n");
+			return -EDESTADDRREQ;
+		}
+
+		/* We try to do the mount securely. */
+		key = afs_request_key(ctx->cell);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
+
+		ctx->key = key;
+
+		if (ctx->volume) {
+			afs_put_volume(ctx->cell, ctx->volume);
+			ctx->volume = NULL;
+		}
+
+		volume = afs_create_volume(ctx);
+		if (IS_ERR(volume))
+			return PTR_ERR(volume);
+
+		ctx->volume = volume;
+	}
 
 	return 0;
 }
@@ -348,39 +399,34 @@ static int afs_parse_device_name(struct afs_mount_params *params,
 /*
  * check a superblock to see if it's the one we're looking for
  */
-static int afs_test_super(struct super_block *sb, void *data)
+static int afs_test_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as1 = data;
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	return (as->net_ns == as1->net_ns &&
+	return (as->net_ns == fc->net_ns &&
 		as->volume &&
-		as->volume->vid == as1->volume->vid &&
+		as->volume->vid == ctx->volume->vid &&
 		!as->dyn_root);
 }
 
-static int afs_dynroot_test_super(struct super_block *sb, void *data)
+static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as1 = data;
 	struct afs_super_info *as = AFS_FS_S(sb);
 
-	return (as->net_ns == as1->net_ns &&
+	return (as->net_ns == fc->net_ns &&
 		as->dyn_root);
 }
 
-static int afs_set_super(struct super_block *sb, void *data)
+static int afs_set_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct afs_super_info *as = data;
-
-	sb->s_fs_info = as;
 	return set_anon_super(sb, NULL);
 }
 
 /*
  * fill in the superblock
  */
-static int afs_fill_super(struct super_block *sb,
-			  struct afs_mount_params *params)
+static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 {
 	struct afs_super_info *as = AFS_FS_S(sb);
 	struct afs_fid fid;
@@ -412,13 +458,13 @@ static int afs_fill_super(struct super_block *sb,
 		fid.vnode	= 1;
 		fid.vnode_hi	= 0;
 		fid.unique	= 1;
-		inode = afs_iget(sb, params->key, &fid, NULL, NULL, NULL);
+		inode = afs_iget(sb, ctx->key, &fid, NULL, NULL, NULL);
 	}
 
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (params->autocell || params->dyn_root)
+	if (ctx->autocell || as->dyn_root)
 		set_bit(AFS_VNODE_AUTOCELL, &AFS_FS_I(inode)->flags);
 
 	ret = -ENOMEM;
@@ -443,17 +489,20 @@ static int afs_fill_super(struct super_block *sb,
 	return ret;
 }
 
-static struct afs_super_info *afs_alloc_sbi(struct afs_mount_params *params)
+static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 {
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct afs_super_info *as;
 
 	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
 	if (as) {
-		as->net_ns = get_net(params->net_ns);
-		if (params->dyn_root)
+		as->net_ns = get_net(fc->net_ns);
+		if (ctx->dyn_root) {
 			as->dyn_root = true;
-		else
-			as->cell = afs_get_cell(params->cell);
+		} else {
+			as->cell = afs_get_cell(ctx->cell);
+			as->volume = __afs_get_volume(ctx->volume);
+		}
 	}
 	return as;
 }
@@ -475,7 +524,7 @@ static void afs_kill_super(struct super_block *sb)
 
 	if (as->dyn_root)
 		afs_dynroot_depopulate(sb);
-	
+
 	/* Clear the callback interests (which will do ilookup5) before
 	 * deactivating the superblock.
 	 */
@@ -488,111 +537,106 @@ static void afs_kill_super(struct super_block *sb)
 }
 
 /*
- * get an AFS superblock
+ * Get an AFS superblock and root directory.
  */
-static struct dentry *afs_mount(struct file_system_type *fs_type,
-				int flags, const char *dev_name, void *options)
+static int afs_get_tree(struct fs_context *fc)
 {
-	struct afs_mount_params params;
+	struct afs_fs_context *ctx = fc->fs_private;
 	struct super_block *sb;
-	struct afs_volume *candidate;
-	struct key *key;
 	struct afs_super_info *as;
 	int ret;
 
-	_enter(",,%s,%p", dev_name, options);
-
-	memset(&params, 0, sizeof(params));
-
-	ret = -EINVAL;
-	if (current->nsproxy->net_ns != &init_net)
+	ret = afs_validate_fc(fc);
+	if (ret)
 		goto error;
-	params.net_ns = current->nsproxy->net_ns;
-	params.net = afs_net(params.net_ns);
-	
-	/* parse the options and device name */
-	if (options) {
-		ret = afs_parse_options(&params, options, &dev_name);
-		if (ret < 0)
-			goto error;
-	}
-
-	if (!params.dyn_root) {
-		ret = afs_parse_device_name(&params, dev_name);
-		if (ret < 0)
-			goto error;
 
-		/* try and do the mount securely */
-		key = afs_request_key(params.cell);
-		if (IS_ERR(key)) {
-			_leave(" = %ld [key]", PTR_ERR(key));
-			ret = PTR_ERR(key);
-			goto error;
-		}
-		params.key = key;
-	}
+	_enter("");
 
 	/* allocate a superblock info record */
 	ret = -ENOMEM;
-	as = afs_alloc_sbi(&params);
+	as = afs_alloc_sbi(fc);
 	if (!as)
-		goto error_key;
-
-	if (!params.dyn_root) {
-		/* Assume we're going to need a volume record; at the very
-		 * least we can use it to update the volume record if we have
-		 * one already.  This checks that the volume exists within the
-		 * cell.
-		 */
-		candidate = afs_create_volume(&params);
-		if (IS_ERR(candidate)) {
-			ret = PTR_ERR(candidate);
-			goto error_as;
-		}
-
-		as->volume = candidate;
-	}
+		goto error;
+	fc->s_fs_info = as;
 
 	/* allocate a deviceless superblock */
-	sb = sget(fs_type,
-		  as->dyn_root ? afs_dynroot_test_super : afs_test_super,
-		  afs_set_super, flags, as);
+	sb = sget_fc(fc,
+		     as->dyn_root ? afs_dynroot_test_super : afs_test_super,
+		     afs_set_super);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
-		goto error_as;
+		goto error;
 	}
 
 	if (!sb->s_root) {
 		/* initial superblock/root creation */
 		_debug("create");
-		ret = afs_fill_super(sb, &params);
+		ret = afs_fill_super(sb, ctx);
 		if (ret < 0)
 			goto error_sb;
-		as = NULL;
 		sb->s_flags |= SB_ACTIVE;
 	} else {
 		_debug("reuse");
 		ASSERTCMP(sb->s_flags, &, SB_ACTIVE);
-		afs_destroy_sbi(as);
-		as = NULL;
 	}
 
-	afs_put_cell(params.net, params.cell);
-	key_put(params.key);
+	fc->root = dget(sb->s_root);
 	_leave(" = 0 [%p]", sb);
-	return dget(sb->s_root);
+	return 0;
 
 error_sb:
 	deactivate_locked_super(sb);
-	goto error_key;
-error_as:
-	afs_destroy_sbi(as);
-error_key:
-	key_put(params.key);
 error:
-	afs_put_cell(params.net, params.cell);
 	_leave(" = %d", ret);
-	return ERR_PTR(ret);
+	return ret;
+}
+
+static void afs_free_fc(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx = fc->fs_private;
+
+	afs_destroy_sbi(fc->s_fs_info);
+	afs_put_volume(ctx->cell, ctx->volume);
+	afs_put_cell(ctx->net, ctx->cell);
+	key_put(ctx->key);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations afs_context_ops = {
+	.free		= afs_free_fc,
+	.parse_param	= afs_parse_param,
+	.get_tree	= afs_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int afs_init_fs_context(struct fs_context *fc)
+{
+	struct afs_fs_context *ctx;
+	struct afs_cell *cell;
+
+	if (current->nsproxy->net_ns != &init_net)
+		return -EINVAL;
+
+	ctx = kzalloc(sizeof(struct afs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->type = AFSVL_ROVOL;
+	ctx->net = afs_net(fc->net_ns);
+
+	/* Default to the workstation cell. */
+	rcu_read_lock();
+	cell = afs_lookup_cell_rcu(ctx->net, NULL, 0);
+	rcu_read_unlock();
+	if (IS_ERR(cell))
+		cell = NULL;
+	ctx->cell = cell;
+
+	fc->fs_private = ctx;
+	fc->ops = &afs_context_ops;
+	return 0;
 }
 
 /*
diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 00975ed3640f..f6eba2def0a1 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -21,7 +21,7 @@ static const char *const afs_voltypes[] = { "R/W", "R/O", "BAK" };
 /*
  * Allocate a volume record and load it up from a vldb record.
  */
-static struct afs_volume *afs_alloc_volume(struct afs_mount_params *params,
+static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
 					   struct afs_vldb_entry *vldb,
 					   unsigned long type_mask)
 {
@@ -113,7 +113,7 @@ static struct afs_vldb_entry *afs_vl_lookup_vldb(struct afs_cell *cell,
  * - Rule 3: If parent volume is R/W, then only mount R/W volume unless
  *           explicitly told otherwise
  */
-struct afs_volume *afs_create_volume(struct afs_mount_params *params)
+struct afs_volume *afs_create_volume(struct afs_fs_context *params)
 {
 	struct afs_vldb_entry *vldb;
 	struct afs_volume *volume;

