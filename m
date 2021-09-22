Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78C4C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Sep 2021 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E99608FB
	for <linux-security-module@archiver.kernel.org>; Wed, 22 Sep 2021 20:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhIVU60 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbhIVU6V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Sep 2021 16:58:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F16C061764
        for <linux-security-module@vger.kernel.org>; Wed, 22 Sep 2021 13:56:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g41so17108076lfv.1
        for <linux-security-module@vger.kernel.org>; Wed, 22 Sep 2021 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snAHFG5xCkeTvyFu2mD4X2wabo24gdMDn530482Xypw=;
        b=cTEvG+kHc4uB7yEtKNHCaR8BVCBCKx/AXjDqWSalmiqES3V438gK0Wr3VHWEE7fFnC
         jOfbPqcPi7D6EiPN9jh0bUTMxJJ/BARQh3eK1gAPGiAueMThy4Vjzgd2rqp5A+Q0ARos
         cfJaQrPjgEZ85kDS8LVy0KAD7yWeCE+u5uE2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snAHFG5xCkeTvyFu2mD4X2wabo24gdMDn530482Xypw=;
        b=Ybp8iJjD0mVuFe2ruvZdW98/DcEcuSVK+wmCn5rIeLhAL188QS7zmvUpgqCq6q6S3J
         4rzNDRuolNKLhmLroNEnWHI5ZOa/Wdxs0AzYGjYU/U1mNMW9eXtl6j9OpCw03wfKa2e8
         q0kh6FKVDJeF7Sc1grx6LskBPpiUGwR6ySUqgAM4R0qRqWq6xQ5UNsgbuWTgfKsWAMRz
         E3XyQ7BXYiNI5wKHafoVRUr+JXoi88d2+Ju/a+K/K7dXW0lD9PICcKomTEFXJ/9/EYOE
         D7BVgm2nmcU/7MyAm2LcHH69WCSmA4udiJ8nSmFp/DSpcd2tZIcrd300WAAD1ukD5+0r
         DJJA==
X-Gm-Message-State: AOAM531u0bc144uxZkRw+xit8sTScI9Khp17UZY08BRNI5qXa58/bn/E
        fWydKJrC7RHSr3mnPw2OWn/RzKUH/2IQCzxi/gM=
X-Google-Smtp-Source: ABdhPJy5Nq+qTFkFaGE/1jZCQKa4KJgbLWv6c2bxawqubGs8Vopi98aYBqm0ecWDUMFZ/GJXfgCFbA==
X-Received: by 2002:a2e:9150:: with SMTP id q16mr1380714ljg.418.1632344176783;
        Wed, 22 Sep 2021 13:56:16 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m12sm364948ljh.21.2021.09.22.13.56.15
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 13:56:15 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y28so17150960lfb.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Sep 2021 13:56:15 -0700 (PDT)
X-Received: by 2002:a19:ae15:: with SMTP id f21mr922847lfc.402.1632344175487;
 Wed, 22 Sep 2021 13:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 13:55:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
Message-ID: <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 22, 2021 at 10:57 AM Paul Moore <paul@paul-moore.com> wrote:
>
> I wanted to check in on this PR to see if you were planning on merging
> it for v5.15-rcX, kicking it back for -next instead, or simply glaring
> at it with quiet disgust?

Heh. I glanced at it with quiet disgust when it came in, and then it
just got lost.

But now I'm looking at it again since you reminded me, and I don't
understand why it has to be done in such an ugly manner.

And I also don't think the thing makes a whit of sense in the first place.

Honestly, that whole "lockdown depends on current creds" makes NO
SENSE at all to me. The whole and only point about lockdown is that
it's locked down. Not that "oh, root can do X". That's against the
point.

The whole and only point of lockdown was as a global thing. Now
somebody seems to have noticed that they violated that basic rule, and
that it's about permissions after all, and it's just a complete mess.

But why the heck would a normal lockdown user have to care about this
fundamental design mistake? Why should a normal lockdown user pass in
a credential that doesn't make sense?

Since 99% of all users DON'T want special rules, why isn't the normal
security_locked_down() kept the way it is?

Make the few special cases do special things, in other words.

This is *literally* why we have all those wrapper functions in
security/security.c - so that people can do sane interfaces and not
call down to the raw hooks.

(Yeah, yeah, a lot of them do nothing but pass it down, but others do
other sanity stuff so that callers don't have to do pointless
boilerplate)

IOW, why is this changing all the normal users that *really* don't
want it, and that really have absolutely no business looking up the
current creds?

Make the regular security_locked_down() function do that, and add a

    if (WARN_ON_ONCE(!in_task()))
        return -EPERM;

so that any bad cases get flagged and refuse to continue.

And then the couple of special users (whether due to interrupt context
or whatever), could get their own wrapper function.

Note how that would
 (a) make the patch smaller
 (b) not pollute normal users pointlessly
 (c) actually be a kind of documentation too
 (d) not make the default lockdown testing function be senseless

because right now you have absolutely no explanation in the crazy
cases, so y9ou have code like this:

        lockdown = !!security_locked_down(NULL, LOCKDOWN_XMON_RW);

in xmon_is_locked_down(), and it makes no sense to anybody. Why the
NULL? What is going on?

Yes, yes, I can tell why the NULL, and what is going on, because I
read the commit message and it's in my context. But look at that line,
and tell me that it makes sense as code to anybody who has paged out
that context (or never had it in the first place).

If it said "security_globally_locked_down()" maybe it would at least
give a hint about what's going on.

But the other side of the argument is that the *common* lockdown
functions are insane too after the patch. In kernel/module.c, this
line:

        return security_locked_down(current_cred(), LOCKDOWN_MODULE_SIGNATURE);

really screams "lockdown is fundamentally broken and mis-designed".

Seriously. If lockdown needs "current creds" then lockdown is wrong.

I was unhappy about lockdown from before, so maybe I'm more likely to
just reject this kind of garbage, but this really looks completely
broken to me.

Hmm? This lockdown stuff is some ugly random code to begin with, I
think the interfaces need to make SENSE. Passing in credentials
fundamentally does not make sense to me.

              Linus
