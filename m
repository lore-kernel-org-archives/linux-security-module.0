From: serge@hallyn.com (Serge E. Hallyn)
Date: Thu, 24 Aug 2017 11:10:20 -0500
Subject: [PATCH V3 03/10] capabilities: rename has_cap to has_fcap
In-Reply-To: <8d77769c458b997ac9b07363bb865415a937848e.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<8d77769c458b997ac9b07363bb865415a937848e.1503459890.git.rgb@redhat.com>
Message-ID: <20170824161020.GC10515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> Rename has_cap to has_fcap to clarify it applies to file capabilities
> since the entire source file is about capabilities.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/commoncap.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 6f05ec0..028d4e4 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -339,7 +339,7 @@ int cap_inode_killpriv(struct dentry *dentry)
>  static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
>  					  struct linux_binprm *bprm,
>  					  bool *effective,
> -					  bool *has_cap)
> +					  bool *has_fcap)
>  {
>  	struct cred *new = bprm->cred;
>  	unsigned i;
> @@ -349,7 +349,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
>  		*effective = true;
>  
>  	if (caps->magic_etc & VFS_CAP_REVISION_MASK)
> -		*has_cap = true;
> +		*has_fcap = true;
>  
>  	CAP_FOR_EACH_U32(i) {
>  		__u32 permitted = caps->permitted.cap[i];
> @@ -438,7 +438,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data 
>   * its xattrs and, if present, apply them to the proposed credentials being
>   * constructed by execve().
>   */
> -static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_cap)
> +static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_fcap)
>  {
>  	int rc = 0;
>  	struct cpu_vfs_cap_data vcaps;
> @@ -469,7 +469,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>  		goto out;
>  	}
>  
> -	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_cap);
> +	rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
>  	if (rc == -EINVAL)
>  		printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
>  		       __func__, rc, bprm->filename);
> @@ -481,7 +481,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>  	return rc;
>  }
>  
> -void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effective, kuid_t root_uid)
> +void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap, bool *effective, kuid_t root_uid)
>  {
>  	const struct cred *old = current_cred();
>  	struct cred *new = bprm->cred;
> @@ -493,7 +493,7 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effec
>  	 * for a setuid root binary run by a non-root user.  Do set it
>  	 * for a root user just to cause least surprise to an admin.
>  	 */
> -	if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +	if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
>  		warn_setuid_and_fcaps_mixed(bprm->filename);
>  		return;
>  	}
> @@ -531,20 +531,20 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  {
>  	const struct cred *old = current_cred();
>  	struct cred *new = bprm->cred;
> -	bool effective = false, has_cap = false, is_setid;
> +	bool effective = false, has_fcap = false, is_setid;
>  	int ret;
>  	kuid_t root_uid;
>  
>  	if (WARN_ON(!cap_ambient_invariant_ok(old)))
>  		return -EPERM;
>  
> -	ret = get_file_caps(bprm, &effective, &has_cap);
> +	ret = get_file_caps(bprm, &effective, &has_fcap);
>  	if (ret < 0)
>  		return ret;
>  
>  	root_uid = make_kuid(new->user_ns, 0);
>  
> -	handle_privileged_root(bprm, has_cap, &effective, root_uid);
> +	handle_privileged_root(bprm, has_fcap, &effective, root_uid);
>  
>  	/* if we have fs caps, clear dangerous personality flags */
>  	if (cap_gained(permitted, new, old))
> @@ -574,7 +574,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	new->sgid = new->fsgid = new->egid;
>  
>  	/* File caps or setid cancels ambient. */
> -	if (has_cap || is_setid)
> +	if (has_fcap || is_setid)
>  		cap_clear(new->cap_ambient);
>  
>  	/*
> -- 
> 1.7.1
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
