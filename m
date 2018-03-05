From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 20:09:44 +0200
Subject: [PATCH 1/2] tpm: tpm-interface: fix tpm_transmit/_cmd  kdoc
In-Reply-To: <20180305124826.5160-1-tomas.winkler@intel.com>
References: <20180305124826.5160-1-tomas.winkler@intel.com>
Message-ID: <20180305180944.GC6220@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 05, 2018 at 02:48:25PM +0200, Tomas Winkler wrote:
> Fix tmp_ -> tpm_ typo and add reference to 'space' parameter
> in kdoc for tpm_transmit and tpm_transmit_cmd functions.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 64dbec078c1b..cafec634181a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -399,9 +399,10 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
>  }
>  
>  /**
> - * tmp_transmit - Internal kernel interface to transmit TPM commands.
> + * tpm_transmit - Internal kernel interface to transmit TPM commands.
>   *
>   * @chip: TPM chip to use
> + * @space: tpm space
>   * @buf: TPM command buffer
>   * @bufsiz: length of the TPM command buffer
>   * @flags: tpm transmit flags - bitmap
> @@ -549,10 +550,11 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  }
>  
>  /**
> - * tmp_transmit_cmd - send a tpm command to the device
> + * tpm_transmit_cmd - send a tpm command to the device
>   *    The function extracts tpm out header return code
>   *
>   * @chip: TPM chip to use
> + * @space: tpm space
>   * @buf: TPM command buffer
>   * @bufsiz: length of the buffer
>   * @min_rsp_body_length: minimum expected length of response body
> -- 
> 2.14.3
> 

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
