Return-Path: <SRS0=caJR=AC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB39C433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Jun 2020 21:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B93252B6
	for <linux-security-module@archiver.kernel.org>; Sun, 21 Jun 2020 21:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UmqmDfcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFUVyv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 21 Jun 2020 17:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVyt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 21 Jun 2020 17:54:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A22C061796
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2020 14:54:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g21so9486170wmg.0
        for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2020 14:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClfrnpZFSOZxRBbJuLVUEpU0s3ZL/yim5HOOV5Ogv1E=;
        b=UmqmDfcGFPh0Va7QuZnr3DCpZHHCoGEUeNMvxE49O43zZI4ukzRSqoeZrNg1fNozX5
         KdlJ8y9VbJysFjkWTnhLtGwdSVlO36dC1xFYD6+RdImYoj+1Qxt0KAq93hxwXLzWrWCJ
         L1WmyTunnn1F2IwLdNdDFJ1EuD1aioWwa3N84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClfrnpZFSOZxRBbJuLVUEpU0s3ZL/yim5HOOV5Ogv1E=;
        b=oyzU9rn6LIpIE0HSqRPZGZhZSkCPe6qLn6DSg9VM1Ycn09iT4BosWfpYp5C90IQw2z
         eQ2b1d/Zb/b6DktrXUMx2qMtlww/7tM5FTc5nQIMFtD7obu/MbMB17ibd10ZS/BtzGdo
         m+XpbnoV5J2PoxP79wL/LeNUup9BK+yl3outnqxjO1GONgDS4BsRc+a3iYUo6VuRLkcQ
         noAQ+Mr6k2R6SJX/62dr5+sLctFIARs9qb/SpFvPtR1Pat8F9rTxf+vBqI15L8Ul9HBz
         XLArdjmDwVerOqyrnUUK9csdHoS7/fV+th8he+KCxhLkBQ/Kx9065xqwoagffhOdjbG6
         ualQ==
X-Gm-Message-State: AOAM532n5K0Pg46tGfZ3XLTb+HpYt3tNNZmAdyamfzP3xsyN/ynF7dkS
        g/X2HEN/hJT74Y9a1XlcdH85MkpU7Y2AeBQNGYI8WQ==
X-Google-Smtp-Source: ABdhPJx9PQCSL0hsDiPG5OLhGhAFSoLfDmdFvNeu2eJ81EqiNlwPW/s0PIQ4FYdlYi0pOf+1JNyIXSNgD/EzZgE36TA=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr15443921wmj.56.1592776486432;
 Sun, 21 Jun 2020 14:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200520125616.193765-1-kpsingh@chromium.org> <CAFqZXNsu8Vs86SKpdnej_=xnQqg=Hh132JqNe1Ybt-bHJB4NeQ@mail.gmail.com>
 <CACYkzJ5e_JOLS-gmNug6e4RJkSsv7sjMUfMWyfMCsQLSoxS8RQ@mail.gmail.com> <CAFqZXNuqNP4OMQGNunyUyyKBc_0-e_P+ogha08V6UsTNCATfLA@mail.gmail.com>
In-Reply-To: <CAFqZXNuqNP4OMQGNunyUyyKBc_0-e_P+ogha08V6UsTNCATfLA@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sun, 21 Jun 2020 23:54:35 +0200
Message-ID: <CACYkzJ4RidV2p7OxyVoMLnFM=CLuX1MNVyOk82XEHr1QhQFYvA@mail.gmail.com>
Subject: Re: [PATCH bpf] security: Fix hook iteration for secid_to_secctx
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 19, 2020 at 4:17 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 3:13 PM KP Singh <kpsingh@chromium.org> wrote:
> > Hi,
> >
> > On Fri, Jun 19, 2020 at 2:49 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Wed, May 20, 2020 at 2:56 PM KP Singh <kpsingh@chromium.org> wrote:
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > secid_to_secctx is not stackable, and since the BPF LSM registers this
> > > > hook by default, the call_int_hook logic is not suitable which
> > > > "bails-on-fail" and casues issues when other LSMs register this hook and
> > > > eventually breaks Audit.
> > > >
> > > > In order to fix this, directly iterate over the security hooks instead
> > > > of using call_int_hook as suggested in:
> > > >
> > > > https: //lore.kernel.org/bpf/9d0eb6c6-803a-ff3a-5603-9ad6d9edfc00@schaufler-ca.com/#t
> > > >
> > > > Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
> > > > Fixes: 625236ba3832 ("security: Fix the default value of secid_to_secctx hook"
> > > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > [...]
> > >
> > > Sorry for being late to the party, but doesn't this (and the
> > > associated default return value patch) just paper over a bigger
> > > problem? What if I have only the BPF LSM enabled and I attach a BPF
> > > program to this hook that just returns 0? Doesn't that allow anything
> > > privileged enough to do this to force the kernel to try and send
> > > memory from uninitialized pointers to userspace and/or copy such
> > > memory around and/or free uninitialized pointers?
> > >
> > > Why on earth does the BPF LSM directly expose *all* of the hooks, even
> > > those that are not being used for any security decisions (and are
> > > "useful" in this context only for borking the kernel...)? Feel free to
> > > prove me wrong, but this lazy approach of "let's just take all the
> > > hooks as they are and stick BPF programs to them" doesn't seem like a
> >
> > The plan was definitely to not hook everywhere but only call the hooks
> > that do have a BPF program registered. This was one of the versions
> > we proposed in the initial patches where the call to the BPF LSM was
> > guarded by a static key with it being enabled only when there's a
> > BPF program attached to the hook.
> >
> > https://lore.kernel.org/bpf/20200220175250.10795-5-kpsingh@chromium.org/
> >
> > However, this special-cased BPF in the LSM framework, and, was met
> > with opposition. Our plan is to still achieve this, but we want to do this
> > with DEFINE_STATIC_CALL patches:
> >
> > https://lore.kernel.org/lkml/cover.1547073843.git.jpoimboe@redhat.com
> >
> > Using these, only can we enable the call into the hook based on whether
> > a program is attached, we can also eliminate the indirect call overhead which
> > currently affects the "slow" way which was decided in the discussion:
> >
> > https://lore.kernel.org/bpf/202002241136.C4F9F7DFF@keescook/
>
> Perhaps you are misunderstanding me... I don't have a problem with BPF
> LSM registering callbacks for all the hooks. My point is about what
> you can trigger once you attach programs to certain hooks. All the
> above seem to be just optimizations/implementation details that do not
> affect the problem I'm pointing to.
>

The immediate concern was to fix the issue caused by the default
callback (bpf_lsm_secid_to_secctx) which affected even the users
who were not deliberately attaching a BPF program to the hook.

We can probably restrict attachment of BPF programs to be fexit trampolines
instead of fmod_ret by using some of the work that is being done for
BTF ID whitelists for the d_path helper. (fexit trampolines cannot
change the return
value of the default callback).

https://lore.kernel.org/bpf/20200616100512.2168860-9-jolsa@kernel.org/

With some of the optimization work which should remove this
default callback, we can also prevent the non-deliberate errors (the ones
that occur even when a BPF program is not attached to the LSM hook).
IMHO, these are more important to fix.

- KP

> >
> > > good choice... IMHO you should either limit the set of hooks that can
> > > be attached to only those that aren't used to return back values via
> >
> > I am not sure if limiting the hooks is required here once we have
> > the ability to call into BPF only when a program is attached. If the
> > the user provides a BPF program, deliberately returns 0 (or any
> > other value) then it is working as intended. Even if we limit this in the
> > bpf LSM, deliberate privileged users can still achieve this with
> > other means.
>
> The point is that for this particular hook (secid_to_secctx) and a
> couple others, the consequences of having control over the return
> value are more serious than with other hooks. For most hooks, the
> implementation usually just returns 0 (OK), -EACCESS (access denied)
> or -E... (error) and the caller either continues as normal or handles
> the error. But here if you return 0, you signal that you have
> initialized the pointer and size to valid values. So suddenly the BPF
> prog doesn't just control allow/deny decisions, but can now easily
> trigger kernel panic. And when you look at the semantics of the hook,
> you will realize that it doesn't really make sense to implement it via
> BPF, since it can never populate the output values and the only
> meaningful implementation would be to just return -EOPNOTSUPP.
>
> Maybe I have it all wrong, but isn't the whole point of BPF programs
> to provide a tight sandbox where you can only implement pure input ->
> output functions + read/modify some internal state? Is it really
> "working as intended" if you can crash the kernel by attaching a
> simple BPF program to a certain hook? I mean yes, you can make the
> system pretty much unusable already using the classic hooks by simply
> returning -EACCESS for everything, but IMO that's quite different from
> causing the kernel to do an invalid memory access.
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
