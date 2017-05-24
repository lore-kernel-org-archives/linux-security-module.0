From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Wed, 24 May 2017 18:59:41 -0400
Subject: [PATCH v6 1/3] tpm: Introduce flag TPM_TRANSMIT_RAW
In-Reply-To: <20170524221840.lv37joufkdepa5ci@intel.com>
References: <1495661981-27249-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1495661981-27249-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170524221840.lv37joufkdepa5ci@intel.com>
Message-ID: <c505607a-9ce2-779c-a0d8-acfb2f598673@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/24/2017 06:18 PM, Jarkko Sakkinen wrote:
> On Wed, May 24, 2017 at 05:39:39PM -0400, Stefan Berger wrote:
>> Introduce the flag TPM_TRANSMIT_RAW that allows us to transmit
>> a command without recursing into the requesting of locality.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> I'll rename the constant as TPM_TRANSMIT_NO_LOCALITY if you don't mind.

Fine by me.


     Stefan

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
