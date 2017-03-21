From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 21 Mar 2017 08:36:21 -0700
Subject: out of tree lsm's
In-Reply-To: <201703211941.CBC26593.FtOLFQFJSOMOHV@I-love.SAKURA.ne.jp>
References: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
	<CAHC9VhSiEaXYoUhr_Bvs_fLYyA+ex=xQLY26jkPLqivkRpTkqw@mail.gmail.com>
	<CADc-OzEFBMk1sdbqT54Fwzya2uAAcfFisJ6ZGgxBRJT8s+jzeg@mail.gmail.com>
	<c25cb4fd-9459-1899-8275-beb62d12c265@schaufler-ca.com>
	<201703210718.CJE73456.MVHOFFQFLSJOOt@I-love.SAKURA.ne.jp>
	<201703211941.CBC26593.FtOLFQFJSOMOHV@I-love.SAKURA.ne.jp>
Message-ID: <04d6fd0a-bb59-b3c0-258c-b5826e7277a0@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/21/2017 3:41 AM, Tetsuo Handa wrote:
> Tetsuo Handa wrote:
>> Casey Schaufler wrote:
>>>> right. sorry for the imprecise language; by site-specific I meant a "small" lsm.
>>>>
>>>> I would love to have the ability write a small lsm that I can build as
>>>> a module and load at boot eg. via initrd.
>>>>
>>>> AIUI, adding even a new "small" lsm requires kconfig patches, building
>>>> a new kernel, etc. I know there are objections to dynamically loadable
>>>> lsms and I was trying to find a compromise that made them easier to
>>>> work with.
>>> The stacking design criteria I'm working with
>>> include not doing anything that would prevent
>>> dynamic module loading. I do not plan to implement
>>> dynamic loading. Tetsuo has been a strong
>>> advocate of loadable modules. I would expect to
>>> see a proposal from him shortly after the
>>> general stacking lands, assuming it does.
>> But currently __lsm_ro_after_init which is planned to go to 4.12 is preventing
>> dynamic modules from loading. We need a legitimate interface for loadable modules like
>> http://lkml.kernel.org/r/201702152342.GBH04183.FOFJFHQOLMOtVS at I-love.SAKURA.ne.jp .
>> Requiring rodata=0 kernel command line option to allow dynamic modules is silly.
>>
> I think we need something like below change when allowing loadable modules.

I believe that a simpler approach would be to
add a separate list of dynamic hooks to supliment
the list of static hooks. If SELinux unloading is
desired the SELinux hooks would be put on the
dynamic list which would not be "hardened" with
_ro_after_init, where the rest of the static modules
would be.


> >From b81fbc7c9c052c92f842777428bee2d5942ce9a9 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 21 Mar 2017 14:37:52 +0900
> Subject: [PATCH] security: Make dynamic module registration legitimate.
>
> While we are waiting for stacking support of in-tree built-in LSM modules
> (and therefore I am refraining from proposing changes for supporting
> dynamically loadable LSM modules), commit dd0859dccbe291cf ("security:
> introduce CONFIG_SECURITY_WRITABLE_HOOKS") and commit ca97d939db114c8d
> ("security: mark LSM hooks as __ro_after_init") came in. But these two
> commits are preventing us from making it possible to legitimately support
> dynamically loadable LSM modules due to lack of architecture-independent
> infrastructure for temporarily making LSM hooks writable.
>
> This patch demonstrates how we can make it possible to legitimately support
> dynamically loadable LSM modules by using set_memory_ro()/set_memory_nx()/
> set_memory_rw() infrastructure rather than __ro_after_init marking.
>
> Below is an example output for registration and runtime disablement of
> SELinux by this patch. pr_info() in this patch is only for testing purpose
> and will be removed in the final version.
>
> ----------
> [    0.014039] Security Framework initialized
> [    0.015006] Allocating LSM hooks for capability at ffff88013a10a000
> [    0.016003] Yama: becoming mindful.
> [    0.017008] Allocating LSM hooks for yama at ffff88013a10b000
> [    0.018006] LoadPin: ready to pin (currently disabled)
> [    0.018009] Allocating LSM hooks for loadpin at ffff88013a10c000
> [    0.020004] SELinux:  Initializing.
> [    0.021016] Allocating LSM hooks for selinux at ffff88013a114000
> [    0.022005] AppArmor: AppArmor disabled by boot time parameter
> [    0.023002] Marking LSM hook heads at ffffffff81853000 read only and non execute.
> [    0.024025] Marking LSM hooks for capability at ffff88013a10a000 read only and non execute.
> [    0.025730] Marking LSM hooks for yama at ffff88013a10b000 read only and non execute.
> [    0.026007] Marking LSM hooks for loadpin at ffff88013a10c000 read only and non execute.
> [    0.027007] Marking LSM hooks for selinux at ffff88013a114000 read only and non execute.
> [    0.028140] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
> (...snipped...)
> [    5.069577] SELinux:  Disabled at runtime.
> [    5.076575] Marking LSM hooks for capability at ffff88013a10a000 read write.
> [    5.087069] Marking LSM hooks for yama at ffff88013a10b000 read write.
> [    5.096963] Marking LSM hooks for loadpin at ffff88013a10c000 read write.
> [    5.104957] Marking LSM hooks for selinux at ffff88013a114000 read write.
> [    5.109179] Marking LSM hook heads at ffffffff81853000 read write.
> [    5.112881] Marking LSM hook heads at ffffffff81853000 read only and non execute.
> [    5.117276] Marking LSM hooks for capability at ffff88013a10a000 read only and non execute.
> [    5.122347] Marking LSM hooks for yama at ffff88013a10b000 read only and non execute.
> [    5.126936] Marking LSM hooks for loadpin at ffff88013a10c000 read only and non execute.
> [    5.149116] audit: type=1404 audit(1490064154.351:2): selinux=0 auid=4294967295 ses=4294967295
> ----------
>
> This patch mainly does the following things.
>
>   (1) Use set_memory_ro()/set_memory_nx() instead of __ro_after_init
>       so that runtime disablement of SELinux and runtime enablement of
>       dynamically loadable LSMs can use set_memory_rw().
>
>       While x86 architecture provides lookup_address() for finding
>       "struct page" from virtual address which allows us to temporarily
>       make specific pages writable, other architectures which support
>       CONFIG_STRICT_KERNEL_RWX feature which __ro_after_init depends on
>       (e.g. arm, parisc, s390) do not provide it.
>       But set_memory_ro()/set_memory_nx()/set_memory_rw() are already
>       available in x86, arm and s390. I don't know whether parisc can
>       implement set_memory_xx() but I assume it is possible. Therefore,
>       I assume that set_memory_xx() will support wider environments than
>       __ro_after_init while allowing runtime disablement of SELinux and
>       runtime enablement of dynamically loadable LSMs until we get
>       architecture-independent infrastructure for temporarily making LSM
>       hooks writable.
>
>   (2) Make "struct security_hook_list" variable in each LSM module
>       read-only by copying the content of that variable to dynamically
>       allocated (and protected via set_memory_ro()/set_memory_nx())
>       memory pages upon registration.
>
>   (3) Add EXPORT_SYMBOL_GPL(security_add_hooks) in order to legitimately
>       support dynamically loadable LSMs.
>
>   (4) Replace "struct security_hook_list"->head with
>       "struct security_hook_list"->offset so that
>       "struct security_hook_heads security_hook_heads;" can become
>       a local variable in security/security.c .
>
> This patch applies on top of reverting the two commits mentioned above.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  include/linux/lsm_hooks.h  |  34 +++++++-------
>  security/apparmor/lsm.c    |   2 +-
>  security/commoncap.c       |   2 +-
>  security/loadpin/loadpin.c |   2 +-
>  security/security.c        | 112 ++++++++++++++++++++++++++++++++++++++++++---
>  security/selinux/hooks.c   |  14 ++++--
>  security/smack/smack_lsm.c |   2 +-
>  security/tomoyo/tomoyo.c   |   2 +-
>  security/yama/yama_lsm.c   |   2 +-
>  9 files changed, 139 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index e29d4c6..668157f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1857,7 +1857,7 @@ struct security_hook_heads {
>  	struct list_head audit_rule_match;
>  	struct list_head audit_rule_free;
>  #endif /* CONFIG_AUDIT */
> -};
> +} __aligned(PAGE_SIZE);
>  
>  /*
>   * Security module hook list structure.
> @@ -1865,9 +1865,16 @@ struct security_hook_heads {
>   */
>  struct security_hook_list {
>  	struct list_head		list;
> -	struct list_head		*head;
>  	union security_list_options	hook;
> -	char				*lsm;
> +	const char			*lsm;
> +	unsigned int			offset;
> +};
> +
> +struct lsm_entry {
> +	struct list_head head;
> +	unsigned int order;
> +	unsigned int count;
> +	struct security_hook_list hooks[0];
>  };
>  
>  /*
> @@ -1877,14 +1884,14 @@ struct security_hook_list {
>   * text involved.
>   */
>  #define LSM_HOOK_INIT(HEAD, HOOK) \
> -	{ .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
> +	{ .offset = offsetof(struct security_hook_heads, HEAD), \
> +	  .hook = { .HEAD = HOOK } }
>  
> -extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
> -extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> -
> +extern struct lsm_entry *security_add_hooks(const struct security_hook_list *
> +					    hooks, const unsigned int count,
> +					    const char *lsm);
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  /*
>   * Assuring the safety of deleting a security module is up to
> @@ -1898,15 +1905,8 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>   * disabling their module is a good idea needs to be at least as
>   * careful as the SELinux team.
>   */
> -static inline void security_delete_hooks(struct security_hook_list *hooks,
> -						int count)
> -{
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		list_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> +extern void security_delete_hooks(struct lsm_entry *entry);
> +#endif
>  
>  extern int __init security_module_enable(const char *module);
>  extern void __init capability_add_hooks(void);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 709eacd..04cf323 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -587,7 +587,7 @@ static int apparmor_task_setrlimit(struct task_struct *task,
>  	return error;
>  }
>  
> -static struct security_hook_list apparmor_hooks[] = {
> +static const struct security_hook_list apparmor_hooks[] __initconst = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>  	LSM_HOOK_INIT(capget, apparmor_capget),
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 78b3783..c456805 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1071,7 +1071,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> -struct security_hook_list capability_hooks[] = {
> +static const struct security_hook_list capability_hooks[] __initconst = {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
>  	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 1d82eae..b88154a 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -174,7 +174,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>  	return 0;
>  }
>  
> -static struct security_hook_list loadpin_hooks[] = {
> +static const struct security_hook_list loadpin_hooks[] __initconst = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  };
> diff --git a/security/security.c b/security/security.c
> index d0e07f2..9cb2b3e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,6 +32,7 @@
>  /* Maximum number of letters for an LSM name string */
>  #define SECURITY_NAME_MAX	10
>  
> +static bool lsm_initialized __ro_after_init;
>  char *lsm_names;
>  /* Boot-time LSM user choice */
>  static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
> @@ -47,6 +48,59 @@ static void __init do_security_initcalls(void)
>  	}
>  }
>  
> +static struct security_hook_heads security_hook_heads __aligned(PAGE_SIZE);
> +static LIST_HEAD(lsm_entry_list);
> +#if defined(CONFIG_STRICT_KERNEL_RWX) && !defined(CONFIG_PARISC)
> +static inline void mark_security_hooks_ro(void)
> +{
> +	struct lsm_entry *tmp;
> +	void *addr;
> +
> +	BUILD_BUG_ON(sizeof(security_hook_heads) % PAGE_SIZE);
> +	BUILD_BUG_ON(!PAGE_ALIGNED(&security_hook_heads));
> +	pr_info("Marking LSM hook heads at %p read only and non execute.\n",
> +		&security_hook_heads);
> +	addr = page_address(virt_to_page(&security_hook_heads));
> +	set_memory_ro((unsigned long) addr,
> +		      sizeof(security_hook_heads) >> PAGE_SHIFT);
> +	set_memory_nx((unsigned long) addr,
> +		      sizeof(security_hook_heads) >> PAGE_SHIFT);
> +	list_for_each_entry(tmp, &lsm_entry_list, head) {
> +		pr_info("Marking LSM hooks for %s at %p read only and non execute.\n",
> +			tmp->hooks[0].lsm, tmp);
> +		addr = page_address(virt_to_head_page(tmp));
> +		set_memory_ro((unsigned long) addr, 1 << tmp->order);
> +		set_memory_nx((unsigned long) addr, 1 << tmp->order);
> +	}
> +}
> +
> +static inline void mark_security_hooks_rw(void)
> +{
> +	struct lsm_entry *tmp;
> +	void *addr;
> +
> +	list_for_each_entry(tmp, &lsm_entry_list, head) {
> +		pr_info("Marking LSM hooks for %s at %p read write.\n",
> +			tmp->hooks[0].lsm, tmp);
> +		addr = page_address(virt_to_head_page(tmp));
> +		set_memory_rw((unsigned long) addr, 1 << tmp->order);
> +	}
> +	pr_info("Marking LSM hook heads at %p read write.\n",
> +		&security_hook_heads);
> +	addr = page_address(virt_to_page(&security_hook_heads));
> +	set_memory_rw((unsigned long) addr,
> +		      sizeof(security_hook_heads) >> PAGE_SHIFT);
> +}
> +#else
> +static inline void mark_security_hooks_ro(void)
> +{
> +}
> +
> +static inline void mark_security_hooks_rw(void)
> +{
> +}
> +#endif
> +
>  /**
>   * security_init - initializes the security framework
>   *
> @@ -68,6 +122,8 @@ int __init security_init(void)
>  	 */
>  	do_security_initcalls();
>  
> +	lsm_initialized = true;
> +	mark_security_hooks_ro();
>  	return 0;
>  }
>  
> @@ -79,7 +135,7 @@ static int __init choose_lsm(char *str)
>  }
>  __setup("security=", choose_lsm);
>  
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>  	char *cp;
>  
> @@ -122,18 +178,60 @@ int __init security_module_enable(const char *module)
>   *
>   * Each LSM has to register its hooks with the infrastructure.
>   */
> -void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +struct lsm_entry *security_add_hooks(const struct security_hook_list *hooks,
> +				     const unsigned int count, const char *lsm)
>  {
>  	int i;
> +	/*
> +	 * entry has to be an PAGE_ALIGNED multiple of PAGE_SIZE memory
> +	 * in order to pass to set_memory_ro()/set_memory_nx()/set_memory_rw().
> +	 */
> +	const size_t size = sizeof(*hooks) * count + sizeof(struct lsm_entry);
> +	const unsigned int order = get_order(size);
> +	struct lsm_entry *entry = kmalloc_order(size, GFP_KERNEL | __GFP_ZERO,
> +						order);
>  
> +	if (!entry || !PAGE_ALIGNED(entry) || lsm_append(lsm, &lsm_names) < 0) {
> +		kfree(entry);
> +		goto out;
> +	}
> +	if (lsm_initialized)
> +		mark_security_hooks_rw();
> +	pr_info("Allocating LSM hooks for %s at %p\n", lsm, entry);
> +	entry->order = order;
> +	entry->count = count;
> +	memcpy(&entry->hooks[0], hooks, size - sizeof(struct lsm_entry));
>  	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> -		list_add_tail_rcu(&hooks[i].list, hooks[i].head);
> +		entry->hooks[i].lsm = lsm;
> +		list_add_tail_rcu(&entry->hooks[i].list, (struct list_head *)
> +				  (((char *) &security_hook_heads)
> +				   + entry->hooks[i].offset));
>  	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> +	list_add_tail(&entry->head, &lsm_entry_list);
> +	if (lsm_initialized)
> +		mark_security_hooks_ro();
> +	return entry;
> + out:
> +	if (!lsm_initialized)
>  		panic("%s - Cannot get early memory.\n", __func__);
> +	return NULL;
> +}
> +/* Enable this when we start supporting loadable LSM modules.*/
> +EXPORT_SYMBOL_GPL(security_add_hooks);
> +
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +void security_delete_hooks(struct lsm_entry *entry)
> +{
> +	int i;
> +
> +	mark_security_hooks_rw();
> +	list_del_rcu(&entry->head);
> +	for (i = 0; i < entry->count; i++)
> +		list_del_rcu(&entry->hooks[i].list);
> +	/* Not calling kfree() in order to avoid races. */
> +	mark_security_hooks_ro();
>  }
> +#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>  
>  /*
>   * Hook list operation macros.
> @@ -1622,7 +1720,7 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
>  }
>  #endif /* CONFIG_AUDIT */
>  
> -struct security_hook_heads security_hook_heads = {
> +static struct security_hook_heads security_hook_heads = {
>  	.binder_set_context_mgr =
>  		LIST_HEAD_INIT(security_hook_heads.binder_set_context_mgr),
>  	.binder_transaction =
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0c2ac31..6fa68d9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6108,7 +6108,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  
>  #endif
>  
> -static struct security_hook_list selinux_hooks[] = {
> +static const struct security_hook_list selinux_hooks[] __initconst = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> @@ -6323,6 +6323,10 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  #endif
>  };
>  
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +static struct lsm_entry *selinux_entry;
> +#endif
> +
>  static __init int selinux_init(void)
>  {
>  	if (!security_module_enable("selinux")) {
> @@ -6350,7 +6354,11 @@ static __init int selinux_init(void)
>  					    0, SLAB_PANIC, NULL);
>  	avc_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +	selinux_entry =
> +#endif
> +		security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> +				   "selinux");
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> @@ -6479,7 +6487,7 @@ int selinux_disable(void)
>  	selinux_disabled = 1;
>  	selinux_enabled = 0;
>  
> -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> +	security_delete_hooks(selinux_entry);
>  
>  	/* Try to destroy the avc node cache */
>  	avc_disable();
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index fc8fb31..fbc86a3 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4633,7 +4633,7 @@ static int smack_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
>  	return 0;
>  }
>  
> -static struct security_hook_list smack_hooks[] = {
> +static const struct security_hook_list smack_hooks[] __initconst = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index edc52d6..74ef461 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -496,7 +496,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
>   */
> -static struct security_hook_list tomoyo_hooks[] = {
> +static const struct security_hook_list tomoyo_hooks[] __initconst = {
>  	LSM_HOOK_INIT(cred_alloc_blank, tomoyo_cred_alloc_blank),
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
>  	LSM_HOOK_INIT(cred_transfer, tomoyo_cred_transfer),
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 88271a3..6e1cb40 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -428,7 +428,7 @@ int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> -static struct security_hook_list yama_hooks[] = {
> +static const struct security_hook_list yama_hooks[] __initconst = {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>  	LSM_HOOK_INIT(task_prctl, yama_task_prctl),

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
