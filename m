Return-Path: <SRS0=MM4E=37=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D6C3B187
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F5620708
	for <linux-security-module@archiver.kernel.org>; Tue, 11 Feb 2020 21:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPb+i27r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBKVdE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 11 Feb 2020 16:33:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41071 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBKVdE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 11 Feb 2020 16:33:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so11691547otc.8
        for <linux-security-module@vger.kernel.org>; Tue, 11 Feb 2020 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7t90g4c6XNbG2IVEsLyCTMS996Wdaa8ZX4sfkSxqPY=;
        b=sPb+i27ruMFTvdaOm/MyeY4Oz9L1b8r1xJSqYOfN+o5NMuR8tLmfXcwUTIumlqIiYW
         2N8lzmIaxjR+23jnTm7qAer4rFagk617Vw5fp6rbbZAoseCihITs9GNCZ4bnVda2WJnk
         oiLpm3H8xB22+xnzg0KozaxmzWdWjbLz64ru6WrEx0MMiBBMRsPvHBFlRVuQAdlBaR5O
         YUpX/nkFwO39yJTtfwvmkOhu73zPYObk0PdEjCMmWCpJ2YWhjbHOa+ZOUJCgxialqOvU
         x3LpOiDBJtwItD0ieD23vk+I1qQp1gvNs12BQTOn4RGIJYOyWze2v5PeqFwz0IpDf+dV
         UZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7t90g4c6XNbG2IVEsLyCTMS996Wdaa8ZX4sfkSxqPY=;
        b=modYydoDKtw/zpQllJ/aqe3pe42UpiNDzM1RzWDlbmBwKV8zpbWmhHerMu4dBOTFcq
         JrBqddCZbJAbqnkTnmM24U+qb1QAdnKNVWij0VF3lm5a9+6OTuD1oYsjQ5ZTleXoXt20
         g1ngQ3ZjmuOq5jYoS0IEMUJvPuU86oU70JgWnpcjHfaQtBS4Xhq8DjAK1zpi1vo6CJzw
         iyDMIlWJfHhVHXNM2Gi6g2B3s/aEnw1rxLz3ULYYfl5w/cC9rWAsTmbAYQ8Pi0x0McSS
         CAiqJelnxUgY9dktoBWIM24BthgQVKNN0hIrOFMvNSYC6zbjho7ohKpZtdmUKpcipA7J
         wPFQ==
X-Gm-Message-State: APjAAAWNFxlEGtvBHdmRFkqYLN5dmew3mTUl9yIlqICMIaHa8JDsebGy
        f/p8+l3c70PG036s0uhi7xkgZ1z4GxesqTv7BfX/gg==
X-Google-Smtp-Source: APXvYqyx2YfO3CrgVT8Ue7KGbrpANlKv/7s2kPE1d6utD3uoHxPksjBi0y8VM3cugmkfUj0o0k+v0rF5MEB6CHlQjRg=
X-Received: by 2002:a05:6830:22cc:: with SMTP id q12mr7016668otc.110.1581456783363;
 Tue, 11 Feb 2020 13:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp> <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp> <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp> <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
In-Reply-To: <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 22:32:37 +0100
Message-ID: <CAG48ez0gxY5bzTpk+6DjkXqTPDM+06yy8spKdqoF7Edt9Nx_JQ@mail.gmail.com>
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

On Tue, Feb 11, 2020 at 9:33 PM Jann Horn <jannh@google.com> wrote:
> On Tue, Feb 11, 2020 at 9:10 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Tue, Feb 11, 2020 at 08:36:18PM +0100, Jann Horn wrote:
> > > On Tue, Feb 11, 2020 at 8:09 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Tue, Feb 11, 2020 at 07:44:05PM +0100, Jann Horn wrote:
> > > > > On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
> > > > > [...]
> > > > > > > * When using the semantic provided by fexit, the BPF LSM program will
> > > > > > >   always be executed and will be able to override / clobber the
> > > > > > >   decision of LSMs which appear before it in the ordered list. This
> > > > > > >   semantic is very different from what we currently have (i.e. the BPF
> > > > > > >   LSM hook is only called if all the other LSMs allow the action) and
> > > > > > >   seems to be bypassing the LSM framework.
> > > > > >
> > > > > > It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> > > > > > trampoline generator specific to lsm progs.
> > > > > [...]
> > > > > > Using fexit mechanism and bpf_sk_storage generalization is
> > > > > > all that is needed. None of it should touch security/*.
[...]
> > Some of the lsm hooks are in critical path. Like security_socket_sendmsg().
> > retpoline hurts. If we go with indirect calls right now it will be harder to
> > optimize later. It took us long time to come up with bpf trampoline and build
> > bpf dispatcher on top of it to remove single indirect call from XDP runtime.
> > For bpf+lsm would be good to avoid it from the start.
>
> Just out of curiosity: Are fexit hooks really much cheaper than indirect calls?
>
> AFAIK ftrace on x86-64 replaces the return pointer for fexit
> instrumentation (see prepare_ftrace_return()). So when the function
> returns, there is one return misprediction for branching into
> return_to_handler(), and then the processor's internal return stack
> will probably be misaligned so that after ftrace_return_to_handler()
> is done running, all the following returns will also be mispredicted.
>
> So I would've thought that fexit hooks would have at least roughly the
> same impact as indirect calls - indirect calls via retpoline do one
> mispredicted branch, fexit hooks do at least two AFAICS. But I guess
> indirect calls could still be slower if fexit benefits from having all
> the mispredicted pointers stored on the cache-hot stack while the
> indirect branch target is too infrequently accessed to be in L1D, or
> something like that?

Ah, kpsingh explained to me that BPF trampolines work differently from
normal ftrace and don't do the return address poking. Still, the
processor's internal call stack will be misaligned by the BPF
trampoline, right? Since there is one more call than return, if e.g.
security_blah() is hooked, then the kernel will probably predict
security_blah+5 as the target when returning from the trampoline to
security_blah's parent, then when returning from security_blah's
parent to the grandparent predict the parent, and so on, right?
