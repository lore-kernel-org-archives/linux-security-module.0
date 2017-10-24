From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 25 Oct 2017 00:29:30 +0200
Subject: [PATCH] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171024213449.GA21662@obsidianresearch.com>
References: <20171024184235.GC1806@obsidianresearch.com>
	<20171024213449.GA21662@obsidianresearch.com>
Message-ID: <20171024222930.wdsmttgujgpwmizb@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 24, 2017 at 03:34:49PM -0600, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2017 at 12:42:35PM -0600, Jason Gunthorpe wrote:
> 
> > This is compile tested only.
> 
> 0day says the kconfig has a problem when randomized, here is the fix I
> will roll into a v2 in a few days:

I will probably have to postpone the review to next week anyway so take
your time :-)

/Jarkko

> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index a95725fa77789e..ca89da3e4b2ae9 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -27,16 +27,13 @@ menuconfig TCG_TPM
>  if TCG_TPM
>  
>  config HW_RANDOM_TPM
> -       tristate "TPM HW Random Number Generator support"
> -       depends on TCG_TPM && HW_RANDOM
> -       default HW_RANDOM
> +       bool "TPM HW Random Number Generator support"
> +       depends on TCG_TPM && HW_RANDOM && !(TCG_TPM=y && HW_RANDOM=m)
> +       default y
>         ---help---
>           This driver provides kernel-side support for the Random Number
>           Generator in the Trusted Platform Module
>  
> -         To compile this driver as a module, choose M here: the
> -         module will be called tpm-rng.
> -
>           If unsure, say Y.
>  
>  config TCG_TIS_CORE
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
