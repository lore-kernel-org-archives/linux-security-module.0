Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34981C433EF
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 13:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115F560524
	for <linux-security-module@archiver.kernel.org>; Tue,  7 Sep 2021 13:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbhIGNIF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344609AbhIGNIE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Sep 2021 09:08:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D976C061575
        for <linux-security-module@vger.kernel.org>; Tue,  7 Sep 2021 06:06:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bt14so19575195ejb.3
        for <linux-security-module@vger.kernel.org>; Tue, 07 Sep 2021 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4oWWGov+bkftJWApz4guBbjvDk1FzTK4dXqUmqhsGo=;
        b=rnSIxm8cJRcatY6H7Eo6xNBmKdAEFiSjwDRpe1p581pHp2njaMR21jCJhp4BSa6AF9
         sdAlWMYna02+u2ELL6Dy9FN4vDBj1NbNoYRcvx7YrBG60NFQBZTkEkJkVB02YtmUl49u
         GlpTMTsuwJOd3+A4KMoTcJQE2njez1aT+nZbbWyHy3rE+DzcGRsL1uChH1WXPA3vVecs
         wpU53lPC5zPSWTm1g09vm2+9YVOWzWWPLoZh+1GyxgAox4HcOZudkDV2WBP6hHp75FVG
         T1WQdjvUc/J8teTsE4S6db1q46Vn+Zvjzy9m6ghat29UvFjY9ZQI2hgX58E499q6xR7Q
         1WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4oWWGov+bkftJWApz4guBbjvDk1FzTK4dXqUmqhsGo=;
        b=f79fEK5LQYkoErGoFTaf5gV7ejrFT81rE2XNJXhYnw/CgQNWi33FJgz4P/jQOHR5dm
         y7pNKAGbSBBVOVGyjXjPM26yBmuGnlh4KtGrdP4GU0RR/Osz5QlUfnnOkjhYKzFq9M/j
         xD/5us1aVyQqZZE1SybGG+FnmrmO6SfptM77XgQvaMDfMpsEIqHJUJ9LTDdItF7wieEn
         NNxk+Fmkj2xPTNEB62d1vatfZb8NtYJKeO851iJqfSUSRGDkH5c76k7mNmoyP9NZKQ9R
         rmjAFyBxu1CeFzLnMbWlm0dI7qWT/s+pmASZrwT8iGkW6CRm6klNSoRrwtU2DXMKfXCO
         RbBg==
X-Gm-Message-State: AOAM533BbpL2jXGm4SEev/kSKkdjJUWjmZyHGGqfYHeZmp3eH+KXPE8d
        5ki9UgiyUw38VsTxIyn8ah2eA1iXh33fVoka8uxV
X-Google-Smtp-Source: ABdhPJwDAmt2hGxT5ZkcZv9YGnSEohNbSITnIOxntCgMm5mnhtxhhGJHKQSwvGW7B6b8gVrXH65MjjesrNwq98dkGuI=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr18352630eje.341.1631020016659;
 Tue, 07 Sep 2021 06:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210830115942.1017300-1-sashal@kernel.org> <20210830115942.1017300-13-sashal@kernel.org>
 <CAD-N9QUXXjEMtdDniuqcNSAtaOhKtHE=hLMchtCJgbvxQXdABQ@mail.gmail.com>
 <CAHC9VhTjFMw111-fyZsFaCSnN3b-TuQjqXcc1zVu2QTTekTohw@mail.gmail.com> <YTS96ql9DzxpYpnl@sashalap>
In-Reply-To: <YTS96ql9DzxpYpnl@sashalap>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Sep 2021 09:06:45 -0400
Message-ID: <CAHC9VhR_eHxS9HFGx1QwRj9wqcmcg5794cCJ8QXKsbGA1+QELQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 13/14] net: fix NULL pointer reference in cipso_v4_doi_free
To:     Sasha Levin <sashal@kernel.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Abaci <abaci@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Sep 5, 2021 at 8:54 AM Sasha Levin <sashal@kernel.org> wrote:
> On Mon, Aug 30, 2021 at 10:20:22AM -0400, Paul Moore wrote:
> >On Mon, Aug 30, 2021 at 8:42 AM Dongliang Mu <mudongliangabcd@gmail.com>=
 wrote:
> >>
> >> On Mon, Aug 30, 2021 at 8:01 PM Sasha Levin <sashal@kernel.org> wrote:
> >> >
> >> > From: =E7=8E=8B=E8=B4=87 <yun.wang@linux.alibaba.com>
> >> >
> >> > [ Upstream commit 733c99ee8be9a1410287cdbb943887365e83b2d6 ]
> >> >
> >>
> >> Hi Sasha,
> >>
> >> Michael Wang has sent a v2 patch [1] for this bug and it is merged
> >> into netdev/net-next.git. However, the v1 patch is already in the
> >> upstream tree.
> >>
> >> How do you guys handle such a issue?
> >>
> >> [1] https://lkml.org/lkml/2021/8/30/229
> >
> >Ugh.  Michael can you please work with netdev to fix this in the
> >upstream, and hopefully -stable, kernels?  My guess is you will need
> >to rebase your v2 patch on top of the v1 patch (basically what exists
> >in upstream) and send that back out.
>
> I'm just going to drop this one for now (it never made it in). If there
> is a follow-up you do want us to queue please let us know :)

Thanks Sasha.  The lore link below is the v2 version of the patch and
it is worth merging as a fix into the older kernels.

* https://lore.kernel.org/linux-security-module/18f0171e-0cc8-6ae6-d04a-a69=
a2a3c1a39@linux.alibaba.com

--=20
paul moore
www.paul-moore.com
