From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Tue, 18 Apr 2017 18:41:28 -0400
Subject: [PATCH 2/3] tpm: vtpm_proxy: Implement request_locality
In-Reply-To: <20170418164748.GB7181@obsidianresearch.com>
References: <1492442371-30252-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1492442371-30252-3-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170418164748.GB7181@obsidianresearch.com>
Message-ID: <4df6f613-7276-7a3a-4e3d-07657f815030@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/18/2017 12:47 PM, Jason Gunthorpe wrote:
> On Mon, Apr 17, 2017 at 11:19:30AM -0400, Stefan Berger wrote:
>> Implement the request_locality function. Accept all localties assuming
>> that the emulator handling the localities will check for a valid locality.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>   drivers/char/tpm/tpm_vtpm_proxy.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
>> index be0a268..bf59426 100644
>> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
>> @@ -371,6 +371,11 @@ static bool vtpm_proxy_tpm_req_canceled(struct tpm_chip  *chip, u8 status)
>>   	return ret;
>>   }
>>   
>> +static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
>> +{
>> +	return locality;
>> +}
> I thought we had agreed to make this function pass/fail?


What do you mean? The TIS driver for example returns the locality if 
accepted, a negative error code otherwise. In the case of the vtpm proxy 
I would let the emulator handle the locality on the level of TPM error 
codes (TPM_BAD_LOCALITY for TPM1.2 or TPM_RC_LOCALITY for TPM 2).

   Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
