From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 09 Apr 2018 14:13:20 +0300
Subject: [PATCH] tpm: tpm_crb: relinquish locality on error path.
In-Reply-To: <20180407161236.22969-1-tomas.winkler@intel.com>
References: <20180407161236.22969-1-tomas.winkler@intel.com>
Message-ID: <c06b86c0b58888f750e6e00c33be33ab54d39257.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> In crb_map_io() function, __crb_request_locality() is called prior
> to crb_cmd_ready(), but if one of the consecutive function fails
> the flow bails out instead of trying to relinquish locality.
> This patch adds goto jump to __crb_relinquish_locality() on the error path.
> 
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 7f78482cd157..34fbc6cb097b 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -511,8 +511,10 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  
>  	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
>  				   sizeof(struct crb_regs_tail));
> -	if (IS_ERR(priv->regs_t))
> -		return PTR_ERR(priv->regs_t);
> +	if (IS_ERR(priv->regs_t)) {
> +		ret = PTR_ERR(priv->regs_t);
> +		goto out_relinquish_locality;
> +	}
>  
>  	/*
>  	 * PTT HW bug w/a: wake up the device to access
> @@ -520,7 +522,7 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  	 */
>  	ret = crb_cmd_ready(dev, priv);
>  	if (ret)
> -		return ret;
> +		goto out_relinquish_locality;
>  
>  	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
>  	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> @@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  
>  	crb_go_idle(dev, priv);
>  
> +out_relinquish_locality:
> +
>  	__crb_relinquish_locality(dev, priv, 0);
>  
>  	return ret;

Thanks, please just call it before returning in the error path.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
