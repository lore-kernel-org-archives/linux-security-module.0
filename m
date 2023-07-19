Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BA3C001B0
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Jul 2023 18:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGSSqG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSSqF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jul 2023 14:46:05 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D92F171E
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jul 2023 11:46:02 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36JIjF67006065;
        Wed, 19 Jul 2023 13:45:15 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36JIjEH5006064;
        Wed, 19 Jul 2023 13:45:14 -0500
Date:   Wed, 19 Jul 2023 13:45:14 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Leesoo Ahn <lsahn@wewakecorp.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process on Host
Message-ID: <20230719184514.GA6050@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com> <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com> <20230718103432.GA19728@wind.enjellic.com> <bc7f842f-caa3-082b-3159-cdc2c4b2dfa7@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc7f842f-caa3-082b-3159-cdc2c4b2dfa7@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 19 Jul 2023 13:45:15 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 18, 2023 at 10:20:40AM -0700, Casey Schaufler wrote:

Good afternoon to everyone.

> On 7/18/2023 3:34 AM, Dr. Greg wrote:
> > On Fri, Jul 07, 2023 at 09:50:41AM -0700, Casey Schaufler wrote:
> >
> > Hi, I hope the week is going well for everyone.
> >
> >> On 7/7/2023 7:20 AM, Paul Moore wrote:
> >>> On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >>>> 2023-07-06 ?????? 10:43??? Paul Moore ???(???) ??? ???:
> >>>>> On Thu, Jul 6, 2023 at 1:20???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >>>>>  >
> >>>>>  > Hello! Here is another weird behavior of lsm stacking..
> >>>>>  >
> >>>>>  > test env
> >>>>>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> >>>>>  > - boot param: lsm=apparmor,selinux
> >>>>>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> >>>>>  >
> >>>>>  > In the test environment mentioned above and applying selinux policy
> >>>>>  > enforcing by running "setenforce 1" within the container, executing the
> >>>>>  > following command on the host will result in "Permission denied" output.
> >>>>>
> >>>>> SELinux operates independently of containers, or kernel namespacing in
> >>>>> general. When you load a SELinux policy it applies to all processes
> >>>>> on the system, regardless of where they are in relation to the process
> >>>>> which loaded the policy into the kernel.
> >>>>>
> >>>>> This behavior is independent of the LSM stacking work, you should be
> >>>>> able to see the same behavior even in cases where SELinux is the only
> >>>>> loaded LSM on the system.
> >>>> Thank you for the reply!
> >>>>
> >>>> So as far as I understand, the environment of LSM Stacking,
> >>>> AppArmor (Host) + SELinux (Container) couldn't provide features "using
> >>>> SELinux policy inside the container shouldn't affect to the host side"
> >>>> for now.
> >>>>
> >>>> If so, I wonder if you and Casey plan to design future features like
> >>>> that, because my co-workers and I are considering taking LSM stacking of
> >>>> AppArmor + SELinux in products that both policies must be working
> >>>> separately.
> >>> What you are looking for is a combination of LSM stacking and
> >>> individual LSM namespacing.  Sadly, I think the communications
> >>> around LSM stacking have not been very clear on this and I worry
> >>> that many people are going to be disappointed with LSM stacking
> >>> for this very reason.

> >> There have been many discussions regarding the viability of the
> >> using different LSM policies in containers. Some of these
> >> discussions have been quite lively. I have never claimed that LSM
> >> stacking addresses all of the possible use cases for multiple
> >> concurrent LSMs. If people are disappointed by how little they can
> >> accomplish with what is currently being proposed I can only say that
> >> we can't get on to the next phase until this work is complete.

> > It seems pretty clear, to us anyway, that generic user expectations
> > are that advanced security controls for Linux, ie beyond DAC, should
> > provide the same compartmentalization and isolation that other
> > resource namespaces bring to the table.

> It would have been really nice if the developers of resource
> namespaces had addressed the "LSM question" when they created their
> schemes. But they didn't. Namespaces are not primarily security
> constructs. You need go no further than the group access problem of
> user namespaces to understand where security ranks on the priority
> of namespaces.

It may very well be the case that namespaces are the worst abomination
that has ever been foisted on mankind with respect to security.

Unfortunately, that doesn't negate the fact that the software industry
has spoken and the notion of a 'container' or 'resource namespace',
whatever parlance one chooses to use, is now deeply ingrained in how
software is being developed and delivered and this will probably be
the case for the foreseeable future.

This thread was initiated by the fact that their is an expectation,
that will only grow in the future, that security controls can be
scoped to a subdivision less than that of an entire system and in a
manner that doesn't cause one security policy to interfere with or
complicate the implementation of another.

If current industry experience is any example, the one causing the
most problems will get turned off.  Or administrators will be left
trying to reason as to what security controls are actually being
achieved, which is always hazardous.

With respect to our work, if you believe that we are looking at a
namespace as an isolation concept you have misunderstand our
motivations, objectives and implementation.

The LSM infrastructure represents the basis set of information that
can be used to model the security behavior of a platform.  If it does
not, it cannot adequately enforce effective security controls, since
by definition, it would have insufficient visibility into all security
relevant behavior.

There are at least three ways this information can be used:

The LSM can be used to enforce a system wide security policy through
mandatory access controls, your area of interest and endeavor.

An equally valid concept is for developers to use this information
to verify that the security behavior of workloads that they develop
are consistent with what they desire.

A third possible use case of the LSM, since it represents access to
all of the information that describes the security state of a
platform, is to drive machine learning based analysis and
interpretation of the security status of a system.

The latter two use cases benefit from the ability to reduce the scope
and complexity of the model being analyzed, which is the intent of the
TSEM security modeling namespaces.

I'm just hazarding a guess here, no judgement implied, but I would
assume you view phenomenological modeling, machine learning and
artificial intelligence as irrelevant endeavors with respect to
security?

We have direct and constant dialogue with a group that has around 6000
virtual machines running 30,000+ containers at any given instant in
time.  Every VM is running, I believe, three CrowdStrike kernel
modules and other supportive infrastructure that are feeding 'machine
learning' telemetry into the cloud for security analysis.  I also
believe there are Kubernetes sidecars analysing container behavior in
the mix as well.

None of which is optional, given that the conversations surrounding
the technology consists of; "Run this because our insurance says we
have to".

The beauty in Linux is that you can ignore all of this and run
SeLinux, but to say that resoure namespaces, compartmentalization and
modeling are irrelevant, flies in the face of how security is being
done.

> > The 10 years of experience we have had with building systems, and
> > feedback we have received from collaborators with significant
> > experience in critical infrastructure, drove the focus in TSEM on
> > strictly partitioned and workload based security controls.

> The 45 years of experience we have had with building systems at
> every level from network appliances, through user interface engines
> and multi-level secure supercomputers convince us that workload
> based controls can never provide anything beyond grandiose security
> theater.
>
> We have often claimed that isolation (partitioning, if you prefer)
> is easy, sharing is hard. Building a system security policy based on
> alleged "safe" existing behavior is at best naive.

Personally, I've actually got two years on that, started with writing
assembler code to modify the functionality of RDOS running on Data
General Nova 2's, circa 1976.  Edited microcode to fix the 'tired
microcode' problems on DG Eclipses.  Even built and ran a
supercomputer center for about 6-7 years.  Spent a ton of time in the
last few years writing micro-controller code to implement hardware
Trusted Modeling Agents, so I think I've been full circle as well.

If we can put personal length issues aside, we can turn to the question
of security controls tuned to the needs of a workload.

Based on your comment above, I assume your position would be that
'Default deny, exception allow' security policies are inadequate or
unsafe?

There is probably no use drilling down too much further into technical
details until we can reach that point of understanding.

> > We obviously had an advantage in that we came into this with the
> > opportunity for a clean design, whereas the existing, particularly
> > label based solutions, have the constraint of a single ground truth
> > with respect to the inode label implemented in the extended
> > attributes.  Which is the fault of nobody, but rather a function of
> > the fact that label based systems have a heritage from before anyone
> > even thought about resource namespaces.

> Resource namespaces are expensive and require extensive administration
> to be useful. As one of the early developers of the inode label based
> solutions you disparage so flippantly, I take umbrage with your
> characterization of the design process.
>
> Of course we thought of features which closely resemble user
> namespaces. They're great for isolation.  They're not so great for
> implementing fixed security policy, which was the requirement and
> goal.

I wasn't being flippant or disparaging, please do not suggest malign
intent where it does not exist.

I will stand informed that you and others considered the notion of
something equivalent to Linux namespaces or workloads and discarded
them as useless, perhaps for very good reasons given the objectives you
were attempting to achieve.

Perhaps, unforunately, the rest of the world has gone in a different
direction and now has expectations and needs that are influenced by
the road that was chosen.

Two comments:

I find your observation that resource namespaces are expensive
interesting.  While they may not provide the degree of isolation you
are interested in, one of the issues that drove their adoption was
some degree of isolation with lower overhead than full virtualization.

Secondly, I believe that an unjaded observer would not consider TSEM
security modeling namespaces to require complex administrative
overhead.  Is there something about the usage examples and/or their
description in the documentation that suggests the degree of
complexity required to use them even approaches that of an OCI
orchestrator?

> > Do to our objectives, and the approach we took, TSEM doesn't require
> > support for 'stacking' with other LSM's, obviously other LSM's do need
> > that support, not a criticism but an observation.  That opened the
> > door to implement what users would consider to be an independent
> > security namespace.
> >
> > The take away, that I assume everyone interested in Linux security
> > would be in agreement on, perhaps not, is that user expectations are
> > to have independent and separately administered security control
> > environments that don't interact with one another.

> So long as the "environments" are completely isolated this makes
> perfect sense. What so many "users", and more importantly, software
> snake oil salesmen, seem incapable of coming to grips with, is that
> for an "environment" to be useful it is going to do some amount of
> resource sharing with the host and frequently with other
> "environments".  That is where the lofty claims of isolation fall
> apart, and the real, painful work for security developers, begins.

First, we are not selling anything, we are attempting to contribute
infrastructure to the common good to implement a security model that
we have worked to significantly document the rationale for.

Once again, TSEM 'namespaces' are not a mechanism for imposing
isolation, they are about limiting the scope of acceptable security
behaviors that can be exhibited by a process heirarchy.

This allows a development team to impose a requirement that the
workload block, through the use of mandatory controls, any security
behavior that the application has not been unit tested to, without the
need to engage systems administration support.

Since the behaviors are workload specific there is less opportunity
for the controls to 'break' the application.  Which, based on our
reasonably significant field experience and depending on the
environment, results in an order being given to turn off the controls.

None of this limits the ability of the system administrators to impose
more rigid controls in pursuit of a whole system security policy if
that is a desired goal of the architecture.

With respect to modeling of security behavior, a namespace is a
mechanism for reducing model complexity, which in turn increases the
accuracy of the model prediction.

If one doubts the importance of this concept in the modern enterprise
security environment, I can go into stories about running uname, on a
Linux box running an Oracle database implementation, setting off
security policy alarms that bring in the security team and the need to
write a formal security violation explanation.

If there would be interest, I can post a link to a reasonably current
review paper on the application of machine learning to system call
analysis for Host Intrusion and Anomaly detection.  It specifically
calls out the need to focus on driving the model at workload scope in
order to increase prediction accuracy.

One of the forward looking objectives of TSEM namespaces is to drive
models from the LSM level that, again by definition, has the most
complete visibility into the security state of the system.

> >>> While stacking of LSMs is largely done at the LSM layer, namespacing
> >>> LSMs such that they can be customized for individual containers
> >>> requires work to be done at the per-LSM level as each LSM is
> >>> different.  AppArmor already has a namespacing concept, but SELinux
> >>> does not.  Due to differences in the approach taken by the two LSMs,
> >>> namespacing is much more of a challenge for SELinux, largely due to
> >>> issues around filesystem labeling.  We have not given up on the idea,
> >>> but we have yet to arrive at a viable solution for namespacing
> >>> SELinux.

> >> I remain more optimistic than Paul about the options for
> >> supporting generic LSM namespacing. I hope to explore a couple
> >> notions that I have more fully, but as they depend on the current
> >> stacking work I may not get to them very soon.

> > I believe TSEM demonstrates that we already have the
> > infrastructure at the LSM layer for generic namespacing.  Of all
> > the current LSM's, I believe we have the most sophisticated
> > namespace implementation with respect to the functionality that it
> > implements.
> >
> > We have implemented TSEM using both the standard Linux namespace
> > infrastructure and as an independent namespace implementation using
> > the LSM 'blob' infrastructure.  FWIW, we have never looked back on the
> > decision to implement LSM specific namespacing using the generic LSM
> > 'blob' functionality.
> >
> > If there is a desire to provide some minimum level of generic security
> > namespace functionality I could recitate a whole list of thoughts to
> > consider but will leave that to another time.

> 	I have discovered a truly marvelous patch for this, which this
> 	email is too brief to contain.
>
> All kidding aside, there are a bunch of things we could do, but they all
> introduce issues with object sharing.

We have a TMA model implementation, that reads the SeLinux extended
security attribute and role information and uses those in the
computation of the allowed security state coefficients that would be
representative of the MAC status of a workload.  The TSEM
documentation discusses the relationship between security state
coefficients and positive AVC nodes in the 'Security Event Modeling'
section, starting at line 204.

My comments would have been framed around the experience and insights
that work gave us with respect to the challenges associated with label
based object sharing and possible responses to those issues that TSEM
would facilitate.

We don't blow smoke, but we are sensitive to the fact that people
don't like to read much anymore.

> >>> If you are interested in stacking SELinux and AppArmor, I believe the
> >>> only practical solution is to run SELinux on the host system (initial
> >>> namespace) and run AppArmor in the containers.  Even in a world where
> >>> SELinux is fully namespaced, it would likely still be necessary to run
> >>> some type of SELinux policy on the host (initial namespace) in order
> >>> to support SELinux policies in the containers.

> >> SELinux policy is sufficiently flexible to support what would look
> >> like different policies on the host system and in the container. I
> >> think that the administration of such a system would be tricky, and
> >> the policy would be very complex, but it could be done, for some use
> >> cases at least.

> > These reflections illuminate our motivation in developing TSEM, others
> > may disagree, but a lot of experience in, and observation of, the
> > security industry has led us to believe that security has to get
> > simpler and easier to implement rather than more complex and arcane.

> Evidence would indicate this is an errant conclusion.

Interesting.

So, by extentive reasoning, if we make security more complex, arcane
and brittle; in an environment where professional security experience
is increasingly limited, our systems will become more secure?

I guess history will judge.

> > We are probably at an interesting juncture in Linux development.  The
> > security controls we make available as a platform can either pursue a
> > path where only highly skilled administrators and technology companies
> > can implement them, or, we can provide mechanisms that work to increase
> > the accessibility by development teams and ultimately the user
> > community to advanced security controls.

> Ever hear of the "Hillbilly Hummer"? No, you don't leave security
> policy development to end users.

No, the only Hillbilly thing we have here is a guy on the lake who has
two 4x8 sheets of green treated plywood nailed together with 50 gallon
plastic barrels on each corner pushed around by a five horse Evinrude.

More directly to your point, you're misrepresenting our intentions, we
are not suggesting we leave it to end users.

As noted above, we have pretty solid feedback from groups who are
deeply involved with infrastructure security that believe there are
positive benefits to development teams being able to independently
verify and protect the security of their workloads.

If this works to increase the security posture of the systems in
question, end users of the service would obviously seem to benefit.

> > With TSEM, our design philosophy is that security controls need to
> > flow from the development process in order to accomplish this latter
> > objective.  CI/CD is now considered a necessary and standard practice
> > in the software industry, it doesn't seem like a stretch of the
> > imagination that security controls should flow from that process as
> > well.
> >
> > One of the requirements of this model is the ability to strictly scope
> > security controls to the level of a workload nee security modeling
> > namespace.
> >
> > Regardless of motivation, it would seem from this thread alone, that
> > there is a user expectation, if not a necessary technical requirement,
> > for Linux to provide infrastructure that enables strictly partitioned
> > and independent security controls that don't require extensive
> > reasoning as to what they might actually do in practice.

> You really have missed the point. By a long way. The problem of
> security is not now, nor has it ever been, isolation. It is
> sharing. If it is appropriate for "users" to determine sharing, we
> have mode bits. If it is appropriate for "administrators" to
> determine sharing, we have mandatory access controls and
> namespaces. If sharing is completely inappropriate, we have
> virtualization.

Hopefully, if people have elected to read this far, they will at least
entertain the notion that our efforts are not as witless as has been
suggested.

Every technical issue involves shades of grey but TSEM is not about
isolation, or sharing, for that matter.  It is about defining whether
or not a workload is acting consistently with what it was designed and
intended to do and either acting in response or signaling that fact to
others, in as precise a manner as can be implemented.

It attempts to do this in what is, at least currently, within the
context of the technology framework that industry has chosen to
operate in.  This of course leaves open the question if industry has
chosen properly, which is something that neither one of us is going to
do anything about.

Best wishes for a productive remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
