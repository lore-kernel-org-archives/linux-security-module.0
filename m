From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 19 Jul 2018 10:19:10 -0700
Subject: [PATCH] tpm: add support for partial reads
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <1532020750.5396.4.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2018-07-19 at 08:52 -0700, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one
> go.  The application doesn't know how big the response it beforehand
> so it always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough
> buffer the TCTI spec says that the library should set the required
> size and return TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that
> the application could allocate a bigger buffer and call receive
> again. To make it possible in the TSS library this requires being
> able to do partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.
> 
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e2468
> 3d30b05800648d8a264c

That's just an implementation, though, what's the use case?

I'm curious because all the TPM applications I've written need to be
aware of TPM2B_MAX_BUFFER_SIZE, which is related to MAX_RESPONSE_SIZE
because you can't go over that for big buffer commands (mostly sealing
and unsealing).

The TCG supporting routines define MAX_RESPONSE_SIZE to be 4096, so you
know absolutely how large a buffer you have to have ... and the value
is rather handy for us because if it were larger we'd have to do
scatter gather.

I think the point is that knowing the max buffer size allows us to
behave like UDP: if your packet is the wrong size it gets dropped and
relieves the applications from having to do fragmentation and
reassembly.  Since the max size is so low, what's the benefit of not
assuming the application has to know it?

James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
