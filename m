Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1275C4332F
	for <linux-security-module@archiver.kernel.org>; Sun, 12 Nov 2023 01:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjKLBY0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 11 Nov 2023 20:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjKLBYZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 Nov 2023 20:24:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC930F9
        for <linux-security-module@vger.kernel.org>; Sat, 11 Nov 2023 17:24:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50930f126b1so4258561e87.3
        for <linux-security-module@vger.kernel.org>; Sat, 11 Nov 2023 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699752259; x=1700357059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=RcDPHGJHHOOgJZH/wHy6xVxdE2Wmqqk3yma9riLo17z/yv0Lb1uJuXkpImxDPr2hrp
         /18vySr5I6h0DiUMsXlrAuSF0THo/xYorncYJ4Cuftk+nZgMXSWuml0r9X5pU77THFA3
         mFTEkuh7w+nuxLswj8TKIUm+e2wsv4xac0qqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699752259; x=1700357059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=OinZiORqoIYqglVJKz9rtnSjM9zlMcAPkbBsDKMVtkFGiGP/8EtYypAWdkL8bETHqT
         hEs+PbSE52q8dDEqFVCTB/VMAOxVOQtbvsXYsxXXYmrrb3v0DFJ9AFksLiPqWHF6BHxa
         h6D167scgG2/7FpfO771hv6Gw02oio+UhxCRoPYr6T/JLg3wx/f5MWlTtsgUOKqQ5boX
         zTY5kn7YnvQST2xsHAlqn+HxgGsHvj/zWnHvS0cA+TjLXLEoDbOto9fz9Y0iw1g30xDD
         cPjZ7BG1cghRiGQRUhzqwlv1Mh2dVIZKNe8LSvW/9Lg1i8Bdtjc4lU27j0tIip+C2Vip
         f+bg==
X-Gm-Message-State: AOJu0YyF/MFSuKHxVgqiMf8l8bbViidLPtsQZotq2Z7zEVm+PErmTVRu
        I72rPblIoIArmjaT1LglnqMuYTuBnh3PZagdIvKl+A==
X-Google-Smtp-Source: AGHT+IHnTi1+BYyLDAVDn3vnx2oWx0hMulbVfnALfXPvWkKi1ljHHWSJKeL8fzmHgcmTs/poDb0DIg==
X-Received: by 2002:a19:e047:0:b0:50a:5df2:f322 with SMTP id g7-20020a19e047000000b0050a5df2f322mr1919200lfj.13.1699752259134;
        Sat, 11 Nov 2023 17:24:19 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b00533dd4d2947sm1662284edj.74.2023.11.11.17.24.17
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 17:24:17 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso5046201a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 11 Nov 2023 17:24:17 -0800 (PST)
X-Received: by 2002:a05:6402:138f:b0:53e:78ed:924d with SMTP id
 b15-20020a056402138f00b0053e78ed924dmr2051608edv.5.1699752257302; Sat, 11 Nov
 2023 17:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com> <20231111132431.GA3717@1wt.eu>
In-Reply-To: <20231111132431.GA3717@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 17:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     Willy Tarreau <w@1wt.eu>
Cc:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
>
> IMHO it does not make sense to add a syscall for this, please have a
> look at prctl(2) instead, which is already used for similar settings.

Honestly, I don't think it makes any sense at all.

If the key manager people can't be bothered to keep track of their
keys, the kernel certainly shouldn't be bothered with this kind of
huge hammer.

It looks like an active DoS attack to me, by anybody who just creates
a huge process and then sits there giggling as the machine comes to a
complete halt, with the kernel busy zeroing pointless crap.

Do it in user space. And if your user space randomly crashes, you have
other problems - but you can try to use ptrace to catch even that case
if you care.

          Linus
