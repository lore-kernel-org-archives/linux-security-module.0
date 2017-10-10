From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 10 Oct 2017 18:04:33 +0300
Subject: [PATCH v3 2/5] tpm: ignore burstcount to improve tpm_tis send()
	performance
In-Reply-To: <20171004102924.12355-3-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
	<20171004102924.12355-3-nayna@linux.vnet.ibm.com>
Message-ID: <20171010150433.vxwxg4wzc3lgqckf@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 04, 2017 at 06:29:21AM -0400, Nayna Jain wrote:
> The TPM burstcount status indicates the number of bytes that can
> be sent to the TPM without causing bus wait states.  Effectively,
> it is the number of empty bytes in the command FIFO. Further,
> some TPMs have a static burstcount, when the value remains zero
> until the entire FIFO is empty.
> 
> This patch optimizes the tpm_tis_send_data() function by checking
> the burstcount only once. And if the burstcount is valid, it writes
> all the bytes at once, permitting wait states. The performance of a
> 34 byte extend on a TPM 1.2 with an 8 byte burstcount improved from
> 41msec to 14msec.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~41sec to ~14sec.
> 
> Suggested-by: Ken Goldman <kgold@linux.vnet.ibm.com> in
> conjunction with the TPM Device Driver work group.
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 42 ++++++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index b33126a35694..8da425e1783f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -316,7 +316,6 @@ static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int rc, status, burstcnt;
> -	size_t count = 0;
>  	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
>  
>  	status = tpm_tis_status(chip);
> @@ -330,35 +329,26 @@ static int tpm_tis_send_data(struct tpm_chip *chip, u8 *buf, size_t len)
>  		}
>  	}
>  
> -	while (count < len - 1) {
> -		burstcnt = get_burstcount(chip);
> -		if (burstcnt < 0) {
> -			dev_err(&chip->dev, "Unable to read burstcount\n");
> -			rc = burstcnt;
> -			goto out_err;
> -		}
> -		burstcnt = min_t(int, burstcnt, len - count - 1);
> -		rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
> -					 burstcnt, buf + count);
> -		if (rc < 0)
> -			goto out_err;
> +	/*
> +	 * Get the initial burstcount to ensure TPM is ready to
> +	 * accept data.
> +	 */
> +	burstcnt = get_burstcount(chip);
> +	if (burstcnt < 0) {
> +		dev_err(&chip->dev, "Unable to read burstcount\n");
> +		rc = burstcnt;
> +		goto out_err;
> +	}
>  
> -		count += burstcnt;
> +	burstcnt = len - 1;
>  
> -		if (wait_for_tpm_stat(chip, TPM_STS_VALID, chip->timeout_c,
> -					&priv->int_queue, false) < 0) {
> -			rc = -ETIME;
> -			goto out_err;
> -		}
> -		status = tpm_tis_status(chip);
> -		if (!itpm && (status & TPM_STS_DATA_EXPECT) == 0) {
> -			rc = -EIO;
> -			goto out_err;
> -		}
> -	}
> +	rc = tpm_tis_write_bytes(priv, TPM_DATA_FIFO(priv->locality),
> +			burstcnt, buf);

Otherwise, this looks good but I don't understand why you assign 'len -
1' to 'brustcnt' and pass it to tpm_tis_write_bytes() instead of just
passing 'len - 1'. I mean no relation to burst count, right?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
