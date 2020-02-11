Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8AC3B187
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3220708
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeozm3+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgBKUeR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:34:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33239 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgBKUeR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 15:34:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so11562555otp.0
        for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2020 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q11zsssSHeKjTpfbV0UQcFcGMIVXHOWVWu3BFYxakp4=;
        b=qeozm3+R7EnJiUqxAO5WKU6Hyo8tOvNoKIv3sqG0gwJnruWChpe1RHY1CoExS/DHwK
         he5Szs4itn3GjZWTFLBu9ib1jeaKQF7I8F/J6ZCd+raCeXX8Ml8qL2LsKQzBrsvmpZWi
         LQGGl/dWBrexM2f/haFE13HCd+3IpMAZkvvGpB5n55Z5/Ag2N3RjnXl8xgLc2+1aFkTR
         UPSbLDiLCbU/Cb4J4f2WFKJTYxS11Fr3qOVTalvoCvAxRpL5kc/w5gTC8sfJ/NDgEgT6
         jeFEpLJm7a3am8dmDSuwym2sTtDNasMRQr77XiJDdvOXMmN3Pf70q/USLL7OUWvG29yX
         4aCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q11zsssSHeKjTpfbV0UQcFcGMIVXHOWVWu3BFYxakp4=;
        b=ty827dGW0IHBp0WOtoCCPBwBIHrMml4S/a2VwG/QP/OG/+x2gTs6mRIBRYQKeT5ptP
         U22zyJvCI1slAuXg87gAJ7IOHrMmStWTw6OCkP7HjPUD5x7iT100PESiAWhWs/PJUbCI
         tRL5V5NUTmyJoDVj04QDDcm1QQr8lUu6B0ZpCf70ioy0XWTJAaSkZjzp2qfhO7xwM/uq
         wlfA7mBHGFIPWZnZvE8thvDjoZalegffgEgl8qcScPnYO3zhMCCJXO7inZJrZhcXLhqE
         FzgQWTN+rv/gpFL6vBPbtZLMJWGarQ6Q0GSGd6bcMkxRaJFvwWVt0TtnX05NREdNpo2C
         uMCg==
X-Gm-Message-State: APjAAAX+6VoddraqT185Chmn96HcYxsxkRf/75CJ2drtG4GdT0c65AhS
        YnJsqwfD6lFNf4xYFOy1bEXiFxfcWTCNRSOwndo1iw==
X-Google-Smtp-Source: APXvYqwN+vAsdRxgGOaSrJORQpfpoOK0DTUx7e2DVI860NZpm9RoWnlwAaQwqmRW/lEAu1tBxxXl1zt3MnY8gyqlm3Y=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr6936015oth.180.1581453255514;
 Tue, 11 Feb 2020 12:34:15 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp> <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp> <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp>
In-Reply-To: <20200211201039.om6xqoscfle7bguz@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 21:33:49 +0100
Message-ID: <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
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

()On Tue, Feb 11, 2020 at 9:10 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 11, 2020 at 08:36:18PM +0100, Jann Horn wrote:
> > On Tue, Feb 11, 2020 at 8:09 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> > > > On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> > > > [...]
> > > > > > * When using the semantic provided by fexit, the BPF LSM program will
> > > > > >   always be executed and will be able to override / clobber the
> > > > > >   decision of LSMs which appear before it in the ordered list. This
> > > > > >   semantic is very different from what we currently have (i.e. the BPF
> > > > > >   LSM hook is only called if all the other LSMs allow the action) and
> > > > > >   seems to be bypassing the LSM framework.
> > > > >
> > > > > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > > > > trampoline generator specific to lsm progs.
> > > > [...]
> > > > > Using fexit mechanism and bpf_sk_storage generalization is
> > > > > all that is needed. None of it should touch security/*.
> > > >
> > > > If I understand your suggestion correctly, that seems like a terrible
> > > > idea to me from the perspective of inspectability and debuggability.
> > > > If at runtime, a function can branch off elsewhere to modify its
> > > > decision, I want to see that in the source code. If someone e.g.
> > > > changes the parameters or the locking rules around a security hook,
> > > > how are they supposed to understand the implications if that happens
> > > > through some magic fexit trampoline that is injected at runtime?
> > >
> > > I'm not following the concern. There is error injection facility that is
> > > heavily used with and without bpf. In this case there is really no difference
> > > whether trampoline is used with direct call or indirect callback via function
> > > pointer. Both will jump to bpf prog. The _source code_ of bpf program will
> > > _always_ be available for humans to examine via "bpftool prog dump" since BTF
> > > is required. So from inspectability and debuggability point of view lsm+bpf
> > > stuff is way more visible than any builtin LSM. At any time people will be able
> > > to see what exactly is running on the system. Assuming folks can read C code.
> >
> > You said that you want to use fexit without touching security/, which
> > AFAIU means that the branch from security_*() to the BPF LSM will be
> > invisible in the *kernel's* source code unless the reader already
> > knows about the BPF LSM. But maybe I'm just misunderstanding your
> > idea.
> >
> > If a random developer is trying to change the locking rules around
> > security_blah(), and wants to e.g. figure out whether it's okay to
> > call that thing with a spinlock held, or whether one of the arguments
> > is actually used, or stuff like that, the obvious way to verify that
> > is to follow all the direct and indirect calls made from
> > security_blah(). It's tedious, but it works, unless something is
> > hooked up to it in a way that is visible in no way in the source code.
> >
> > I agree that the way in which the call happens behind the scenes
> > doesn't matter all that much - I don't really care all that much
> > whether it's an indirect call, a runtime-patched direct call in inline
> > assembly, or an fexit hook. What I do care about is that someone
> > reading through any affected function can immediately see that the
> > branch exists - in other words, ideally, I'd like it to be something
> > happening in the method body, but if you think that's unacceptable, I
> > think there should at least be a function attribute that makes it very
> > clear what's going on.
>
> Got it. Then let's whitelist them ?
> All error injection points are marked with ALLOW_ERROR_INJECTION().
> We can do something similar here, but let's do it via BTF and avoid
> abusing yet another elf section for this mark.
> I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
> name and extensive comment about what is going on.

Sounds reasonable to me. :)

> Locking rules and cleanup around security_blah() shouldn't change though.
> Like security_task_alloc() should be paired with security_task_free().
> And so on. With bpf_sk_storage like logic the alloc/free of scratch
> space will be similar to the way socket and bpf progs deal with it.
>
> Some of the lsm hooks are in critical path. Like security_socket_sendmsg().
> retpoline hurts. If we go with indirect calls right now it will be harder to
> optimize later. It took us long time to come up with bpf trampoline and build
> bpf dispatcher on top of it to remove single indirect call from XDP runtime.
> For bpf+lsm would be good to avoid it from the start.

Just out of curiosity: Are fexit hooks really much cheaper than indirect calls?

AFAIK ftrace on x86-64 replaces the return pointer for fexit
instrumentation (see prepare_ftrace_return()). So when the function
returns, there is one return misprediction for branching into
return_to_handler(), and then the processor's internal return stack
will probably be misaligned so that after ftrace_return_to_handler()
is done running, all the following returns will also be mispredicted.

So I would've thought that fexit hooks would have at least roughly the
same impact as indirect calls - indirect calls via retpoline do one
mispredicted branch, fexit hooks do at least two AFAICS. But I guess
indirect calls could still be slower if fexit benefits from having all
the mispredicted pointers stored on the cache-hot stack while the
indirect branch target is too infrequently accessed to be in L1D, or
something like that?
