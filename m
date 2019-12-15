Return-Path: <SRS0=H1aQ=2F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EDC43603
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 23:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FE52467A
	for <linux-security-module@archiver.kernel.org>; Sun, 15 Dec 2019 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576452430;
	bh=SaxfkzNQTUcffJfpkXAwED/JqIwCQVeEd84yluBQb7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WhxXI2womhWqVvHv3aE3eYDpAeggIS9XtG11/wW8I0/7+MaK/HAkmV5uR/tCqarOQ
	 IOxJLYa8/KPaKR79MsNnExSWxe+1Q0CfRkuERX24tj+pCJCqAABQ3j+WHgIqNmDyaW
	 6FSNOsVKxe1wiNVw4lAaScAtc9DYtIexlqc0Fgbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLOX1J (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 15 Dec 2019 18:27:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36163 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfLOX1J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 15 Dec 2019 18:27:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id a203so2810490qkc.3
        for <linux-security-module@vger.kernel.org>; Sun, 15 Dec 2019 15:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SaxfkzNQTUcffJfpkXAwED/JqIwCQVeEd84yluBQb7E=;
        b=oJWTn+pjpVV3JGFMy8alct2RYxACERRvF1HOlA/1yclfuofmeXK2IwtlZfpB2BAaI0
         CdTBMyfSa6sOYhE9tk/7O11SqmdWSeG+K2zYfHNn6YU/38HK34T8gkjXwSHN4CWiplQN
         1Z+KNl1ZWeZ1brDBjMT/+/fSAk5hJfpACrDb4POGYnideaSki6wF5UuC59znZGE3jsSE
         JbSP7+oVK4lC7zbnoBKkzhWbz46CImLFAIJBE/YXW30buUrW/pHEQGJ2oXrhh5cZqai/
         Y+DhVUknBu79F8cCxWsvWMFW6nvVS5hT4TSTbRRViNA+OOZfLWPdppsLKin0Qal6bUyq
         xnig==
X-Gm-Message-State: APjAAAVJkCNGJwl2K/c3VYN2i+/LdLMM9t8fyREdDanrqcmKA58kTJT7
        yMggc8Pzr1SQK39kgCOyJfM3n1dHT/oMX9RjN1Dlog==
X-Google-Smtp-Source: APXvYqxKDkFtJzOuPW9p8FaxDjrNxMpeH1PbH0D+6MxQ9O0NGQAdO7iFokwxMww0M7MEOTZxjz6EI3ZJkogP9A8F66M=
X-Received: by 2002:a37:b601:: with SMTP id g1mr24786560qkf.114.1576452427756;
 Sun, 15 Dec 2019 15:27:07 -0800 (PST)
MIME-Version: 1.0
References: <CAKgNAkiyAkZy=oLrpJvHYU9Tq1dunNJLOJdtr508_w3vrdPWcQ@mail.gmail.com>
 <CALQRfL7i5r1d1K3fOuwyJ0BtmrsVMC8zzdd0Z7=14n3X8QNw5g@mail.gmail.com> <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
In-Reply-To: <CAKgNAkjuFOumKV6Z+GDDEjLrVup7fJB_H86xguJ7asdUdfEBxQ@mail.gmail.com>
From:   "Andrew G. Morgan" <morgan@kernel.org>
Date:   Sun, 15 Dec 2019 15:26:56 -0800
Message-ID: <CALQRfL57VP_VHuHSzM9A65wxR6LjsH9+3wgeQ3qQEU0G9PuWHw@mail.gmail.com>
Subject: Re: Anomalous output from getpcaps(1) for process with all capabilities
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        ksrot@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[Resend with reply-all this time.]

On Sun, Dec 15, 2019 at 11:17 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Andrew,
>
> On Sun, 15 Dec 2019 at 19:30, Andrew G. Morgan <morgan@kernel.org> wrote:
> >
> > This changed with this commit I think:
> >
> > https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=3fa808f5886d08c45866217cfe6e6e9def7de04e
> >
> > Prior to that, we had "=ep" mean the cap set was ~0 for
> > all the bitmasks in e and p. When we started to clip the
> >bounding set to only defined capabilities, it meant that the
> > text output started to look like
> > "=ep 33,34,35,36,37,38,39,40,41,42.....63-ep" which
> > was quite terrible.
>
> Was that really the change that caused this? That's a 2008 commit.
> Certainly, I recall in 2014 or 2015 still being able to see =ep, and I
> presume (but do not recall for sure) that I was using a system with a
> libcap more recent than v2.11 (of which that commit was a part).

The only other commit that seems relevant was this one:

https://git.kernel.org/pub/scm/libs/libcap/libcap.git/commit/libcap/cap_text.c?id=afb17b8c007a49d93b0d30936b2d65af1bfdb039

But I think this was all part of the same effort.

> > So, this was seen as the least worst option.
>
> But surely this is fixable? Or, to put it another was, I presume
> there's something that makes this difficult to fix in getpcaps, but
> what is that something?

I recall spending a day or more trying to avoid it, but I can't see
how it is really fixable because there are too many moving parts.

If the kernel adds another capability, then =ep could reasonably mean
both the "old full set" or the "new full set". There are contexts
where the difference matters. For example, where folk are using text
representations for things like package manager shell-script setups.
What they get when they say "=ep
cap_setpcap,cap_sys_admin,cap_setfcap-ep" today, might suddenly be
inappropriate when the new kernel adds "cap_self_destruct". At least
the way it is at present, we are very explicit about what is in
effect.

Cheers

Andrew

>
> Thanks,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
