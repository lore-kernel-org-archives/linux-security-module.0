From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 10 Jan 2018 18:08:23 +0200
Subject: [GIT PULL] tpmdd updates for v4.16
In-Reply-To: <1b81847f-123f-ea9e-f2e5-48c73174c8b2@infineon.com>
References: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
	<1b81847f-123f-ea9e-f2e5-48c73174c8b2@infineon.com>
Message-ID: <20180110160823.4jco3foc4afxbtl2@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 09, 2018 at 10:59:07AM +0100, Alexander Steffen wrote:
> On 08.01.2018 12:18, Jarkko Sakkinen wrote:
> > Hi James,
> > 
> > Sorry for a late PR.
> > 
> > Summary of the content:
> > 
> > * Reduced polling delays in tpm_tis.
> > * Support for retrieving TPM 2.0 Event Log through EFI before
> >    ExitBootServices.
> > * Replaced tpm-rng.c with a hwrng device managed by the driver for each
> >    TPM device.
> > * TPM resource manager synthesizes TPM_RC_COMMAND_CODE response instead
> >    of returning -EINVAL for unknown TPM commands. This makes user space
> >    more sound.
> > * CLKRUN fixes:
> >    * Keep #CLKRUN disable through the entier TPM command/response flow.
> >    * Check whether #CLKRUN is enabled before disabling and enabling it
> >      again because enabling it breaks PS/2 devices on a system where it
> >      is disabled.
> 
> I just spent some time trying to run all that (tpmdd-next-20180108) through
> my test system and hit a couple of non-TPM problems. In case you see similar
> issues, this is what I found out:
> 
> 1. rmmod for the TPM driver hangs indefinitely. The TPM driver now registers
> itself as a hwrng, but in case it is the only hwrng in a system, the call to
> hwrng_unregister never returns. Known bug, but still not fixed in 4.15-rc7
> (see https://www.mail-archive.com/linux-crypto at vger.kernel.org/msg29884.html
> for details).
> 
> 2. Raspberry Pis (which I use to test tpm_tis_spi and
> tpm_i2c_infineon) boot with that kernel, but have no USB or ethernet
> support. Also a known problem
> (http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/552280.html).
> 
> 3. Device tree overlays with references to non-existent target-paths are
> rejected now (whereas before the invalid parts were just ignored). I guess
> this is an intentional change, but the error message does not really point
> to the problem (applying the overlay just returns with EINVAL).

Do we have these?

> With all that fixed in my environment, my tests now pass successfully.
> 
> Alexander

Thank you for reporting these issues.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
