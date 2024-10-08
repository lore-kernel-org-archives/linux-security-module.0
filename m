Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B761CF7A2;
	Tue,  8 Oct 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386130; cv=none; b=mPTFaSXsy0Aum25SJ8PJH8E7x0vlglKRT+iaVuCo43cpZMvq/Iw+iEeudcbK+WTUq8luJqqI8GIXZVA5TRaWI4N6+3oEqs/XWk0FjsKnzeJDUMP2RRXIaG6GRllXB4Sm61QRq7J2fj51rRJaGA+k2rh/OhgbCDqz3I6x5KRPtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386130; c=relaxed/simple;
	bh=GvOIH3DHFsDeaxCjB3ghIAXSIOFMn7rO3QRkqzJq7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPpa+etXe78MXdCipYWjBP48Q7D7XaH4ftbsVDDy6a7uloI+RbOFUfHSxxUgual5ZHBBMpEquDdmvW47xKU1+wOtXERLKgMtZn1CCHkXS2yRu7z9rcvpP1OmU7F3R0aGyii988EP918VFTUSE8F1CmR86y0pNsXgHk8rftIl3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 498BEiGn023933;
	Tue, 8 Oct 2024 06:14:44 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 498BEgtu023932;
	Tue, 8 Oct 2024 06:14:42 -0500
Date: Tue, 8 Oct 2024 06:14:42 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <20241008111442.GA23889@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp> <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com> <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com> <20241002103830.GA22253@wind.enjellic.com> <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRjq4B4Ub7kbD8uLZxL_CKSm=z+poCXBMmcfs=8ETHj3Q@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 08 Oct 2024 06:14:44 -0500 (CDT)

On Wed, Oct 02, 2024 at 10:35:58AM -0400, Paul Moore wrote:

Good morning, I hope the day is starting well for everyone.

Some clarifications regarding the current challenges to LSM review.

> On Wed, Oct 2, 2024 at 6:38???AM Dr. Greg <greg@enjellic.com> wrote:
> > On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > > On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > Linus, it's unclear if you're still following this thread after the
> > > > pull, but can you provide a little insight on your thoughts here?
> >
> > > I absolutely hate the whole "security people keep arguing", and I
> > > cannot personally find it in myself to care about tomoyo.  I don't
> > > even know where it is used - certainly not in Fedora, which is the
> > > only distro I can check quickly.
> > >
> > > If the consensus is that we should revert, I'll happily revert. This
> > > was all inside of the tomoyo subdirectory, so I didn't see it as
> > > some kind of sidestepping, and treated the pull request as a regular
> > > "another odd security subsystem update".
> >
> > I see that Paul Moore has further responded with commentary about the
> > 'LSM community' responding to this issue.  I wanted, on behalf of our
> > project and in support of Tetsuo's concerns, to register directly with
> > you a sense of jaded skepticism about the notion of a community
> > response.
> >
> > Fixing Tetsuo's issue, at least to the extent it can be fixed,
> > requires technical improvements in the Linux security architecture.
> > Currently, potential technical improvements in this venue are
> > struggling to receive any kind of acknowledgement or review, to the
> > ultimate detriment of enhancements that Linux should be bringing
> > forward to address, not only this issue, but the security industry
> > writ-large.

> I've believe the LSM developer community is interesting in that it
> is much smaller than many other kernel subsystems, despite the
> substantial technical scope when one considers the LSM's reach
> within the kernel.  This brings about a number of challenges, the
> largest being that reviewing ideas, documents, and code changes
> takes time.  Everyone always wants their personal patchset to land
> "right now!", but it's important that the changes are given the
> proper review and testing.  You don't have to look any further than
> the recent static call changes to see a perfect example of how
> overly aggressive attitudes toward merging would have resulted in a
> number of real world failures.  I agree that a quicker pace would be
> nice, but I'm not willing to trade off reliability or correctness so
> people's favorite feature can land in Linus' tree a bit quicker.

We would certainly concur and fall decidedly on the side of minimizing
any potential negative impacts to changes in the LSM.  One of our
areas of primary focus is on critical infrastructure systems, so we
are laser focused on both simplicity and high reliability.

That is why TSEM was designed to be an LSM that implements generic
security modeling and only functions to consume security event
descriptions, with no impact outside of its own functionality.

For the benefit of the record, and everyone following along, here is
the diffstat for the recent V4 release:

Documentation/ABI/testing/tsem                | 2420 ++++++++++++++++
Documentation/admin-guide/LSM/index.rst       |    1 +
Documentation/admin-guide/LSM/tsem.rst        | 1680 +++++++++++
.../admin-guide/kernel-parameters.txt         |   29 +
MAINTAINERS                                   |    8 +
include/uapi/linux/lsm.h                      |    1 +
security/Kconfig                              |   11 +-
security/Makefile                             |    1 +
security/security.c                           |    3 +-
security/tsem/Kconfig                         |   36 +
security/tsem/Makefile                        |    6 +
security/tsem/event.c                         | 1846 +++++++++++++
security/tsem/export.c                        |  429 +++
security/tsem/fs.c                            | 2304 ++++++++++++++++
security/tsem/map.c                           | 1536 +++++++++++
security/tsem/model.c                         |  758 +++++
security/tsem/model0.c                        |   21 +
security/tsem/namespace.c                     |  530 ++++
security/tsem/nsmgr.c                         |  255 ++
security/tsem/nsmgr.h                         |   48 +
security/tsem/trust.c                         |  261 ++
security/tsem/tsem.c                          | 2446 +++++++++++++++++
security/tsem/tsem.h                          | 2336 ++++++++++++++++

It should be noted that with version v4, in response to the issues
that Tetsuo has been raising, we implemented the ability to implement
customized LSM event handling through the use of loadable kernel
modules.

Given the code footprint and design, and the Tomoyo discussion and
issues, we believe our approach offers a highly positive benefit/risk
ratio.

> Independent of everything above, it is important to note that the pace
> of changes in the LSM framework over the past two years has increased
> significantly.  Even ignoring some of the administrative improvements,
> e.g. process documentation, since 2022 the LSM community has been
> merging code at a pace much higher than we've seen during the entirety
> of the "git age":
> 
> [NOTE: using 'security/security.c' to be representative of LSM
> framework specific changes seems reasonable for a quick metric]
> 
> # previous two years (reference)
> % git log --after="2022" --before="2024" \
>   --oneline security/security.c | wc -l
> 141

We certainly wouldn't ascribe to be 'git foo' masters but we have used
git a little bit and grep a whole lot.

We believe the following command sheds some light on these statistics:

git log --after=2022 --before=2024 --oneline --no-merges security/security.c |
	egrep -vi "comments|evm|ima|integrity|spelling" | wc -l

Which generates the following value as of the head of the v6.10 tree:

60

The EVM/IMA/integrity integration work is certainly positive, and we
believe was something that you advocated for in coming into the LSM
maintainership role, but its potential negative impacts writ-large are
potentially more significant than an independent LSM.

To extend a bit further with respect to our work.

If one reads the TSEM documentation carefully, one will find that its
functional predicate, from a modeling perspective, is based on tying
security event descriptions to the cryptographic checksums of the
executable that are generating the security events.

By composing from a clean sheet of music you get a simpler and more
self-contained integrity design.  Since a TSEM security model has its
time of measurement based on the unit test of the workload, the
complexity of cryptographic metadata signing (EVM) can be sidestepped
along with a significant component of its performance impact.

So we would posit, once again, that TSEM offers a comparatively low
risk implementation with significant benefit to the Linux security
community.

> > We have made multiple submissions of technology, that can at least
> > positively impact Tetsuo's concerns, and in the process perhaps
> > improve the opportunity for security innovation in Linux.  After 20
> > months of doing so we have yet to receive anything that would resemble
> > substantive technical review [1].

> I disagree.  I've personally reviewed two of your LSM revisions,
> providing feedback on both.  Unfortunately both times I've not made
> it past the documentation as there have been rather significant
> issues which I didn't believe were properly addressed from one
> revision to the next.  From what I've seen on the mailing list,
> others have identified similarly serious concerns which in my
> opinion have not received adequate responses.

I believe the published record of TSEM clearly does not support this
premise.

For the benefit of everyone following this discussion, we will post
again the links to the four releases:

V1
https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t

V2:
https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

V3:
https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t

V4:
https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

Here is a breakdown of all the review comments received in 20 months:

Casey Schaufler		9
Paul Moore		3
Serge Hallyn		2
Greg Kroah-Hartman	2
Randy Dunlap		1

At the risk of having possibly missed something, we would encourage
everyone else to look at the four link summaries to see if we have
left any review comments unanswered, we don't believe an inspection of
the threads will find that to be the case.

If anyone chooses to clone the TSEM GIT repository, you will find in
the commit summary, references to all of the issues that were raised
and the steps we took to address them.

For the record, we have integrated all of the functional changes
requested by the reviews, most significantly the implementation of
JSON encoding of all security event descriptions, a very positive
review comment from GKH.

Casey's primary concerns have been about the organization of the code,
ie. a single header file with all of the declarations and definitions
for the compilation units in the security/tsem directory.

We reached out to you in advance of the v3 release to find out if you
would like us to re-structure the code to have multiple include files.
You indicated there were far more problems than the code organization,
we asked specifically what those problems would be and received no
response.

The primary technical objection you raised, and to date no one else
has raised this issue, was with the fact that we were exporting the
global PID of an externally modeled process to a trust orchestrator.
This is needed so that the orchestrator can find the process task
structure, in order to set its trust status in its task control
structure before releasing the process for further exection, after the
model evaluation of a security event was completed.

Two of your review comments dealt with this issue.  In your original
response you posited that it was possible to kill a process waiting
for model evaluation and conduct a PID race attack that could
substitute an alternate process to be acted on by the trust
orchestrator.

In response to that concern, we implemented a task authentication
mechanism that requires cryptographic verification of the process by
the trust orchestrator.  We also implemented protections in the
task_kill handler that would allow only tasks with CAP_MAC_ADMIN
status to generate a cross-model/namespace signal that would bring a
modeled task out of its sleep state.

You indicated that authentication was good but insufficient and noted
that an attacker could use the OOM handler to bypass the task_kill
protections.  You posited that pidfd's were how this type of thing
should be done.

We went back and studied the problem in significant detail, including
trust orchestration latency timings and the impact they would have on
the exploitability of a race window.

For the record, here is the lore link to our response that we posted
on 02/19/2024, which to date, we have received no reply to:

https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#me86004e3cd197046885d371cb70df389beb72c7e

We would hope that anyone in the LSM community, that reads the above,
would conclude that we took time to develop a detailed technical
response to this primary concern you have raised.

A summary for those that don't want to click on the link.

Exploiting the race window would require killing the sleeping process
with the OOM handler, something that we are not sure is even possible,
and then cycling a new process with an identical PID into the PID slot
in approximately 45-90 micro-seconds.  In a worst case scenario, with
a 32 bit PID space, this would require 2 billion forks in the race
window, without the trust orchestrator being re-scheduled, which would
have the effect of terminating the race window.

To extend further, since we are answering a technical criticism.

TSEM's security model predicates on the notion of a trust orchestrator
constraining the behavior of processes in a workload to a set of
cryptographically unique coefficients that represent each security
state the process can enter into.  Those states are dependent not only
on the cryptographic checksum of the executable code that gave rise to
the process but the cryptographic identities of all processes that led
to that process.

If an adversary were to substitute a process that was 'raced' into the
PID slot it would have a different cryptographic identity than the
process it was replacing and would thus generate security events that
were inconsistent with the model being enforced.  This would result in
any further security events by that process being trapped as
untrusted.

An open vulnerability in this model, of course, is if the attacker
could also mount an effective second pre-image attack against the
cryptographic hash function being used to implement the extension sum
that represents the task identity.  To our knowledge, no such attacks
are available against any of the cryptographically secure hash
functions that would be chosen for a TSEM security model.  Such an
attack would represent a major failure in the modern cryptographic
primitives the security industry depends on.

> The TSEM LSM is still queued for review, but based on prior reviews
> it currently sits at a lower priority.  I realize this is
> frustrating, but I have to prioritize work based on impact and
> perceived quality.

We will leave the perceived quality discussion to the previous section
of our response and take on the notion of impact here.

We've stated previously and will state again.  We saw the issue
created by Tetsuo and this Tomoyo incident coming during the COVID
years and began work on addressing what we saw was going to be an
important issue for the Linux security community.

You commented to us in an alternate thread, that you have seen nothing
that Tetsuo has done that would change your mind with respect to
having an LSM being implemented with a loadable module.

If that isn't possible, and there are probably good technical reasons
for that, then we need an LSM that is capable of implementing security
models of one's choosing, using mechanisms that do not necessarily
require having an in-kernel LSM.

That is exactly what TSEM was designed to bring to the Linux security
community.  Which, given the issues this event has raised, would seem
to be a positive contribution with some impact.

Which we also believe justifies more attention than what it has been
able to receive in 20 months.

> paul-moore.com

Hopefully with these clarifications in place we can proceed forward in
a more positive context.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
