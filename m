From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 12 Oct 2017 14:19:43 +0300
Subject: [PATCH v3 5/5] tpm: use tpm_msleep() value as max delay
In-Reply-To: <20171004102924.12355-6-nayna@linux.vnet.ibm.com>
References: <20171004102924.12355-1-nayna@linux.vnet.ibm.com>
	<20171004102924.12355-6-nayna@linux.vnet.ibm.com>
Message-ID: <20171012111943.vy43q2mkiqmrbuvc@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 04, 2017 at 06:29:24AM -0400, Nayna Jain wrote:
> Currently, tpm_msleep() uses delay_msec as the minimum value in
> usleep_range. However, that is the maximum time we want to wait.
> The function is modified to use the delay_msec as the maximum
> value, not the minimum value.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~9sec to ~8sec.
> 
> Fixes: 3b9af007869("tpm: replace msleep() with usleep_range() in TPM 1.2/
> 2.0 generic drivers")
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Acked-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 4fc83ac7abeb..644de70de2cc 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -528,8 +528,8 @@ int tpm_pm_resume(struct device *dev);
>  
>  static inline void tpm_msleep(unsigned int delay_msec)
>  {
> -	usleep_range(delay_msec * 1000,
> -		     (delay_msec * 1000) + TPM_TIMEOUT_RANGE_US);
> +	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> +		     delay_msec * 1000);
>  };
>  
>  struct tpm_chip *tpm_chip_find_get(int chip_num);
> -- 
> 2.13.3
> 

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
