From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 24 Oct 2017 11:04:44 -0700
Subject: [tpmdd-devel] [PATCH] tpm: remove chip_num parameter from
	in-kernel API
In-Reply-To: <20171024173757.GA1806@obsidianresearch.com>
References: <20171023123817.18559-1-jarkko.sakkinen@linux.intel.com>
	<cbcb78c6-fa36-32d3-891e-96544875d97c@linux.vnet.ibm.com>
	<20171023163139.GA17394@obsidianresearch.com>
	<20171024154440.3jeupmus43jcgbbz@linux.intel.com>
	<CANc+2y4TbkfPT3d_sBd0MbE7ZJ4F7Sfsfvdv9V6=63=tRpWn4A@mail.gmail.com>
	<20171024155526.GA32250@obsidianresearch.com>
	<CANc+2y6-P9MvjbL18h02SPwNMPyk4_cPFfL6LKHDXiKSHfv00A@mail.gmail.com>
	<20171024161118.GA348@obsidianresearch.com>
	<CAKdAkRT9sLux6S1qdd=j0nbXSBdnYGG_hvjny=ic0YJLVNnxzA@mail.gmail.com>
	<20171024173757.GA1806@obsidianresearch.com>
Message-ID: <20171024180444.aewqwgglfmb46h22@dtor-ws>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 24, 2017 at 11:37:57AM -0600, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2017 at 10:02:00AM -0700, Dmitry Torokhov wrote:
> > tpm-rng is abomination that should be kicked out as soon as possible.
> > It wrecks havoc with the power management (TPM chip drivers may go
> > into suspend state, but tpm_rng does not do any power management and
> > happily forwards requests to suspended hardware) and may be available
> > when there is no TPM at all yet (the drivers have not been probed yet,
> > or have gotten a deferral, etc).
> 
> Makes sense
> 
> > TPM core should register HWRNGs when chips are ready.
> 
> The main thing I've wanted from the TPM RNG is
> 'add_early_randomness'..

I see... However you can't add any randomness if hardware is not quite
there yet.

> 
> We can certainly provide a TPM interface to hwrng, it seems
> reasonable.
> 
> Excep that we already have a user api in /dev/tpm to access the
> tpm RNG, is the duplication a problem?

If we already have userspace API we have to maintain this, even if it is
duplicate, there is no way around it. I'd expect most of the users will
use unified random API, while some TPM-oriented users may still go via
/dev/tpm to use the same API as all other their requests.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
