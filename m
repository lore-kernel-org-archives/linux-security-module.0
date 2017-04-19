From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Apr 2017 18:30:36 +0300
Subject: [PATCH] tpm: Fix reference count to main device
In-Reply-To: <1492480706-6928-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1492480706-6928-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170419153036.7bcax775wskrskdo@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 17, 2017 at 09:58:26PM -0400, Stefan Berger wrote:
> The main device is currently not properly released due to one additional
> reference to the 'devs' device which is only released in case of a TPM 2.
> So, also get the additional reference only in case of a TPM2.
> 
> Fixes: fdc915f7f719 ("tpm: expose spaces via a device link /dev/tpmrm<n>")
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Excellent, thank you. I'll send this with some other small fixes for
4.12 to James rather sooner than later.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

> 
> ---
>  drivers/char/tpm/tpm-chip.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index a321bd5..9dec9f5 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -191,9 +191,10 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
>  	/* get extra reference on main device to hold on
>  	 * behalf of devs.  This holds the chip structure
>  	 * while cdevs is in use.  The corresponding put
> -	 * is in the tpm_devs_release
> +	 * is in the tpm_devs_release (TPM2 only)
>  	 */
> -	get_device(&chip->dev);
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +		get_device(&chip->dev);
>  
>  	if (chip->dev_num == 0)
>  		chip->dev.devt = MKDEV(MISC_MAJOR, TPM_MINOR);
> -- 
> 2.4.3
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
