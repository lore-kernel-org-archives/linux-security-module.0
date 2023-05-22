Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B71C7EE23
	for <linux-security-module@archiver.kernel.org>; Mon, 22 May 2023 18:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjEVScP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 May 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEVScM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 May 2023 14:32:12 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFBC2
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 11:32:09 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5621a279cbbso58761287b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 22 May 2023 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684780328; x=1687372328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz0jybB8N6lVUtpbckckEpYsDExxtY08OX0Cm9skpv4=;
        b=CqG4tZhq+McdhKnyHsmL5yWQaDnrIE7n5wxEHFhl/WH/jUO85/Az/QmEpqGpMMm6Du
         RU22x7T9AyhacKeDorKZhwrBysx28Xqe6Q2ABtcG+XITc80UuTAfZ8TTGqkAwugr0U8U
         Mlx+Q4sICQ/Mx2I9pa91TuP8puYTAJrwaeevMJ0Mq5jjy/oL3HamgOz5OJIXRnXAA6uy
         vWGFiMPgBNJQpStHx6wB0MMrNPV2eHWJWIy9uaKOjZXgxBLMaoNFLzftYH/9G+MM6bsQ
         r7dpOvFR4l/OtiYWfUYEN361C0gL6zYR1VHM8HcSWA5YSkckEwGyNfG02yU0K3aEX0k2
         xIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780328; x=1687372328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kz0jybB8N6lVUtpbckckEpYsDExxtY08OX0Cm9skpv4=;
        b=JnnFEyLQ9rkJ9xrmad2jnz+3up9cPF1oqGvHm54W3MwiKWRBWI//bHqe4FdYau6ukX
         3EsYSjXmJHhM6ROh6TaKq5ARwtB5WQ4LAUgVgOxST9m1+r4gJNoXdTSKc27t9Nd1o8hO
         NyEyQA+dFFQRMBFE2XnR/R94G3FdGy0NUfdciaztGmIlYgUvMlifigck9j3buNZoQjt/
         onKS6O+TBxKRGMQZbxyGt1tyVqItsUMkVtVWeDQhUC38joos3vmHMbxiHyDN/zNfu9+u
         h8HbpMrs28Hephgq+sjcO+zWK95PhePavE8RMJC0BWKwKraBwNN0YKsxhhfsab74rqNx
         O/eg==
X-Gm-Message-State: AC+VfDwV0aUaX2blR9/0h6KixFi6tCjTGWguPhClUkBzPeonMXUKsweb
        EE7LNMB4ndAYtM/Qegyha5OuaOUoD91RMAn9G4SL
X-Google-Smtp-Source: ACHHUZ7rRDSEq0GwVsyLG9r+diolCEzwWSfy9euohpFbWZ9ypIMowURZyzFh3e1z+trfcZxB4/jgPgj0W06Xx5eZqrY=
X-Received: by 2002:a81:7949:0:b0:561:872d:5086 with SMTP id
 u70-20020a817949000000b00561872d5086mr13809974ywc.1.1684780328316; Mon, 22
 May 2023 11:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230511012715.3692211-1-cuigaosheng1@huawei.com>
 <20230511052527.GA115075@mail.hallyn.com> <CAHC9VhT0mRM33JMe8qQ-cevDxfM8zb-FbA=27h07VqB6igAJ=A@mail.gmail.com>
 <20230522174154.GA336383@mail.hallyn.com>
In-Reply-To: <20230522174154.GA336383@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 22 May 2023 14:31:57 -0400
Message-ID: <CAHC9VhSKNtQMqqGpA2K3ejmL58-s-nLrkCY1w2MxHXm4P-Tg4g@mail.gmail.com>
Subject: Re: [PATCH -next] capability: fix kernel-doc warnings in capability.c
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, May 22, 2023 at 1:41=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Fri, May 19, 2023 at 04:58:46PM -0400, Paul Moore wrote:
> > On Thu, May 11, 2023 at 1:31=E2=80=AFAM Serge E. Hallyn <serge@hallyn.c=
om> wrote:
> > >
> > > On Thu, May 11, 2023 at 09:27:15AM +0800, Gaosheng Cui wrote:
> > > > Fix all kernel-doc warnings in capability.c:
> > > >
> > > > kernel/capability.c:477: warning: Function parameter or member 'idm=
ap'
> > > > not described in 'privileged_wrt_inode_uidgid'
> > > > kernel/capability.c:493: warning: Function parameter or member 'idm=
ap'
> > > > not described in 'capable_wrt_inode_uidgid'
> > > >
> > > > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> > >
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > I'm guessing you would prefer it if I took this via the LSM tree Serge?
>
> That would be great, thank you.

Merged into lsm/next, thanks everyone.

--=20
paul-moore.com
