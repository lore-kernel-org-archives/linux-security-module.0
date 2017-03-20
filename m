From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 20 Mar 2017 11:23:05 -0600
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
	<20170317161614.GA28082@obsidianresearch.com>
	<bca2bee3c1b84100ac72238425ac4791@MUCSE612.infineon.com>
	<12e63cdba1e34cac9b82e4bff9621ae6@MUCSE603.infineon.com>
Message-ID: <20170320172305.GA4990@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 20, 2017 at 09:54:41AM +0000, Alexander.Steffen at infineon.com wrote:
> >>> 2. When upgrading the firmware on my TPM, it switches to a
> >>> non-standard communication mode for the upgrade process and does not
> >>> communicate using TPM2.0 commands during this time. Rejecting
> >>> non-TPM2.0 commands means upgrading won't be possible anymore.
> >>
> >> How non standard? Is the basic header even there? Are the lengths and
> >> status code right?
> >>
> >> This might be an argument to add a 'raw' ioctl or something specifically
> >> for this special case.
> >
> > It follows the regular TPM command syntax and looks something like 1.2
> > commands.
> 
> Yep, so most of it already works with the current implementation.
> 
> There are a few special cases that need some thought though. For
> example, it is possible to use an upgrade to switch the TPM family
> from 1.2 to 2.0 (or vice versa). In this case it seems useful to let
> the kernel reinitialize the TPM driver, so it uses the correct
> timeouts for communication, activates the correct features (resource
> manager or not?), etc., without needing to reboot the system.

It would be nice to do this via plug/unplug with existing sysfs
machinery.

> Another problem arises when the upgrade process is interrupted,
> e.g. because power is lost. Then the TPM is stuck in its
> non-standard upgrade mode, so the kernel does not recognize it as a
> valid TPM device and does not export /dev/tpm<n>. But without the
> device node the upgrader is unable to restart the upgrade process,
> leaving the TPM forever inaccessible.

I guess you'd have to teach the TPM core about a new chip mode besides
1.2, 2.0 - some kind of 'upgrade' mode.

So the flow would be to send the upgrade command, unplug/replug the
driver to switch to 'upgrade' mode (which could happen if there was a
reboot?) do the upgrade, then unplug/replug to rediscover the 'new'
TPM.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
