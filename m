From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 22 May 2018 09:27:46 +0000
Subject: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180522091732.GA5228@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
	<20180522091732.GA5228@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> > streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is
> abused
> > to resolve tpm spaces recursive calls to tpm_transmit().
> 
> This looks good and all but I don't think we want to abuse anything in the
> driver code, do we?

It's not abuse just the flag UNLOCKED is not really named correctly 
I think this has to be backported so wanted to do less invasive change.
> 
> In other words, either
> 
> 1. New flag is to be added.
No
> 2. Rename the existing flag to something else than UNLOCKED (perhaps
>    SPACE).


Currently both TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW  servers the same purpose, to resolve
the recursion in tpm tranmit. 
What I believe should be done is to split the function into two to eliminate recursive call instead of using flags.
Please also there is clock_enable which is not protected from double call.
Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
