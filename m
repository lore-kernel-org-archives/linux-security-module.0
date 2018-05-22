From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 22 May 2018 12:17:32 +0300
Subject: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180516194600.28189-1-tomas.winkler@intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
Message-ID: <20180522091732.GA5228@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is abused to
> resolve tpm spaces recursive calls to tpm_transmit().

This looks good and all but I don't think we want to abuse anything in
the driver code, do we?

In other words, either

1. New flag is to be added.
2. Rename the existing flag to something else than UNLOCKED (perhaps
   SPACE).

 /Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
