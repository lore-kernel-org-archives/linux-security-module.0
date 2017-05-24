From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 24 May 2017 14:52:59 -0700
Subject: [PATCH] tpm, tpm_infineon: remove useless snprintf() calls
In-Reply-To: <20170524212916.9106-1-jarkko.sakkinen@linux.intel.com>
References: <20170524212916.9106-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170524215259.xkaqrnhcb44jpyd5@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 24, 2017 at 02:29:16PM -0700, Jarkko Sakkinen wrote:
> The memory copy from rodata to stack is useless.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I already applied this, reviewed-by would be nice for this one but given
how obvious this change is, it is not mandatory. I take my chances on
this one as a maitainer.

/Jarkko

> ---
>  drivers/char/tpm/tpm_infineon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index e3cf9f3545c5..3b1b9f9322d5 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -397,7 +397,7 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
>  	int vendorid[2];
>  	int version[2];
>  	int productid[2];
> -	char chipname[20];
> +	const char *chipname;
>  	struct tpm_chip *chip;
>  
>  	/* read IO-ports through PnP */
> @@ -488,13 +488,13 @@ static int tpm_inf_pnp_probe(struct pnp_dev *dev,
>  
>  	switch ((productid[0] << 8) | productid[1]) {
>  	case 6:
> -		snprintf(chipname, sizeof(chipname), " (SLD 9630 TT 1.1)");
> +		chipname = " (SLD 9630 TT 1.1)";
>  		break;
>  	case 11:
> -		snprintf(chipname, sizeof(chipname), " (SLB 9635 TT 1.2)");
> +		chipname = " (SLB 9635 TT 1.2)";
>  		break;
>  	default:
> -		snprintf(chipname, sizeof(chipname), " (unknown chip)");
> +		chipname = " (unknown chip)";
>  		break;
>  	}
>  
> -- 
> 2.11.0
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
