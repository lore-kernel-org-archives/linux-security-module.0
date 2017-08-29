From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 29 Aug 2017 14:05:07 -0700
Subject: [PATCH 11/11] LSM: Allow stacking of all existing security
In-Reply-To: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
References: <bbf8bc4a-b56d-e800-4231-60058e4a88bc@schaufler-ca.com>
Message-ID: <886849ce-87c1-9a50-42db-eb6f9ee4fe41@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Subject: [PATCH 11/11] LSM: Allow stacking of all existing security

Allow any combination of existing security modules,
including those using secids and security marked networking.

The interfaces used by filesystems to maintain security
attributes:
	security_inode_setsecctx
	security_inode_getsecctx
	security_inode_notifysecctx
have been trained to keep a full set of attributes
using the "lsm1='data1',lsm2='data2'" format.

A prtcl interface has been added to identify which
security module should be invoked when secids are
translated to secctx and back. If none is specified the
first module will be used. This eliminates the ambiguity
of what data will be seen in user-space at the cost of
requiring user-space code to be explicit about what it
wants to see.

Issues remain with the use of netlabel, as SELinux and
Smack use the interfaces differently.

Audit has not been fully tested, and may not always
be providing the correct security module information.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/xattr.c                          |   6 +-
 include/linux/lsm_audit.h           |   4 +
 include/linux/lsm_hooks.h           |  10 +-
 include/net/request_sock.h          |   2 +
 include/uapi/linux/prctl.h          |   6 +
 kernel/fork.c                       |   3 +
 net/netlabel/netlabel_unlabeled.c   |   2 +-
 security/Kconfig                    |  41 +--
 security/security.c                 | 658 ++++++++++++++++++++++++++++++------
 security/selinux/hooks.c            |  41 +--
 security/selinux/include/objsec.h   |  13 +
 security/selinux/include/security.h |   3 +-
 security/selinux/netlabel.c         |   5 +-
 security/selinux/ss/services.c      |   4 +-
 security/smack/smack.h              |  10 +
 security/smack/smack_lsm.c          |  79 ++---
 security/smack/smack_netfilter.c    |  17 +-
 security/smack/smackfs.c            |   3 +-
 security/stacking.c                 |  63 +++-
 19 files changed, 733 insertions(+), 237 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 464c94bf65f9..01983733651c 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -249,7 +249,11 @@ xattr_getsecurity(struct inode *inode, const char *name, void *value,
 	}
 	memcpy(value, buffer, len);
 out:
-	security_release_secctx(buffer, len);
+	/*
+	 * security_inode_getsecurity() does not put a secctx
+	 * into buffer, it puts an allocated string into buffer.
+	 */
+	kfree(buffer);
 out_noalloc:
 	return len;
 }
diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 22b5d4e687ce..44004e477d97 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -94,7 +94,11 @@ struct common_audit_data {
 		struct lsm_ibendport_audit *ibendport;
 	} u;
 	/* this union contains LSM specific data */
+#ifdef CONFIG_SECURITY_STACKING
+	struct {
+#else
 	union {
+#endif
 #ifdef CONFIG_SECURITY_SMACK
 		struct smack_audit_data *smack_audit_data;
 #endif
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 75d95854f2ed..61460f930adb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1939,7 +1939,8 @@ struct lsm_secids {
 
 extern u32 lsm_secids_to_token(const struct lsm_secids *secids);
 extern void lsm_token_to_secids(const u32 token, struct lsm_secids *secids);
-extern u32 lsm_token_to_module_secid(const u32 token, int lsm);
+extern u32 lsm_token_get_secid(const u32 token, int lsm);
+extern u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm);
 extern void lsm_secids_init(struct lsm_secids *secids);
 #else /* CONFIG_SECURITY_STACKING */
 struct lsm_secids {
@@ -1957,11 +1958,16 @@ static inline void lsm_token_to_secids(const u32 token,
 	secids->secid = token;
 }
 
-static inline u32 lsm_token_to_module_secid(const u32 token, int lsm)
+static inline u32 lsm_token_get_secid(const u32 token, int lsm)
 {
 	return token;
 }
 
+static inline u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm)
+{
+	return lsecid;
+}
+
 static inline void lsm_secids_init(struct lsm_secids *secids)
 {
 	secids->secid = 0;
diff --git a/include/net/request_sock.h b/include/net/request_sock.h
index 23e22054aa60..07c0e919c4e7 100644
--- a/include/net/request_sock.h
+++ b/include/net/request_sock.h
@@ -102,6 +102,8 @@ reqsk_alloc(const struct request_sock_ops *ops, struct sock *sk_listener,
 	sk_tx_queue_clear(req_to_sk(req));
 	req->saved_syn = NULL;
 	refcount_set(&req->rsk_refcnt, 0);
+	req->secid = 0;
+	req->peer_secid = 0;
 
 	return req;
 }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a8d0759a9e40..e7234c5cb7de 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -197,4 +197,10 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
+/*
+ * Control the LSM specific information reported by
+ * SO_PEERSEC and /proc/.../attr/current
+ */
+#define	PR_GET_DISPLAY_LSM	48
+#define	PR_SET_DISPLAY_LSM	49
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 5ff0ebcaafc3..01b90e4f76eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1696,6 +1696,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
 #endif
+#ifdef CONFIG_SECURITY
+	p->security = NULL;
+#endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 22dc1b9d6362..751cfac79b3e 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -899,7 +899,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
-	 * for IPv4 and IPv4, with the same LSM security context which should
+	 * for IPv4 and IPv6, with the same LSM security context which should
 	 * achieve the same result. */
 	if (!info->attrs[NLBL_UNLABEL_A_SECCTX] ||
 	    !info->attrs[NLBL_UNLABEL_A_IFACE] ||
diff --git a/security/Kconfig b/security/Kconfig
index 36a1519f31d2..499175d0b164 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -292,42 +292,27 @@ endmenu
 menu "Security Module Stack"
 	visible if SECURITY_STACKING
 
-choice
-	prompt "Stacked 'extreme' security module"
-	default SECURITY_SELINUX_STACKED if SECURITY_SELINUX
-	default SECURITY_SMACK_STACKED if SECURITY_SMACK
-
-	help
-	  Enable an extreme security module. These modules cannot
-	  be used at the same time.
-
-	config SECURITY_SELINUX_STACKED
-		bool "SELinux" if SECURITY_SELINUX=y
+config SECURITY_SELINUX_STACKED
+	bool "SELinux" if SECURITY_SELINUX=y
 	help
-	  Add the SELinux security module to the stack. At this
-	  time the Smack security module is incompatible with this
-	  module.
+	  Add the SELinux security module to the stack.
 	  Please be sure your user space code is accomodating of
 	  this security module.
+	  Ensure that your network configuration is compatible
+	  with your combination of security modules.
 
-	config SECURITY_SMACK_STACKED
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_SMACK_STACKED
+	bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
 	help
-	  Add the Smack security module to the stack. At this
-	  time the SELinux security module is incompatible with this
-	  module.
+	  Add the Smack security module to the stack.
 	  Please be sure your user space code is accomodating of
 	  this security module.
+	  Ensure that your network configuration is compatible
+	  with your combination of security modules.
 
-	config SECURITY_NOTHING_STACKED
-		bool "Use no 'extreme' security module"
-	help
-	  Add neither the SELinux security module nor the Smack security
-	  module to the stack.
-	  Please be sure your user space code does not require either of
-	  these security modules.
-
-endchoice
+	  If you are unsure how to answer this question, answer N.
 
 config SECURITY_TOMOYO_STACKED
 	bool "TOMOYO support is enabled by default"
diff --git a/security/security.c b/security/security.c
index a66663ac932b..0ee8aca486ca 100644
--- a/security/security.c
+++ b/security/security.c
@@ -28,10 +28,16 @@
 #include <linux/backing-dev.h>
 #include <linux/string.h>
 #include <linux/msg.h>
+#include <linux/prctl.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
-#define MAX_LSM_EVM_XATTR	2
+/*
+ * EVM, SElinux, Smack, and one extra.
+ *
+ * This should be computed.
+ */
+#define MAX_LSM_EVM_XATTR	8
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
@@ -41,7 +47,17 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes;
+
+/*
+ * If stacking is enabled the task blob will always
+ * include an indicator of what security module data
+ * should be displayed. This is set with PR_SET_DISPLAY_LSM.
+ */
+static struct lsm_blob_sizes blob_sizes = {
+#ifdef CONFIG_SECURITY_STACKING
+	.lbs_task = SECURITY_NAME_MAX + 2,
+#endif
+};
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
@@ -354,6 +370,64 @@ int lsm_file_alloc(struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_STACKING
+static inline char *lsm_of_task(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	if (task->security == NULL)
+		pr_info("%s: task has no lsm name.\n", __func__);
+#endif
+	return task->security;
+}
+#endif
+
+#ifdef CONFIG_SECURITY_STACKING
+struct lsm_value {
+	char *lsm;
+	char *data;
+};
+
+/**
+ * lsm_parse_context - break a compound "context" into module data
+ * @cxt: the initial data, which will be modified
+ * @vlist: an array to receive the results
+ *
+ * Returns the number of entries, or -EINVAL if the cxt is unworkable.
+ */
+static int lsm_parse_context(char *cxt, struct lsm_value *vlist)
+{
+	char *lsm;
+	char *data;
+	char *cp;
+	int i;
+
+	lsm = cxt;
+	for (i = 0; i < LSM_MAX_MAJOR; i++) {
+		data = strstr(lsm, "='");
+		if (!data)
+			break;
+		*data = '\0';
+		data += 2;
+		cp = strchr(data, '\'');
+		if (!cp)
+			return -EINVAL;
+		*cp++ = '\0';
+		vlist[i].lsm = lsm;
+		vlist[i].data = data;
+		if (*cp == '\0') {
+			i++;
+			break;
+		}
+		if (*cp == ',')
+			cp++;
+		else
+			return -EINVAL;
+		lsm = cp;
+	}
+	return i;
+}
+#endif /* CONFIG_SECURITY_STACKING */
+
 /**
  * lsm_task_alloc - allocate a composite task blob
  * @task: the task that needs a blob
@@ -860,9 +934,10 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
-	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
-	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
+	struct security_hook_list *hp;
+	struct xattr xattrs[MAX_LSM_EVM_XATTR + 1];
+	int rc = -EOPNOTSUPP;
+	int attrn = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -870,24 +945,41 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!initxattrs)
 		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
 				     dir, qstr, NULL, NULL, NULL);
-	memset(new_xattrs, 0, sizeof(new_xattrs));
-	lsm_xattr = new_xattrs;
-	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
+
+	memset(xattrs, 0, sizeof(xattrs));
+
+	list_for_each_entry(hp, &security_hook_heads.inode_init_security,
+									list) {
+		rc = hp->hook.inode_init_security(inode, dir, qstr,
+						  &xattrs[attrn].name,
+						  &xattrs[attrn].value,
+						  &xattrs[attrn].value_len);
+		/*
+		 * If the module doesn't support this, reuse the entry.
+		 * If it's a real error, bail out of the loop.
+		 */
+		if (rc == -EOPNOTSUPP)
+			rc = 0;
+		else if (rc)
+			break;
+		else
+			attrn++;
+	}
+	if (rc)
 		goto out;
 
-	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
+	/*
+	 * Should EVM loop on these?
+	 * Do the first one until it's sorted out.
+	 */
+	rc = evm_inode_init_security(inode, &xattrs[0], &xattrs[attrn]);
+	if (rc)
 		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	rc = initxattrs(inode, xattrs, fs_data);
 out:
-	for (xattr = new_xattrs; xattr->value != NULL; xattr++)
-		kfree(xattr->value);
-	return (ret == -EOPNOTSUPP) ? 0 : ret;
+	for (; attrn >= 0; attrn--)
+		kfree(xattrs[attrn].value);
+	return (rc == -EOPNOTSUPP) ? 0 : rc;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
@@ -1115,24 +1207,26 @@ int security_inode_getattr(const struct path *path)
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	struct security_hook_list *hp;
+	int rc = -ENOSYS;
+	int trc;
 
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	/*
-	 * SELinux and Smack integrate the cap call,
-	 * so assume that all LSMs supplying this call do so.
-	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
-
-	if (ret == 1)
-		ret = cap_inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
-	if (ret)
-		return ret;
+	list_for_each_entry(hp, &security_hook_heads.inode_setxattr, list) {
+		trc = hp->hook.inode_setxattr(dentry, name, value, size, flags);
+		if (trc != -ENOSYS) {
+			rc = trc;
+			break;
+		}
+	}
+	if (rc == -ENOSYS)
+		rc = cap_inode_setxattr(dentry, name, value, size, flags);
+	if (rc)
+		return rc;
+	rc = ima_inode_setxattr(dentry, name, value, size);
+	if (rc)
+		return rc;
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
@@ -1237,6 +1331,7 @@ EXPORT_SYMBOL(security_inode_listsecurity);
 
 void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 
@@ -1246,6 +1341,9 @@ void security_inode_getsecid(struct inode *inode, u32 *secid)
 		hp->hook.inode_getsecid(inode, &secids.secid[hp->lsm_index]);
 
 	*secid = lsm_secids_to_token(&secids);
+#else
+	call_void_hook(inode_getsecid, inode, secid);
+#endif
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
@@ -1437,6 +1535,7 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -1444,11 +1543,20 @@ int security_kernel_act_as(struct cred *new, u32 secid)
 	lsm_token_to_secids(secid, &secids);
 
 	list_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		/*
+		 * Not all of the security modules may have gotten
+		 * a secid when this token was created, so ignore 0.
+		 */
+		if (secids.secid[hp->lsm_index] == 0)
+			continue;
 		rc = hp->hook.kernel_act_as(new, secids.secid[hp->lsm_index]);
 		if (rc)
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(kernel_act_as, 0, new, secid);
+#endif
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
@@ -1507,6 +1615,7 @@ int security_task_getsid(struct task_struct *p)
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 
@@ -1516,6 +1625,10 @@ void security_task_getsecid(struct task_struct *p, u32 *secid)
 		hp->hook.task_getsecid(p, &secids.secid[hp->lsm_index]);
 
 	*secid = lsm_secids_to_token(&secids);
+#else
+	*secid = 0;
+	call_void_hook(task_getsecid, p, secid);
+#endif
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
@@ -1564,6 +1677,7 @@ int security_task_movememory(struct task_struct *p)
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -1577,7 +1691,61 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(task_kill, 0, p, info, sig, secid);
+#endif
+}
+
+#ifdef CONFIG_SECURITY_STACKING
+static char *nolsm = "-default";
+#define NOLSMLEN	9
+
+static int lsm_task_prctl(int option, unsigned long arg2, unsigned long arg3,
+				unsigned long arg4, unsigned long arg5)
+{
+	char *lsm = lsm_of_task(current);
+	char buffer[SECURITY_NAME_MAX + 1];
+	__user char *optval = (__user char *)arg2;
+	__user int *optlen = (__user int *)arg3;
+	int dlen;
+	int len;
+
+	switch (option) {
+	case PR_GET_DISPLAY_LSM:
+		len = arg4;
+		if (lsm[0] == '\0') {
+			lsm = nolsm;
+			dlen = NOLSMLEN;
+		} else
+			dlen = strlen(lsm) + 1;
+		if (dlen > len)
+			return -ERANGE;
+		if (copy_to_user(optval, lsm, dlen))
+			return -EFAULT;
+		if (put_user(dlen, optlen))
+			return -EFAULT;
+		break;
+	case PR_SET_DISPLAY_LSM:
+		len = arg3;
+		if (len > SECURITY_NAME_MAX)
+			return -EINVAL;
+		if (copy_from_user(buffer, optval, len))
+			return -EFAULT;
+		buffer[len] = '\0';
+		/*
+		 * Trust the caller to know what lsm name(s) are available.
+		 */
+		if (!strncmp(buffer, nolsm, NOLSMLEN))
+			lsm[0] = '\0';
+		else
+			strcpy(lsm, buffer);
+		break;
+	default:
+		return -ENOSYS;
+	}
+	return 0;
 }
+#endif
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
@@ -1586,6 +1754,12 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
 
+#ifdef CONFIG_SECURITY_STACKING
+	rc = lsm_task_prctl(option, arg2, arg3, arg4, arg5);
+	if (rc != -ENOSYS)
+		return rc;
+#endif
+
 	list_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
 		if (thisrc != -ENOSYS) {
@@ -1609,6 +1783,7 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 
@@ -1618,6 +1793,10 @@ void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 		hp->hook.ipc_getsecid(ipcp, &secids.secid[hp->lsm_index]);
 
 	*secid = lsm_secids_to_token(&secids);
+#else
+	*secid = 0;
+	call_void_hook(ipc_getsecid, ipcp, secid);
+#endif
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
@@ -1754,6 +1933,9 @@ EXPORT_SYMBOL(security_d_instantiate);
 int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	char *speclsm = lsm_of_task(p);
+#endif
 	struct security_hook_list *hp;
 	char *vp;
 	char *cp = NULL;
@@ -1801,6 +1983,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	list_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsm))
 			continue;
+#ifdef CONFIG_SECURITY_STACKING
+		if (!lsm && speclsm && speclsm[0] && strcmp(speclsm, hp->lsm))
+			continue;
+#endif
 		rc = hp->hook.getprocattr(p, name, value);
 		if (rc != -ENOENT)
 			return rc;
@@ -1811,12 +1997,17 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	char *speclsm = lsm_of_task(current);
+	struct lsm_value *lsm_value = NULL;
+	int count;
+#else
+	char *tvalue;
+#endif
 	struct security_hook_list *hp;
 	int rc;
-	char *local;
+	char *temp;
 	char *cp;
-	int slen;
-	int failed = 0;
 
 	/*
 	 * If lsm is NULL look at all the modules to find one
@@ -1826,71 +2017,81 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	 * "context" is handled directly here.
 	 */
 	if (strcmp(name, "context") == 0) {
-		/*
-		 * First verify that the input is acceptable.
-		 * lsm1='v1'lsm2='v2'lsm3='v3'
-		 *
-		 * A note on the use of strncmp() below.
-		 * The check is for the substring at the beginning of cp.
-		 * The kzalloc of size + 1 ensures a terminated string.
-		 */
 		rc = -EINVAL;
-		local = kzalloc(size + 1, GFP_KERNEL);
-		memcpy(local, value, size);
-		cp = local;
-		list_for_each_entry(hp, &security_hook_heads.setprocattr,
-					list) {
-			if (lsm != NULL && strcmp(lsm, hp->lsm))
-				continue;
-			if (cp[0] == ',') {
-				if (cp == local)
-					goto free_out;
-				cp++;
-			}
-			slen = strlen(hp->lsm);
-			if (strncmp(cp, hp->lsm, slen))
-				goto free_out;
-			cp += slen;
-			if (cp[0] != '=' || cp[1] != '\'' || cp[2] == '\'')
-				goto free_out;
-			for (cp += 2; cp[0] != '\''; cp++)
-				if (cp[0] == '\0')
-					goto free_out;
-			cp++;
+		temp = kmemdup(value, size + 1, GFP_KERNEL);
+		if (!temp)
+			return -ENOMEM;
+
+		temp[size] = '\0';
+		cp = strrchr(temp, '\'');
+		if (!cp)
+			goto free_out;
+
+		cp[1] = '\0';
+#ifdef CONFIG_SECURITY_STACKING
+		lsm_value = kzalloc(sizeof(*lsm_value) * LSM_MAX_MAJOR,
+					GFP_KERNEL);
+		if (!lsm_value) {
+			rc = -ENOMEM;
+			goto free_out;
 		}
 
-		cp = local;
+		count = lsm_parse_context(temp, lsm_value);
+		if (count <= 0)
+			goto free_out;
+
+		for (count--; count >= 0; count--) {
+			list_for_each_entry(hp,
+				&security_hook_heads.setprocattr, list) {
+
+				if (lsm && strcmp(lsm, hp->lsm))
+					continue;
+				if (!strcmp(hp->lsm, lsm_value[count].lsm)) {
+					rc = hp->hook.setprocattr("context",
+						lsm_value[count].data,
+						strlen(lsm_value[count].data));
+					break;
+				}
+			}
+			if (rc < 0 || (lsm && rc >0))
+				break;
+		}
+#else /* CONFIG_SECURITY_STACKING */
+		cp = strstr(temp, "='");
+		if (!cp)
+			goto free_out;
+		*cp = '\0';
+		tvalue = strchr(cp + 2, '\'');
+		if (!tvalue)
+			goto free_out;
 		list_for_each_entry(hp, &security_hook_heads.setprocattr,
-					list) {
-			if (lsm != NULL && strcmp(lsm, hp->lsm))
-				continue;
-			if (cp[0] == ',')
-				cp++;
-			cp += strlen(hp->lsm) + 2;
-			for (slen = 0; cp[slen] != '\''; slen++)
-				;
-			cp[slen] = '\0';
-
-			rc = hp->hook.setprocattr("context", cp, slen);
-			if (rc < 0)
-				failed = rc;
-			cp += slen + 1;
+								list) {
+			if (lsm == NULL || !strcmp(lsm, hp->lsm)) {
+				rc = hp->hook.setprocattr(name, tvalue, size);
+				break;
+			}
 		}
-		if (failed != 0)
-			rc = failed;
-		else
-			rc = size;
+#endif /* CONFIG_SECURITY_STACKING */
 free_out:
-		kfree(local);
+		kfree(temp);
+#ifdef CONFIG_SECURITY_STACKING
+		kfree(lsm_value);
+#endif
+		if (rc >= 0)
+			return size;
 		return rc;
 	}
 
 	list_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm && strcmp(lsm, hp->lsm))
 			continue;
+#ifdef CONFIG_SECURITY_STACKING
+		if (!lsm && speclsm && speclsm[0] && strcmp(speclsm, hp->lsm))
+			continue;
+#endif
 		rc = hp->hook.setprocattr(name, value, size);
 		if (rc != -ENOENT)
-			return rc;
+		return rc;
 	}
 	return -EINVAL;
 }
@@ -1908,48 +2109,71 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	char *speclsm = lsm_of_task(current);
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = -EOPNOTSUPP;
 
 	lsm_token_to_secids(secid, &secids);
 
-	/*
-	 * CBS - Return the first result regardless.
-	 */
 	list_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
+		if (speclsm && speclsm[0] && strcmp(hp->lsm, speclsm))
+			continue;
 		rc = hp->hook.secid_to_secctx(secids.secid[hp->lsm_index],
 						secdata, seclen);
-		if (rc != -EOPNOTSUPP)
-			break;
+		return rc;
 	}
-	return rc;
+	return -EOPNOTSUPP;
+#else
+	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, secid, secdata,
+				seclen);
+#endif
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	struct security_hook_list *hp;
+#ifdef CONFIG_SECURITY_STACKING
+	char *speclsm = lsm_of_task(current);
 	struct lsm_secids secids;
+	struct security_hook_list *hp;
 	int rc = 0;
 
 	lsm_secids_init(&secids);
 
 	list_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (speclsm && speclsm[0] && strcmp(hp->lsm, speclsm))
+			continue;
 		rc = hp->hook.secctx_to_secid(secdata, seclen,
 						&secids.secid[hp->lsm_index]);
-		if (rc)
-			break;
+		break;
 	}
 
 	*secid = lsm_secids_to_token(&secids);
 	return rc;
+#else
+	*secid = 0;
+	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+#ifdef CONFIG_SECURITY_STACKING
+	char *speclsm = lsm_of_task(current);
+#endif
+	struct security_hook_list *hp;
+
+	list_for_each_entry(hp, &security_hook_heads.release_secctx, list) {
+#ifdef CONFIG_SECURITY_STACKING
+		if (speclsm[0] && strcmp(hp->lsm, speclsm))
+			continue;
+#endif
+		hp->hook.release_secctx(secdata, seclen);
+		break;
+	}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -1961,19 +2185,173 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_value *lsm_value;
+	char *temp;
+	int count;
+	int rc = 0;
+
+	if (!ctx || !ctxlen)
+		return -EACCES;
+
+	lsm_value = kzalloc(sizeof(*lsm_value) * LSM_MAX_MAJOR, GFP_KERNEL);
+	if (!lsm_value)
+		return -ENOMEM;
+
+	temp = kmemdup(ctx, ctxlen + 1, GFP_KERNEL);
+	if (!temp) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+	temp[ctxlen] = '\0';
+
+	count = lsm_parse_context(temp, lsm_value);
+	if (count <= 0) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+
+	for (count--; count >= 0; count--) {
+		list_for_each_entry(hp, &security_hook_heads.inode_notifysecctx,
+									list) {
+			if (!strcmp(hp->lsm, lsm_value[count].lsm)) {
+				rc = hp->hook.inode_notifysecctx(inode,
+						lsm_value[count].data,
+						strlen(lsm_value[count].data));
+				break;
+			}
+		}
+		if (rc)
+			break;
+	}
+
+free_out:
+	kfree(lsm_value);
+	kfree(temp);
+	return rc;
+#else
 	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
+/**
+ * security_inode_setsecctx - set the LSM security attribute(s) on an inode
+ * @dentry: the directory entry containing the inode
+ * @ctx: the security attributes, in text form
+ * @ctxlen: the length of the attributes
+ *
+ * This should only be called by filesystems for the purpose
+ * of setting attributes in an LSM agnositic way. The @ctx
+ * value should never be externally supplied.
+ *
+ * Returns 0 on success and LSM defined errors.
+ */
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	struct lsm_value *lsm_value;
+	char *temp;
+	int count;
+	int rc = 0;
+
+	lsm_value = kzalloc(sizeof(*lsm_value) * LSM_MAX_MAJOR, GFP_KERNEL);
+	if (!lsm_value)
+		return -ENOMEM;
+
+	temp = kmemdup(ctx, ctxlen + 1, GFP_KERNEL);
+	if (!temp) {
+		rc = -ENOMEM;
+		goto free_out;
+	}
+	temp[ctxlen] = '\0';
+
+	count = lsm_parse_context(temp, lsm_value);
+	if (count <= 0) {
+		rc = -EINVAL;
+		goto free_out;
+	}
+
+	for (count--; count >= 0; count--) {
+		list_for_each_entry(hp, &security_hook_heads.inode_setsecctx,
+									list) {
+			if (!strcmp(hp->lsm, lsm_value[count].lsm)) {
+				rc = hp->hook.inode_setsecctx(dentry,
+						lsm_value[count].data,
+						strlen(lsm_value[count].data));
+				break;
+			}
+		}
+		if (rc)
+			break;
+	}
+
+free_out:
+	kfree(lsm_value);
+	kfree(temp);
+	return rc;
+#else
 	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
+/**
+ * security_inode_getsecctx - get the LSM security attribute(s) of an inode
+ * @inode: the inode
+ * @ctx: the fetched security attributes, in text form
+ * @ctxlen: the length of the fetched attributes
+ *
+ * This should only be called by filesystems for the purpose
+ * of getting attributes in an LSM agnositic way. The @ctx
+ * value should never be externally exposed.
+ *
+ * Returns 0 on success and LSM defined errors.
+ */
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char *value = NULL;
+	void *vp;
+	char *cp;
+	u32 tlen;
+	int trc;
+	int rc = -EOPNOTSUPP;
+
+	list_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		trc = hp->hook.inode_getsecctx(inode, &vp, &tlen);
+		if (trc < 0) {
+			kfree(value);
+			return trc;
+		}
+		rc = trc;
+		if (value == NULL) {
+			value = kasprintf(GFP_KERNEL, "%s='%s'", hp->lsm,
+						(char *)vp);
+			kfree(vp);
+			if (value == NULL)
+				return -ENOMEM;
+		} else {
+			cp = kasprintf(GFP_KERNEL, "%s,%s='%s'", value,
+					hp->lsm, (char *)vp);
+			kfree(vp);
+			kfree(value);
+			if (cp == NULL)
+				return -ENOMEM;
+			value = cp;
+		}
+	}
+	if (!rc) {
+		*ctxlen = strlen(value);
+		*ctx = value;
+	}
+	return rc;
+#else
 	return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ctxlen);
+#endif
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -2068,30 +2446,61 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct security_hook_list *hp;
+	char *lsm = lsm_of_task(current);
+
+	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+									list) {
+		if (!lsm || !lsm[0] || !strcmp(lsm, hp->lsm))
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+						optlen, len);
+	}
+	return -ENOPROTOOPT;
+#else
 	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
 				optval, optlen, len);
+#endif
 }
 
+/**
+ * security_socket_getpeersec_dgram - get peer secids for datagrams
+ * @sock: the socket
+ * @skb: packet data
+ * @secid: the result goes here
+ *
+ * The return is based on the task display module, but gather
+ * all the results to get a full token.
+ *
+ * Returns 0 on success, -ENOPROTOOPT if no modules, module error otherwise
+ */
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
 				     u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
+	char *lsm = lsm_of_task(current);
 	int rc = -ENOPROTOOPT;
+	int trc;
 
 	lsm_secids_init(&secids);
 
 	list_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
 									list) {
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+		trc = hp->hook.socket_getpeersec_dgram(sock, skb,
 						&secids.secid[hp->lsm_index]);
-		if (rc)
-			break;
+		if (!lsm || !lsm[0] || !strcmp(lsm, hp->lsm))
+			rc = trc;
 	}
 
 	if (!rc)
 		*secid = lsm_secids_to_token(&secids);
 	return rc;
+#else
+	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
+			     skb, secid);
+#endif
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
@@ -2119,6 +2528,7 @@ EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 
@@ -2128,12 +2538,16 @@ void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 		hp->hook.sk_getsecid(sk, &secids.secid[hp->lsm_index]);
 
 	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
+	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
+#endif
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
 void security_req_classify_flow(const struct request_sock *req,
 				struct flowi *fl)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 
@@ -2143,6 +2557,9 @@ void security_req_classify_flow(const struct request_sock *req,
 		hp->hook.req_classify_flow(req, &secids.secid[hp->lsm_index]);
 
 	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
+	call_void_hook(req_classify_flow, req, &fl->flowi_secid);
+#endif
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
@@ -2173,6 +2590,7 @@ void security_inet_conn_established(struct sock *sk,
 
 int security_secmark_relabel_packet(u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2187,6 +2605,9 @@ int security_secmark_relabel_packet(u32 secid)
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(secmark_relabel_packet, 0, secid);
+#endif
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
@@ -2304,6 +2725,7 @@ EXPORT_SYMBOL(security_xfrm_state_alloc);
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2318,6 +2740,9 @@ int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
+#endif
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
@@ -2333,6 +2758,7 @@ void security_xfrm_state_free(struct xfrm_state *x)
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2346,6 +2772,9 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
+#endif
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
@@ -2353,8 +2782,10 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       const struct flowi *fl)
 {
 	struct security_hook_list *hp;
-	struct lsm_secids secids;
 	int rc = 1;
+#ifdef CONFIG_SECURITY_STACKING
+	struct lsm_secids secids;
+#endif
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -2365,12 +2796,18 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
+#ifdef CONFIG_SECURITY_STACKING
 	lsm_token_to_secids(fl->flowi_secid, &secids);
+#endif
 
 	list_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
 									list) {
+#ifdef CONFIG_SECURITY_STACKING
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp,
 				secids.secid[hp->lsm_index]);
+#else
+		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl->flowi_secid);
+#endif
 		break;
 	}
 	return rc;
@@ -2378,6 +2815,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2394,10 +2832,14 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 	if (!rc)
 		*secid = lsm_secids_to_token(&secids);
 	return rc;
+#else
+	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
+#endif
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2413,6 +2855,11 @@ void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 	}
 	BUG_ON(rc);
 	fl->flowi_secid = lsm_secids_to_token(&secids);
+#else
+	int rc = call_int_hook(xfrm_decode_session, 0, skb, &fl->flowi_secid,
+				0);
+	BUG_ON(rc);
+#endif
 }
 EXPORT_SYMBOL(security_skb_classify_flow);
 
@@ -2471,6 +2918,7 @@ void security_audit_rule_free(void *lsmrule)
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
+#ifdef CONFIG_SECURITY_STACKING
 	struct security_hook_list *hp;
 	struct lsm_secids secids;
 	int rc = 0;
@@ -2484,5 +2932,9 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			break;
 	}
 	return rc;
+#else
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
+				actx);
+#endif
 }
 #endif /* CONFIG_AUDIT */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1cb90a7ac0cb..a93450cf9c8b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -101,7 +101,7 @@
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
 /* Index into lsm_secids */
-static int selinux_secids_index;
+int selinux_secids_index;
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing;
@@ -411,6 +411,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
+
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
@@ -4613,11 +4614,6 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
 
-static u32 selinux_secmark_to_secid(u32 token)
-{
-	return lsm_token_to_module_secid(token, selinux_secids_index);
-}
-
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
@@ -4638,7 +4634,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 
 	if (selinux_secmark_enabled()) {
 		err = avc_has_perm(sk_sid,
-				   selinux_secmark_to_secid(skb->secmark),
+				   selinux_token_to_secid(skb->secmark),
 				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -4714,7 +4710,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	if (secmark_active) {
 		err = avc_has_perm(sk_sid,
-				   selinux_secmark_to_secid(skb->secmark),
+				   selinux_token_to_secid(skb->secmark),
 				   SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
@@ -4783,7 +4779,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 out:
 	*secid = peer_secid;
-	if (peer_secid == SECSID_NULL)
+	if (*secid == SECSID_NULL)
 		return -EINVAL;
 	return 0;
 }
@@ -4857,8 +4853,8 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	err = selinux_conn_sid(sksec->sid, peersid, &connsid);
 	if (err)
 		return err;
-	req->secid = connsid;
-	req->peer_secid = peersid;
+	req->secid = selinux_token_from_secid(req->secid, connsid);
+	req->peer_secid = selinux_token_from_secid(req->peer_secid, peersid);
 
 	return selinux_netlbl_inet_conn_request(req, family);
 }
@@ -4868,8 +4864,10 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 {
 	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
-	newsksec->sid = req->secid;
-	newsksec->peer_sid = req->peer_secid;
+
+	newsksec->sid = selinux_token_to_secid(req->secid);
+	newsksec->peer_sid = selinux_token_to_secid(req->peer_secid);
+
 	/* NOTE: Ideally, we should also get the isec->sid for the
 	   new socket in sync, but we don't have the isec available yet.
 	   So we will wait until sock_graft to do it, by which
@@ -4916,7 +4914,7 @@ static void selinux_secmark_refcount_dec(void)
 static void selinux_req_classify_flow(const struct request_sock *req,
 				      u32 *fl_secid)
 {
-	*fl_secid = req->secid;
+	*fl_secid = selinux_token_to_secid(req->secid);
 }
 
 static int selinux_tun_dev_alloc_security(void **security)
@@ -5079,7 +5077,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 
 	if (secmark_active)
 		if (avc_has_perm(peer_sid,
-				 selinux_secmark_to_secid(skb->secmark),
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
@@ -5192,7 +5190,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 
 	if (selinux_secmark_enabled())
 		if (avc_has_perm(sksec->sid,
-				 selinux_secmark_to_secid(skb->secmark),
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5316,7 +5314,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 
 	if (secmark_active)
 		if (avc_has_perm(peer_sid,
-				 selinux_secmark_to_secid(skb->secmark),
+				 selinux_token_to_secid(skb->secmark),
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5493,14 +5491,16 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 	/* Can this process write to the queue? */
 	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
-	if (!rc)
+	if (!rc) {
 		/* Can this process send the message */
 		rc = avc_has_perm(sid, msec->sid, SECCLASS_MSG,
 				  MSG__SEND, &ad);
-	if (!rc)
+	}
+	if (!rc) {
 		/* Can the message be put in the queue? */
 		rc = avc_has_perm(msec->sid, isec->sid, SECCLASS_MSGQ,
 				  MSGQ__ENQUEUE, &ad);
+	}
 
 	return rc;
 }
@@ -5523,9 +5523,10 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 
 	rc = avc_has_perm(sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
-	if (!rc)
+	if (!rc) {
 		rc = avc_has_perm(sid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
+	}
 	return rc;
 }
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 306863675614..939db01e86dc 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -231,4 +231,17 @@ static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 #endif
 }
 
+extern int selinux_secids_index;
+
+static inline u32 selinux_token_to_secid(u32 token)
+{
+	return lsm_token_get_secid(token, selinux_secids_index);
+}
+
+static inline u32 selinux_token_from_secid(u32 token, u32 secid)
+{
+	return lsm_token_set_secid(token, secid, selinux_secids_index);
+}
+
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index e91f08c16c0b..88bcf6a111c6 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -160,8 +160,7 @@ int security_member_sid(u32 ssid, u32 tsid,
 int security_change_sid(u32 ssid, u32 tsid,
 	u16 tclass, u32 *out_sid);
 
-int security_sid_to_context(u32 sid, char **scontext,
-	u32 *scontext_len);
+int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len);
 
 int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
 
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 0b0091c04688..fe556c3ca1b3 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -122,7 +122,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 		return NULL;
 
 	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
-	    (secattr->attr.secid == sid))
+	    (selinux_token_to_secid(secattr->attr.secid) == sid))
 		return secattr;
 
 	return NULL;
@@ -291,7 +291,8 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
 		return 0;
 
 	netlbl_secattr_init(&secattr);
-	rc = security_netlbl_sid_to_secattr(req->secid, &secattr);
+	rc = security_netlbl_sid_to_secattr(selinux_token_to_secid(req->secid),
+					    &secattr);
 	if (rc != 0)
 		goto inet_conn_request_return;
 	rc = netlbl_req_setattr(req, &secattr);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4558a23d160e..303460b8f551 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3445,7 +3445,7 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
 	else if (secattr->flags & NETLBL_SECATTR_SECID)
-		*sid = secattr->attr.secid;
+		*sid = selinux_token_to_secid(secattr->attr.secid);
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
 		ctx = sidtab_search(&sidtab, SECINITSID_NETMSG);
@@ -3516,7 +3516,7 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 	if (secattr->domain == NULL)
 		goto out;
 
-	secattr->attr.secid = sid;
+	secattr->attr.secid = selinux_token_from_secid(secattr->attr.secid, sid);
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(ctx, secattr);
 	rc = mls_export_netlbl_cat(ctx, secattr);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index e9fd586e0ec1..7d606e49dea0 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -433,6 +433,16 @@ static inline struct smack_known **smack_key(const struct key *key)
 }
 #endif /* CONFIG_KEYS */
 
+static inline u32 smack_from_token(u32 token)
+{
+	return lsm_token_get_secid(token, smack_secids_index);
+}
+
+static inline u32 smack_to_token(u32 token, u32 secid)
+{
+	return lsm_token_set_secid(token, secid, smack_secids_index);
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1e32fcd99a0d..f7063bf9f014 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1429,7 +1429,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
  * @inode: the object
  * @name: attribute name
  * @buffer: where to put the result
- * @alloc: unused
+ * @alloc: requires a buffer be allocated
  *
  * Returns the size of the attribute or an error code
  */
@@ -1442,43 +1442,39 @@ static int smack_inode_getsecurity(struct inode *inode,
 	struct super_block *sbp;
 	struct inode *ip = (struct inode *)inode;
 	struct smack_known *isp;
-	int ilen;
-	int rc = 0;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
 		isp = smk_of_inode(inode);
-		ilen = strlen(isp->smk_known);
-		*buffer = isp->smk_known;
-		return ilen;
-	}
-
-	/*
-	 * The rest of the Smack xattrs are only on sockets.
-	 */
-	sbp = ip->i_sb;
-	if (sbp->s_magic != SOCKFS_MAGIC)
-		return -EOPNOTSUPP;
+	else {
+		/*
+		 * The rest of the Smack xattrs are only on sockets.
+		 */
+		sbp = ip->i_sb;
+		if (sbp->s_magic != SOCKFS_MAGIC)
+			return -EOPNOTSUPP;
 
-	sock = SOCKET_I(ip);
-	if (sock == NULL || sock->sk == NULL)
-		return -EOPNOTSUPP;
+		sock = SOCKET_I(ip);
+		if (sock == NULL || sock->sk == NULL)
+			return -EOPNOTSUPP;
 
-	ssp = smack_sock(sock->sk);
+		ssp = smack_sock(sock->sk);
 
-	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
-		isp = ssp->smk_in;
-	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0)
-		isp = ssp->smk_out;
-	else
-		return -EOPNOTSUPP;
+		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
+			isp = ssp->smk_in;
+		else if (strcmp(name, XATTR_SMACK_IPOUT) == 0)
+			isp = ssp->smk_out;
+		else
+			return -EOPNOTSUPP;
+	}
 
-	ilen = strlen(isp->smk_known);
-	if (rc == 0) {
+	if (alloc) {
+		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		if (*buffer == NULL)
+			return -ENOMEM;
+	} else
 		*buffer = isp->smk_known;
-		rc = ilen;
-	}
 
-	return rc;
+	return strlen(isp->smk_known);
 }
 
 
@@ -3734,7 +3730,7 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 		/*
 		 * Looks like a fallback, which gives us a secid.
 		 */
-		return smack_from_secid(sap->attr.secid);
+		return smack_from_secid(smack_from_token(sap->attr.secid));
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
@@ -3792,13 +3788,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 }
 #endif /* CONFIG_IPV6 */
 
-#ifdef CONFIG_SECURITY_SMACK_NETFILTER
-static u32 smk_of_secmark(u32 secmark)
-{
-	return lsm_token_to_module_secid(secmark, smack_secids_index);
-}
-#endif
-
 /**
  * smack_socket_sock_rcv_skb - Smack packet delivery access check
  * @sk: socket
@@ -3830,7 +3819,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		 * The secmark is assumed to reflect policy better.
 		 */
 		if (skb && skb->secmark != 0) {
-			skp = smack_from_secid(smk_of_secmark(skb->secmark));
+			skp = smack_from_secid(smack_from_token(skb->secmark));
 			goto access_check;
 		}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -3875,7 +3864,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		if (skb && skb->secmark != 0)
-			skp = smack_from_secid(smk_of_secmark(skb->secmark));
+			skp = smack_from_secid(smack_from_token(skb->secmark));
 		else
 			skp = smack_ipv6host_label(&sadd);
 		if (skp == NULL)
@@ -3973,7 +3962,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET:
 #ifdef CONFIG_SECURITY_SMACK_NETFILTER
-		s = smk_of_secmark(skb->secmark);
+		s = smack_from_token(skb->secmark);
 		if (s != 0)
 			break;
 #endif
@@ -3992,7 +3981,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	case PF_INET6:
 #ifdef SMACK_IPV6_SECMARK_LABELING
-		s = smk_of_secmark(skb->secmark);
+		s = smack_from_token(skb->secmark);
 #endif
 		break;
 	}
@@ -4071,7 +4060,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * The secmark is assumed to reflect policy better.
 	 */
 	if (skb && skb->secmark != 0) {
-		skp = smack_from_secid(smk_of_secmark(skb->secmark));
+		skp = smack_from_secid(smack_from_token(skb->secmark));
 		goto access_check;
 	}
 #endif /* CONFIG_SECURITY_SMACK_NETFILTER */
@@ -4107,7 +4096,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	 * Save the peer's label in the request_sock so we can later setup
 	 * smk_packet in the child socket so that SO_PEERCRED can report it.
 	 */
-	req->peer_secid = skp->smk_secid;
+	req->peer_secid = smack_to_token(0, skp->smk_secid);
 
 	/*
 	 * We need to decide if we want to label the incoming connection here
@@ -4142,7 +4131,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
-		skp = smack_from_secid(req->peer_secid);
+		skp = smack_from_secid(smack_from_token(req->peer_secid));
 		ssp->smk_packet = skp;
 	} else
 		ssp->smk_packet = NULL;
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 510661ba6c16..ee5c32c62643 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -23,19 +23,6 @@
 
 #if IS_ENABLED(CONFIG_IPV6)
 
-/*
- * Reinvestigate this soon?
- *
- */
-static u32 smack_to_secmark(u32 secid)
-{
-	struct lsm_secids secids;
-
-	lsm_secids_init(&secids);
-	secids.secid[smack_secids_index] = secid;
-	return lsm_secids_to_token(&secids);
-}
-
 static unsigned int smack_ipv6_output(void *priv,
 					struct sk_buff *skb,
 					const struct nf_hook_state *state)
@@ -47,7 +34,7 @@ static unsigned int smack_ipv6_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = smack_to_secmark(skp->smk_secid);
+		skb->secmark = smack_to_token(skb->secmark, skp->smk_secid);
 	}
 
 	return NF_ACCEPT;
@@ -65,7 +52,7 @@ static unsigned int smack_ipv4_output(void *priv,
 	if (sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
-		skb->secmark = smack_to_secmark(skp->smk_secid);
+		skb->secmark = smack_to_token(skb->secmark, skp->smk_secid);
 	}
 
 	return NF_ACCEPT;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 9d2dde608298..a4274f1e1e9b 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1284,7 +1284,8 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	if (rc == 0 && skp != NULL)
 		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
 			&snp->smk_host, &snp->smk_mask, PF_INET,
-			snp->smk_label->smk_secid, &audit_info);
+			smack_to_token(0, snp->smk_label->smk_secid),
+			&audit_info);
 
 	if (rc == 0)
 		rc = count;
diff --git a/security/stacking.c b/security/stacking.c
index 65276cd695de..88000d3158b1 100644
--- a/security/stacking.c
+++ b/security/stacking.c
@@ -30,7 +30,9 @@ struct token_entry {
 #define TOKEN_AGE_LIMIT (MAX_INT >> 2)
 #define TOKEN_LIMIT 0x20000000
 #define TOKEN_SET_SIZE 200
+#ifdef CONFIG_SECURITY_LSM_DEBUG
 #define TOKEN_BIT 0x80000000
+#endif
 int token_used;
 u32 token_next;
 struct lsm_secids null_secids;
@@ -41,7 +43,8 @@ static void report_token(const char *msg, const struct token_entry *te)
 {
 	int i;
 
-	pr_info("LSM: %s token=%08x %u,%u,%u,%u,%u,%u,%u,%u\n", msg, te->token,
+	pr_info("LSM: %s token=%08x %u,%u,%u,%u,%u,%u,%u,%u\n",
+		msg, te->token,
 		te->secids.secid[0], te->secids.secid[1], te->secids.secid[2],
 		te->secids.secid[3], te->secids.secid[4], te->secids.secid[5],
 		te->secids.secid[6], te->secids.secid[7]);
@@ -70,7 +73,11 @@ static u32 next_token(void)
 		pr_info("LSM: Security token overflow - safe reset\n");
 		token_next = 0;
 	}
+#ifdef CONFIG_SECURITY_LSM_DEBUG
 	return ++token_next | TOKEN_BIT;
+#else
+	return ++token_next;
+#endif
 }
 
 u32 lsm_secids_to_token(const struct lsm_secids *secids)
@@ -80,18 +87,23 @@ u32 lsm_secids_to_token(const struct lsm_secids *secids)
 	int old;
 
 #ifdef CONFIG_SECURITY_LSM_DEBUG
-	for (i = 0; i < LSM_MAX_MAJOR; i++)
+	for (i = 0; i < LSM_MAX_MAJOR; i++) {
+		WARN_ON_ONCE(secids->secid[i] & TOKEN_BIT);
 		if (secids->secid[i] & TOKEN_BIT)
 			pr_info("LSM: %s secid[%d]=%08x has token bit\n",
 				__func__, i, secids->secid[i]);
+	}
 #endif
-
 	/*
 	 * If none of the secids are set whoever sent this here
 	 * was thinking "0".
 	 */
 	if (!memcmp(secids, &null_secids, sizeof(*secids)))
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+		return TOKEN_BIT;
+#else
 		return 0;
+#endif
 
 	for (i = 0; i < TOKEN_SET_SIZE; i++) {
 		if (token_set[i].token == 0)
@@ -122,19 +134,12 @@ u32 lsm_secids_to_token(const struct lsm_secids *secids)
 void lsm_token_to_secids(const u32 token, struct lsm_secids *secids)
 {
 	int i;
-	struct lsm_secids fudge;
 
-	if (token) {
-		if (!(token & TOKEN_BIT)) {
 #ifdef CONFIG_SECURITY_LSM_DEBUG
-			pr_info("LSM: %s token=%08x has no token bit\n",
-				__func__, token);
+	if ((token & TOKEN_BIT) && token != TOKEN_BIT) {
+#else
+	if (token) {
 #endif
-			for (i = 0; i < LSM_MAX_MAJOR; i++)
-				fudge.secid[i] = token;
-			*secids = fudge;
-			return;
-		}
 		for (i = 0; i < TOKEN_SET_SIZE; i++) {
 			if (token_set[i].token == 0)
 				break;
@@ -145,13 +150,18 @@ void lsm_token_to_secids(const u32 token, struct lsm_secids *secids)
 			}
 		}
 #ifdef CONFIG_SECURITY_LSM_DEBUG
-	pr_info("LSM: %s token=%u was not found\n", __func__, token);
+		pr_info("LSM: %s token=%08x was not found\n", __func__, token);
 #endif
 	}
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	if (token && !(token & TOKEN_BIT))
+		pr_info("LSM: %s token=%08x has no token bit\n",
+			__func__, token);
+#endif
 	*secids = null_secids;
 }
 
-u32 lsm_token_to_module_secid(const u32 token, int lsm)
+u32 lsm_token_get_secid(const u32 token, int lsm)
 {
 	struct lsm_secids secids;
 
@@ -163,3 +173,26 @@ void lsm_secids_init(struct lsm_secids *secids)
 {
 	*secids = null_secids;
 }
+
+u32 lsm_token_set_secid(const u32 token, u32 lsecid, int lsm)
+{
+	struct lsm_secids secids;
+
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	if (!(token & TOKEN_BIT)) {
+		if (token)
+			pr_info("LSM: %s token=%08x has no token bit\n",
+				__func__, token);
+#else
+	if (!token) {
+#endif
+		lsm_secids_init(&secids);
+	} else {
+		lsm_token_to_secids(token, &secids);
+		if (secids.secid[lsm] == lsecid)
+			return token;
+	}
+
+	secids.secid[lsm] = lsecid;
+	return lsm_secids_to_token(&secids);
+}
-- 
2.13.0


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
