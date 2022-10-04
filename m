Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CEC433FE
	for <linux-security-module@archiver.kernel.org>; Tue,  4 Oct 2022 20:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDUhE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDUhD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Oct 2022 16:37:03 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1585E5072B;
        Tue,  4 Oct 2022 13:37:01 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:48246)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofoex-002GnZ-Me; Tue, 04 Oct 2022 14:36:59 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:35366 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ofoew-006tp6-DP; Tue, 04 Oct 2022 14:36:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
Date:   Tue, 04 Oct 2022 15:36:14 -0500
In-Reply-To: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        (Paul Moore's message of "Mon, 3 Oct 2022 18:37:59 -0400")
Message-ID: <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ofoew-006tp6-DP;;;mid=<87sfk3mim9.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/CNA2V/chByfUqrnUOWta2brEHwV7NaoA=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Linus,
Please don't pull the user namespace bits of this code.

Paul Moore <paul@paul-moore.com> writes:

> Hi Linus,
>
> - Add a LSM hook for user namespace creation, with implementations for
> both the BPF LSM and SELinux.  Even though the changes are fairly
> small, this is the bulk of the diffstat as we are also including BPF
> LSM selftests for the new hook.  It's also the most contentious of the
> changes in this pull request with Eric Biederman NACK'ing the LSM hook
> multiple times during its development and discussion upstream.  While
> I've never taken NACK's lightly, I'm sending these patches to you
> because it is my belief that they are of good quality, satisfy a
> long-standing need of users and distros, and are in keeping with the
> existing nature of the LSM layer and the Linux Kernel as a whole.  The
> patches in this pull request implement a LSM hook for user namespace
> creation that allows for a granular approach, configurable at runtime,
> which enables both monitoring and control of user namespaces.  The
> general consensus has been that this is far preferable to the other
> solutions that have been adopted downstream including outright removal
> from the kernel, disabling via system wide sysctls, or various other
> out-of-tree mechanisms that users have been forced to adopt since we
> haven't been able to provide them an upstream solution for their
> requests.
>
> Eric has been steadfast in his objections to this LSM hook,
> explaining that any restrictions on the user namespace could have
> significant impact on userspace.  While there is the possibility of
> impacting userspace, it is important to note that this solution only
> impacts userspace when it is requested based on the runtime
> configuration supplied by the distro/admin/user.



> Frederick (the
> pathset author), the LSM/security community, and myself have tried to
> work with Eric during development of this patchset to find a mutually
> acceptable solution, but Eric's approach and unwillingness to engage
> in a meaningful way have made this impossible.  I have CC'd Eric
> directly on this pull request so he has a chance to provide his side
> of the story; there have been no objections outside of Eric's.

Paul I am not unwilling.  I have not had much time, or energy.
It feels like every disease that has been going around has made
it's way into my household in the last couple of months.  Including
my son catching COVID just a little while ago.  Inspite of that
I have taken time to engage but the things I have asked for
have not happened, so I have started nacking the patchset.


I have asked on multiple occasions what the problem that is being solved
with this hook so I could understand the problem, and I have asked that
the problem be documented in the patchset.  Something that has not
happened.


I have told you that from a this violates the design of the user
namespace, and said that because of that this is not something that
should be done casually, and it feels like you have simply brushed aside
the objection.  Instead of doing digging into this and showing that
this change to the design won't enable new problems.



From my limited amount of information I have into what people want to do
this appears to be shooting the messenger (the user namespace), given
that there is practically nothing to the user namespace itself.

This can be seen by considering a version of the linux kernel that does
not support privilege changes on exec.  In such a kernel everything that
is enabled as root in a user namespace would largely be enabled for all
applications all of the time.  As with user namespaces the only
restriction really needed is not to be able to modify a namespace
created by another user.  In such a kernel I strongly suspect the
problem that is trying to be solved by the create_user_ns hook is not
being solved.



There is the issue that Serge Hallyn demonstrated that if the concern is
about exploiting functionality the user namespace makes available
then setns is enough, if the user ever creates a user namespace for
any purpose.  Which makes fine grained limiting of user namespace
creation seem questionable.


There is the issue that you are adding a hook into the code user
namespace for out of tree code (LSM policies).  Code that has not shown
itself to be particularly fixable once a buggy version is deployed.
Examples of long time code challenges because of such out of tree code
include /proc/net pointing to /proc/self/net instead of
/proc/thread-self/net, and the same_thread_group check in
__ptrace_may_access.  When I added that same_thread_group check in
__ptrace_may_access I got the impression the LSM folks were going to fix
their LSMs so that it could be removed.

Usually when adding something for out of tree code, it is appropriate
to have a discussion on linux-api and to document the change.  Something
you have not done.


As a maintainer I am still getting bug reports about software that
attempts to lock down a container without using user namespaces.
I have to tell them the fix is use user namespaces.  I am concerned
that there will be random policies in place that encourage people
to perform less secure work-arounds in their user space applications
to get around whatever security polices will be invoked.  Something I
have not seen addressed.


This whole notion that you are going to randomly deny access to the user
namespace for random reasons and aren't willing to discuss those reasons
makes me supremely uncomfortable, and has me thinking that it will
result in a choice of maintaining user namespaces or breaking userspace
at some point.  I would really like some reassurance that we are not
going in that direction.



There is also the issue of the what happens in practice when you deny
creation of a user namespace.  Something I have asked to be explored,
and to which I have seen no one take the time and do.  Something that
won't happen in linux-next as the userspace polices that trigger the
new behavior are not there.

As far as I can tell there are a couple of scenarios that can
happen if you deny creation of a user namespace to an application.

1. It will decide it does not have what it needs and exit.
2. It will silently fallback on pre-usernamespace code that does
   not use a sandbox.  In my testing this is what chrome appears
   to do.
3. It won't try and create a user namespace so nothing happens.
4. It will be an program searching for a kernel exploit and it will
   just try another way to exploit the system.

Given that some applications will become less secure when denied access
to user namespace creation killing those applications with an
uncatchable signal rather than letting continue silently seems more
appropriate.  I suggested this but the suggestion received no traction
in our discussion.

Now that I have taken the time to verify my suspicions I am going to be
modifying the enforcement of max_user_namespaces to user an uncatchable
signal.  The entire notion of tricking an application to thinking it is
running on an old kernel that does not support user namespaces,
resulting in a silent down-grade of application security does not make
me at all comfortable.


As someone who is going to have to deal with the aftermath of adding
this security hook in the years ahead I would really appreciate that we
think these things through before we merge this and wind up in a very
unpleasant situation with no good choices in the years ahead.

I hope I have made my objections clear enough that they can be
understood this time around.

Eric
