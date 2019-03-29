Return-Path: <SRS0=lFQA=SA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FBC43381
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A1C2064A
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Mar 2019 19:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6BChV78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfC2TjZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:39:25 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38957 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2TjZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 Mar 2019 15:39:25 -0400
Received: by mail-vs1-f66.google.com with SMTP id g127so1987925vsd.6
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9Ln700NNZht1VSpLwaKxuKKoPaBwgguV6ht1OCs+D4=;
        b=E6BChV783FUf4iAiTSbNCA+VG+1mDO6HcjyYS82QUHBXwppADb9IaM6ZBdkCzwsQN2
         yNTJFJADornUGuI9APaKAl6yV1/C+A0Sdrt5pAf6Ig4I+WeePepFpsjxewDC/C8XgwlD
         rY39U/xz3gwmKlW3+2P3PBMQVo/8raltWHA3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9Ln700NNZht1VSpLwaKxuKKoPaBwgguV6ht1OCs+D4=;
        b=UAbffPeUXs6nTy/gNMtNmzlfG+XKK5bxbdA4E9bNez0XgcmjuGbaR7GsVIJs3c/+Yt
         6oysbc6z+oJQQeQQBFFadJe8Q16tqAN4Ut3xyeo823qCsSSWFPQ18AQgr1etRO8uz+MQ
         MXrBg6DuuCf4XNn7/4QVbrrekHdgnzSL5N9sPa83sj1YQYy5RjPZ/g9Xs3YXGyAWiH8b
         Udywoju7O/YkI0+Yi6/MUg/5vLmp3NrwddpgEmrA0Hlb9aJT6POMPVeMF0kezljbARSM
         itAOMih7Ij89RvvdlCVOUCZg0kC1CEI+UZQfooqObyXe9zsiwVxh5bMVhq1k5pa2OFk3
         Joig==
X-Gm-Message-State: APjAAAXET2g3BaQrm3cgTfI31Ifk+/N+lskfYBHIhr5TF2JPrqp6gFU7
        80FUyi/VHRdEvL7I93Lzy1po2wyWlR4=
X-Google-Smtp-Source: APXvYqwgBU6XIDNexuA+E6BABPpXZEbmnu+4EcFprmVDFNsMVacY04cDO01Ruq/uJRrmF1DmBESjTg==
X-Received: by 2002:a67:8154:: with SMTP id c81mr30711648vsd.37.1553888363742;
        Fri, 29 Mar 2019 12:39:23 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id m23sm4048240vsl.24.2019.03.29.12.39.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 12:39:22 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id i207so1967227vsd.10
        for <linux-security-module@vger.kernel.org>; Fri, 29 Mar 2019 12:39:22 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr6131716vsc.172.1553888362435;
 Fri, 29 Mar 2019 12:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_wR2t_jLYx3=-uivpDHnGpozdhBzZOBcz3KJ=Mi-PikBw@mail.gmail.com>
 <CABatt_yJxncPXVy09j757Ff_caodTUM4S4nf399MOatQ1LdPtA@mail.gmail.com>
In-Reply-To: <CABatt_yJxncPXVy09j757Ff_caodTUM4S4nf399MOatQ1LdPtA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 29 Mar 2019 12:39:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJpnxOs9K0gbJ5zU51DE_=oRjmo8MS+-DetQR03O4G-Ew@mail.gmail.com>
Message-ID: <CAGXu5jJpnxOs9K0gbJ5zU51DE_=oRjmo8MS+-DetQR03O4G-Ew@mail.gmail.com>
Subject: Re: LoadPin old-api-denied
To:     Martin Townsend <mtownsend1973@gmail.com>
Cc:     LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Mar 29, 2019 at 11:01 AM Martin Townsend
<mtownsend1973@gmail.com> wrote:
>
> On Fri, Mar 29, 2019 at 5:26 PM Martin Townsend <mtownsend1973@gmail.com> wrote:
> >
> > Hi,
> >
> > I'm seeing the following message when trying to load some backported
> > kernel modules:
> > Mar 29 16:24:09 mach-cw-rnet-ppm-1840 kernel: LoadPin: kernel-module
> > old-api-denied obj=<unknown> pid=340 cmdline="modprobe compat"
> >
> > I have other kernel modules that were built out of tree and these load
> > fine, the only difference I can see is that they are loaded via
> > /etc/modules-load.d
> >
> > I've read through the loadpin docs and it states that it will only
> > allow modules that are from the main root filesystem and that
> > filesystem is read-only.  I've checked and both of these are true for
> > the failing module.  I've read through the source code and there's a
> > comment above the code path that loadpin is taking where the file
> > pointer is NULL.
> > /* This handles the older init_module API that has a NULL file. */
> > if (!file) {
> >
> > I'm not 100% sure what this means, but could it be that
> > modprobe/insmod are using this older init_module API? if so how can I
> > get around this, I need to manually insert these modules at an
> > appropriate time during boot?
> >
> > Any help greatly appreciated,
> >
> > Martin.
>
> After sending this I then found this post:
> https://lwn.net/Articles/519010/
>
> So I think I need to write some C code to use finit_module so I will try this.

It sounds like you have a mix of finit_module and init_module? Also,
if you're not intending to enforce loadpinning, you can also either
boot with "loadpin.enforce=0" or build with
CONFIG_SECURITY_LOADPIN_ENFORCE unset.

-Kees

-- 
Kees Cook
