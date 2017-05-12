From: rgb@redhat.com (Richard Guy Briggs)
Date: Fri, 12 May 2017 07:37:18 -0400
Subject: [RFC PATCH V2 1/4] capabilities: use macros to make the logic
	easier to follow and verify
In-Reply-To: <20170512053516.GA29944@mail.hallyn.com>
References: <cover.1494527628.git.rgb@redhat.com>
	<f676394915d5a3b3feb3ffc2f1587575bc13deaa.1494527628.git.rgb@redhat.com>
	<20170512053516.GA29944@mail.hallyn.com>
Message-ID: <20170512113718.GA25861@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-05-12 00:35, Serge E. Hallyn wrote:
> On Thu, May 11, 2017 at 04:42:40PM -0400, Richard Guy Briggs wrote:
> > This change is intended to be logic-neutral and simply make the logic easier to
> > read in natural language and verify without getting distracted by details.
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/commoncap.c |   53 ++++++++++++++++++++++++++++++++-----------------
> >  1 files changed, 34 insertions(+), 19 deletions(-)
> > 
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index 78b3783..9520f0a 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -497,6 +497,16 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  	int ret;
> >  	kuid_t root_uid;
> >  
> 
> The #defines make me uncomfortable, especially the lack of parens around
> them.  The way they are used seems fine, but they seem like potential
> future maintenance issues.  I definately appreciate the way you broke
> the functionality down, though.  And I'm not sure I can improve on it.

I wrestled with #defines vs functions and the #defines won because they
were cleaner without parameters in parens to cloud the reading of the
logic.  I could go with local variables to assign these a value, but
they would be evaluated at the time of setting the local variable (which
would be fine for most of the variables involved) but also use local
stack space, though the compiler may be smart enough to optimize it
away.  This was also why I quickly undefined them as soon as
practicable.

> > +#define SROOT !issecure(SECURE_NOROOT) /* root is special */
> 
> maybe
> 
> static inline bool root_privileged() { return !issecure(SECURE_NOROOT); }

That is one of the few clean ones that doesn't need any other parameters
(such as "new" and "old" and the recently computed "root_uid").

> > +#define RROOT uid_eq(new->uid, root_uid) /* real root */
> > +#define EROOT uid_eq(new->euid, root_uid) /* effective root */
> > +#define SETUIDROOT !RROOT && EROOT /* set uid root */
> 
> Yeah every time I start typing an alternative it doesn't look as good.

Yup, this one was originally SUIDROOT which would have conflicted with SUID.

> > +#define SUID !uid_eq(new->euid, old->uid) /* set uid */
> > +#define SGID !gid_eq(new->egid, old->gid) /* set gid */
> > +#define pPADD !cap_issubset(new->cap_permitted, old->cap_permitted) /* process permitted capabilities have been added */
> > +#define pESET !cap_issubset(new->cap_effective, new->cap_ambient) /* process effective capabilities have been set */
> > +#define pEALL cap_issubset(CAP_FULL_SET, new->cap_effective) /* process effective capabilities are full set */
> > +#define pAADD !cap_issubset(new->cap_ambient, old->cap_ambient) /* process ambient capabilities have been added */
> >  	if (WARN_ON(!cap_ambient_invariant_ok(old)))
> >  		return -EPERM;
> >  
> > @@ -507,13 +517,13 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  
> >  	root_uid = make_kuid(new->user_ns, 0);
> >  
> > -	if (!issecure(SECURE_NOROOT)) {
> > +	if (SROOT) {
> >  		/*
> >  		 * If the legacy file capability is set, then don't set privs
> >  		 * for a setuid root binary run by a non-root user.  Do set it
> >  		 * for a root user just to cause least surprise to an admin.
> >  		 */
> > -		if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> > +		if (has_cap && SETUIDROOT) {
> >  			warn_setuid_and_fcaps_mixed(bprm->filename);
> >  			goto skip;
> >  		}
> > @@ -521,33 +531,32 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  		 * To support inheritance of root-permissions and suid-root
> >  		 * executables under compatibility mode, we override the
> >  		 * capability sets for the file.
> > -		 *
> > -		 * If only the real uid is 0, we do not set the effective bit.
> >  		 */
> > -		if (uid_eq(new->euid, root_uid) || uid_eq(new->uid, root_uid)) {
> > +		if (EROOT || RROOT) {
> >  			/* pP' = (cap_bset & ~0) | (pI & ~0) */
> >  			new->cap_permitted = cap_combine(old->cap_bset,
> >  							 old->cap_inheritable);
> >  		}
> > -		if (uid_eq(new->euid, root_uid))
> > +		/*
> > +		 * If only the real uid is root, we do not set the effective bit.
> > +		 */
> > +		if (EROOT)
> >  			effective = true;
> >  	}
> >  skip:
> >  
> >  	/* if we have fs caps, clear dangerous personality flags */
> > -	if (!cap_issubset(new->cap_permitted, old->cap_permitted))
> > +	if (pPADD)
> >  		bprm->per_clear |= PER_CLEAR_ON_SETID;
> >  
> > +	is_setid = SUID || SGID;
> >  
> >  	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
> >  	 * credentials unless they have the appropriate permit.
> >  	 *
> >  	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
> >  	 */
> > -	is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
> > -
> > -	if ((is_setid ||
> > -	     !cap_issubset(new->cap_permitted, old->cap_permitted)) &&
> > +	if ((is_setid || pPADD) &&
> >  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> >  	     !ptracer_capable(current, new->user_ns))) {
> >  		/* downgrade; they get no more than they had, and maybe less */
> > @@ -599,14 +608,10 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  	 * Number 1 above might fail if you don't have a full bset, but I think
> >  	 * that is interesting information to audit.
> >  	 */
> > -	if (!cap_issubset(new->cap_effective, new->cap_ambient)) {
> > -		if (!cap_issubset(CAP_FULL_SET, new->cap_effective) ||
> > -		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> > -		    issecure(SECURE_NOROOT)) {
> > -			ret = audit_log_bprm_fcaps(bprm, new, old);
> > -			if (ret < 0)
> > -				return ret;
> > -		}
> > +	if (pESET && (!pEALL || !EROOT || !RROOT || !SROOT) ) {
> 
> This might be better served by a separate helper 
> 
> 	if (nonroot_raised_e(new, root_uid)) {
> 		ret = audit_log_bprm_fcaps(bprm, new, old);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
> > +		ret = audit_log_bprm_fcaps(bprm, new, old);
> > +		if (ret < 0)
> > +			return ret;
> >  	}
> >  
> >  	new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
> > @@ -615,6 +620,16 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  		return -EPERM;
> >  
> >  	return 0;
> > +#undef SROOT
> > +#undef RROOT
> > +#undef EROOT
> > +#undef SETUIDROOT
> > +#undef SUID
> > +#undef SGID
> > +#undef pPADD
> > +#undef pESET
> > +#undef pEALL
> > +#undef pAADD
> >  }
> >  
> >  /**
> > -- 
> > 1.7.1

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
