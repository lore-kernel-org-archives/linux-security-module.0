Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BC8EB64DA
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jul 2023 10:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGRKfe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jul 2023 06:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjGRKfd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 06:35:33 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A32E5F
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 03:35:32 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36IAYYPk019793;
        Tue, 18 Jul 2023 05:34:34 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36IAYXln019792;
        Tue, 18 Jul 2023 05:34:33 -0500
Date:   Tue, 18 Jul 2023 05:34:33 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Leesoo Ahn <lsahn@wewakecorp.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process on Host
Message-ID: <20230718103432.GA19728@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com> <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67cb60c9-35c9-6dc3-7ef9-2540d5acf162@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 18 Jul 2023 05:34:34 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 07, 2023 at 09:50:41AM -0700, Casey Schaufler wrote:

Hi, I hope the week is going well for everyone.

> On 7/7/2023 7:20 AM, Paul Moore wrote:
> > On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >> 2023-07-06 ?????? 10:43??? Paul Moore ???(???) ??? ???:
> >>> On Thu, Jul 6, 2023 at 1:20???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> >>>  >
> >>>  > Hello! Here is another weird behavior of lsm stacking..
> >>>  >
> >>>  > test env
> >>>  > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> >>>  > - boot param: lsm=apparmor,selinux
> >>>  > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> >>>  >
> >>>  > In the test environment mentioned above and applying selinux policy
> >>>  > enforcing by running "setenforce 1" within the container, executing the
> >>>  > following command on the host will result in "Permission denied" output.
> >>>
> >>> SELinux operates independently of containers, or kernel namespacing in
> >>> general. When you load a SELinux policy it applies to all processes
> >>> on the system, regardless of where they are in relation to the process
> >>> which loaded the policy into the kernel.
> >>>
> >>> This behavior is independent of the LSM stacking work, you should be
> >>> able to see the same behavior even in cases where SELinux is the only
> >>> loaded LSM on the system.

> >> Thank you for the reply!
> >>
> >> So as far as I understand, the environment of LSM Stacking,
> >> AppArmor (Host) + SELinux (Container) couldn't provide features "using
> >> SELinux policy inside the container shouldn't affect to the host side"
> >> for now.
> >>
> >> If so, I wonder if you and Casey plan to design future features like
> >> that, because my co-workers and I are considering taking LSM stacking of
> >> AppArmor + SELinux in products that both policies must be working
> >> separately.

> > What you are looking for is a combination of LSM stacking and
> > individual LSM namespacing.  Sadly, I think the communications
> > around LSM stacking have not been very clear on this and I worry
> > that many people are going to be disappointed with LSM stacking
> > for this very reason.

> There have been many discussions regarding the viability of the
> using different LSM policies in containers. Some of these
> discussions have been quite lively. I have never claimed that LSM
> stacking addresses all of the possible use cases for multiple
> concurrent LSMs. If people are disappointed by how little they can
> accomplish with what is currently being proposed I can only say that
> we can't get on to the next phase until this work is complete.

It seems pretty clear, to us anyway, that generic user expectations
are that advanced security controls for Linux, ie beyond DAC, should
provide the same compartmentalization and isolation that other
resource namespaces bring to the table.  The 10 years of experience we
have had with building systems, and feedback we have received from
collaborators with significant experience in critical infrastructure,
drove the focus in TSEM on strictly partitioned and workload based
security controls.

We obviously had an advantage in that we came into this with the
opportunity for a clean design, whereas the existing, particularly
label based solutions, have the constraint of a single ground truth
with respect to the inode label implemented in the extended
attributes.  Which is the fault of nobody, but rather a function of
the fact that label based systems have a heritage from before anyone
even thought about resource namespaces.

Do to our objectives, and the approach we took, TSEM doesn't require
support for 'stacking' with other LSM's, obviously other LSM's do need
that support, not a criticism but an observation.  That opened the
door to implement what users would consider to be an independent
security namespace.

The take away, that I assume everyone interested in Linux security
would be in agreement on, perhaps not, is that user expectations are
to have independent and separately administered security control
environments that don't interact with one another.

> > While stacking of LSMs is largely done at the LSM layer, namespacing
> > LSMs such that they can be customized for individual containers
> > requires work to be done at the per-LSM level as each LSM is
> > different.  AppArmor already has a namespacing concept, but SELinux
> > does not.  Due to differences in the approach taken by the two LSMs,
> > namespacing is much more of a challenge for SELinux, largely due to
> > issues around filesystem labeling.  We have not given up on the idea,
> > but we have yet to arrive at a viable solution for namespacing
> > SELinux.

> I remain more optimistic than Paul about the options for supporting
> generic LSM namespacing. I hope to explore a couple notions that I
> have more fully, but as they depend on the current stacking work I
> may not get to them very soon.

I believe TSEM demonstrates that we already have the infrastructure at
the LSM layer for generic namespacing.  Of all the current LSM's, I
believe we have the most sophisticated namespace implementation with
respect to the functionality that it implements.

We have implemented TSEM using both the standard Linux namespace
infrastructure and as an independent namespace implementation using
the LSM 'blob' infrastructure.  FWIW, we have never looked back on the
decision to implement LSM specific namespacing using the generic LSM
'blob' functionality.

If there is a desire to provide some minimum level of generic security
namespace functionality I could recitate a whole list of thoughts to
consider but will leave that to another time.

> > If you are interested in stacking SELinux and AppArmor, I believe the
> > only practical solution is to run SELinux on the host system (initial
> > namespace) and run AppArmor in the containers.  Even in a world where
> > SELinux is fully namespaced, it would likely still be necessary to run
> > some type of SELinux policy on the host (initial namespace) in order
> > to support SELinux policies in the containers.

> SELinux policy is sufficiently flexible to support what would look
> like different policies on the host system and in the container. I
> think that the administration of such a system would be tricky, and
> the policy would be very complex, but it could be done, for some use
> cases at least.

These reflections illuminate our motivation in developing TSEM, others
may disagree, but a lot of experience in, and observation of, the
security industry has led us to believe that security has to get
simpler and easier to implement rather than more complex and arcane.

We are probably at an interesting juncture in Linux development.  The
security controls we make available as a platform can either pursue a
path where only highly skilled administrators and technology companies
can implement them, or, we can provide mechanisms that work to increase
the accessibility by development teams and ultimately the user
community to advanced security controls.

With TSEM, our design philosophy is that security controls need to
flow from the development process in order to accomplish this latter
objective.  CI/CD is now considered a necessary and standard practice
in the software industry, it doesn't seem like a stretch of the
imagination that security controls should flow from that process as
well.

One of the requirements of this model is the ability to strictly scope
security controls to the level of a workload nee security modeling
namespace.

Regardless of motivation, it would seem from this thread alone, that
there is a user expectation, if not a necessary technical requirement,
for Linux to provide infrastructure that enables strictly partitioned
and independent security controls that don't require extensive
reasoning as to what they might actually do in practice.

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
