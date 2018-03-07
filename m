From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 07 Mar 2018 14:21:35 -0500
Subject: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
In-Reply-To: <1520449719.5558.28.camel@HansenPartnership.com>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
	<20180307185132.GA30102@ziepe.ca>
	<1520448953.10396.565.camel@linux.vnet.ibm.com>
	<1520449719.5558.28.camel@HansenPartnership.com>
Message-ID: <1520450495.10396.587.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-03-07 at 11:08 -0800, James Bottomley wrote:
> On Wed, 2018-03-07 at 13:55 -0500, Mimi Zohar wrote:
> > On Wed, 2018-03-07 at 11:51 -0700, Jason Gunthorpe wrote:
> > > 
> > > On Tue, Mar 06, 2018 at 11:26:26PM -0600, Jiandi An wrote:
> > > > 
> > > > TPM_CRB driver is the TPM support for ARM64.??If it
> > > > is built as module, TPM chip is registered after IMA
> > > > init.??tpm_pcr_read() in IMA driver would fail and
> > > > display the following message even though eventually
> > > > there is TPM chip on the system:
> > > > 
> > > > ima: No TPM chip found, activating TPM-bypass! (rc=-19)
> > > > 
> > > > Fix IMA Kconfig to select TPM_CRB so TPM_CRB driver is
> > > > built in kernel and initializes before IMA driver.
> > > > 
> > > > Signed-off-by: Jiandi An <anjiandi@codeaurora.org>
> > > > ?security/integrity/ima/Kconfig | 1 +
> > > > ?1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/security/integrity/ima/Kconfig
> > > > b/security/integrity/ima/Kconfig
> > > > index 35ef693..6a8f677 100644
> > > > +++ b/security/integrity/ima/Kconfig
> > > > @@ -10,6 +10,7 @@ config IMA
> > > > ?	select CRYPTO_HASH_INFO
> > > > ?	select TCG_TPM if HAS_IOMEM && !UML
> > > > ?	select TCG_TIS if TCG_TPM && X86
> 
> Well, this explains why IMA doesn't work on one of my X86 systems: it's
> got a non i2c infineon TPM.
> 
> > > > +	select TCG_CRB if TCG_TPM && ACPI
> > > > ?	select TCG_IBMVTPM if TCG_TPM && PPC_PSERIES
> > > > ?	help
> > > > ?	??The Trusted Computing Group(TCG) runtime Integrity
> > > 
> > > This seems really weird, why are any specific TPM drivers linked to
> > > IMA config, we have lots of drivers..
> > > 
> > > I don't think I've ever seen this pattern in Kconfig before?
> > 
> > As you've seen by the current discussions, the TPM driver needs to be
> > initialized prior to IMA. ?Otherwise IMA goes into TPM-bypass mode.
> > ?That implies that the TPM must be builtin to the kernel, and not as
> > a kernel module.
> 
> Actually, that's not necessarily true: ?If we don't begin appraisal
> until after the initrd phase, then the initrd can load TPM modules
> before IMA starts.
> 
> This would involve a bit of code rejigging to not require a TPM until
> IMA wants to write its first measurement, but it looks doable and would
> get us out of having to second guess TPM selections.

The question is about measurement, not appraisal. ?Although the
initramfs might be measured, the initramfs can access files on the
real root filesystem. ?Those files need to be measured, before they
are used/accessed.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
