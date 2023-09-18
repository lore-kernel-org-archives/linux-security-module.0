Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10888CD13D2
	for <linux-security-module@archiver.kernel.org>; Mon, 18 Sep 2023 17:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjIRRHi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjIRRHh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E348E
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 10:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4FC433A9
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 13:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695043668;
        bh=NpDQaIq8slcpBBgt5F7J36tVVCzb5GbvEyBtCzOBLa8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UoxmHwOgqyogWMleGl7hlYN60HkduLBu56UN6a+4DTfHcLmBgI+h1pf5qWAePe/Uk
         IbqBJP8SKRqIWxZyTr+dA2QAoihC53I3syrPshrD/i/O5neW3R+fPbjb3iGdp37RLZ
         PUdOuzTbvs0TwPzO9bOg8mIwcy0VrhLPrhJDaxSCW9pnAU6NYFC+tSP6v32rkmfRBx
         zGjl8ZbkzUCq8QUI8X2aE309WAaqmFZba1mAvrVYeU9nX6XOnDOChV6HaXRN8E9GjK
         ODvI9HpRdEj0ikMDnSA2QtIT/66Ed0qf87vgraicOICuSilQc/0/T4wfou04qrvFUu
         WrlEUzbRWL6fA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-530c9980556so2337273a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 18 Sep 2023 06:27:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxUgubWXTgXjYMcU+IKq8OANovLMPH54gjq2LhArtLBc7c99eoF
        sZGZ7yNn46TRbz3JKm4FmVMBXiFcjmb+ZFhFQ1b7UQ==
X-Google-Smtp-Source: AGHT+IHVacgZlb19m5SNsEYtq+vvIEOgYDfqOIvL1EGeUP6of8LJwyHm479IBQOjE2k7UHwxocOqT8Qvp9EQwMirE8w=
X-Received: by 2002:aa7:d58b:0:b0:530:4f4b:9d1a with SMTP id
 r11-20020aa7d58b000000b005304f4b9d1amr7872098edq.5.1695043666738; Mon, 18 Sep
 2023 06:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230616000441.3677441-1-kpsingh@kernel.org> <20230616000441.3677441-6-kpsingh@kernel.org>
 <202306201356.CF454506@keescook>
In-Reply-To: <202306201356.CF454506@keescook>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 18 Sep 2023 15:27:36 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Nv+_L_scpZL3L32AZtradq6yTeN9adz0ayihe3PpHsw@mail.gmail.com>
Message-ID: <CACYkzJ7Nv+_L_scpZL3L32AZtradq6yTeN9adz0ayihe3PpHsw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, jannh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 20, 2023 at 10:59=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, Jun 16, 2023 at 02:04:41AM +0200, KP Singh wrote:
> > [...]
> > @@ -110,6 +110,9 @@ static __initdata struct lsm_info *exclusive;
> >  #undef LSM_HOOK
> >  #undef DEFINE_LSM_STATIC_CALL
> >
> > +#define security_hook_active(n, h) \
> > +     static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY, &SECURITY_HOOK_A=
CTIVE_KEY(h, n))
> > +
> >  /*
> >   * Initialise a table of static calls for each LSM hook.
> >   * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CA=
LL_KEY)
> > @@ -816,7 +819,7 @@ static int lsm_superblock_alloc(struct super_block =
*sb)
> >   */
> >  #define __CALL_STATIC_VOID(NUM, HOOK, ...)                            =
    \
> >  do {                                                                  =
    \
> > -     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {    \
> > +     if (security_hook_active(NUM, HOOK)) {                           =
    \
> >               static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__);    =
    \
> >       }                                                                =
    \
> >  } while (0);
> > @@ -828,7 +831,7 @@ do {                                               =
                            \
> >
> >  #define __CALL_STATIC_INT(NUM, R, HOOK, LABEL, ...)                   =
    \
> >  do {                                                                  =
    \
> > -     if (static_branch_unlikely(&SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)))=
 {  \
> > +     if (security_hook_active(NUM, HOOK)) {    \
> >               R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
> >               if (R !=3D 0)                                            =
      \
> >                       goto LABEL;                                      =
    \
>
> I actually think I'd prefer there be no macro wrapping
> static_branch_maybe(), just for reading it more easily. i.e. people
> reading this code are going to expect the static_branch/static_call code
> patterns, and seeing "security_hook_active" only slows them down in
> understanding it. I don't think it's _that_ ugly to have it all typed
> out. e.g.:

Done and agreed, especially given that this is behind a macro anyways.


>
>         if (static_branch_maybe(CONFIG_SECURITY_HOOK_LIKELY,             =
    \
>                                 &SECURITY_HOOK_ACTIVE_KEY(HOOK, NUM)) {  =
    \
>                 R =3D static_call(LSM_STATIC_CALL(HOOK, NUM))(__VA_ARGS__=
);    \
>                 if (R !=3D 0)                                            =
      \
>                         goto LABEL;                                      =
    \
>
>
>
> --
> Kees Cook
