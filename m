From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 18 Sep 2017 21:02:50 +0300
Subject: about context gap
In-Reply-To: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
References: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
Message-ID: <20170918180250.6db5ti4gpinqr5jz@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 16, 2017 at 08:36:29AM -0700, Jarkko Sakkinen wrote:
> Hi
> 
> While sitting at the airport I started to think a bit about the context
> gap issue.
> 
> I think first thing that would make sense would be to have a 64-bit
> shadow count for every TPM space i.e.
> 
> atomic_long_t tpm2_ctx_cnt;
> 
> struct tpm2_space {
> 	/* ... */
> 	u64 ctx_cnt;
> };
> 
> For every create and load of a session you will read the global count
> and increase it. This way we have get a well defined order.
> 
> With this organization we could for example put tpm spaces to a
> red-black tree and refresh the oldest tpm space (just first thought
> that came to mind).
> 
> PS. While doing LPC and LSS slides I found error from the TPM 2.0
> commands specification. TPM2_ContextSave can never emit
> TPM2_RC_CONTEXT_GAP albeit the specification says so.
> 
> /Jarkko

Other than context gap it would probably make sense to estimate TPM
capacity in order to make implementation more intelligent. We could
measure memory capacity of a TPM in the driver initialization by filling
it with fixed size dummy objects.

TPM2_GetCapability gives stuff that cannot be really trusted as spec
compliant TPM HW could just return always '1' for max.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
