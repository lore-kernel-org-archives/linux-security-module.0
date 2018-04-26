From: penguin-kernel@i-love.sakura.ne.jp (Tetsuo Handa)
Date: Thu, 26 Apr 2018 16:15:24 +0900
Subject: [PATCH v7 0/6] Safe LSM (un)loading, and immutable hooks
In-Reply-To: <cover.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
Message-ID: <201804260715.w3Q7FOlb036047@www262.sakura.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Suggested changes on top of your series.

But I think that your series still lacks critical code which is also not yet
implemented in Casey's work. The reason call_int_hook() can work for hooks
which change state (e.g. security_inode_alloc()) is that there is no need to
call undo function because a hook which might change state (so-called Major LSM
modules) is always the last entry of the list. If we allow runtime registration
of LSM modules, there is a possibility that call_int_hook() returns an error
after some LSM module allocated memory. You need to implement safe transaction
in order to allow FOR_EACH_SECURITY_HOOK_RW hooks to return an error.

---
 include/linux/lsm_hooks.h |  4 +--
 security/security.c       | 86 +++++++++++++----------------------------------
 security/security.h       |  5 ---
 3 files changed, 25 insertions(+), 70 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c227bb..98809d6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2010,7 +2010,7 @@ struct lsm_info {
 	const char			*name;
 	const unsigned int		count;
 	struct security_hook_list	*hooks;
-	struct module			*owner;
+	const struct module		*owner;
 } __randomize_layout;
 
 struct security_hook_list {
@@ -2044,7 +2044,7 @@ struct security_hook_list {
 	}
 
 extern int __must_check security_add_hooks(struct lsm_info *lsm,
-						bool is_mutable);
+					   bool is_writable);
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 void __security_delete_hooks(struct lsm_info *lsm);
diff --git a/security/security.c b/security/security.c
index 3606512..a4bc9cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -48,18 +48,15 @@
 
 /*
  * security_allow_unregister_hooks blocks the delete_module syscall for
- * hooks that are loaded into the  set of mutable hooks by getting a reference
+ * hooks that are loaded into the set of writable hooks by getting a reference
  * on those modules. This allows built-in modules to still delete their security
  * hooks, so SELinux will still be able to deregister.
  *
  * If an arbitrary module tries to deregister, it will get a return code
  * indicating failure.
- *
- * When this value turns true -> false -- Once, lock_existing_hooks will be
- * called.
  */
-static atomic_t security_allow_unregister_hooks =
-	ATOMIC_INIT(IS_ENABLED(CONFIG_SECURITY_UNREGISTRABLE_HOOKS) ? 1 : 0);
+static bool security_allow_unregister_hooks =
+	IS_ENABLED(CONFIG_SECURITY_UNREGISTRABLE_HOOKS) ? 1 : 0;
 
 #define FOR_EACH_SECURITY_HOOK_RO(ITERATOR, HEAD) \
 	hlist_for_each_entry_rcu(ITERATOR, &security_hook_heads_ro.HEAD, list)
@@ -90,18 +87,18 @@ void __security_delete_hooks(struct lsm_info *info)
 #define FOR_EACH_SECURITY_HOOK_RW(ITERATOR, HEAD) \
 	hlist_for_each_entry_rcu(ITERATOR, &security_hook_heads_rw.HEAD, list)
 
-struct security_hook_heads *get_security_hook_heads(bool is_mutable)
+static struct security_hook_heads *get_security_hook_heads(bool is_writable)
 {
-	if (is_mutable)
+	if (is_writable)
 		return &security_hook_heads_rw;
 	return &security_hook_heads_ro;
 }
 #else
 #define FOR_EACH_SECURITY_HOOK_RW(ITERATOR, HEAD)	while (0)
 
-struct security_hook_heads *get_security_hook_heads(bool is_mutable)
+static struct security_hook_heads *get_security_hook_heads(bool is_writable)
 {
-	if (is_mutable)
+	if (is_writable)
 		return ERR_PTR(-ENOTSUPP);
 	return &security_hook_heads_ro;
 }
@@ -120,7 +117,7 @@ static inline void unlock_lsm(int idx)
 }
 
 /**
- * security_delete_hooks - Remove modules hooks from the mutable hooks lists.
+ * security_delete_hooks - Remove modules hooks from the writable hooks lists.
  * @lsm_info: The lsm_info struct for this security module
  *
  * If LSM unloading is disabled, this function will panic. It should not
@@ -128,9 +125,8 @@ static inline void unlock_lsm(int idx)
  */
 void security_delete_hooks(struct lsm_info *info)
 {
-	if (!atomic_read(&security_allow_unregister_hooks))
-		panic("Security module %s is attempting to delete hooks.\n",
-			info->name);
+	if (!security_allow_unregister_hooks)
+		panic("Security hooks are already locked.\n");
 
 	__security_delete_hooks(info);
 
@@ -138,39 +134,17 @@ void security_delete_hooks(struct lsm_info *info)
 }
 EXPORT_SYMBOL_GPL(security_delete_hooks);
 
-static void lock_existing_hooks(void)
-{
-	struct lsm_info *info;
-
-	/*
-	 * Prevent module unloading while we're doing this
-	 * try_module_get may fail (safely), if the module
-	 * is already unloading -- allow that.
-	 */
-	mutex_lock(&module_mutex);
-	mutex_lock(&lsm_info_lock);
-	pr_info("Locking security hooks\n");
-
-	hlist_for_each_entry(info, &lsm_info_head, list)
-		WARN_ON(!try_module_get(info->owner));
-
-	mutex_unlock(&lsm_info_lock);
-	mutex_unlock(&module_mutex);
-}
-
 static int allow_unregister_hooks_set(const char *val,
 					const struct kernel_param *kp)
 {
-	const int current_val = atomic_read(&security_allow_unregister_hooks);
+	const bool current_val = security_allow_unregister_hooks;
 	bool new_val;
-	int ret;
 
-	ret = strtobool(val, &new_val);
-	if (ret)
+	if (strtobool(val, &new_val))
 		return 0;
 
 	/* Noop */
-	if (!!new_val == !!current_val)
+	if (new_val == current_val)
 		return 0;
 
 	/* Do not allow for the transition from false -> true */
@@ -178,16 +152,15 @@ static int allow_unregister_hooks_set(const char *val,
 		return -EPERM;
 
 	/* The only legal transition true -> false */
-	if (atomic_cmpxchg(&security_allow_unregister_hooks, 1, 0) == 1)
-		lock_existing_hooks();
-
+	if (!xchg(&security_allow_unregister_hooks, 1))
+		pr_info("Locked security hooks.\n");
 	return 0;
 }
 
 static int allow_unregister_hooks_get(char *buffer,
 					const struct kernel_param *kp)
 {
-	const int current_val = atomic_read(&security_allow_unregister_hooks);
+	const bool current_val = security_allow_unregister_hooks;
 	int ret;
 
 	ret = sprintf(buffer, "%c\n", current_val ? '1' : '0');
@@ -241,14 +214,13 @@ static int security_module_cb(struct notifier_block *nb, unsigned long val,
 	struct module *mod = data;
 	struct lsm_info *info;
 
-	if (val != MODULE_STATE_GOING)
+	if (val != MODULE_STATE_GOING || security_allow_unregister_hooks)
 		return NOTIFY_DONE;
 
 	mutex_lock(&lsm_info_lock);
 	hlist_for_each_entry(info, &lsm_info_head, list)
 		if (mod == info->owner)
-			panic("Security module %s is being unloaded without deregistering hooks",
-				info->name);
+			panic("Security hooks are already locked.\n");
 	mutex_unlock(&lsm_info_lock);
 
 	return NOTIFY_DONE;
@@ -334,41 +306,29 @@ static void security_add_hook(struct security_hook_list *hook,
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @lsm_info: The lsm_info struct for this security module
- * @is_mutable: Can these hooks be loaded or unloaded after boot time
+ * @is_writable: Can these hooks be loaded or unloaded after boot time
  *
  * Each LSM has to register its hooks with the infrastructure.
  * Return 0 on success
  */
-int __must_check security_add_hooks(struct lsm_info *info, bool is_mutable)
+int __must_check security_add_hooks(struct lsm_info *info, bool is_writable)
 {
 	struct security_hook_heads *heads;
-	int i, ret = 0;
+	int i;
 
-	heads = get_security_hook_heads(is_mutable);
+	heads = get_security_hook_heads(is_writable);
 	if (IS_ERR(heads))
 		return PTR_ERR(heads);
 
 	if (mutex_lock_killable(&lsm_info_lock))
 		return -EINTR;
 
-	if (!atomic_read(&security_allow_unregister_hooks)) {
-		/*
-		 * Because hook deregistration is not allowed, we need to try
-		 * to get a refcount on the module owner.
-		 */
-		if (!try_module_get(info->owner)) {
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-
 	for (i = 0; i < info->count; i++)
 		security_add_hook(&info->hooks[i], info, heads);
 	hlist_add_tail_rcu(&info->list, &lsm_info_head);
-out:
 	mutex_unlock(&lsm_info_lock);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(security_add_hooks);
 
diff --git a/security/security.h b/security/security.h
index 3e757f5..ed056d5 100644
--- a/security/security.h
+++ b/security/security.h
@@ -1,11 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/mutex.h>
 #include <linux/list.h>
-#include <linux/lsm_hooks.h>
 
-#ifndef __SECURITY_SECURITY_H
-#define __SECURITY_SECURITY_H
 extern struct mutex lsm_info_lock;
 extern struct hlist_head lsm_info_head;
-extern struct security_hook_heads *get_security_hook_heads(bool is_mutable);
-#endif
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
