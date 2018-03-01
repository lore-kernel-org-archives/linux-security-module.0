From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Fri, 2 Mar 2018 00:14:57 +0530
Subject: [PATCH 1/3] tpm: move TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h
In-Reply-To: <20180301083740.GB29420@linux.intel.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
	<20180301083740.GB29420@linux.intel.com>
Message-ID: <409652f8-74db-2af5-3faa-137c71a27a59@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 03/01/2018 02:07 PM, Jarkko Sakkinen wrote:
> Hi
>
> On Wed, Feb 28, 2018 at 02:18:26PM -0500, Nayna Jain wrote:
>> This patch moves TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h, renaming
>> it to TPM_TIMEOUT_POLL, to follow the existing enum naming
>> conventions.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> The cover letter is missing. Are this meant to be a patch set or
> individual patches? I'll check these anyway.

These patches continue to improve TPM performance.
The first patch exports and renames the timeout enum for polling, that 
is subsequently used in the second patch.
The third patch is posted as an RFC? for further performance improvement 
by improving granularity.
>
>> ---
>>   drivers/char/tpm/tpm.h          |  3 ++-
>>   drivers/char/tpm/tpm_tis_core.c | 10 ++--------
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index f895fba4e20d..7e797377e1eb 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -53,7 +53,8 @@ enum tpm_const {
>>   enum tpm_timeout {
>>   	TPM_TIMEOUT = 5,	/* msecs */
>>   	TPM_TIMEOUT_RETRY = 100, /* msecs */
>> -	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
>> +	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
> What is happening here?
Addition of comma to add next enum value.

Thanks & Regards,
 ??? - Nayna

>
>> +	TPM_TIMEOUT_POLL = 1	/* msecs */
>>   };
>>   
>>   /* TPM addresses */
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 183a5f54d875..dc474e7244a6 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -31,12 +31,6 @@
>>   #include "tpm.h"
>>   #include "tpm_tis_core.h"
>>   
>> -/* This is a polling delay to check for status and burstcount.
>> - * As per ddwg input, expectation is that status check and burstcount
>> - * check should return within few usecs.
>> - */
>> -#define TPM_POLL_SLEEP	1  /* msec */
>> -
>>   static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>>   
>>   static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>> @@ -90,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>>   		}
>>   	} else {
>>   		do {
>> -			tpm_msleep(TPM_POLL_SLEEP);
>> +			tpm_msleep(TPM_TIMEOUT_POLL);
>>   			status = chip->ops->status(chip);
>>   			if ((status & mask) == mask)
>>   				return 0;
>> @@ -232,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
>>   		burstcnt = (value >> 8) & 0xFFFF;
>>   		if (burstcnt)
>>   			return burstcnt;
>> -		tpm_msleep(TPM_POLL_SLEEP);
>> +		tpm_msleep(TPM_TIMEOUT_POLL);
>>   	} while (time_before(jiffies, stop));
>>   	return -EBUSY;
>>   }
>> -- 
>> 2.13.3
>>
> Otherwise, looks fine.
> /Jarkko
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
