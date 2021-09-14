Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D3C433F5
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E8610A6
	for <linux-security-module@archiver.kernel.org>; Tue, 14 Sep 2021 14:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhINOvZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbhINOvW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Sep 2021 10:51:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F3C061762
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 07:50:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ho42so29499408ejc.9
        for <linux-security-module@vger.kernel.org>; Tue, 14 Sep 2021 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rWA2zdtVFWcSikNV8pK0ujqNWpI7AI04iP+kL8drAc=;
        b=amRUN8nG0KRcoDn29VzagGnKE1/CITBv4aaajWQVMYbGCrDsVnfl1agNGSXIktL6h6
         /n301GG1WuNdNqxYqqFwVtRioTO29hRUMi/8/aWh7LXRNjm2qSXU6sbGvXmRs1M0Ftcr
         MyVEJiL+7pdkBQwW0fbmvilS+Z6DhPOPTn94PKZqUvcpcl591BpVC2+YJJgS8IdMd2iS
         daHOhp7Dt3YV3bqwupwkiNbJGawV1om+mytbg/8rLABI9yBhI+x8w8Hs2UYsjVGLe7xM
         ABm0WyEgz+Fg/3qbGPD+RyO9fOFSAt7feUBGFkv1WOIxxdK8wPp31M30tfBAWZhkt4Re
         Rdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rWA2zdtVFWcSikNV8pK0ujqNWpI7AI04iP+kL8drAc=;
        b=1XB5b0Mv7G1uuZLmqmehzcp93k/aCEJvlx+D5qfn4hFRB8oOOWsTS9UXD6u09PSjlV
         TGaoZbWv8uqSXnT9Q7mUY9ppfBfCnhSFkitR1g7a2pigUuZP/KU2cxHLw7tuaRHVU3P6
         rVJRNJ2mPPiQLdnF0aRR7d/WLpEcnQWweNNG8vJCfO3gBLdLhi+3ghpYT2iCF51dRoTu
         VJnSjyTIFTDnnAl0ceMh8M2p5ZqltLokuo8XOSTpvVxBnbI7Ow4T8oX2wVWUFs4z2E+g
         +kI/lBgMYTKoBuZAKAlKtGsTCoZ6p9lD+ramNTMcTKFWJZrD/aI4+ZyLLUswKyG6BYZc
         WIwg==
X-Gm-Message-State: AOAM532w/A4EXKG3X00zecEc0mXZEFvQso4j2khiy9P5mtrrlI8DzKNc
        2wIy76E9HGkFe9KAZpWwTopF3KkEV7DWyQh7oGFF
X-Google-Smtp-Source: ABdhPJzq0ZXA37IHcUu1EaqiGZ3oe969h/pJ/Fx6Dz+pMr0ti8TXdT4GHj4UtPyunLY/kFJ3Smt0q8DUkiN5kW+G50k=
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr18658835ejj.157.1631631002838;
 Tue, 14 Sep 2021 07:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210914131516.128823-1-omosnace@redhat.com>
In-Reply-To: <20210914131516.128823-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Sep 2021 10:49:51 -0400
Message-ID: <CAHC9VhTLvAy4QtmSunpA+cHSuYrnYt_-f6dTiu+VSX2ifiJ2Xg@mail.gmail.com>
Subject: Re: [PATCH] lsm_audit: avoid overloading the "key" audit field
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 14, 2021 at 9:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The "key" field is used to associate records with the rule that
> triggered them, os it's not a good idea to overload it with an
> additional IPC key semantic. Moreover, as the classic "key" field is a
> text field, while the IPC key is numeric, AVC records containing the IPC
> key info actually confuse audit userspace, which tries to interpret the
> number as a hex-encoded string, thus showing garbage for example in the
> ausearch "interpret" output mode.
>
> Hence, change it to "ipc_key" to fix both issues and also make the
> meaning of this field more clear.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/lsm_audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems reasonable to me, I can merge it via the audit/next tree unless
James would prefer to take it via the LSM tree.

> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 5a5016ef43b0..1897cbf6fc69 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -224,7 +224,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>         case LSM_AUDIT_DATA_NONE:
>                 return;
>         case LSM_AUDIT_DATA_IPC:
> -               audit_log_format(ab, " key=%d ", a->u.ipc_id);
> +               audit_log_format(ab, " ipc_key=%d ", a->u.ipc_id);
>                 break;
>         case LSM_AUDIT_DATA_CAP:
>                 audit_log_format(ab, " capability=%d ", a->u.cap);
> --
> 2.31.1

-- 
paul moore
www.paul-moore.com
