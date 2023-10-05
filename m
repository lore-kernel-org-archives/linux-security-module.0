Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA88E9270E
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Oct 2023 14:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjJEOmW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbjJEOhs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42204E35A
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 07:03:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DC8C4AF71
        for <linux-security-module@vger.kernel.org>; Thu,  5 Oct 2023 13:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512381;
        bh=6mUgLSnm4Kc6OY+sFrERl85k6Jk4/7QG8hihF86ti4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lqFWaQzZooeQt1OHHnMDx3Nhb3xVcKAAd+TWPLpY4IL4qIyjVZMSfqKiVKM9s7oXk
         GuWk3axUIJJsCZfoZyzWBhnN9BhrBwbJzTVg7o3Ilz3Rhp+JwQBm2Ts0E9hILthjYD
         srTdVeZFXidzZpq0wrt1jVtDPGs7WE2m+dTyyo9w2VGs80nSJwr0o7TLlcZ9ZGHHOr
         ONe57mugQpnRV8QJL+p6b587kuA6dQuJe51hhQgO6/POSraodfz9lOQN8bX/Gban/p
         gNMFLKMPyafSd/9e2akqR9nW8OKCR5Udigskggeu+gu/h3/e3RQNoIV8n1du0EE1ab
         4AbeDxKVNf61Q==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so1715459a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Oct 2023 06:26:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YwppI5HcotZX9ocANxnhKl5NzYB5mrOMyyrX6cTs6H+LO4+FVlq
        SIxu18gUyaUcgtcAZVoVetKF13qP/FaqBFVtUzI/nQ==
X-Google-Smtp-Source: AGHT+IGjEoiN5sIey9XlvsLiGVpcrzObalyvIGnXglMXvNE6FLnE02Xn7KXKfKtdJpJoQEp9dBTg8bLESCIN87KN+xM=
X-Received: by 2002:a05:6402:134f:b0:532:bb18:7986 with SMTP id
 y15-20020a056402134f00b00532bb187986mr5067221edw.39.1696512379251; Thu, 05
 Oct 2023 06:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230928202410.3765062-1-kpsingh@kernel.org> <20230928202410.3765062-5-kpsingh@kernel.org>
 <ZR5vSyyNGBb8TvNH@krava>
In-Reply-To: <ZR5vSyyNGBb8TvNH@krava>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 5 Oct 2023 15:26:08 +0200
X-Gmail-Original-Message-ID: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
Message-ID: <CACYkzJ69x9jX3scjSA7zT99CJoM+eG6FDQdBT-SCxm47a6UEoA@mail.gmail.com>
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

On Thu, Oct 5, 2023 at 10:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Sep 28, 2023 at 10:24:09PM +0200, KP Singh wrote:
>
> SNIP
>
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index e97aeda3a86b..df9699bce372 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/bpf_verifier.h>
> >  #include <linux/bpf_lsm.h>
> >  #include <linux/delay.h>
> > +#include <linux/bpf_lsm.h>
> >
> >  /* dummy _ops. The verifier will operate on target program's ops. */
> >  const struct bpf_verifier_ops bpf_extension_verifier_ops =3D {
> > @@ -514,7 +515,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tr=
amp_link *link, struct bpf_tr
> >  {
> >       enum bpf_tramp_prog_type kind;
> >       struct bpf_tramp_link *link_exiting;
> > -     int err =3D 0;
> > +     int err =3D 0, num_lsm_progs =3D 0;
> >       int cnt =3D 0, i;
> >
> >       kind =3D bpf_attach_type_to_tramp(link->link.prog);
> > @@ -545,8 +546,14 @@ static int __bpf_trampoline_link_prog(struct bpf_t=
ramp_link *link, struct bpf_tr
> >                       continue;
> >               /* prog already linked */
> >               return -EBUSY;
> > +
> > +             if (link_exiting->link.prog->type =3D=3D BPF_PROG_TYPE_LS=
M)
> > +                     num_lsm_progs++;
>
> this looks wrong, it's never reached.. seems like we should add separate
> hlist_for_each_entry loop over trampoline's links for this check/init of
> num_lsm_progs ?
>
> jirka

Good catch, I missed this during my rebase, after
https://lore.kernel.org/bpf/20220510205923.3206889-2-kuifeng@fb.com/
this condition is basically never reached. I will do a general loop
over to count LSM programs and toggle the hook to true (and same for
unlink).

- KP

[...]
