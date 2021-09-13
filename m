Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D29C433EF
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 23:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29CD60EC0
	for <linux-security-module@archiver.kernel.org>; Mon, 13 Sep 2021 23:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbhIMXtX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 13 Sep 2021 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbhIMXtW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Sep 2021 19:49:22 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEAC061760
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 16:48:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j13so16865515edv.13
        for <linux-security-module@vger.kernel.org>; Mon, 13 Sep 2021 16:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHteEWVAZLt0OaBtiwLU1pAl1Ek5T6z635cI8YpKSSI=;
        b=YJTK7efG4Mtv3PAk/JgStkogskGHLYDKrcfP9BC2F+OS3HdrsyrPXxGn4a7OqCk9xH
         HJnf3f3PYl0utfAMttI/hepD0cH785+DFRDiyHvVJHcb9hl/s9oUOMlEQO0bx562kYkp
         gBdHDPvk4mcICm8Rv4dQiWWNWwlME3M7DmsJ4EeKK9KU//OxxPMIbzQtvq5azlwJBlPw
         jzbOQ2DUawDvWdnkb3KfucY9A7K17bxLOd/IZxnkl91rf1AcLion1a+fBY4H59QHFf7R
         WsmrYXCCm5XC73QpPJ1uFdT1CK8+8xMssJExjvuD1jPcX/EJuqeJFl+6Y3sCEo32yaHA
         hUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHteEWVAZLt0OaBtiwLU1pAl1Ek5T6z635cI8YpKSSI=;
        b=6B+E5aUiWw8WuD8MyLEEhO8vfMwnaViVB7WsbvBoGahgFkKqDNtViutIcNEtV5PU82
         55/1vM+4iAuToFJwsnuxp5wV6JDsxsMaM0AkqIoagTm0kfDtYWySYRa2TP+G7FwQnkJt
         5qCD3QjOdVA43hXs3xvyGrv2C0KV2GCPu5EPeMM2fBqfVSq8DFxg4gYxoVBymUjJaWVl
         ybE7Be0bRdMB0upiZblphwZGssZB0vFZbh/ypQFWiefXE9j7uJFX/oDIrstz1tvV8rgh
         49x8u4pZsehuCqlbU8A/WVc/DfwahnK/N4L/FWBWw/EbWrfdrsRn1QLz8z/tF4367/Hs
         1uKg==
X-Gm-Message-State: AOAM531r4ntCG5KxGTSwmgY7pJEiXnK372lQc/QrRXHQFqhgTnwM+Lhm
        3Ynk9mUp/1YBfyGWWcTbxhwFKfu2z0Aw3bBF9PKFvnuteg==
X-Google-Smtp-Source: ABdhPJyTx4j9C5z7itSxBMb0ywnCVLrM09iZQDbyMJBj6xbfFQiRVOym1cj8gF+MLuypO+vpifw0tvCyHL7vtrwaNpw=
X-Received: by 2002:a50:ab18:: with SMTP id s24mr9061810edc.88.1631576884555;
 Mon, 13 Sep 2021 16:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <a507efa7-066b-decf-8605-89cdb0ac1951.ref@schaufler-ca.com> <a507efa7-066b-decf-8605-89cdb0ac1951@schaufler-ca.com>
In-Reply-To: <a507efa7-066b-decf-8605-89cdb0ac1951@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Sep 2021 19:47:53 -0400
Message-ID: <CAHC9VhR9SKX_-SAmtcCj+vuUvcdq-SWzKs86BKMjBcC8GhJ1gg@mail.gmail.com>
Subject: Re: Regression in unix stream sockets with the Smack LSM
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Jiang Wang <jiang.wang@bytedance.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 13, 2021 at 6:53 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Commit 77462de14a43f4d98dbd8de0f5743a4e02450b1d
>
>         af_unix: Add read_sock for stream socket types
>
> introduced a regression in UDS socket connections for the Smack LSM.
> I have not tracked done the details of why the change broke the code,
> but this is where bisecting the kernel indicates the problem lies, and
> I have verified that reverting this change repairs the problem.
>
> You can verify the problem with the Smack test suite:
>
>         https://github.com/smack-team/smack-testsuite.git
>
> The failing test is tests/uds-access.sh.
>
> I have not looked to see if there's a similar problem with SELinux.
> There may be, but if there isn't it doesn't matter, there's still a
> bug.

FWIW, the selinux-testsuite tests ran clean today with v5.15-rc1 (it
looks like this code is only in v5.15) but as Casey said, a regression
is a regression.

Casey, what actually fails on the Smack system with this commit?

-- 
paul moore
www.paul-moore.com
