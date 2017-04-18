From: dhowells@redhat.com (David Howells)
Date: Tue, 18 Apr 2017 13:38:26 +0100
Subject: [PATCH 02/38] Annotate hardware config module parameters in
	arch/x86/mm/
In-Reply-To: <alpine.DEB.2.20.1704142007590.2327@nanos>
References: <alpine.DEB.2.20.1704142007590.2327@nanos>
	<149141141298.29162.5612793122429261720.stgit@warthog.procyon.org.uk>
	<149141142839.29162.10470212173396183651.stgit@warthog.procyon.org.uk>
Message-ID: <10432.1492519106@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:

> > -module_param(mmio_address, ulong, 0);
> > +module_param_hw(mmio_address, ulong, iomem, 0);
> >  MODULE_PARM_DESC(mmio_address, " Start address of the mapping of 16 kB "
> >  				"(or 8 MB if read_far is non-zero).");
> 
> The copied boilerplate above is really nonsensical here. The default
> address is 0, so the init function will emit:
> 
>      pr_err("you have to use the module argument mmio_address.\n");
>      pr_err("DO NOT LOAD THIS MODULE UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!\n");
> 
> Pretty useless when you can't supply a valid address.
> 
>        if (kernel_locked_down()) {
>        		pr_info("This is not allowed because ...");
> 		return -EPERM;
>        }
> 
> would make too much sense for the user, right?

In some drivers, this would be wrong - ipmi, for example - and we've already
been through this.  The hwparam series of patches annotates *all*
ioport/iomem/irq/dma specifiers unconditionally.  The hwparam series is the
way it is is because this has no overhead if it's not used - and also has the
potentially useful side effect of making such parameters greppable.

It may well make sense to add your above suggestion also - but in the other
patch series.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
