From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 12 May 2017 08:50:50 -0500
Subject: [RFC PATCH V2 1/4] capabilities: use macros to make the logic
	easier to follow and verify
In-Reply-To: <f676394915d5a3b3feb3ffc2f1587575bc13deaa.1494527628.git.rgb@redhat.com>
References: <cover.1494527628.git.rgb@redhat.com>
	<f676394915d5a3b3feb3ffc2f1587575bc13deaa.1494527628.git.rgb@redhat.com>
Message-ID: <20170512135050.GA5624@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> This change is intended to be logic-neutral and simply make the logic easier to
> read in natural language and verify without getting distracted by details.
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/commoncap.c |   53 ++++++++++++++++++++++++++++++++-----------------
>  1 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 78b3783..9520f0a 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -497,6 +497,16 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	int ret;
>  	kuid_t root_uid;
>  
> +#define SROOT !issecure(SECURE_NOROOT) /* root is special */
> +#define RROOT uid_eq(new->uid, root_uid) /* real root */
> +#define EROOT uid_eq(new->euid, root_uid) /* effective root */
> +#define SETUIDROOT !RROOT && EROOT /* set uid root */
> +#define SUID !uid_eq(new->euid, old->uid) /* set uid */
> +#define SGID !gid_eq(new->egid, old->gid) /* set gid */
> +#define pPADD !cap_issubset(new->cap_permitted, old->cap_permitted) /* process permitted capabilities have been added */
> +#define pESET !cap_issubset(new->cap_effective, new->cap_ambient) /* process effective capabilities have been set */
> +#define pEALL cap_issubset(CAP_FULL_SET, new->cap_effective) /* process effective capabilities are full set */
> +#define pAADD !cap_issubset(new->cap_ambient, old->cap_ambient) /* process ambient capabilities have been added */
>  	if (WARN_ON(!cap_ambient_invariant_ok(old)))
>  		return -EPERM;

Ok, I'm going to offer a few alternatives below.  Please feel free to
say you think yours is better, and I'll simply ack that.  I just feel
obliged to give it the old college try,

> @@ -507,13 +517,13 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  
>  	root_uid = make_kuid(new->user_ns, 0);
>  
> -	if (!issecure(SECURE_NOROOT)) {
> +	if (SROOT) {
>  		/*
>  		 * If the legacy file capability is set, then don't set privs
>  		 * for a setuid root binary run by a non-root user.  Do set it
>  		 * for a root user just to cause least surprise to an admin.
>  		 */
> -		if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +		if (has_cap && SETUIDROOT) {

Thinking about this some more last night, there are two things which make these
checks harder to read than they should be.  One is the fact that the brain can
have a hard time with negation.  The second is that we have long conditionals
in which the pieces are expressed using the mechanism we need to express what
we want, rather than what we are really asking.    So sometimes just coming up
with a different name for a function can help clarify its use, i.e.
uid_changed(from, to) instead of !uid_eq.

So the above I think would be much easier as

		if (has_cap && did_setuid_to(new, root_uid)) {

Needing to predefine root_uid is unfortunate.  Perhaps giving it a shorter name
like 'root' would help in some of these lines.  So then

		if (has_cap && did_setuid_to(new, root)) {

>  			warn_setuid_and_fcaps_mixed(bprm->filename);
>  			goto skip;
>  		}
> @@ -521,33 +531,32 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  		 * To support inheritance of root-permissions and suid-root
>  		 * executables under compatibility mode, we override the
>  		 * capability sets for the file.
> -		 *
> -		 * If only the real uid is 0, we do not set the effective bit.
>  		 */
> -		if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> +		if (EROOT || RROOT) {

		if (same_real_uid(new, root) || same_eff_uid(new, root))

>  			/* pP' = (cap_bset & ~0) | (pI & ~0) */
>  			new->cap_permitted = cap_combine(old->cap_bset,
>  							 old->cap_inheritable);
>  		}
> -		if (uid_eq(new->euid, root_uid))
> +		/*
> +		 * If only the real uid is root, we do not set the effective bit.
> +		 */
> +		if (EROOT)
>  			effective = true;

		if (same_eff_uid(new, root))

>  	}
>  skip:
>  
>  	/* if we have fs caps, clear dangerous personality flags */
> -	if (!cap_issubset(new->cap_permitted, old->cap_permitted))
> +	if (pPADD)
>  		bprm->per_clear |= PER_CLEAR_ON_SETID;

		if (p_caps_grew(old, new))

Not quite sure whether p_caps_grew, e_caps_grew, a_caps_grew() are
nicer, or caps_grew(old, new, field).  i like the latter, but when
seeing the final patch maybe the former would be clearer.  But so maybe

		if (caps_grew(old, new, permitted))

>  
> +	is_setid = SUID || SGID;

	is_setid = eff_uid_changed(old, new) || eff_gid_changed(old, new)

uid_changed() is a trivial change, but i think is a lot more helpful while
reading this.

>  
>  	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
>  	 * credentials unless they have the appropriate permit.
>  	 *
>  	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>  	 */
> -	is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
> -
> -	if ((is_setid ||
> -	     !cap_issubset(new->cap_permitted, old->cap_permitted)) &&
> +	if ((is_setid || pPADD) &&

	if ((is_setid || p_caps_grew(old, new)) &&

>  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
>  	     !ptracer_capable(current, new->user_ns))) {
>  		/* downgrade; they get no more than they had, and maybe less */
> @@ -599,14 +608,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  	 * Number 1 above might fail if you don't have a full bset, but I think
>  	 * that is interesting information to audit.
>  	 */
> -	if (!cap_issubset(new->cap_effective, new->cap_ambient)) {
> -		if (!cap_issubset(CAP_FULL_SET, new->cap_effective) ||
> -		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> -		    issecure(SECURE_NOROOT)) {
> -			ret = audit_log_bprm_fcaps(bprm, new, old);
> -			if (ret < 0)
> -				return ret;
> -		}
> +	if (pESET && (!pEALL || !EROOT || !RROOT || !SROOT) ) {

And this I still think this should be a separate function, though what
you have obviously helped you reason about its correctness.

> +		ret = audit_log_bprm_fcaps(bprm, new, old);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
> @@ -615,6 +620,16 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  		return -EPERM;
>  
>  	return 0;
> +#undef SROOT
> +#undef RROOT
> +#undef EROOT
> +#undef SETUIDROOT
> +#undef SUID
> +#undef SGID
> +#undef pPADD
> +#undef pESET
> +#undef pEALL
> +#undef pAADD

Lastly, the first !issecure(SECURE_NOROOT) block could stand to be a
separate function.

	handle_privileged_root(bprm, has_cap, &effective, root);
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
