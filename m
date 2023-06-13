Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58E5EB64D7
	for <linux-security-module@archiver.kernel.org>; Tue, 13 Jun 2023 21:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFMVsm (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 13 Jun 2023 17:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMVsl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Jun 2023 17:48:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212D1BCD
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 14:48:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98220bb31c6so3943966b.3
        for <linux-security-module@vger.kernel.org>; Tue, 13 Jun 2023 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686692919; x=1689284919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADa1SrlhiNMb6mM/PE1kFqixN0opneYlqe0aSrO769s=;
        b=o4Degcdc/aL9DMZAmBGzPHDQasFBke6nQDodix6WkxHDhBzU7EG/cZtLsZbjmzvbEk
         1EcU4/iMybfDlGUBdbyYWtTgss5YM4BwLWHZKGAq5nvA9fGzA+ZCrhsB0Pi2C8d5KqbS
         XVJBzGe+9py/K4L0/P8l1JgWzqXSk1p8UnumTP4wSipjx2snK6iEdYSFnscpCtPUIUlg
         /EzisiIOM4DVRE+dhxCtFKaItFTjnobXcshVCfTkPUE+qJY8vcm+EXznHByDtYC3FtyU
         31IlD7rzRTHpFEmzFVLNVCEegSnCtgFhEeC/DQY1CP0ZGqSJvPchamIzMo99FEEMKBae
         rznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692919; x=1689284919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADa1SrlhiNMb6mM/PE1kFqixN0opneYlqe0aSrO769s=;
        b=PU0/mN1sgJFcqo6jQQkQ1j7TfSfipiag08AUxhLpKzSGqFe28cLssrz8cVIT7lRWjk
         Sw7d5xO9e/1vs4IPOhMub7T0S6+GrwrZvI1XALfY8w+PMWl/M7R19zOBnTNk+JElWgwS
         mFXEZKTsm3jDjgdRnmClZBgV9dPFFadeEFchotzZnTsNEAjg9cQTLR/7EC9m1zHNcgyq
         JN6ztf2hYKi8apzg7YWSTlXZn8AHiTB9NIzHfEKcTWMoo3Zb/ewHlGkizjg3vLoZQQl5
         lYKb5MzrU2FskHppPckZMkfvegzwv9xdHj1O6+wWyjYlEDvwfH43qC/S3il6Eh9pnC8y
         Yljg==
X-Gm-Message-State: AC+VfDw/3AuMod12QAbV1ggmuFvTpEhIaLPO4K19OUu0aeS3CCEti6kR
        cGbNIvfY2MaSEvKnZLDw8SU9uk5jkiZ3DD8TzC6vdQ==
X-Google-Smtp-Source: ACHHUZ5nvDS7tFFD1Y+h6ks477R1i9ZZezfuYGnptfBOg5Dmsqh6HxA9eqBQev4y1f61OefF7jggxmLk/pcClQq4kLk=
X-Received: by 2002:a17:907:9724:b0:979:7624:1f70 with SMTP id
 jg36-20020a170907972400b0097976241f70mr16868450ejc.18.1686692918707; Tue, 13
 Jun 2023 14:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org> <871qik28bs.fsf@toke.dk>
 <CAEf4BzYin==+WF27QBXoj23tHcr5BeezbPj2u9RW6qz4sLJsKw@mail.gmail.com>
 <87h6rgz60u.fsf@toke.dk> <CAEf4Bzasz_1qRXh4b7B8V1mOfyD++mVNYnhm6v__-cc7cU_33w@mail.gmail.com>
 <87bkhlymyk.fsf@toke.dk> <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
In-Reply-To: <CAEf4BzZRKgMjOQhxdC_fvn1SPwPh-GXhy_1TJVB6eVpZ8k04vw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 13 Jun 2023 14:48:27 -0700
Message-ID: <CA+khW7h95RpurRL8qmKdSJQEXNYuqSWnP16o-uRZ9G0KqCfM4Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 12, 2023 at 3:08=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jun 12, 2023 at 3:49=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@kernel.org> wrote:
> >
<...>
> > to avoid that is by baking the support into libbpf, then that can be
> > done regardless of the mechanism we choose.
> >
> > Or to put it another way: as you say it may be more *complicated* to ad=
d
> > an RPC-based path to libbpf, but it's not fundamentally impossible, it'=
s
> > just another technical problem to be solved. And if that added
> > complexity buys us better security properties, maybe that is a good
> > trade-off. At least we shouldn't dismiss it out of hand.
>
> You are oversimplifying this. There is a huge difference between
> syscall and RPC and interfaces.
>
> The former (syscall approach) will error out only on invalid inputs
> (and highly improbable if kernel runs out of memory, which means your
> app is dead anyways). You don't code against syscall interface with
> expectation that it can fail at any point and you should be able to
> recover it.
>
> With RPC you have to bake in into your application that any RPC can
> fail transiently, for many reasons. Service could be down, restarted,
> slow, etc, etc. This changes *everything* in how you develop
> application, how you write code, how you handle errors, how you
> monitor stuff. Everything.
>
> It's impossible to just swap out syscall with RPC transparently
> without introducing horrible consequences. This is not some technical
> difficulty, it's a fundamental impedance mismatch. One of the early
> distributed systems mistakes was to pretend that remote procedure
> calls could be reliable and assume errors are rare and could be
> pretended to behave like syscalls or local in-process APIs. It has
> been recognized many times over how bad such approaches were. It's
> outside of the scope of this discussion to go into more details.
> Suffice it to say that libbpf is not going to pretend that syscall and
> some RPC are equivalent and can be interchangeable in a transparent
> way.
>
> And then, even if we were crazy enough to do the above, there is no
> way everyone will settle on one single implementation and/or RPC
> protocol and API such that libbpf could implement it in its upstream
> version. Big companies most probably will go with their own internal
> ones that would give them better integration with internal
> infrastructure, better overvability, etc. And even in open-source
> there probably won't be one single implementation everyone will be
> happy with.
>

Hello Toke and Andrii,

I agree with Andrii here. In Google, we have several years of
experience building and using BPF RPC service. We delegate BPF
operations to this service. From our experience, the RPC approach is
quite limiting and becomes impractical for many BPF use cases.

For programs that do not require much user interaction, it works just
fine. It just loads and attaches the programs, that's all. The problem
is the programs that require much user interaction, for example, the
ones doing observability, which may often read maps or poll on bpf
ringbuf. Overhead and reliability of RPC is one concern. Another
problem is the BPF operations based on mmap, for example, directly
updating/reading BPF global variables as used in skeleton. We still
haven't figured out how to fully support bpf skeleton. We also haven't
figured out how to support BPF ringbuf using RPC. There are also
problems maintaining this service to catch up with some new features
in libbpf.

Anyway, I think the syscall interface has been heavily baked in libbpf
and bpf kernel interfaces today. There are many BPF use cases where
delegating all BPF operations to a service can't work well. IMHO, to
achieve a good balance between flexibility and security, some
abstraction that conveys controlled trust from priv to unpriv is
necessary. The idea of BPF token makes sense to me. With token, libbpf
interface requires only minimal change, unpriv user can call libbpf
and bpf syscall natively, wins on efficiency and less maintenance
burden for libbpf developers.

Thanks,
Hao
