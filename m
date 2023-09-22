Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC40E6FE42
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 14:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjIVO5r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjIVO5q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 10:57:46 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A033100
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 07:57:38 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d81f35511e6so3647304276.0
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695394657; x=1695999457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UGat+gX/Q5QYftTlk13jBPZCD07aGnpuSHgzrG0u4U=;
        b=Ryc9L70dE6X3O6jLGhxAO9yMPiRgvIgExlJPbPAH2jR8OtsSHwRLvXtXC/9dH2mMk0
         U/sGKxsmn7HPz6dXAP0yBruFQmRScESzOByg2f9a0jFOgUQHrA9St6Cb73UieKyTLml4
         QdG/TqljCvOgBriiK9fxUekyHRfuVE3XaJAy767HC+6aa+BpVVAOEk3NOZXx8ouhGFBG
         TxfcHn1ibqgWed+cyqqBw+UeO7fYSXIKOw2zpeAuV2ZTSUtT2y4rculPOVraKjavnqBO
         i4MlcGNgcrCxcrKC9M0JgynVjfWx7EOhefJZe8DvykWA/onbpeeqOhJUlbvbXMnW1FVG
         Obvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695394657; x=1695999457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UGat+gX/Q5QYftTlk13jBPZCD07aGnpuSHgzrG0u4U=;
        b=KCVyZS/FSDnoML+EEajjVrY4a1L76s57yx6QGV6gsL+yS/QFq53Afy1f82QJS5tLY4
         PXLe2w9hb6/g1gkDphKEOUaBhEMV3cS2eW8nv0BGFClTMYW1lHKqXZ5crGge6liybiKj
         dH9j/PZqrHjaf+9/2rTtubn4/sXD/ZfW2sRxO45NZYFuCLjWk4+8g0fn3clfZBF7O6ZJ
         +VcKy5CADY1ZXxtzWKwqGmPu5fN0wS6sa75IjK0M8LtnKdnKHhqTXsF85V75ZVN9ZOzV
         6BpHqp5jHWQxgatHYJ8YqWxSnefT/9rB41gqRWJTetI3VHu+xbmkGD5Zsmt8JKp8XLCu
         PfAA==
X-Gm-Message-State: AOJu0Yx+F/vETR068o0XoOHikh+e1oTJtzwJiNOlyfttX8t2tLGU/Ne8
        /RSAPzWse470R3HHWVNO3NQBUJitumjmb71KUqZt
X-Google-Smtp-Source: AGHT+IEQDkERaTmElRptmPZBItx4iey/h0R82GJGP+6gl1Z/RBoKKFdNxy3AHXCPCXT0u3SW7JfVDVxDbDQkAw1jleY=
X-Received: by 2002:a25:b1a2:0:b0:d81:89d4:ffd9 with SMTP id
 h34-20020a25b1a2000000b00d8189d4ffd9mr1811994ybj.31.1695394657625; Fri, 22
 Sep 2023 07:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
 <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com> <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
In-Reply-To: <dde20522-af01-c198-5872-b19ef378f286@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Sep 2023 10:57:26 -0400
Message-ID: <CAHC9VhTv3f3+ZOviV7YcjbA=cdKOmSC0hj80y2sJgACo+nyK9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 7:25=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/09/21 22:58, KP Singh wrote:
> > Yeah, LSMs are not meant to be used from a kernel module. The data
> > structure is actually __ro_after_init. So, I am not even sure how you
> > are using it in kernel modules (unless you are patching this out).
> > And, if you are really patching stuff to get your out of tree LSMs to
> > work, then you might as well add your "custom" LSM config here or just
> > override this count.
>
> I'm using LKM-based LSM with any version between 2.6.0 and 6.6-rc2, witho=
ut patching
> __ro_after_init out. We can load LKM-based LSMs, without patching the ori=
ginal kernel.
> And it seems to me that several proprietary security products for Linux a=
re using
> this trick, for LSMs for such products cannot be built into distributor's=
 kernels...

...

> > The performance benefits here outweigh the need for a completely
> > unsupported use case.
>
> LKM-based LSMs are not officially supported since 2.6.24. But people need=
 LKM-based LSMs.
> It is very sad that the LSM community is trying to lock out out of tree L=
SMs
> ( https://lkml.kernel.org/r/ec37cd2f-24ee-3273-c253-58d480569117@I-love.S=
AKURA.ne.jp ).
> The LSM interface is a common property for *all* Linux users.
>
> I'm not objecting the performance benefits by replacing with static calls=
.
> I'm not happy that the LSM community ignores the Torvald's comment at htt=
ps://lkml.org/lkml/2007/10/1/192
> and does not listen to minority's voices.

Despite a previous comment that I was done engaging with Tetsuo on
this topic, I feel it is worth commenting here as there are a number
of people on the To/CC line that have likely not been following the
related discussion threads on the LSM list.

First and foremost I want to reiterate that the LSM community's first
priority are those LSMs which have been accepted and merged into the
upstream Linux kernel.  While I have no intention, or desire, to harm
out-of-tree LSMs, I stand firm that we should not compromise designs
for in-tree LSMs/functionality solely to benefit out-of-tree LSMs.  I
believe this is consistent, or at least compatible, with the general
Linux kernel community's stance on in-tree vs out-of-tree code.

The (relatively) newly proposed LSM syscalls have proven to be a
contentious topic between Tetsuo and the LSM community as a whole; I
won't rehash the arguments here, as they are all available on
lore.kernel.org (simply look for any threads that Tetsuo has been
involved in over the past several months) but we have discussed this
issue at great length and Tetsuo remains the only opposing opinion.
It was my hope that Tetsuo would respect the opinion of the upstream
LSM community, even if he didn't agree with the details.  After all,
this is how we move forward in cases where differing opinions cannot
all be accommodated in the code.

Unfortunately Tetsuo's continued and stubborn refusal to accept the
majority opinion has started to spill into other discussion threads,
disrupting the discussion there and twisting some of the core issues
to better fit his arguments.  Not only is this frustrating, it is
becoming rather disruptive.  My suggestion is to simply follow some
classic Internet advice and "don't feed the trolls".

As we discussed off-list (and in-person!) this week, I am generally
supportive of work that improves performance, but correctness will
always be my priority with maintainability a close second.  We have a
few more pressing issues at the LSM layer which are demanding my time
at the moment, but I do promise to come back to this issue/patchset as
these other high priority issues are resolved.

Thanks for your patience and understanding KP :)

--=20
paul-moore.com
