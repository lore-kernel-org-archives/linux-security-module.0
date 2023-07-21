Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EEBEB64DD
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Jul 2023 23:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjGUX5k (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Jul 2023 19:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGUX53 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Jul 2023 19:57:29 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9530F3C2A
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jul 2023 16:57:06 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36LNu0Pt005072;
        Fri, 21 Jul 2023 18:56:00 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36LNtxq2005071;
        Fri, 21 Jul 2023 18:55:59 -0500
Date:   Fri, 21 Jul 2023 18:55:59 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Leesoo Ahn <lsahn@wewakecorp.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process on Host
Message-ID: <20230721235559.GA5056@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com> <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com> <20230718103432.GA19728@wind.enjellic.com> <bc7f842f-caa3-082b-3159-cdc2c4b2dfa7@schaufler-ca.com> <20230719184514.GA6050@wind.enjellic.com> <4f81a0a6-ecb4-1283-1d30-f58cfce0f26d@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f81a0a6-ecb4-1283-1d30-f58cfce0f26d@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 21 Jul 2023 18:56:01 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 19, 2023 at 05:21:37PM -0700, Casey Schaufler wrote:

I hope the week is ending well for everyone.

> On 7/19/2023 11:45 AM, Dr. Greg wrote:
> > On Tue, Jul 18, 2023 at 10:20:40AM -0700, Casey Schaufler wrote:
> >
> > Good afternoon to everyone.
> >
> >> On 7/18/2023 3:34 AM, Dr. Greg wrote:
> >>> On Fri, Jul 07, 2023 at 09:50:41AM -0700, Casey Schaufler wrote:
> >>>
> >>> Hi, I hope the week is going well for everyone.
> >>>
> >>>> On 7/7/2023 7:20 AM, Paul Moore wrote:
> >>>>> On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >>>>>> 2023-07-06 ?????? 10:43??? Paul Moore ???(???) ??? ???:
> >>>>>>> On Thu, Jul 6, 2023 at 1:20???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >>>>>>>  >
> >>>>>>>  > Hello! Here is another weird behavior of lsm stacking..
> >>>>>>>  >
> >>>>>>>  > test env
> >>>>>>>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> >>>>>>>  > - boot param: lsm=apparmor,selinux
> >>>>>>>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> >>>>>>>  >
> >>>>>>>  > In the test environment mentioned above and applying selinux policy
> >>>>>>>  > enforcing by running "setenforce 1" within the container, executing the
> >>>>>>>  > following command on the host will result in "Permission denied" output.
> >>>>>>>
> >>>>>>> SELinux operates independently of containers, or kernel namespacing in
> >>>>>>> general. When you load a SELinux policy it applies to all processes
> >>>>>>> on the system, regardless of where they are in relation to the process
> >>>>>>> which loaded the policy into the kernel.
> >>>>>>>
> >>>>>>> This behavior is independent of the LSM stacking work, you should be
> >>>>>>> able to see the same behavior even in cases where SELinux is the only
> >>>>>>> loaded LSM on the system.
> >>>>>> Thank you for the reply!
> >>>>>>
> >>>>>> So as far as I understand, the environment of LSM Stacking,
> >>>>>> AppArmor (Host) + SELinux (Container) couldn't provide features "using
> >>>>>> SELinux policy inside the container shouldn't affect to the host side"
> >>>>>> for now.
> >>>>>>
> >>>>>> If so, I wonder if you and Casey plan to design future features like
> >>>>>> that, because my co-workers and I are considering taking LSM stacking of
> >>>>>> AppArmor + SELinux in products that both policies must be working
> >>>>>> separately.
> >>>>> What you are looking for is a combination of LSM stacking and
> >>>>> individual LSM namespacing.  Sadly, I think the communications
> >>>>> around LSM stacking have not been very clear on this and I worry
> >>>>> that many people are going to be disappointed with LSM stacking
> >>>>> for this very reason.
> >>>> There have been many discussions regarding the viability of the
> >>>> using different LSM policies in containers. Some of these
> >>>> discussions have been quite lively. I have never claimed that LSM
> >>>> stacking addresses all of the possible use cases for multiple
> >>>> concurrent LSMs. If people are disappointed by how little they can
> >>>> accomplish with what is currently being proposed I can only say that
> >>>> we can't get on to the next phase until this work is complete.
> >>> It seems pretty clear, to us anyway, that generic user expectations
> >>> are that advanced security controls for Linux, ie beyond DAC, should
> >>> provide the same compartmentalization and isolation that other
> >>> resource namespaces bring to the table.
> >> It would have been really nice if the developers of resource
> >> namespaces had addressed the "LSM question" when they created their
> >> schemes. But they didn't. Namespaces are not primarily security
> >> constructs. You need go no further than the group access problem of
> >> user namespaces to understand where security ranks on the priority
> >> of namespaces.

> > It may very well be the case that namespaces are the worst abomination
> > that has ever been foisted on mankind with respect to security.

> Oh heavens, no. There are many things that are much worse.

Noted with interest, hopefully none of it is inside of Linux.

> > Unfortunately, that doesn't negate the fact that the software industry
> > has spoken and the notion of a 'container' or 'resource namespace',
> > whatever parlance one chooses to use, is now deeply ingrained in how
> > software is being developed and delivered and this will probably be
> > the case for the foreseeable future.

> Containers are a fad, like grid computing, Beowulf clusters and
> storage area networks.

Interesting outlook.

FWIW, on a strictly unrelated, non-technical front.

My Dad is telling me the same thing, almost every day, about these
automatic transmissions they are putting in cars.  I'm hoping that
what he thinks comes true before I have lost all the acumen that I
developed double-clutching a 3-5-5 triple split Fuller LoadRanger on
the tail of the 3208 Cat that I spent a fair amount of time driving,
during a decidedly non-technical interlude in my professional career.

The above offered, as a public service to any interests, who feel that
TSEM shouldn't see the light of day because it, proudly,
originates from what are decidedly hillbilly origins... :-)

Besides security, it looks like I also personally fail, on a secondary
technical front.  I architected, designed and direct the maintenance
over a pretty good sized SAN, that has been steadily advancing over
the last 23 years since it was first built.  It currently links three
geographically dispersed data-centers at 32 GBPS storage target speeds
to synchronously replicate petabytes of data on a day in and data out
basis.  Not sure how we would do all of that without the concept of a
storage network.

I guess time will tell on all of these fads.

> > This thread was initiated by the fact that their is an expectation,
> > that will only grow in the future, that security controls can be
> > scoped to a subdivision less than that of an entire system and in a
> > manner that doesn't cause one security policy to interfere with or
> > complicate the implementation of another.

> I dispute your "fact". I understand that some people believe that,
> but I also know that they haven't been told to expect that, at least
> not by the developers who are in a position to make it happen.

All I can speak for are the groups that we are engaged with who
indicate that they believe that workload specific security controls
are a reasonable, if not necessary requirement, for how software
development is evolving, and who have an interest in seeing what TSEM
represents available on Linux.

Our conversations in this forum would suggest you believe such ideas
are completely misguided.  From your perspective and experiences, that
may not be an unreasonable on systems that are supporting adversarial
parties.

This is security, so no one wants to talk about who may be doing
something and how.  FWIW, the people who contemplate this as a useful
advancement represent a formidable body of experience in the security
industry.

> > If current industry experience is any example, the one causing the
> > most problems will get turned off.  Or administrators will be left
> > trying to reason as to what security controls are actually being
> > achieved, which is always hazardous.

> <snark - sorry>
> Horror of horrors! Users have no business understanding the security
> policy their system implements! You may as well let them write their
> own programs!
> </snark - sorry>

I did 107 miles of cycling yesterday, in the glacial moraine lake
country of West-Central Minnesota, trying to parse what the above
means.

The best that I can come up with is that only systems administrators,
or perhaps security personnel, should understand what security
controls are implemented and how.

All the environments we have experience with suggest that everyone is
on the same team; platform engineers, administrators, developers,
security personnel, quality assurance et.al.  They are all focused on
having a solution be as secure as possible.

Some have watched these conversations and don't understand why it
would be unreasonable for a development team to be able to implement
controls that could catch a possible defect in their application
stack, before system wide controls would need to stop the behavior.

> > With respect to our work, if you believe that we are looking at a
> > namespace as an isolation concept you have misunderstand our
> > motivations, objectives and implementation.
> >
> > The LSM infrastructure represents the basis set of information that
> > can be used to model the security behavior of a platform.  If it does
> > not, it cannot adequately enforce effective security controls, since
> > by definition, it would have insufficient visibility into all security
> > relevant behavior.

> You have it backwards. The LSM infrastructure is driven by the needs
> of the security modules. If no one needed a hook for bind() we
> wouldn't have one.

You misinterpret my point, let me see if I can clarify.

The LSM, over the course of its development, has developed a
significant body of security inspection points, at the expense of a
fair amount of pain as Paul Moore would seem to suggest, for what has
been determined to be security significant actions, all to support the
needs of various security enforcement systems.

It may not represent all relevant security behavior, but it is the sum
of what is available for Linux as a platform, you cannot get any
better visibility, without adding more hooks, which seems to be
increasingly problematic and conflict laden.

So TSEM comes at this from the perspective of: "If life gives you
lemons, make lemonade".

We take all of the available information that these interception
points can generate and use it to enable the application of
mathematical models that range through the spectrum of deterministic,
quasi-deterministic, and with an increasing relevance, machine
learning models.

All of this provides a pathway to security model resolution that
represents a detection and interdiction strength that equals the sum
of what all the other LSM security schemes can produce, put together.

If additional hooks get added and they make sense from a modeling
perspective, any security models implemented via TSEM will
gain additional resolution.

> > There are at least three ways this information can be used:
> >
> > The LSM can be used to enforce a system wide security policy through
> > mandatory access controls, your area of interest and endeavor.

> MAC has been an area of interest of mine for a long time, but is
> hardly the only one. Unfortunately, the other things I want to do
> require stackability. They don't require either/or with SELinux (or
> AppArmor, or Smack) but they do use cred blobs.

Presumably a security token bearing scheme, we will look forward to
seeing it.

> > An equally valid concept is for developers to use this information
> > to verify that the security behavior of workloads that they develop
> > are consistent with what they desire.

> Err, no. That assumes that the information is sufficiently complete
> to identify any possible interesting behavior. There's no way I
> would claim the LSM infrastructure provides that.

Again, with reference to the discussion above, it is the best that
Linux can do as a platform.  If TSEM's security model cannot detect an
aberration, by definition, there would be no reason to expect that any
of the other LSM based security controls could detect and act on the
threat.

A final point.

TSEM models are exquisitely sensitive to deviations in the security
behavior of a workload.  You would presumably have little interest in
taking the time to actually test TSEM with the Quixote utilities but
doing so may be illuminating for you or others within the Linux
security community.

The contributing factor to this high sensitivity is the security state
coefficient generation function that is used.  The 'Event Modeling'
section of the TSEM document, starting at line 704, goes into some
detail on this aspect of the security model.

From a big picture perspective, every corpus of executable code will
have its own representation of any of the security behaviors that the
LSM is capable of tracking.  The TSEM documentation has practical
examples of how this manifests itself in practice.

> > A third possible use case of the LSM, since it represents access to
> > all of the information that describes the security state of a
> > platform, is to drive machine learning based analysis and
> > interpretation of the security status of a system.

> Nope. The claim that LSM provides access to "all of the information"
> is fallacious. It provides access to the information that existing
> security modules have asked for, and no more.

Hopefully we we have taken that issue to task.

> > The latter two use cases benefit from the ability to reduce the scope
> > and complexity of the model being analyzed, which is the intent of the
> > TSEM security modeling namespaces.
> >
> > I'm just hazarding a guess here, no judgement implied, but I would
> > assume you view phenomenological modeling, machine learning and
> > artificial intelligence as irrelevant endeavors with respect to
> > security?

> Oh no, They are likely to be very relevant. Alas, I don't expect the
> general populous to listen to Artificial intelligence any better
> than they listen to Natural intelligence. I fully expect AI to
> provide significant insights, but the audience will be the security
> community, not the user community.

Once gain, nothing about TSEM involves the user community, unless of
course, the user community means the development teams that are
putting the application stacks on the platform.

TSEM is designed to provide a mechanism for machine learning to have
access to what by definition, is all of the relevant security behavior
information that Linux has available to it as a platform.  The primary
user community will be data science teams.

> > We have direct and constant dialogue with a group that has around 6000
> > virtual machines running 30,000+ containers at any given instant in
> > time.  Every VM is running, I believe, three CrowdStrike kernel
> > modules and other supportive infrastructure that are feeding 'machine
> > learning' telemetry into the cloud for security analysis.  I also
> > believe there are Kubernetes sidecars analysing container behavior in
> > the mix as well.

> What is the AI looking for? How do you know if it is "security"
> you're analyzing, as opposed to teen-age buying patterns?

I wouldn't have a clue as to what they are looking for, you would need
to ask the CrowdStrike security engineering teams.

Given how closely guarded security technology is, with machine
learning models considered the most closely guarded secrets there are,
it seems unlikely they would tell you.

Their current 35.11 billion dollar valuation is dependent on their
ability to detect anomalous platform security behavior, however they
do it, if you believe their web-site, it is through event modeling and
artifical intelligence schemes implemented in the 'cloud'.  I suspect
you would need to run a request up through your chain of command to
Pat Gelsinger to try and get access to exactly what they are doing.

Pat Gelsinger taking George Kurtz to lunch, or some similar momentous
exchange, is where those types of deals for exchange of cooperation
probably need to get done.

You had suggested in a previous e-mail that there are software
'snake-oil' salesman out there, maybe that is what CrowdStrike
represents, if so they are making a ton of money doing it.

> > None of which is optional, given that the conversations surrounding
> > the technology consists of; "Run this because our insurance says we
> > have to".
> >
> > The beauty in Linux is that you can ignore all of this and run
> > SeLinux, but to say that resoure namespaces, compartmentalization and
> > modeling are irrelevant, flies in the face of how security is being
> > done.

> I often see cases where someone tries to implement a secure behavior
> using sophisticated mechanisms when a simple mechanism intended to
> address that specific issue is already in the system. That point
> that lots of people are using these mechanisms is valid, but in way
> too many cases far from the easiest or most reliable way to go about
> solving the problem.

You would probably disagree, but TSEM is about an easier way of doing
things.

> >>> The 10 years of experience we have had with building systems, and
> >>> feedback we have received from collaborators with significant
> >>> experience in critical infrastructure, drove the focus in TSEM on
> >>> strictly partitioned and workload based security controls.
> >> The 45 years of experience we have had with building systems at
> >> every level from network appliances, through user interface engines
> >> and multi-level secure supercomputers convince us that workload
> >> based controls can never provide anything beyond grandiose security
> >> theater.
> >>
> >> We have often claimed that isolation (partitioning, if you prefer)
> >> is easy, sharing is hard. Building a system security policy based on
> >> alleged "safe" existing behavior is at best naive.

> > Personally, I've actually got two years on that, started with writing
> > assembler code to modify the functionality of RDOS running on Data
> > General Nova 2's, circa 1976.  Edited microcode to fix the 'tired
> > microcode' problems on DG Eclipses.  Even built and ran a
> > supercomputer center for about 6-7 years.  Spent a ton of time in the
> > last few years writing micro-controller code to implement hardware
> > Trusted Modeling Agents, so I think I've been full circle as well.
> >
> > If we can put personal length issues aside, we can turn to the question
> > of security controls tuned to the needs of a workload.
> >
> > Based on your comment above, I assume your position would be that
> > 'Default deny, exception allow' security policies are inadequate or
> > unsafe?

> They are certainly prone to a particular kind of error. Program A
> accesses resource B, and the "policy" author doesn't know
> why. Rather than researching the reason that A accesses B, the
> policy is written to allow the access on the basis that A needs the
> access to do its job. Alas, giving A access to B also gives A access
> to C, which allows A to do nefarious things. Because no one ever
> contemplated the relationship between B and C, and A doesn't
> normally access C, the "policy" is flawed.

Yes, the perils of transitive security reasoning.

TSEM isn't about that, TSEM is more about the security model that
every firewall running on the planet implements.

It is all, actually, pretty straight forward.

Assume a deterministic or quasi-deterministic model (model inputs run
through a leveling algorithm).

There exists a finite field of security coefficients that will be
generated for a workload based on the security coefficient generation
algorithm in use.  By default, all coefficients in the field will deny
access to their associated event.  Unit testing of the workload
generates a sub-field of coefficients whose associated actions are
permitted.

This allows development teams to place a bounding set on the allowed
security behavior of their workload.  If you don't trust your
developers to do complete CI/CD coverage you install additional
controls as a secondary security boundary.

There are always exceptions, but our experience is that development
teams are starting to get pretty serious about the security of their
stacks and their CI/CD code coverage.

From our perspective, it doesn't seem right-headed for Linux to deny
them access to the ability to leverage mandatory control schemes to
improve their deliverable.

> ... And that's all I have time for today.

Indeed and we have probably hit the asymptotic limit of interest to
anyone who may be following along at home.

Best wishes for a pleasant summer weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
