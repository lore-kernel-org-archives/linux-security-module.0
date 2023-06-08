Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5ABC7EE25
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Jun 2023 18:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjFHS5z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFHS5y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Jun 2023 14:57:54 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45302718
        for <linux-security-module@vger.kernel.org>; Thu,  8 Jun 2023 11:57:53 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55af55a0fdaso642467eaf.2
        for <linux-security-module@vger.kernel.org>; Thu, 08 Jun 2023 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686250672; x=1688842672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOhMqhjw5pgo1DLFwbT1NxdLsERedd9NQ4vBoJhagXQ=;
        b=I885Q2BjWoCM/xdi9m0qbewwKaXmhHDxrKogZX9aC4+GBmjp7VGikVCh8WKBiBeyES
         Sa/+64LHGDyYuxZAiRgrNkJ16f7EVfxm7fy/u1oWhlOGtNNhBzZDaS0Ami6hjp97Bi/M
         z5o+ch7+bpOiCog7mF+kGbJoZQ5dSXk9z0AISMXz+MLf0GhLNR8bWDijaSXiUJE2Sv4Y
         Ykn90vUpy65hYTYzVQv+5ZmwyAl2nNbkr72WPslQsWk+MgntUqGD6y7HOeq2+LhXQenq
         XAFTjgztjTLvjTxhwEh9C8ZEny7BJRdDT62COM6zw1o9JyR7bU4EMsuiSuYk05yuwMXC
         n8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686250672; x=1688842672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOhMqhjw5pgo1DLFwbT1NxdLsERedd9NQ4vBoJhagXQ=;
        b=bHMb/v3m+XDxOL1NKLef942OTdD2F/hDIFgmGKeWRPd8wiaGnKEHzo7sW1iaiMdZmG
         puQ1wYah4yvrcyMXflhesqpz6nKObo694+4VS9QzlnpYMKS/LBxVUAkGTB0uuezA34k/
         Km3/REwAhqk30/Ldw5I7wixp94EHN6JaN3LnmXQsGRLh7lc2cB7aCKiEM503oNvMwaow
         LsP8fiOwtx951Ffsp2oWV7HK7NZh0gVB2WjzvGq8fX2OtcKD0wIz2+fmAxC3MmGJDsrE
         74F6hbgViadmiBS/EpVsxynK9UlmOzRkkxgvJ5iEaUmG9Lw9VhN408fVYOomKwT5j3Wg
         ys7g==
X-Gm-Message-State: AC+VfDxuVm89MtshiM0FCuSxlILX0j4FP0m6pwFvwnsDW0A5zXfjocsr
        dSmpX6giTDqw6bRne3f1Ri0C56edO+L4yc3KAtTm
X-Google-Smtp-Source: ACHHUZ5r48MqAG02vf5w1UQDeniWS4RiheX9JdGyxl11RzIt8axYQmCosdK24DnsbTB0pGlZlXQOW6mBMW5z3gB6Cf4=
X-Received: by 2002:a05:6808:b25:b0:394:4603:77f2 with SMTP id
 t5-20020a0568080b2500b00394460377f2mr9583454oij.2.1686250671974; Thu, 08 Jun
 2023 11:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230608135754.25044-1-dmastykin@astralinux.ru>
In-Reply-To: <20230608135754.25044-1-dmastykin@astralinux.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Jun 2023 14:57:41 -0400
Message-ID: <CAHC9VhSMe0sLNkWbNCswm67bGZAgp+xJjyD2EBcXvTxD_2kAwg@mail.gmail.com>
Subject: Re: [PATCH] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
To:     Dmitry Mastykin <dmastykin@astralinux.ru>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 8, 2023 at 9:58=E2=80=AFAM Dmitry Mastykin <dmastykin@astralinu=
x.ru> wrote:
>
> There is a shift wrapping bug in this code on 32-bit architectures.
> NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
> Every second 32-bit word of catmap becomes corrupted.
>
> Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
> ---
>  net/netlabel/netlabel_kapi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Dmitry.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
> index 54c083003947..27511c90a26f 100644
> --- a/net/netlabel/netlabel_kapi.c
> +++ b/net/netlabel/netlabel_kapi.c
> @@ -857,7 +857,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **=
catmap,
>
>         offset -=3D iter->startbit;
>         idx =3D offset / NETLBL_CATMAP_MAPSIZE;
> -       iter->bitmap[idx] |=3D bitmap << (offset % NETLBL_CATMAP_MAPSIZE)=
;
> +       iter->bitmap[idx] |=3D (NETLBL_CATMAP_MAPTYPE)bitmap
> +                            << (offset % NETLBL_CATMAP_MAPSIZE);
>
>         return 0;
>  }
> --
> 2.30.2

--=20
paul-moore.com
