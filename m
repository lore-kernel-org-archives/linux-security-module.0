From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:39:01 +0300
Subject: [PATCH v4 14/21] tpm: tpm-interface.c drop unused macros
In-Reply-To: <20180921135820.20549-15-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-15-tomas.winkler@intel.com>
Message-ID: <bf9342175181934b1324d3cf118dca3d41268685.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> The commit:
> "tpm_tis: further simplify calculation of ordinal duration"
> left unused macros, we can drop them now.
> 
> Fixes compilation warnings:
> tpm-interface.c:37:0: warning: macro "TPM_PROTECTED_COMMAND" is not used [-
> Wunused-macros]
> tpm-interface.c:36:0: warning: macro "TSC_MAX_ORDINAL" is not used [-Wunused-
> macros]
> tpm-interface.c:38:0: warning: macro "TPM_CONNECTION_COMMAND" is not used [-
> Wunused-macros]
> 
> Fixes: f72864300139 ("tpm_tis: further simplify calculation of ordinal
> duration")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V3: New in the series.
> V4: Fix the commit message.
> 
>  drivers/char/tpm/tpm-interface.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-
> interface.c
> index 6cd3aed1e190..d7059fc72c51 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -33,10 +33,6 @@
>  
>  #include "tpm.h"
>  
> -#define TSC_MAX_ORDINAL 12
> -#define TPM_PROTECTED_COMMAND 0x00
> -#define TPM_CONNECTION_COMMAND 0x40
> -
>  /*
>   * Bug workaround - some TPM's don't flush the most
>   * recently changed pcr on suspend, so force the flush

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
