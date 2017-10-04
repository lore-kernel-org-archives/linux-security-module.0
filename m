From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 4 Oct 2017 14:22:29 +0300
Subject: [PATCH 3/3] tpm: add the crypto algorithm identifier to
	active_bank_info
In-Reply-To: <20170925111950.21511-4-roberto.sassu@huawei.com>
References: <20170925111950.21511-1-roberto.sassu@huawei.com>
	<20170925111950.21511-4-roberto.sassu@huawei.com>
Message-ID: <20171004112229.7aafz6yttewq4pbb@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 25, 2017 at 01:19:50PM +0200, Roberto Sassu wrote:
> In preparation for the patch introducing a function to pass supported TPM
> algorithms and digest sizes to TPM users, the crypto algorithm identifier
> is added to the active_bank_info structure.
> 
> All members of active_bank_info are necessary: TPM algorithm identifiers
> will be used to create an event log (they are included in the Crypto Agile
> format defined by TCG); crypto identifiers will be used to calculate
> digests using the crypto subsystem; digest sizes will be used to truncate
> digests calculated with different algorithms.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

This should be in the patch set where it makes sense. Please remove it
from the next version.

/Jarkko

> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 ++
>  include/linux/tpm.h         | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index b1356be..8c58f6e 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -946,6 +946,7 @@ static int tpm2_init_active_bank_info(struct tpm_chip *chip, u16 alg_id,
>  	int rc, i;
>  
>  	active_bank->alg_id = alg_id;
> +	active_bank->crypto_id = HASH_ALGO__LAST;
>  
>  	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
>  		enum hash_algo crypto_algo = tpm2_hash_map[i].crypto_id;
> @@ -954,6 +955,7 @@ static int tpm2_init_active_bank_info(struct tpm_chip *chip, u16 alg_id,
>  			continue;
>  
>  		active_bank->digest_size = hash_digest_size[crypto_algo];
> +		active_bank->crypto_id = crypto_algo;
>  		return 0;
>  	}
>  
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 3ecce21..fc927f3 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -54,6 +54,7 @@ struct tpm_class_ops {
>  
>  struct active_bank_info {
>  	u16 alg_id;
> +	u16 crypto_id;
>  	u16 digest_size;
>  };
>  
> -- 
> 2.9.3
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
