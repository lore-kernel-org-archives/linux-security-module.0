Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C543CC77B7A
	for <linux-security-module@archiver.kernel.org>; Fri, 19 May 2023 20:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjESU7D (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 May 2023 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjESU7D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 May 2023 16:59:03 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A738E45
        for <linux-security-module@vger.kernel.org>; Fri, 19 May 2023 13:58:58 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561c46e07d7so51371337b3.2
        for <linux-security-module@vger.kernel.org>; Fri, 19 May 2023 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529937; x=1687121937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+w9dRor02sYIAeQgw1weuiOYBX3hAqheAba5Kv9Spo=;
        b=YbCYtMeuKLzcC9eLmBvL6yXlMx0MjQhm5VinOekpUGAAsCsfHI0Encl2eQQ5NULaCr
         stJD/5qDV1pThTHwVib83jBZ3pwnYVLNIL0ESb7Wc13XB9XMTNDFkCTEqPqxfxDcm2KK
         N2wLaiqNYC/MX/g7nCzLOQK7YPrgCBna55GxOcfqcI6RZ8TUPPKGFUrlpLCQq3CTf2/V
         o1HQKMjByN4DWA48VgDY5sPS/jEzcNVqi0wd/ITPHTwRBYJwrAIaXHSMM3/0dcUCHgMG
         hg4pw27IhgyZjAQB2iwZo+U446mBLLuOuDlgVkeoEaGak9p5IORL+4bskpLpLlkyqazo
         zIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529937; x=1687121937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+w9dRor02sYIAeQgw1weuiOYBX3hAqheAba5Kv9Spo=;
        b=jQO2jpAxULueDFEiJwU9sprpdnnC25mIBz2hX7TP58pzHS0JxxogqQpaXMh5no5jMA
         vTXM/VE2TTJkHj78uUmpJKzxrzB3++9YxySaaCIUHB7Yamru4DQ0ja7vMuExccm3E/z8
         GlK4RRm+yRXtVxiXkySglJU8Jj/EQkRx/FtTvVb/RR+D9/2bNaLpkGi6xIjoH9cvYwX7
         eyxKwehlLShI6iQoTXBOFh+DS5j8aZbTHnKp4o42OoqCn2MuCQrIWbhETik9C6gvsmVl
         E+uXxNism+sII3moGhaKI0hHzDOdZWJrSH2XX6YXaQUy6ff91/60q5mOvr1ExA5cX60v
         HqlQ==
X-Gm-Message-State: AC+VfDyV4Uo2mueXmwIRNS0MYkJOKb/0oQLUxmwlvvJg9gVd/3eOSeLC
        Xc8yx/yNQEl+DZlxbKs+bFGwoHLICm1tDtF1SZgi
X-Google-Smtp-Source: ACHHUZ4aGW/0UAbawUQQSW48wKjMHkgC7SEV064ulhdzpiVZGurZYCOxDcN3xPlIYDR8p2P0ZEimi6/WnyfCRrkgLpM=
X-Received: by 2002:a0d:ca46:0:b0:561:e873:9225 with SMTP id
 m67-20020a0dca46000000b00561e8739225mr3631670ywd.27.1684529937593; Fri, 19
 May 2023 13:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230511012715.3692211-1-cuigaosheng1@huawei.com> <20230511052527.GA115075@mail.hallyn.com>
In-Reply-To: <20230511052527.GA115075@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 16:58:46 -0400
Message-ID: <CAHC9VhT0mRM33JMe8qQ-cevDxfM8zb-FbA=27h07VqB6igAJ=A@mail.gmail.com>
Subject: Re: [PATCH -next] capability: fix kernel-doc warnings in capability.c
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 11, 2023 at 1:31=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Thu, May 11, 2023 at 09:27:15AM +0800, Gaosheng Cui wrote:
> > Fix all kernel-doc warnings in capability.c:
> >
> > kernel/capability.c:477: warning: Function parameter or member 'idmap'
> > not described in 'privileged_wrt_inode_uidgid'
> > kernel/capability.c:493: warning: Function parameter or member 'idmap'
> > not described in 'capable_wrt_inode_uidgid'
> >
> > Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>

I'm guessing you would prefer it if I took this via the LSM tree Serge?

> > ---
> >  kernel/capability.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/capability.c b/kernel/capability.c
> > index 3e058f41df32..1a2795102ae4 100644
> > --- a/kernel/capability.c
> > +++ b/kernel/capability.c
> > @@ -467,6 +467,7 @@ EXPORT_SYMBOL(file_ns_capable);
> >  /**
> >   * privileged_wrt_inode_uidgid - Do capabilities in the namespace work=
 over the inode?
> >   * @ns: The user namespace in question
> > + * @idmap: idmap of the mount @inode was found from
> >   * @inode: The inode in question
> >   *
> >   * Return true if the inode uid and gid are within the namespace.
> > @@ -481,6 +482,7 @@ bool privileged_wrt_inode_uidgid(struct user_namesp=
ace *ns,
> >
> >  /**
> >   * capable_wrt_inode_uidgid - Check nsown_capable and uid and gid mapp=
ed
> > + * @idmap: idmap of the mount @inode was found from
> >   * @inode: The inode in question
> >   * @cap: The capability in question
> >   *
> > --
> > 2.25.1

--=20
paul-moore.com
