From: PeterHuewe@gmx.de (Peter Huewe)
Date: Thu, 25 May 2017 07:32:28 +0200
Subject: Aw: Re: [PATCH] tpm: remove struct tpm_pcrextend_in
In-Reply-To: <20170524222822.bk2popwamuo7ee3o@intel.com>
References: <20170524222731.19741-1-jarkko.sakkinen@linux.intel.com>
	<20170524222822.bk2popwamuo7ee3o@intel.com>
Message-ID: <trinity-4c867f71-295b-4ef6-b141-ca66fa805d6c-1495690348388@3capp-gmx-bs66>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> Removed struct tpm_pcrextend_in as it is not used for anything anymore.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
LGTM.
Reviewed-by: Peter Huewe <peterhuewe@gmx.de>

> ---
> drivers/char/tpm/tpm.h | 6 ------
> 1 file changed, 6 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index dd1173427fb2..af05c1403c6e 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -363,11 +363,6 @@ struct tpm_pcrread_in {
> __be32 pcr_idx;
> } __packed;
>
> -struct tpm_pcrextend_in {
> - __be32 pcr_idx;
> - u8 hash[TPM_DIGEST_SIZE];
> -} __packed;
> -
> /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
> * bytes, but 128 is still a relatively large number of random bytes and
> * anything much bigger causes users of struct tpm_cmd_t to start getting
> @@ -392,7 +387,6 @@ typedef union {
> u8 readpubek_out_buffer[sizeof(struct tpm_readpubek_params_out)];
> struct tpm_pcrread_in pcrread_in;
> struct tpm_pcrread_out pcrread_out;
> - struct tpm_pcrextend_in pcrextend_in;
> struct tpm_getrandom_in getrandom_in;
> struct tpm_getrandom_out getrandom_out;
> struct tpm_startup_in startup_in;
> --
> 2.11.0
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
