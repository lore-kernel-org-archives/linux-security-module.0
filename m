From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 14 Apr 2017 20:25:12 +0200 (CEST)
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
References: <149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704142021320.2327@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 5 Apr 2017, David Howells wrote:

$subject == crap

> When the kernel is running in secure boot mode, we lock down the kernel to
> prevent userspace from modifying the running kernel image.  Whilst this
> includes prohibiting access to things like /dev/mem, it must also prevent
> access by means of configuring driver modules in such a way as to cause a
> device to access or modify the kernel image.
> 
> To this end, annotate module_param* statements that refer to hardware
> configuration and indicate for future reference what type of parameter they
> specify.  The parameter parser in the core sees this information and can
> skip such parameters with an error message if the kernel is locked down.
> The module initialisation then runs as normal, but just sees whatever the
> default values for those parameters is.
> 
> Note that we do still need to do the module initialisation because some
> drivers have viable defaults set in case parameters aren't specified and
> some drivers support automatic configuration (e.g. PNP or PCI) in addition
> to manually coded parameters.
> 
> This patch annotates drivers in drivers/clocksource/.

Sigh.

> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> cc: Thomas Gleixner <tglx@linutronix.de>
> cc: linux-kernel at vger.kernel.org
> ---
> 
>  drivers/clocksource/cs5535-clockevt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/cs5535-clockevt.c b/drivers/clocksource/cs5535-clockevt.c
> index 9a7e37cf56b0..a1df588343f2 100644
> --- a/drivers/clocksource/cs5535-clockevt.c
> +++ b/drivers/clocksource/cs5535-clockevt.c
> @@ -22,7 +22,7 @@
>  #define DRV_NAME "cs5535-clockevt"
>  
>  static int timer_irq;
> -module_param_named(irq, timer_irq, int, 0644);
> +module_param_hw_named(irq, timer_irq, int, irq, 0644);
>  MODULE_PARM_DESC(irq, "Which IRQ to use for the clock source MFGPT ticks.");

I'm not sure about this. AFAIR the parameter is required to work on
anything else than some arbitrary hardware which has it mapped to 0.

Cc'ed people who might know.

Thanks,

	tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
