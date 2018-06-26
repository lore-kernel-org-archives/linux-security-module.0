From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 26 Jun 2018 21:15:45 +0000
Subject: [PATCH v7] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
References: <20180624205202.6597-1-tomas.winkler@intel.com>
	<19b4282d625e04bb391f497419283a191bca610d.camel@linux.intel.com>
	<cb7ecb912486ee3e504de7c0918d667ebd370080.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D954923@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> 
> On Mon, 2018-06-25 at 19:24 +0300, Jarkko Sakkinen wrote:
> > On Sun, 2018-06-24 at 23:52 +0300, Tomas Winkler wrote:
> > > Fix tpm ptt initialization error:
> > > tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> > >
> > > We cannot use go_idle cmd_ready commands via runtime_pm handles as
> > > with the introduction of localities this is no longer an optional
> > > feature, while runtime pm can be not enabled.
> > > Though cmd_ready/go_idle provides a power saving, it's also a part
> > > of
> > > TPM2 protocol and should be called explicitly.
> > > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > > runtime pm support as it is not used by any driver.
> > >
> > > A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which implies
> > > TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed
> to
> > > resolve tpm spaces and locality request recursive calls to tpm_transmit().
> > >
> > > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > > streamline tpm_try_transmit code.
> > >
> > > tpm_crb no longer needs own power saving functions and can drop
> > > using tpm_pm_suspend/resume.
> > >
> > > This patch cannot be really separated from the locality fix.
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting
> > > locality)
> > >
> > > Cc: stable at vger.kernel.org
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting
> > > locality)
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> >
> > Please:
> >
> > 1. Remove NESTED.
> > 2. Where you need call RAW | UNLOCKED.
> > 3. Do not add __ prefix.
> 
> Right now if I really put head into this I can understand the logic but it is a
> complete mess.

I think what is the mess is that we have a recursive call to tpm_transmit topped with retries.  All other mess is just the result of that.

>I will forgot the dependencies between flags within few
> weeks. 
Hope the reasons are well documented both in code and the commit message, if not let's address that. We really cannot depend on one's memory.
It's not like I'm not striving for simplest possible code. 

>A fixed requirement (so that you know) is that they must be
> independent.
The flags (hope this what you referring here to) are not independent and weren't before, (RAW cannot be called alone as you will have double locking) putting them under one name just should make it clear. 
I beg you to go over the  code one more time, don't get stuck with flags names, maybe you even discover some real issue. 

Thanks
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
