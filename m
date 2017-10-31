From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 31 Oct 2017 14:03:03 -0600
Subject: [PATCH v3] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
References: <20171026135453.24672-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20171031200303.GB18578@ziepe.ca>
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

Reviewed-by: Jason Gunthorpe <jgg@ziepe.ca>

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
