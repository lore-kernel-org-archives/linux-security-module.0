From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 23 Jul 2018 23:19:56 +0300
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180723201956.GB26824@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jul 19, 2018 at 08:52:32AM -0700, Tadeusz Struk wrote:
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

For non-blocking operation I see the benefit because it does not break
the ABI and it really simplifies threading in the user space.

In this case I do not have any major evidence of any major benefit *and*
the change breaks the ABI.

Linux does not *have* to implement in kernel level every tidbit of the
TCG spec but it *can* provide support in places where it makes sense
and things do not break.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
