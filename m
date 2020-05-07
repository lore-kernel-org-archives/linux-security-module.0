Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F934C38A24
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A555215A4
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dowhile0-org.20150623.gappssmtp.com header.i=@dowhile0-org.20150623.gappssmtp.com header.b="v3eS0aDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgEGR3I (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbgEGR3H (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 13:29:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C051C05BD09
        for <linux-security-module@vger.kernel.org>; Thu,  7 May 2020 10:29:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w11so7009543iov.8
        for <linux-security-module@vger.kernel.org>; Thu, 07 May 2020 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cP718RVg7L+b48OY8HXdXUf2TciQmTVFFfxyH6ExEMw=;
        b=v3eS0aDK/Kak3SSpVNSZLNGCqXfJdtyMP0f03t1qdm77HiEC1S/42kAkWcI7WYOB4c
         MsdDs41+ZMoJvut9IAF/Ggz7tr8RzxBmElLFqx7npn1U6SU9+LoX3okTLzsb+YHb+Gfh
         3OQb9QCHeE0HeJrEqqMwpSSy3m95Wv1uYt8wPRIUxHoG7AkU0jB6MSBK15j+4yxfdvx+
         HTlPUjoIUSdK5JToJwh/7yH8nWbCOzS09BCwjl97k0etzVpxSHuR4jfhbZSbyqoNeYDE
         KWDvjrcDuXxleWUwLAQrRnQBo3/dZ9TSE6CLTD38yaau16ia41kknpxsyG/A1sA07JCO
         TMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cP718RVg7L+b48OY8HXdXUf2TciQmTVFFfxyH6ExEMw=;
        b=ix+lTcSjsOYPwv7/x7/qLEuQNU3iTn5Ocw8qN9stAxBlmbF+GVCOD1vWVCGyc1Yl7w
         zDqSI3AjNjIn+z5ec2r08K2HA+Cr9ejh8e5oVlNF9MioR6TkCpnVqW4ABMYiqdibpjMT
         66JDsD7uipQZc+f2arhE8ZOx6hQKIfLbGNARF1aM/tNpnV0F6n77UxBRtu8YNb/sCyV/
         C8pp1YRZnXg0NIXTFoOFdMhSbn3ASOaL1bp5D7rAxfkQojvlxYbW331n1+TLTmCODObd
         WqW2K8ma29EA7aXe9o6+PFkGBdvTduKyZr7XpDQ1udHV4pRrEV3QIpduJ/neuSA7wT4H
         nNhw==
X-Gm-Message-State: AGi0PubxCvQbvzFdTLkvdkY0RsjjAJuUM+o+sEGlw1fY3GV6FtIb8MaN
        gRH912Mu6TAGF+5TogQpExjUF8DepGGj3QUtOirsSQ==
X-Google-Smtp-Source: APiQypJ6rH0TMifwwCjf030A68itXswdJuSWMjE36qthX9IBLI8dVl5bssoqsQ3xPKmIB1c32pwweubYnpQ/SB0o30s=
X-Received: by 2002:a02:c98b:: with SMTP id b11mr14791550jap.117.1588872546853;
 Thu, 07 May 2020 10:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
 <CABxcv=kTL_grDUL00c_e2jyPD4hTtFS8Jze6pQBEz_arR6TPVA@mail.gmail.com> <CAHp75VfuKJXz1QO45gDcu1YL_jJy2oz4==zVgsT+2GoLkkm7zQ@mail.gmail.com>
In-Reply-To: <CAHp75VfuKJXz1QO45gDcu1YL_jJy2oz4==zVgsT+2GoLkkm7zQ@mail.gmail.com>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Thu, 7 May 2020 19:28:55 +0200
Message-ID: <CABxcv=mz560QHEKMtf8PYH2pstScSm=5tZZg-9FOuDB5=CuXuw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 7, 2020 at 7:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, May 7, 2020 at 8:06 PM Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
> > On Wed, May 6, 2020 at 5:52 PM Richard Hughes <hughsient@gmail.com> wrote:
>
> > I wonder if these new entries should be documented in
> > Documentation/ABI/. Or maybe that's not a requirement for securityfs?
>
> ABI must be documented. There is no exceptions.
>

Thanks for the clarification. That's what I thought but wasn't sure.

Best regards,
Javier
