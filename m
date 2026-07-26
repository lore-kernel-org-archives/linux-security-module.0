Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBC3CB541
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082477; cv=none; b=FZEhO+0G/14Ra9Ht9ahWhb9p7+05O2dz+wJ4E37EdgdVqswhjgn1JHMp3jP0L9d1qCzdiPDk1ZbO3RJQZI6ZhsOEp/ProqSrfUrx5IPmhY2tyhY06NXKj1NasiHXwEdc9odvQqZ15aq//8nDSbaBnPbzzOdL4zxO2ULUbXjhNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082477; c=relaxed/simple;
	bh=miGtGkG0g6CkOoaPOFLTz4Av5PQQmmsfLqa1Ivgj3Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsZZ1qXx47JydK9rhsGnSamwZlJA9Le2up3H4TlYEG8rniymWy1YyomexbYkXScYJEECGXMlz7b5iJn75lgAhJLSvXAyLIXKfmXprHsT20tpHZns5reqzAeLm7MbjemPuAkCSW2Gy/NieH8XO2MbAuOl8f4EKbZEmxi1zUzECcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=CSZYjnkT; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="CSZYjnkT"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcl3GNFzf0K;
	Sun, 26 Jul 2026 18:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082455;
	bh=6Q6b5R+/zJAz/E43Nd9NKphmUL6c4gvaloOxmY6NZX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSZYjnkTlPUogNYvVLi7AelUF1hQx2tRH+ZGQwSdiHQ+sxZXRciVubxcbtLOPNtXY
	 VUhI4SztoHA6Z+yHU7bXzwoPAXW6u5+h5/B6NFb4+xSCxjyzlM4MLEpDXmRzboRBwe
	 xa3vRz3xTnXC7t8siiLYiOpiXRfYuYf2aq9RYE6U=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rck29jmzBwT;
	Sun, 26 Jul 2026 18:14:14 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 02/12] security: add LSM blob and hooks for namespaces
Date: Sun, 26 Jul 2026 18:13:47 +0200
Message-ID: <20260726161400.3010511-3-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

From: Christian Brauner <brauner@kernel.org>

All namespace types now share the same ns_common infrastructure. Extend
this to include a security blob so LSMs can start managing namespaces
uniformly without having to add one-off hooks or security fields to
every individual namespace type.

Add a ns_security pointer to ns_common and the corresponding lbs_ns blob
size to lsm_blob_sizes. Allocation and freeing hooks are called from the
common __ns_common_init() and __ns_common_free() paths so every
namespace type gets covered in one go. All information about the
namespace type and the appropriate casting helpers to get at the
containing namespace are available via ns_common making it
straightforward for LSMs to differentiate when they need to.

A namespace_install hook is called from validate_ns() during setns(2)
giving LSMs a chance to enforce policy on namespace transitions.  The
LSM check runs before ns->ops->install() so the security module can deny
the operation before any type-specific installation effects.

Individual namespace types can still have their own specialized security
hooks when needed. This is just the common baseline that makes it easy
to track and manage namespaces from the security side without requiring
every namespace type to reinvent the wheel.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075c28758e1f@kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
https://patch.msgid.link/20260527181127.879771-2-mic@digikod.net
- Split the anonymous mount-namespace free-path change into a
  preceding preparatory commit: dropping the is_anon_ns() guard in
  free_mnt_ns(), adding MNT_NS_INO_SPECIAL_MAX, and guarding
  proc_free_inum() in __ns_common_free() now live there, so that
  commit can be reviewed on its own; only the security_namespace_free()
  call in __ns_common_free() remains here (suggested by Christian
  Brauner and Paul Moore).
- Remove the RCU note from the security_namespace_free() kdoc; it
  read as generic RCU and object-lifetime guidance (suggested by Paul
  Moore).

Changes since v1:
https://patch.msgid.link/20260312100444.2609563-2-mic@digikod.net
- Move security_namespace_install() before ns->ops->install() in
  validate_ns() (suggested by Christian Brauner).
- Only call proc_free_inum() on security_namespace_alloc() failure
  when inum was allocated by this function (suggested by Christian
  Brauner).
- Fix anonymous mount namespace blob leak: move
  security_namespace_free() into __ns_common_free() and make
  proc_free_inum() conditional on dynamically allocated inums
  via MNT_NS_INO_SPECIAL_MAX, so free_mnt_ns() can call
  ns_common_free() unconditionally (suggested by Christian
  Brauner).  Also reported by Daniel Durning while working on
  SELinux support for these hooks:
  https://lore.kernel.org/r/20260318201747.4477-1-danieldurning.work@gmail.com
- Rename security_namespace_alloc() to security_namespace_init()
  to match the caller-name convention and reflect that the hook
  initialises LSM state attached to a constructed ns_common rather
  than allocating the ns_common itself (suggested by Paul Moore).
- Refine the security_namespace_free() kdoc to clarify that
  RCU-safe blob freeing is required only if an LSM exposes data
  within the blob to concurrent RCU readers, and document that
  the blob memory itself is released with kfree() after the
  namespace_free hooks return (suggested by Paul Moore).
- Günther Noack's v1 Reviewed-by is not carried forward to v2:
  the validate_ns() reordering and the anonymous-mount-namespace
  blob-leak fix are semantic changes that were not part of his
  review.  Cc'd instead.
---
 include/linux/lsm_hook_defs.h      |  3 ++
 include/linux/lsm_hooks.h          |  1 +
 include/linux/ns/ns_common_types.h |  3 ++
 include/linux/security.h           | 20 +++++++++
 kernel/nscommon.c                  | 14 ++++++
 kernel/nsproxy.c                   |  6 +++
 security/lsm_init.c                |  2 +
 security/security.c                | 72 ++++++++++++++++++++++++++++++
 8 files changed, 121 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..0da6c7e8f659 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -265,6 +265,9 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigned long arg2,
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
+LSM_HOOK(int, 0, namespace_init, struct ns_common *ns)
+LSM_HOOK(void, LSM_RET_VOID, namespace_free, struct ns_common *ns)
+LSM_HOOK(int, 0, namespace_install, const struct nsset *nsset, struct ns_common *ns)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
 	 struct lsm_prop *prop)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..5cff13069529 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -112,6 +112,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_ipc;
 	unsigned int lbs_key;
 	unsigned int lbs_msg_msg;
+	unsigned int lbs_ns;
 	unsigned int lbs_perf_event;
 	unsigned int lbs_task;
 	unsigned int lbs_xattr_count; /* num xattr slots in new_xattrs array */
diff --git a/include/linux/ns/ns_common_types.h b/include/linux/ns/ns_common_types.h
index ea45c54e4435..5cfe0ce3c881 100644
--- a/include/linux/ns/ns_common_types.h
+++ b/include/linux/ns/ns_common_types.h
@@ -116,6 +116,9 @@ struct ns_common {
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
index 153e9043058f..bf002ed14ac8 100644
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
 
@@ -540,6 +542,9 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
+int security_namespace_init(struct ns_common *ns);
+void security_namespace_free(struct ns_common *ns);
+int security_namespace_install(const struct nsset *nsset, struct ns_common *ns);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1431,6 +1436,21 @@ static inline int security_create_user_ns(const struct cred *cred)
 	return 0;
 }
 
+static inline int security_namespace_init(struct ns_common *ns)
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
index e6f623e1bc37..e72426bba29a 100644
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
@@ -77,6 +81,14 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 		ret = proc_alloc_inum(&ns->inum);
 	if (ret)
 		return ret;
+
+	ret = security_namespace_init(ns);
+	if (ret) {
+		if (!inum)
+			proc_free_inum(ns->inum);
+		return ret;
+	}
+
 	/*
 	 * Tree ref starts at 0. It's incremented when namespace enters
 	 * active use (installed in nsproxy) and decremented when all
@@ -91,6 +103,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 
 void __ns_common_free(struct ns_common *ns)
 {
+	security_namespace_free(ns);
+
 	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
 		proc_free_inum(ns->inum);
 }
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index d9d3d5973bf5..0f1b208d8eef 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -385,6 +385,12 @@ static int prepare_nsset(unsigned flags, struct nsset *nsset)
 
 static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
 {
+	int ret;
+
+	ret = security_namespace_install(nsset, ns);
+	if (ret)
+		return ret;
+
 	return ns->ops->install(nsset, ns);
 }
 
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..dcd2a228c4f6 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -303,6 +303,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
 	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_blob_size_update(&blobs->lbs_ns, &blob_sizes.lbs_ns);
 	lsm_blob_size_update(&blobs->lbs_perf_event,
 			     &blob_sizes.lbs_perf_event);
 	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
@@ -450,6 +451,7 @@ int __init security_init(void)
 		lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
 		lsm_pr("blob(key) size %d\n", blob_sizes.lbs_key);
 		lsm_pr("blob(msg_msg)_size %d\n", blob_sizes.lbs_msg_msg);
+		lsm_pr("blob(ns) size %d\n", blob_sizes.lbs_ns);
 		lsm_pr("blob(sock) size %d\n", blob_sizes.lbs_sock);
 		lsm_pr("blob(superblock) size %d\n", blob_sizes.lbs_superblock);
 		lsm_pr("blob(perf_event) size %d\n", blob_sizes.lbs_perf_event);
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..e0b43ab60d23 100644
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
@@ -381,6 +382,19 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
@@ -3358,6 +3372,64 @@ int security_create_user_ns(const struct cred *cred)
 	return call_int_hook(userns_create, cred);
 }
 
+/**
+ * security_namespace_init() - Initialize LSM security data for a namespace
+ * @ns: the namespace being initialized
+ *
+ * Initialize the LSM security blob attached to the namespace. The namespace type
+ * is available via ns->ns_type, and the owning user namespace (if any)
+ * via ns->ops->owner(ns).
+ *
+ * Return: Returns 0 if successful, otherwise < 0 error code.
+ */
+int security_namespace_init(struct ns_common *ns)
+{
+	int rc;
+
+	rc = lsm_ns_alloc(ns);
+	if (unlikely(rc))
+		return rc;
+
+	rc = call_int_hook(namespace_init, ns);
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
-- 
2.54.0

