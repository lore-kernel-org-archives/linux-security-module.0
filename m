From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Sat, 15 Apr 2017 18:04:05 +0200
Subject: [backport v4.9] tpm_tis: use default timeout value if chip
	reports it as zero
In-Reply-To: <20170415152622.14451-1-user@jsakkine-mobl1>
References: <20170415152622.14451-1-user@jsakkine-mobl1>
Message-ID: <420a825b-9845-7029-482c-aec297265107@maciej.szmigiero.name>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Jarkko,

On 15.04.2017 17:26, Jarkko Sakkinen wrote:
> From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
>
> Since commit 1107d065fdf1 ("tpm_tis: Introduce intermediate layer for
> TPM access") Atmel 3203 TPM on ThinkPad X61S (TPM firmware version 13.9)
> no longer works.  The initialization proceeds fine until we get and
> start using chip-reported timeouts - and the chip reports C and D
> timeouts of zero.
>
> It turns out that until commit 8e54caf407b98e ("tpm: Provide a generic
> means to override the chip returned timeouts") we had actually let
> default timeout values remain in this case, so let's bring back this
> behavior to make chips like Atmel 3203 work again.
>
> Use a common code that was introduced by that commit so a warning is
> printed in this case and /sys/class/tpm/tpm*/timeouts correctly says the
> timeouts aren't chip-original.
>
> Fixes: 1107d065fdf1 ("tpm_tis: Introduce intermediate layer for TPM access")
> Cc: stable at vger.kernel.org
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> Backport v4.9. Can you test it?
>  drivers/char/tpm/tpm-interface.c | 59 ++++++++++++++++++++++------------------
>  drivers/char/tpm/tpm_tis.c       |  2 +-
>  drivers/char/tpm/tpm_tis_core.c  |  6 ++--
>  drivers/char/tpm/tpm_tis_core.h  |  2 +-
>  4 files changed, 38 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 3a9149cf0110..4c914fe25802 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
(..)
> @@ -537,16 +537,15 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  		goto duration;
>  	}
>
> -	if (be32_to_cpu(tpm_cmd.header.out.return_code) != 0 ||
> -	    be32_to_cpu(tpm_cmd.header.out.length)
> -	    != sizeof(tpm_cmd.header.out) + sizeof(u32) + 4 * sizeof(u32))
> -		return -EINVAL;
> -

Is this part right?
These tests weren't removed by this commit as present in the mainline kernel.

Maciej

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
