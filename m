From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Fri, 4 May 2018 00:06:00 +0000
Subject: [PATCH 2/6] ima: prevent sysfs fallback firmware loading
In-Reply-To: <1525182503-13849-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1525182503-13849-3-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20180504000600.GQ27853@wotan.suse.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, May 01, 2018 at 09:48:19AM -0400, Mimi Zohar wrote:
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 754ece08e1c6..8759280dccf6 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -453,7 +453,17 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  		}
>  		return 0;
>  	}
> +
> +	if (read_id == READING_FIRMWARE_FALLBACK) {
> +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent firmware sysfs fallback loading.\n");
> +			return -EACCES;
> +		}
> +		return 0;
> +	}
>  	return 0;
> +
>  }
>  

Due to the lack of ability to appraise these calls, it has me wondering if having
these drivers be wrapped into a their own kconfig may make sense, ie, they use
a mechanism which IMA cannot possibly work with. Then at least some kernel
builds can exist in which we know we can count on this run time to never
happen. Thoughts?

See for instance use of CONFIG_PREVENT_FIRMWARE_BUILD.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
