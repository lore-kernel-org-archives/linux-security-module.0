Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6DDE7D0AA
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 21:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjIUVEW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjIUVDo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518886101
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC6CC4E751
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 13:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695304723;
        bh=7lOBF2i9r1Kh4FFNtvjiKc/p3ePyxm2pDN79LEF5/zc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I5GMABu4tYbB0aNdhNIq3u/vuBZb62pcL1rMZtjQU/ua/yLH3fxS0p6md/dui+iCS
         LKDO46R1VdrxySMmNA74xPkNTsThcqGHbtyYB33dsmKpVHMm5KEu5PZPH8WhLA34au
         d92FSFi3PlkJx0Zityl8dqTPlHFs6Y5L8DCVRwz55piHW6Pw/PYALkRyjH4fM/C2hz
         istgffe151h5AUtcWqBpy+gSMKepPuQvFvwit37vXHMrdcvOj/kl3NL5bSh+IR1/Bj
         abd0ofH607JPVLhPbqa37HyMNuUKC9JiebbFNMr8ErBAxawlPIiJv19OAgQFD2cL+p
         t97bSCI9oyl+g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-502a4f33440so1830993e87.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 06:58:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YyOPd0YWvnv92fNlTVQEZV3GLJSYg55W53RklKHNEsq9LAfL/Yi
        jCWlpIW6L2ikJoA2ZOlBFXokfBfvbo65SwqwBpXYLw==
X-Google-Smtp-Source: AGHT+IFIleiCv6I+nbPJbmS2qxQ2ZfzdaEDAfY65T2iOiN6BU5Ip+37ZMoBsYORL4lPVXjNOP4TEWag98AjRkc3HCOk=
X-Received: by 2002:a05:6512:104f:b0:503:2924:f8dd with SMTP id
 c15-20020a056512104f00b005032924f8ddmr6556728lfb.47.1695304721464; Thu, 21
 Sep 2023 06:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230918212459.1937798-1-kpsingh@kernel.org> <20230918212459.1937798-3-kpsingh@kernel.org>
 <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
In-Reply-To: <cb67f607-3a9d-34d2-0877-a3ff957da79e@I-love.SAKURA.ne.jp>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 21 Sep 2023 15:58:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
Message-ID: <CACYkzJ5GFsgc3vzJXH34hgoTc+CEf+7rcktj0QGeQ5e8LobRcw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] security: Count the LSMs enabled at compile time
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        Kui-Feng Lee <sinquersw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 21, 2023 at 3:21=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/09/19 6:24, KP Singh wrote:
> > These macros are a clever trick to determine a count of the number of
> > LSMs that are enabled in the config to ascertain the maximum number of
> > static calls that need to be configured per LSM hook.
>
> As a LKM-based LSM user, indirect function calls using a linked list have
> an advantage which this series kills. There always is a situation where a


> LSM cannot be built into vmlinux (and hence has to be loaded as a LKM-bas=
ed
> LSM) due to distributor's support policy. Therefore, honestly speaking,
> I don't want LSM infrastructure to define the maximum number of "slots" o=
r
> "static calls"...
>

Yeah, LSMs are not meant to be used from a kernel module. The data
structure is actually __ro_after_init. So, I am not even sure how you
are using it in kernel modules (unless you are patching this out).
And, if you are really patching stuff to get your out of tree LSMs to
work, then you might as well add your "custom" LSM config here or just
override this count.

The performance benefits here outweigh the need for a completely
unsupported use case.

> >
> > Without this one would need to generate static calls for (number of
> > possible LSMs * number of LSM hooks) which ends up being quite wasteful
> > especially when some LSMs are not compiled into the kernel.
>
> I can't interpret "number of possible LSMs * number of LSM hooks" part.
> Is this tokenized as "number of possible LSMs" (an integer) * (multipled =
by)
> "number of LSM hooks" (an integer) ? But the next patch includes
>
>   struct lsm_static_calls_table {
>   #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
>                 struct lsm_static_call NAME[MAX_LSM_COUNT];
>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
>   } __randomize_layout;
>
> which seems to me that lsm_static_calls_table will get "number of possibl=
e
> LSMs" static calls for each LSM hook defined in linux/lsm_hook_defs.h .
> How did this patch help reducing static calls? What does "possible LSMs" =
mean?
> Should "number of possible LSMs" be replaced with "number of built-in LSM=
s" ?
>
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org
>
> Trailing ">" is missing.
>
> > +/*
> > + * Macros to count the number of LSMs enabled in the kernel at compile=
 time.
> > + */
> > +#define MAX_LSM_COUNT                        \
> > +     ___COUNT_COMMAS(                \
> > +             CAPABILITIES_ENABLED    \
> > +             SELINUX_ENABLED         \
> > +             SMACK_ENABLED           \
> > +             APPARMOR_ENABLED        \
> > +             TOMOYO_ENABLED          \
> > +             YAMA_ENABLED            \
> > +             LOADPIN_ENABLED         \
> > +             LOCKDOWN_ENABLED        \
> > +             BPF_LSM_ENABLED         \
> > +             LANDLOCK_ENABLED)
>
> Since IS_ENABLED(CONFIG_FOO) is evaluated to either 1 or 0, why can't you=
 directly
> do like IS_ENABLED(CONFIG_FOO) + IS_ENABLED(CONFIG_BAR) + IS_ENABLED(CONF=
IG_BUZ) ?

You cannot do this because this is not evaluated in the preprocessor
and is used to generate the variable names. If you have a working
snippet of code, please share.

> If you can't do direct "+", can't you still do indirect "+" like somethin=
g below?
>
> #if IS_ENABLED(CONFIG_FOO)
> #define FOO_ENABLED 1
> #else
> #define FOO_ENABLED 0
> #endif

How is this an indirect addition? I am not following. The end goal is
that when the preprocessor runs MAX_LSM_COUNT is a constant number and
not an expression like (1 + 1 + 1) if you have ideas please share the
actual code.

- KP
>
