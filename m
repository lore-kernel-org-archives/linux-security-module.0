Return-Path: <SRS0=sigj=73=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA9C433DF
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 19:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AD320739
	for <linux-security-module@archiver.kernel.org>; Sun, 14 Jun 2020 19:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592162451;
	bh=OOnqXwNCBJ9kLzw8YsaSmckVTLZFijQ8oadVhzEGspI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fxb5eKLriLTuX0Vc1wBZ9QCtDQhonBw6D8G8fpaWfR5jDX2KD7JzB1ksYjlPFEQKz
	 +4b0W5D8EQeCCTws5s21n1XoNxsI8WAYy52f6btaQTf9RkzTzhKfavwgrMBHMwvr/g
	 gSAcrSRkUG13HUJsO+c2Zsvn9bpCNBFf6RdQpBnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFNTUu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNTUu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 14 Jun 2020 15:20:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F09FC08C5C2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 12:20:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so16622743lji.2
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkTGwKN0ehW6UgG74U5MQE/8rHA2ql2TaHXg1+0uOrI=;
        b=B86RJ5yIdsHeQw1NF5tFw3EA4BEodeMzh/BTlJMf7Hy2cC5soKyh29KcDJszKuXFNm
         9GQC3DN3W1Yyj4HAXH4pOSNrTX+5ETIIyNm2eTLHJU6AfMJp4OF6duVNkmwpqYZ7l8kr
         6DfwIL53hjj0LgWaWs+M6ny80fcmdlssZmgao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkTGwKN0ehW6UgG74U5MQE/8rHA2ql2TaHXg1+0uOrI=;
        b=p+hPBR5BzN4+l9TrOcQQsisl8xO6SaKbTNUEpETO/zgsZIvY0renVHHH9g1AZzIaVv
         mSxr3U2l4E7rDIm4pELpqPcVdmoeC8jqRggGFTECwBHqtMFw3kYnKZeeWGPB/1yAtxZX
         o7yUi1EBTs8tfJyoZZdPWQ67kRvF7kRWuHjfpYgVWN/LDGqTgeKzzgKk34Dl30WIwU++
         yVDaUlpCnXqx/uKokW3WHsk/1TXW4mzslN+ZV6RDhRb5/MhFqHHFL7iac3ZlnVbNAdUp
         xKjBtg2qxN5kfFH2hGX9ndgSvp3P0Th2wFWmd5o8E7bNm7u4JADaWXJ5yfBV7cuJ8Cyb
         k2FA==
X-Gm-Message-State: AOAM532gG5D5sca1unzaLh9CsGU6T61+tTyxU093ioh93MBrXIoOvBKg
        Jnxj2MA1JqcNie7C3fKwmZEzRqJcbNY=
X-Google-Smtp-Source: ABdhPJzj9wmGqpDRe8UqTjdRfy9wxM80HUh9GoNcBfkCYol7AwkPjB9okGrgakOxnOVkoaKtw5tDjA==
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr11989658ljc.403.1592162448244;
        Sun, 14 Jun 2020 12:20:48 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 23sm4026064lfb.1.2020.06.14.12.20.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 12:20:47 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e4so16626006ljn.4
        for <linux-security-module@vger.kernel.org>; Sun, 14 Jun 2020 12:20:47 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr12147800ljn.285.1592162446763;
 Sun, 14 Jun 2020 12:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
 <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com> <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
In-Reply-To: <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 12:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
Message-ID: <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 14, 2020 at 12:12 PM Micah Morton <mortonm@chromium.org> wrote:
>
> That said I'm a little fuzzy on where to draw the line for which kinds
> of changes really should be required to have bake time in -next. If
> you think this is one of those cases, we can hold off on this until we
> have some bake time for v5.9.

It's merged, but in general the rule for "bake in -next" should be
absolutely everything.

The only exception is just pure and plain fixes.

This SafeSetID change should in fact have been there for two different
reasons: not only was it a new feature rather than a fix (in
linux-next just for testing), it was one that crossed subsystem
borders (should be in linux-next just for cross-subsystem testing). It
touched files that very much aren't touched by just you.

"Looks obvious" has nothing to do with avoiding linux-next.

I suspect most of the bugs we have tend to be in code that "looked
obvious" to somebody.

                     Linus
