From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Thu, 23 Nov 2017 20:17:42 +0530
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
Message-ID: <20171123144742.GC8862@swastik>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 22, 2017 at 06:52:03AM +0000, Alexander.Steffen at infineon.com wrote:
> > > > > This seems to fail reliably with my SPI TPM 2.0. I get EIO when trying to
> > > > send large amounts of data, e.g. with TPM2_Hash, and subsequent tests
> > > > seem to take an unusual amount of time. More analysis probably has to
> > > wait
> > > > until November, since I am going to be in Prague next week.
> > > >
> > > > Thanks Alex for testing these.. Did you get the chance to do any further
> > > > analysis ?
> > >
> > > I am working on that now. Ken's suggestion seems reasonable, so I am
> > going
> > > to test whether correctly waiting for the flags to change fixes the problem.
> > If
> > > it does, I'll send the patches.
> > 
> > Sorry for the delay, I had to take care of some device tree changes in v4.14
> > that broke my ARM test machines.
> > 
> > I've implemented some patches that fix the issue that Ken pointed out and
> > rebased your patch 2/4 ("ignore burstcount") on top. While doing this I
> > noticed that your original patch does not, as the commit message says, write
> > all the bytes at once, but still unnecessarily splits all commands into at least
> > two transfers (as did the original code). I've fixed this as well in my patches,
> > so that all bytes are indeed sent in a single call, without special handling for
> > the last byte. This should speed up things further, especially for small
> > commands and drivers like tpm_tis_spi, where writing a single byte
> > translates into additional SPI transfers.

Thanks Alex, for digging into.

Yeah, you are right, the first version of this patch sent all the bytes together, but after hearing ddwg inputs,
i.e. "The last byte was introduced for error checking purposes (history).", I reverted back to original to be safe.

It seems that the last byte was sent from the beginning (27084ef [PATCH] tpm: driver for next generation TPM chips,),
does anyone remember the reason ?

> > 
> > Unfortunately, even with those changes the problem persists. But I've got
> > more detailed logs now and will try to understand and hopefully fix the issue.
> > I'll follow up with more details and/or patches once I know more.
> 
> Okay, so the problem seems to be that at some point the TPM starts inserting wait states for the FIFO access. The driver tries to handle this, but fails since even the 50 retries that are currently used do not seem to be enough. Adding small (millisecond) delays between the attempts did not help so far.
> 
> Is there any limit in the specification for how many wait states the TPM may generate or for how long it may do so? I could not find anything, but we need to use something there to prevent a faulty TPM from blocking the kernel forever.
> 

I have been thinking on this, so was wondering:

1. As you said the problem started while sending large amounts of data for TPM2_Hash, how large is "large" ? I mean did it work for some specific large values before failing.
2. Are these wait states limited to SPI, or does it happen on LPC as well?

Thanks & Regards,
   - Nayna


> Alexander
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
