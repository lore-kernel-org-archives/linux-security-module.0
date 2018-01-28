From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Sun, 28 Jan 2018 13:15:59 -0700
Subject: [PATCH 1/2 v2] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180128075101.6883-2-tomas.winkler@intel.com>
References: <20180128075101.6883-1-tomas.winkler@intel.com>
	<20180128075101.6883-2-tomas.winkler@intel.com>
Message-ID: <20180128201559.GG23869@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 28, 2018 at 09:51:00AM +0200, Tomas Winkler wrote:

> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index bcdd3790e94d..06639fb6ab85 100644
> +++ b/include/linux/tpm.h
> @@ -44,7 +44,7 @@ struct tpm_class_ops {
>  	bool (*update_timeouts)(struct tpm_chip *chip,
>  				unsigned long *timeout_cap);
>  	int (*request_locality)(struct tpm_chip *chip, int loc);
> -	void (*relinquish_locality)(struct tpm_chip *chip, int loc);
> +	int (*relinquish_locality)(struct tpm_chip *chip, int loc);

This seems wrong.. What is the core code supposed to do if relinquish
fails?

Just returning an error code from transmit doesn't really do anything
helpful from a broad subsytem perspective.

I think if a driver can fail reliquish then it needs some kind of
strategy to recover.

Suggest trying the reliquish again on every next request until
success, otherwise fail request locality, potentially permanently.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
