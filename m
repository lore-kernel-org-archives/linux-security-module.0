Return-Path: <SRS0=9z6D=6V=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2005C38A24
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05AC20A8B
	for <linux-security-module@archiver.kernel.org>; Thu,  7 May 2020 17:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr3Z+SjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGRWc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 7 May 2020 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgEGRWc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 13:22:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAC0C05BD43;
        Thu,  7 May 2020 10:22:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id y6so2927034pjc.4;
        Thu, 07 May 2020 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/20rvbMhxHaTFq5mGiMpgTwgO54ykpEP+pXY9OZpxhY=;
        b=Rr3Z+SjUgLqMXR2JXcPNOjWrjXcFY6enFmkdBcKQsTRfZyRinb2Fg8wS7OkPwPohtF
         uxn7kXIxOwZerwI5+58I+vfUFBASPe3oO9HZDOnXM3q9PTSRcq8+6yrJnLnmdPorsd61
         SOuUcaLaUClb24ZALz9m2BDAyNmH6JH0TeTl2531Md+Ful9SifpNMCdglCTC9Eb2TXKz
         IqoijdjRPEMpji90olIMwq2uLTSGuzoFshsPliwKfHiuPtlzmkRZqj7nj9yKBPODK5Yx
         Jd0tTbqsSJA4bgfdbxinFmPdc9Pou7OpyIALaKSfSsyF/oaOIEcTLZQpxE5z69lMqiAt
         G9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/20rvbMhxHaTFq5mGiMpgTwgO54ykpEP+pXY9OZpxhY=;
        b=ZiMPik5GE+Nf9UgwAhBqAN8hDvI9pJHyJVeF/ILrlfuhQew12vyoyXMC7EURVx4bs0
         o/Ljo48efLALPVrPNdHqTqJQwRAouYUkwgFHxQ/2/SXLHqo3pnghVQ9Xdt2DI4MgkALJ
         WIqtpu8jdmez64f0dWIf3icwTlkbNb3wA3+/z2DKpANeFuxLgg60g6W5r4zLnUgC80dZ
         AgzRU+BiIPwG0YBozGr7Dtahc4u/K7Ka0obeXBJlfb5GtJ4z8dE2dvbJseH8GvFHeGTn
         omjYj5t4C1sR7he48hxaprjIzHSEZECaAFAm5cIZ066ezj4NDQMfAK/+68CdbFa8Ktu0
         +ZJA==
X-Gm-Message-State: AGi0PuYbJADp1YsZJTX/0FjNviVpp8SivPm1+X7vcGXacU0LcpHeDrDY
        5LQum7YMOnJpYKYALJv7wuvr79m2IVzIg9JR3syKREIg
X-Google-Smtp-Source: APiQypI8SHtTMNgNHfseeYuhxCoCclvKeMR3vCoqyFD/KVrb/AERvT2iVcLkPogjen9hmvMtaAb74oaub6MG+KFPg1k=
X-Received: by 2002:a17:90b:374f:: with SMTP id ne15mr1144503pjb.181.1588872151539;
 Thu, 07 May 2020 10:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com> <CABxcv=kTL_grDUL00c_e2jyPD4hTtFS8Jze6pQBEz_arR6TPVA@mail.gmail.com>
In-Reply-To: <CABxcv=kTL_grDUL00c_e2jyPD4hTtFS8Jze6pQBEz_arR6TPVA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 20:22:25 +0300
Message-ID: <CAHp75VfuKJXz1QO45gDcu1YL_jJy2oz4==zVgsT+2GoLkkm7zQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Export LPC attributes for the system SPI chip
To:     Javier Martinez Canillas <javier@dowhile0.org>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 7, 2020 at 8:06 PM Javier Martinez Canillas
<javier@dowhile0.org> wrote:
> On Wed, May 6, 2020 at 5:52 PM Richard Hughes <hughsient@gmail.com> wrote:

> I wonder if these new entries should be documented in
> Documentation/ABI/. Or maybe that's not a requirement for securityfs?

ABI must be documented. There is no exceptions.

-- 
With Best Regards,
Andy Shevchenko
