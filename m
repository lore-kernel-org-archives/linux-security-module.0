Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B479EE49A6
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 16:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjHUQoC (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 12:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjHUQoA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 12:44:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76427F3
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 09:43:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-584034c706dso38825317b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692636237; x=1693241037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEjD/AU1mAJeRfhZIstUaBuufPMB+eCFCGb0gsqx2K4=;
        b=e/fljHM5IKab4bwCG1qJZjMl1EdYPDisy5PuxXxKuc9lDhOydnOuCnDQqfvG2xe+L6
         k7fwLgzPn5MRWSpTSS7DWJJLICoFgwGSRBTNu+i9RqAJeXjNEY07ysFOtQcv2dAp3WgA
         aWxiuvMltKpXaN5b46LFPwc2GwslYeaXhSA8x3VeP2HnR+eB9pdI7o1m114AhVcjgqUf
         Di2MBfcTOYveghp/yk5rUV8wqFoWTuWw6sUSyoYJJKUeKgCfD5YnKhtU1oMzow1Zs6Mt
         U2375T2IA+uo27m1Y2U7h9GGFaBZSKfkpJi7CtFidyCEX/jtuTiND5dYYIP198K1lC2i
         GrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636237; x=1693241037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEjD/AU1mAJeRfhZIstUaBuufPMB+eCFCGb0gsqx2K4=;
        b=irco83qiyTQnmUE5NL04QrL+kLCo3obAh6owtMAK/nNCZcI1eRedrdSfHZy5BTSTrR
         QVNwlItfO5Sh9+gdeFnmcSgafF5aaBK2x6AAuLjILG3dykv92Y9toNrjkop8C9c5lwqf
         kSMMe/XapVdJyAJvG8tg5YMF1heMqf56+Bn4R+ZXZo7J34Vhg8l9znpid4IS65DHW+cz
         MWeTIT7ZpiJMzlCdYfL4kDHe001ghV18pAEd9dbZjAs0cgDhY7HXU3R17rz9tDUhLEgz
         WchXsPxroWKkrJd82JOfdN1LPik2uwQP73T6LCNrYIt2WnsusolaROzUi5yH2RR4aI6I
         6oWA==
X-Gm-Message-State: AOJu0Yx0tzFCkg5S4WfvIuPLiE2q/8OK6rq7pR6/D0De8LN1RvKnp39p
        poxWpFLlWpPE0zWs/uZImvDTb/8vhHzXOIUp3AM6
X-Google-Smtp-Source: AGHT+IFC5jriDqIEqds1bFUlasgKfzxVpx6c15GAraTz0Da6iHbAu2CtBrlCUKHV6YdY1VqSSccVr3ANUqzpYgoAo4g=
X-Received: by 2002:a81:7384:0:b0:577:3fb4:f245 with SMTP id
 o126-20020a817384000000b005773fb4f245mr6182153ywc.19.1692636237673; Mon, 21
 Aug 2023 09:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAP2_zdp=oGKVfuAYUSXb_42yU-8-86AtS27TiXpibS4mj8wrfg@mail.gmail.com>
In-Reply-To: <CAP2_zdp=oGKVfuAYUSXb_42yU-8-86AtS27TiXpibS4mj8wrfg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Aug 2023 12:43:47 -0400
Message-ID: <CAHC9VhSre7fiAVNtbyVcjg3v3uUwzOm0grNbmo1ppKOyh1B=jg@mail.gmail.com>
Subject: Re: Watchdog bark! bark due to excessive logging from SELinux in Linux-modules;
To:     Aaditya raj <rajaditya073@gmail.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 21, 2023 at 7:14=E2=80=AFAM Aaditya raj <rajaditya073@gmail.com=
> wrote:
>
> Hi Team ,
>
> There is an Watchdog bark issue seen due to excessive logging from SELinu=
x , I have attached a patch to restrict excessive logging , please review t=
he patch and please let me know if there is any issue.
>
> I have modified the file =E2=80=9Csecurity/selinux/hooks.c=E2=80=9D on li=
ne number 1353 , replaced pr_warn with pr_warn_ratelimited.
>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can you provide more information about what kernel you are using and
the filesystem(s) you have mounted which are causing this error,
including how they are mounted?  I wouldn't expect a normal system to
flood the logs with many of these warnings, so I'm wondering if
something else is wrong ...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..83f3e5a0ccc6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1350,7 +1350,7 @@ static int inode_doinit_use_xattr(struct inode *ino=
de, struct dentry *dentry,
>         if (rc < 0) {
>                 kfree(context);
>                 if (rc !=3D -ENODATA) {
> -                       pr_warn("SELinux: %s:  getxattr returned %d for d=
ev=3D%s ino=3D%ld\n",
> +                       pr_warn_ratelimited("SELinux: %s:  getxattr retur=
ned %d for dev=3D%s ino=3D%ld\n",
>                                 __func__, -rc, inode->i_sb->s_id, inode->=
i_ino);
>                         return rc;
>                 }

--=20
paul-moore.com
