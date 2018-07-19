From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 19 Jul 2018 10:54:03 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <1532020750.5396.4.camel@HansenPartnership.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
	<1532020750.5396.4.camel@HansenPartnership.com>
Message-ID: <421c4b75-9e9d-7045-adad-797fd112898a@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/19/2018 10:19 AM, James Bottomley wrote:
> That's just an implementation, though, what's the use case?

Hi James,
The use case is described in the TCTI spec [1] in the
"3.2.5.2 receive" section.

Thanks,
-- 
Tadeusz

[1] https://trustedcomputinggroup.org/wp-content/uploads/TSS_TCTI_v1.0_r12_PUBLIC_REVIEW.pdf
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
