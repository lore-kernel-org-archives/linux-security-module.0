From: kgoldman@us.ibm.com (Ken Goldman)
Date: Wed, 22 Mar 2017 16:09:21 -0400
Subject: [tpmdd-devel] [PATCH v2 4/7] tpm: infrastructure for TPM spaces
In-Reply-To: <1487785159.2376.27.camel@HansenPartnership.com>
References: <20170216192529.25467-1-jarkko.sakkinen@linux.intel.com>
	<20170216192529.25467-5-jarkko.sakkinen@linux.intel.com>
	<58AC85F2.5000406@linux.vnet.ibm.com>
	<1487785159.2376.27.camel@HansenPartnership.com>
Message-ID: <f8d414fa-03f9-2c22-8ddf-497c1d281536@us.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2/22/2017 12:39 PM, James Bottomley wrote:
>
> Right at the moment the kernel use of tpm2 looks like
>
> acquire chip->tpm_mutex
> load key
> process key
> unload key
> release chip->tpm_mutex
>
> While it does this, there's no need for it to have a RM interface
> because what it does between the acquisition and drop of the mutex
> can't be seen by or have any effect on userspace (whether it uses the
> RM or not).  So currently, the question doesn't arise, which is the
> situation you see.

1 - This appears to depend on the RM not releasing the mutex until all 
objects are swapped out.  Correct?  Same for sessions?

2 - A startauthsession can cause a regap error.  Does the above depend 
on the RM doing early regapping so the RM won't see that error?

3 - There's also the problem where the TPM saved session slots 
(typically 64) are full.  My intuition is that the best solution is for 
the RM to reserve 3 slots for the kernel.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
