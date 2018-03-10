From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 10 Mar 2018 13:21:16 +0200
Subject: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<20180306092503.11568-4-tomas.winkler@intel.com>
	<1520339005.3779.3.camel@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B9422F4C1@hasmsx108.ger.corp.intel.com>
Message-ID: <d00187b102355c74b5efc2f7923c441785a6390c.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 15:19 +0000, Winkler, Tomas wrote:
> > On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> > > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > > generation of crypto keys which can be a computationally intensive task.
> > > The timeout is set to 3min.
> > > Rather than increasing default timeout a new constant is added, to not
> > > stall for too long on regular commands failures.
> > > 
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > Why are you radically chaging the default timeout? The commit message
> > does not tell anything about that change.
> > 
> 
> Let me, recheck but it should be same value just converted to msecs.
>  
> > Why couldn't we just have two timeouts: one default and one long that
> > would be at least as long as the longest timeout defined in the spec?
> 
> I've tried to explain it in the commit message but apparently has failed. 
> 
> We have a default or undefined which should be the same as it was unless I did
> some silly mistake in conversion to msecs (will check), ass all others are in
> msecs.
> It was 2 min = 2 * 60 * HZ (in jiffies) which would be msecs_to_jiffies(2 * 60
> * 1000 = 120000) 
> TPM2_DURATION_DEFAULT   = 120000

Aah, of course :-) The problem was that I had somehow a blid spot with
seeing the msec_to_jiffies() conversion.

TPM_NUM_DURATIONS would a better name than TPM_DURATION_MAX because
TPM_DURATION_MAX is easy to confuse with TPM_DURATION_* constants.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
