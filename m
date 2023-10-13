Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FB1CDB47E
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Oct 2023 21:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjJMVz3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Oct 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjJMVz0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Oct 2023 17:55:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7261DCA;
        Fri, 13 Oct 2023 14:55:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d849cc152so2400910f8f.1;
        Fri, 13 Oct 2023 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697234123; x=1697838923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz29dYX5FIygAwUtE9INYy/iUWfEF9vs6rd2O71c8r4=;
        b=aNDexg5udpQfg++Q+rsgGgg0LCGhJ4gSbhLtEEYh98Y1MGa2n/iBsPq8c2NKTuCxAx
         TbUzdFF3sCDYP/GJiB95qRTTlb9PLaA18zeFEJa4TsJEJdg5bY9HaRmrynC7lpiPsAil
         aw6fyDSuX9dodQMHLT7s/D1JCkUzv0ozAy7HI+K/a8UVn2ceUTPpcprHfHxAygrLIATN
         D/uwlfSkZZLP0IUdbMMjAb0EEWbqFzg7nv/jRJWpKcROx4CllJefOSjxp4F0VJmYWZoz
         sBvucU6bpokNBTOhR1cnobCi8oZKnHJFOVb93izkxx7kdCQbz4wyhcUY4EO/ImO16iF3
         Jkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697234123; x=1697838923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz29dYX5FIygAwUtE9INYy/iUWfEF9vs6rd2O71c8r4=;
        b=MgR/s1oQV+3tlzSpHmBGxvdPBk0DmoRYjSR5FWHGmwqPvGnNEvagZHVuGnWrc32m7U
         pbbCXVnYH6+8QM4GPoKiJxPAdfZ05bI/vNOxnuZ5GP2niQMXf2XQOgUFJBo0PTBjqpym
         L7yu8PXzs5mSfeHF4OB1MUL26WMIqWhhXYUzta5Pm+3Y0WFErc9WrCRSu/djkU2V/VH/
         rhkgzVN/RNj9HAemekvypiaJa4WZbXpbBaG7WsBhhqoVFf4ILkXB8kMNtibRImG5ih5I
         OewVabssPGA1z36FoUwo3X3aifltCRXsDeZ2eB41eDexaw+Hk10Cg6tcze1Pq4je1giL
         a2lg==
X-Gm-Message-State: AOJu0YxYu8tI6tZTC4CvYuZ9u7R7aQ6SsH/YpQrXbJYqL6lgBSVIcJyn
        T6Y5jFseFBrXWXsYSEXJe2js6vma9akjuVnUz8OpjKUj
X-Google-Smtp-Source: AGHT+IFVWzgLGGkOnGu8a5sn52Ly4Ije0IIYsxq+b0E1BtPiE4E2R7LVPon6EfYV5C9Ske4Qxz8aJJ5bcmbAz7YPeUY=
X-Received: by 2002:a05:6000:14e:b0:320:a19:7f87 with SMTP id
 r14-20020a056000014e00b003200a197f87mr24226550wrx.18.1697234122772; Fri, 13
 Oct 2023 14:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231012222810.4120312-12-andrii@kernel.org> <91ed4874a98b620dfa2bd6fe2966f8a7.paul@paul-moore.com>
In-Reply-To: <91ed4874a98b620dfa2bd6fe2966f8a7.paul@paul-moore.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Oct 2023 14:55:11 -0700
Message-ID: <CAEf4BzbYu0+6p+V8EmDSUA3q8Hi7QVmAz3rwg3EuhOK+BQnK9A@mail.gmail.com>
Subject: Re: [PATCH v7 11/18] bpf,lsm: add bpf_token_create and bpf_token_free
 LSM hooks
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 13, 2023 at 2:15=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Oct 12, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> > allocate LSM security blob (we add `void *security` field to struct
> > bpf_token for that), but also control who can instantiate BPF token.
> > This follows existing pattern for BPF map and BPF prog.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h           |  3 +++
> >  include/linux/lsm_hook_defs.h |  3 +++
> >  include/linux/security.h      | 11 +++++++++++
> >  kernel/bpf/bpf_lsm.c          |  2 ++
> >  kernel/bpf/token.c            |  6 ++++++
> >  security/security.c           | 28 ++++++++++++++++++++++++++++
> >  6 files changed, 53 insertions(+)
>
> ...
>
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > index d4e0cc8075d3..18fd1e04f92d 100644
> > --- a/kernel/bpf/token.c
> > +++ b/kernel/bpf/token.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/namei.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/security.h>
> >
> >  bool bpf_token_capable(const struct bpf_token *token, int cap)
> >  {
> > @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
> >
> >  static void bpf_token_free(struct bpf_token *token)
> >  {
> > +     security_bpf_token_free(token);
> >       put_user_ns(token->userns);
> >       kvfree(token);
> >  }
> > @@ -183,6 +185,10 @@ int bpf_token_create(union bpf_attr *attr)
> >       token->allowed_progs =3D mnt_opts->delegate_progs;
> >       token->allowed_attachs =3D mnt_opts->delegate_attachs;
> >
> > +     err =3D security_bpf_token_create(token, attr, &path);
> > +     if (err)
> > +             goto out_token;
> > +
> >       fd =3D get_unused_fd_flags(O_CLOEXEC);
> >       if (fd < 0) {
> >               err =3D fd;
>
> As long as bpf_token_alloc() remains separate from bpf_token_create()
> I'm not comfortable not having a security_bpf_token_alloc() hook in
> bpf_token_alloc().  If you really don't want a LSM token alloc hook
> can you fold bpf_token_alloc() into bpf_token_create()?

Yeah, that's easy, I'll just inline it into bpf_token_create(), which
is the only place where I was intending to use it anyways. I just want
to keep all this consistent between map, token, and progs.

>
> --
> paul-moore.com
