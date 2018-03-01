From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 1 Mar 2018 11:58:40 +0200
Subject: [RFC PATCH 3/3] tpm: tpm_msleep() with finer granularity
	improves performance
In-Reply-To: <20180228191828.20056-3-nayna@linux.vnet.ibm.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
	<20180228191828.20056-3-nayna@linux.vnet.ibm.com>
Message-ID: <20180301095840.GD29420@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Feb 28, 2018 at 02:18:28PM -0500, Nayna Jain wrote:
> When 'commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
> in TPM 1.2/2.0 generic drivers")' was upstreamed, it replaced the

"was upstreamed" is redundant information. If you speak about commit ID,
it is expected to be in the mainline. Why there is "'" before the word
'commit'?

Just write

  In commit 9f3fc7bcddcb ("tpm: replace msleep() with  usleep_range()
  in TPM 1.2/2.0 generic drivers")' msleep() was replaced with
  usleep_range().

> msleep() calls with usleep_range(), but did not change the
> granularity of the calls. They're still defined in terms of msec.
> Test results show that refining the granularity further improves
> the performance. We're posting this patch as an RFC to show that there
> needs to be another function which allows finer granularity.
> 
> After this change, performance on a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~10.7sec to ~6.9sec.

Environment where this result was achieved would be mandatory.

> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 7e797377e1eb..8cad6bfc5f46 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -522,8 +522,7 @@ int tpm_pm_resume(struct device *dev);
>  
>  static inline void tpm_msleep(unsigned int delay_msec)
>  {
> -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
> -		     delay_msec * 1000);
> +	usleep_range((delay_msec * 1000) / 10, (delay_msec * 1000) / 2);

Shouldn't the max be 'delay_msec * 1000'? Where do these numbers
come from?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
