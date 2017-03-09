From: sgrubb@redhat.com (Steve Grubb)
Date: Thu, 09 Mar 2017 09:34:53 -0500
Subject: [PATCH] capabilities: do not audit log BPRM_FCAPS on set*id
In-Reply-To: <20170307211048.GE10258@madcap2.tricolour.ca>
References: <515427654218b7ce22441f635115e93cf74d6302.1488491988.git.rgb@redhat.com>
	<20170307181049.GA31834@mail.hallyn.com>
	<20170307211048.GE10258@madcap2.tricolour.ca>
Message-ID: <3292783.lRT1C7ihKT@x2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tuesday, March 7, 2017 4:10:49 PM EST Richard Guy Briggs wrote:
> > > > > one possibly audit-worth case which (if I read correctly) this will
> > > > > skip is where a setuid-root binary has filecaps which *limit* its
> > > > > privs.
> > > > > Does that matter?
> > > > 
> > > > I hadn't thought of that case, but I did consider in the setuid case
> > > > comparing before and after without setuid forcing the drop of all
> > > > capabilities via "ambient".  Mind you, this bug has been around before
> > > > Luto's patch that adds the ambient capabilities set.
> > > 
> > > Can you suggest a scenario where that might happen?
> > 
> > Sorry, do you mean the case I brought up, or the one you mentioned?  I
> > don't quite understnad the one you brought up.  For mine it's pretty
> > simple to reproduce, just
> 
> I was talking about the case you brought up, but they could be the same
> case.
> 
> I was thinking of a case where the caps actually change, but are
> overridden by the blanket full permissions of setuid.

If there actually is a change in capability bits besides the implied change of 
capabilities based on the change of the uid alone, then it should be logged.

-Steve

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
