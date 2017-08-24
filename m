From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:20:29 -0500
Subject: [PATCH V3 07/10] capabilities: remove a layer of conditional logic
In-Reply-To: <b656082f8697c02165b4240ecf4ae60fe08811dd.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<b656082f8697c02165b4240ecf4ae60fe08811dd.1503459890.git.rgb@redhat.com>
Message-ID: <20170824162029.GG10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Remove a layer of conditional logic to make the use of conditions
> easier to read and analyse.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5d81354..ffcaff0 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -551,13 +551,12 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
>  {
>  	bool ret = false;
>  
> -	if (cap_grew(effective, ambient, cred)) {
> -		if (!cap_full(effective, cred) ||
> -		    !is_eff(root, cred) || !is_real(root, cred) ||
> -		    !root_privileged()) {
> -			ret = true;
> -		}
> -	}
> +	if (cap_grew(effective, ambient, cred) &&
> +	    (!cap_full(effective, cred) ||
> +	     !is_eff(root, cred) ||
> +	     !is_real(root, cred) ||
> +	     !root_privileged()))
> +		ret = true;
>  	return ret;
>  }
>  
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
