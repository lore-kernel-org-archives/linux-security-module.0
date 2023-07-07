Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F95EB64D9
	for <linux-security-module@archiver.kernel.org>; Fri,  7 Jul 2023 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGGRwI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjGGRwH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jul 2023 13:52:07 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1491610EC
        for <linux-security-module@vger.kernel.org>; Fri,  7 Jul 2023 10:52:05 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 367HpCOZ006356;
        Fri, 7 Jul 2023 12:51:12 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 367HpBX7006355;
        Fri, 7 Jul 2023 12:51:11 -0500
Date:   Fri, 7 Jul 2023 12:51:11 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a process on Host
Message-ID: <20230707175111.GA6201@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 07 Jul 2023 12:51:12 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 07, 2023 at 05:28:36PM +0900, Leesoo Ahn wrote:

Hi Leesoo, I hope the week has gone well for you.

> 2023-07-06 ?????? 10:43??? Paul Moore ???(???) ??? ???:
> >On Thu, Jul 6, 2023 at 1:20???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> > >
> > > Hello! Here is another weird behavior of lsm stacking..
> > >
> > > test env
> > > - Ubuntu 23.04 Ubuntu Kernel v6.2 w/ Stacking patch v38
> > > - boot param: lsm=apparmor,selinux
> > > - AppArmor (Host) + SELinux (LXD Container Fedora 36)
> > >
> > > In the test environment mentioned above and applying selinux policy
> > > enforcing by running "setenforce 1" within the container, executing the
> > > following command on the host will result in "Permission denied" output.

> >SELinux operates independently of containers, or kernel namespacing in
> >general. When you load a SELinux policy it applies to all processes
> >on the system, regardless of where they are in relation to the process
> >which loaded the policy into the kernel.
> >
> >This behavior is independent of the LSM stacking work, you should be
> >able to see the same behavior even in cases where SELinux is the only
> >loaded LSM on the system.

> Thank you for the reply!
>
> So as far as I understand, the environment of LSM Stacking, AppArmor
> (Host) + SELinux (Container) couldn't provide features "using
> SELinux policy inside the container shouldn't affect to the host
> side" for now.
>
> If so, I wonder if you and Casey plan to design future features like
> that, because my co-workers and I are considering taking LSM
> stacking of AppArmor + SELinux in products that both policies must
> be working separately.

I see that Paul Moore has also replied and indicated that 'stacking'
doesn't imply either/or separation of security policy in a string of
LSM's.  As he also noted, it does not apply isolation and application
of security policy at the container or kernel resource namespace
level.

Just as an FYI, we will be releasing version 2 of our Trusted Security
Event Modeling (TSEM) LSM over the weekend for review and inclusion in
the upstream kernel.

TSEM 'stacks' with the other LSM's, but was architected from the
ground up to support the notion of security namespaces that operate
exclusively from one another, with the express goal of allowing
multiple and distinct security policies to be applied independently at
what would be considered the 'container' level.  Subordinate security
modeling namespaces also act independently from the security
model/policy that the 'root' modeling namespace is operating under.

TSEM is based on a mathematical modeling architecture that is
different from either the label or pathname based LSM's which allowed
us to sidestep some of the issues that are challenging with respect to
implementing full namespace support for those LSM's.

There is a sizable stack of documentation with TSEM that goes further
into all of this.  We also release a rather significant body of
userspace tooling that goes with the TSEM LSM to support running
'security containers', for lack of a better term.

It obviously takes a while to develop a security eco-system but TSEM
will hopefully offer security architects additional flexibility moving
forward.

> best regards,
> Leesoo

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
