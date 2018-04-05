From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 5 Apr 2018 13:12:10 +0300
Subject: [PATCH] tpm: moves the delay_msec increment after sleep in
	tpm_transmit()
In-Reply-To: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
Message-ID: <20180405101210.GA21636@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> handle the TPM2_RC_RETRY error. The loop retries the command after
> sleeping for the specified time, which is incremented exponentially in
> every iteration. This patch fixes the initial sleep to be the default
> sleep time.

I think I understand the code change but do not understand what the
long description.

> 
> Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index c43a9e28995e..6201aab374e6 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  		 */
>  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>  			break;
> -		delay_msec *= 2;
> +

Extra whitespace

>  		if (delay_msec > TPM2_DURATION_LONG) {
>  			if (rc == TPM2_RC_RETRY)
>  				dev_err(&chip->dev, "in retry loop\n");
> @@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  			break;
>  		}
>  		tpm_msleep(delay_msec);
> +		delay_msec *= 2;
>  		memcpy(buf, save, save_size);
>  	}
>  	return ret;
> -- 
> 2.13.6
> 

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
