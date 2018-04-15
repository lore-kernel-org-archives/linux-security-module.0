From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 15 Apr 2018 21:03:56 +0900
Subject: [PATCH v6 1/1] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <CAMp4zn-RTuG_8=NzaY6+F1RyvD8TfxmwzREoVkjS7kshZ8Ms6A@mail.gmail.com>
References: <cover.1523558422.git.sargun@sargun.me>
	<e75b87694dbd28b9e36bf1d53083e9ffb95a4c2f.1523558422.git.sargun@sargun.me>
	<201804132313.HDH87504.MOVLOFFQJtOSHF@I-love.SAKURA.ne.jp>
	<CAMp4zn-RTuG_8=NzaY6+F1RyvD8TfxmwzREoVkjS7kshZ8Ms6A@mail.gmail.com>
Message-ID: <201804152103.EFD05285.FFVFOJLHOMStOQ@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> On Fri, Apr 13, 2018 at 7:13 AM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > +#define LSM_MODULE_INIT(NAME, HOOKS)           \
> > +       {                                       \
> > +               .name = NAME,                   \
> > +               .hooks = HOOKS,                 \
> > +               .count = ARRAY_SIZE(HOOKS),     \
> > +               .owner = THIS_MODULE,           \
> > +       }
> > +
> > +extern int __must_check security_add_hooks(struct lsm_info *lsm,
> > +                                          const bool is_mutable);
> > +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> > +extern void __security_delete_hooks(struct lsm_info *lsm);
> > +#endif
> Why expose __security_delete_hooks in lsm_hooks.h? Given SELinux is
> the only consumer, and shouldn't be using it much longer, I think it
> makes sense to let it stay part of the SELinux hooks.c.

Because scripts/checkpatch.pl says so. In fact, I was puzzled by strange
NULL pointer dereference bug at list_del() in __security_delete_hooks(), for
the compiler did not find for me that I forgot to update the argument of
__security_delete_hooks() in security/selinux/hooks.c .



> > +int __must_check security_add_hooks(struct lsm_info *lsm,
> > +                                   const bool is_mutable)
> >  {
> > -       struct hlist_head *heads;
> > -       int i, hook_idx, ret = 0;
> > +       struct security_hook_heads *heads = get_heads(is_mutable);
> > +       struct security_hook_list *hooks = lsm->hooks;
> > +       const int count = lsm->count;
> > +       int i, ret;
> >
> > -       mutex_lock(&security_hook_mutex);
> > -       heads = get_heads(is_mutable);
> > -       if (IS_ERR(heads)) {
> > -               ret = PTR_ERR(heads);
> > +       INIT_LIST_HEAD(&lsm->list);
> Can't this happen in the macro to setup LSM_INFO?

Yes if the variable's name is passed into the LSM_MODULE_INIT() macro, for
LIST_HEAD_INIT() needs the variable's address.



> > +       if (IS_ERR(heads))
> > +               return PTR_ERR(heads);
> > +       for (i = 0; i < count; i++) {
> > +               unsigned int offset = hooks[i].offset;
> > +
> > +               if (offset % sizeof(struct hlist_head) ||
> > +                   offset + sizeof(struct hlist_head) >
> > +                   sizeof(struct security_hook_heads))
> > +                       return -EINVAL;
> > +       }
> > +       if (!security_allow_unregister_hooks &&
> > +           !try_module_get(lsm->owner))
> > +               return -EINVAL;
> What case is it okay if try_module_get fails? Won't this return
> -EINVAL on built-in modules because lsm->owner is NULL?

try_module_get(NULL) == true.



> > +int __must_check security_delete_hooks(struct lsm_info *lsm)
> >  {
> > -       int i, ret = 0;
> > +       struct security_hook_list *hooks = lsm->hooks;
> > +       const int count = lsm->count;
> > +       int i, ret = -EPERM;
> >
> > -       mutex_lock(&security_hook_mutex);
> > -       if (security_allow_unregister_hooks)
> > +       if (mutex_lock_killable(&security_hook_mutex))
> Why mutex_lock_killable?

If a function can fail safely, it is preferable to allow it be interrupted
when waiting for something.

By the way, how do you guarantee that security_delete_hooks() was called before
delete_module() request of that lsm module starts? Well, rereading your patch:

/**
 * security_delete_hooks - Remove modules hooks from the mutable hooks lists.
 * @hooks: the hooks to remove
 * @count: the number of hooks to remove
 *
 * 0 is returned on success, otherwise -errno is returned on failure.
 * If an error is returned, it is up to the LSM author to handle the error
 * appropriately. If they do not, their code could be unloaded, while
 * leaving dangling pointers.
 *
 * At best, this will cause a kernel oops. At worst case scenario, this can
 * lead to arbitrary code execution. Therefore, it is critical that module
 * authors check the return code here, and act appropriately. In most cases
 * a failure should result in panic.
 */

Your patch tries to prevent security_delete_hooks() from module_exit() function by
holding module_mutex when try_module_get() is called, doesn't it? And you leave
handling of CONFIG_MODULE_FORCE_UNLOAD=y kernels to the module authors when forced
unload is used, don't you? But what the authors can do when security_delete_hooks()
returned an error? They can do nothing other than calling panic(). I think that
security_delete_hooks() is effectively not allowed to fail...

By the way, did you test with CONFIG_PROVE_LOCKING=y? lock_existing_hooks() has
security_hook_mutex -> module_mutex dependency while init_module()/delete_module()
have module_mutex -> security_hook_mutex dependency?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
