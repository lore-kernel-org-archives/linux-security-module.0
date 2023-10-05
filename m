Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28739E92716
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjJEPw1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 11:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjJEPvI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D639B6079D
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 07:07:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB911C4AF70
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512467;
        bh=N1dE7AmjrUZ47G8HQruxm76EJR2/5jXU4d/2bgOQyD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RX91+hxHDnfAAc5JnJjtmLsXaBeaTfXs/YUeCrPgTf4rAIo1sjr/h/E6XJlq//yje
         po8V3DDCBmjT+BZWX7BR7U1LDI3FsVSryPNucgjYQMwKZbZWGmbxAhEDxofAWop0ys
         pD9N0E2FfXWlkmwb5UkTqrzhIcnI5wzZVVjY2tS59LbydSsnTI+AaI0haTWn13U9wR
         GiN3LUj+Sdr+H8zvYkv7WTYhjmALEUH6LVSZVJvVOWSBTpnLEAEQEmb2ohDDfNKUgc
         RfRHaZSSoRZSSlaUahAJobZtlEay1s5puFPuPCvOtRFTY7Mt570OGocDcTh+xw/auH
         K5fyvD7EUlv0g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1729578a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 05 Oct 2023 06:27:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YzsgcagqgMNSSlF9VfJ0+75oBapb0rHrYK66QHPZCRWzLiwwKFF
        xvo7d8R17FQpP8hrxgqMm/3n7ep6ECCAmwesgwfUgw==
X-Google-Smtp-Source: AGHT+IHFOywWEnxWs29vHFV4gq5qgGxjrrUvMtfRCD2Ccr7MKURyA9Sy2tPKeI1YA+BoW/dGxflH4GTeRjKC/Q0IIX8=
X-Received: by 2002:aa7:d588:0:b0:523:33d7:e324 with SMTP id
 r8-20020aa7d588000000b0052333d7e324mr4669372edq.38.1696512466159; Thu, 05 Oct
 2023 06:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava> <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
In-Reply-To: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 5 Oct 2023 15:27:35 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
Message-ID: <CACYkzJ7Q0NEc9HThS1DZr0pMC+zO0GSToWmwQkTgXTeDs5VKaw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] bpf: Only enable BPF LSM hooks when an LSM program
 is attached
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, keescook@chromium.org, casey@schaufler-ca.com,
        song@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        renauld@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 5, 2023 at 3:26=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote:
>
> On Thu, Oct 5, 2023 at 10:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wr=
ote:
> >
> > On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
> >
> > SNIP
> >
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index e97aeda3a86b..df9699bce372 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/bpf_verifier.h>
> > >  #include <linux/bpf_lsm.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/bpf_lsm.h>
> > >
> > >  /* dummy _ops. The verifier will operate on target program's ops. */
> > >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_=
tramp_link *link, struct bpf_tr
> > >  {
> > >       enum bpf_tramp_prog_type kind;
> > >       struct bpf_tramp_link *link_exiting;

I think this is a typo here. It should be existing, no?

> > > -     int err =3D 0;
> > > +     int err =3D 0, num_lsm_progs =3D 0;
> > >       int cnt =3D 0, i;
> > >
> > >       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf=
_tramp_link *link, struct bpf_tr
> > >                       continue;
> > >               /* prog already linked */
> > >               return -EBUSY;
> > > +
> > > +             if (link_exiting->link.prog->type =3D=3D BPF_PROG_TYPE_=
LSM)
> > > +                     num_lsm_progs++;
> >
> > this looks wrong, it's never reached.. seems like we should add separat=
e
> > hlist_for_each_entry loop over trampoline's links for this check/init o=
f
> > num_lsm_progs ?
> >
> > jirka
>
> Good catch, I missed this during my rebase, after
> https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
> this condition is basically never reached. I will do a general loop
> over to count LSM programs and toggle the hook to true (and same for
> unlink).
>
> - KP
>
> [...]
