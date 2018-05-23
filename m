From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Wed, 23 May 2018 13:48:17 +0000
Subject: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180523131616.GD363@linux.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
	<20180522091732.GA5228@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
	<20180523131616.GD363@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D8A1269@hasmsx109.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Tue, May 22, 2018 at 09:27:46AM +0000, Winkler, Tomas wrote:
> > >
> > > On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle()
> wrappers
> > > > to streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag
> is
> > > abused
> > > > to resolve tpm spaces recursive calls to tpm_transmit().
> > >
> > > This looks good and all but I don't think we want to abuse anything
> > > in the driver code, do we?
> >
> > It's not abuse just the flag UNLOCKED is not really named correctly I
> > think this has to be backported so wanted to do less invasive change.
> 
> It should be renamed anyway and possible merge conflicts are not hard to
> sort out in this change. Can you rename it as SPACE?

Not sure, I believe UNLOCKED is still better name than SPACE, I'm not sure this is 
Do you also want to remove TPM_TRANSMIT_RAW? 
clk_enable is handling its own anti recursion counter 'data->clkrun_enabled' 
but it should be all handled under one flag I guess.

> Right, and even without rename this will probably cause merge conflicts at
> least in v4.4 an v4.9 since in-kernel RM landed in v4.12, so not much gain not
> do the rename :-)

I belive we should do minimal change and the big cleanup after that.
Not sure, I believe UNLOCKED is still better name than SPACE even it wasn't the original intention.  
No the SPACE is the issue, but any recursion call into tpm_transmit. A bigger change is needed
and rename to SPACE would be just another intermediat change.

Please reconsider.

Thanks
Tomas 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
