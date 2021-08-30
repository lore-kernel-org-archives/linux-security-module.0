Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB53C432BE
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 14:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C060E98
	for <linux-security-module@archiver.kernel.org>; Mon, 30 Aug 2021 14:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhH3OSM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbhH3OSM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 30 Aug 2021 10:18:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C1C061760
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 07:17:18 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eb14so12653843edb.8
        for <linux-security-module@vger.kernel.org>; Mon, 30 Aug 2021 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PhLhEsUAzqUuFfsscW0DyI/J5DCKBefy3mdhQUbyDaE=;
        b=hFbYrNf1BGA7EbIY3/fCL9Gwx/Ffing14F//0+cYUzQSxvcwICcE7Rag0RErTv4j8x
         q9/o2+bxiLl2n+HRA4/4O1H5rf+/a6V8NEMdoZBWeAE4L2jGfyOW33In6wKXESBD2ugj
         VmnL/1Vwt88n+e0TK7fAlDd5mbzFDA9uc/GzempJs4v38wM0X4ntS7estZIVPC6H/DXH
         V2z54eIRpliokdLYaqoir0M5ElAzRT598ozmmzG5Jjjw5SxnYxPpgIxITb8LP7AY3i/z
         OAebGDHmhn3dch+Kl8AazkXAXXlLyYpwg2jy2CtTeqHvR8FSaVHeA8On6he08wk+xAos
         7XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PhLhEsUAzqUuFfsscW0DyI/J5DCKBefy3mdhQUbyDaE=;
        b=sXF/FGohKBA8+5OvBS8D/0hid3CIIZ491/uH9TfY7XJc/IC4Xm1U7PavJONX2xHTHb
         G3cTqBn4XWxb29kp5lw+y/ViRFHrh4NjmKOgv2Ter9PY9F+CYWM97EbVCMYcELWDBHru
         HlIIoWp/0jRQxwEYmeQjG0jCsD6IjNPCUVtjYvY0DUAEHSXoOdufkYGoUkTU5Lme79fu
         wIMVl+PNBJz6bGQvmr0hJPWZOfwUBRLywJUIq7hbsNnPMCKMIEPEv5wXmA5fGyUA3rUD
         jHpYyxR4YFEOh8n2EvJdKy4Hrrzcq23DQi5R16E9UuHf6eOb34iFt4OaPFql9jVzT9g0
         ZMgA==
X-Gm-Message-State: AOAM533Xah6d6PL2M1IdfhT37ikf8MQGwd4OWwd7VDNxm/A4cqchnGYn
        xrl/SHA3/+duvuHlhrXs1dbrx+NTvaRWm4KNwxlu
X-Google-Smtp-Source: ABdhPJz3FfrmGcwM4/D9ULldGgAIwmlxACn09R0XQcGjmp55gorvp0R5dA9e1PjiKQW+a0+PR6TSBRaUxTeBzYdN+TE=
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr24947247eds.128.1630333036601;
 Mon, 30 Aug 2021 07:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <c6864908-d093-1705-76ce-94d6af85e092@linux.alibaba.com> <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com>
In-Reply-To: <18f0171e-0cc8-6ae6-d04a-a69a2a3c1a39@linux.alibaba.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Aug 2021 10:17:05 -0400
Message-ID: <CAHC9VhTEs9E+ZeGGp96NnOhmr-6MZLXf6ckHeG8w5jh3AfgKiQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: fix NULL pointer reference in cipso_v4_doi_free
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 30, 2021 at 6:28 AM =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.=
com> wrote:
>
> In netlbl_cipsov4_add_std() when 'doi_def->map.std' alloc
> failed, we sometime observe panic:
>
>   BUG: kernel NULL pointer dereference, address:
>   ...
>   RIP: 0010:cipso_v4_doi_free+0x3a/0x80
>   ...
>   Call Trace:
>    netlbl_cipsov4_add_std+0xf4/0x8c0
>    netlbl_cipsov4_add+0x13f/0x1b0
>    genl_family_rcv_msg_doit.isra.15+0x132/0x170
>    genl_rcv_msg+0x125/0x240
>
> This is because in cipso_v4_doi_free() there is no check
> on 'doi_def->map.std' when doi_def->type got value 1, which
> is possibe, since netlbl_cipsov4_add_std() haven't initialize
> it before alloc 'doi_def->map.std'.
>
> This patch just add the check to prevent panic happen in similar
> cases.
>
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  net/netlabel/netlabel_cipso_v4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I see this was already merged, but it looks good to me, thanks for
making those changes.

> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cip=
so_v4.c
> index baf2357..344c228 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -144,8 +144,8 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                 return -ENOMEM;
>         doi_def->map.std =3D kzalloc(sizeof(*doi_def->map.std), GFP_KERNE=
L);
>         if (doi_def->map.std =3D=3D NULL) {
> -               ret_val =3D -ENOMEM;
> -               goto add_std_failure;
> +               kfree(doi_def);
> +               return -ENOMEM;
>         }
>         doi_def->type =3D CIPSO_V4_MAP_TRANS;
>
> --
> 1.8.3.1

--=20
paul moore
www.paul-moore.com
