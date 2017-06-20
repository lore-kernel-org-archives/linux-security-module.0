From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 Jun 2017 13:31:52 -0600
Subject: [PATCH] tpm: consolidate the TPM startup code
In-Reply-To: <20170620181334.28363-1-jarkko.sakkinen@linux.intel.com>
References: <20170620181334.28363-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170620193152.GA3368@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 20, 2017 at 08:13:34PM +0200, Jarkko Sakkinen wrote:
> Consolidated all the "manual" TPM startup code to a single function
> in order to make code flows a bit cleaner and migrate to tpm_buf.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>  drivers/char/tpm/tpm-interface.c | 67 +++++++++++++++++++++++++---------------
>  drivers/char/tpm/tpm.h           |  6 +---
>  drivers/char/tpm/tpm2-cmd.c      | 32 +------------------
>  3 files changed, 44 insertions(+), 61 deletions(-)

Makes sense to me

> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index d2b4df6d9894..fbef47d8bd06 100644
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -540,6 +540,47 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>  }
>  EXPORT_SYMBOL_GPL(tpm_transmit_cmd);
>  
> +#define TPM_ORD_STARTUP 153
> +#define TPM_ST_CLEAR 1

We should really have a tpm1.h and tpm2.h that has all these various
constants and things instead of open coding them randomly all over..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
