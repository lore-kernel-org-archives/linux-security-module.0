From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 29 Jun 2018 13:35:52 +0300
Subject: [PATCH v8] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180628151333.14368-1-tomas.winkler@intel.com>
References: <20180628151333.14368-1-tomas.winkler@intel.com>
Message-ID: <53d76dcd02c69f207a2831f9ede55b867c7438b6.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-06-28 at 18:13 +0300, Tomas Winkler wrote:
> Fix tpm ptt initialization error:
> tpm tpm0: A TPM error (378) occurred get tpm pcr allocation.
> 
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides a power saving, it's also a part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> When calling from nested context always use both flags:
> TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both are needed to resolve
> tpm spaces and locality request recursive calls to tpm_transmit().
> TPM_TRANSMIT_RAW should never be used standalone as it will fail
> on double locking. While TPM_TRANSMIT_UNLOCKED standalone should be
> called from non-recursive locked contexts.
> 
> New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> streamline tpm_try_transmit code.
> 
> tpm_crb no longer needs own power saving functions and can drop using
> tpm_pm_suspend/resume.
> 
> This patch cannot be really separated from the locality fix.
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> 
> 
> Cc: stable at vger.kernel.org
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
