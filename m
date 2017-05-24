From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 24 May 2017 12:23:19 -0700
Subject: [PATCH v5 1/2] tpm: Introduce flag TPM_TRANSMIT_RAW
In-Reply-To: <1494867105-30722-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1494867105-30722-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1494867105-30722-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <20170524192319.o6ntj47ngwif6yrx@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 15, 2017 at 12:51:44PM -0400, Stefan Berger wrote:
> Introduce the flag TPM_TRASNMIT_RAW that allows us to transmit
> a command without recursing into the requesting of locality.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

>  drivers/char/tpm/tpm-interface.c | 3 ++-
>  drivers/char/tpm/tpm.h           | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 4ed08ab..2eacda2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -416,7 +416,8 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	/* Store the decision as chip->locality will be changed. */
>  	need_locality = chip->locality == -1;
>  
> -	if (need_locality && chip->ops->request_locality)  {
> +	if (!(flags & TPM_TRANSMIT_RAW) &&
> +	    need_locality && chip->ops->request_locality)  {
>  		rc = chip->ops->request_locality(chip, 0);
>  		if (rc < 0)
>  			goto out_no_locality;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index e81d8c7..25d9858 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -525,6 +525,7 @@ extern struct idr dev_nums_idr;
>  
>  enum tpm_transmit_flags {
>  	TPM_TRANSMIT_UNLOCKED	= BIT(0),
> +	TPM_TRANSMIT_RAW	= BIT(1),
>  };
>  
>  ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> -- 
> 2.4.3
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
