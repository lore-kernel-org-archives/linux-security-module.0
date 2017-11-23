From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Thu, 23 Nov 2017 16:19:58 +0000
Subject: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <20171123144742.GC8862@swastik>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-3-nayna@linux.vnet.ibm.com>
	<5ef60315f2254b3b8bcc217a572280e5@infineon.com>
	<e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
	<3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
	<20171123144742.GC8862@swastik>
Message-ID: <74de457e7338449a957dc31c39de9ac1@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Wed, Nov 22, 2017 at 06:52:03AM +0000,
> Alexander.Steffen at infineon.com wrote:
> > > > > > This seems to fail reliably with my SPI TPM 2.0. I get EIO when trying
> to
> > > > > send large amounts of data, e.g. with TPM2_Hash, and subsequent
> tests
> > > > > seem to take an unusual amount of time. More analysis probably has
> to
> > > > wait
> > > > > until November, since I am going to be in Prague next week.
> > > > >
> > > > > Thanks Alex for testing these.. Did you get the chance to do any
> further
> > > > > analysis ?
> > > >
> > > > I am working on that now. Ken's suggestion seems reasonable, so I am
> > > going
> > > > to test whether correctly waiting for the flags to change fixes the
> problem.
> > > If
> > > > it does, I'll send the patches.
> > >
> > > Sorry for the delay, I had to take care of some device tree changes in
> v4.14
> > > that broke my ARM test machines.
> > >
> > > I've implemented some patches that fix the issue that Ken pointed out
> and
> > > rebased your patch 2/4 ("ignore burstcount") on top. While doing this I
> > > noticed that your original patch does not, as the commit message says,
> write
> > > all the bytes at once, but still unnecessarily splits all commands into at
> least
> > > two transfers (as did the original code). I've fixed this as well in my
> patches,
> > > so that all bytes are indeed sent in a single call, without special handling
> for
> > > the last byte. This should speed up things further, especially for small
> > > commands and drivers like tpm_tis_spi, where writing a single byte
> > > translates into additional SPI transfers.
> 
> Thanks Alex, for digging into.
> 
> Yeah, you are right, the first version of this patch sent all the bytes together,
> but after hearing ddwg inputs,
> i.e. "The last byte was introduced for error checking purposes (history).", I
> reverted back to original to be safe.
> 
> It seems that the last byte was sent from the beginning (27084ef [PATCH]
> tpm: driver for next generation TPM chips,),
> does anyone remember the reason ?

The intention seems to be to make extra sure that the TPM has correctly understood the command by observing the Expect flag flipping from 1 to 0 when writing the last byte.

But following Ken's arguments, this does not work as intended, because the Expect flag will change not when writing the last byte to the FIFO, but when the TPM reads the last byte from the FIFO. Since there is no "FIFO empty" indication, just observing the Expect flag to be 1 before writing the last byte, cannot reliably tell us anything (there might be enough data left in the FIFO for the Expect flag to flip to 0 without writing the last byte).

Also, I'd argue that this check is not necessary, because if the Expect flag is 0 after all bytes have been written to the FIFO, then the TPM has correctly received the command and is ready to execute it. According to TIS/PTP the TPM is required to throw away all extra bytes that were not announced in the header, and in addition the kernel driver already ensures not to send more data. That are enough safeguards, I'd say.

> 
> > >
> > > Unfortunately, even with those changes the problem persists. But I've
> got
> > > more detailed logs now and will try to understand and hopefully fix the
> issue.
> > > I'll follow up with more details and/or patches once I know more.
> >
> > Okay, so the problem seems to be that at some point the TPM starts
> inserting wait states for the FIFO access. The driver tries to handle this, but
> fails since even the 50 retries that are currently used do not seem to be
> enough. Adding small (millisecond) delays between the attempts did not
> help so far.
> >
> > Is there any limit in the specification for how many wait states the TPM may
> generate or for how long it may do so? I could not find anything, but we need
> to use something there to prevent a faulty TPM from blocking the kernel
> forever.
> >
> 
> I have been thinking on this, so was wondering:
> 
> 1. As you said the problem started while sending large amounts of data for
> TPM2_Hash, how large is "large" ? I mean did it work for some specific large
> values before failing.

Around 1k of data (the exact values are chosen randomly, and it failed many times), but I did not try to find a specific boundary. The interesting thing was that for this long command all SPI frames with the maximum payload of 64 bytes were accepted without wait states, but the last frame (with less than 64 bytes) caused the wait states.

> 2. Are these wait states limited to SPI, or does it happen on LPC as well?

I do not know for LPC because there the wait states are handled in hardware and I cannot trace the LPC signals.

> Thanks & Regards,
>    - Nayna
> 
> 
> > Alexander
> >
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
