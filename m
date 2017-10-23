From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Mon, 23 Oct 2017 19:02:18 +0530
Subject: [PATCH v4 1/4] tpm: move wait_for_tpm_stat() to respective driver
	files
In-Reply-To: <20171020085645.q43e62d2vmspatm2@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
	<20171017203232.2262-2-nayna@linux.vnet.ibm.com>
	<20171019142141.jtzilibffx4fsgmw@linux.intel.com>
	<d2a4fca3aee340dcb5de88a69814bd90@infineon.com>
	<20171020085645.q43e62d2vmspatm2@linux.intel.com>
Message-ID: <67d5b797-17b6-6247-1f0d-c62c09967f87@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 10/20/2017 02:26 PM, Jarkko Sakkinen wrote:
> On Thu, Oct 19, 2017 at 05:00:29PM +0000, Alexander.Steffen at infineon.com wrote:
>>> On Tue, Oct 17, 2017 at 04:32:29PM -0400, Nayna Jain wrote:
>>>> The function wait_for_tpm_stat() is currently defined in
>>>> tpm-interface file. It is a hardware specific function used
>>>> only by tpm_tis and xen-tpmfront, so it is removed from
>>>> tpm-interface.c and defined in respective driver files.
>>>>
>>>> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>>> ---
>>>>   drivers/char/tpm/tpm-interface.c | 60 ----------------------------------------
>>>>   drivers/char/tpm/tpm.h           |  2 --
>>>>   drivers/char/tpm/tpm_tis_core.c  | 60
>>> ++++++++++++++++++++++++++++++++++++++++
>>>>   drivers/char/tpm/xen-tpmfront.c  | 60
>>> ++++++++++++++++++++++++++++++++++++++++
>>>>   4 files changed, 120 insertions(+), 62 deletions(-)
>>>>
>>>> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
>>> interface.c
>>>> index 1d6729be4cd6..313f7618d569 100644
>>>> --- a/drivers/char/tpm/tpm-interface.c
>>>> +++ b/drivers/char/tpm/tpm-interface.c
>>>> @@ -1035,66 +1035,6 @@ int tpm_send(u32 chip_num, void *cmd, size_t
>>> buflen)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(tpm_send);
>>>>
>>>> -static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>>>> -					bool check_cancel, bool *canceled)
>>>> -{
>>>> -	u8 status = chip->ops->status(chip);
>>>> -
>>>> -	*canceled = false;
>>>> -	if ((status & mask) == mask)
>>>> -		return true;
>>>> -	if (check_cancel && chip->ops->req_canceled(chip, status)) {
>>>> -		*canceled = true;
>>>> -		return true;
>>>> -	}
>>>> -	return false;
>>>> -}
>>>> -
>>>> -int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, unsigned long
>>> timeout,
>>>> -		      wait_queue_head_t *queue, bool check_cancel)
>>>> -{
>>>> -	unsigned long stop;
>>>> -	long rc;
>>>> -	u8 status;
>>>> -	bool canceled = false;
>>>> -
>>>> -	/* check current status */
>>>> -	status = chip->ops->status(chip);
>>>> -	if ((status & mask) == mask)
>>>> -		return 0;
>>>> -
>>>> -	stop = jiffies + timeout;
>>>> -
>>>> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>>>> -again:
>>>> -		timeout = stop - jiffies;
>>>> -		if ((long)timeout <= 0)
>>>> -			return -ETIME;
>>>> -		rc = wait_event_interruptible_timeout(*queue,
>>>> -			wait_for_tpm_stat_cond(chip, mask, check_cancel,
>>>> -					       &canceled),
>>>> -			timeout);
>>>> -		if (rc > 0) {
>>>> -			if (canceled)
>>>> -				return -ECANCELED;
>>>> -			return 0;
>>>> -		}
>>>> -		if (rc == -ERESTARTSYS && freezing(current)) {
>>>> -			clear_thread_flag(TIF_SIGPENDING);
>>>> -			goto again;
>>>> -		}
>>>> -	} else {
>>>> -		do {
>>>> -			tpm_msleep(TPM_TIMEOUT);
>>>> -			status = chip->ops->status(chip);
>>>> -			if ((status & mask) == mask)
>>>> -				return 0;
>>>> -		} while (time_before(jiffies, stop));
>>>> -	}
>>>> -	return -ETIME;
>>>> -}
>>>> -EXPORT_SYMBOL_GPL(wait_for_tpm_stat);
>>>> -
>>>>   #define TPM_ORD_SAVESTATE 152
>>>>   #define SAVESTATE_RESULT_SIZE 10
>>>>
>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>> index 2d5466a72e40..4fc83ac7abeb 100644
>>>> --- a/drivers/char/tpm/tpm.h
>>>> +++ b/drivers/char/tpm/tpm.h
>>>> @@ -525,8 +525,6 @@ int tpm_do_selftest(struct tpm_chip *chip);
>>>>   unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32
>>> ordinal);
>>>>   int tpm_pm_suspend(struct device *dev);
>>>>   int tpm_pm_resume(struct device *dev);
>>>> -int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask, unsigned long
>>> timeout,
>>>> -		      wait_queue_head_t *queue, bool check_cancel);
>>>>
>>>>   static inline void tpm_msleep(unsigned int delay_msec)
>>>>   {
>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c
>>> b/drivers/char/tpm/tpm_tis_core.c
>>>> index 63bc6c3b949e..b33126a35694 100644
>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>> @@ -31,6 +31,66 @@
>>>>   #include "tpm.h"
>>>>   #include "tpm_tis_core.h"
>>>>
>>>> +static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>>>> +					bool check_cancel, bool *canceled)
>>>> +{
>>>> +	u8 status = chip->ops->status(chip);
>>>> +
>>>> +	*canceled = false;
>>>> +	if ((status & mask) == mask)
>>>> +		return true;
>>>> +	if (check_cancel && chip->ops->req_canceled(chip, status)) {
>>>> +		*canceled = true;
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>>>> +		unsigned long timeout, wait_queue_head_t *queue,
>>>> +		bool check_cancel)
>>>> +{
>>>> +	unsigned long stop;
>>>> +	long rc;
>>>> +	u8 status;
>>>> +	bool canceled = false;
>>>> +
>>>> +	/* check current status */
>>>> +	status = chip->ops->status(chip);
>>>> +	if ((status & mask) == mask)
>>>> +		return 0;
>>>> +
>>>> +	stop = jiffies + timeout;
>>>> +
>>>> +	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>>>> +again:
>>>> +		timeout = stop - jiffies;
>>>> +		if ((long)timeout <= 0)
>>>> +			return -ETIME;
>>>> +		rc = wait_event_interruptible_timeout(*queue,
>>>> +			wait_for_tpm_stat_cond(chip, mask, check_cancel,
>>>> +					       &canceled),
>>>> +			timeout);
>>>> +		if (rc > 0) {
>>>> +			if (canceled)
>>>> +				return -ECANCELED;
>>>> +			return 0;
>>>> +		}
>>>> +		if (rc == -ERESTARTSYS && freezing(current)) {
>>>> +			clear_thread_flag(TIF_SIGPENDING);
>>>> +			goto again;
>>>> +		}
>>>> +	} else {
>>>> +		do {
>>>> +			tpm_msleep(TPM_TIMEOUT);
>>>> +			status = chip->ops->status(chip);
>>>> +			if ((status & mask) == mask)
>>>> +				return 0;
>>>> +		} while (time_before(jiffies, stop));
>>>> +	}
>>>> +	return -ETIME;
>>>> +}
>>>> +
>>>>   /* Before we attempt to access the TPM we must see that the valid bit is
>>> set.
>>>>    * The specification says that this bit is 0 at reset and remains 0 until the
>>>>    * 'TPM has gone through its self test and initialization and has established
>>>> diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-
>>> tpmfront.c
>>>> index 656e8af95d52..d20a0a9ded27 100644
>>>> --- a/drivers/char/tpm/xen-tpmfront.c
>>>> +++ b/drivers/char/tpm/xen-tpmfront.c
>>>> @@ -39,6 +39,66 @@ enum status_bits {
>>>>   	VTPM_STATUS_CANCELED = 0x8,
>>>>   };
>>>>
>>>> +static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>>>> +					bool check_cancel, bool *canceled)
>>>> +{
>>>> +	u8 status = chip->ops->status(chip);
>>>> +
>>>> +	*canceled = false;
>>>> +	if ((status & mask) == mask)
>>>> +		return true;
>>>> +	if (check_cancel && chip->ops->req_canceled(chip, status)) {
>>>> +		*canceled = true;
>>>> +		return true;
>>>> +	}
>>>> +	return false;
>>>> +}
>>>> +
>>>> +static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>>>> +		unsigned long timeout, wait_queue_head_t *queue,
>>>> +		bool check_cancel)
>>>> +{
>>>> +	unsigned long stop;
>>>> +	long rc;
>>>> +	u8 status;
>>>> +	bool canceled = false;
>>>> +
>>>> +	/* check current status */
>>>> +	status = chip->ops->status(chip);
>>>> +	if ((status & mask) == mask)
>>>> +		return 0;
>>>> +
>>>> +	stop = jiffies + timeout;
>>>> +
>>>> +	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>>>> +again:
>>>> +		timeout = stop - jiffies;
>>>> +		if ((long)timeout <= 0)
>>>> +			return -ETIME;
>>>> +		rc = wait_event_interruptible_timeout(*queue,
>>>> +			wait_for_tpm_stat_cond(chip, mask, check_cancel,
>>>> +					       &canceled),
>>>> +			timeout);
>>>> +		if (rc > 0) {
>>>> +			if (canceled)
>>>> +				return -ECANCELED;
>>>> +			return 0;
>>>> +		}
>>>> +		if (rc == -ERESTARTSYS && freezing(current)) {
>>>> +			clear_thread_flag(TIF_SIGPENDING);
>>>> +			goto again;
>>>> +		}
>>>> +	} else {
>>>> +		do {
>>>> +			tpm_msleep(TPM_TIMEOUT);
>>>> +			status = chip->ops->status(chip);
>>>> +			if ((status & mask) == mask)
>>>> +				return 0;
>>>> +		} while (time_before(jiffies, stop));
>>>> +	}
>>>> +	return -ETIME;
>>>> +}
>>>> +
>>>>   static u8 vtpm_status(struct tpm_chip *chip)
>>>>   {
>>>>   	struct tpm_private *priv = dev_get_drvdata(&chip->dev);
>>>> --
>>>> 2.13.3
>>>>
>>> This commit caused a compiler warning because freezer.h was not included
>>> to xen-tpmfront.c. I manually fixed it.
>> Yep, and checkpatch.pl still complains about some stuff (mostly
>> whitespace) in both patch 1/4 and 2/4. When fixed patches are
>> available, I can run them again through my automation.
>> Alexander

Sorry for delay in response.. I was on vacation for last few days.
Thanks for informing. I am wondering these didn't show up when I ran 
checkpatch.pl.

> I'll fix these manually (weird, I run sparse and checkpatch, must have
> done some mistake).
Thanks Jarkko.

Thanks & Regards,
 ??? - Nayna

> Thank you!
>
> /Jarkko
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
