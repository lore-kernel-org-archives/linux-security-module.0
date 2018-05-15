From: jwboyer@kernel.org (Josh Boyer)
Date: Tue, 15 May 2018 08:32:55 -0400
Subject: [PATCH 3/6] firmware: differentiate between signed regulatory.db
	and other firmware
In-Reply-To: <20180515032656.GR27853@wotan.suse.de>
References: <20180509212212.GX27853@wotan.suse.de>
	<1525903617.3551.281.camel@linux.vnet.ibm.com>
	<20180509234814.GY27853@wotan.suse.de>
	<1525917658.3551.322.camel@linux.vnet.ibm.com>
	<20180510232639.GF27853@wotan.suse.de>
	<1526014826.3414.46.camel@linux.vnet.ibm.com>
	<20180511215250.GJ27853@wotan.suse.de>
	<1526302692.3898.145.camel@linux.vnet.ibm.com>
	<20180514192853.GM27853@wotan.suse.de>
	<1526349751.3937.78.camel@linux.vnet.ibm.com>
	<20180515032656.GR27853@wotan.suse.de>
Message-ID: <CA+5PVA7QU0k91zvoBTAFzG+unkh-=-s9Lhk3hn3eTJhHo4ovCQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 14, 2018 at 11:27 PM Luis R. Rodriguez <mcgrof@kernel.org>
wrote:

> On Mon, May 14, 2018 at 10:02:31PM -0400, Mimi Zohar wrote:
> > On Mon, 2018-05-14 at 19:28 +0000, Luis R. Rodriguez wrote:
> > > > - CONFIG_IMA_APPRAISE is not fine enough grained.
> > > >
> > > > The CONFIG_IMA_APPRAISE_FIRMWARE will be a Kconfig option.  Similar
> > > > Kconfig options will require kernel modules, kexec'ed image, and the
> > > > IMA policy to be signed.
> > >
> > > Sure, it is still unclear to me if CONFIG_IMA_APPRAISE_FIRMWARE will
be
> > > doing firmware verification in userspace or in the kernel.
> >
> > The kernel is verifying signatures.
> >
> > > > There are a number of reasons that the kernel should be verifying
> > > > firmware signatures (eg. requiring a specific version of the
firmware,
> > > > that was locally signed).
> > >
> > > Oh I agree, Linux enterprise distributions also have a strong reason
to
> > > have this, so that for instance we only trust and run vendor-approved
> > > signed firmware. Otherwise the driver should reject the firmware.
Every
> > > now and then enterprise distros may run into cases were certain
customers
> > > may run oddball firmwares, and its unclear if we expect proper
functionality
> > > with that firmware. Having some form of firmware signing would help
with
> > > this pipeline, but this is currently dealt with at the packaging, and
> > > noting other than logs ensures the driver is using an intended
firmware.
> > > But these needs *IMHO* have not been enough to push to generalize a
kernel
> > > firmware signing facility.
> >
> > In order for IMA-appraisal to verify firmware signatures, the
> > signatures need to be distributed with the firmware.  Perhaps this
> > will be enough of an incentive for distros to start including firmware
> > signatures in the packages.

> Best to poke the maintainers about that... We have been sending mixed
messages
> about firmware signing over years now. Josh, heads up the new one is we
can
> do firmware signing through IMA future CONFIG_IMA_APPRAISE_FIRMWARE. I'll
> bounce you a few emails related to this.

> > > If CONFIG_IMA_APPRAISE_FIRMWARE is going to provide this
functionality somehow
> > > I'm happy to hear it.
> >
> > The functionality has been there since commit 5a9196d ("ima: add
> > support for measuring and appraising firmware").  The
> > security_kernel_fw_from_file() hook was later replaced with the
> > generic security_kernel_read_file() hook.

> Groovy, its unclear from the code on that commit how this is done, so I
> suppose I need to study this a bit more. Josh, do you grok it?

I haven't looked to be honest.  I don't do much in the way of kernel
maintenance on the distro side any longer.  You already have David copied
and I've added Justin Forbes and Laura Abbott to cover Fedora.

One aspect that was always a concern to some is whether the firmware files
were modified directly to have the signature attached to them.  That may
run afoul of the "no modification" license that most blobs are shipped
under.  Does IMA have the signatures for the files stored in xattrs or in
some other detached manner?

josh
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
