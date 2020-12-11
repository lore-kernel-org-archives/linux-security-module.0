Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BAC4361B
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Dec 2020 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3F522CB3
	for <linux-security-module@archiver.kernel.org>; Fri, 11 Dec 2020 15:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393478AbgLKO4l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgLKO4M (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Dec 2020 09:56:12 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164ABC0613CF
        for <linux-security-module@vger.kernel.org>; Fri, 11 Dec 2020 06:55:32 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x4so4907275vsp.7
        for <linux-security-module@vger.kernel.org>; Fri, 11 Dec 2020 06:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qMuLxvVnDHp3uy4PWFqZ6dlsKThKey3XysejxwonVc=;
        b=jBCqJLhhqpWmNYM9gv6n/7oRElgxyilQXQMEYhBlLIagO2t+cpiqg8yQ5G06PdR46X
         hxAq7wNE1/5qUSy6J8ku1Vv41/qOq6C25IqBX9A1WbkaxkOLZZgjTGZjFztNWbThjo/K
         o06O3ghwW+WoXwiZ7MpUAG/PxcCOvabnzbun8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qMuLxvVnDHp3uy4PWFqZ6dlsKThKey3XysejxwonVc=;
        b=q/tH5gzzROgM+ry9U/JMb+XqPzvhEWoW20OIJJgZmtvde3MqishUfE862D999uJAaO
         Bml0D3RjhjyBeGZnSgbeAu/ErrWL8Qvvz6ZPvVam2sbhvz8icbR/WuqFb9vqPXMyw4Ha
         s9162/oM1UVahRovrDStCefP4CJBag7Xk3HbZ475qYeGJwc6To6ekEDl5XdPLSqKv7f0
         Rc5Xul1c5lzwt4DJ691Cm6WP4t/9BLWgeB/XWKlUpK2xN/sUEW8ANbhdRIkFm2sS0/mX
         CLsaC1YZqVc4P5dJEsLEUEbiF5MZXv/ohkRKuIG7y31pp9jSzg+UnWN1ZEOKbZRjSFm5
         EW8w==
X-Gm-Message-State: AOAM530aTdwNCVi0b7A9/y4XLDyCIWZnp3OsfPKVLX6SmqKC43xkWeV1
        nBkLm7eB/aW1O3mP7h/5ayhzl/1y4wPyLYzHRxNsRAP/Rd8dcA==
X-Google-Smtp-Source: ABdhPJwMNShiSY2MP7gO+rAui8QkCyTNR0rAGwuad5uMGbc0nJuY8BS3bOuh1uYseNFLtouqxbqM41NpF+q/o6s7Eto=
X-Received: by 2002:a67:fa50:: with SMTP id j16mr13417920vsq.9.1607698531177;
 Fri, 11 Dec 2020 06:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-7-mszeredi@redhat.com>
 <CAOQ4uxju9wLCq5mqPLgo0anD+n7DLnmHzJ=SymFTRc0c_uVY4Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxju9wLCq5mqPLgo0anD+n7DLnmHzJ=SymFTRc0c_uVY4Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 11 Dec 2020 15:55:20 +0100
Message-ID: <CAJfpegvzU5y09jxpzq=SSKc67bp-03hpqkQa-m4CZk-p2bEcVw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] ovl: user xattr
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Dec 8, 2020 at 2:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Dec 7, 2020 at 6:37 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Optionally allow using "user.overlay." namespace instead of
> > "trusted.overlay."
>
> There are several occurrences of "trusted.overlay" string in code and
> Documentation, which is fine. But maybe only adjust the comment for
> testing xattr support:
>
>          * Check if upper/work fs supports trusted.overlay.* xattr


Updated documentation and comments.

Pushed new series to:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#ovl-unpriv-v3

Based on the feedback, I feel it's ready for v5.11, so merged this
into #overlayfs-next as well.

Thanks,
Miklos
