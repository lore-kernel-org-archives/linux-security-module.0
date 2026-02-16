Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260D28C871;
	Mon, 16 Feb 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249954; cv=none; b=kh7nGR24oNYN3yGkY0seN+OGSG/I7Hes1SsDjuAFdExhicTIw4NfT5LC2ZxmF6ZgcRpWWYdjUfTYSEKs2Fz+pASJJ39xPAyRjE6JecJVTRiqzfsdTerQOwmAUHpHr2eN0VghUpyAeMhZugfQmiXQm8rdcrDs8doyfJ+uJnLT9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249954; c=relaxed/simple;
	bh=6wHmz9hyiXjpmD0yAqeRqRilUG3nZa79IPdxYDPHmsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y7Qq8Lz0Gr6xiBn6X/kTlCXjiCPXMpNolYQmw9Y1kUM7rckO3H5zSnKXC5SBRpH7+FHznI3JaW5G2Xwvc+TFhmlz26F51C0PJWuFYS1p0ZEY3kpObWRvFtzXl/P8TIqvqLGuEtcbynmcCk0Fmjfx7/kXEkTiqcVu5d749GnHpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV1PF0sI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV1PF0sI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D06C116C6;
	Mon, 16 Feb 2026 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249953;
	bh=6wHmz9hyiXjpmD0yAqeRqRilUG3nZa79IPdxYDPHmsk=;
	h=From:Date:Subject:To:Cc:From;
	b=MV1PF0sIePoXy9JI3mRl5jnl5gqsLkYsT3ROi0XM9IFKiQZDSQfRza3DCDWMHcSeg
	 vJ08Ccv30f9uNKETRNl+iqhnk3oWQ5ImjNFUGrNYdhVy9iDZTm+/xUBVgDqmRzzext
	 kyGZz0e1eIyrGbYYrBCcJG2Dg/pHmRHB7zKIFvV6jswwPD/uclhvWGCwIfhpiVya6b
	 y+mETrThFV/E4Lgd6qL6EV+nqhM59x/YMvqV+IHzkq6+jy0unY4B8nOndJ2gRp90XT
	 jKWV/n7JeuHQPw7K2TAe+flxWETxYj1adP3AKxl2A44LeBkqw6begsZtaMyQhq0g6v
	 Qxe7ds4kX+0xA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:52:25 +0100
Subject: [PATCH RFC] security: add LSM blob and hooks for namespaces
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org>
X-B4-Tracking: v=1; b=H4sIABghk2kC/x2Myw7CIBAAf6XZs5gtlK16NfEDvBoPQBdLTGkD9
 ZWm/y56nElmFsicAmc4VAskfoYcxlig3lTgehNvLEJXGCRKQokkXmO6i8zukcL8EdEMnCfjWHR
 kWkW4k9Z5KPWU2If3/3yB8+kI1yKtySxsMtH1v+lg8sxp20qn9hpl0xmnWda6VuSs9+1eNVp7J
 E2oLBKs6xdRRMTGsAAAAA==
X-Change-ID: 20260206-work-security-namespace-d6a736082bcf
To: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=11032; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6wHmz9hyiXjpmD0yAqeRqRilUG3nZa79IPdxYDPHmsk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROVlTg+hPiGlMnZVa7QnjCj4bci1vDovftNNmwNOj0m
 xe84rvDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyLYThf4FqzMPg06rTqre+
 ejmrSczxXj+vx0fBvZsSs5RN3Y8nTmD4w3P83NsjM1z91WZtydyxZmt/ww7HVXwh131nxWywYbh
 pyQgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

All namespace types now share the same ns_common infrastructure. Extend
this to include a security blob so LSMs can start managing namespaces
uniformly without having to add one-off hooks or security fields to
every individual namespace type.

Add a ns_security pointer to ns_common and the corresponding lbs_ns
blob size to lsm_blob_sizes. Allocation and freeing hooks are called
from the common __ns_common_init() and __ns_common_free() paths so
every namespace type gets covered in one go. All information about the
namespace type and the appropriate casting helpers to get at the
containing namespace are available via ns_common making it
straightforward for LSMs to differentiate when they need to.

A namespace_install hook is called from validate_ns() during setns(2)
giving LSMs a chance to enforce policy on namespace transitions.

Individual namespace types can still have their own specialized security
hooks when needed. This is just the common baseline that makes it easy
to track and manage namespaces from the security side without requiring
every namespace type to reinvent the wheel.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/lsm_hook_defs.h      |  3 ++
 include/linux/lsm_hooks.h          |  1 +
 include/linux/ns/ns_common_types.h |  3 ++
 include/linux/security.h           | 20 ++++++++++
 kernel/nscommon.c                  | 12 ++++++
 kernel/nsproxy.c                   |  8 +++-
 security/lsm_init.c                |  2 +
 security/security.c                | 76 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 8c42b4bde09c..fefd3aa6d8f4 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -260,6 +260,9 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
+LSM_HOOK(int, 0, namespace_alloc, struct ns_common *ns)
+LSM_HOOK(void, LSM_RET_VOID, namespace_free, struct ns_common *ns)
+LSM_HOOK(int, 0, namespace_install, const struct nsset *nsset, struct ns_common *ns)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
 	 struct lsm_prop *prop)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d48bf0ad26f4..3e7afe76e86c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -111,6 +111,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_ipc;
 	unsigned int lbs_key;
 	unsigned int lbs_msg_msg;
+	unsigned int lbs_ns;
 	unsigned int lbs_perf_event;
 	unsigned int lbs_task;
 	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
index 0014fbc1c626..170288e2e895 100644
--- a/include/linux/ns/ns_common_types.h
+++ b/include/linux/ns/ns_common_types.h
@@ -115,6 +115,9 @@ struct ns_common {
 	struct dentry *stashed;
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
+#ifdef CONFIG_SECURITY
+	void *ns_security;
+#endif
 	union {
 		struct ns_tree;
 		struct rcu_head ns_rcu;
diff --git a/include/linux/security.h b/include/linux/security.h
index 83a646d72f6f..611b9098367d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -67,6 +67,7 @@ enum fs_value_type;
 struct watch;
 struct watch_notification;
 struct lsm_ctx;
+struct nsset;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -80,6 +81,7 @@ struct lsm_ctx;
 
 struct ctl_table;
 struct audit_krule;
+struct ns_common;
 struct user_namespace;
 struct timezone;
 
@@ -533,6 +535,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
+int security_namespace_alloc(struct ns_common *ns);
+void security_namespace_free(struct ns_common *ns);
+int security_namespace_install(const struct nsset *nsset, struct ns_common *ns);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1407,6 +1412,21 @@ static inline int security_create_user_ns(const struct cred *cred)
 	return 0;
 }
 
+static inline int security_namespace_alloc(struct ns_common *ns)
+{
+	return 0;
+}
+
+static inline void security_namespace_free(struct ns_common *ns)
+{
+}
+
+static inline int security_namespace_install(const struct nsset *nsset,
+					     struct ns_common *ns)
+{
+	return 0;
+}
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bdc3c86231d3..de774e374f9d 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -4,6 +4,7 @@
 #include <linux/ns_common.h>
 #include <linux/nstree.h>
 #include <linux/proc_ns.h>
+#include <linux/security.h>
 #include <linux/user_namespace.h>
 #include <linux/vfsdebug.h>
 
@@ -59,6 +60,9 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 	refcount_set(&ns->__ns_ref, 1);
 	ns->stashed = NULL;
+#ifdef CONFIG_SECURITY
+	ns->ns_security = NULL;
+#endif
 	ns->ops = ops;
 	ns->ns_id = 0;
 	ns->ns_type = ns_type;
@@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 		ret = proc_alloc_inum(&ns->inum);
 	if (ret)
 		return ret;
+
+	ret = security_namespace_alloc(ns);
+	if (ret) {
+		proc_free_inum(ns->inum);
+		return ret;
+	}
+
 	/*
 	 * Tree ref starts at 0. It's incremented when namespace enters
 	 * active use (installed in nsproxy) and decremented when all
@@ -91,6 +102,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 void __ns_common_free(struct ns_common *ns)
 {
+	security_namespace_free(ns);
 	proc_free_inum(ns->inum);
 }
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 259c4b4f1eeb..f0b30d1907e7 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 
 static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
 {
-	return ns->ops->install(nsset, ns);
+	int ret;
+
+	ret = ns->ops->install(nsset, ns);
+	if (ret)
+		return ret;
+
+	return security_namespace_install(nsset, ns);
 }
 
 /*
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 573e2a7250c4..637c2d65e131 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -301,6 +301,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
 	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_ns, &blob_sizes.lbs_ns);
 	lsm_blob_size_update(&blobs->lbs_perf_event,
 			     &blob_sizes.lbs_perf_event);
 	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
@@ -446,6 +447,7 @@ int __init security_init(void)
 		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
 		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
 		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
+		lsm_pr("blob(ns) size %d\n", blob_sizes.lbs_ns);
 		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
 		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
 		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
diff --git a/security/security.c b/security/security.c
index 67af9228c4e9..dcf073cac848 100644
--- a/security/security.c
+++ b/security/security.c
@@ -26,6 +26,7 @@
 #include <linux/string.h>
 #include <linux/xattr.h>
 #include <linux/msg.h>
+#include <linux/ns_common.h>
 #include <linux/overflow.h>
 #include <linux/perf_event.h>
 #include <linux/fs.h>
@@ -355,6 +356,19 @@ static int lsm_superblock_alloc(struct super_block *sb)
 			      GFP_KERNEL);
 }
 
+/**
+ * lsm_ns_alloc - allocate a composite namespace blob
+ * @ns: the namespace that needs a blob
+ *
+ * Allocate the namespace blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_ns_alloc(struct ns_common *ns)
+{
+	return lsm_blob_alloc(&ns->ns_security, blob_sizes.lbs_ns, GFP_KERNEL);
+}
+
 /**
  * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
  * @uctx: a userspace LSM context to be filled
@@ -3255,6 +3269,68 @@ int security_create_user_ns(const struct cred *cred)
 	return call_int_hook(userns_create, cred);
 }
 
+/**
+ * security_namespace_alloc() - Allocate LSM security data for a namespace
+ * @ns: the namespace being allocated
+ *
+ * Allocate and attach security data to the namespace. The namespace type
+ * is available via ns->ns_type, and the owning user namespace (if any)
+ * via ns->ops->owner(ns).
+ *
+ * Return: Returns 0 if successful, otherwise < 0 error code.
+ */
+int security_namespace_alloc(struct ns_common *ns)
+{
+	int rc;
+
+	rc = lsm_ns_alloc(ns);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(namespace_alloc, ns);
+	if (unlikely(rc))
+		security_namespace_free(ns);
+
+	return rc;
+}
+
+/**
+ * security_namespace_free() - Release LSM security data from a namespace
+ * @ns: the namespace being freed
+ *
+ * Release security data attached to the namespace. Called before the
+ * namespace structure is freed.
+ *
+ * Note: The namespace may be freed via kfree_rcu(). LSMs must use
+ * RCU-safe freeing for any data that might be accessed by concurrent
+ * RCU readers.
+ */
+void security_namespace_free(struct ns_common *ns)
+{
+	if (!ns->ns_security)
+		return;
+
+	call_void_hook(namespace_free, ns);
+
+	kfree(ns->ns_security);
+	ns->ns_security = NULL;
+}
+
+/**
+ * security_namespace_install() - Check permission to install a namespace
+ * @nsset: the target nsset being configured
+ * @ns: the namespace being installed
+ *
+ * Check permission before allowing a namespace to be installed into the
+ * process's set of namespaces via setns(2).
+ *
+ * Return: Returns 0 if permission is granted, otherwise < 0 error code.
+ */
+int security_namespace_install(const struct nsset *nsset, struct ns_common *ns)
+{
+	return call_int_hook(namespace_install, nsset, ns);
+}
+
 /**
  * security_ipc_permission() - Check if sysv ipc access is allowed
  * @ipcp: ipc permission structure

---
base-commit: 72c395024dac5e215136cbff793455f065603b06
change-id: 20260206-work-security-namespace-d6a736082bcf

