From: casey@schaufler-ca.com (Casey Schaufler)
Date: Wed, 28 Mar 2018 10:39:57 -0700
Subject: [PATCH v2 2/2] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <19f85393f334f87ff097b3112b55a15caa3faf8d.1522185596.git.sargun@sargun.me>
References: <cover.1522185596.git.sargun@sargun.me>
	<19f85393f334f87ff097b3112b55a15caa3faf8d.1522185596.git.sargun@sargun.me>
Message-ID: <4fa6c20b-a559-d2c2-408c-72fa3dfac087@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/27/2018 6:30 PM, Sargun Dhillon wrote:
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
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/lsm_hooks.h  |  23 ++--
>  security/Kconfig           |   2 +-
>  security/apparmor/lsm.c    |   2 +-
>  security/commoncap.c       |   2 +-
>  security/security.c        | 270 ++++++++++++++++++++++++++++++++++++++++++---
>  security/selinux/hooks.c   |   5 +-
>  security/smack/smack_lsm.c |   3 +-
>  security/tomoyo/tomoyo.c   |   3 +-
>  security/yama/yama_lsm.c   |   2 +-
>  9 files changed, 273 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 09bc60fb35f1..689e5e72fb38 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1981,9 +1981,12 @@ extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +				char *lsm, bool is_mutable);
>  
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +#define __lsm_ro_after_init	__ro_after_init
> +/* Currently required to handle SELinux runtime hook disable. */
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +#define __lsm_mutable_after_init
>  /*
>   * Assuring the safety of deleting a security module is up to
>   * the security module involved. This may entail ordering the
> @@ -1996,21 +1999,9 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>   * disabling their module is a good idea needs to be at least as
>   * careful as the SELinux team.
>   */
> -static inline void security_delete_hooks(struct security_hook_list *hooks,
> -						int count)
> -{
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		hlist_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> -
> -/* Currently required to handle SELinux runtime hook disable. */
> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> -#define __lsm_ro_after_init
> +extern void security_delete_hooks(struct security_hook_list *hooks, int count);
>  #else
> -#define __lsm_ro_after_init	__ro_after_init
> +#define __lsm_mutable_after_init __ro_after_init
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>  
>  extern int __init security_module_enable(const char *module);
> diff --git a/security/Kconfig b/security/Kconfig
> index c4302067a3ad..a3b8b1142e6f 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,7 +32,7 @@ config SECURITY
>  	  If you are unsure how to answer this question, answer N.
>  
>  config SECURITY_WRITABLE_HOOKS
> -	depends on SECURITY
> +	depends on SECURITY && SRCU
>  	bool
>  	default n
>  
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 9a65eeaf7dfa..d6cca8169df0 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1155,7 +1155,7 @@ static int __init apparmor_init(void)
>  		goto buffers_out;
>  	}
>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				"apparmor", false);
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 48620c93d697..fe4b0d9d44ce 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1363,7 +1363,7 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  void __init capability_add_hooks(void)
>  {
>  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +				"capability", false);
>  }
>  
>  #endif /* CONFIG_SECURITY */
> diff --git a/security/security.c b/security/security.c
> index 3cafff61b049..c5e770e96616 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -29,6 +29,11 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <net/flow.h>
> +#include <linux/srcu.h>
> +#include <linux/mutex.h>
> +
> +#define SECURITY_HOOK_COUNT \
> +	(sizeof(security_hook_heads) / sizeof(struct hlist_head))
>  
>  #define MAX_LSM_EVM_XATTR	2
>  
> @@ -36,7 +41,10 @@
>  #define SECURITY_NAME_MAX	10
>  
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +EXPORT_SYMBOL_GPL(security_hook_heads);
> +
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +static DEFINE_MUTEX(security_hook_mutex);
>  
>  char *lsm_names;
>  /* Boot-time LSM user choice */
> @@ -53,6 +61,81 @@ static void __init do_security_initcalls(void)
>  	}
>  }
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +static struct srcu_struct security_hook_srcu;
> +
> +static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
> +{
> +	struct security_hook_list *mutable_hook;
> +	union {
> +		void *cb_ptr;
> +		union security_list_options slo;
> +	} hook_options;
> +
> +	hlist_for_each_entry(mutable_hook, hook->head, list) {
> +		hook_options.slo = mutable_hook->hook;
> +		if (hook_options.cb_ptr)
> +			continue;
> +
> +		if (is_mutable)
> +			hlist_add_behind_rcu(&hook->list, &mutable_hook->list);
> +		else
> +			hlist_add_before_rcu(&hook->list, &mutable_hook->list);
> +		return;
> +	}
> +
> +	panic("Unable to install hook, cannot find mutable hook\n");
> +}
> +
> +static void __init add_mutable_hooks(void)
> +{
> +	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> +	struct security_hook_list *shl;
> +	int i;
> +
> +	for (i = 0; i < SECURITY_HOOK_COUNT; i++) {
> +		shl = kzalloc(sizeof(*shl), GFP_KERNEL);
> +		if (!shl)
> +			panic("Unable to allocate memory for mutable hooks\n");
> +		shl->head = &list[i];
> +		hlist_add_head_rcu(&shl->list, shl->head);
> +	}
> +}
> +
> +static void __init setup_mutable_hooks(void)
> +{
> +	int ret;
> +
> +	ret = init_srcu_struct(&security_hook_srcu);
> +	if (ret)
> +		panic("Could not initialize srcu: %d\n", ret);
> +	add_mutable_hooks();
> +}
> +
> +void security_delete_hooks(struct security_hook_list *hooks, int count)
> +{
> +	int i;
> +
> +	mutex_lock(&security_hook_mutex);
> +	for (i = 0; i < count; i++)
> +		hlist_del_rcu(&hooks[i].list);
> +	mutex_unlock(&security_hook_mutex);
> +
> +	synchronize_srcu(&security_hook_srcu);
> +}
> +EXPORT_SYMBOL_GPL(security_delete_hooks);
> +
> +#else
> +static void security_add_hook(struct security_hook_list *hook, bool is_mutable)
> +{
> +	WARN_ONCE(is_mutable,
> +			"Mutable hook loaded with writable hooks disabled");
> +	hlist_add_tail_rcu(&hook->list, hook->head);
> +}
> +
> +static void __init setup_mutable_hooks(void) {}
> +#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -63,11 +146,11 @@ int __init security_init(void)
>  	int i;
>  	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
>  
> -	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> -	     i++)
> +	for (i = 0; i < SECURITY_HOOK_COUNT; i++)
>  		INIT_HLIST_HEAD(&list[i]);
>  	pr_info("Security Framework initialized\n");
>  
> +	setup_mutable_hooks();
>  	/*
>  	 * Load minor LSMs, with the capability module always first.
>  	 */
> @@ -153,21 +236,26 @@ int __init security_module_enable(const char *module)
>   * @hooks: the hooks to add
>   * @count: the number of hooks to add
>   * @lsm: the name of the security module
> + * @is_mutable: is this hook mutable after kernel init
>   *
>   * Each LSM has to register its hooks with the infrastructure.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +void security_add_hooks(struct security_hook_list *hooks, int count,
> +				char *lsm, bool is_mutable)
>  {
>  	int i;
>  
> +	mutex_lock(&security_hook_mutex);
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsm = lsm;
> -		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +		security_add_hook(&hooks[i], is_mutable);
>  	}
> +	mutex_unlock(&security_hook_mutex);
> +
>  	if (lsm_append(lsm, &lsm_names) < 0)
>  		panic("%s - Cannot get early memory.\n", __func__);
>  }
> +EXPORT_SYMBOL_GPL(security_add_hooks);
>  
>  int call_lsm_notifier(enum lsm_event event, void *data)
>  {
> @@ -197,6 +285,38 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
>   *	This is a hook that returns a value.
>   */
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +#define call_void_hook(FUNC, ...)					\
> +	do {								\
> +		struct security_hook_list *P;				\
> +		int srcu_idx;						\
> +									\
> +		srcu_idx = srcu_read_lock(&security_hook_srcu);		\
> +		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) \
> +			if (P->hook.FUNC)				\
> +				P->hook.FUNC(__VA_ARGS__);		\
> +		srcu_read_unlock(&security_hook_srcu, srcu_idx);	\
> +	} while (0)
> +
> +#define call_int_hook(FUNC, IRC, ...) ({			\
> +	int srcu_idx, RC = IRC;					\
> +								\
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);		\
> +	do {							\
> +		struct security_hook_list *P;			\
> +								\
> +		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
> +			if (P->hook.FUNC) {			\
> +				RC = P->hook.FUNC(__VA_ARGS__);	\
> +				if (RC != 0)			\
> +					break;			\
> +			}					\
> +		}						\
> +	} while (0);						\
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);	\
> +	RC;							\
> +})
> +#else
>  #define call_void_hook(FUNC, ...)				\
>  	do {							\
>  		struct security_hook_list *P;			\
> @@ -218,6 +338,7 @@ EXPORT_SYMBOL(unregister_lsm_notifier);
>  	} while (0);						\
>  	RC;							\
>  })
> +#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>  
>  /* Security operations */
>  
> @@ -304,7 +425,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
>  	return call_int_hook(settime, 0, ts, tz);
>  }
>  
> -int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> +static int __security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  {
>  	struct security_hook_list *hp;
>  	int cap_sys_admin = 1;
> @@ -318,6 +439,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	 * thinks it should not be set it won't.
>  	 */
>  	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
> +		if (!hp->hook.vm_enough_memory)
> +			continue;

This needs to be conditional on CONFIG_SECURITY_WRITABLE_HOOKS
?

>  		rc = hp->hook.vm_enough_memory(mm, pages);
>  		if (rc <= 0) {
>  			cap_sys_admin = 0;
> @@ -327,6 +450,24 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
>  	return __vm_enough_memory(mm, pages, cap_sys_admin);
>  }
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> +{
> +	int srcu_idx, ret;
> +
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);
> +	ret = __security_vm_enough_memory_mm(mm, pages);
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);
> +
> +	return ret;
> +}
> +#else
> +int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
> +{
> +	return __security_vm_enough_memory_mm(mm, pages);
> +}
> +#endif

I prefer Tetsuo's lock_lsm()/unlock_lsm() method over adding
__security functions. I abhor functions that do nothing but call
another function.


> +
>  int security_bprm_set_creds(struct linux_binprm *bprm)
>  {
>  	return call_int_hook(bprm_set_creds, 0, bprm);
> @@ -795,7 +936,8 @@ int security_inode_killpriv(struct dentry *dentry)
>  	return call_int_hook(inode_killpriv, 0, dentry);
>  }
>  
> -int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
> +static int __security_inode_getsecurity(struct inode *inode, const char *name,
> +					void **buffer, bool alloc)
>  {
>  	struct security_hook_list *hp;
>  	int rc;
> @@ -806,14 +948,19 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
>  	 * Only one module will provide an attribute with a given name.
>  	 */
>  	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
> +		if (!hp->hook.inode_getsecurity)
> +			continue;

This needs to be conditional on CONFIG_SECURITY_WRITABLE_HOOKS
?

>  		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
>  		if (rc != -EOPNOTSUPP)
>  			return rc;
>  	}
> +
>  	return -EOPNOTSUPP;
>  }
>  
> -int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
> +static int __security_inode_setsecurity(struct inode *inode, const char *name,
> +					const void *value, size_t size,
> +					int flags)
>  {
>  	struct security_hook_list *hp;
>  	int rc;
> @@ -824,14 +971,58 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
>  	 * Only one module will provide an attribute with a given name.
>  	 */
>  	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecurity, list) {
> +		if (!hp->hook.inode_setsecurity)
> +			continue;

This needs to be conditional on CONFIG_SECURITY_WRITABLE_HOOKS
?

>  		rc = hp->hook.inode_setsecurity(inode, name, value, size,
> -								flags);
> +						flags);
>  		if (rc != -EOPNOTSUPP)
>  			return rc;
>  	}
> +
>  	return -EOPNOTSUPP;
>  }
>  
> +
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +int security_inode_getsecurity(struct inode *inode, const char *name,
> +				void **buffer, bool alloc)
> +{
> +	int srcu_idx, ret;
> +
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);
> +	ret = __security_inode_getsecurity(inode, name, buffer, alloc);
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);
> +
> +	return ret;
> +
> +}
> +
> +int security_inode_setsecurity(struct inode *inode, const char *name,
> +				const void *value, size_t size, int flags)
> +{
> +	int srcu_idx, ret;
> +
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);
> +	ret = __security_inode_setsecurity(inode, name, value, size, flags);
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);
> +
> +	return ret;
> +}
> +#else
> +int security_inode_getsecurity(struct inode *inode, const char *name,
> +				void **buffer, bool alloc)
> +{
> +	return __security_inode_getsecurity(inode, name, buffer, alloc);
> +}
> +
> +int security_inode_setsecurity(struct inode *inode, const char *name,
> +				const void *value, size_t size, int flags)
> +{
> +	return __security_inode_setsecurity(inode, name, value, size, flags);
> +}
> +#endif
> +
> +
>  int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
>  {
>  	if (unlikely(IS_PRIVATE(inode)))
> @@ -1119,14 +1310,17 @@ int security_task_kill(struct task_struct *p, struct siginfo *info,
>  	return call_int_hook(task_kill, 0, p, info, sig, secid);
>  }
>  
> -int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> -			 unsigned long arg4, unsigned long arg5)
> +static int __security_task_prctl(int option, unsigned long arg2,
> +				 unsigned long arg3, unsigned long arg4,
> +				 unsigned long arg5)
>  {
>  	int thisrc;
>  	int rc = -ENOSYS;
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.task_prctl, list) {
> +		if (!hp->hook.task_prctl)
> +			continue;

This needs to be conditional on CONFIG_SECURITY_WRITABLE_HOOKS
?

>  		thisrc = hp->hook.task_prctl(option, arg2, arg3, arg4, arg5);
>  		if (thisrc != -ENOSYS) {
>  			rc = thisrc;
> @@ -1137,6 +1331,26 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  	return rc;
>  }
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> +			 unsigned long arg4, unsigned long arg5)
> +{
> +	int srcu_idx, ret;
> +
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);
> +	ret = __security_task_prctl(option, arg2, arg3, arg4, arg5);
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);
> +
> +	return ret;
> +}
> +#else
> +int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> +			 unsigned long arg4, unsigned long arg5)
> +{
> +	return __security_task_prctl(option, arg2, arg3, arg4, arg5);
> +}
> +#endif
> +
>  void security_task_to_inode(struct task_struct *p, struct inode *inode)
>  {
>  	call_void_hook(task_to_inode, p, inode);
> @@ -1613,9 +1827,9 @@ int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
>  	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid, dir);
>  }
>  
> -int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
> -				       struct xfrm_policy *xp,
> -				       const struct flowi *fl)
> +static int __security_xfrm_state_pol_flow_match(struct xfrm_state *x,
> +						struct xfrm_policy *xp,
> +						const struct flowi *fl)
>  {
>  	struct security_hook_list *hp;
>  	int rc = 1;
> @@ -1629,14 +1843,40 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
>  	 * For speed optimization, we explicitly break the loop rather than
>  	 * using the macro
>  	 */
> -	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
> +	hlist_for_each_entry(hp,
> +				&security_hook_heads.xfrm_state_pol_flow_match,
>  				list) {
> +		if (!hp->hook.xfrm_state_pol_flow_match)
> +			continue;

This needs to be conditional on CONFIG_SECURITY_WRITABLE_HOOKS
?

>  		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, fl);
>  		break;
>  	}
> +
>  	return rc;
>  }
>  
> +#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> +int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
> +				       struct xfrm_policy *xp,
> +				       const struct flowi *fl)
> +{
> +	int srcu_idx, ret;
> +
> +	srcu_idx = srcu_read_lock(&security_hook_srcu);
> +	ret = __security_xfrm_state_pol_flow_match(x, xp, fl);
> +	srcu_read_unlock(&security_hook_srcu, srcu_idx);
> +
> +	return ret;
> +}
> +#else
> +int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
> +				       struct xfrm_policy *xp,
> +				       const struct flowi *fl)
> +{
> +	return __security_xfrm_state_pol_flow_match(x, xp, fl);
> +}
> +#endif
> +
>  int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
>  {
>  	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8644d864e3c1..f05184a3a7a6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6393,7 +6393,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  }
>  #endif
>  
> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list selinux_hooks[] __lsm_mutable_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> @@ -6651,7 +6651,8 @@ static __init int selinux_init(void)
>  					    0, SLAB_PANIC, NULL);
>  	avc_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux",
> +				IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE));
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 03fdecba93bb..7a9f1bb06c8e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4902,7 +4902,8 @@ static __init int smack_init(void)
>  	/*
>  	 * Register with LSM
>  	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
> +				false);
>  
>  	return 0;
>  }
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 213b8c593668..ba74fab0e9a5 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -543,7 +543,8 @@ static int __init tomoyo_init(void)
>  	if (!security_module_enable("tomoyo"))
>  		return 0;
>  	/* register ourselves with the security framework */
> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
> +				false);
>  	printk(KERN_INFO "TOMOYO Linux initialized\n");
>  	cred->security = &tomoyo_kernel_domain;
>  	tomoyo_mm_init();
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index ffda91a4a1aa..04c9aed9e951 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -480,6 +480,6 @@ static inline void yama_init_sysctl(void) { }
>  void __init yama_add_hooks(void)
>  {
>  	pr_info("Yama: becoming mindful.\n");
> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama", false);
>  	yama_init_sysctl();
>  }

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
