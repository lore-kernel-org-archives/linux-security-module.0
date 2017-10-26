From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 16:08:41 +0200
Subject: [PATCH v3] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
References: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20171026140841.6x2lplwijnhwzkqc@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 03:54:50PM +0200, Jarkko Sakkinen wrote:
> Device number (the character device index) is not a stable identifier
> for a TPM chip. That is the reason why every call site passes
> TPM_ANY_NUM to tpm_chip_find_get().
> 
> This commit changes the API in a way that instead a struct tpm_chip
> instance is given and NULL means the default chip. In addition, this
> commit refines the documentation to be up to date with the
> implementation.
> 
> Suggested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (@chip_num -> @chip)
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Jason, once you have given this reviewed-by can you do a patch set that
includes this and your and PrasannaKumar's change? It could be a while
before keyring and IMA maintainers have reviewed my change.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
