From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:17:20 -0500
Subject: [PATCH V3 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
Message-ID: <20170824161719.GE10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Introduce a number of inlines to make the use of the negation of
> uid_eq() easier to read and analyse.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c |   26 +++++++++++++++++++++-----
>  1 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 36c38a1..1af7dec 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -483,6 +483,15 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_f
>  
>  static inline bool root_privileged(void) { return !issecure(SECURE_NOROOT); }
>  
> +static inline bool is_real(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->uid, uid); }
> +
> +static inline bool is_eff(kuid_t uid, struct cred *cred)
> +{ return uid_eq(cred->euid, uid); }
> +
> +static inline bool is_suid(kuid_t uid, struct cred *cred)
> +{ return !is_real(uid, cred) && is_eff(uid, cred); }
> +
>  void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effective, kuid_t root_uid)
>  {
>  	const struct cred *old = current_cred();
> @@ -493,7 +502,7 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
>  	 * for a setuid root binary run by a non-root user.  Do set it
>  	 * for a root user just to cause least surprise to an admin.
>  	 */
> -	if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +	if (has_fcap && is_suid(root_uid, new)) {
>  		warn_setuid_and_fcaps_mixed(bprm->filename);
>  		return;
>  	}
> @@ -504,12 +513,12 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
>  	 *
>  	 * If only the real uid is 0, we do not set the effective bit.
>  	 */
> -	if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> +	if (is_eff(root_uid, new) || is_real(root_uid, new)) {
>  		/* pP' = (cap_bset & ~0) | (pI & ~0) */
>  		new->cap_permitted = cap_combine(old->cap_bset,
>  						 old->cap_inheritable);
>  	}
> -	if (uid_eq(new->euid, root_uid))
> +	if (is_eff(root_uid, new))
>  		*effective = true;
>  }
>  
> @@ -519,6 +528,13 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effe
>  	!cap_issubset(cred->cap_##target, cred->cap_##source)
>  #define cap_full(field, cred) \
>  	cap_issubset(CAP_FULL_SET, cred->cap_##field)
> +
> +static inline bool is_setuid(struct cred *new, const struct cred *old)
> +{ return !uid_eq(new->euid, old->uid); }
> +
> +static inline bool is_setgid(struct cred *new, const struct cred *old)
> +{ return !gid_eq(new->egid, old->gid); }
> +
>  /**
>   * cap_bprm_set_creds - Set up the proposed credentials for execve().
>   * @bprm: The execution parameters, including the proposed creds
> @@ -556,7 +572,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	 *
>  	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>  	 */
> -	is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
> +	is_setid = is_setuid(new, old) || is_setgid(new, old);
>  
>  	if ((is_setid || cap_gained(permitted, new, old)) &&
>  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> @@ -612,7 +628,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	 */
>  	if (cap_grew(effective, ambient, new)) {
>  		if (!cap_full(effective, new) ||
> -		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> +		    !is_eff(root_uid, new) || !is_real(root_uid, new) ||
>  		    !root_privileged()) {
>  			ret = audit_log_bprm_fcaps(bprm, new, old);
>  			if (ret < 0)
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
