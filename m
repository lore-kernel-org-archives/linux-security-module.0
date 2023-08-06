Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A90C0015E
	for <linux-security-module@archiver.kernel.org>; Sun,  6 Aug 2023 17:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjHFRRH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 6 Aug 2023 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjHFRRG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Aug 2023 13:17:06 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7895C2
        for <linux-security-module@vger.kernel.org>; Sun,  6 Aug 2023 10:17:04 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 376HGNJc017666;
        Sun, 6 Aug 2023 12:16:23 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 376HGMKs017665;
        Sun, 6 Aug 2023 12:16:22 -0500
Date:   Sun, 6 Aug 2023 12:16:22 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Leesoo Ahn <lsahn@wewakecorp.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [LSM Stacking] SELinux policy inside container affects a processon Host
Message-ID: <20230806171622.GA17655@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <32e59b69-79a2-f440-bf94-fdb8f8f5fa64@wewakecorp.com> <CAHC9VhRdCSJwB9hpyrCe+D00ddeRLisz=9GEWJz50ybr80tnsg@mail.gmail.com> <4ec9e7ae-e95e-a737-5131-0b57922e4fce@wewakecorp.com> <CAHC9VhQBbbSu6YBbnXOPMjpBxQxc1nmgA+icfN4x6s6FeQSeiw@mail.gmail.com> <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02da6484-658c-bfe8-0ae0-08ffe9b93c47@wewakecorp.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 06 Aug 2023 12:16:23 -0500 (CDT)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 28, 2023 at 10:54:23AM +0900, Leesoo Ahn wrote:

> I hope you have a great day today

Hi Leesoo, I hope your week is starting well.

> 2023-07-07 ?????? 11:20??? Paul Moore ???(???) ??? ???:
> >On Fri, Jul 7, 2023 at 4:29???AM Leesoo Ahn <lsahn@wewakecorp.com> wrote:
> 
> [...]
> 
> >
> >What you are looking for is a combination of LSM stacking and
> >individual LSM namespacing. Sadly, I think the communications around
> >LSM stacking have not been very clear on this and I worry that many
> >people are going to be disappointed with LSM stacking for this very
> >reason.
> >
> >While stacking of LSMs is largely done at the LSM layer, namespacing
> >LSMs such that they can be customized for individual containers
> >requires work to be done at the per-LSM level as each LSM is
> >different. AppArmor already has a namespacing concept, but SELinux
> >does not. Due to differences in the approach taken by the two LSMs,
> >namespacing is much more of a challenge for SELinux, largely due to
> >issues around filesystem labeling. We have not given up on the idea,
> >but we have yet to arrive at a viable solution for namespacing
> >SELinux.
> >
> >If you are interested in stacking SELinux and AppArmor, I believe the
> >only practical solution is to run SELinux on the host system (initial
> >namespace) and run AppArmor in the containers. 

> Paul, I don't get that SELinux on the host system and run AppArmor
> in the containers is the only practical solution. Could you please
> explain that in more details?

It appears that Paul is extremely busy, so I thought the 'Quixote
Group' would try and offer some reflections that may help with your
efforts.

The most important issue in all of this is to understand that Linux
LSM's 'stack', they don't 'nest'.

If more than one LSM is enabled, their hooks will be called
consecutively until one fails or they all succeed.  There is currently
no concept of an 'LSM namespace' that would allow the actions of one
LSM to be isolated from a second LSM that is enabled.

So if you are attempting to run SELinux and AppArmor on the same host,
you need to reason through the effective security policy that results
from the combination of the SELinux and AppArmor policies.

We would certainly not profess to be the experts on LSM/SELinux that
Paul is but I believe the point he is making is that, in his opinion,
the only way to allow both policies to effectively co-habitate is to
use SELinux enforcement on the host system and AppArmor enforcement in
the container environment.

Lets see if we can reason through a hypothetical example that would
illustrate the issues involved.

If SELinux 'goes first', which will probably be the case, there will
be a need to have an SELinux policy in place that does not prohibit
the interaction of subjects and objects in the container environment,
otherwise you will get whatever the effective SELinux policy is.  Once
SELinux elects to not deny a security event, an AppArmor policy will
have the opportunity to make security decisions for the processes
running in the container environment.

As Casey has noted previously in this thread, creating this type of
environment will no doubt require some degree of sophistication and
expertise in both SELinux and AppArmor policy development and
implementation.

Hopefully the above will help facilitate further understanding with
respect to your efforts.

> Best regards,
> Leesoo

Best wishes for a productive remainder of the week and the success of
your work.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
