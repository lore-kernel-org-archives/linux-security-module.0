Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC75C388F7
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3DA920809
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 18:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bb7eV6Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJSfO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Nov 2020 13:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJSfO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Nov 2020 13:35:14 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E2CC0613D1
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 10:35:14 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id x20so13130358ilj.8
        for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2020 10:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcW7DGdRYPQre9d0rCuZTVN2xdKVZeP/11KAhpcdeGQ=;
        b=Bb7eV6Ffk30/lADN/CtBQNkUYKmIlGDuP5HgNdb7lko796qK+rPQAotrkNWYHqh5li
         76lujpo108QS9f8ZA53B/idZGNhYqH00HMORfhYexedWrdx5jeraYbXN85UdToL1n61m
         IXglx2VBB8XZji5DYomCSjDtBhqN1MWHhxeV45Vcu9otTPkCVMr1FltZPW9xNky0VTxe
         eidiazNZla3CPfk22mus83C/TSQMvzGRSvriokLQ2ZvS7v32J3z3Ya8r+ie53hSa28FI
         8fZZe6y7gGahOslzrH1tnScTCa70j4VkRQXPfrdq0iSAJpfxAKuXo/t9AkMgD2bWLkOH
         15Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcW7DGdRYPQre9d0rCuZTVN2xdKVZeP/11KAhpcdeGQ=;
        b=pFoopt0CXGow20y4sACZ1uvmiYxUSM6iG8wiMc9M3rTCYNorfVVCt+fnXkXw7bEL6i
         EUdoVRLl+npSBTl97HtwB1/OJkh9gSC7O/gawyjpTzHUpAG5majqdmWWveL0QBIPVAMm
         Td34nnYW4gxk7+ONE++emfd47fC96UMFpjq/WBzRMclVs6mGJo6R+6+wPVB57gR8RrFs
         UntZWRoctiH0u4mrxkT3yANdIar+rpmOjeg2YrvsPqCfG31to7e5A8sfQbfemA3aE28g
         lNjdPzUk3MQPCy4YhefIbZ2WKz2kKey+KhK0qjOzYpkgqhpEdoXhLlCbytNy/rRsC4Vo
         WNaQ==
X-Gm-Message-State: AOAM531zGYtT8d/HMYUxy6SWH5bpdbcVzEINEJrOYCK+vm24Hu+T+323
        yYkU8AWOUzWPtC6m1xXXVByuULP/B3SHVkfsxApuKw==
X-Google-Smtp-Source: ABdhPJwW0NyVtuugVDLRW5lkeqwxCPGA/28xMTg1/Ar0AmTrISyPlZ7xPsV/9rqOwGigTwHHYFH+KXQJDnsmstuQC0o=
X-Received: by 2002:a92:6504:: with SMTP id z4mr14758818ilb.282.1605033313560;
 Tue, 10 Nov 2020 10:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20201029183526.2131776-1-aleksandrnogikh@gmail.com>
 <20201029183526.2131776-2-aleksandrnogikh@gmail.com> <04d8c32a-06cd-d71a-43d9-47b1de6c7684@i-love.sakura.ne.jp>
In-Reply-To: <04d8c32a-06cd-d71a-43d9-47b1de6c7684@i-love.sakura.ne.jp>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 10 Nov 2020 21:35:02 +0300
Message-ID: <CANp29Y5USTozWhFjaBBCwEQJf8Ape2ivNK1zSpySJW_PT1H7Bg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] security: add fault injection capability
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Aleksandr Nogikh <aleksandrnogikh@gmail.com>, jmorris@namei.org,
        serge@hallyn.com, Akinobu Mita <akinobu.mita@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 10, 2020 at 7:43 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
[...]
>
> By the way, fail_lsm_hooks.retval is "signed int" but debugfs_create_u32() handles "unsigned int".
> Do we want to allow lsm_hooks_inject_fail() to inject arbitrary !IS_ERR_VALUE() values?

Thanks for pointing it out. Technically, now it's possible to set a
negative value - internally, the kernel
will process negative integers anyway, and after casting the unsigned
value to a signed one, retval
will contain exactly what the user provided. However, if the user
retrieves the attribute value, they won't
get the exact value that was set (if it was negative).

I'll change debugfs_create_u32 to something else in v4, so that it'll
be more explicit and so that it'll be
possible to read negative values normally.
