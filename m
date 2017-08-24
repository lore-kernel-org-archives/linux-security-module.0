From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:18:39 -0500
Subject: [PATCH V3 06/10] capabilities: move audit log decision to function
In-Reply-To: <0ef18e4236773f4ccd55f9b47639adb6a992d104.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<0ef18e4236773f4ccd55f9b47639adb6a992d104.1503459890.git.rgb@redhat.com>
Message-ID: <20170824161839.GF10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Move the audit log decision logic to its own function to isolate the
> complexity in one place.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   50 ++++++++++++++++++++++++++++++--------------------
>  1 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 1af7dec..5d81354 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -535,6 +535,32 @@ static inline bool is_setuid(struct cred *new, const struct cred *old)
>  static inline bool is_setgid(struct cred *new, const struct cred *old)
>  { return !gid_eq(new->egid, old->gid); }
>  
> +/*
> + * Audit candidate if current->cap_effective is set
> + *
> + * We do not bother to audit if 3 things are true:
> + *   1) cap_effective has all caps
> + *   2) we are root
> + *   3) root is supposed to have all caps (SECURE_NOROOT)
> + * Since this is just a normal root execing a process.
> + *
> + * Number 1 above might fail if you don't have a full bset, but I think
> + * that is interesting information to audit.
> + */
> +static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
> +{
> +	bool ret = false;
> +
> +	if (cap_grew(effective, ambient, cred)) {
> +		if (!cap_full(effective, cred) ||
> +		    !is_eff(root, cred) || !is_real(root, cred) ||
> +		    !root_privileged()) {
> +			ret = true;
> +		}
> +	}
> +	return ret;
> +}
> +
>  /**
>   * cap_bprm_set_creds - Set up the proposed credentials for execve().
>   * @bprm: The execution parameters, including the proposed creds
> @@ -614,26 +640,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  
>  	bprm->cap_effective = effective;
>  
> -	/*
> -	 * Audit candidate if current->cap_effective is set
> -	 *
> -	 * We do not bother to audit if 3 things are true:
> -	 *   1) cap_effective has all caps
> -	 *   2) we are root
> -	 *   3) root is supposed to have all caps (SECURE_NOROOT)
> -	 * Since this is just a normal root execing a process.
> -	 *
> -	 * Number 1 above might fail if you don't have a full bset, but I think
> -	 * that is interesting information to audit.
> -	 */
> -	if (cap_grew(effective, ambient, new)) {
> -		if (!cap_full(effective, new) ||
> -		    !is_eff(root_uid, new) || !is_real(root_uid, new) ||
> -		    !root_privileged()) {
> -			ret = audit_log_bprm_fcaps(bprm, new, old);
> -			if (ret < 0)
> -				return ret;
> -		}
> +	if (nonroot_raised_pE(new, root_uid)) {
> +		ret = audit_log_bprm_fcaps(bprm, new, old);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
