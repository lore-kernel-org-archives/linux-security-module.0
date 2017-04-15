From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 15 Apr 2017 07:49:33 +0200 (CEST)
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <12228.1492210765@warthog.procyon.org.uk>
References: <alpine.DEB.2.20.1704142021320.2327@nanos>
	<149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
	<12228.1492210765@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704150746530.2327@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 14 Apr 2017, David Howells wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > -module_param_named(irq, timer_irq, int, 0644);
> > > +module_param_hw_named(irq, timer_irq, int, irq, 0644);
> > >  MODULE_PARM_DESC(irq, "Which IRQ to use for the clock source MFGPT ticks.");
> > 
> > I'm not sure about this. AFAIR the parameter is required to work on
> > anything else than some arbitrary hardware which has it mapped to 0.
> 
> Should it then be set through in-kernel platform initialisation since the
> AMD Geode is an embedded chip?

I think so. 

> Btw, is it possible to use IRQ grants to prevent a device that has limited IRQ
> options from being drivable?

What do you mean with 'IRQ grants' ?

Thanks

	tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
