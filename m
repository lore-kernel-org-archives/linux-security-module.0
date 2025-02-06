Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F99921CFF7;
	Thu,  6 Feb 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738845981; cv=none; b=hyWro5ytiyZY84Fl69RqFajUEuwvHNiBCIoHdvzekh8vuj8ogerk1+DlqyluIxSuBQAl56y+X3nntv6ph2UOuSfvL1Owq1vukqVGzyM350+38V6BoN0r4tQ8Pa7FPLgdprstkNNpHdG+poyTkUif2vY4EnRxcsm6Fr6JIIPwAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738845981; c=relaxed/simple;
	bh=LzPmLR4NECVJzanm9D7VrWg3lHEbiyR22YsArEv+U6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTxeewmED3NLp6jy8ZlFBUEny9LSDLnnbVZgfAqOrROzhRyzwWCS+AEE9LCqUwA6IpLw1s9q5R8jINHTXTqqDm0A5zT3oFPqmdrXPK6O9qkDpq9zEvSl3LX07wizfT6MMc+xQooFe/P2V2nA/VK0K32YSoIhzQD7hgjzBCc2c3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 516CjkJa027957;
	Thu, 6 Feb 2025 06:45:46 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 516CjiQD027956;
	Thu, 6 Feb 2025 06:45:44 -0600
Date: Thu, 6 Feb 2025 06:45:44 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
Message-ID: <20250206124544.GA27587@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240826103728.3378-3-greg@enjellic.com> <8642afa96650e02f50709aa3361b62c4@paul-moore.com> <20250205120026.GA15809@wind.enjellic.com> <e8ec2704-90bf-4e67-9e90-eb206e6d08c0@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8ec2704-90bf-4e67-9e90-eb206e6d08c0@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 06 Feb 2025 06:45:46 -0600 (CST)

On Wed, Feb 05, 2025 at 11:58:00AM -0800, Casey Schaufler wrote:

Good morning, I hope the week is progressing well.

I need to climb on an airplane in less than 24 hours to fly to Aspen
to spend some time skiing with the 'beautiful people', so only two
comments.

> On 2/5/2025 4:00 AM, Dr. Greg wrote:
> > On Tue, Jan 28, 2025 at 05:23:52PM -0500, Paul Moore wrote:
> >
> > Good morning, I hope mid-week is going well for everyone.
> >
> > After the issue of the functionality of modern cryptographic
> > primitives, a discussion of the second most important issue Paul
> > raises.
> >
> >> I believe the LSM can support both the enforcement of security policy
> >> and the observation of security relevant events on a system.  In fact
> >> most of the existing LSMs do both, at least to some extent.
> >>
> >> However, while logging of security events likely needs to be
> >> asynchronous for performance reasons, enforcement of security policy
> >> likely needs to be synchronous to have any reasonable level of
> >> assurance.  You are welcome to propose LSMs which provide
> >> observability functionality that is either sync, async, or some
> >> combination of both (? it would need to make sense to do both ?), but
> >> I'm not currently interested in accepting LSMs that provide
> >> asynchronous enforcement as I don't view that as a "reasonable"
> >> enforcement mechanism.
> > This is an artificial distinction that will prove limiting to the
> > security that Linux will be able to deliver in the future.

> I'll apologize up front to everyone else for this response, but I
> hope it is something you might understand.
> 
> A security guard scans a person's access pass. As the computer system that
> processes the data is slow, the guard lets the person go through the gate.
> An access denial finally comes through. The guard turns and shoots the
> intruder. What other choice is available? The intruder may have seen what
> should not have been seen. Now the guard has to file a fatal incident report
> and slow down everything else while cleaning up the remains.
> 
> tl;dr - async access control is just messy.

Stated more precisely, the model is asynchronous behavioral controls
and model response.

It is currently what 100+ billion dollar security companies and their
products are based on.  Which, in an increasingly wide swath of
corporate IT, you are required to implement.

Kernel security maintainers can choose to ignore the issue, doesn't
mean it isn't reality.

We have a very diverse team, members of which have been involved in
international cybersecurity issues that have been in the news.  I've
personally written white papers for the consumption of individuals
that are in the news, as to the socio-technical issues that are behind
why we can't have nice things in cybersecurity.

We believe Linux can improve on this situation.  We at least look on
it as fortunate to have a public record as to why that may not be
possible, if that turns out to be the case.

> > Based on your response, is it your stated position as Linux security
> > maintainer, that you consider modern Endpoint Detection and Response
> > Systems (EDRS) lacking with respect to their ability to implement a
> > "reasonable" enforcement and assurance mechanism?
> 
> You are conflating issues. It isn't the purpose of the system, it is
> the mechanism by which it is implemented that is the problem.
> 
> > If this is the case, your philosophy leaves Linux in a position that
> > is inconsistent with how the industry is choosing to implement
> > security.
> >
> > Let me cite an example from one of our project advisors.
> >
> > This individual is a senior principal at a reasonably large technology
> > products company that depends on Linux almost exclusively to support
> > its operations.  At any given instant he participates in supervising a
> > fleet of around 6,000 virtual machines running about 50,000-60,000
> > containerized workloads.
> 
> How can this possibly be a kernel problem?
> 
> > All of the Linux deployments are Ansible orchestrated.  The security
> > deployment consists of disabling SeLinux and installing an EDRS
> > solution.  Doing the latter checks all the boxes they need for their
> > corporate security compliance policies.
> 
> Without insight regarding what these policies might be it is impossible
> to say for sure, but I'll bet a refreshing beverage that they involve
> all sorts of application level protocols, and other things the kernel
> has no business moderating.
> 
> > He, and others, have watched this discussion closely over the last two
> > years that we have tried to get TSEM reviewed and just recently phoned
> > me with the following comment:
> >
> > "I think the problem is that these guys don't understand how security
> > is being done and the reasons why".
> 
> Oh, make no mistake, I (at least) understand how security is being
> done these days and find it terrifying. We do in the kernel what can
> and should be done in the kernel, but adding general supply chain controls
> as an LSM isn't gonna happen in my (admittedly limited) lifetime.
> 
> > There is probably not a modern EDRS solution that does not involve
> > going to the cloud for its decision making enforcement,
> 
> Wow. The number and density of application and network protocols
> necessary for that to work puts an Austrian pastry to shame. And
> you want to put that in the kernel?
> 
> >  in most cases
> > based on Indicators Of Compromise (IOC) trained machine learning
> > models.  Asynchronous detection, enforcement and remediation is now
> > standard practice.  In the security industry, a 1 minute response to a
> > security event is considered the 'gold' standard.
> 
> A one minute delay in an openat() call ain't gonna happen.
> 
> > For the sake of discussion, lets take a Quixote userspace Trusted
> > Modeling Agent (TMA) running TSEM based deterministic modeling of a
> > containerized workload.  As we've discussed previously, demonstrated
> > average response times are on the order of 170 micro-seconds.
> >
> > For an event that needs asynchronous enforcement, ie. running in
> > atomic context, that represents a 3.5 order of magnitude advantage in
> > response over the industry standard, without the attendant challenges
> > of going off machine or installing kernel based infrastructure.
> >
> > What would be the rationale or advantage of denying those that desire
> > this type of security option, a 3,500 fold increase in security
> > response times?
> >
> > Let's take another need for running in userspace, trusted execution
> > environments.  Support is available in our userspace package for
> > running a TMA model in either an SGX enclave or in an independent
> > hypervisor protected execution context, both of which significantly
> > harden the enforcement implementation against attack by adversaries.
> >
> > As Linux security maintainer, we assume that you have read Executive
> > Order 14144 signed on January 16th 2025.
> 
> Remember "C2 in '92"? Executive order. Industry invested ~$25 Million
> in 1990's dollars in evaluation costs alone. Never enforced. I am not
> shaking in my boots.
> 
> >   That document specifically
> > calls out the requirement for the increased use of trusted execution
> > environments in combination with advancements in endpoint detection.
> >
> > It shouldn't be a leap in imagination as to the regulatory compliance
> > advantages associated with hardware attestation that the security
> > implementation is operational and in a known good enforcement state.
> 
> When those technologies have developed some level of maturity and
> acceptance they'll be worth considering more seriously.
> 
> > Finally, at this point in time, it would seem unwise in the technology
> > industry, to discount the importance of 'AI', or more correctly
> > machine learning.  As we've noted before in our discussions, it is
> > unlikely that we are going to see synchronous LSM enforcement using a
> > machine learning model trained on potentially trillions of data
> > observations and indicators.
> 
> I'm not discounting AI. I'm questioning it's use in kernel access control
> implementations. You cannot ignore the impact of access control on system
> performance. Ever.
> 
> > The LSM is designed to provide security services to the users of
> > Linux, not to be a kingdom.
> 
> It's never been more than a principality. ;)
> 
> > Linux is/was about 'choice' as to how users want to use their
> > hardware.
> 
> Nah, it's about a Finish grad student's side project.
> 
> > Artifically limiting the types of security that can be implemented by
> > the LSM works to the detriment of the security innovation that Linux
> > can deliver and the Linux user community writ large.
> 
> If you can demonstrate a sane implementation of your mechanism we're
> all ears. User space policy adjudication isn't sane. It wasn't in the
> 1980's, it isn't now.

For the official record, a number of your assessments above are
incorrect and do not reflect our implementation or intentions.

It doesn't seem to be a worthwhile expenditure of anyone's time to
discuss technical specifics.

We will remain content to be 'The Ghost of Christmas Yet To Come'.

Best wishes for a productive remainder of the week to everyone.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
