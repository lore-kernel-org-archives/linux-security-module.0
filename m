From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 20:12:49 +0200
Subject: [PATCH 2/2] tpm: fix buffer type in tpm_transimt/_cmd
In-Reply-To: <20180305124826.5160-2-tomas.winkler@intel.com>
References: <20180305124826.5160-1-tomas.winkler@intel.com>
	<20180305124826.5160-2-tomas.winkler@intel.com>
Message-ID: <20180305181249.GE6220@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 05, 2018 at 02:48:26PM +0200, Tomas Winkler wrote:
> 1. The buffer cannot be const as it is used both for send and receive.
> 2. Drop useless casting to u8 *, as this is already a
> type of 'buf' parameter, it has just masked the 'const' issue.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 8 ++++----
>  drivers/char/tpm/tpm.h           | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index cafec634181a..4afd95c83612 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -475,7 +475,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	if (rc)
>  		goto out;
>  
> -	rc = chip->ops->send(chip, (u8 *) buf, count);
> +	rc = chip->ops->send(chip, buf, count);
>  	if (rc < 0) {
>  		if (rc != -EPIPE)
>  			dev_err(&chip->dev,
> @@ -512,7 +512,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	goto out;
>  
>  out_recv:
> -	len = chip->ops->recv(chip, (u8 *) buf, bufsiz);
> +	len = chip->ops->recv(chip, buf, bufsiz);
>  	if (len < 0) {
>  		rc = len;
>  		dev_err(&chip->dev,
> @@ -567,7 +567,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>   *     A positive number for a TPM error.
>   */
>  ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
> -			 const void *buf, size_t bufsiz,
> +			 void *buf, size_t bufsiz,
>  			 size_t min_rsp_body_length, unsigned int flags,
>  			 const char *desc)
>  {
> @@ -575,7 +575,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
>  	int err;
>  	ssize_t len;
>  
> -	len = tpm_transmit(chip, space, (u8 *)buf, bufsiz, flags);
> +	len = tpm_transmit(chip, space, buf, bufsiz, flags);
>  	if (len <  0)
>  		return len;
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index b82b924d763c..50dcbf3b60aa 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -520,7 +520,7 @@ enum tpm_transmit_flags {
>  ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  		     u8 *buf, size_t bufsiz, unsigned int flags);
>  ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
> -			 const void *buf, size_t bufsiz,
> +			 void *buf, size_t bufsiz,
>  			 size_t min_rsp_body_length, unsigned int flags,
>  			 const char *desc);
>  int tpm_startup(struct tpm_chip *chip);
> -- 
> 2.14.3
> 

Thanks, these changes have applied.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
