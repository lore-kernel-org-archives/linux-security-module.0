From: john.johansen@canonical.com (John Johansen)
Date: Tue, 8 May 2018 10:55:15 -0700
Subject: [PATCH v1] apparmor: Convert to use match_string() helper
In-Reply-To: <20180507133903.39041-1-andriy.shevchenko@linux.intel.com>
References: <20180507133903.39041-1-andriy.shevchenko@linux.intel.com>
Message-ID: <0c13a36f-2d24-768d-775f-cff911950a45@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/07/2018 06:39 AM, Andy Shevchenko wrote:
> The new helper returns index of the matching string in an array.
> We are going to use it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

looks good thanks
Acked-by: John Johansen <john.johansen@canonical.com>

I've pulled it into apparmor-next


> ---
>  security/apparmor/lsm.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 033221d4fc6c..9d5006744356 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1392,14 +1392,12 @@ static int param_set_audit(const char *val, const struct kernel_param *kp)
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
> @@ -1423,14 +1421,12 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>  		return -EPERM;
>  
> -	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
> -		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
> -			aa_g_profile_mode = i;
> -			return 0;
> -		}
> -	}
> +	i = match_string(aa_profile_mode_names, APPARMOR_MODE_NAMES_MAX_INDEX, val);
> +	if (i < 0)
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
