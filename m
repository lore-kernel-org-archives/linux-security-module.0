From: sargun@sargun.me (Sargun Dhillon)
Date: Sat, 14 Apr 2018 13:14:41 -0700
Subject: [PATCH v6 1/1] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <201804132313.HDH87504.MOVLOFFQJtOSHF@I-love.SAKURA.ne.jp>
References: <cover.1523558422.git.sargun@sargun.me>
	<e75b87694dbd28b9e36bf1d53083e9ffb95a4c2f.1523558422.git.sargun@sargun.me>
	<201804132313.HDH87504.MOVLOFFQJtOSHF@I-love.SAKURA.ne.jp>
Message-ID: <CAMp4zn-RTuG_8=NzaY6+F1RyvD8TfxmwzREoVkjS7kshZ8Ms6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Apr 13, 2018 at 7:13 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I think we can introduce a struct for passing arguments of
> security_add_hooks()/security_delete_hooks(). Then, we don't
> need to increment module usage count as many as hooks used.
>
> ---
>  include/linux/lsm_hooks.h                     |  37 +++++---
>  scripts/gcc-plugins/randomize_layout_plugin.c |   2 -
>  security/apparmor/lsm.c                       |   6 +-
>  security/commoncap.c                          |   7 +-
>  security/loadpin/loadpin.c                    |   5 +-
>  security/security.c                           | 117 ++++++++++++++------------
>  security/selinux/hooks.c                      |  10 +--
>  security/smack/smack_lsm.c                    |   4 +-
>  security/tomoyo/tomoyo.c                      |   5 +-
>  security/yama/yama_lsm.c                      |   5 +-
>  10 files changed, 112 insertions(+), 86 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c577d3d..4df62dd 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2007,10 +2007,17 @@ struct security_hook_heads {
>   */
>  struct security_hook_list {
>         struct hlist_node                       list;
> -       const unsigned int                      hook_idx;
> +       const unsigned int                      offset;
>         const union security_list_options       hook;
> -       struct module                           *owner;
> -       char                                    *lsm;
> +       const char                              *lsm; /* Currently unused. */
> +} __randomize_layout;
> +
> +struct lsm_info {
> +       struct list_head                list;
> +       const char                      *name;
> +       struct module                   *owner;
> +       const int                       count;
> +       struct security_hook_list       *hooks;
>  } __randomize_layout;
>
>  /*
> @@ -2020,20 +2027,27 @@ struct security_hook_list {
>   * text involved.
>   */
>  #define HOOK_OFFSET(HEAD)      offsetof(struct security_hook_heads, HEAD)
> -#define HOOK_SIZE(HEAD)                FIELD_SIZEOF(struct security_hook_heads, HEAD)
> -#define LSM_HOOK_IDX(HEAD)     (HOOK_OFFSET(HEAD) / HOOK_SIZE(HEAD))
>
>  #define LSM_HOOK_INIT(HEAD, HOOK) \
>         {                                               \
>                 .hook = { .HEAD = HOOK },               \
> -               .owner = THIS_MODULE,                   \
> -               .hook_idx = LSM_HOOK_IDX(HEAD),         \
> +               .offset = HOOK_OFFSET(HEAD),            \
>         }
>  extern char *lsm_names;
>
> -extern int __must_check security_add_hooks(struct security_hook_list *hooks,
> -                                               const int count, char *lsm,
> -                                               const bool is_mutable);
> +#define LSM_MODULE_INIT(NAME, HOOKS)           \
> +       {                                       \
> +               .name = NAME,                   \
> +               .hooks = HOOKS,                 \
> +               .count = ARRAY_SIZE(HOOKS),     \
> +               .owner = THIS_MODULE,           \
> +       }
> +
> +extern int __must_check security_add_hooks(struct lsm_info *lsm,
> +                                          const bool is_mutable);
> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> +extern void __security_delete_hooks(struct lsm_info *lsm);
> +#endif
Why expose __security_delete_hooks in lsm_hooks.h? Given SELinux is
the only consumer, and shouldn't be using it much longer, I think it
makes sense to let it stay part of the SELinux hooks.c.

>  #ifdef CONFIG_SECURITY_UNREGISTRABLE_HOOKS
>  /*
>   * Used to facilitate runtime hook unloading
> @@ -2049,8 +2063,7 @@ extern int __must_check security_add_hooks(struct security_hook_list *hooks,
>   * disabling their module is a good idea needs to be at least as
>   * careful as the SELinux team.
>   */
> -extern int __must_check security_delete_hooks(struct security_hook_list *hooks,
> -                                               int count);
> +extern int __must_check security_delete_hooks(struct lsm_info *lsm);
>  #endif /* CONFIG_SECURITY_UNREGISTRABLE_HOOKS */
>
>  extern int __init security_module_enable(const char *module);
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 6d5bbd3..d941389 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -52,8 +52,6 @@ struct whitelist_entry {
>         { "net/unix/af_unix.c", "unix_skb_parms", "char" },
>         /* big_key payload.data struct splashing */
>         { "security/keys/big_key.c", "path", "void *" },
> -       /* walk struct security_hook_heads as an array of struct hlist_head */
> -       { "security/security.c", "hlist_head", "security_hook_heads" },
>         { }
>  };
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2a591bd..12c98aa8 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1191,6 +1191,9 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
>         LSM_HOOK_INIT(task_kill, apparmor_task_kill),
>  };
>
> +static struct lsm_info apparmor_module =
> +       LSM_MODULE_INIT("apparmor", apparmor_hooks);
> +
>  /*
>   * AppArmor sysfs module parameters
>   */
> @@ -1562,8 +1565,7 @@ static int __init apparmor_init(void)
>                 aa_free_root_ns();
>                 goto buffers_out;
>         }
> -       BUG_ON(security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -                                       "apparmor", false));
> +       BUG_ON(security_add_hooks(&apparmor_module, false));
>
>         /* Report that AppArmor successfully initialized */
>         apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index a215059..8c0df17 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1362,11 +1362,12 @@ struct security_hook_list capability_hooks[] __ro_after_init = {
>         LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
>  };
>
> +static struct lsm_info capability_module =
> +       LSM_MODULE_INIT("capability", capability_hooks);
> +
>  void __init capability_add_hooks(void)
>  {
> -       BUG_ON(security_add_hooks(capability_hooks,
> -                                       ARRAY_SIZE(capability_hooks),
> -                                       "capability", false));
> +       BUG_ON(security_add_hooks(&capability_module, false));
>  }
>
>  #endif /* CONFIG_SECURITY */
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 7c84ca8..60f85a5 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -178,10 +178,13 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
>         LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  };
>
> +static struct lsm_info loadpin_module =
> +       LSM_MODULE_INIT("loadpin", loadpin_hooks);
> +
>  void __init loadpin_add_hooks(void)
>  {
>         pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
> -       security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> +       BUG_ON(security_add_hooks(&loadpin_module, false));
>  }
>
>  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
> diff --git a/security/security.c b/security/security.c
> index dd69889..c4e5437 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,9 +32,6 @@
>  #include <linux/srcu.h>
>  #include <linux/mutex.h>
>
> -#define SECURITY_HOOK_COUNT \
> -       (sizeof(security_hook_heads) / sizeof(struct hlist_head))
> -
>  #include <trace/events/initcall.h>
>
>  #define MAX_LSM_EVM_XATTR      2
> @@ -43,7 +40,7 @@
>  #define SECURITY_NAME_MAX      10
>
>  static struct security_hook_heads security_hook_heads __ro_after_init;
> -
> +static LIST_HEAD(registered_lsm_modules);
>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>  static DEFINE_MUTEX(security_hook_mutex);
>  /*
> @@ -93,20 +90,20 @@ static void __init do_security_initcalls(void)
>  #define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD) \
>         hlist_for_each_entry(ITERATOR, &security_hook_heads_mutable.HEAD, list)
>
> -static struct hlist_head *get_heads(bool is_mutable)
> +static struct security_hook_heads *get_heads(bool is_mutable)
>  {
>         if (is_mutable)
> -               return (struct hlist_head *)&security_hook_heads_mutable;
> -       return (struct hlist_head *)&security_hook_heads;
> +               return &security_hook_heads_mutable;
> +       return &security_hook_heads;
>  }
>  #else
>  #define FOR_EACH_SECURITY_HOOK_MUTABLE(ITERATOR, HEAD) while (0)
>
> -static struct hlist_head *get_heads(bool is_mutable)
> +static struct security_hook_heads *get_heads(bool is_mutable)
>  {
>         if (is_mutable)
>                 return ERR_PTR(-EINVAL);
> -       return (struct hlist_head *)&security_hook_heads;
> +       return &security_hook_heads;
>  }
>  #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
>
> @@ -129,8 +126,7 @@ static inline void synchronize_lsm(void)
>
>  /**
>   * security_delete_hooks - Remove modules hooks from the mutable hooks lists.
> - * @hooks: the hooks to remove
> - * @count: the number of hooks to remove
> + * @lsm: Module info,
>   *
>   * 0 is returned on success, otherwise -errno is returned on failure.
>   * If an error is returned, it is up to the LSM author to handle the error
> @@ -142,31 +138,29 @@ static inline void synchronize_lsm(void)
>   * authors check the return code here, and act appropriately. In most cases
>   * a failure should result in panic.
>   */
> -int __must_check security_delete_hooks(struct security_hook_list *hooks,
> -                                       int count)
> +int __must_check security_delete_hooks(struct lsm_info *lsm)
>  {
> -       int i, ret = 0;
> +       struct security_hook_list *hooks = lsm->hooks;
> +       const int count = lsm->count;
> +       int i, ret = -EPERM;
>
> -       mutex_lock(&security_hook_mutex);
> -       if (security_allow_unregister_hooks)
> +       if (mutex_lock_killable(&security_hook_mutex))
Why mutex_lock_killable?
> +               return -EINTR;
> +       if (security_allow_unregister_hooks) {
>                 for (i = 0; i < count; i++)
>                         hlist_del_rcu(&hooks[i].list);
> -       else
> -               ret = -EPERM;
> -       mutex_unlock(&security_hook_mutex);
> -
> -       if (!ret)
> +               list_del(&lsm->list);
>                 synchronize_lsm();
> +               ret = 0;
> +       }
Why put this in the mutex? It could hold the mutex for a very long
time if a bunch of long(er)-running callbacks are in place.
> +       mutex_unlock(&security_hook_mutex);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(security_delete_hooks);
>
>  static void lock_existing_hooks(void)
>  {
> -       struct hlist_head *list = (struct hlist_head *)
> -                                       &security_hook_heads_mutable;
> -       struct security_hook_list *P;
> -       int i;
> +       struct lsm_info *lsm;
>
>         /*
>          * Prevent module unloading while we're doing this
> @@ -174,10 +168,8 @@ static void lock_existing_hooks(void)
>          * is already unloading -- allow that.
>          */
>         mutex_lock(&module_mutex);
> -       for (i = 0; i < SECURITY_HOOK_COUNT; i++)
> -               hlist_for_each_entry(P, &list[i], list)
> -                       if (P->owner)
> -                               WARN_ON(!try_module_get(P->owner));
> +       list_foreach_entry(lsm, &registered_lsm_modules, list)
> +               try_module_get(lsm->owner);
>         mutex_unlock(&module_mutex);
>  }
>  #else
> @@ -198,16 +190,19 @@ static inline void synchronize_lsm(void) {}
>   * Only to be called by legacy code, like SELinux's delete hooks mechanism
>   * as it ignores whether or not allow_unregister_hooks is set.
>   */
> -void __security_delete_hooks(struct security_hook_list *hooks, int count)
> +void __security_delete_hooks(struct lsm_info *lsm)
>  {
>         int i;
> +       struct security_hook_list *hooks = lsm->hooks;
> +       const int count = lsm->count;
>
>         mutex_lock(&security_hook_mutex);
>         for (i = 0; i < count; i++)
>                 hlist_del_rcu(&hooks[i].list);
> +       list_del(&lsm->list);
> +       synchronize_lsm();
>         mutex_unlock(&security_hook_mutex);
>
> -       synchronize_lsm();
>  }
>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>
> @@ -314,7 +309,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>         return !strcmp(last, lsm);
>  }
>
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>         char *cp;
>
> @@ -358,41 +353,53 @@ int __init security_module_enable(const char *module)
>
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> - * @hooks: the hooks to add
> - * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsm: Module info,
>   * @is_mutable: True if dynamic registration and/or unregistration is needed.
>   *
>   * Each LSM has to register its hooks with the infrastructure.
>   * 0 is returned on success, otherwise -errno is returned on failure.
>   */
> -int __must_check security_add_hooks(struct security_hook_list *hooks,
> -                                       const int count, char *lsm,
> -                                       const bool is_mutable)
> +int __must_check security_add_hooks(struct lsm_info *lsm,
> +                                   const bool is_mutable)
>  {
> -       struct hlist_head *heads;
> -       int i, hook_idx, ret = 0;
> +       struct security_hook_heads *heads = get_heads(is_mutable);
> +       struct security_hook_list *hooks = lsm->hooks;
> +       const int count = lsm->count;
> +       int i, ret;
>
> -       mutex_lock(&security_hook_mutex);
> -       heads = get_heads(is_mutable);
> -       if (IS_ERR(heads)) {
> -               ret = PTR_ERR(heads);
> +       INIT_LIST_HEAD(&lsm->list);
Can't this happen in the macro to setup LSM_INFO?

> +       if (IS_ERR(heads))
> +               return PTR_ERR(heads);
> +       for (i = 0; i < count; i++) {
> +               unsigned int offset = hooks[i].offset;
> +
> +               if (offset % sizeof(struct hlist_head) ||
> +                   offset + sizeof(struct hlist_head) >
> +                   sizeof(struct security_hook_heads))
> +                       return -EINVAL;
> +       }
> +       if (!security_allow_unregister_hooks &&
> +           !try_module_get(lsm->owner))
> +               return -EINVAL;
What case is it okay if try_module_get fails? Won't this return
-EINVAL on built-in modules because lsm->owner is NULL?
> +       if (mutex_lock_killable(&security_hook_mutex)) {
> +               module_put(lsm->owner);
> +               return -EINTR;
> +       }
> +       ret = lsm_append(lsm->name, &lsm_names);
> +       if (ret) {
> +               module_put(lsm->owner);
>                 goto out;
>         }
> -
> +       list_add(&lsm->list, &registered_lsm_modules);
>         for (i = 0; i < count; i++) {
> -               hook_idx = hooks[i].hook_idx;
> -               hooks[i].lsm = lsm;
> -               hlist_add_tail_rcu(&hooks[i].list, &heads[hook_idx]);
> -               if (!security_allow_unregister_hooks && hooks[i].owner)
> -                       WARN_ON(!try_module_get(hooks->owner));
> -       }
> +               struct hlist_head *head = (struct hlist_head *)
> +                       (((char *) heads) + hooks[i].offset);
>
> -       if (lsm_append(lsm, &lsm_names) < 0)
> -               panic("%s - Cannot get memory.\n", __func__);
> -out:
> +               hooks[i].lsm = lsm->name;
> +               hlist_add_tail_rcu(&hooks[i].list, head);
> +       }
> + out:
>         mutex_unlock(&security_hook_mutex);
> -
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(security_add_hooks);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 72466eb..0140e2b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7090,6 +7090,9 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  #endif
>  };
>
> +static struct lsm_info selinux_module =
> +       LSM_MODULE_INIT("selinux", selinux_hooks);
> +
>  static __init int selinux_init(void)
>  {
>         const bool is_mutable = IS_ENABLED(CONFIG_SECURITY_SELINUX_DISABLE);
> @@ -7131,8 +7134,7 @@ static __init int selinux_init(void)
>
>         hashtab_cache_init();
>
> -       BUG_ON(security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> -                                       "selinux", is_mutable));
> +       BUG_ON(security_add_hooks(&selinux_module, is_mutable));
>
>         if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>                 panic("SELinux: Unable to register AVC netcache callback\n");
> @@ -7266,8 +7268,6 @@ static void selinux_nf_ip_exit(void)
>   * it not meant to be  used by new LSMs. Therefore, this is defined here, rather
>   * than in a shared header.
>   */
> -extern void __security_delete_hooks(struct security_hook_list *hooks,
> -                                       int count);
>  int selinux_disable(struct selinux_state *state)
>  {
>         if (state->initialized) {
> @@ -7286,7 +7286,7 @@ int selinux_disable(struct selinux_state *state)
>
>         selinux_enabled = 0;
>
> -       __security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> +       __security_delete_hooks(&selinux_module);
>
>         /* Try to destroy the avc node cache */
>         avc_disable();
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f69b4d9..6b9566e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4764,6 +4764,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>         LSM_HOOK_INIT(dentry_create_files_as, smack_dentry_create_files_as),
>  };
>
> +static struct lsm_info smack_module = LSM_MODULE_INIT("smack", smack_hooks);
>
>  static __init void init_smack_known_list(void)
>  {
> @@ -4842,8 +4843,7 @@ static __init int smack_init(void)
>         /*
>          * Register with LSM
>          */
> -       BUG_ON(security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack",
> -                                       false));
> +       BUG_ON(security_add_hooks(&smack_module, false));
>
>         return 0;
>  }
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 544a614..0917f71 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -528,6 +528,8 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>         LSM_HOOK_INIT(socket_sendmsg, tomoyo_socket_sendmsg),
>  };
>
> +static struct lsm_info tomoyo_module = LSM_MODULE_INIT("tomoyo", tomoyo_hooks);
> +
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
>
> @@ -543,8 +545,7 @@ static int __init tomoyo_init(void)
>         if (!security_module_enable("tomoyo"))
>                 return 0;
>         /* register ourselves with the security framework */
> -       BUG_ON(security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo",
> -                                       false));
> +       BUG_ON(security_add_hooks(&tomoyo_module, false));
>         printk(KERN_INFO "TOMOYO Linux initialized\n");
>         cred->security = &tomoyo_kernel_domain;
>         tomoyo_mm_init();
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 2e4bbb0..ee520b0 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -430,6 +430,8 @@ int yama_ptrace_traceme(struct task_struct *parent)
>         LSM_HOOK_INIT(task_free, yama_task_free),
>  };
>
> +static struct lsm_info yama_module = LSM_MODULE_INIT("yama", yama_hooks);
> +
>  #ifdef CONFIG_SYSCTL
>  static int yama_dointvec_minmax(struct ctl_table *table, int write,
>                                 void __user *buffer, size_t *lenp, loff_t *ppos)
> @@ -480,7 +482,6 @@ static inline void yama_init_sysctl(void) { }
>  void __init yama_add_hooks(void)
>  {
>         pr_info("Yama: becoming mindful.\n");
> -       BUG_ON(security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama",
> -                                       false));
> +       BUG_ON(security_add_hooks(&yama_module, false));
>         yama_init_sysctl();
>  }
> --
> 1.8.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
