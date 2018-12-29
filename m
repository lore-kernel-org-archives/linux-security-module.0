Return-Path: <SRS0=pW80=PG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB7AC43387
	for <linux-security-module@archiver.kernel.org>; Sat, 29 Dec 2018 04:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50178218A1
	for <linux-security-module@archiver.kernel.org>; Sat, 29 Dec 2018 04:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="POdfCrQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbeL2ErW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:47:22 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40878 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeL2ErW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Dec 2018 23:47:22 -0500
Received: by mail-lj1-f177.google.com with SMTP id n18-v6so20099388lji.7
        for <linux-security-module@vger.kernel.org>; Fri, 28 Dec 2018 20:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dq+lfuIWh1P/Gp4hYiThICEmHXTujA3lNrXKZ1foSVM=;
        b=POdfCrQ7UE0Y2NTbxp161XO8XVymfUYDB/9i3WeYY2StQhKxSXYKTyKMdk/JZKtoGs
         6YiDm53DxXjVZ7ijwasBtP7eVg8Gq0T2kmg3Yz9BYKaSU+V+tmh17C5My1EAgclQ8zV1
         G24szgPzN4eCeskjAVvLbK5Z/wqTZaMDYQ5rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dq+lfuIWh1P/Gp4hYiThICEmHXTujA3lNrXKZ1foSVM=;
        b=sIat1QHcNXu4yveU8+ovE/xLNi51MnAF4A/F/EgWEG2DqtiFNaSXao1mflOW/LbWY3
         X2IsZoDr7e5G/NYJa59BN/9B46HPZBWEedZWZiG4+4CzVGiyKaNfpwcbRGCkNo0WI6zp
         q4IQpgqEcE8vTEF6VqDXuDfFObRkRAkqAVXliEZZcb1Yc3rTyzihq8iu0psGRG7szI9c
         sIGBdnFgqFNmDUN3AWTqaO6PgI92b70zFTFbJ1d9Ji9Kfm0swmilUAjX8J/3/N0xBHrW
         blpHxdYXTipS9AsVrAeqd2I6qF1ykRftQEj04xFHgHySBcR06wjIj4vHKghqNJaw7qmV
         bFCA==
X-Gm-Message-State: AJcUukdQwDJyHpPD2y7UGpgqo21ElN/+hOsGWMOb2fUHpnXHW0Uu8/q7
        LkSHQGMdAD8xl8azLMhVlwaC4oBwUhE=
X-Google-Smtp-Source: ALg8bN44VPMpofPkRACiGYni8QwU10uJVyzC53U2w39ubdBUQLGxY2j37LJJLQ+FLVOpW8lCXOPItw==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr17438616ljj.9.1546054789436;
        Fri, 28 Dec 2018 19:39:49 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p10-v6sm8866343ljh.59.2018.12.28.19.39.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 19:39:48 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id u89-v6so20076624lje.1
        for <linux-security-module@vger.kernel.org>; Fri, 28 Dec 2018 19:39:48 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr17349302ljs.118.1546054787800;
 Fri, 28 Dec 2018 19:39:47 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1812250652420.2714@namei.org> <CAHk-=wiUaA4sZ=8UnT+q6eXE29K+XGVX=kZPR6gG-Z4UhO3p+Q@mail.gmail.com>
 <alpine.LRH.2.21.1812291406530.29722@namei.org>
In-Reply-To: <alpine.LRH.2.21.1812291406530.29722@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 19:39:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
Message-ID: <CAHk-=wh4sL5mO1J+yzngonBvjO9ZwL_kA0a2e51rE9TzVjAA4g@mail.gmail.com>
Subject: Re: [GIT PULL] security: general updates for v4.21
To:     James Morris <jmorris@namei.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 28, 2018 at 7:11 PM James Morris <jmorris@namei.org> wrote:
>
> I do this every development cycle, after requests from security subsystem
> maintainers to sync to -rc kernels.

Why?

A merge should have a *reason*.

                Linus
