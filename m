Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387EC7EE30
	for <linux-security-module@archiver.kernel.org>; Tue, 28 Feb 2023 00:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjB1Ao1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjB1Ao1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Feb 2023 19:44:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A031F5E4
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 16:44:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq23so33415021edb.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=RsHw/7bf2AWfHNjtJ5v/u3oBO4UVqyim+ZjyJHLVumO0yRgL8CyxfZSuOL1XDP6Ldz
         Mk5/x93eWLTNfo4rz2SYFy2S+wQKxVb8wycJD0kYjCMYV0wBFG3sWqRWJua6C8NSggwB
         2aTMW/W28IYwMZGy621QeKOe4FJHunteyMmgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VmmBrX2p1inGbF8ku+z06Eh1CWxuqZx/wcts3IMRaQ=;
        b=gCEISc2quaWg/uw4pPuYs36lO8z3gX5BIzNa273Z7DQz52n43ShH/mILkJ/uhZs4cd
         Go8Wl6dfNRhHbPHQPr7wRd361MbEyfeTAbo37VbrRAC+p62ZsuFFHtbQ91saR46+ecAy
         q8TfaUh/5a1NchflDNxmtOlEzFK7royERea31dj+Xx1GOr1n8t4nfUWuqipo/OhzN69w
         m0F6+8079UB2/X7Tq+H7UOJDKRt/uKTQufuRhbipnhMGjWa0e9+2ykyVcxVcNfwUXLsc
         yl/ZUXqL5IXbat/6re6MQvTnSyV6+MvqJY96351DS9gDSeuvfqlNxHrQU+o3nC39gOa+
         On7g==
X-Gm-Message-State: AO0yUKX2JnpjVXBwy/mKoG7rVp/pCj0ls1UpIPNnU659p/KdvX8ZhubD
        4kTFiPntO4mEO4lB7UXJzp8owuS3t0xOwPuWz0c=
X-Google-Smtp-Source: AK7set9FKjfGSnrHUDlZUmrmVJxuMzcqL+/DP1+EV5MujUs2zyTn07hmi6mO1kXx7iPDAkoS8E/jGA==
X-Received: by 2002:a17:907:a048:b0:87b:e105:5d9a with SMTP id gz8-20020a170907a04800b0087be1055d9amr552604ejc.67.1677545064209;
        Mon, 27 Feb 2023 16:44:24 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id s25-20020a1709066c9900b008d5183c1e20sm3799240ejr.190.2023.02.27.16.44.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:44:23 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id f13so33292644edz.6
        for <linux-security-module@vger.kernel.org>; Mon, 27 Feb 2023 16:44:23 -0800 (PST)
X-Received: by 2002:a50:bb41:0:b0:4ac:b616:4ba9 with SMTP id
 y59-20020a50bb41000000b004acb6164ba9mr736894ede.5.1677545062838; Mon, 27 Feb
 2023 16:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <20230125155557.37816-2-mjguzik@gmail.com>
In-Reply-To: <20230125155557.37816-2-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 16:44:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Message-ID: <CAHk-=wgbm1rjkSs0w+dVJJzzK2M1No=j419c+i7T4V4ky2skOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 25, 2023 at 7:56=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> Turns out for typical consumers the resulting creds would be identical
> and this can be checked upfront, avoiding the hard work.

I've applied this v3 of the two patches.

Normally it would go through Al, but he's clearly been under the
weather and is drowning in email. Besides, I'm comfortable with this
particular set of patches anyway as I was involved in the previous
round of access() overhead avoidance with the whole RCU grace period
thing.

So I think we're all better off having Al look at any iov_iter issues.

Anybody holler if there are issues,

             Linus
