Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E6C433FE
	for <linux-security-module@archiver.kernel.org>; Fri, 21 Oct 2022 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJUVmf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUVmf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 21 Oct 2022 17:42:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046EC2A8A4E
        for <linux-security-module@vger.kernel.org>; Fri, 21 Oct 2022 14:42:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 8so2921997qka.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Oct 2022 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=I80BmYwmapXMsaFaO7z6zYbaghq7BAhIzcq3bRl9+ijNCbn+7jyWwY0lu51t1rXyFx
         mDpjRRP6dUKPk7ucQ12SPEPo/rKwU8pKTkN+duv7lVufggHpQttUQ8vU0+M/J/sE80oJ
         C1PuDo5G8mzbJFa3TGFzOk66a6+I3X53Vg0Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=l3d6f9oQM7UN6Gz/xEAfBJi8Vz1hLAcktRskeuDvPTSpcv4IaQknsFQAQSro03S0OI
         lDnhikQIpQNWqbh4Yn5Q362zClXXXMJqjoYKfrHPZo92a8vieUZhuwmPvsc9hp4ywTsq
         h+yyRlXXD3gutBQFBuOHBN14KPG6VkonJeu1mbT23m0iFA7Yu9aVqNOm/9LzW0yl1fzE
         cRUmLDNK8jjj6N56gqWJUgpK6iCR1votaaRB7QwXilqgPMLypszwJuYOmSCteUXUgidN
         n77vfZSQXzYL/t9RaZvOBvttGECbj2jMNqKg89GP7MVtx4TPgpsRbyBlBZ3FSu5Q7xfQ
         t1Fg==
X-Gm-Message-State: ACrzQf0vD6zN9PHJ6VClRs5R/03Uir634L02PYbJ/PtEh+bPYdTY5UHW
        /7QU59CXtjhHuNM/9wuofEyOdfSx7cd3Yw==
X-Google-Smtp-Source: AMsMyM67qYRFd98b014LHB1k7K4A1UTlOfQT35YKBe7LaMaKzVqMd3T8cM7emFqQkKQbWuXRPUGCDw==
X-Received: by 2002:a05:620a:298a:b0:6ee:e31f:6247 with SMTP id r10-20020a05620a298a00b006eee31f6247mr14785047qkp.744.1666388552770;
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v2-20020a05620a0f0200b006cfc1d827cbsm10801027qkl.9.2022.10.21.14.42.32
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e83so4835346ybh.1
        for <linux-security-module@vger.kernel.org>; Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr19715171ybu.310.1666388551764; Fri, 21
 Oct 2022 14:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
In-Reply-To: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 14:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v6.1 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 20, 2022 at 8:20 AM Paul Moore <paul@paul-moore.com> wrote:
>
>         The patch, while still fairly small, is a bit
> larger than one might expect from a simple s/GFP_KERNEL/GFP_ATOMIC/
> conversion because we added support for the function to be called with
> different gfp flags depending on the context, preserving GFP_KERNEL
> for those cases that can safely sleep.

Hmm.

So I've pulled this, but that patch actually makes it obvious that
there is only one single possible function for "convert->func", namely
that "convert_context()" function.

So why is that an indirect function call in the first place? That just
makes for slower (particularly in this age of indirect call
speculation costs), and bigger code, and only makes it harder to see
what is going on.

In the call-site, it looks like "Oh, this will call some
conversion-specific callback function".

In reality, there is no context-specific callback, there is only ever
convert_context().

Inefficient and misleading code. Not a great combination.

              Linus
