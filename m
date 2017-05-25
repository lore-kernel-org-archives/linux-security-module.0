From: joe@perches.com (Joe Perches)
Date: Thu, 25 May 2017 14:53:05 -0700
Subject: [PATCH v2] tpm: vtpm_proxy: Suppresse error logging when in
	closed state
In-Reply-To: <1495748360-26558-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1495748360-26558-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <1495749185.29207.21.camel@perches.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-05-25 at 17:39 -0400, Stefan Berger wrote:
> Suppress the error logging when the core TPM driver sends commands
> to the VTPM proxy driver and -EPIPE is returned in case the VTPM
> proxy driver is 'closed' (closed anonymous file descriptor).  This
> error code is only returned by the send function and by tpm_transmit
> when the VTPM proxy driver is being used.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 4 ++--
>  drivers/char/tpm/tpm2-cmd.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index d711186..4826fcf 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -429,11 +429,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  		goto out;
>  
>  	rc = chip->ops->send(chip, (u8 *) buf, count);
> -	if (rc < 0) {
> +	if (rc < 0 && rc != -EPIPE)
>  		dev_err(&chip->dev,
>  			"tpm_transmit: tpm_send: error %d\n", rc);
> +	if (rc < 0)
>  		goto out;

Perhaps this would read better as

	if (rc < 0) {
		if (rc != -EPIPE)
			dev_err(etc...);
		goto out;
	}

though for etc, perhaps
			dev_err(&chip->dev, "%s: %tpm_send: error %d\n",
				__func__, rc);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
