From: paul@paul-moore.com (Paul Moore)
Date: Wed, 30 May 2018 17:00:04 -0400
Subject: [PATCH v4 8/8] module: replace the existing LSM hook in
	init_module
In-Reply-To: <1527635645.3534.39.camel@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
	<CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
	<1527635645.3534.39.camel@linux.vnet.ibm.com>
Message-ID: <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 29, 2018 at 7:14 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Tue, 2018-05-29 at 18:39 -0400, Paul Moore wrote:
> [...]
>> > @@ -4043,6 +4037,25 @@ static int selinux_kernel_module_from_file(struct file *file)
>> >                                 SYSTEM__MODULE_LOAD, &ad);
>> >  }
>> >
>> > +static int selinux_kernel_load_data(enum kernel_load_data_id id)
>> > +{
>> > +       u32 sid;
>> > +       int rc = 0;
>> > +
>> > +       switch (id) {
>> > +       case LOADING_MODULE:
>> > +               sid = current_sid();
>> > +
>> > +               /* init_module */
>> > +               return avc_has_perm(&selinux_state, sid, sid, SECCLASS_SYSTEM,
>> > +                                   SYSTEM__MODULE_LOAD, NULL);
>> > +       default:
>> > +               break;
>> > +       }
>> > +
>> > +       return rc;
>> > +}
>>
>> I'm not a fan of the duplication here.  If we must have a new LSM hook
>> for this, can we at least have it call
>> selinux_kernel_module_from_file() so we have all the kernel module
>> loading logic/controls in one function?  Yes, I understand there are
>> differences between init_module() and finit_module() but I like
>> handling them both in one function as we do today.
>
> There's some disagreement as to whether we really need two LSM hooks.
>  This sounds like you would prefer a single LSM hook, not the two that
> this patch set introduces.
>
> We need to come to some consensus.  (Comments appreciated in 0/8.)

My comments were intentionally made on the SELinux specific code and
not the LSM generic code/hooks.  As the LSM hook code must not make
any assumptions about the underlying LSM implementations, it may make
sense to have two different hooks.  However as far as the SELinux code
is concerned I would rather keep the access controls in one function
as mentioned above.  From a purely selfish SELinux perspective I would
prefer a single hook, but if others feel two hooks are better, that's
fine with me too.

>> >  static int selinux_kernel_read_file(struct file *file,
>> >                                     enum kernel_read_file_id id)
>> >  {
>> > @@ -6950,6 +6963,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>> >         LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>> >         LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
>> >         LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
>> > +       LSM_HOOK_INIT(kernel_load_data, selinux_kernel_load_data),
>> >         LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
>> >         LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>> >         LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>> > --
>> > 2.7.5

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
