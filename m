From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 26 Sep 2017 14:46:59 -0400
Subject: about context gap
In-Reply-To: <20170918180250.6db5ti4gpinqr5jz@linux.intel.com>
References: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
	<20170918180250.6db5ti4gpinqr5jz@linux.intel.com>
Message-ID: <03018f5e-4afc-7db5-b5a8-dfed8e2bd8d2@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/18/2017 2:02 PM, Jarkko Sakkinen wrote:

> Other than context gap it would probably make sense to estimate TPM
> capacity in order to make implementation more intelligent. We could
> measure memory capacity of a TPM in the driver initialization by filling
> it with fixed size dummy objects.
> 
> TPM2_GetCapability gives stuff that cannot be really trusted as spec
> compliant TPM HW could just return always '1' for max.

I don't see anything in the TPM specs that claim the TPM can return 1.

E.g., the PC Client spec says that loaded sessions must return a minimum 
of 3.  Active sessions must return a minimum of 64.

I think the resource manager can safely use these getcapability values.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
