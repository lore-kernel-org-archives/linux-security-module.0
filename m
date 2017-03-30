From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 30 Mar 2017 16:06:17 -0500
Subject: [PATCH 9/9] kernel-api.rst: fix a series of errors when parsing
	C files
In-Reply-To: <5c39bc852b201759de4cf901f7e9ad04715285d9.1490904090.git.mchehab@s-opensource.com>
References: <cover.1490904090.git.mchehab@s-opensource.com>
	<5c39bc852b201759de4cf901f7e9ad04715285d9.1490904090.git.mchehab@s-opensource.com>
Message-ID: <20170330210617.GA28207@bhelgaas-glaptop.roam.corp.google.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 30, 2017 at 05:11:36PM -0300, Mauro Carvalho Chehab wrote:
> ./lib/string.c:134: WARNING: Inline emphasis start-string without end-string.
> ./mm/filemap.c:522: WARNING: Inline interpreted text or phrase reference start-string without end-string.
> ./mm/filemap.c:1283: ERROR: Unexpected indentation.
> ./mm/filemap.c:3003: WARNING: Inline interpreted text or phrase reference start-string without end-string.
> ./mm/vmalloc.c:1544: WARNING: Inline emphasis start-string without end-string.
> ./mm/page_alloc.c:4245: ERROR: Unexpected indentation.
> ./ipc/util.c:676: ERROR: Unexpected indentation.
> ./drivers/pci/irq.c:35: WARNING: Block quote ends without a blank line; unexpected unindent.
> ./security/security.c:109: ERROR: Unexpected indentation.
> ./security/security.c:110: WARNING: Definition list ends without a blank line; unexpected unindent.
> ./block/genhd.c:275: WARNING: Inline strong start-string without end-string.
> ./block/genhd.c:283: WARNING: Inline strong start-string without end-string.
> ./include/linux/clk.h:134: WARNING: Inline emphasis start-string without end-string.
> ./include/linux/clk.h:134: WARNING: Inline emphasis start-string without end-string.
> ./ipc/util.c:477: ERROR: Unknown target name: "s".
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# for drivers/pci/irq.c

> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 6684f153ab57..f9f2a0324ecc 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -31,7 +31,7 @@ static void pci_note_irq_problem(struct pci_dev *pdev, const char *reason)
>   * driver).
>   *
>   * Returns:
> - *  a suggestion for fixing it (although the driver is not required to
> + * a suggestion for fixing it (although the driver is not required to
>   * act on this).
>   */
>  enum pci_lost_interrupt_reason pci_lost_interrupt(struct pci_dev *pdev)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
