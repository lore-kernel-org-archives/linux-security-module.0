Return-Path: <SRS0=3eDG=QE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0EAC282CF
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 22:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679672148E
	for <linux-security-module@archiver.kernel.org>; Mon, 28 Jan 2019 22:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bG3QcuDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1WdY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:33:24 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35738 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfA1WdX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jan 2019 17:33:23 -0500
Received: by mail-yb1-f194.google.com with SMTP id 64so2991635ybs.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jan 2019 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1RPKRUV2AU4z/ZEGpXMul2En7X+8ucTqjgs3T7MuKk=;
        b=bG3QcuDCLcExcnd5oXGm80993j03M0/qB/r7IUP76DABlt4mDxYTL4c4GiUAzjvISD
         27znRZBw+zwxOkuQReeMBXk+ifmOcJTt1ZmmD26wph/H1BoGXxLL2UgHKqQhpXCc5ECU
         2q2JY992MNeqgjY1f4xPSkObZkIN/HP2ygu8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1RPKRUV2AU4z/ZEGpXMul2En7X+8ucTqjgs3T7MuKk=;
        b=tAzkC1Y0aq1Nea+qFPIws4qsSJThaxtOK/cdJ9rvx9Yt50HZU9uFhsCj+RU/Zy6BHP
         cjK+hcc3WUkwP2t7iCiea5jL4p+zOzNQhZO+vqJk7ACRjbkXiy8yi3AYn7PILPrsUPYo
         NfL6XA7sx6OxZaOhMh/0Dg49oivcUBHP/kB5bf+SE4iNP+TouzvEMENFku6LsdfB1S/T
         AIFGrZomZRjkNeNm6H8xZ/1BjugnmNblVn0NzZDad/CQ0sFPI7rfRUpSw8X9++jWmW82
         6W1M7pf2zrY4RG9SJ1IOg073C8UuCkYxxqwjJcWEQ/dgTwZ5qHw2FiZoH+HViv6+puSE
         XzUA==
X-Gm-Message-State: AJcUukdVpMKJSpMZvm2N4zL+hQxcf6D43YMI5gs2S/OdOAnczLB5LXNz
        QVs5HM0m+suC5WKIBbTuX5/rlPihsCkY75kV9+VgLg==
X-Google-Smtp-Source: ALg8bN4dmnQ9pzrT5adKFtK2QwJTsi4lq/3bcY3KCNQO2D3JfRGqMbj1HreK6uHdnpB9Ig3PgtbRR9dAai/O/CUnDkc=
X-Received: by 2002:a25:35c3:: with SMTP id c186mr14274696yba.464.1548714803112;
 Mon, 28 Jan 2019 14:33:23 -0800 (PST)
MIME-Version: 1.0
References: <CAGXu5j+V61YOk7oAEw3Fm5rOxQAmy2-3QqOZaOP_FROLBUk2Qg@mail.gmail.com>
 <20190116154606.92331-1-mortonm@chromium.org> <alpine.LRH.2.21.1901260714380.27585@namei.org>
 <CAJ-EccMc3Xz0DZAm_u09VvTzWRzhrf9x0SpJKX=4FR6NYwqkpQ@mail.gmail.com>
 <CAJ-EccMAb-OX3R6mk4me0x6dS2bQw=yZrpKmF7JpzHDWSX5e4g@mail.gmail.com>
 <CAGXu5jKLdcadm30NwpquX1iGJRsjZY-A5grc65BC64B96RE_Eg@mail.gmail.com> <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
In-Reply-To: <CAJ-EccM3BzUUS0CZuhAcj47+KR57JwvhLWiQoc86LWb87wWBcg@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 28 Jan 2019 14:33:11 -0800
Message-ID: <CAJ-EccPpb_544TgW3YtcT=ptGDwTxx=KOMBdLtqUNim7ynuCdQ@mail.gmail.com>
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

FWIW, I've now done a manual test of this LSMs functionality on a
Linux VM built from the next-general branch. Adding policies, policy
enforcement by the LSM, and flushing policies all worked as intended.

So there hopefully won't be any more surprises.

On Mon, Jan 28, 2019 at 12:19 PM Micah Morton <mortonm@chromium.org> wrote:
>
> On Mon, Jan 28, 2019 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 29, 2019 at 8:47 AM Micah Morton <mortonm@chromium.org> wrote:
> > >
> > > I'm getting the following crash when booting after compiling a kernel
> > > with this LSM enabled, so I'll have to figure out what is going on.
> > > All the "core" functionality of this LSM has been tested thoroughly
> > > (we're already using this LSM on ChromeOS), but looks like there's
> > > some debugging of the initialization that still needs to be done.
> >
> >
> > +DEFINE_LSM(safesetid_security_init) = {
> > +       .init = safesetid_security_init,
> > +};
> >
> > I think this is from not having:
> >
> > .name = "safesetid",
>
> That fixed it for me! Thanks
>
> >
> > I missed that in the review, sorry!
> >
> > --
> > Kees Cook
