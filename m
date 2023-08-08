Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8EC001B0
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Aug 2023 17:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjHHRQc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjHHRP4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Aug 2023 13:15:56 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64F706F4BC
        for <linux-security-module@vger.kernel.org>; Tue,  8 Aug 2023 09:06:28 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 3786eFmR031546;
        Tue, 8 Aug 2023 01:40:15 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 3786eEVp031545;
        Tue, 8 Aug 2023 01:40:14 -0500
Date:   Tue, 8 Aug 2023 01:40:14 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Leesoo Ahn <lsahn@wewakecorp.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        "Dr. Greg" <greg@enjellic.com>
Subject: Re: [LSM Stacking] SELinux policy inside container affects a processon Host
Message-ID: <20230808064014.GA31533@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com> <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com> <20230806171622.GA17655@wind.enjellic.com> <CAHC9VhRDcJTMpzeWsNHbhkJEk0Vsj+zH_utTgmfzK6Teqzn81Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRDcJTMpzeWsNHbhkJEk0Vsj+zH_utTgmfzK6Teqzn81Q@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 08 Aug 2023 01:40:15 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Aug 06, 2023 at 03:25:32PM -0400, Paul Moore wrote:

Good morning, I hope the week has started well for everyone.

> On Sun, Aug 6, 2023 at 1:16???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Fri, Jul 28, 2023 at 10:54:23AM +0900, Leesoo Ahn wrote:
> > > 2023-07-07 ?????? 11:20??? Paul Moore ???(???) ??? ???:
> > > >On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> > >
> > > [...]
> > >
> > > >
> > > >What you are looking for is a combination of LSM stacking and
> > > >individual LSM namespacing. Sadly, I think the communications around
> > > >LSM stacking have not been very clear on this and I worry that many
> > > >people are going to be disappointed with LSM stacking for this very
> > > >reason.
> > > >
> > > >While stacking of LSMs is largely done at the LSM layer, namespacing
> > > >LSMs such that they can be customized for individual containers
> > > >requires work to be done at the per-LSM level as each LSM is
> > > >different. AppArmor already has a namespacing concept, but SELinux
> > > >does not. Due to differences in the approach taken by the two LSMs,
> > > >namespacing is much more of a challenge for SELinux, largely due to
> > > >issues around filesystem labeling. We have not given up on the idea,
> > > >but we have yet to arrive at a viable solution for namespacing
> > > >SELinux.
> > > >
> > > >If you are interested in stacking SELinux and AppArmor, I believe the
> > > >only practical solution is to run SELinux on the host system (initial
> > > >namespace) and run AppArmor in the containers.
> >
> > > Paul, I don't get that SELinux on the host system and run AppArmor
> > > in the containers is the only practical solution. Could you please
> > > explain that in more details?
> >
> > It appears that Paul is extremely busy, so I thought the 'Quixote
> > Group' would try and offer some reflections that may help with your
> > efforts.

> My apologies, yes I am rather busy at the moment, but I also stopped
> following this thread a while ago as it didn't seem to be going
> anywhere meaningful.  I happen to read this last email while I'm
> waiting in an airport, so let me try and provide a quick explanation
> about why running SELinux only in a container is a bad idea.
> 
> As you probably know, the Linux kernel has no concept of a container,
> it only supports subsystem specific namespaces, e.g. mount namespace,
> network namespace, etc.  SELinux does not provide a subsystem
> namespace, and it does not generally concern itself with other
> subsystem names.  From a SELinux perspective there is no difference
> between a process running in the host namespace or a
> container/namespace; both are treated the same with access control
> decisions made based on the processes' SELinux domain, the type of the
> target resource, and the access requested.
> 
> If one were to load a SELinux policy inside a container, even if it
> were allowed, the system would likely behave in unexpected ways as the
> container-loaded policy will take effect across the entire system, not
> just inside the container.

All reasonable and consistent, with what we had previously written
with respect to there being no notion of LSM namespacing.

To further assist Leesoo and others who may be following this, you had
suggested the following earlier in this thread:

Paul> If you are interested in stacking SELinux and AppArmor, I
Paul> believe the only practical solution is to run SELinux on the
Paul> host system (initial namespace) and run AppArmor in the
Paul> containers.

Which would seem to apply that in a 'stacked' LSM configuration of
SELinux and AppArmor, there would be a possibility of using the two
LSM's without them 'colliding', the equivalent of what could be
considered a 'nested' LSM implementation.

Casey had also suggested in this thread that this would be possible at
the risk of a system that would be difficult to reason about.

Were our previous comments correct, that the path forward would be to
have SELinux configured in a manner where it would not act on any of
the subject/object interactions that occur in the container
environment that is using AppArmor?

If so, would the path forward be to implement an SELinux policy that
would place the process initiating the namespace, and its descendants,
in an unconfined domain with respect to the assets in the scope of the
container?

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
