Return-Path: <SRS0=bVIv=RK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB84C43381
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6035B20675
	for <linux-security-module@archiver.kernel.org>; Thu,  7 Mar 2019 00:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljG3pXDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCGAMb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:12:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52046 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAMb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Mar 2019 19:12:31 -0500
Received: by mail-it1-f195.google.com with SMTP id e24so12577563itl.1
        for <linux-security-module@vger.kernel.org>; Wed, 06 Mar 2019 16:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezOAVi/+85xQ0cQ5uMUhyfKczC6Zcgc3Xf7/a9KMpt0=;
        b=ljG3pXDvh/JGlXb3cfYGf7sz7TnKMIjIB2DmSLlmU4D2ZQAv8s7NDzdS4aQBZGn86v
         mCgxEM9mHOTEdQdE/50dDMpay9ORCxGyAK2BysihUw4ExkoZ3p7gP9WgIVNSeau8yxal
         gkMfi9530MJUOaAFOjZYghkIFxSptRTN5A+bVA893Jt3QXt3WYZh2nBZCs/9NDpVVmS9
         vOU/GNvfMQC+iAaUB6UByNG/g91jxSIFx8JU0gkiT8DPDcjAOpCuJRd45k/h6cMatOAg
         fs4YQFp9ZOewTRxHvKVRtMIRe4LhaFf2XPaCSkU77PhKM6vB26g7SxgUrOjvYWJ6U1fW
         2YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezOAVi/+85xQ0cQ5uMUhyfKczC6Zcgc3Xf7/a9KMpt0=;
        b=lnpF6R+3kn5buRBLwMff0yv9npvC8QZoDzmxBvB9UJqwHaVR9oJwNCKwRCTr8mbjGU
         JkSpYS8vpDBl0AtTXFnWYkL0niPPg0wmYQDGl1sOVUEYlpL5RhL1Yczxyo/AqHAveMVx
         +3Fb3R6GM4sZoe1M+zqinWOXLFjoEf3YxvxKK5rrCbFfZQds/Xc8CC30SLsAV89UymPO
         BrRJxMVPrHwQTuopMt3IrGVTghdq9Sjb+z3jSpY7DqNPseE4s5DCwc3cAsuqOb/q41fZ
         Tn4EQmi7uSIHUliMvD228eaSOsEYe0GBrKDs6UL9UhHyR2juh8WsVedt2jWr4nqTuD1W
         gtFQ==
X-Gm-Message-State: APjAAAU7RwYC6WI6Y09l2Zwl3vosKWel4Kgnw9LW3/Ua+EZxzYE8/WVw
        y/GdN4LCB90SvX0ol5MWlF/IcTefm8YL7rIK1IcNwA==
X-Google-Smtp-Source: APXvYqx+7BfFRYc9FIjPhKRtXKZBgJQQsl/EUB+DtnJOMAbPmXfyRM1JLwSZZfHZsIewZi7pN1cOctBHJ5j5QRGtF8s=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr3942607iti.161.1551917550566;
 Wed, 06 Mar 2019 16:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20190306235913.6631-1-matthewgarrett@google.com>
 <20190306235913.6631-3-matthewgarrett@google.com> <7bcd6149-332d-15f8-31e1-ef0a6b7f496e@infradead.org>
In-Reply-To: <7bcd6149-332d-15f8-31e1-ef0a6b7f496e@infradead.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 Mar 2019 16:12:19 -0800
Message-ID: <CACdnJuuxAM06TcnczOA6NwxhnmQUeqqm3Ma8btukZpuCS+dOqg@mail.gmail.com>
Subject: Re: [PATCH 02/27] Add a SysRq option to lift kernel lockdown
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     jmorris@namei.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 6, 2019 at 4:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 3/6/19 3:58 PM, Matthew Garrett wrote:
> > From: Kyle McMartin <kyle@redhat.com>
> >
> > Make an option to provide a sysrq key that will lift the kernel lockdown,
> > thereby allowing the running kernel image to be accessed and modified.
>
> You still need to document this in Documentation/admin-guide/sysrq.rst,
> like I mentioned last week.

Hm.. On reflection this patch doesn't make much sense without the
automatic lockdown enable functionality, so I'll just drop it from the
patchset instead. Thanks!
