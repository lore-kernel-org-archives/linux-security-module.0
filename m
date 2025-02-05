Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BA2288C3;
	Wed,  5 Feb 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756897; cv=none; b=e69epGyTy8kytlhOBUCliS/p8qm8VvT/MuHiyJ142/kPhyrlPs8JEoSjDaea2rvCxOgcnPnUu8pSYBNGfxQqMwcr2p71ruFHLZsKrvnw+YMhEPRGXwSpaeDlT1SBtSV6VUUA8bkxSVfIHYJ5TQjitkVfJsXl6UiT2+9ZzzTnZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756897; c=relaxed/simple;
	bh=WAeq4BEFXXSX6jShyygg3gjPfLk6uyqHt8itTUj+cwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdzT0wSgfkZXsn7metGx3lhH5um+nOPjuqvjDzFFteJ9QpmBVkkW3NFniMA9tQPwRV5WAnqqHl1BzrbbxumA74foHsT0UXzM1AT5tigNmm7R7TWSBgJsOIl0djG4FVW8lHtnEqj8dvX+tkEG6udAz9LrlLosKivDL3Jg7PYZkO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 515C0S39015867;
	Wed, 5 Feb 2025 06:00:28 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 515C0QIm015866;
	Wed, 5 Feb 2025 06:00:26 -0600
Date: Wed, 5 Feb 2025 06:00:26 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Greg Wettstein <greg@enjellic.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250205120026.GA15809@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 05 Feb 2025 06:00:28 -0600 (CST)

On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:

Good morning, I hope mid-week is going well for everyone.

After the issue of the functionality of modern cryptographic
primitives, a discussion of the second most important issue Paul
raises.

> > > > +In an externally modeled namespace, the event type and parameters are
> > > > +exported to userspace for processing by a trust orchestrator with an
> > > > +associated TMA.  The trust orchestrator communicates the result of the
> > > > +modeling back to the kernel to support the setting of the process
> > > > +trust status.
> > > > +
> > > > +The exception to this model are for security event handlers that are
> > > > +called in atomic, ie. non-sleeping context.  The export of these
> > > > +security event descriptions are done asynchronously in order to avoid
> > > > +having the TSEM implementation attempt to sleep in atomic context
> > > > +while the userspace trust orchestrator is scheduled for execution.
> > > > +
> > > > +It is up to the trust orchestrator and its security policy to
> > > > +determine how it handles events that violate the security model being
> > > > +enforced in this model.  The Quixote trust orchestrators shut down the
> > > > +entire workload running in the security namespace if an asynchronously
> > > > +modeled event violates the security model being enforced and the model
> > > > +is running in enforcing mode.

> > > I understand your desire to simply pass off the non-blocking/async
> > > access control hole as a security policy issue, but it seems to me
> > > that this is a fundamental flaw with an externally modeled TSEM
> > > namespace.  If an externally modeled namespace was configured with
> > > an enforcing policy, it doesn't appear that there is a mechanism for
> > > TSEM to properly enforce that policy as there is an unbounded delay
> > > between the undesired access and a denial verdict being processed by
> > > the kernel.
> > >
> > > Unless you can resolve this somehow, and I'm not sure how, I would
> > > suggest dropping external/userspace trust orchestrators.  They
> > > simply don't seem able to reliably implement their security
> > > policies.

> > An important issue.
> >
> > Some reflections on why we would, respectfully, disagree.
> >
> > A business assessment of the current security market suggests that the
> > mindset in security has changed from prevention to detection.  TSEM is
> > about providing kernel infrastructure to enable better solutions for
> > the detection model.

> I believe the LSM can support both the enforcement of security policy
> and the observation of security relevant events on a system.  In fact
> most of the existing LSMs do both, at least to some extent.
> 
> However, while logging of security events likely needs to be
> asynchronous for performance reasons, enforcement of security policy
> likely needs to be synchronous to have any reasonable level of
> assurance.  You are welcome to propose LSMs which provide
> observability functionality that is either sync, async, or some
> combination of both (? it would need to make sense to do both ?), but
> I'm not currently interested in accepting LSMs that provide
> asynchronous enforcement as I don't view that as a "reasonable"
> enforcement mechanism.

This is an artificial distinction that will prove limiting to the
security that Linux will be able to deliver in the future.
	
Based on your response, is it your stated position as Linux security
maintainer, that you consider modern Endpoint Detection and Response
Systems (EDRS) lacking with respect to their ability to implement a
"reasonable" enforcement and assurance mechanism?

If this is the case, your philosophy leaves Linux in a position that
is inconsistent with how the industry is choosing to implement
security.

Let me cite an example from one of our project advisors.

This individual is a senior principal at a reasonably large technology
products company that depends on Linux almost exclusively to support
its operations.  At any given instant he participates in supervising a
fleet of around 6,000 virtual machines running about 50,000-60,000
containerized workloads.

All of the Linux deployments are Ansible orchestrated.  The security
deployment consists of disabling SeLinux and installing an EDRS
solution.  Doing the latter checks all the boxes they need for their
corporate security compliance policies.

He, and others, have watched this discussion closely over the last two
years that we have tried to get TSEM reviewed and just recently phoned
me with the following comment:

"I think the problem is that these guys don't understand how security
is being done and the reasons why".

There is probably not a modern EDRS solution that does not involve
going to the cloud for its decision making enforcement, in most cases
based on Indicators Of Compromise (IOC) trained machine learning
models.  Asynchronous detection, enforcement and remediation is now
standard practice.  In the security industry, a 1 minute response to a
security event is considered the 'gold' standard.

For the sake of discussion, lets take a Quixote userspace Trusted
Modeling Agent (TMA) running TSEM based deterministic modeling of a
containerized workload.  As we've discussed previously, demonstrated
average response times are on the order of 170 micro-seconds.

For an event that needs asynchronous enforcement, ie. running in
atomic context, that represents a 3.5 order of magnitude advantage in
response over the industry standard, without the attendant challenges
of going off machine or installing kernel based infrastructure.

What would be the rationale or advantage of denying those that desire
this type of security option, a 3,500 fold increase in security
response times?

Let's take another need for running in userspace, trusted execution
environments.  Support is available in our userspace package for
running a TMA model in either an SGX enclave or in an independent
hypervisor protected execution context, both of which significantly
harden the enforcement implementation against attack by adversaries.

As Linux security maintainer, we assume that you have read Executive
Order 14144 signed on January 16th 2025.  That document specifically
calls out the requirement for the increased use of trusted execution
environments in combination with advancements in endpoint detection.

It shouldn't be a leap in imagination as to the regulatory compliance
advantages associated with hardware attestation that the security
implementation is operational and in a known good enforcement state.

Finally, at this point in time, it would seem unwise in the technology
industry, to discount the importance of 'AI', or more correctly
machine learning.  As we've noted before in our discussions, it is
unlikely that we are going to see synchronous LSM enforcement using a
machine learning model trained on potentially trillions of data
observations and indicators.

The LSM is designed to provide security services to the users of
Linux, not to be a kingdom.

Linux is/was about 'choice' as to how users want to use their
hardware.

Artifically limiting the types of security that can be implemented by
the LSM works to the detriment of the security innovation that Linux
can deliver and the Linux user community writ large.

> paul-moore.com

Best wishes for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
