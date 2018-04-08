From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Sun, 8 Apr 2018 16:01:13 -0400
Subject: [PATCH 0/5 V2] tpm: timeouts revamp
In-Reply-To: <1520338622.3779.1.camel@linux.intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
	<1520338622.3779.1.camel@linux.intel.com>
Message-ID: <65bd7ace-2780-6056-5363-c8325874c79f@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/6/2018 7:17 AM, Jarkko Sakkinen wrote:
>>
>> Second is to define timeouts for new tpm2 commands
>> defined in TCG 1.36 spec.
> 
> Where can we get that specification? I don't have that new
> version and couldn't find it from the public internet.

The published spec is 138, not 136.  You can find it here:

https://trustedcomputinggroup.org/tpm-library-specification/

I also recommend looking at either the errata or the latest draft here.

https://trustedcomputinggroup.org/specifications-public-review/



--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
