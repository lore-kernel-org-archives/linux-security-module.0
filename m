From: john.johansen@canonical.com (John Johansen)
Date: Mon, 21 May 2018 08:33:52 -0700
Subject: [PATCH 26/33] apparmor: use match_string() helper
In-Reply-To: <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
	<1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
Message-ID: <06051489-f5fd-b7bd-d5be-db3706dbded3@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/21/2018 04:58 AM, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 

Andy Shevchenko patch to do the same thing is already in apparmor-next

> Cc: John Johansen <john.johansen@canonical.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module at vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  security/apparmor/lsm.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index ce2b89e..9b5904f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1378,14 +1378,12 @@ static int param_set_audit(const char *val, const struct kernel_param *kp)
>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>  		return -EPERM;
>  
> -	for (i = 0; i < AUDIT_MAX_INDEX; i++) {
> -		if (strcmp(val, audit_mode_names[i]) == 0) {
> -			aa_g_audit = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(audit_mode_names, AUDIT_MAX_INDEX, val);
> +	if (i < 0)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	aa_g_audit = i;
> +	return 0;
>  }
>  
>  static int param_get_mode(char *buffer, const struct kernel_param *kp)
> @@ -1409,14 +1407,13 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>  		return -EPERM;
>  
> -	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
> -		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
> -			aa_g_profile_mode = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(aa_profile_mode_names,
> +			 APPARMOR_MODE_NAMES_MAX_INDEX, val);
> +	if (i)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	aa_g_profile_mode = i;
> +	return 0;
>  }
>  
>  /*
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
