From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 06 Jun 2018 09:24:04 -0400
Subject: [PATCH v2] integrity: silence warning when CONFIG_SECURITYFS is
	not enabled
In-Reply-To: <1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
References: <1528121121-3959-1-git-send-email-sudeep.holla@arm.com>
	<1528194345-9956-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1528291444.3255.4.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-06-05 at 11:25 +0100, Sudeep Holla wrote:
> When CONFIG_SECURITYFS is not enabled, securityfs_create_dir returns
> -ENODEV which throws the following error:
> 	"Unable to create integrity sysfs dir: -19"
> 
> However, if the feature is disabled, it can't be warning and hence
> we need to silence the error. This patch checks for the error -ENODEV
> which is returned when CONFIG_SECURITYFS is disabled to stop the error
> being thrown.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  security/integrity/iint.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> v1->v2:
> 	- Check for -ENODEV rather than IS_ENABLED(..) as suggested by
> 	  Matthew Garrett
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 149faa81f6f0..7051ea4a8161 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -219,10 +219,13 @@ static int __init integrity_fs_init(void)
>  {
>  	integrity_dir = securityfs_create_dir("integrity", NULL);
>  	if (IS_ERR(integrity_dir)) {
> -		pr_err("Unable to create integrity sysfs dir: %ld\n",
> -		       PTR_ERR(integrity_dir));
> +		int ret = PTR_ERR(integrity_dir);
> +
> +		if (ret != -ENODEV)
> +			pr_err("Unable to create integrity sysfs dir: %ld\n",
> +			       ret;

Can we replace "sysfs" to "securityfs" at the same time?

>  		integrity_dir = NULL;
> -		return PTR_ERR(integrity_dir);
> +		return ret;
>  	}
> 
>  	return 0;
> --
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
