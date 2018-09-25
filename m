From: nayna@linux.vnet.ibm.com (Nayna Jain)
Date: Tue, 25 Sep 2018 21:55:27 +0530
Subject: [PATCH v3 06/20] tpm: move tpm1_pcr_extend to tpm1-cmd.c
In-Reply-To: <20180919140634.GA27854@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-7-tomas.winkler@intel.com>
	<20180919140634.GA27854@linux.intel.com>
Message-ID: <7af3302c-3c46-ebc7-bf9b-704c8eaaa6b7@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 09/19/2018 07:36 PM, Jarkko Sakkinen wrote:
> On Tue, Sep 18, 2018 at 12:34:45PM +0300, Tomas Winkler wrote:
>> Move tpm1_pcr_extend to tpm1-cmd.c and remove
>> unused pcrextend_header structure.
>>
>> Fixes warning:
>> drivers/char/tpm/tpm-interface.c:609:38: warning: ?pcrextend_header? defined but not used [-Wunused-const-variable=]
>>   static const struct tpm_input_header pcrextend_header = {
>>                                        ^~~~~~~~~~~~~~~~
>> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> Can someone with a working IMA environment to test it? Don't have one
> right now (should probably setup).

I think I can try testing this patch sometime next week. I will test the 
updated version.

Thanks & Regards,
 ??? - Nayna

>
> /Jarkko
>
