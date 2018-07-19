From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Thu, 19 Jul 2018 08:55:38 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <5984eedf-792f-2d8c-be7a-143ca570592a@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/19/2018 08:52 AM, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough buffer
> the TCTI spec says that the library should set the required size and return
> TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
> allocate a bigger buffer and call receive again.
> To make it possible in the TSS library this requires being able to do
> partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.
> 
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

This needs to go on top of this:
https://patchwork.kernel.org/patch/10460863/

Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
