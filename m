From: jmorris@namei.org (James Morris)
Date: Tue, 20 Jun 2017 11:22:00 +1000 (AEST)
Subject: [GIT PULL] tpmdd fixes for 4.13
In-Reply-To: <1497833925.14670.3.camel@linux.intel.com>
References: <1497833925.14670.3.camel@linux.intel.com>
Message-ID: <alpine.LRH.2.20.1706201121401.10628@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 19 Jun 2017, Jarkko Sakkinen wrote:

> Hi
> 
> Here are thpdates for 4.13.
> 
> Major changes:
> 
> - Releasing and relinquishing of locality in tpm_vtpm_proxy for each
> ? command/response sequence.
> - Consolidating platform and ACPI driver in tpm_tis.
> - Sanitize endian conversions for TPM 1.2 commands i.e. call
> ? cpu_to_be32() in place when required. Do not have it in the constant
> ? definition.

Pulled to -next, thanks.


-- 
James Morris
<jmorris@namei.org>
