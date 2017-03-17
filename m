From: Alexander.Steffen@infineon.com (Alexander.Steffen at infineon.com)
Date: Fri, 17 Mar 2017 15:41:38 +0000
Subject: [tpmdd-devel] [PATCH v3 4/7] tpm: infrastructure for TPM spaces
In-Reply-To: <20170303151912.14752-5-jarkko.sakkinen@linux.intel.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-5-jarkko.sakkinen@linux.intel.com>
Message-ID: <1aa1c9d32fd446f69551a36c37f0ed16@MUCSE603.infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 20b1fe3..db5ffe9 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -376,11 +376,12 @@ static bool tpm_validate_command(struct
> tpm_chip *chip, const u8 *cmd,
>   *     0 when the operation is successful.
>   *     A negative number for system errors (errno).
>   */
> -ssize_t tpm_transmit(struct tpm_chip *chip, const u8 *buf, size_t bufsiz,
> -		     unsigned int flags)
> +ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
> +		     u8 *buf, size_t bufsiz, unsigned int flags)

When adding parameters, please also update the parameter documentation at the top of the function. It is missing for the new parameter "space" here.

Alexander
????{.n?+???????+%?????????w??{.n?+????{??????????v?^?)????w*jg??????????j????G?????????j:+v???w?j?m????????w?????f???h?????????
