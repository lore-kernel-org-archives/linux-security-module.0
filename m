From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 17 Mar 2017 21:02:40 +0200
Subject: [PATCH 2/2] tpm: add sleep only for retry in
	i2c_nuvoton_write_status()
In-Reply-To: <1489171554-6844-2-git-send-email-nayna@linux.vnet.ibm.com>
References: <1489171554-6844-1-git-send-email-nayna@linux.vnet.ibm.com>
	<1489171554-6844-2-git-send-email-nayna@linux.vnet.ibm.com>
Message-ID: <20170317190240.yn5ifl5ozvi2lxqf@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 10, 2017 at 01:45:54PM -0500, Nayna Jain wrote:
> Currently, there is an unnecessary 1 msec delay added in
> i2c_nuvoton_write_status() for the successful case. This 
> function is called multiple times during send() and recv(),
> which implies adding multiple extra delays for every TPM
> operation.
> 
> This patch calls usleep_range() only if retry is to be done.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Cc: stable at vger.kernel.org (linux-4.8)
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

I applied this too.

/Jarkko

> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
> index 0c98c42..c642877 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -124,8 +124,9 @@ static s32 i2c_nuvoton_write_status(struct i2c_client *client, u8 data)
>  	/* this causes the current command to be aborted */
>  	for (i = 0, status = -1; i < TPM_I2C_RETRY_COUNT && status < 0; i++) {
>  		status = i2c_nuvoton_write_buf(client, TPM_STS, 1, &data);
> -		usleep_range(TPM_I2C_BUS_DELAY, TPM_I2C_BUS_DELAY
> -			     + TPM_I2C_DELAY_RANGE);
> +		if (status < 0)
> +			usleep_range(TPM_I2C_BUS_DELAY, TPM_I2C_BUS_DELAY
> +				     + TPM_I2C_DELAY_RANGE);
>  	}
>  	return status;
>  }
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
