Return-Path: <SRS0=aNh/=ID=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42931C433E6
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 16:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B8965093
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Mar 2021 16:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCEQm7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Mar 2021 11:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhCEQmq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Mar 2021 11:42:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C21C061756
        for <linux-security-module@vger.kernel.org>; Fri,  5 Mar 2021 08:42:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w9so3453883edc.11
        for <linux-security-module@vger.kernel.org>; Fri, 05 Mar 2021 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk8OMwOmLOeNF44FNlnogIevqm0mjwKAqfLqMpd5Efc=;
        b=hsEVnShXawCTd7rYsCb7HmtVmYF7JpNBQa+GKL0GnK3x/ghboFZ7bp61xlKk/PFFqa
         TBvKvgSRwXgzNPM0R//w1139J7dyM4Sy5pl+cbrkYo2XAURPKL9U25cvj677eYYYBQyC
         qWoXYnv5WZpEcjDLESX9uEXwGfKKalPrPwz9PNMxU07gDBxqzw9GfyhPb1LrOi+9VTbz
         AE9BeED/7/NQVa/HMZMUpY4gtYVPxHehLXoP/Sdl1JB43Km8XiIWwz4HCnnKBb7jg/Mw
         3S0f2EOUtoOsJHRBkbuUyXQ3G9NQ2TVO1TcDT5NgbyUt9XfbN0tRkyqdvnBfp6qLnYi6
         d2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk8OMwOmLOeNF44FNlnogIevqm0mjwKAqfLqMpd5Efc=;
        b=Or7UEDSqa+GlwiIyPEmm9z8kEfN2Brbd0V5KJEF9d4G0weC8H17F/eBRTjmUfiY242
         MeXh47sMDrWAsuWSHIqYTYzXQ3PFrMejyTgYqDAsoeSHDDZVAq1cSckN+RArdxPI0u89
         Eramzw++niy4q7+Kw3DcuqCYJSmw+ugCBtZcAKds1f7ET0qHF1RZJCHMbmVOxDZ7vRcj
         E/f0pCbxnbK4ZQPbmy0JhzKYiPtPAS0fzBlHnIllS9JRTaadk6CwTu2ivJs+szOI99U9
         PktYOMxhoeq+ah+6+5+X3a3PoIuhMxRTiht7fONjlprJsiEPJedF53zjZ6bPiRAadvW0
         hpTg==
X-Gm-Message-State: AOAM533B9GDrfGjATwPqsp9vJqyPwaXtOp9+VSVxl1XWgmfMK5bYd6Ap
        glMooXoLWzDMlcD55Hxe51Aj+Gg91cMzIXs/2FKA
X-Google-Smtp-Source: ABdhPJy+q9jV7lCI28zhXkY4ioQuhXyOXmBqObFe8OW+gQynwKVXVXSTR220ORndaBZpYDMSFC9wP58OKyzt5LEHsZA=
X-Received: by 2002:aa7:d7da:: with SMTP id e26mr9947170eds.269.1614962564566;
 Fri, 05 Mar 2021 08:42:44 -0800 (PST)
MIME-Version: 1.0
References: <962223cc9f1cd71814c66f563e35f53cc220f5ce.camel@yandex.ru>
In-Reply-To: <962223cc9f1cd71814c66f563e35f53cc220f5ce.camel@yandex.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Mar 2021 11:42:33 -0500
Message-ID: <CAHC9VhQy2Z512Qy2EVaoc_XMewS0bhH12VJU0SxgK3pSy0ub8Q@mail.gmail.com>
Subject: Re: [PATCH v2] CIPSO: Fix unaligned memory access in cipso_v4_gentag_hdr
To:     Sergey Nazarov <s-nazarov@yandex.ru>
Cc:     linux-security-module@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 5, 2021 at 3:05 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
>
> We need to use put_unaligned when writing 32-bit DOI value
> in cipso_v4_gentag_hdr to avoid unaligned memory access.
>
> v2: unneeded type cast removed as Ondrej Mosnacek suggested.
>
> Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> ---
>  net/ipv4/cipso_ipv4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 471d33a..6e59902 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1162,7 +1162,7 @@ static void cipso_v4_gentag_hdr(const struct
> cipso_v4_doi *doi_def,
>  {
>         buf[0] = IPOPT_CIPSO;
>         buf[1] = CIPSO_V4_HDR_LEN + len;
> -       *(__be32 *)&buf[2] = htonl(doi_def->doi);
> +       put_unaligned_be32(doi_def->doi, &buf[2]);
>  }
>
>  /**
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
