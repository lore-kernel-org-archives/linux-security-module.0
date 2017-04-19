From: dhowells@redhat.com (David Howells)
Date: Wed, 19 Apr 2017 16:33:05 +0100
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <alpine.DEB.2.20.1704142021320.2327@nanos>
References: <alpine.DEB.2.20.1704142021320.2327@nanos>
	<149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
Message-ID: <25653.1492615985@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> wrote:

> > --- a/drivers/clocksource/cs5535-clockevt.c
> > +++ b/drivers/clocksource/cs5535-clockevt.c
> > @@ -22,7 +22,7 @@
> >  #define DRV_NAME "cs5535-clockevt"
> >  
> >  static int timer_irq;
> > -module_param_named(irq, timer_irq, int, 0644);
> > +module_param_hw_named(irq, timer_irq, int, irq, 0644);
> >  MODULE_PARM_DESC(irq, "Which IRQ to use for the clock source MFGPT ticks.");
> 
> I'm not sure about this. AFAIR the parameter is required to work on
> anything else than some arbitrary hardware which has it mapped to 0.
> 
> Cc'ed people who might know.

Given what Jens said:

	Parameter defaults to 0, which means:
	1. autodetect (=keep IRQ BIOS has set up)
	2. if that fails use CONFIG_CS5535_MFGPT_DEFAULT_IRQ
	(see drivers/misc/cs5535-mfgpt.c: cs5535_mfgpt_set_irq())

	Autodetect works fine for our (ex-LiPPERT, now ADLINK) COTS boards:
	Linux auto-uses IRQ chosen in BIOS Setup. Wouldn't know about other
	companies, of course, but (2.) means parameter can be avoided via make
	menuconfig.

are you willing to okay this?

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
