From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 19 Mar 2018 11:37:35 +0200
Subject: [PATCH 3/5 V3] tpm2: add longer timeouts for creation commands.
In-Reply-To: <20180310151545.22237-1-tomas.winkler@intel.com>
References: <20180310151545.22237-1-tomas.winkler@intel.com>
Message-ID: <20180319093735.GA4587@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 10, 2018 at 05:15:45PM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> Rather than increasing default timeout a new constant is
> added, to not stall for too long on regular commands failures.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

PS. Please format the long description properly. Now the lines cut from
weird places. I use gq command in Vim to get that done. The description
itself is nice and concise.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
