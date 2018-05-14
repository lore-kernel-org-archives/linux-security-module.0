From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Mon, 14 May 2018 16:09:41 +0530
Subject: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
In-Reply-To: <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
	<20180507160733.8817-2-nayna@linux.vnet.ibm.com>
	<becb898c-b778-d104-5781-899599f536d4@gmail.com>
	<107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Message-ID: <4896f0b6-70b7-77ad-1b33-f13890b6fec2@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 05/10/2018 06:11 PM, Nayna Jain wrote:
>
>
> On 05/08/2018 10:04 PM, J Freyensee wrote:
>>
>>> ????????? do {
>>> -??????????? tpm_msleep(TPM_POLL_SLEEP);
>>> +??????????? tpm_msleep(TPM_TIMEOUT_POLL);
>>>
>> I'm just curious why it was decided to still use tpm_msleep() here 
>> instead of usleep_range() which was used in the 2nd patch.
>
> TPM_TIMEOUT_POLL is in msec i.e. 1 msec and usleep_range() is used 
> only when timeout is needed in usecs.

Just to add bit more details:

usleep_range() is used in wait_for_tpm_stat() and get_burstcount() which 
are expected to return quickly. tpm_transmit() is a generic function 
used across all drivers and commands.
Some of the commands (eg. hash, key generation) take longer compared to 
other commands (eg. extend). The sleep time in tpm_transmit is reduced 
but kept in msecs to balance between the smaller and longer commands.

Thanks & Regards,
 ??? - Nayna

>
>>
>> Otherwise,
>>
>> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
>
> Thanks !!
>
> Thanks & Regards,
> ??? - Nayna
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
