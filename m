From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Mar 2018 15:19:23 +0000
Subject: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
In-Reply-To: <1520339005.3779.3.camel@linux.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<20180306092503.11568-4-tomas.winkler@intel.com>
	<1520339005.3779.3.camel@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> > Rather than increasing default timeout a new constant is added, to not
> > stall for too long on regular commands failures.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> Why are you radically chaging the default timeout? The commit message
> does not tell anything about that change.
>
Let me, recheck but it should be same value just converted to msecs.
 
> Why couldn't we just have two timeouts: one default and one long that
> would be at least as long as the longest timeout defined in the spec?

I've tried to explain it in the commit message but apparently has failed. 

We have a default or undefined which should be the same as it was unless I did some silly mistake in conversion to msecs (will check), ass all others are in msecs.
It was 2 min = 2 * 60 * HZ (in jiffies) which would be msecs_to_jiffies(2 * 60 * 1000 = 120000) 
TPM2_DURATION_DEFAULT   = 120000

Then we have a new one which is 3 min just for key generation (Prime number generation is heavy liffting) 

> Then we would not have to ever update LAST_CC constant, we could actually
> remove it completely.

I believe I've removed it next patch, I didn???t want do too much in this one.

Thanks
Tomas

????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
