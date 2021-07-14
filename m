Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCBEC47E48
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55CE760C3D
	for <linux-security-module@archiver.kernel.org>; Wed, 14 Jul 2021 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhGNVr4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhGNVrz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D9C06175F;
        Wed, 14 Jul 2021 14:45:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q10so3206440pfj.12;
        Wed, 14 Jul 2021 14:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ecMCBD0DRX8i6ceCMBbDcAoHrM9zIxqgKO1lRrTFgA=;
        b=ZU1rg2kxF1xhpB09DWxWH4ZRjGXZTX9WF60dLpoChO4lv7ueN8II8Rohp5s90/BTRe
         8a5l2kCFNXFmCY/eD1S7M9HhUknYtZNpSBpfQ1qfAhh0yQKHtfUxl8h0ojNACKkvY0bz
         J1YnxNKCaYzIzEXgEeYA79d2sONF4bQtGwIjil4PeQDj7aHhhjXhAdsyBXJG4sGIP5TT
         bPUdfZVLoCf5s3OuKPh2KQvJDm/fdyHT8jIuU1lyS6HMYvHxcS7KWFGBenCpK7KXDuDi
         t+VbQwLsgKkExDC3PD3pv4KLRSJYBVoDaX2DjoSj07tBkqcLnuIbQGX1dmjh6h4RTBEC
         +eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ecMCBD0DRX8i6ceCMBbDcAoHrM9zIxqgKO1lRrTFgA=;
        b=Nnnesi9AUps0lp2aZOEDMGhp5NQrNykvMTrJUg54qQWmGSd+ooP4iVtlV/4g7NB+DM
         9XNTBI27yAvSIVyIkQ/nXGrkBY6Fhl0Y0R00D3+2P4TZIgdlqZXC4uRD3ZvUMWtOO5wC
         MNhzC+mb2Kb1s4a24UqvXWC/ZXpB6KYUnJZR2kHTOoqizAc7W17suM23d+Tsejz8J7iG
         kHgVZbWVXyH8azEZJlzM5+ylyxH2yztPodMWZHfpZgJ65bIvqaL4udyv1lbH8UKsdFfg
         U7fCPxeoJXsN07gBjuayO5hF+YmA3RVuoF0JOTlqwsWXvZFCNTYs/tX5ktd3FcEyCboM
         t0sQ==
X-Gm-Message-State: AOAM533LxLSp/fKvXpEdJIyGXjBE7biq4DOlckXBzv2P9JGC69CZ0KBN
        T+8JL0/3g7z9TZgYAPf3S25KnNQlCx3cIE0iL0A=
X-Google-Smtp-Source: ABdhPJyHP9qOXZGGjYLNzUYOXa+IYsiRjHpSR1L7qfsw6lFcTuGCybzVDU32v4snFsCu3o4uuFYO7tTrWLx3Fffne/Q=
X-Received: by 2002:aa7:81d8:0:b029:308:1d33:a5fa with SMTP id
 c24-20020aa781d80000b02903081d33a5famr51074pfn.55.1626299103098; Wed, 14 Jul
 2021 14:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210712234434.GA29205@raspberrypi> <e0a2655b-3bc6-fd45-bd84-8df2dc6bc5f@namei.org>
In-Reply-To: <e0a2655b-3bc6-fd45-bd84-8df2dc6bc5f@namei.org>
From:   Austin Kim <austindh.kim@gmail.com>
Date:   Thu, 15 Jul 2021 06:44:52 +0900
Message-ID: <CADLLry6RmSDuB4nmVKDEiqxXmEU0xrhMn2wieuuVTypMWqc4cQ@mail.gmail.com>
Subject: Re: [PATCH] LSM: add NULL check for kcalloc()
To:     James Morris <jmorris@namei.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?6rmA64+Z7ZiE?= <austin.kim@lge.com>,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

2021=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 4:12, J=
ames Morris <jmorris@namei.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, 13 Jul 2021, Austin Kim wrote:
>
> > From: Austin Kim <austin.kim@lge.com>
> >
> > kcalloc() may return NULL when memory allocation fails.
> > So it is necessary to add NULL check after the call to kcalloc() is mad=
e.
> >
> > Signed-off-by: Austin Kim <austin.kim@lge.com>
> > ---
> >  security/security.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 09533cbb7221..f885c9e9bc35 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -321,6 +321,8 @@ static void __init ordered_lsm_init(void)
> >
> >       ordered_lsms =3D kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
> >                               GFP_KERNEL);
> > +     if (ordered_lsms)
> > +             return;
>
> Your logic is reversed here.

I feel very sorry for my terrible mistake.
'if (ordered_lsms)' should have been 'if (!ordered_lsms)'.

Let me resend patch(v2) soon.

Thanks,
Austin Kim

>
> Should this also be a kernel panic?
>
> >
> >       if (chosen_lsm_order) {
> >               if (chosen_major_lsm) {
> > --
> > 2.20.1
> >
>
> --
> James Morris
> <jmorris@namei.org>
>
