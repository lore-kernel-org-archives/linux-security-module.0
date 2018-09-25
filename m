From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:31:07 +0300
Subject: [PATCH v4 10/21] tpm: factor out tpm 1.x pm suspend flow into
	tpm1-cmd.c
In-Reply-To: <20180921135820.20549-11-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-11-tomas.winkler@intel.com>
Message-ID: <8fff0ded33cf5b012eff398161a09af013b02d41.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> Factor out TPM 1.x suspend flow from tpm-interface.c into a new function
> tpm1_pm_suspend() in tpm1-cmd.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2-V3: Rebase
> V4: 1. Add kdoc for tpm1_pm_suspend().
>     2. Fix commit message.
> 
>  drivers/char/tpm/tpm-interface.c | 55 ++++---------------------------------
>  drivers/char/tpm/tpm.h           |  1 +
>  drivers/char/tpm/tpm1-cmd.c      | 59
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 7239ccc16e2f..dfa972bbdd81 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -585,15 +585,6 @@ int tpm_send(struct tpm_chip *chip, void *cmd, size_t
> buflen)
>  }
>  EXPORT_SYMBOL_GPL(tpm_send);
>  
> -#define TPM_ORD_SAVESTATE 152
> -#define SAVESTATE_RESULT_SIZE 10
> -
> -static const struct tpm_input_header savestate_header = {
> -	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> -	.length = cpu_to_be32(10),
> -	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
> -};
> -
>  /*
>   * We are about to suspend. Save the TPM state
>   * so that it can be restored.
> @@ -601,54 +592,18 @@ static const struct tpm_input_header savestate_header =
> {
>  int tpm_pm_suspend(struct device *dev)
>  {
>  	struct tpm_chip *chip = dev_get_drvdata(dev);
> -	struct tpm_cmd_t cmd;
> -	int rc, try;
> -
> -	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
> +	int rc = 0;
>  
> -	if (chip == NULL)
> +	if (!chip)
>  		return -ENODEV;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		return 0;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		tpm2_shutdown(chip, TPM2_SU_STATE);
> -		return 0;
> -	}
> -
> -	/* for buggy tpm, flush pcrs with extend to selected dummy */
> -	if (tpm_suspend_pcr)
> -		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
> -				     "extending dummy pcr before suspend");
> -
> -	/* now do the actual savestate */
> -	for (try = 0; try < TPM_RETRY; try++) {
> -		cmd.header.in = savestate_header;
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> SAVESTATE_RESULT_SIZE,
> -				      0, 0, NULL);
> -
> -		/*
> -		 * If the TPM indicates that it is too busy to respond to
> -		 * this command then retry before giving up.  It can take
> -		 * several seconds for this TPM to be ready.
> -		 *
> -		 * This can happen if the TPM has already been sent the
> -		 * SaveState command before the driver has loaded.  TCG 1.2
> -		 * specification states that any communication after
> SaveState
> -		 * may cause the TPM to invalidate previously saved state.
> -		 */
> -		if (rc != TPM_WARN_RETRY)
> -			break;
> -		tpm_msleep(TPM_TIMEOUT_RETRY);
> -	}
> -
> -	if (rc)
> -		dev_err(&chip->dev,
> -			"Error (%d) sending savestate before suspend\n", rc);
> -	else if (try > 0)
> -		dev_warn(&chip->dev, "TPM savestate took %dms\n",
> -			 try * TPM_TIMEOUT_RETRY);
> +	else
> +		rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
>  
>  	return rc;
>  }
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index fd945fc828b6..862c9262e037 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -543,6 +543,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct
> tpm_space *space,
>  int tpm_startup(struct tpm_chip *chip);
>  int tpm_get_timeouts(struct tpm_chip *);
>  
> +int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr);
>  int tpm1_do_selftest(struct tpm_chip *chip);
>  int tpm1_auto_startup(struct tpm_chip *chip);
>  int tpm1_get_timeouts(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 8ecda2cd3734..d118adbcd2a7 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -667,3 +667,62 @@ int tpm1_auto_startup(struct tpm_chip *chip)
>  		rc = -ENODEV;
>  	return rc;
>  }
> +
> +#define TPM_ORD_SAVESTATE 152
> +#define SAVESTATE_RESULT_SIZE 10
> +static const struct tpm_input_header savestate_header = {
> +	.tag = cpu_to_be16(TPM_TAG_RQU_COMMAND),
> +	.length = cpu_to_be32(10),
> +	.ordinal = cpu_to_be32(TPM_ORD_SAVESTATE)
> +};
> +
> +/**
> + * tpm1_pm_suspend() - pm suspend handler
> + *    The functions saves the TPM state to be restored on resume.
> + *
> + * @chip:    TPM chip to use.
> + * @tpm_suspend_pcr: flush pcr for buggy TPM chips.
> + *
> + * Return: 0 on success, < 0 on error.
> + */
> +int tpm1_pm_suspend(struct tpm_chip *chip, int tpm_suspend_pcr)
> +{
> +	u8 dummy_hash[TPM_DIGEST_SIZE] = { 0 };
> +	struct tpm_cmd_t cmd;
> +	int rc, try;
> +
> +	/* for buggy tpm, flush pcrs with extend to selected dummy */
> +	if (tpm_suspend_pcr)
> +		rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
> +				     "extending dummy pcr before suspend");
> +
> +	/* now do the actual savestate */
> +	for (try = 0; try < TPM_RETRY; try++) {
> +		cmd.header.in = savestate_header;
> +		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> SAVESTATE_RESULT_SIZE,
> +				      0, 0, NULL);
> +
> +		/*
> +		 * If the TPM indicates that it is too busy to respond to
> +		 * this command then retry before giving up.  It can take
> +		 * several seconds for this TPM to be ready.
> +		 *
> +		 * This can happen if the TPM has already been sent the
> +		 * SaveState command before the driver has loaded.  TCG 1.2
> +		 * specification states that any communication after
> SaveState
> +		 * may cause the TPM to invalidate previously saved state.
> +		 */
> +		if (rc != TPM_WARN_RETRY)
> +			break;
> +		tpm_msleep(TPM_TIMEOUT_RETRY);
> +	}
> +
> +	if (rc)
> +		dev_err(&chip->dev, "Error (%d) sending savestate before
> suspend\n",
> +			rc);
> +	else if (try > 0)
> +		dev_warn(&chip->dev, "TPM savestate took %dms\n",
> +			 try * TPM_TIMEOUT_RETRY);
> +
> +	return rc;
> +}

Again, looks otherwise good except for the heading comment.

/Jarkko
