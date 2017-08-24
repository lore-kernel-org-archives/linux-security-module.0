From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:35:59 -0500
Subject: [PATCH V3 10/10] capabilities: audit log other surprising
	conditions
In-Reply-To: <11df9e69904600785a8a609f471ff30431ef5464.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<11df9e69904600785a8a609f471ff30431ef5464.1503459890.git.rgb@redhat.com>
Message-ID: <20170824163559.GJ10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> The existing condition tested for process effective capabilities set by file
> attributes but intended to ignore the change if the result was unsurprisingly an
> effective full set in the case root is special with a setuid root executable
> file and we are root.
> 
> Stated again:
> - When you execute a setuid root application, it is no surprise and expected
> that it got all capabilities, so we do not want capabilities recorded.
>         if (pE_grew && !(pE_fullset && (eff_root || real_root) && root_priveleged) )
> 
> Now make sure we cover other cases:
> - If something prevented a setuid root app getting all capabilities and it
> wound up with one capability only, then it is a surprise and should be logged.
> When it is a setuid root file, we only want capabilities when the process does
> not get full capabilities..
>         root_priveleged && setuid_root && !pE_fullset
> 
> - Similarly if a non-setuid program does pick up capabilities due to file system
> based capabilities, then we want to know what capabilities were picked up.
> When it has file system based capabilities we want the capabilities.
>         !is_setuid && (has_fcap && pP_gained)
> 
> - If it is a non-setuid file and it gets ambient capabilities, we want the
> capabilities.
>         !is_setuid && pA_gained
> 
> - These last two are combined into one due to the common first parameter.
> 
> Related: https://github.com/linux-audit/audit-kernel/issues/16
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 49cce06..8da965c 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -536,7 +536,7 @@ static inline bool is_setgid(struct cred *new, const struct cred *old)
>  { return !gid_eq(new->egid, old->gid); }
>  
>  /*
> - * Audit candidate if current->cap_effective is set
> + * 1) Audit candidate if current->cap_effective is set
>   *
>   * We do not bother to audit if 3 things are true:
>   *   1) cap_effective has all caps
> @@ -546,16 +546,28 @@ static inline bool is_setgid(struct cred *new, const struct cred *old)
>   *
>   * Number 1 above might fail if you don't have a full bset, but I think
>   * that is interesting information to audit.
> + *
> + * A number of other conditions require logging:
> + * 2) something prevented setuid root getting all caps
> + * 3) non-setuid root gets fcaps
> + * 4) non-setuid root gets ambient
>   */
> -static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
> +static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old, kuid_t root, bool has_fcap)
>  {
>  	bool ret = false;
>  
> -	if (cap_grew(effective, ambient, cred) &&
> -	    !(cap_full(effective, cred) &&
> -	      (is_eff(root, cred) ||
> -	       is_real(root, cred)) &&
> -	      root_privileged()))
> +	if ((cap_grew(effective, ambient, new) &&
> +	     !(cap_full(effective, new) &&
> +	       (is_eff(root, new) ||
> +	        is_real(root, new)) &&
> +	       root_privileged())) ||
> +	    (root_privileged() &&
> +	     is_suid(root, new) &&
> +	     !cap_full(effective, new)) ||
> +	    (!is_setuid(new, old) &&
> +	     ((has_fcap &&
> +               cap_gained(permitted, new, old)) ||
> +              cap_gained(ambient, new, old))))
>  		ret = true;
>  	return ret;
>  }
> @@ -639,7 +651,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  
>  	bprm->cap_effective = effective;
>  
> -	if (nonroot_raised_pE(new, root_uid)) {
> +	if (nonroot_raised_pE(new, old, root_uid, has_fcap)) {
>  		ret = audit_log_bprm_fcaps(bprm, new, old);
>  		if (ret < 0)
>  			return ret;
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
