Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE8EB64DA
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Jul 2023 20:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjGEUjg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjGEUjg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Jul 2023 16:39:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0304619A0;
        Wed,  5 Jul 2023 13:39:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so73595895e9.3;
        Wed, 05 Jul 2023 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688589573; x=1691181573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/DgRnfk/VasYj340iA+fHXx6nmWGbrTdE9q5k2v4xs=;
        b=fLAVpn0TBVAJLQdXEkLqqLm6jV8e3UpBt2dtRTHk3EUk/6z/51ZyX/7vx6aI822WJf
         yOgr6IoB5BUuNoIYqhmer+I9CgtD3pCgWGY6sSCv85vpkKQ0BMtCsACBwe0K+c1XpUQY
         astLMk2cAYPUeXcelquKBmQhX6jXmoDQs5CjhV0CzW3ub6/RECcb63A/+MNhVoF6VpOV
         S3GpSMYu1OZZM2EQ4YD6WjfHR2iyZZkFmgD45jMj+b4VUs84YKS3vdTImVFrIopOVfj2
         dUeqhbTcSoBOnGabS6lhhHYcyGp1C1GJFEtzGMyNKacUixitDUTZUL8+/Mtmjq6cO4ZU
         382g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589573; x=1691181573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/DgRnfk/VasYj340iA+fHXx6nmWGbrTdE9q5k2v4xs=;
        b=XkKVrmO39qxi7fEYiqCjTx7p1aJX5Ag30G94Zx9Ou1TVUIIKBflRN7dP1/jxIKtPmM
         AjjvdlPCS8FaoCqz4rCOt1wp25G8DJ05V0doTRKwP/JcXNFXxjrCz6QARvuOzwvhZZbS
         uhxmQO+vMUXVyQ74Pl5ZXuxlXIEkbsY67VaRT23h1Lu4HnI++Hag8ueDWm24EXO0RmCW
         JETKhVjDrom3l2308iBs60jJOerbELM0fcHK/2QiZb+uUANteiP4CYLfqV6YJQ1IQDmj
         W0ElcGUxpytpvy3qtQHOX4js6twAAPx3PWbEA1tStA93peIl40I2UFSB1Oko7QUU8m81
         eS0w==
X-Gm-Message-State: AC+VfDxfiCLAxTBfZLHo3TH5wsRX3n3UDTOii5S3s88OVrkXCtGILOPu
        aWgfuz8wyqoy/Bw8l6eWtQT9D8s1hWIHrPd2Tgo=
X-Google-Smtp-Source: ACHHUZ6vUmUtwxnvlSBZoRERruwEFg7aGcBsViutqfmZwzQjpt0OUEvthpZv3DVVzZM58b+kCq6wRUCLMEtw2C0YTRc=
X-Received: by 2002:a7b:cc99:0:b0:3fb:b34f:6cd6 with SMTP id
 p25-20020a7bcc99000000b003fbb34f6cd6mr16026302wma.41.1688589573155; Wed, 05
 Jul 2023 13:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230629051832.897119-1-andrii@kernel.org> <87sfa9eu70.fsf@toke.dk>
 <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
In-Reply-To: <20230704-vielversprechend-zollfrei-a2a148f2699b@brauner>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jul 2023 13:39:21 -0700
Message-ID: <CAEf4BzaPbAW-c8LYhX2kLqZ48e3M1Ae+7kLQPhkN5mtpueMOBw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 bpf-next 00/14] BPF token
To:     Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        lennart@poettering.net, cyphar@cyphar.com, luto@kernel.org,
        kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jul 4, 2023 at 2:52=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jun 30, 2023 at 01:15:47AM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> > Andrii Nakryiko <andrii@kernel.org> writes:
> >
> > > This patch set introduces new BPF object, BPF token, which allows to =
delegate
> > > a subset of BPF functionality from privileged system-wide daemon (e.g=
.,
> > > systemd or any other container manager) to a *trusted* unprivileged
> > > application. Trust is the key here. This functionality is not about a=
llowing
> > > unconditional unprivileged BPF usage. Establishing trust, though, is
> > > completely up to the discretion of respective privileged application =
that
> > > would create a BPF token, as different production setups can and do a=
chieve it
> > > through a combination of different means (signing, LSM, code reviews,=
 etc),
> > > and it's undesirable and infeasible for kernel to enforce any particu=
lar way
> > > of validating trustworthiness of particular process.
> > >
> > > The main motivation for BPF token is a desire to enable containerized
> > > BPF applications to be used together with user namespaces. This is cu=
rrently
> > > impossible, as CAP_BPF, required for BPF subsystem usage, cannot be n=
amespaced
> > > or sandboxed, as a general rule. E.g., tracing BPF programs, thanks t=
o BPF
> > > helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can sa=
fely read
> > > arbitrary memory, and it's impossible to ensure that they only read m=
emory of
> > > processes belonging to any given namespace. This means that it's impo=
ssible to
> > > have namespace-aware CAP_BPF capability, and as such another mechanis=
m to
> > > allow safe usage of BPF functionality is necessary. BPF token and del=
egation
> > > of it to a trusted unprivileged applications is such mechanism. Kerne=
l makes
> > > no assumption about what "trusted" constitutes in any particular case=
, and
> > > it's up to specific privileged applications and their surrounding
> > > infrastructure to decide that. What kernel provides is a set of APIs =
to create
> > > and tune BPF token, and pass it around to privileged BPF commands tha=
t are
> > > creating new BPF objects like BPF programs, BPF maps, etc.
> >
> > So a colleague pointed out today that the Seccomp Notify functionality
> > would be a way to achieve your stated goal of allowing unprivileged
> > containers to (selectively) perform bpf() syscall operations. Christian
> > Brauner has a pretty nice writeup of the functionality here:
> > https://people.kernel.org/brauner/the-seccomp-notifier-new-frontiers-in=
-unprivileged-container-development
>
> I'm amazed you read this. :)
> The seccomp notifier comes with a lot of caveats. I think it would be
> impractical if not infeasible to handle bpf() delegation.

Thanks for confirming my hunch.

And yeah, I read a bunch of blog posts from your blog post. The one
about new mount APIs was especially useful given how little
documentation I could find on them otherwise :)

>
> >
> > In fact he even mentions allowing unprivileged access to bpf() as a
> > possible use case (in the second-to-last paragraph).
>
> Yeah, I tried to work around a userspace regression with the
> introduction of the cgroup v2 devices controller.
