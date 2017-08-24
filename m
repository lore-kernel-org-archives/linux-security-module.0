From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:14:51 -0500
Subject: [PATCH V3 04/10] capabilities: use root_priveleged inline to
	clarify logic
In-Reply-To: <cf456cee4480719b861c5f62f0d96f9083f9f3c4.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<cf456cee4480719b861c5f62f0d96f9083f9f3c4.1503459890.git.rgb@redhat.com>
Message-ID: <20170824161451.GD10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Introduce inline root_privileged() to make use of SECURE_NONROOT
> easier to read.
> 
> Suggested-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 028d4e4..36c38a1 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -481,13 +481,13 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>  	return rc;
>  }
>  
> +static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
> +
>  void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effective, kuid_t root_uid)
>  {
>  	const struct cred *old = current_cred();
>  	struct cred *new = bprm->cred;
>  
> -	if (issecure(SECURE_NOROOT))
> -		return;
>  	/*
>  	 * If the legacy file capability is set, then don't set privs
>  	 * for a setuid root binary run by a non-root user.  Do set it
> @@ -544,7 +544,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  
>  	root_uid = make_kuid(new->user_ns, 0);
>  
> -	handle_privileged_root(bprm, has_fcap, &effective, root_uid);
> +	if (root_privileged())
> +		handle_privileged_root(bprm, has_fcap, &effective, root_uid);
>  
>  	/* if we have fs caps, clear dangerous personality flags */
>  	if (cap_gained(permitted, new, old))
> @@ -612,7 +613,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	if (cap_grew(effective, ambient, new)) {
>  		if (!cap_full(effective, new) ||
>  		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> -		    issecure(SECURE_NOROOT)) {
> +		    !root_privileged()) {
>  			ret = audit_log_bprm_fcaps(bprm, new, old);
>  			if (ret < 0)
>  				return ret;
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
