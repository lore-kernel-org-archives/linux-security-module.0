Return-Path: <SRS0=6iY4=B5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DFDC433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 23:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C537D20885
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 23:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RYffqW5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgHSXgT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSXgP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 19:36:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE8C061757
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 16:36:15 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so149546pjx.5
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OL8pogAZ7nK/GHwOhHpYX84wczTBnNXhUKszoax97yw=;
        b=RYffqW5j0gjcmqcAj0G4MNruh3ppWqpBsZ8QlvxrvGV6E83CWwux4WS6qnUuvz51sr
         E4NgGnt7fx4sHD6mIqOgU+uA98mMhWEO2MXccxzbH4uSQ2urHK6W+Zr7hPVMgV/c8r+g
         0DTIsord8MCQKQPhvMj67W6EgsU2F5nK7rUZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OL8pogAZ7nK/GHwOhHpYX84wczTBnNXhUKszoax97yw=;
        b=t1YJamZfNmnWGQBYzmbKQTYNwI44xz15DVdqXn2WXXAlOL/SEaOxGas8l1xQODxgyq
         CotrneoRDTaodt1pIozUL03kd5PXYaskcF7LnCiZaNF4p3HYwzvceumYkb2cnmKe98mp
         WfoL4hPOW1hCktw9oi42AjCFCagIA03/vg6neBhJEP37Lf31GMNrHDAspcb0GADqpoWT
         uXVyrp+19HwktURYDYy1to96XkqOk5ZFT2yPL8a9DrP4h0cARTaWPoh8QCNpIm1Pat4E
         sBEpKpiU+PJxoVkw+Yjs+7AU0Rg9C6rIYEGI+cggJAX90ZOFbQSrp5oUkQImqmt4gTQa
         5f3Q==
X-Gm-Message-State: AOAM533JW+5g4JtllWUuh86cwCHoPC2fBby61GvcpP/PTLiLS3w3QIlP
        3xio9vxVXoeDJ90vls78X+Rbfw==
X-Google-Smtp-Source: ABdhPJztG561lgarz0fyj0g5MgwaALC3qNQDwRg7Mg7XodZzm8ie+lc4uJ10jF+RtiVvGy+Gslmjlw==
X-Received: by 2002:a17:90a:c682:: with SMTP id n2mr239820pjt.72.1597880175006;
        Wed, 19 Aug 2020 16:36:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e8sm327961pfd.34.2020.08.19.16.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 16:36:11 -0700 (PDT)
Date:   Wed, 19 Aug 2020 16:36:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jirka Hladky <jhladky@redhat.com>
Cc:     Alexander Potapenko <glider@google.com>,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: init_on_alloc/init_on_free boot options
Message-ID: <202008191626.1420C63231@keescook>
References: <CAE4VaGD8sKqUgOxr0im+OJgwrLxbbXDaKTSqpyAGRx=rr9isUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE4VaGD8sKqUgOxr0im+OJgwrLxbbXDaKTSqpyAGRx=rr9isUg@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 20, 2020 at 12:18:33AM +0200, Jirka Hladky wrote:
> Could you please help me to clarify the purpose of init_on_alloc=1
> when init_on_free is enabled?

It's to zero memory at allocation time. :) (They are independent
options.)

> If I get it right, init_on_free=1 alone guarantees that the memory
> returned by the page allocator and SL[AU]B is initialized with zeroes.

No, it's guarantees memory freed by the page/slab allocators are zeroed.

> What is the purpose of init_on_alloc=1 in that case? We are zeroing
> memory twice, or am I missing something?

If you have both enabled, yes, you will zero twice. (In theory, if you
have any kind of Use-After-Free/dangling pointers that get written
through after free and before alloc, those contents wouldn't strictly be
zero at alloc time without init_on_alloc. But that's pretty rare.

I wouldn't expect many people to run with both options enabled;
init_on_alloc is more performance-friendly (i.e. cache-friendly), and
init_on_free minimizes the lifetime of stale data in memory.

It appears that the shipping kernel defaults for several distros (Ubuntu,
Arch, Debian, others?) and devices (Android, Chrome OS, others?) are using
init_on_alloc=1. Will Fedora and/or RedHat be joining this trend?  :)

-- 
Kees Cook
