From: rgb@redhat.com (Richard Guy Briggs)
Date: Thu, 24 Aug 2017 12:19:12 -0400
Subject: [PATCH V3 02/10] capabilities: intuitive names for cap gain status
In-Reply-To: <20170824160344.GB10515@mail.hallyn.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<9e3f99d3c2cbfee24fb3af7ec9b4cf93e4430112.1503459890.git.rgb@redhat.com>
	<20170824160344.GB10515@mail.hallyn.com>
Message-ID: <20170824161912.GI24692@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-08-24 11:03, Serge E. Hallyn wrote:
> Quoting Richard Guy Briggs (rgb at redhat.com):
> > Introduce macros cap_gained, cap_grew, cap_full to make the use of the
> > negation of is_subset() easier to read and analyse.
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/commoncap.c |   16 ++++++++++------
> >  1 files changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/commoncap.c b/security/commoncap.c
> > index b7fbf77..6f05ec0 100644
> > --- a/security/commoncap.c
> > +++ b/security/commoncap.c
> > @@ -513,6 +513,12 @@ void handle_privileged_root(struct linux_binprm *bprm, bool has_cap, bool *effec
> >  		*effective = true;
> >  }
> >  
> 
> It's subjective and so might be just me, but I think I'd find it easier
> to read if it was cap_gained(source, target, field) and cap_grew(cred, source, target)

In more than one place, I wanted to put the parameter that I was trying
to read aloud closest to the function name to make reading it flow
better, leaving the parameters less critical to comprehension towards
the end.

> This looks correct though, so either way
> 
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Thanks.  Did you want to put this through, or send it through Paul's
audit tree?

> > +#define cap_gained(field, target, source) \
> > +	!cap_issubset(target->cap_##field, source->cap_##field)
> > +#define cap_grew(target, source, cred) \
> > +	!cap_issubset(cred->cap_##target, cred->cap_##source)
> > +#define cap_full(field, cred) \
> > +	cap_issubset(CAP_FULL_SET, cred->cap_##field)
> >  /**
> >   * cap_bprm_set_creds - Set up the proposed credentials for execve().
> >   * @bprm: The execution parameters, including the proposed creds
> > @@ -541,10 +547,9 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  	handle_privileged_root(bprm, has_cap, &effective, root_uid);
> >  
> >  	/* if we have fs caps, clear dangerous personality flags */
> > -	if (!cap_issubset(new->cap_permitted, old->cap_permitted))
> > +	if (cap_gained(permitted, new, old))
> >  		bprm->per_clear |= PER_CLEAR_ON_SETID;
> >  
> > -
> >  	/* Don't let someone trace a set[ug]id/setpcap binary with the revised
> >  	 * credentials unless they have the appropriate permit.
> >  	 *
> > @@ -552,8 +557,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  	 */
> >  	is_setid = !uid_eq(new->euid, old->uid) || !gid_eq(new->egid, old->gid);
> >  
> > -	if ((is_setid ||
> > -	     !cap_issubset(new->cap_permitted, old->cap_permitted)) &&
> > +	if ((is_setid || cap_gained(permitted, new, old)) &&
> >  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> >  	     !ptracer_capable(current, new->user_ns))) {
> >  		/* downgrade; they get no more than they had, and maybe less */
> > @@ -605,8 +609,8 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
> >  	 * Number 1 above might fail if you don't have a full bset, but I think
> >  	 * that is interesting information to audit.
> >  	 */
> > -	if (!cap_issubset(new->cap_effective, new->cap_ambient)) {
> > -		if (!cap_issubset(CAP_FULL_SET, new->cap_effective) ||
> > +	if (cap_grew(effective, ambient, new)) {
> > +		if (!cap_full(effective, new) ||
> >  		    !uid_eq(new->euid, root_uid) || !uid_eq(new->uid, root_uid) ||
> >  		    issecure(SECURE_NOROOT)) {
> >  			ret = audit_log_bprm_fcaps(bprm, new, old);
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
