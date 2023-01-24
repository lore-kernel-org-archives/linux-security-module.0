Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2822BC54E94
	for <linux-security-module@archiver.kernel.org>; Tue, 24 Jan 2023 20:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjAXUh5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjAXUh4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Jan 2023 15:37:56 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314E4B1AD
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jan 2023 12:37:54 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id w15so1819975qvs.11
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jan 2023 12:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZljQXUAv1zGBqD9bK2Eq8FCbMFjab23U5zice80vuU=;
        b=X002AKiZUf3hGcCKm5944aKx1gFXf+DZmQLKkow8NxeqbeQinBQkAPxXNfzd9giWWq
         TePtDtrs0p7XlQAKo2pQMD+w5W95gdaCOTzMjQva9NwhVLL7pPqWnJDfCvgtxZ4iqDEV
         wFUNFn3c5X3JOQuGaOe3xp+xT7JmtXqB7s2jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZljQXUAv1zGBqD9bK2Eq8FCbMFjab23U5zice80vuU=;
        b=Df/R67mf7nVW3t6aRjCfeHkuFHx2QqskjSEkgaururbAJTnhSiFVvCaIEmoBOxqYVr
         xVI0ncuoJluGOsjJV7zXaidmF0y+DaqgUiMkl/prTMYaBx2fMaoTpPNeE+/od0hVItOO
         3dN2wZkhjHr7mErKYzz+Wu+Ij5HBf2yAh/Od5T15p5GnRVU/rmuRpVeysliAQvxWF4WU
         k4Usd+sA/iG8x+dFZfcalSdDEKODYV2IoaN23ca2Rzcd6sgY82QvmAvuRHRomdfKoreV
         3i7f0XYPEYvA8Tqr+KAk3pE4kFZLADPCFOtX1u8r2PbirPMZl9GrRI/ZR3UhzmHoHHWr
         VZ1g==
X-Gm-Message-State: AFqh2kpiWaTrs3Im3R/rI7JLhZgwkM6L2kKmtYI7G6YoXUOR5bu8fT9U
        tTYb+Ypjj/jjn66IK9yl5n4emYsVduFzgGCF
X-Google-Smtp-Source: AMrXdXtde0zUF7+5Bco7wHcs3Eet7Z6liOnm8wvs99M8HKVCv3nPz/iONFzbQXMNWAFGrcGCX6J+tA==
X-Received: by 2002:ad4:43e4:0:b0:534:3013:1d2c with SMTP id f4-20020ad443e4000000b0053430131d2cmr39939816qvu.1.1674592673625;
        Tue, 24 Jan 2023 12:37:53 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05620a179e00b007062139ecb3sm2105977qkb.95.2023.01.24.12.37.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 12:37:53 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id bj29so2325362qkb.9
        for <linux-security-module@vger.kernel.org>; Tue, 24 Jan 2023 12:37:52 -0800 (PST)
X-Received: by 2002:a37:6387:0:b0:706:92f4:125 with SMTP id
 x129-20020a376387000000b0070692f40125mr1629012qkb.72.1674592672602; Tue, 24
 Jan 2023 12:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com> <CAGudoHG22iS3Bt1rh_kEJDEstj3r1Mj4Z305vqRbP8vBjQZ3dg@mail.gmail.com>
In-Reply-To: <CAGudoHG22iS3Bt1rh_kEJDEstj3r1Mj4Z305vqRbP8vBjQZ3dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jan 2023 12:37:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjzniFhDkfXzE4r9NDxsneKD3hkxzq7tHvjfbgr2ZdhEg@mail.gmail.com>
Message-ID: <CAHk-=wjzniFhDkfXzE4r9NDxsneKD3hkxzq7tHvjfbgr2ZdhEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jan 24, 2023 at 10:42 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So how about I simply respin with the comment I mailed earlier,
> repasted here for reference (with a slight tweak):

Ack, that's probably the way to go,

         Linus
