From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 18:10:45 +0300
Subject: [PATCH v3 14/20] tpm: tpm-interface.c drop unused macros
In-Reply-To: <20180918093459.19165-15-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-15-tomas.winkler@intel.com>
Message-ID: <20180919151045.GG31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:53PM +0300, Tomas Winkler wrote:
> The code movement left some macros unused.

Rewrite the long description and the language is horrible. The code
movement maps to nothing.  Should be something along the lines: "The
migration of the TPM 1.x code has left some unused macros to
tpm-interface.c. Remove those macros."

/Jarkko

> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V3: new in the series
> 
>  drivers/char/tpm/tpm-interface.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index a8f8e0bcb434..358ef5bd601e 100644
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
> -- 
> 2.14.4
> 
