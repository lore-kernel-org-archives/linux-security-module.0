Return-Path: <SRS0=opVv=TM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCABC04A6B
	for <linux-security-module@archiver.kernel.org>; Sun, 12 May 2019 19:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB36921019
	for <linux-security-module@archiver.kernel.org>; Sun, 12 May 2019 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557688684;
	bh=YTdu+RGIXE+yh4I+ry6/A1VY5R4PrBznNGEOgW3q/yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CVEVa9aiYZrBXncfBh3/YhFCn9UW8ULqIGlLTF8xeJHZH9x8IV+9j86YBUEZmHRcZ
	 5lvOsMxXOG8R7eNAwRqa4TNBRpEhGPLZ3hKPz+zJp7BFOco/SvpK6CGOhf0Lkeznsu
	 a+EUK81hUzqMc9PRhPFijSVEe6QB4YaVwQbqg7qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfELTSE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 12 May 2019 15:18:04 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:41249 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfELTSD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 May 2019 15:18:03 -0400
Received: by mail-lj1-f172.google.com with SMTP id k8so9037567lja.8
        for <linux-security-module@vger.kernel.org>; Sun, 12 May 2019 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MSZEHCyfykuTsR5UxAxvZRk6avmGdIqI2k10oF5oMw=;
        b=KdLaCUwO/LnM7f3mmNdi0GYIW6HvshB36R3VN3KEhRIHtUcJiw4NQU2ksjWVyAjymH
         WVbB/8EOAlfLMV2f40L8JX7XSxLrGXh9tPxjQDuO3Awy9DmM1v6TJZmO5L5KI3Rbupw0
         BN8jGKNmomo2oxR+K802Q+5y+Pocrj/nXQ0tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MSZEHCyfykuTsR5UxAxvZRk6avmGdIqI2k10oF5oMw=;
        b=VsVuhrICO88Dh5A0QryiqqjRItfak1Fw5l4RjGZYLr8UV+EtP90wnbX+rf7U+su7Sa
         WOteTyZz5yIokh53f0aqX088IqGPZRTH/Bbz38lDryTLyH9eoUxtnZ6wjEuPkYG2b52x
         +L/VffBASXlkMIIRj96fDb59nak9s9k+WGj60fpzXIU1u7uYnbNmQ3zSQAmT0ieVoMI+
         h4Rkeq0vdzv2uREsSA0IQkFGwitJxGN6/kJu9ZelTEPp4/H1zbTev4RlNXlYmEwuFy7y
         7GXyqWY091i8vt7GY8CyUySU7Onv8s2tXjOrEzkjEDX5TGBktTsE6xY7ZwblqONRW/22
         bPAw==
X-Gm-Message-State: APjAAAXInMLi3MUQJdCb7KJxl9lXlkOpsgPf9l8pRDAZhpHuwna+F3r2
        pAPzw/7+CCi1zn83isZGKJewSWOvdEA=
X-Google-Smtp-Source: APXvYqwYJNP1AVMOy+SLc6Ias2umQQ6VfmrLaSUrrxx1wZMMDV7oZDeOOlsxXj7gf6aHym6imPa0Hg==
X-Received: by 2002:a2e:9ada:: with SMTP id p26mr11278850ljj.167.1557688681017;
        Sun, 12 May 2019 12:18:01 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r11sm1993435ljd.91.2019.05.12.12.17.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:17:59 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id n134so7417759lfn.11
        for <linux-security-module@vger.kernel.org>; Sun, 12 May 2019 12:17:59 -0700 (PDT)
X-Received: by 2002:ac2:5212:: with SMTP id a18mr11822328lfl.166.1557688678930;
 Sun, 12 May 2019 12:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
 <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com>
 <24d602d2-a1a7-7b1e-9035-a2d732cd822b@schaufler-ca.com> <CAHC9VhR-oqJwyvB2JhzTu2_nuZuENA=Y9f4rtfUrSGtLMnGZfw@mail.gmail.com>
In-Reply-To: <CAHC9VhR-oqJwyvB2JhzTu2_nuZuENA=Y9f4rtfUrSGtLMnGZfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 May 2019 15:17:42 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh33PsgxtwXdzDgx13tARBnhzkPV9294L2g6OjOBeNvfA@mail.gmail.com>
Message-ID: <CAHk-=wh33PsgxtwXdzDgx13tARBnhzkPV9294L2g6OjOBeNvfA@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, May 12, 2019 at 11:33 AM Paul Moore <paul@paul-moore.com> wrote:
>
> As far as I'm concerned, whatever makes it easier for Linus to consume
> the changes is the preferred path.

So for me it's not so much the pulling itself that ends up being a
problem, it's just that I want to feel like the pull request makes
sense, and I want to feel "safe" in pulling it.

The audit and selinux trees haven't had any issues that I can recall,
so that has worked fine. And it's been easier now that most of the
security layer things have been coming in separately, so it's easy for
me to see what's coming in, when it's in sane chunks that stand alone.
And then I also feel like _if_ there are problems in one area, it's
not affecting any other area the things are now. So if there's
something I want to look at a bit more, I might pull all the other
requests that I don't have any questions about, so that I can then
look more closely at the part I want to understand better.

I basically want to see pulls being "well-defined". That's both in the
area they affect, but also in the explanations for the pull request,
and preferably really also in the history (ie both the whole "starting
at a well-defined point", but also a "history is nice and clear", so I
like seeing topic branches and well-defined merges).

I guess it's kind of hard to explain, but it just gives me the warm
and fuzzies if I do a

    gitk ORIG_HEAD..

after having done a merge, and the history and merges I see "make sense".

Then I feel like even if there are problems with the code I pull, even
the problems will hopefully be well-defined. Sometimes that is
literally "ok, I'm bisecting some issue, but even before I've bisected
the whole way, I can see that it came in through a particular pull
request or two" because the changes came in through a few clearly
separated topic branch and it's clear which pull request it is even if
there are still a hundred more commits to bisect all the way..

Side note: this depends on the subsystem. When I pull huge subsystems
like networking from Davem or the big driver pulls from Greg, I don't
even look at the gitk history and ask myself "does this make sense",
because I have ceded that kind of worries over to Greg and Davem. The
history in their areas are their concern, and their subsystems are so
big that I don't expect them to make it make sense to me, if you see
what I mean. But if you want to see an area where you can see how
people have split up development in topic branches, you can look at my
"x86 merges", where I get separate pull requests for each topic
branch, and they all tend to be very clearly defined (but then there
might often a "misc leftovers" branch, or a couple of branches that
are just one or two commits).

>     My guess is that you are right and
> any *significant* changes to the LSM layer itself, e.g. security/*, is
> best sent via James' tree.  For smaller changes to the LSM layer I
> think it's okay if they go in via an individual LSM tree so long as
> all the other LSMs agree-on/ack the changes; which pretty much fits
> what we've been doing for some time now and it seems to work well
> enough.

Yeah, I think that's the sane model. And I think it's mostly been working.

             Linus
