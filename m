From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 19 Oct 2017 10:20:26 -0700
Subject: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
In-Reply-To: <150842464774.7923.7951986297563109339.stgit@warthog.procyon.org.uk>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842464774.7923.7951986297563109339.stgit@warthog.procyon.org.uk>
Message-ID: <97659d0c-6992-3025-0f85-819d23e954cc@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/19/17 07:50, David Howells wrote:
> From: Kyle McMartin <kyle@redhat.com>
> 
> Make an option to provide a sysrq key that will lift the kernel lockdown,
> thereby allowing the running kernel image to be accessed and modified.
> 
> On x86_64 this is triggered with SysRq+x, but this key may not be available
> on all arches, so it is set by setting LOCKDOWN_LIFT_KEY in asm/setup.h.
> 
> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: x86 at kernel.org
> ---
> 
>  arch/x86/include/asm/setup.h |    2 ++
>  drivers/input/misc/uinput.c  |    1 +
>  drivers/tty/sysrq.c          |   19 +++++++++++------
>  include/linux/input.h        |    5 ++++
>  include/linux/sysrq.h        |    8 ++++++-
>  kernel/debug/kdb/kdb_main.c  |    2 +-
>  security/Kconfig             |   15 +++++++++++++
>  security/lock_down.c         |   48 ++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 92 insertions(+), 8 deletions(-)

> diff --git a/security/Kconfig b/security/Kconfig
> index 8e01fd59ae7e..4be6be71e075 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -213,6 +213,21 @@ config LOCK_DOWN_KERNEL
>  	  turns off various features that might otherwise allow access to the
>  	  kernel image (eg. setting MSR registers).
>  
> +config ALLOW_LOCKDOWN_LIFT
> +	bool
> +	help
> +	  Allow the lockdown on a kernel to be lifted, thereby restoring the
> +	  ability of userspace to access the kernel image (eg. by SysRq+x under

how about:                                                                on

> +	  x86).
> +
> +config ALLOW_LOCKDOWN_LIFT_BY_SYSRQ
> +	bool "Allow the kernel lockdown to be lifted by SysRq"
> +	depends on MAGIC_SYSRQ
> +	help
> +	  Allow the lockdown on a kernel to be lifted, by pressing a SysRq key
> +	  combination on a wired keyboard.
> +
> +
>  source security/selinux/Kconfig
>  source security/smack/Kconfig
>  source security/tomoyo/Kconfig
> diff --git a/security/lock_down.c b/security/lock_down.c
> index d8595c0e6673..f71118c340d2 100644
> --- a/security/lock_down.c
> +++ b/security/lock_down.c


> +
> +/*
> + * Allow lockdown to be lifted by pressing something like SysRq+x (and not by
> + * echoing the appropriate letter into the sysrq-trigger file).
> + */
> +#ifdef CONFIG_ALLOW_LOCKDOWN_LIFT_BY_KEY

is that the same as: CONFIG_ALLOW_LOCKDOWN_LIFT_BY_SYSRQ ?
tested?

> +
> +static void sysrq_handle_lockdown_lift(int key)
> +{
> +	if (kernel_locked_down)
> +		lift_kernel_lockdown();
> +}
> +
> +static struct sysrq_key_op lockdown_lift_sysrq_op = {
> +	.handler	= sysrq_handle_lockdown_lift,
> +	.help_msg	= "unSB(x)",
> +	.action_msg	= "Disabling Secure Boot restrictions",
> +	.enable_mask	= SYSRQ_DISABLE_USERSPACE,
> +};
> +
> +static int __init lockdown_lift_sysrq(void)
> +{
> +	if (kernel_locked_down) {
> +		lockdown_lift_sysrq_op.help_msg[5] = LOCKDOWN_LIFT_KEY;
> +		register_sysrq_key(LOCKDOWN_LIFT_KEY, &lockdown_lift_sysrq_op);
> +	}
> +	return 0;
> +}
> +
> +late_initcall(lockdown_lift_sysrq);
> +
> +#endif /* CONFIG_ALLOW_LOCKDOWN_LIFT_BY_KEY */

                                        BY_SYSRQ


-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
