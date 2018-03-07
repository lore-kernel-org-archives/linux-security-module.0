From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 7 Mar 2018 11:51:32 -0700
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
In-Reply-To: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
Message-ID: <20180307185132.GA30102@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
> TPM_CRB driver is the TPM support for ARM64.  If it
> is built as module, TPM chip is registered after IMA
> init.  tpm_pcr_read() in IMA driver would fail and
> display the following message even though eventually
> there is TPM chip on the system:
> 
> ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> 
> Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> built in kernel and initializes before IMA driver.
> 
> Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 35ef693..6a8f677 100644
> +++ b/security/integrity/ima/Kconfig
> @@ -10,6 +10,7 @@ config IMA
>  	select CRYPTO_HASH_INFO
>  	select TCG_TPM if HAS_IOMEM && !UML
>  	select TCG_TIS if TCG_TPM && X86
> +	select TCG_CRB if TCG_TPM && ACPI
>  	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
>  	help
>  	  The Trusted Computing Group(TCG) runtime Integrity

This seems really weird, why are any specific TPM drivers linked to
IMA config, we have lots of drivers..

I don't think I've ever seen this pattern in Kconfig before?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
