Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB89FC4167D
	for <linux-security-module@archiver.kernel.org>; Fri,  3 Nov 2023 19:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjKCTFo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 3 Nov 2023 15:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjKCTFn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 3 Nov 2023 15:05:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8742BD4D
        for <linux-security-module@vger.kernel.org>; Fri,  3 Nov 2023 12:05:40 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3FMcna007749
        for <linux-security-module@vger.kernel.org>; Fri, 3 Nov 2023 12:05:40 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u4r6s5f64-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Fri, 03 Nov 2023 12:05:40 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 12:05:36 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 4A7823AE3839A; Fri,  3 Nov 2023 12:05:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount options to BPF FS
Date:   Fri, 3 Nov 2023 12:05:08 -0700
Message-ID: <20231103190523.6353-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103190523.6353-1-andrii@kernel.org>
References: <20231103190523.6353-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Oq547G-UGgOGt2j64ZxqoidQCNc6s0yA
X-Proofpoint-GUID: Oq547G-UGgOGt2j64ZxqoidQCNc6s0yA
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add few new mount options to BPF FS that allow to specify that a given
BPF FS instance allows creation of BPF token (added in the next patch),
and what sort of operations are allowed under BPF token. As such, we get
4 new mount options, each is a bit mask
  - `delegate_cmds` allow to specify which bpf() syscall commands are
    allowed with BPF token derived from this BPF FS instance;
  - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
    a set of allowable BPF map types that could be created with BPF token;
  - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
    a set of allowable BPF program types that could be loaded with BPF token;
  - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
    a set of allowable BPF program attach types that could be loaded with
    BPF token; delegate_progs and delegate_attachs are meant to be used
    together, as full BPF program type is, in general, determined
    through both program type and program attach type.

Currently, these mount options accept the following forms of values:
  - a special value "any", that enables all possible values of a given
  bit set;
  - numeric value (decimal or hexadecimal, determined by kernel
  automatically) that specifies a bit mask value directly;
  - all the values for a given mount option are combined, if specified
  multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
  delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
  mask.

Ideally, more convenient (for humans) symbolic form derived from
corresponding UAPI enums would be accepted (e.g., `-o
delegate_progs=kprobe|tracepoint`) and I intend to implement this, but
it requires a bunch of UAPI header churn, so I postponed it until this
feature lands upstream or at least there is a definite consensus that
this feature is acceptable and is going to make it, just to minimize
amount of wasted effort and not increase amount of non-essential code to
be reviewed.

Attentive reader will notice that BPF FS is now marked as
FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
user namespace as long as the process has sufficient *namespaced*
capabilities within that user namespace. But in reality we still
restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *in
init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is added
to allow creating BPF FS context object (i.e., fsopen("bpf")) from
inside unprivileged process inside non-init userns, to capture that
userns as the owning userns. It will still be required to pass this
context object back to privileged process to instantiate and mount it.

This manipulation is important, because capturing non-init userns as the
owning userns of BPF FS instance (super block) allows to use that userns
to constraint BPF token to that userns later on (see next patch). So
creating BPF FS with delegation inside unprivileged userns will restrict
derived BPF token objects to only "work" inside that intended userns,
making it scoped to a intended "container".

There is a set of selftests at the end of the patch set that simulates
this sequence of steps and validates that everything works as intended.
But careful review is requested to make sure there are no missed gaps in
the implementation and testing.

All this is based on suggestions and discussions with Christian Brauner
([0]), to the best of my ability to follow all the implications.

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 10 ++++++
 kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4825d3cdb29..df50a7bf1a77 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1562,6 +1562,16 @@ struct bpf_link_primer {
 	u32 id;
 };
 
+struct bpf_mount_opts {
+	umode_t mode;
+
+	/* BPF token-related delegation options */
+	u64 delegate_cmds;
+	u64 delegate_maps;
+	u64 delegate_progs;
+	u64 delegate_attachs;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1aafb2ff2e95..e49e93bc65e3 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -20,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/kstrtox.h>
 #include "preload/bpf_preload.h"
 
 enum bpf_type {
@@ -599,10 +600,31 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
+	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
 
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
+
+	if (opts->delegate_cmds == ~0ULL)
+		seq_printf(m, ",delegate_cmds=any");
+	else if (opts->delegate_cmds)
+		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
+
+	if (opts->delegate_maps == ~0ULL)
+		seq_printf(m, ",delegate_maps=any");
+	else if (opts->delegate_maps)
+		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
+
+	if (opts->delegate_progs == ~0ULL)
+		seq_printf(m, ",delegate_progs=any");
+	else if (opts->delegate_progs)
+		seq_printf(m, ",delegate_progs=0x%llx", opts->delegate_progs);
+
+	if (opts->delegate_attachs == ~0ULL)
+		seq_printf(m, ",delegate_attachs=any");
+	else if (opts->delegate_attachs)
+		seq_printf(m, ",delegate_attachs=0x%llx", opts->delegate_attachs);
 	return 0;
 }
 
@@ -626,22 +648,27 @@ static const struct super_operations bpf_super_ops = {
 
 enum {
 	OPT_MODE,
+	OPT_DELEGATE_CMDS,
+	OPT_DELEGATE_MAPS,
+	OPT_DELEGATE_PROGS,
+	OPT_DELEGATE_ATTACHS,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
 	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
+	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
+	fsparam_string	("delegate_progs",		OPT_DELEGATE_PROGS),
+	fsparam_string	("delegate_attachs",		OPT_DELEGATE_ATTACHS),
 	{}
 };
 
-struct bpf_mount_opts {
-	umode_t mode;
-};
-
 static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	int opt;
+	int opt, err;
+	u64 msk;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case OPT_DELEGATE_CMDS:
+	case OPT_DELEGATE_MAPS:
+	case OPT_DELEGATE_PROGS:
+	case OPT_DELEGATE_ATTACHS:
+		if (strcmp(param->string, "any") == 0) {
+			msk = ~0ULL;
+		} else {
+			err = kstrtou64(param->string, 0, &msk);
+			if (err)
+				return err;
+		}
+		switch (opt) {
+		case OPT_DELEGATE_CMDS: opts->delegate_cmds |= msk; break;
+		case OPT_DELEGATE_MAPS: opts->delegate_maps |= msk; break;
+		case OPT_DELEGATE_PROGS: opts->delegate_progs |= msk; break;
+		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |= msk; break;
+		default: return -EINVAL;
+		}
+		break;
 	}
 
 	return 0;
@@ -739,10 +785,14 @@ static int populate_bpffs(struct dentry *parent)
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
 	int ret;
 
+	/* Mounting an instance of BPF FS requires privileges */
+	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -764,7 +814,10 @@ static int bpf_get_tree(struct fs_context *fc)
 
 static void bpf_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct bpf_mount_opts *opts = fc->s_fs_info;
+
+	if (opts)
+		kfree(opts);
 }
 
 static const struct fs_context_operations bpf_context_ops = {
@@ -786,17 +839,32 @@ static int bpf_init_fs_context(struct fs_context *fc)
 
 	opts->mode = S_IRWXUGO;
 
-	fc->fs_private = opts;
+	/* start out with no BPF token delegation enabled */
+	opts->delegate_cmds = 0;
+	opts->delegate_maps = 0;
+	opts->delegate_progs = 0;
+	opts->delegate_attachs = 0;
+
+	fc->s_fs_info = opts;
 	fc->ops = &bpf_context_ops;
 	return 0;
 }
 
+static void bpf_kill_super(struct super_block *sb)
+{
+	struct bpf_mount_opts *opts = sb->s_fs_info;
+
+	kill_litter_super(sb);
+	kfree(opts);
+}
+
 static struct file_system_type bpf_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "bpf",
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= bpf_kill_super,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 static int __init bpf_init(void)
-- 
2.34.1

