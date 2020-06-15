Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28399C433E0
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1BE2078E
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zo5ehkbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgFOQWc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFOQWc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 12:22:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B478BC061A0E
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:22:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o15so18061451ejm.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vrNNxvqzd1+6WcN18UWNnrm3SzmXd8+xL+vm2U41hs=;
        b=Zo5ehkbMWUQUNb9n3tIc5zV9ibuTmwKK3biPsJDwDAFXGbT+pEyjb5SZPDnyHTAj62
         5OlXN3u5Q1MlWMVccYeP/p46e2nsmyVmGIyJUq85kS/I3ylT7lFNXt8QTXkbVt/tM72H
         lfXAm2MWFyvoXvuiq5tn7ggY15XVP9TVWDYgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vrNNxvqzd1+6WcN18UWNnrm3SzmXd8+xL+vm2U41hs=;
        b=oHJy4po7jSzwt1NJVevCqLiu4U+25uujrP3xcE9ZYQ0w9hQ9sqVNGxdW/+h0fqnWRp
         0/XQgIQp5BAsGvvxmRqRkYC2RUmfpR+GgZ9rNJytjtvwVfgenuvYBGtRlyKzYqFtwA8e
         WTlye8Zn2SRSUykXTudRti7BL1YXpRMdKRTkr3vXL/QWa78LwGw82iGLp7BqyQoa8pNY
         vAEDF8rGbIwrGO5i88zY0OTsWFp6QHFaLz/XQVUuCtkKD2VGIWd1FwRNPZ/piFBDLSZ3
         8RnPTPx9axMJA3K4UcDf2bijyeLgVTyAsHT+fToc29p8Zb20CmKonKhoUv7Oq9xd4Zin
         LSlQ==
X-Gm-Message-State: AOAM530FdXl/p0czZg5p0bCbOG9gjqgSZMoJMVx/KHexLXakH5owyPAS
        cA5pB8eKXIwGdzAyUpr9iaFqKkSQIQtsOHK14oeP9g==
X-Google-Smtp-Source: ABdhPJx+bT/qo9gxqE/zoNAe1/BkPFy8sVFIY15o/zABl1r/0Kd+6QCAu4UjRjIvp6LUm6j//qBO9qKM9BgOO+88yFw=
X-Received: by 2002:a17:906:5595:: with SMTP id y21mr27317038ejp.61.1592238149992;
 Mon, 15 Jun 2020 09:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com> <alpine.LRH.2.21.2006151517230.9003@namei.org>
In-Reply-To: <alpine.LRH.2.21.2006151517230.9003@namei.org>
From:   Micah Morton <mortonm@chromium.org>
Date:   Mon, 15 Jun 2020 09:22:19 -0700
Message-ID: <CAJ-EccO+4s8Dd=wj75ckfp4ZLhppt7uCgg2chf4SvTOxzqbgPw@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 10:21 PM James Morris <jmorris@namei.org> wrote:
>
> On Sun, 14 Jun 2020, Micah Morton wrote:
>
> > This patch was sent to the security mailing list and there were no objections.
>
> Standard practice for new or modified LSM hooks is that they are reviewed
> and acked by maintainers of major LSMs (SELinux, AppArmor, and Smack, at
> least).
>
> "No objections" should be considered "not reviewed".
>
> Can you add your tree to linux-next?
> https://www.kernel.org/doc/man-pages/linux-next.html

Sure, I can do that. I should just send an email to Stephen Rothwell
asking him to include the -next branch from my tree?

>
> --
> James Morris
> <jmorris@namei.org>
>
