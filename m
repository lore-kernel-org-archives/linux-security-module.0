Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14077C282C8
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00282171F
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 20:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FZA07DX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfA1UTq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:19:46 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38563 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfA1UTq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 15:19:46 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so7277628ywb.5
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0RoEbehmxQIYiHZUqjNeZ5YNr/WroLHwd8LB4/ek44=;
        b=FZA07DX4SqqxUIae6bgIQarCb0gfcmtcNDY0PLzc3b6Q89o+vBGxnOasQyH5M/5Pbq
         UKkkuQ9i9wounpWf1oIXx6HZDY60gYKw+MyvGzDk1LKFIWFQ0nYfcXxc64XesCqNFunA
         4W5AUfWCI0ghw0RsvdXQAO/5o4Gt2xezk38vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0RoEbehmxQIYiHZUqjNeZ5YNr/WroLHwd8LB4/ek44=;
        b=APX3KaLKdY3vgyvLKmxSG0zMMCVBrN/kbmV9W7v3wNBzGpT0TZlWhZD411LgQLsrrQ
         bRjAGYmCyqglW4vsVJY1EBYUNZwTgX6FTrSudcKbEGdyBnz0eCBrd+GLABKVTG1N9bHY
         QMCX6K4xjM+S76qlzxGEEsfa57ioUgXMVBzi12ynVWp/nRjV1xp2VA77TasUWT4WlRbn
         SuOMdpdvgroDDGgnKoPjjnTJfT7x5x7vrOQzqpM2X3EaBQLfi5m9sXreeVtAq3sGe+cY
         Q2jLkI5HowVLpZXRk6vsuWGMoqR9mu4x9KEo22V/9Ya3aTA2UukzWYkYWNjVTaQ7m9pU
         ITfQ==
X-Gm-Message-State: AJcUukceiwDOV5+FotDV4r/8t/y98HkIe7f8v8j+7TVydKnUf8dZLgcS
        4kXciX7TJmHg+vafFlPKyMY8tV7DJX6jOY8j+mgxMQ==
X-Google-Smtp-Source: ALg8bN4dUdJJPH57ZeONz/ZmBxJ7idsWGDwiUr9ImRJZxaqofs8H3QImVh4dawd8mbxw3sl6+WFRcOJmEpxort9I90o=
X-Received: by 2002:a81:b61a:: with SMTP id u26mr21867488ywh.428.1548706785501;
 Mon, 28 Jan 2019 12:19:45 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
 <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com> <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
In-Reply-To: <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 28 Jan 2019 12:19:34 -0800
Message-ID: <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] LSM: add SafeSetID module that gates setid calls
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 28, 2019 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 29, 2019 at 8:47 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > I'm getting the following crash when booting after compiling a kernel
> > with this LSM enabled, so I'll have to figure out what is going on.
> > All the "core" functionality of this LSM has been tested thoroughly
> > (we're already using this LSM on ChromeOS), but looks like there's
> > some debugging of the initialization that still needs to be done.
>
>
> +DEFINE_LSM(safesetid_security_init) = {
> +       .init = safesetid_security_init,
> +};
>
> I think this is from not having:
>
> .name = "safesetid",

That fixed it for me! Thanks

>
> I missed that in the review, sorry!
>
> --
> Kees Cook
