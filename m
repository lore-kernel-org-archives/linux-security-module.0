Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABFBC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F88206B6
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PO2nmPYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfDJQJt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:09:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32837 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfDJQJt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 12:09:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id a190so1710854vsd.0
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nndJGk2SQklOU2DpxIQYC6PE/jXN4O9poL6LmAQyF0s=;
        b=PO2nmPYvKFNAToYBvn7hITb4mz+MShgxeBxWhdg8yQBG2YZH8ACWTAut1kKPNHDphT
         9o0TOne1PLJ2SIGTguSz/cvj5/PlIpi8FtlumI58R30BrXhAWd0R4g240t4kK1Wkc0Kn
         o9MrMZ/IsQgieI4+t86GTUefB4bHTiwL9QUuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nndJGk2SQklOU2DpxIQYC6PE/jXN4O9poL6LmAQyF0s=;
        b=XWV70O02qdV/POAHTmNa38En4OwspuLCwHN6RdZJGOKTEPOrDTGJtMlja4Zl7EiH4R
         U0Uu8K8ysHZc51VoefA2cP8bfMz29qzcfGw+gxhJos20JJt5bSVb/wOjf5CVoe+TE/tS
         LATwZpLpBhdrImwVO2sSKpBBk8tY1jb0pk46JhYmRoIAQ4JrhNERDRgNlpW7wTFus+zy
         Z2aOU8Lc0VB3PhJZiyd8zhB8YEZazXQbius1Oxmtu20ZGWLYUZo6q6ADLt7+lD4QtDtC
         nkgmAdrwHWo7Hjo//6869hvjsYrjANKfgUCaq+4c92LNTg1InyFkWHVjZmwnVp7dZ472
         +mBQ==
X-Gm-Message-State: APjAAAXyqDz4NvlvCuvfMlXT6iczWEgTQdZaSQlcvV2w/3pqXPllhY9c
        HDjQdS2JmFY994udsV/k3eqpXljdEkA=
X-Google-Smtp-Source: APXvYqza5uaF2ZjR8SHWagRff50CaVC1/fdH2SGosXeRRPbqHrc8lZ9IBQi/FAF9panF/Xr9FZdJoA==
X-Received: by 2002:a67:fa95:: with SMTP id f21mr24209487vsq.180.1554912588130;
        Wed, 10 Apr 2019 09:09:48 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id g184sm4659495vkd.31.2019.04.10.09.09.46
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 09:09:46 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id o10so1667544vsp.12
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 09:09:46 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr23608239vsc.115.1554912586202;
 Wed, 10 Apr 2019 09:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190410131726.250295-1-glider@google.com> <20190410131726.250295-3-glider@google.com>
In-Reply-To: <20190410131726.250295-3-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 09:09:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com>
Message-ID: <CAGXu5jJt3uNWVXDD=GR6oVwn=g7O=Jcz9sxai5q10X9yyR56XA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Alexander Potapenko <glider@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 6:18 AM Alexander Potapenko <glider@google.com> wrote:
>
> This config option adds the possibility to initialize newly allocated
> pages and heap objects with a 0xAA pattern.
> There's already a number of places where allocations are initialized
> based on the presence of __GFP_ZERO flag. We just change this code so
> that under CONFIG_INIT_ALL_HEAP these allocations are always initialized
> with either 0x00 or 0xAA depending on the __GFP_ZERO.

Why not just make __GFP_ZERO unconditional instead? This looks like
it'd be simpler and not need arch-specific implementation?

-- 
Kees Cook
