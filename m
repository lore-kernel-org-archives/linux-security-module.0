From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 06 Mar 2018 14:23:25 +0200
Subject: [PATCH 3/5 V2] tpm2: add longer timeouts for creation commands.
In-Reply-To: <20180306092503.11568-4-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<20180306092503.11568-4-tomas.winkler@intel.com>
Message-ID: <1520339005.3779.3.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 11:25 +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> Rather than increasing default timeout a new constant is
> added, to not stall for too long on regular commands failures.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Why are you radically chaging the default timeout? The commit
message does not tell anything about that change.

Why couldn't we just have two timeouts: one default and one long that
would be at least as long as the longest timeout defined in the spec?
Then we would not have to ever update LAST_CC constant, we could
actually remove it completely.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
