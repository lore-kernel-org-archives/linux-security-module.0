From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 8 Nov 2017 21:09:16 +0100
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <1510171269.4484.26.camel@linux.vnet.ibm.com>
References: <1509660086.3416.15.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
	<1509660641.3416.24.camel@linux.vnet.ibm.com>
	<20171107230700.GJ22894@wotan.suse.de>
	<1510171269.4484.26.camel@linux.vnet.ibm.com>
Message-ID: <20171108200916.GF22894@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 08, 2017 at 03:01:09PM -0500, Mimi Zohar wrote:
> 
> > > Or reflect that IMA-appraisal, if enabled, will enforce firmware being
> > > validly signed.
> > 
> > But FWICT lockdown is a built-in kernel thingy, unless lockdown implies IMA
> > it would not be the place to refer to it.
> > 
> > It seems the documentation was proposed to help users if an error was caught.
> > That error should cover only what is being addressed in code on the kernel.
> 
> Enabling "lockdown" needs to take into account IMA-appraisal to
> prevent breaking systems with it enabled.
> 
> An IMA builtin "secure_boot" policy was already upstreamed (commit
> 503ceaef8e2e "ima: define a set of appraisal rules requiring file
> signatures"). ?An additional patch, automatically enables the
> "secure_boot" policy in "lockdown" mode.
> 
> Refer to this discussion and patch:
> http://kernsec.org/pipermail/linux-security-module-archive/2017-October/003913.html
> http://kernsec.org/pipermail/linux-security-module-archive/2017-October/003910.html

Ah then yeah this makes sense to mesh into the lock down documentation.

 Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
