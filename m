From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 25 Oct 2017 09:22:25 -0600
Subject: [PATCH v2] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20171025152225.GC15557@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 01:55:04PM +0200, Jarkko Sakkinen wrote:
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
> v2:
> * Further defined function documentation.
> * Changed @chip_num to @chip instead of removing the parameter as suggested by
>   Jason Gunthorpe.

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
