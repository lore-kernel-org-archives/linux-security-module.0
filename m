From: rgb@redhat.com (Richard Guy Briggs)
Date: Wed, 29 Mar 2017 06:29:11 -0400
Subject: [PATCH] capabilities: do not audit log BPRM_FCAPS on set*id
In-Reply-To: <3292783.lRT1C7ihKT@x2>
References: <515427654218b7ce22441f635115e93cf74d6302.1488491988.git.rgb@redhat.com>
	<20170307181049.GA31834@mail.hallyn.com>
	<20170307211048.GE10258@madcap2.tricolour.ca>
	<3292783.lRT1C7ihKT@x2>
Message-ID: <20170329102911.GO9021@madcap2.tricolour.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 2017-03-09 09:34, Steve Grubb wrote:
> On Tuesday, March 7, 2017 4:10:49 PM EST Richard Guy Briggs wrote:
> > > > > > one possibly audit-worth case which (if I read correctly) this will
> > > > > > skip is where a setuid-root binary has filecaps which *limit* its
> > > > > > privs.
> > > > > > Does that matter?
> > > > > 
> > > > > I hadn't thought of that case, but I did consider in the setuid case
> > > > > comparing before and after without setuid forcing the drop of all
> > > > > capabilities via "ambient".  Mind you, this bug has been around before
> > > > > Luto's patch that adds the ambient capabilities set.
> > > > 
> > > > Can you suggest a scenario where that might happen?
> > > 
> > > Sorry, do you mean the case I brought up, or the one you mentioned?  I
> > > don't quite understnad the one you brought up.  For mine it's pretty
> > > simple to reproduce, just
> > 
> > I was talking about the case you brought up, but they could be the same
> > case.
> > 
> > I was thinking of a case where the caps actually change, but are
> > overridden by the blanket full permissions of setuid.
> 
> If there actually is a change in capability bits besides the implied change of 
> capabilities based on the change of the uid alone, then it should be logged.

Are you speaking of a change in pP' only from pI, or also pI', pE' and pA'?

Something like ( pP' xor pI ) not empty?

The previous patch I'd sent was reasonably easy to understand, but I'm
having trouble adding this new twist to the logic expression in question
due to the inverted combination of pre-existing items.  I'm having
trouble visualizing a 5 or more-dimensional Karnaugh map...


While I am at it, I notice pA is missing from the audit record.  The
record contains fields "old_pp", "old_pi", "old_pe", "new_pp", "new_pi",
"new_pe" so in keeping with the previous record normalizations, I'd like
to change the "new_*" variants to simply drop the "new_" prefix.

	https://github.com/linux-audit/audit-kernel/issues/40

> -Steve

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Kernel Security Engineering, Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
