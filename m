From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:14:57 +0300
Subject: [PATCH v4 02/21] tpm: sort objects in the Makefile
In-Reply-To: <20180921135820.20549-3-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-3-tomas.winkler@intel.com>
Message-ID: <a778571533dced1fbf2a0883848972934f145eff.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> Make the tpm Makefile a bit more in order by putting
> objects in one column.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2: 1. back to tpm-y notation
>     2. Partially sort files alphanumerically.
> V3: Rebase
> V4: Remove redunant sentence in commit message.
> 
>  drivers/char/tpm/Makefile | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 4e9c33ca1f8f..efc785053627 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -3,9 +3,18 @@
>  # Makefile for the kernel tpm device drivers.
>  #
>  obj-$(CONFIG_TCG_TPM) += tpm.o
> -tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
> -	 tpm-dev-common.o tpmrm-dev.o eventlog/common.o eventlog/tpm1.o \
> -	 eventlog/tpm2.o tpm2-space.o
> +tpm-y := tpm-chip.o
> +tpm-y += tpm-dev-common.o
> +tpm-y += tpm-dev.o
> +tpm-y += tpm-interface.o
> +tpm-y += tpm2-cmd.o
> +tpm-y += tpmrm-dev.o
> +tpm-y += tpm2-space.o
> +tpm-y += tpm-sysfs.o
> +tpm-y += eventlog/common.o
> +tpm-y += eventlog/tpm1.o
> +tpm-y += eventlog/tpm2.o
> +
>  tpm-$(CONFIG_ACPI) += tpm_ppi.o eventlog/acpi.o
>  tpm-$(CONFIG_EFI) += eventlog/efi.o
>  tpm-$(CONFIG_OF) += eventlog/of.o

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
