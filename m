From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 16 Sep 2017 08:36:29 -0700
Subject: about context gap
Message-ID: <20170916153540.w5lpsqz3cwpd3enx@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi

While sitting at the airport I started to think a bit about the context
gap issue.

I think first thing that would make sense would be to have a 64-bit
shadow count for every TPM space i.e.

atomic_long_t tpm2_ctx_cnt;

struct tpm2_space {
	/* ... */
	u64 ctx_cnt;
};

For every create and load of a session you will read the global count
and increase it. This way we have get a well defined order.

With this organization we could for example put tpm spaces to a
red-black tree and refresh the oldest tpm space (just first thought
that came to mind).

PS. While doing LPC and LSS slides I found error from the TPM 2.0
commands specification. TPM2_ContextSave can never emit
TPM2_RC_CONTEXT_GAP albeit the specification says so.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
