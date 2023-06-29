Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C1EB64DD
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Jun 2023 05:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjF2FSq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 29 Jun 2023 01:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjF2FSl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 29 Jun 2023 01:18:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6339626BB
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:39 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 35T17GAl005980
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:38 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3rgygy9psh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 28 Jun 2023 22:18:38 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:37 -0700
Received: from twshared66906.03.prn6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 22:18:37 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 724BC33AFB404; Wed, 28 Jun 2023 22:18:34 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <cyphar@cyphar.com>, <luto@kernel.org>, <kernel-team@meta.com>,
        <sargun@sargun.me>
Subject: [PATCH RESEND v3 bpf-next 01/14] bpf: introduce BPF token object
Date:   Wed, 28 Jun 2023 22:18:19 -0700
Message-ID: <20230629051832.897119-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629051832.897119-1-andrii@kernel.org>
References: <20230629051832.897119-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: nhecyFjyQQswNyELxVWNl8xmrBhPYhIy
X-Proofpoint-ORIG-GUID: nhecyFjyQQswNyELxVWNl8xmrBhPYhIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add new kind of BPF kernel object, BPF token. BPF token is meant to to
allow delegating privileged BPF functionality, like loading a BPF
program or creating a BPF map, from privileged process to a *trusted*
unprivileged process, all while have a good amount of control over which
privileged operations could be performed using provided BPF token.

This patch adds new BPF_TOKEN_CREATE command to bpf() syscall, which
allows to create a new BPF token object along with a set of allowed
commands that such BPF token allows to unprivileged applications.
Currently only BPF_TOKEN_CREATE command itself can be
delegated, but other patches gradually add ability to delegate
BPF_MAP_CREATE, BPF_BTF_LOAD, and BPF_PROG_LOAD commands.

The above means that new BPF tokens can be created using existing BPF
token, if original privileged creator allowed BPF_TOKEN_CREATE command.
New derived BPF token cannot be more powerful than the original BPF
token.

Importantly, BPF token is automatically pinned at the specified location
inside an instance of BPF FS and cannot be repinned using BPF_OBJ_PIN
command, unlike BPF prog/map/btf/link. This provides more control over
unintended sharing of BPF tokens through pinning it in another BPF FS
instances.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            |  47 ++++++++++
 include/uapi/linux/bpf.h       |  38 ++++++++
 kernel/bpf/Makefile            |   2 +-
 kernel/bpf/inode.c             |  46 +++++++--
 kernel/bpf/syscall.c           |  17 ++++
 kernel/bpf/token.c             | 167 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  38 ++++++++
 7 files changed, 344 insertions(+), 11 deletions(-)
 create mode 100644 kernel/bpf/token.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..c4f1684aa138 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -51,6 +51,7 @@ struct module;
 struct bpf_func_state;
 struct ftrace_ops;
 struct cgroup;
+struct bpf_token;
 
 extern struct idr btf_idr;
 extern spinlock_t btf_idr_lock;
@@ -1533,6 +1534,12 @@ struct bpf_link_primer {
 	u32 id;
 };
 
+struct bpf_token {
+	struct work_struct work;
+	atomic64_t refcnt;
+	u64 allowed_cmds;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
 
@@ -1916,6 +1923,11 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
+static inline bool bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return token || capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
+}
+
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
 extern struct mutex bpf_stats_enabled_mutex;
@@ -2077,8 +2089,25 @@ struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
 struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
 
+void bpf_token_inc(struct bpf_token *token);
+void bpf_token_put(struct bpf_token *token);
+int bpf_token_create(union bpf_attr *attr);
+int bpf_token_new_fd(struct bpf_token *token);
+struct bpf_token *bpf_token_get_from_fd(u32 ufd);
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+
+enum bpf_type {
+	BPF_TYPE_UNSPEC	= 0,
+	BPF_TYPE_PROG,
+	BPF_TYPE_MAP,
+	BPF_TYPE_LINK,
+	BPF_TYPE_TOKEN,
+};
+
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
+int bpf_obj_pin_any(int path_fd, const char __user *pathname, void *raw, enum bpf_type type);
 
 #define BPF_ITER_FUNC_PREFIX "bpf_iter_"
 #define DEFINE_BPF_ITER_FUNC(target, args...)			\
@@ -2436,6 +2465,24 @@ static inline int bpf_obj_get_user(const char __user *pathname, int flags)
 	return -EOPNOTSUPP;
 }
 
+static inline void bpf_token_inc(struct bpf_token *token)
+{
+}
+
+static inline void bpf_token_put(struct bpf_token *token)
+{
+}
+
+static inline int bpf_token_new_fd(struct bpf_token *token)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline void __dev_flush(void)
 {
 }
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..3ff91f52745d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -846,6 +846,24 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall commands
+ *		to grant BPF subsystem functionality to unprivileged processes.
+ *		BPF token is automatically pinned at specified location in BPF
+ *		FS. It can be retrieved (to get FD passed to bpf() syscall)
+ *		using BPF_OBJ_GET command. It's not allowed to re-pin BPF
+ *		token using BPF_OBJ_PIN command. Such restrictions ensure BPF
+ *		token stays associated with originally intended BPF FS
+ *		instance and cannot be intentionally or unintentionally pinned
+ *		somewhere else.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +918,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
 
 enum bpf_map_type {
@@ -1622,6 +1641,25 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		/* optional, BPF token FD granting operation */
+		__u32		token_fd;
+		__u32		token_flags;
+		__u32		pin_flags;
+		/* pin_{path_fd,pathname} specify location in BPF FS instance
+		 * to pin BPF token at;
+		 * path_fd + pathname have the same semantics as openat() syscall
+		 */
+		__u32		pin_path_fd;
+		__u64		pin_pathname;
+		/* a bit set of allowed bpf() syscall commands,
+		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
+		 * will allow creating derived BPF tokens and loading new BPF
+		 * programs
+		 */
+		__u64		allowed_cmds;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..bbc17ea3878f 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
-obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
+obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 4174f76133df..b9b93b81af9a 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -22,13 +22,6 @@
 #include <linux/bpf_trace.h>
 #include "preload/bpf_preload.h"
 
-enum bpf_type {
-	BPF_TYPE_UNSPEC	= 0,
-	BPF_TYPE_PROG,
-	BPF_TYPE_MAP,
-	BPF_TYPE_LINK,
-};
-
 static void *bpf_any_get(void *raw, enum bpf_type type)
 {
 	switch (type) {
@@ -41,6 +34,9 @@ static void *bpf_any_get(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_inc(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_inc(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -61,6 +57,9 @@ static void bpf_any_put(void *raw, enum bpf_type type)
 	case BPF_TYPE_LINK:
 		bpf_link_put(raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		bpf_token_put(raw);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
@@ -89,6 +88,12 @@ static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *type)
 		return raw;
 	}
 
+	raw = bpf_token_get_from_fd(ufd);
+	if (!IS_ERR(raw)) {
+		*type = BPF_TYPE_TOKEN;
+		return raw;
+	}
+
 	return ERR_PTR(-EINVAL);
 }
 
@@ -97,6 +102,7 @@ static const struct inode_operations bpf_dir_iops;
 static const struct inode_operations bpf_prog_iops = { };
 static const struct inode_operations bpf_map_iops  = { };
 static const struct inode_operations bpf_link_iops  = { };
+static const struct inode_operations bpf_token_iops  = { };
 
 static struct inode *bpf_get_inode(struct super_block *sb,
 				   const struct inode *dir,
@@ -136,6 +142,8 @@ static int bpf_inode_type(const struct inode *inode, enum bpf_type *type)
 		*type = BPF_TYPE_MAP;
 	else if (inode->i_op == &bpf_link_iops)
 		*type = BPF_TYPE_LINK;
+	else if (inode->i_op == &bpf_token_iops)
+		*type = BPF_TYPE_TOKEN;
 	else
 		return -EACCES;
 
@@ -369,6 +377,11 @@ static int bpf_mklink(struct dentry *dentry, umode_t mode, void *arg)
 			     &bpf_iter_fops : &bpffs_obj_fops);
 }
 
+static int bpf_mktoken(struct dentry *dentry, umode_t mode, void *arg)
+{
+	return bpf_mkobj_ops(dentry, mode, arg, &bpf_token_iops, &bpffs_obj_fops);
+}
+
 static struct dentry *
 bpf_lookup(struct inode *dir, struct dentry *dentry, unsigned flags)
 {
@@ -435,8 +448,8 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
 	return ret;
 }
 
-static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void *raw,
-			  enum bpf_type type)
+int bpf_obj_pin_any(int path_fd, const char __user *pathname, void *raw,
+		    enum bpf_type type)
 {
 	struct dentry *dentry;
 	struct inode *dir;
@@ -469,6 +482,9 @@ static int bpf_obj_do_pin(int path_fd, const char __user *pathname, void *raw,
 	case BPF_TYPE_LINK:
 		ret = vfs_mkobj(dentry, mode, bpf_mklink, raw);
 		break;
+	case BPF_TYPE_TOKEN:
+		ret = vfs_mkobj(dentry, mode, bpf_mktoken, raw);
+		break;
 	default:
 		ret = -EPERM;
 	}
@@ -487,7 +503,15 @@ int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname)
 	if (IS_ERR(raw))
 		return PTR_ERR(raw);
 
-	ret = bpf_obj_do_pin(path_fd, pathname, raw, type);
+	/* disallow BPF_OBJ_PIN command for BPF token; BPF token can only be
+	 * auto-pinned during creation with BPF_TOKEN_CREATE
+	 */
+	if (type == BPF_TYPE_TOKEN) {
+		bpf_any_put(raw, type);
+		return -EOPNOTSUPP;
+	}
+
+	ret = bpf_obj_pin_any(path_fd, pathname, raw, type);
 	if (ret != 0)
 		bpf_any_put(raw, type);
 
@@ -547,6 +571,8 @@ int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags)
 		ret = bpf_map_new_fd(raw, f_flags);
 	else if (type == BPF_TYPE_LINK)
 		ret = (f_flags != O_RDWR) ? -EINVAL : bpf_link_new_fd(raw);
+	else if (type == BPF_TYPE_TOKEN)
+		ret = (f_flags != O_RDWR) ? -EINVAL : bpf_token_new_fd(raw);
 	else
 		return -ENOENT;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..745b605fad8e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5095,6 +5095,20 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
 	return ret;
 }
 
+#define BPF_TOKEN_CREATE_LAST_FIELD token_create.allowed_cmds
+
+static int token_create(union bpf_attr *attr)
+{
+	if (CHECK_ATTR(BPF_TOKEN_CREATE))
+		return -EINVAL;
+
+	/* no flags are supported yet */
+	if (attr->token_create.token_flags || attr->token_create.pin_flags)
+		return -EINVAL;
+
+	return bpf_token_create(attr);
+}
+
 static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5228,6 +5242,9 @@ static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_PROG_BIND_MAP:
 		err = bpf_prog_bind_map(&attr);
 		break;
+	case BPF_TOKEN_CREATE:
+		err = token_create(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
new file mode 100644
index 000000000000..1ece52439701
--- /dev/null
+++ b/kernel/bpf/token.c
@@ -0,0 +1,167 @@
+#include <linux/bpf.h>
+#include <linux/vmalloc.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/namei.h>
+
+DEFINE_IDR(token_idr);
+DEFINE_SPINLOCK(token_idr_lock);
+
+void bpf_token_inc(struct bpf_token *token)
+{
+	atomic64_inc(&token->refcnt);
+}
+
+static void bpf_token_put_deferred(struct work_struct *work)
+{
+	struct bpf_token *token = container_of(work, struct bpf_token, work);
+
+	kvfree(token);
+}
+
+void bpf_token_put(struct bpf_token *token)
+{
+	if (!token)
+		return;
+
+	if (!atomic64_dec_and_test(&token->refcnt))
+		return;
+
+	INIT_WORK(&token->work, bpf_token_put_deferred);
+	schedule_work(&token->work);
+}
+
+static int bpf_token_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_token *token = filp->private_data;
+
+	bpf_token_put(token);
+	return 0;
+}
+
+static ssize_t bpf_dummy_read(struct file *filp, char __user *buf, size_t siz,
+			      loff_t *ppos)
+{
+	/* We need this handler such that alloc_file() enables
+	 * f_mode with FMODE_CAN_READ.
+	 */
+	return -EINVAL;
+}
+
+static ssize_t bpf_dummy_write(struct file *filp, const char __user *buf,
+			       size_t siz, loff_t *ppos)
+{
+	/* We need this handler such that alloc_file() enables
+	 * f_mode with FMODE_CAN_WRITE.
+	 */
+	return -EINVAL;
+}
+
+static const struct file_operations bpf_token_fops = {
+	.release	= bpf_token_release,
+	.read		= bpf_dummy_read,
+	.write		= bpf_dummy_write,
+};
+
+static struct bpf_token *bpf_token_alloc(void)
+{
+	struct bpf_token *token;
+
+	token = kvzalloc(sizeof(*token), GFP_USER);
+	if (!token)
+		return NULL;
+
+	atomic64_set(&token->refcnt, 1);
+
+	return token;
+}
+
+static bool is_bit_subset_of(u32 subset, u32 superset)
+{
+	return (superset & subset) == subset;
+}
+
+int bpf_token_create(union bpf_attr *attr)
+{
+	struct bpf_token *new_token, *token = NULL;
+	int ret;
+
+	if (attr->token_create.token_fd) {
+		token = bpf_token_get_from_fd(attr->token_create.token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		/* if provided BPF token doesn't allow creating new tokens,
+		 * then use system-wide capability checks only
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_TOKEN_CREATE)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	ret = -EPERM;
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN))
+		goto out;
+
+	/* requested cmds should be a subset of associated token's set */
+	if (token && !is_bit_subset_of(attr->token_create.allowed_cmds, token->allowed_cmds))
+		goto out;
+
+	new_token = bpf_token_alloc();
+	if (!new_token) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	new_token->allowed_cmds = attr->token_create.allowed_cmds;
+
+	ret = bpf_obj_pin_any(attr->token_create.pin_path_fd,
+			      u64_to_user_ptr(attr->token_create.pin_pathname),
+			      new_token, BPF_TYPE_TOKEN);
+	if (ret < 0)
+		bpf_token_put(new_token);
+out:
+	bpf_token_put(token);
+	return ret;
+}
+
+#define BPF_TOKEN_INODE_NAME "bpf-token"
+
+/* Alloc anon_inode and FD for prepared token.
+ * Returns fd >= 0 on success; negative error, otherwise.
+ */
+int bpf_token_new_fd(struct bpf_token *token)
+{
+	return anon_inode_getfd(BPF_TOKEN_INODE_NAME, &bpf_token_fops, token, O_CLOEXEC);
+}
+
+struct bpf_token *bpf_token_get_from_fd(u32 ufd)
+{
+	struct fd f = fdget(ufd);
+	struct bpf_token *token;
+
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+	if (f.file->f_op != &bpf_token_fops) {
+		fdput(f);
+		return ERR_PTR(-EINVAL);
+	}
+
+	token = f.file->private_data;
+	bpf_token_inc(token);
+	fdput(f);
+
+	return token;
+}
+
+bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	if (!token)
+		return false;
+
+	return token->allowed_cmds & (1ULL << cmd);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..3ff91f52745d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -846,6 +846,24 @@ union bpf_iter_link_info {
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ * BPF_TOKEN_CREATE
+ *	Description
+ *		Create BPF token with embedded information about what
+ *		BPF-related functionality it allows. This BPF token can be
+ *		passed as an extra parameter to various bpf() syscall commands
+ *		to grant BPF subsystem functionality to unprivileged processes.
+ *		BPF token is automatically pinned at specified location in BPF
+ *		FS. It can be retrieved (to get FD passed to bpf() syscall)
+ *		using BPF_OBJ_GET command. It's not allowed to re-pin BPF
+ *		token using BPF_OBJ_PIN command. Such restrictions ensure BPF
+ *		token stays associated with originally intended BPF FS
+ *		instance and cannot be intentionally or unintentionally pinned
+ *		somewhere else.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -900,6 +918,7 @@ enum bpf_cmd {
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
+	BPF_TOKEN_CREATE,
 };
 
 enum bpf_map_type {
@@ -1622,6 +1641,25 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	struct { /* struct used by BPF_TOKEN_CREATE command */
+		/* optional, BPF token FD granting operation */
+		__u32		token_fd;
+		__u32		token_flags;
+		__u32		pin_flags;
+		/* pin_{path_fd,pathname} specify location in BPF FS instance
+		 * to pin BPF token at;
+		 * path_fd + pathname have the same semantics as openat() syscall
+		 */
+		__u32		pin_path_fd;
+		__u64		pin_pathname;
+		/* a bit set of allowed bpf() syscall commands,
+		 * e.g., (1ULL << BPF_TOKEN_CREATE) | (1ULL << BPF_PROG_LOAD)
+		 * will allow creating derived BPF tokens and loading new BPF
+		 * programs
+		 */
+		__u64		allowed_cmds;
+	} token_create;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.34.1

