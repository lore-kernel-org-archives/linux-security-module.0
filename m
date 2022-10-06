Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00E8C433FE
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Oct 2022 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJFGcD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 6 Oct 2022 02:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJFGcD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Oct 2022 02:32:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315253FEE0
        for <linux-security-module@vger.kernel.org>; Wed,  5 Oct 2022 23:32:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so2347055eja.6
        for <linux-security-module@vger.kernel.org>; Wed, 05 Oct 2022 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=mHju16tHxpXl3EK4c7Bh3/hsomdw2uS+nwGbV/7jvJE=;
        b=iySenhqEf+XihjlDc4yaj8PGwDwtb8erweo1YsY4IcBWCgSq5VaSLzZDVtDF+VqQAC
         BEHszdgbn3nX20tgDQ677zAacRoyxXK4hXS9taeizO0XiacsmzZoVQDmH8s0fEn/i8DX
         wAbMjCOdqOLgddyiDGsCCI+cuaoQiFQWoAKds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mHju16tHxpXl3EK4c7Bh3/hsomdw2uS+nwGbV/7jvJE=;
        b=TJryd46sGE8QlAwSocTBHSXzDjcQ+RiUc/CIVvC4V4sD9bYXXzvj8mUCJGFhRH72uM
         hrgHzjStYSqlSYURg9YOGQ/CHr3PUnbLJ6BypV0MBNH6RH+NXfPa9g3oAwB0eJlklWcL
         lGQL6RaK83CjlXflULWa4HI7YLGrZbIVm+iOLKnXQdQ43N69mB8A5h/Of4H4VdzJ7FPq
         oJJtzNRVGmCjN2DSoU2/lgx3DCM+1OV+f0Le/SyezI26TMHwEiyJleeFfqgh/uT7nYVE
         BTNQAT3diQB1DAjHnLOJsUloHVa0AaJG6oRghH2LEu1dyh0piAmE2J/uGMQ/r3XeA5uR
         f5Sg==
X-Gm-Message-State: ACrzQf2cqjNiq6mfnK0KERCjeJL8M+JbXaY5XqqEiQRmPT7qoUWp5rmT
        u94iuDQvBQ8clCd57qCweViEW2jo6UB8ejEMkdumhQ==
X-Google-Smtp-Source: AMsMyM5f9K6PIAM9zeO5vKX91jTFdHXC9+MnXMlia0zJkE65UlxJxiFVol75UCFnY+6Gy9vUC0i9YtJsYgZ3KGz0mEc=
X-Received: by 2002:a17:907:7f9e:b0:78b:c4af:bcca with SMTP id
 qk30-20020a1709077f9e00b0078bc4afbccamr2714447ejc.187.1665037918815; Wed, 05
 Oct 2022 23:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220929153041.500115-1-brauner@kernel.org> <20220929153041.500115-5-brauner@kernel.org>
 <CAJfpegterbOyGGDbHY8LidzR45TTbhHdRG728mQQi_LaNMS3PA@mail.gmail.com>
 <20220930090949.cl3ajz7r4ub6jrae@wittgenstein> <CAJfpegsu9r84J-3wN=z8OOzHd+7YRBn9CNFMDWSbftCEm0e27A@mail.gmail.com>
 <CAH2r5muRDdy1s4xS7bHePEF3t84qGaX3rDXUgGLY1k_XG4vuAg@mail.gmail.com> <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
In-Reply-To: <20221005071508.lc7qg6cffqrhbc4d@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Oct 2022 08:31:47 +0200
Message-ID: <CAJfpegviBdPx25oLTNHCg661GfMa92NKOadSr=QnaFAhzkkN2Q@mail.gmail.com>
Subject: Re: [PATCH v4 04/30] fs: add new get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     Steve French <smfrench@gmail.com>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 5 Oct 2022 at 09:15, Christian Brauner <brauner@kernel.org> wrote:

> We're just talking about thet fact that
> {g,s}etxattr(system.posix_acl_{access,default}) work on cifs but
> getting acls based on inode operations isn't supported. Consequently you
> can't use the acls for permission checking in the vfs for cifs. If as
> you say below that's intentional because the client doesn't perform
> access checks then that's probably fine.

Now I just need to wrap my head around how this interacts with all the
uid/gid transformations.

Do these (userns, mnt_userns) even make sense for the case of remotely
checked permissions?

Thanks,
Miklos
