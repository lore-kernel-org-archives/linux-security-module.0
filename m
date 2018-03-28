From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 28 Mar 2018 19:27:04 +0900
Subject: [PATCH v2 2/2] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <19f85393f334f87ff097b3112b55a15caa3faf8d.1522185596.git.sargun@sargun.me>
References: <cover.1522185596.git.sargun@sargun.me>
	<19f85393f334f87ff097b3112b55a15caa3faf8d.1522185596.git.sargun@sargun.me>
Message-ID: <201803281927.GIH12442.FMQJVOSFLFtOHO@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> This patch introduces a mechanism to add mutable hooks and immutable
> hooks to the callback chain. It adds an intermediary item to the
> chain which separates mutable and immutable hooks. Immutable hooks
> are then marked as read-only, as well as the hook heads. This does
> not preclude some hooks being able to be mutated (removed).
> 
> It also wraps the hook unloading, and execution with an SRCU. One
> SRCU is used across all hooks, as the SRCU struct can be memory
> intensive, and hook execution time in general should be relatively
> short.

Please fold below change into patch 1/2, for patch 1/2 is causing build warning.

  CC      security/security.o
security/security.c: In function ?security_init?:
security/security.c:64:21: note: randstruct: casting between randomized structure pointer types (op0): ?struct hlist_head? and ?struct security_hook_heads?

  struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
                     ^~~~

----------------------------------------
 randomize_layout_plugin.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index c4a345c..6d5bbd3 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -52,8 +52,8 @@ struct whitelist_entry {
 	{ "net/unix/af_unix.c", "unix_skb_parms", "char" },
 	/* big_key payload.data struct splashing */
 	{ "security/keys/big_key.c", "path", "void *" },
-	/* walk struct security_hook_heads as an array of struct list_head */
-	{ "security/security.c", "list_head", "security_hook_heads" },
+	/* walk struct security_hook_heads as an array of struct hlist_head */
+	{ "security/security.c", "hlist_head", "security_hook_heads" },
 	{ }
 };
 
----------------------------------------

You can fold below change into patch 2/2.

init_srcu_struct() is not needed for initializing statically allocated
security_hook_srcu lock.

kmalloc(GFP_KERNEL) from __init functions in vmlinux cannot fail, for panic()
will be called from out_of_memory() if out of memory.

----------------------------------------
 security.c |  192 +++++++++++--------------------------------------------------
 1 file changed, 37 insertions(+), 155 deletions(-)

diff --git a/security/security.c b/security/security.c
index c5e770e..f5989eb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -62,7 +62,10 @@ static void __init do_security_initcalls(void)
 }
 
 #ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-static struct srcu_struct security_hook_srcu;
+DEFINE_STATIC_SRCU(security_hook_srcu);
+#define lock_lsm() srcu_read_lock(&security_hook_srcu)
+#define unlock_lsm(idx) srcu_read_unlock(&security_hook_srcu, (idx))
+static struct security_hook_list null_hooks[SECURITY_HOOK_COUNT];
 
 static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
 {
@@ -94,9 +97,7 @@ static void __init add_mutable_hooks(void)
 	int i;
 
 	for (i = 0; i < SECURITY_HOOK_COUNT; i++) {
-		shl = kzalloc(sizeof(*shl), GFP_KERNEL);
-		if (!shl)
-			panic("Unable to allocate memory for mutable hooks\n");
+		shl = &null_hooks[i];
 		shl->head = &list[i];
 		hlist_add_head_rcu(&shl->list, shl->head);
 	}
@@ -104,11 +105,6 @@ static void __init add_mutable_hooks(void)
 
 static void __init setup_mutable_hooks(void)
 {
-	int ret;
-
-	ret = init_srcu_struct(&security_hook_srcu);
-	if (ret)
-		panic("Could not initialize srcu: %d\n", ret);
 	add_mutable_hooks();
 }
 
@@ -126,6 +122,8 @@ void security_delete_hooks(struct security_hook_list *hooks, int count)
 EXPORT_SYMBOL_GPL(security_delete_hooks);
 
 #else
+#define lock_lsm() 0
+#define unlock_lsm(idx) do { } while (0)
 static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
 {
 	WARN_ONCE(is_mutable,
@@ -143,11 +141,6 @@ static void __init setup_mutable_hooks(void) {}
  */
 int __init security_init(void)
 {
-	int i;
-	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
-
-	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
-		INIT_HLIST_HEAD(&list[i]);
 	pr_info("Security Framework initialized\n");
 
 	setup_mutable_hooks();
@@ -285,23 +278,22 @@ int unregister_lsm_notifier(struct notifier_block *nb)
  *	This is a hook that returns a value.
  */
 
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
 #define call_void_hook(FUNC, ...)					\
 	do {								\
 		struct security_hook_list *P;				\
 		int srcu_idx;						\
 									\
-		srcu_idx = srcu_read_lock(&security_hook_srcu);		\
+		srcu_idx = lock_lsm();					\
 		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
 			if (P->hook.FUNC)				\
 				P->hook.FUNC(__VA_ARGS__);		\
-		srcu_read_unlock(&security_hook_srcu, srcu_idx);	\
+		unlock_lsm(srcu_idx);					\
 	} while (0)
 
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int srcu_idx, RC = IRC;					\
 								\
-	srcu_idx = srcu_read_lock(&security_hook_srcu);		\
+	srcu_idx = lock_lsm();					\
 	do {							\
 		struct security_hook_list *P;			\
 								\
@@ -313,32 +305,9 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 			}					\
 		}						\
 	} while (0);						\
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);	\
-	RC;							\
-})
-#else
-#define call_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
-			P->hook.FUNC(__VA_ARGS__);		\
-	} while (0)
-
-#define call_int_hook(FUNC, IRC, ...) ({			\
-	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			if (RC != 0)				\
-				break;				\
-		}						\
-	} while (0);						\
+	unlock_lsm(srcu_idx);					\
 	RC;							\
 })
-#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 /* Security operations */
 
@@ -425,11 +394,12 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
 	return call_int_hook(settime, 0, ts, tz);
 }
 
-static int __security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
+int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	struct security_hook_list *hp;
 	int cap_sys_admin = 1;
 	int rc;
+	int srcu_idx;
 
 	/*
 	 * The module will respond with a positive value if
@@ -438,6 +408,7 @@ static int __security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
 		if (!hp->hook.vm_enough_memory)
 			continue;
@@ -447,27 +418,10 @@ static int __security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 			break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
-{
-	int srcu_idx, ret;
-
-	srcu_idx = srcu_read_lock(&security_hook_srcu);
-	ret = __security_vm_enough_memory_mm(mm, pages);
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);
-
-	return ret;
-}
-#else
-int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
-{
-	return __security_vm_enough_memory_mm(mm, pages);
-}
-#endif
-
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
 	return call_int_hook(bprm_set_creds, 0, bprm);
@@ -936,91 +890,56 @@ int security_inode_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_killpriv, 0, dentry);
 }
 
-static int __security_inode_getsecurity(struct inode *inode, const char *name,
+int security_inode_getsecurity(struct inode *inode, const char *name,
 					void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
 		if (!hp->hook.inode_getsecurity)
 			continue;
 		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-
-	return -EOPNOTSUPP;
+	unlock_lsm(srcu_idx);
+	return rc;
 }
 
-static int __security_inode_setsecurity(struct inode *inode, const char *name,
+int security_inode_setsecurity(struct inode *inode, const char *name,
 					const void *value, size_t size,
 					int flags)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int rc = -EOPNOTSUPP;
+	int srcu_idx;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
 	/*
 	 * Only one module will provide an attribute with a given name.
 	 */
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
 		if (!hp->hook.inode_setsecurity)
 			continue;
 		rc = hp->hook.inode_setsecurity(inode, name, value, size,
 						flags);
 		if (rc != -EOPNOTSUPP)
-			return rc;
+			break;
 	}
-
-	return -EOPNOTSUPP;
-}
-
-
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-int security_inode_getsecurity(struct inode *inode, const char *name,
-				void **buffer, bool alloc)
-{
-	int srcu_idx, ret;
-
-	srcu_idx = srcu_read_lock(&security_hook_srcu);
-	ret = __security_inode_getsecurity(inode, name, buffer, alloc);
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);
-
-	return ret;
-
-}
-
-int security_inode_setsecurity(struct inode *inode, const char *name,
-				const void *value, size_t size, int flags)
-{
-	int srcu_idx, ret;
-
-	srcu_idx = srcu_read_lock(&security_hook_srcu);
-	ret = __security_inode_setsecurity(inode, name, value, size, flags);
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);
-
-	return ret;
-}
-#else
-int security_inode_getsecurity(struct inode *inode, const char *name,
-				void **buffer, bool alloc)
-{
-	return __security_inode_getsecurity(inode, name, buffer, alloc);
+	unlock_lsm(srcu_idx);
+	return rc;
 }
 
-int security_inode_setsecurity(struct inode *inode, const char *name,
-				const void *value, size_t size, int flags)
-{
-	return __security_inode_setsecurity(inode, name, value, size, flags);
-}
-#endif
 
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
@@ -1310,14 +1229,16 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
 	return call_int_hook(task_kill, 0, p, info, sig, secid);
 }
 
-static int __security_task_prctl(int option, unsigned long arg2,
+int security_task_prctl(int option, unsigned long arg2,
 				 unsigned long arg3, unsigned long arg4,
 				 unsigned long arg5)
 {
 	int thisrc;
 	int rc = -ENOSYS;
 	struct security_hook_list *hp;
+	int srcu_idx;
 
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
 		if (!hp->hook.task_prctl)
 			continue;
@@ -1328,29 +1249,10 @@ static int __security_task_prctl(int option, unsigned long arg2,
 				break;
 		}
 	}
+	unlock_lsm(srcu_idx);
 	return rc;
 }
 
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
-{
-	int srcu_idx, ret;
-
-	srcu_idx = srcu_read_lock(&security_hook_srcu);
-	ret = __security_task_prctl(option, arg2, arg3, arg4, arg5);
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);
-
-	return ret;
-}
-#else
-int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			 unsigned long arg4, unsigned long arg5)
-{
-	return __security_task_prctl(option, arg2, arg3, arg4, arg5);
-}
-#endif
-
 void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
 	call_void_hook(task_to_inode, p, inode);
@@ -1827,12 +1729,13 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
 }
 
-static int __security_xfrm_state_pol_flow_match(struct xfrm_state *x,
+int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 						struct xfrm_policy *xp,
 						const struct flowi *fl)
 {
 	struct security_hook_list *hp;
 	int rc = 1;
+	int srcu_idx;
 
 	/*
 	 * Since this function is expected to return 0 or 1, the judgment
@@ -1843,6 +1746,7 @@ static int __security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	 * For speed optimization, we explicitly break the loop rather than
 	 * using the macro
 	 */
+	srcu_idx = lock_lsm();
 	hlist_for_each_entry(hp,
 				&security_hook_heads.xfrm_state_pol_flow_match,
 				list) {
@@ -1851,32 +1755,10 @@ static int __security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
 		break;
 	}
-
+	unlock_lsm(srcu_idx);
 	return rc;
 }
 
-#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
-int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
-				       struct xfrm_policy *xp,
-				       const struct flowi *fl)
-{
-	int srcu_idx, ret;
-
-	srcu_idx = srcu_read_lock(&security_hook_srcu);
-	ret = __security_xfrm_state_pol_flow_match(x, xp, fl);
-	srcu_read_unlock(&security_hook_srcu, srcu_idx);
-
-	return ret;
-}
-#else
-int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
-				       struct xfrm_policy *xp,
-				       const struct flowi *fl)
-{
-	return __security_xfrm_state_pol_flow_match(x, xp, fl);
-}
-#endif
-
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
 	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
----------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
