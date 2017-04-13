From: sgrubb@redhat.com (Steve Grubb)
Date: Thu, 13 Apr 2017 15:36:12 -0400
Subject: [PATCH] capabilities: do not audit log BPRM_FCAPS on set*id
In-Reply-To: <20170413085056.GP1572@madcap2.tricolour.ca>
References: <515427654218b7ce22441f635115e93cf74d6302.1488491988.git.rgb@redhat.com>
	<1833607.dNomLM3Ooh@x2>
	<20170413085056.GP1572@madcap2.tricolour.ca>
Message-ID: <2229474.OLsFFx6DaB@x2>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thursday, April 13, 2017 4:50:56 AM EDT Richard Guy Briggs wrote:
> > > > >> > I was thinking of a case where the caps actually change, but are
> > > > >> > overridden by the blanket full permissions of setuid.
> > > > >> 
> > > > >> If there actually is a change in capability bits besides the
> > > > >> implied change of capabilities based on the change of the uid
> > > > >> alone, then it should be logged.
> > > > > 
> > > > > Are you speaking of a change in pP' only from pI, or also pI', pE'
> > > > > and pA'?
> > > > > 
> > > > > Something like ( pP' xor pI ) not empty?
> 
> This is what I'm trying to clarify.

Any change other than what is expected. When you execute a setuid root 
application, its no surprise and expected that it got all capabilities. So, we 
do not want capabilities recorded. If, however, something prevented it and it 
wound up with one capability only, then it is a surprise and should be logged 
assuming the file is being watched for execution. Similarly if we have a watch 
on a non-setuid program and it does pick up capabilities due to file system 
based capabilities, then we want to know what capabilities were picked up.


> > > > > The previous patch I'd sent was reasonably easy to understand, but
> > > > > I'm having trouble adding this new twist to the logic expression in
> > > > > question due to the inverted combination of pre-existing items.  I'm
> > > > > having trouble visualizing a 5 or more-dimensional Karnaugh map...
> > > > > 
> > > > > While I am at it, I notice pA is missing from the audit record.  The
> > > > > record contains fields "old_pp", "old_pi", "old_pe", "new_pp",
> > > > > "new_pi", "new_pe" so in keeping with the previous record
> > > > > normalizations, I'd like to change the "new_*" variants to simply
> > > > > drop the "new_" prefix.
> > > > > 
> > > > > https://github.com/linux-audit/audit-kernel/issues/40
> > > > 
> > > > Yes, there is the separate ambient capabilities record patch, but
> > > > where do we stand with this patch?  From what I gather there is still
> > > > some uncertainty here?
> > > 
> > > Yes, I put this on my back burner thinking about how best to re-approach
> > > this, hoping others would offer some insight or advice how to attack
> > > this, otherwise I'm going to end up with a horrendous conditional
> > > expression, I fear.
> > > 
> > > Steve, I was hoping to get a clarification from you about which
> > > capability bits had changed.
> > 
> > I am not sure what you are asking of me.
> 
> I'm trying to understand exactly which capability sets should be
> compared to determine if there was a material change, but perhaps that
> question is better asked of Serge.  What does the certification care
> about in terms that helps me code this?

When its a file system based capabilities and the file has a watch for 
execute, we want the capabilities. If there is a watch for execute on non-
setuid file and it gets ambient capabilities, we want the capabilities. When 
there's a watch on a setuid root for execute, we only want capabilities when 
the process does not get full capabilities..

-Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
