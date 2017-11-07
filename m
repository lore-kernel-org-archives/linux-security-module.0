From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 8 Nov 2017 00:07:00 +0100
Subject: Firmware signing -- Re: [PATCH 00/27] security, efi: Add kernel
	lockdown
In-Reply-To: <1509660641.3416.24.camel@linux.vnet.ibm.com>
References: <1509660086.3416.15.camel@linux.vnet.ibm.com>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<14219.1509660259@warthog.procyon.org.uk>
	<1509660641.3416.24.camel@linux.vnet.ibm.com>
Message-ID: <20171107230700.GJ22894@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Nov 02, 2017 at 06:10:41PM -0400, Mimi Zohar wrote:
> On Thu, 2017-11-02 at 22:04 +0000, David Howells wrote:
> > Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > 
> > > > Only validly signed device firmware may be loaded.
> > > 
> > > fw_get_filesystem_firmware() calls kernel_read_file_from_path() to
> > > read the firmware, which calls into the security hooks. Is there
> > > another place that validates the firmware signatures. ?I'm not seeing
> > > which patch requires firmware to be signed?
> > 
> > Luis has a set of patches for this.  However, I'm not sure if that's going
> > anywhere at the moment.  Possibly I should remove this from the manpage for
> > the moment.

Remove it for now. The state of of affairs for firmware signing is complex given
that we first wanted to address how to properly grow the API without making
the API worse. This in and of itself was an effort, and that effort also
evaluated two different development paradigms:

	o functional API
	o data driven API

I only recently was convinced that functional API should be used, even for
commonly used exported symbols, and as such I've been going back and slowly
grooming the firmware API with small atomic changes to first clean up the
complex flag mess we have.

Since I'm busy with that Takahiro AKASHI has taken up firmware singing effort
but this will depend on the above small cleanup to be done first. I was busy
with addressing existing bugs on the firmware API for a while, then company
travel / conferences so was not able to address this, but I'm back now and
I believe I should be able to tackle the cleanup now.

Only after this is merged can we expect a final respin of the firmware signing
effort.

> Or reflect that IMA-appraisal, if enabled, will enforce firmware being
> validly signed.

But FWICT lockdown is a built-in kernel thingy, unless lockdown implies IMA
it would not be the place to refer to it.

It seems the documentation was proposed to help users if an error was caught.
That error should cover only what is being addressed in code on the kernel.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
