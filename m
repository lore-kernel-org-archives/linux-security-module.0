From: serge@hallyn.com (Serge E. Hallyn)
Date: Wed, 12 Apr 2017 09:51:28 -0500
Subject: [PATCH] capabilities: do not audit log BPRM_FCAPS on set*id
In-Reply-To: <20170412064321.GN18559@madcap2.tricolour.ca>
References: <515427654218b7ce22441f635115e93cf74d6302.1488491988.git.rgb@redhat.com>
	<20170307181049.GA31834@mail.hallyn.com>
	<20170307211048.GE10258@madcap2.tricolour.ca>
	<3292783.lRT1C7ihKT@x2>
	<20170329102911.GO9021@madcap2.tricolour.ca>
	<CAHC9VhQxbdT18tWNon30Hm3+8sMOV=2QTHO8yR1mpRbeuMqr2A@mail.gmail.com>
	<20170412064321.GN18559@madcap2.tricolour.ca>
Message-ID: <20170412145128.GA3557@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting Richard Guy Briggs (rgb at redhat.com):
> On 2017-04-11 15:36, Paul Moore wrote:
> > On Wed, Mar 29, 2017 at 6:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2017-03-09 09:34, Steve Grubb wrote:
> > >> On Tuesday, March 7, 2017 4:10:49 PM EST Richard Guy Briggs wrote:
> > >> > > > > > one possibly audit-worth case which (if I read correctly) this will
> > >> > > > > > skip is where a setuid-root binary has filecaps which *limit* its
> > >> > > > > > privs.
> > >> > > > > > Does that matter?
> > >> > > > >
> > >> > > > > I hadn't thought of that case, but I did consider in the setuid case
> > >> > > > > comparing before and after without setuid forcing the drop of all
> > >> > > > > capabilities via "ambient".  Mind you, this bug has been around before
> > >> > > > > Luto's patch that adds the ambient capabilities set.
> > >> > > >
> > >> > > > Can you suggest a scenario where that might happen?
> > >> > >
> > >> > > Sorry, do you mean the case I brought up, or the one you mentioned?  I
> > >> > > don't quite understnad the one you brought up.  For mine it's pretty
> > >> > > simple to reproduce, just
> > >> >
> > >> > I was talking about the case you brought up, but they could be the same
> > >> > case.
> > >> >
> > >> > I was thinking of a case where the caps actually change, but are
> > >> > overridden by the blanket full permissions of setuid.
> > >>
> > >> If there actually is a change in capability bits besides the implied change of
> > >> capabilities based on the change of the uid alone, then it should be logged.
> > >
> > > Are you speaking of a change in pP' only from pI, or also pI', pE' and pA'?
> > >
> > > Something like ( pP' xor pI ) not empty?
> > >
> > > The previous patch I'd sent was reasonably easy to understand, but I'm
> > > having trouble adding this new twist to the logic expression in question
> > > due to the inverted combination of pre-existing items.  I'm having
> > > trouble visualizing a 5 or more-dimensional Karnaugh map...
> > >
> > > While I am at it, I notice pA is missing from the audit record.  The
> > > record contains fields "old_pp", "old_pi", "old_pe", "new_pp", "new_pi",
> > > "new_pe" so in keeping with the previous record normalizations, I'd like
> > > to change the "new_*" variants to simply drop the "new_" prefix.
> > >
> > >         https://github.com/linux-audit/audit-kernel/issues/40
> > 
> > Yes, there is the separate ambient capabilities record patch, but
> > where do we stand with this patch?  From what I gather there is still
> > some uncertainty here?
> 
> Yes, I put this on my back burner thinking about how best to re-approach
> this, hoping others would offer some insight or advice how to attack
> this, otherwise I'm going to end up with a horrendous conditional
> expression, I fear.
> 
> Steve, I was hoping to get a clarification from you about which
> capability bits had changed.
> 
> Serge, do you have any suggestions on how to approach the conditional
> logic?

I've been looking through the thread and the github issue, but haven't
seen an example.  Can you post a patch the way you'd do it off the top
of your head, as a strawman?  In general I'm a fan of putting complicated
conditionals behind clearly named static inline helper functions, i.e.

if (should_audit_caps(current))
	// do the auditing

then when reading should_audit_caps() your mind can process more complicated
logic because it's not distracted by other things the calling function is
doing...  That's probably nothing you wouldn't do anyway so I don't think I'm
being helpful.

> > paul moore
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
