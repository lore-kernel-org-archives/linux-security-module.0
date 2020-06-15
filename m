Return-Path: <SRS0=9iMC=74=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9BC433E2
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722532078A
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jun 2020 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239602;
	bh=1KT+vWhBgSpztqjzGMDQ4D4S8JwxH2WCmGD+wQfbPAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BktWCTztYoNsFufSNwMJXu1OrWhKjpM7g12Isox3nWPAPIQQFSjGnM6NHN3wwAB6/
	 SkIjYY8N9E4mqJIKCnU8AbhpgXV1wsQUHbpSbbMpzy2AUhDK0aGS6M5aAlVeAUxIpj
	 ZWbJBKA8/VRZnBSkeATjTa+9aUub8VjYGWZjakCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgFOQqe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgFOQqd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 12:46:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215CC08C5C2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so19987221lji.1
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=ZWk3x5iEjnyTLq8IMemOkgARbFQCw/Q53/428riLywNB6u9f+bQvXVcEgFAYoeyppV
         fCCBULVD7KWfArLFv0AgIvtaFvWI/tVW+Ez2gZY7mm3zfsO/bpanBZ32Aq/zacBlYhG6
         8bUzNz2BvrW4v3rb3iq/l8f6ouqvyn24pdFzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZvZBCuCQSkLPs9g5InfZ9ThZzzENQM2asJ2hMImD+8=;
        b=OIiqtu1wDlTKcXUVbTWHQ0305QgofPx+8kiIUSHn18zCgBOJrukJGv/cyVcEsu7EFr
         fD/k+p8ZoHTeMtAw0I6LuWgwC+8YDBePbu180jL4rH7VoKfNtJl223NYsQ5SF651dyEU
         pRQkPdUKUeOuE9zrMOaUPiRkhlIFJrPuv8vSyLzjz3w6cLDjljo9htX/GqPMg/rw5gdm
         4JDcI4Fs/iGIe88LEsVfnU/Ok24Wzdf9jwWpA0h0lnsn4YXvRnui1g6nPChPIrcmVuly
         6viezNtWPKlqvW1gfXnui4kSTJb9TGUq+uTqPyxs0xnkxu5M7ZQJchLiNOw5mXYtV9oj
         FqRg==
X-Gm-Message-State: AOAM530G3/VtrnBqXHmztRkjqZiNfzEDSTr8AT4WMzGJE5aBheUk5W6s
        SSTWtAJ6hq/1xhRC+mJ/O9itxmfvAVE=
X-Google-Smtp-Source: ABdhPJy9QMCicnHzgC+4YyGXsZZu+neRR3ticlDi9lVvCCzl19bWMwuFF5K4DXYKh6D+ufP0vaUIbg==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr13778304lji.199.1592239590391;
        Mon, 15 Jun 2020 09:46:30 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id n10sm556255lfb.82.2020.06.15.09.46.29
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id d7so9946779lfi.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jun 2020 09:46:29 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr5160341lfl.152.1592239588691;
 Mon, 15 Jun 2020 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-11-hch@lst.de>
In-Reply-To: <20200615121257.798894-11-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:46:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Message-ID: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
Subject: Re: [PATCH 10/13] integrity/ima: switch to using __kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> __kernel_read has a bunch of additional sanity checks, and this moves
> the set_fs out of non-core code.

Wel, you also seem to be removing this part:

> -       if (!(file->f_mode & FMODE_READ))
> -               return -EBADF;

which you didn't add in the previous patch that implemented __kernel_read().

It worries me that you're making these kinds of transformations where
the comments imply it's a no-op, but the actual code doesn't agree.

Especially when it's part of one large patch series and each commit
looks trivial.

This kind of series needs more care. Maybe that test isn't necessary,
but it isn't obvious, and I really don't like how you completely
glossed over totally changing what the code did.

               Linus
