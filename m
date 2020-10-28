Return-Path: <SRS0=Tuew=EE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8707CC56201
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 00:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3771720790
	for <linux-security-module@archiver.kernel.org>; Thu, 29 Oct 2020 00:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603933011;
	bh=+ZdDzdBNKbaHfui4MuF5O6NTQjMZGthQqlXfYWR4DRQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oBtBLYl9x19ytN1iT69FqotvnFrBO5QXFrzHcCEya2sv0MwMBicgeHJ/tfWRgvok/
	 d+BZKS5JsSTeIndxg6QoAd7HlS/8XzZH9L+UDT3h5Fwxc7n0fv1NgX2Bxf4a6FxszB
	 PGlQE1GiopCsrh8U1VBL/iiZC+I1vPHt8TMlhdWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgJ2A4u (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731627AbgJ1WRg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FDBF2474C
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603893460;
        bh=+ZdDzdBNKbaHfui4MuF5O6NTQjMZGthQqlXfYWR4DRQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wdnXqCAbX7zR57S749UE30A8dxHypmCw4XE+OuWGovBeUDLiWy0rm+1lEVWzJT2zx
         b2Fi/aWJYJSVWPXn8432nKy8Kt//Z17OulKjp9112UoaEgi/LYYgcazYcq2z2hPiMM
         xMy89iHMWLOW4A1DpiIp0+dvQ6MuRXLxAQmYpl4o=
Received: by mail-lf1-f49.google.com with SMTP id i6so2415558lfd.1
        for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2020 06:57:40 -0700 (PDT)
X-Gm-Message-State: AOAM5310yvNV+TzeaWDMQhWHIn6R0JYJqauD86YucqNwC0WgpKPp3Vkj
        a/En5yokBUNnTetqkeH9fplPUB5yD+7DJId7YsU=
X-Google-Smtp-Source: ABdhPJyvfULNd0KJ+iC88tvCmHLYU3hvDB4IoOkcvqBjEqXu5oPDU9JBhOHo+u9AfQvAXWM7FKZxbkRDYbXqQces/sk=
X-Received: by 2002:a19:4006:: with SMTP id n6mr2688309lfa.28.1603893458043;
 Wed, 28 Oct 2020 06:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201026215236.3894200-1-arnd@kernel.org> <7bb56fd2-ffe2-2985-19d0-31b42bc9e7e8@i-love.sakura.ne.jp>
In-Reply-To: <7bb56fd2-ffe2-2985-19d0-31b42bc9e7e8@i-love.sakura.ne.jp>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 28 Oct 2020 14:57:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3id-zGLfdvo1m=ct_E=EKkf6Xwkrz5LQdgNsvfgbMcZw@mail.gmail.com>
Message-ID: <CAK8P3a3id-zGLfdvo1m=ct_E=EKkf6Xwkrz5LQdgNsvfgbMcZw@mail.gmail.com>
Subject: Re: [PATCH] tomoyo: fix clang pointer arithmetic warning
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Oct 28, 2020 at 2:22 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Thank you for a patch. I have two questions.
>
> On 2020/10/27 6:52, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang warns about additions on NULL pointers being undefined in C:
> >
> > security/tomoyo/securityfs_if.c:226:59: warning: arithmetic on a null pointer treated as a cast from integer to pointer is a GNU extension [-Wnull-pointer-arithmetic]
> >         securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> >
> > Change the code to instead use a cast through uintptr_t to avoid
> > the warning.
> >
>
> > -     securityfs_create_file(name, mode, parent, ((u8 *) NULL) + key,
> > +     securityfs_create_file(name, mode, parent, (u8 *)(uintptr_t)key,
> >                              &tomoyo_operations);
>
> (1) Does clang warn if "(void *)key" is used instead of "(u8 *)(uintptr_t)key" ?

Yes, both clang and gcc warn when you cast between a pointer and
an integer of a different size.

> (2) tomoyo_open() has
>
>         const int key = ((u8 *) file_inode(file)->i_private) - ((u8 *) NULL);
>
>     which decodes the "u8 key" passed to tomoyo_create_entry(). For symmetry,
>     I'd like to remove NULL from tomoyo_open() as well. Does clang warn if
>
>         const int key = (u8) (file_inode(file)->i_private);
>
>     is used?

Yes, same thing, but

   const int key = (uintptr_t)file_inode(file)->i_private;

works without warnings and seems clearer.

       Arnd
