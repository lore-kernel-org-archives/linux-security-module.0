Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F1C433FE
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Oct 2022 12:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJEM7e (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Oct 2022 08:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJEM7d (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Oct 2022 08:59:33 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A67823E;
        Wed,  5 Oct 2022 05:59:32 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52138)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3zn-00BkiA-Kh; Wed, 05 Oct 2022 06:59:31 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48256 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3zm-008PSK-Oj; Wed, 05 Oct 2022 06:59:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Date:   Wed, 05 Oct 2022 07:59:24 -0500
In-Reply-To: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 4 Oct 2022 14:30:35 -0700")
Message-ID: <87czb6h1eb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1og3zm-008PSK-Oj;;;mid=<87czb6h1eb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX194papHtAgjuUo54RQw7kyhgOiDF0VRh3g=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Oct 4, 2022 at 1:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So this whole "don't do this" approach you have is not acceptable.
>
> Side note: if we have a security hook for "create random file", then
> the notion that creating a whole new namespace somehow must not have
> any security hooks because it's *so* special is just ridiculous.
>
> I also note that right now USER_NS is both "default n" and "if not
> sure, say 'n'" in the Kconfig files, even though obviously that ship
> has sailed long ago.

Definitely.  I did try and slow the up take as long as I could when
the code was maturing.

> So originally it might have been a reasonable expectation to say "only
> enable this if you're doing containers in servers", but that clearly
> isn't the case any more. So we basically take USER_NS for granted, but
> the fact that people might want chrome to use it for sandboxing does
> *not* mean that randomly we want any CLONE_NEWNS to just be ok,
> regardless of how trusted (or not) the case is.

Most importantly chrome shows how the mechanism this patch is using to
deny user space applications is one that ``breaks'' userspace.  AKA
causing to silently fall back on less tested code paths that existed
before user namespaces were common.  Any application that does this
uses less trusted code paths.

I am pretty certain that the code should be sending a fatal signal
instead of returning an error code on user namespace creation.  I
unfortunately hadn't realized the implications until this conversation.



That said Chrome and sandboxing I think is a reasonable case to look at
to demonstrate the trade-offs.  This is not all about increased kernel
attack surface, user namespaces also enable reduced attack surface in
sandboxes, which can make applications safer.

Eric
