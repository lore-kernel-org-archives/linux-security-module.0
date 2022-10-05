Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DAC433F5
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Oct 2022 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJEPdo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Oct 2022 11:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJEPdn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Oct 2022 11:33:43 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB0B78220;
        Wed,  5 Oct 2022 08:33:39 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55402)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og6Ov-003s6G-9S; Wed, 05 Oct 2022 09:33:37 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:37298 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og6Ou-009DOt-7q; Wed, 05 Oct 2022 09:33:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
        <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
Date:   Wed, 05 Oct 2022 10:32:58 -0500
In-Reply-To: <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
        (Paul Moore's message of "Wed, 5 Oct 2022 09:38:27 -0400")
Message-ID: <87a66ae15h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1og6Ou-009DOt-7q;;;mid=<87a66ae15h.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19023JUCXseQOFmljSDa0wPGkT0zrxXDc4=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Oct 5, 2022 at 8:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> ...
>
>> > I'm not saying that an LSM is the only place to do it, but I don't
>> > think there have been any better suggestions either.
>>
>> I don't know.  I tried to have the conversation and Paul shut it down.
>
> I would encourage anyone reading the above statement to look at the
> previous discussion, links were provided at the top of this thread in
> the original pull request.

Or they can just look below at your defense of out of tree code.
Where you again refuse to consider the other point of view.

>> Effectively he said that where two or more out of tree LSM policies want
>> something it makes no sense to discussion the actual reasons people want
>> to use the hook.
>
> Runtime kernel configuration is inherently "out of tree", this
> includes not only loadable LSM security policies (e.g. a SELinux
> policy), the system's firewall configuration, things like sysctl.conf,
> and countless others.  Please understand that "out of tree" in this
> context is not the same as when it is used in the context of kernel
> code; the former is actually a positive thing ("look we can configure
> the kernel behavior the way we want!") while the latter is a
> maintenance and support nightmare.

Paul are you saying my experience with /proc/net pointing incorrectly at
/proc/self/net instead of /proc/thread-self/net is invalid?

Paul are you saying that my experience with LSM needed a hack for
buggy LSMs in __ptrace_may_access since Jun 2006 is invalid?

My experience with the conditionals and the policy (not just on/off
configuration) existing in userspace is very much the maintenance and
support nightmare you have been describing.

In this case it is compounded because the mechanism chosen to alert
userspace of a failure (the error code) is chosen by userspace.
Further this is a mechanism that does cause silent application failures.

Do you see how it could be a concern with silent application failures
and no control in the kernel to fix anything if/when this turns into a
real world problem?  Yes, I finally found the time and tested and
verified that is the case.


I am also wondering how you see it makes sense to add userspace
functionality without discussing it on linux-api, and not documenting
what is being added?  It is easy to overlook but it was suggested.

I am wondering how you feel about adding a mechanism to the kernel
that results in userspace breakage if used?

Eric
