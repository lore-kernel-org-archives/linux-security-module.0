From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 18 Apr 2017 14:54:32 +0200 (CEST)
Subject: [PATCH 06/38] Annotate hardware config module parameters in
	drivers/clocksource/
In-Reply-To: <10505.1492519386@warthog.procyon.org.uk>
References: <alpine.DEB.2.20.1704151153280.2327@nanos>
	<alpine.DEB.2.20.1704150746530.2327@nanos>
	<alpine.DEB.2.20.1704142021320.2327@nanos>
	<149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141145858.29162.13072730133817038218.stgit@warthog.procyon.org.uk>
	<12228.1492210765@warthog.procyon.org.uk>
	<15283.1492235470@warthog.procyon.org.uk>
	<10505.1492519386@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.20.1704181451500.1659@nanos>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Apr 2017, David Howells wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > > > Btw, is it possible to use IRQ grants to prevent a device that has limited
> > > > > IRQ options from being drivable?
> > > > 
> > > > What do you mean with 'IRQ grants' ?
> > > 
> > > request_irq().
> > 
> > I still can't parse the sentence above. If request_irq() fails the device
> > initialization fails. If you request the wrong irq then request_irq() might
> > succeed but the device won't work.
> 
> I was talking about having using a driver to make request_irq() grant an irq
> to that driver so that another driver can't bind to its device because all its
> irq options are taken and the irqs can't be shared.

Yes. That's possible.

init_driver1()
	request_irq(X, flags,.....);

init_driver2()
	request_irq(X, flags,.....);

The second driver can fail, when flags are not matching. That might be
disagreement about SHARED or the trigger type, i.e. egde vs. level.

Thanks,

	tglx



       
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
