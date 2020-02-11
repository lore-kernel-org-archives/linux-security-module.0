Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB37C35242
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346FF20842
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 19:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZhloKZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgBKTgp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:36:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42364 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgBKTgp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 14:36:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so11321552otd.9
        for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2020 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxqF+VNeMWZGe5ApL4PlqNlBNetErOePHfuXXbpvPY8=;
        b=IZhloKZlSi90VZuyomEqK+wb28Ls462eDYugPvp1S7ESpuRD4Rfl6jLj2xl2jhqEVH
         7ho7YjhbHTbVYCyzKyNalVjYOxoQbOO1JHWlIPbYbpej0Q62uLfuEXSWZcUj9KfIv0Gd
         QZTUlFVV5gdTcvaT6/P165+oF7SbzBPL2GjYEKXQXLq2ZfuVBlj7RCbVUnqa+L7lBdwX
         o2d6FYR7ZmxhttJWZM06H/Cjb1GxGmlwA/tAi+NjvbFsx5T3j0Qt8V1ZOVOua8p2nBVG
         bXPVjnPAiq0mc8uFLwuc2NsrL8+cV53joMVXnRy60OaZKL5CJsjqbXpW1cJaEECq7a9z
         F8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxqF+VNeMWZGe5ApL4PlqNlBNetErOePHfuXXbpvPY8=;
        b=YI0cj0VZlFPlMzPVsq8iYROB0JBulkJOLAfgG+nOTpG8oAyNXuqL/O0xZVgJYCUk0G
         La58GjUFby3c813LydAL7aH3ugX5G/i4LzApY3El9BZA5UdmIUHhJb4xsONNkjSbOULx
         ewWFz5up7gFoLHtmE8PBv5skAcQPZ93KmNjLD3ZrXGkUjeC6O5GVB4NEcB9Mn9qtsXzz
         0w+d99AXYaX3Qj+DRRq7S8OjSqLM0fuCcrCyeO4+e7RaVh7FXPteRtlQGUs9aoIvkMLs
         po9X1WnRdXI4ZgmyYiT3NEtlizJ1/lQqRun7Ao9NxuTZWwyZ7/EOV4RYevkBnxdPihYD
         IweA==
X-Gm-Message-State: APjAAAX00H0CS6+VpxX7bDYB/0LLS535s2aYUAtHcqduYEywCmFTGpIL
        SiRqmt/6E/BT4QReC/jkZsK4dJsJy9IvRrD6NWcWXw==
X-Google-Smtp-Source: APXvYqyyrnBUsCabs/CQ6Qhae2j7QYXzMx9OL94W1lELvhgv0t9KfhU7xnAJyW+zD5QqB4wH0A0UXDdV+EVyKDdBOx0=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr6740319oth.180.1581449804497;
 Tue, 11 Feb 2020 11:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp> <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp>
In-Reply-To: <20200211190943.sysdbz2zuz5666nq@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 20:36:18 +0100
Message-ID: <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 11, 2020 at 8:09 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> > On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> > [...]
> > > > * When using the semantic provided by fexit, the BPF LSM program will
> > > >   always be executed and will be able to override / clobber the
> > > >   decision of LSMs which appear before it in the ordered list. This
> > > >   semantic is very different from what we currently have (i.e. the BPF
> > > >   LSM hook is only called if all the other LSMs allow the action) and
> > > >   seems to be bypassing the LSM framework.
> > >
> > > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > > trampoline generator specific to lsm progs.
> > [...]
> > > Using fexit mechanism and bpf_sk_storage generalization is
> > > all that is needed. None of it should touch security/*.
> >
> > If I understand your suggestion correctly, that seems like a terrible
> > idea to me from the perspective of inspectability and debuggability.
> > If at runtime, a function can branch off elsewhere to modify its
> > decision, I want to see that in the source code. If someone e.g.
> > changes the parameters or the locking rules around a security hook,
> > how are they supposed to understand the implications if that happens
> > through some magic fexit trampoline that is injected at runtime?
>
> I'm not following the concern. There is error injection facility that is
> heavily used with and without bpf. In this case there is really no difference
> whether trampoline is used with direct call or indirect callback via function
> pointer. Both will jump to bpf prog. The _source code_ of bpf program will
> _always_ be available for humans to examine via "bpftool prog dump" since BTF
> is required. So from inspectability and debuggability point of view lsm+bpf
> stuff is way more visible than any builtin LSM. At any time people will be able
> to see what exactly is running on the system. Assuming folks can read C code.

You said that you want to use fexit without touching security/, which
AFAIU means that the branch from security_*() to the BPF LSM will be
invisible in the *kernel's* source code unless the reader already
knows about the BPF LSM. But maybe I'm just misunderstanding your
idea.

If a random developer is trying to change the locking rules around
security_blah(), and wants to e.g. figure out whether it's okay to
call that thing with a spinlock held, or whether one of the arguments
is actually used, or stuff like that, the obvious way to verify that
is to follow all the direct and indirect calls made from
security_blah(). It's tedious, but it works, unless something is
hooked up to it in a way that is visible in no way in the source code.

I agree that the way in which the call happens behind the scenes
doesn't matter all that much - I don't really care all that much
whether it's an indirect call, a runtime-patched direct call in inline
assembly, or an fexit hook. What I do care about is that someone
reading through any affected function can immediately see that the
branch exists - in other words, ideally, I'd like it to be something
happening in the method body, but if you think that's unacceptable, I
think there should at least be a function attribute that makes it very
clear what's going on.
