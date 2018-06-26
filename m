From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 26 Jun 2018 14:36:13 -0400
Subject: [PATCH v6 3/5] tpm: Convert tpm_find_get_ops() to use
	tpm_default_chip()
In-Reply-To: <20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
References: <20180626172331.2505541-1-stefanb@linux.vnet.ibm.com>
	<20180626172331.2505541-4-stefanb@linux.vnet.ibm.com>
Message-ID: <17ca4660-150b-b536-bbda-01629aac11f6@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 06/26/2018 01:23 PM, Stefan Berger wrote:
> Convert tpm_find_get_ops() to use tpm_default_chip() in case no chip
> is passed in.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>   drivers/char/tpm/tpm-chip.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index f551061262c9..b01d34983766 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -124,29 +124,23 @@ EXPORT_SYMBOL_GPL(tpm_default_chip);
>    */
>   struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip)
>   {
> -	struct tpm_chip *res = NULL;
> -	int chip_num = 0;
> -	int chip_prev;
> -
> -	mutex_lock(&idr_lock);
> +	int rc;
>
> -	if (!chip) {
> -		do {
> -			chip_prev = chip_num;
> -			chip = idr_get_next(&dev_nums_idr, &chip_num);
> -			if (chip && !tpm_try_get_ops(chip)) {
> -				res = chip;
> -				break;
> -			}
> -		} while (chip_prev != chip_num);
> -	} else {
> +	if (chip) {
>   		if (!tpm_try_get_ops(chip))
> -			res = chip;
> +			return chip;
> +		return NULL;
>   	}
>
> -	mutex_unlock(&idr_lock);
> -
> -	return res;
> +	chip = tpm_default_chip();
> +	if (!chip)
> +		return NULL;
> +	rc = tpm_try_get_ops(chip);
> +	/* release additional reference we got from tpm_default_chip() */
> +	put_device(&chip->dev);
> +	if (!rc)
This should say 'if (rc)'.
> +		return NULL;
> +	return chip;
>   }
>
>   /**


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
