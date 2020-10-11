Return-Path: <SRS0=H78M=DS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B0EC433E7
	for <linux-security-module@archiver.kernel.org>; Sun, 11 Oct 2020 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96A221655
	for <linux-security-module@archiver.kernel.org>; Sun, 11 Oct 2020 20:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rH4sQc4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbgJKUFq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 11 Oct 2020 16:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgJKUFp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 11 Oct 2020 16:05:45 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85851C0613D0
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2020 13:05:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lw21so20370548ejb.6
        for <linux-security-module@vger.kernel.org>; Sun, 11 Oct 2020 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fn3a2TRSpw4Qw7kTvuDdS1yGeLObpqGFeJkmfCLmfYw=;
        b=rH4sQc4kiIaL95mmyPCWUBV+W8FLVcv9VPmB76fcwdAwToK82RaPakQwVZaGoBad4m
         23OMt4Q0VLoTmPtInWeBUCoJCWIj0skXYBoTLnIvsRiquSB+zOsaQLLfb279t6eipWkg
         D3rf0rhG/LDgpaTZhl/g/w97VfMWnTLecK5f2e4wDNCElehkdW4O44B7LFC95UOswQie
         sYVKXK99Gj4/eYiT2aE7UC6bODUaFkKXJsqYRvApBXuuhEXfDiVrR5BjmLniRbLxZsn3
         GXgMD6FkaKTbO8zo805cNPBXND5Wx69VtiC24pIvvjQ72VQjI9HwnMblLk6l94FmcO77
         ZgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fn3a2TRSpw4Qw7kTvuDdS1yGeLObpqGFeJkmfCLmfYw=;
        b=WADspbUs/YUjbM1xn3Os7bhYmzyK+kKVfsA3fU63fcAyH6XEC+/IJZIcGC/up1l0JG
         uYyS8/Kn8Za9esZzdqzGGVL4U6hO1Z7GJXEuSR1+NBQmUPr0gOoQzjpH8w5P4HwI/+ih
         k9fN96Rn2OyNz5w+yLFDY0YPy/6+B+r2vz4HkBwLUulgI48heVob707rdwOxRIUkQOKI
         6uYJjeNa4+Mh1zjWM9ntFS5mNPYKzHywuOd5hqBgii1BaG13Rk2wJUi1+uigYOrsg6tB
         A2RCQZeoecu45PSKebfeJmKXZBAc4/fGVvoqFnAbNEYypqn1Ue01eKpdKcw70M9jz17w
         o8ng==
X-Gm-Message-State: AOAM533x/jChBIV+cCbWSFRsxcS0z7L9ks1gexiuqnqdASYV+1GLAcEt
        uM6jVZvpxv0aHkFKGENT0vox6yf8whJ2h+fGj1y7
X-Google-Smtp-Source: ABdhPJyFWEkF1uWg3VFTio+74U0ShC3sxoON2X/ALfSwQEFGN/OFeCXzUCfNwuRvCX3yfsan24m6yO/nqdSoXNYAUAY=
X-Received: by 2002:a17:906:c444:: with SMTP id ck4mr23598812ejb.398.1602446743879;
 Sun, 11 Oct 2020 13:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <1602412498-32025-1-git-send-email-Julia.Lawall@inria.fr> <1602412498-32025-5-git-send-email-Julia.Lawall@inria.fr>
In-Reply-To: <1602412498-32025-5-git-send-email-Julia.Lawall@inria.fr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 11 Oct 2020 16:05:32 -0400
Message-ID: <CAHC9VhQfDueBs_nahF2xxP8bof2yH1p4PPXwfxh4xnmQeEF4XA@mail.gmail.com>
Subject: Re: [PATCH 4/5] net/ipv6: use semicolons rather than commas to
 separate statements
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Oct 11, 2020 at 7:18 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Replace commas with semicolons.  Commas introduce unnecessary
> variability in the code structure and are hard to see.  What is done
> is essentially described by the following Coccinelle semantic patch
> (http://coccinelle.lip6.fr/):
>
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>  net/ipv6/calipso.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Julia.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index 8d3f66c310db..78f766019b7e 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -761,7 +761,7 @@ static int calipso_genopt(unsigned char *buf, u32 start, u32 buf_len,
>         calipso[1] = len - 2;
>         *(__be32 *)(calipso + 2) = htonl(doi_def->doi);
>         calipso[6] = (len - CALIPSO_HDR_LEN) / 4;
> -       calipso[7] = secattr->attr.mls.lvl,
> +       calipso[7] = secattr->attr.mls.lvl;
>         crc = ~crc_ccitt(0xffff, calipso, len);
>         calipso[8] = crc & 0xff;
>         calipso[9] = (crc >> 8) & 0xff;

-- 
paul moore
www.paul-moore.com
