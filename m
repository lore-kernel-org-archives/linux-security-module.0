From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 20 Jun 2017 16:58:19 -0400
Subject: [tpmdd-devel] [PATCH] tpm: consolidate the TPM startup code
In-Reply-To: <20170620193152.GA3368@obsidianresearch.com>
References: <20170620181334.28363-1-jarkko.sakkinen@linux.intel.com>
	<20170620193152.GA3368@obsidianresearch.com>
Message-ID: <ba8acc37-f751-ddbf-48a0-e5ece6cecbd2@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/20/2017 3:31 PM, Jason Gunthorpe wrote:
>> 
>> +#define TPM_ORD_STARTUP 153 +#define TPM_ST_CLEAR 1
> 
> We should really have a tpm1.h and tpm2.h that has all these various 
> constants and things instead of open coding them randomly all over..

While you're doing that, perhaps put the ordinal numbers in hex.  The
TPM 1.2 spec uses both hex and decimal, but TPM 2.0 uses hex.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
