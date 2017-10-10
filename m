From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 10 Oct 2017 17:57:13 +0300
Subject: [PATCH v3 1/5] tpm: move wait_for_tpm_stat() to respective
	driver files
In-Reply-To: <20171004102924.12355-2-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
	<20171004102924.12355-2-nayna@linux.vnet.ibm.com>
Message-ID: <20171010145713.i2zbuzo4iicyyeo3@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 04, 2017 at 06:29:20AM -0400, Nayna Jain wrote:
> The function wait_for_tpm_stat() is currently defined in
> tpm-interface file. It is a hardware specific function used
> only by tpm_tis and xen-tpmfront, so it is removed from
> tpm-interface.c and defined in respective driver files.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko

> ---
>  drivers/char/tpm/tpm-interface.c | 60 ----------------------------------------
>  drivers/char/tpm/tpm.h           |  2 --
>  drivers/char/tpm/tpm_tis_core.c  | 60 ++++++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/xen-tpmfront.c  | 60 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 120 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1d6729be4cd6..313f7618d569 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1035,66 +1035,6 @@ int tpm_send(u32 chip_num, void *cmd, size_t buflen)
>  }
>  EXPORT_SYMBOL_GPL(tpm_send);
>  
> -static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> -					bool check_cancel, bool *canceled)
> -{
> -	u8 status = chip->ops->status(chip);
> -
> -	*canceled = false;
> -	if ((status & mask) == mask)
> -		return true;
> -	if (check_cancel && chip->ops->req_canceled(chip, status)) {
> -		*canceled = true;
> -		return true;
> -	}
> -	return false;
> -}
> -
> -int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
> -		      wait_queue_head_t *queue, bool check_cancel)
> -{
> -	unsigned long stop;
> -	long rc;
> -	u8 status;
> -	bool canceled = false;
> -
> -	/* check current status */
> -	status = chip->ops->status(chip);
> -	if ((status & mask) == mask)
> -		return 0;
> -
> -	stop = jiffies + timeout;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> -again:
> -		timeout = stop - jiffies;
> -		if ((long)timeout <= 0)
> -			return -ETIME;
> -		rc = wait_event_interruptible_timeout(*queue,
> -			wait_for_tpm_stat_cond(chip, mask, check_cancel,
> -					       &canceled),
> -			timeout);
> -		if (rc > 0) {
> -			if (canceled)
> -				return -ECANCELED;
> -			return 0;
> -		}
> -		if (rc == -ERESTARTSYS && freezing(current)) {
> -			clear_thread_flag(TIF_SIGPENDING);
> -			goto again;
> -		}
> -	} else {
> -		do {
> -			tpm_msleep(TPM_TIMEOUT);
> -			status = chip->ops->status(chip);
> -			if ((status & mask) == mask)
> -				return 0;
> -		} while (time_before(jiffies, stop));
> -	}
> -	return -ETIME;
> -}
> -EXPORT_SYMBOL_GPL(wait_for_tpm_stat);
> -
>  #define TPM_ORD_SAVESTATE 152
>  #define SAVESTATE_RESULT_SIZE 10
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2d5466a72e40..4fc83ac7abeb 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -525,8 +525,6 @@ int tpm_do_selftest(struct tpm_chip *chip);
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
> -int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
> -		      wait_queue_head_t *queue, bool check_cancel);
>  
>  static inline void tpm_msleep(unsigned int delay_msec)
>  {
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 63bc6c3b949e..b33126a35694 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -31,6 +31,66 @@
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> +static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> +					bool check_cancel, bool *canceled)
> +{
> +	u8 status = chip->ops->status(chip);
> +
> +	*canceled = false;
> +	if ((status & mask) == mask)
> +		return true;
> +	if (check_cancel && chip->ops->req_canceled(chip, status)) {
> +		*canceled = true;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> +		unsigned long timeout, wait_queue_head_t *queue,
> +		bool check_cancel)
> +{
> +	unsigned long stop;
> +	long rc;
> +	u8 status;
> +	bool canceled = false;
> +
> +	/* check current status */
> +	status = chip->ops->status(chip);
> +	if ((status & mask) == mask)
> +		return 0;
> +
> +	stop = jiffies + timeout;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +again:
> +		timeout = stop - jiffies;
> +		if ((long)timeout <= 0)
> +			return -ETIME;
> +		rc = wait_event_interruptible_timeout(*queue,
> +			wait_for_tpm_stat_cond(chip, mask, check_cancel,
> +					       &canceled),
> +			timeout);
> +		if (rc > 0) {
> +			if (canceled)
> +				return -ECANCELED;
> +			return 0;
> +		}
> +		if (rc == -ERESTARTSYS && freezing(current)) {
> +			clear_thread_flag(TIF_SIGPENDING);
> +			goto again;
> +		}
> +	} else {
> +		do {
> +			tpm_msleep(TPM_TIMEOUT);
> +			status = chip->ops->status(chip);
> +			if ((status & mask) == mask)
> +				return 0;
> +		} while (time_before(jiffies, stop));
> +	}
> +	return -ETIME;
> +}
> +
>  /* Before we attempt to access the TPM we must see that the valid bit is set.
>   * The specification says that this bit is 0 at reset and remains 0 until the
>   * 'TPM has gone through its self test and initialization and has established
> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
> index 656e8af95d52..d20a0a9ded27 100644
> --- a/drivers/char/tpm/xen-tpmfront.c
> +++ b/drivers/char/tpm/xen-tpmfront.c
> @@ -39,6 +39,66 @@ enum status_bits {
>  	VTPM_STATUS_CANCELED = 0x8,
>  };
>  
> +static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> +					bool check_cancel, bool *canceled)
> +{
> +	u8 status = chip->ops->status(chip);
> +
> +	*canceled = false;
> +	if ((status & mask) == mask)
> +		return true;
> +	if (check_cancel && chip->ops->req_canceled(chip, status)) {
> +		*canceled = true;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
> +		unsigned long timeout, wait_queue_head_t *queue,
> +		bool check_cancel)
> +{
> +	unsigned long stop;
> +	long rc;
> +	u8 status;
> +	bool canceled = false;
> +
> +	/* check current status */
> +	status = chip->ops->status(chip);
> +	if ((status & mask) == mask)
> +		return 0;
> +
> +	stop = jiffies + timeout;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +again:
> +		timeout = stop - jiffies;
> +		if ((long)timeout <= 0)
> +			return -ETIME;
> +		rc = wait_event_interruptible_timeout(*queue,
> +			wait_for_tpm_stat_cond(chip, mask, check_cancel,
> +					       &canceled),
> +			timeout);
> +		if (rc > 0) {
> +			if (canceled)
> +				return -ECANCELED;
> +			return 0;
> +		}
> +		if (rc == -ERESTARTSYS && freezing(current)) {
> +			clear_thread_flag(TIF_SIGPENDING);
> +			goto again;
> +		}
> +	} else {
> +		do {
> +			tpm_msleep(TPM_TIMEOUT);
> +			status = chip->ops->status(chip);
> +			if ((status & mask) == mask)
> +				return 0;
> +		} while (time_before(jiffies, stop));
> +	}
> +	return -ETIME;
> +}
> +
>  static u8 vtpm_status(struct tpm_chip *chip)
>  {
>  	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
> -- 
> 2.13.3
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
