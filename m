Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBF16A92B
	for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719394462; cv=none; b=tPiaocut1NmDIKxxpybudX8f0Jyq2cBqYR0+yy88tVp5TFdtqxkn9A0HFYx2xj2TbfBIfIy6TwTErJvQ0ySehGoFVlS0L5N8pgypbzAW6StisaMB2RUf22d092D/TQviEZw2dAUpvhMTaMlYxW2NsANutZBAkXBcSvYnE55our8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719394462; c=relaxed/simple;
	bh=Lb8qwrbhYIYFI0D1aM5BTy06idF3ZQYCiF4jruEL/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPCVk8bEiJHYExmF8CZ7eOYfp070qzLSfNBWhsPJ491zvZhbSvQ7d/KdRamo5vL++Y4bZDylfvBGJIQsb5zLBpuNcc8JZvMVFBk/qNRSO6vBqHy2fEQWs/2Fzn0oxjDcuEwzvS5V4MDv5itjKZQiRT/DLTV1Kh/r2F0QFlAbiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 45Q9XrI9019919;
	Wed, 26 Jun 2024 04:33:53 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 45Q9XqZq019918;
	Wed, 26 Jun 2024 04:33:52 -0500
Date: Wed, 26 Jun 2024 04:33:52 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Timur Chernykh <tim.cherry.co@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
Message-ID: <20240626093352.GA19864@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com> <9b672b38-f580-4278-be20-9b9ca1f0cccf@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b672b38-f580-4278-be20-9b9ca1f0cccf@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 26 Jun 2024 04:33:54 -0500 (CDT)

On Thu, Jun 20, 2024 at 09:52:36AM -0700, Casey Schaufler wrote:

Good afternoon, I hope the week is going well for everyone.

> On 6/20/2024 6:40 AM, Timur Chernykh wrote:
> > Hello!
> >
> > I'm here for yours' opinions.
> >
> > The modern Linux, in fact, does not provide convenient options to
> > write AV/EDR software

> Please don't assume that everyone knows your abbreviations.  Audio
> Visual / Editable Data Record.  Sure, "everyone knows" what AV/EDR
> is today. Except that many of us also know what it was in 2010,
> 2000, 1990, and 1980. Confusion!

We will then take as standard practice for the Linux security mailing
list the dictum from academic publishing, for any phrases referenced
as acronyms, the expectation is to define the term with the acronym in
parenthesis and then use the acronym throughout the remainder of the
document in place of the term.

We could perhaps prevail upon Paul Moore to update the ANN document
accordingly to document correct practice... :-)

> >  with real-time system events analysis as far as
> > unified system security events. For now we have only inconsistent
> > self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
> > cool technology, but even CO-RE sometimes works as not expected or
> > gets broken, for example:
> > https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
> > of a huge amount of the same hacks) looks a bit "crutchy".
> >
> > As an EDR developer, I have an idea how to fix this situation, using a
> > unified endpoint security framework (ESF) placed in the kernel. Its
> > must:
> > - Provide unified and consistent security events;

> "Consistent" is hardly a term you can use to describe Linux security
> events.  Is binding a socket to a port a security event? Where is
> the security event when using io_uring?

Linux security events grew organically, so that is what we have to
deal with.

The alternative is to implement what Timur is proposing.  A second set
of kernel infrastructure, parallel to the current LSM but with more
'consistency'.  A project whose arguments over purpose, and the
subsequent bike-shedding over implementation, will take until the heat
death of the Universe to resolve, if then.

Binding to a socket is absolutely a security event, if not there would
have presumably been no LSM security event handler defined for the
action.  Nearly every webshell or Remote Access Technology methodology
worth its weight as malware attempts to do so.

SMACK itself nods to the potential security relevance of binding a
socket, given that it provides a handler for security_socket_bind if
IPV6 port labeling is in effect.

With respect to io_uring functionality.

Based on the current 6.8 kernel sources, the security relevant events
for io_uring are defined as follows:

uring_override_creds

uring_sqpoll

uring_cmd

One of the challenges with defining what is a security relevant event
comes from the fact that security architectures have historically been
prospective, the notion of defining a set of rules that goven access
to security critical events.  In this Kantian formed model one has to
presume what security relevant events are.

In a retrospective or Hegelian model, where the desired security
behavior is derived from the security events that a workload is unit
tested to, this issue is decidedly more deterministic.  If you have a
basis set that describes the field of security relevant events any
departures from that basis represent a violation.

> > - API to communicate with kernel:
> >  - To send program-defined events (as audit has);
> >  - Read events from kernel;

> A comprehensive set of events is likely to overwhelm any user space
> collector.

A couple of responses to that:

First.

Given how busy you are it is unlikely that you would have had time to
patch a kernel with TSEM and setup the Quixote userspace utilities.
For anyone who would have time to do so, we believe that doing so
would provide a clear demonstration of the feasibility of capturing
detailed security event information from all of the LSM security event
handlers.

In round numbers.  Booting a minimal Debian 12 implementation to a
shell prompt with a 6.1 kernel implementation generates 81 megabytes
of JSON encoded LSM event information over 119,000 events which
represent 24,000 security unique events.

To extend further the tractability argument, let us assume that the
collector and/or enforcement system is running on hardware of similar
performance characteristics to the hardware that is generating the
event stream.

To suggest that the information could not be collected or acted on
without being overwhelmed would be to suggest that the existing Linux
mandatory access controls, acting on the same set of events at the
same rate, would be overwhelmed and thus incapable of being feasibly
implemented.

Secondly.

Current activity in the security industry would suggest that the
capture and interpretation of, at least what it considers relevant
security event information, by userspace is clearly viable.

Technical issues aside, CrowdStrike's current 93 billion dollar market
capitalization as of last Friday (06/21/2024) would suggest that the
concept is notionally, if not commercially viable.

Userspace capture and analysis of security event information is how
security is now being done and that will increasingly be the case in
the future.  Particularly if, as we believe, that access to high
resolution LSM event information provides an extremely strong basis
set for training machine learning models.

> > - Trusted agents delivery mechanisms (signing like kernel modules);
> > - Has a possibility to control what happens on system e.g block some
> > file operations, binary executions and so on;

> Performance concerns (locking, sleeping and a host of others) are
> likely to prevent this.

Once again, we believe that current art demonstrates that to not be
the case.

The locking and sleeping issues are only problematic in the context of
the current Kantian models that are attempting to respond with real
time deterministic security decisions.  As has been noted previously,
that is not how the industry is choosing to implement security.

All of the agent based systems are acting in a retrospective manner
where a determination is made that a system has exhibited security
anomalous behavior and an alert is generated and/or the system is
isolated.

> > - Has a portable and flexible events structure which doesn't get
> > broken from version to version;

> If the kernel's policies, mechanisms and structures were more
> consistent you might have a chance at this.

It is certainly the case that there is nothing on the horizon that
suggests the possibility of a portable or consistent event reporting
structure.  Paul Moore has consistently and strongly stated that there
can be no expectations for a stable security API on Linux.

That being said, this issue has to be taken in the context of how the
technology industry is operating.  As RedHat/IBM has clearly
demonstrated with their business model, there is generalized appetite
in industry to lock onto a particular version of an operating system
implementation for long periods of time.

This is even more so the case in the critical infrastructure industry.
The expectation there is for common infrastructure that will be
persisted for at least 15-20 year timeframes.

So security solutions, as do other application providers, simply
target the behavior of these standardized releases.

The BPF LSM has the same issues with respect to API stability and it
is not only being embraced by the security industry it is being
endorsed in some corners of the Linux community as the 'way forward'
for security implementations.

> > For now I have PoC, which describes the concept in more detail:
> > GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
> > It contains all listed above points (maybe except portable event
> > structures)
> >
> > There are an examples with:
> > - Security agent:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/samples/esf/agent.c
> > - API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/ctl.h
> > - Event structures and types:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/include/uapi/linux/esf/defs.h
> > - Main ESF source code:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/security/esf
> >
> > Questions I'm interested in:
> > How does the community feel about this idea? Is it a viable concept?
> > If all is OK, what should I, as developer, do further? How much kernel
> > code outside the LSM module may be modified to keep further merge
> > acceptable? (currently not all LSM hooks meet to intercept all needed
> > data).

> User-space arbitration of kernel events won't work. It's been tried
> repeatedly. I started seeing it in the early 1980's. It always
> devolved into a kernel bolt-on, with sub-optimal performance and
> versatility.

Once again, we believe that current art suggests to the contrary.

Going to userspace for decision making always has performance impacts.
We have posted numbers that demonstrate that deterministic models,
mediated through userspace, are capable of responding with 20-40
micro-second decision latencies.

That may be considered a viable tradeoff if the alternative is to
spend 5-7 years attempting to get a kernel based solution first
accepted and then into the field.

As has been noted previously, the security industry is embracing a
model based approach to security.  Such systems are not going to go
into the kernel, not only because they can't, but also because doing
so would require solution providers to expose their intellectual
property.

The versatility argument is difficult to understand if userspace is
acting on the same information that an in kernel LSM event handler is
sampling and acting on.

A final comment on performance and versatility.  Those issue may be
relevant to kernel developers and perhaps the major technology
companies that are running their own cloud infrastructure, but they
are irrelevant to where most of Linux is going, general industry.

I can line up a dozen system administrators that will raise their hand
and swear on the good Book as to how badly performant and inherently
dangerous these current security solutions are.  The answer from
organizational leadership is always the same: 'you will run it without
questions'.

The challenge for the Linux security architecture, to remain relevant,
is to provide better infrastructure to implement these solutions given
the engineering constraints they impose.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
