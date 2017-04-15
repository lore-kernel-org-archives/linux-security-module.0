From: greg@kroah.com (Greg KH)
Date: Sat, 15 Apr 2017 22:50:32 +0200
Subject: [backport v4.9] tpm_tis: use default timeout value if chip
	reports it as zero
In-Reply-To: <20170415152622.14451-1-user@jsakkine-mobl1>
References: <20170415152622.14451-1-user@jsakkine-mobl1>
Message-ID: <20170415205032.GA17774@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Apr 15, 2017 at 06:26:22PM +0300, Jarkko Sakkinen wrote:
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

What is the git commit id for this patch in Linus's tree?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
