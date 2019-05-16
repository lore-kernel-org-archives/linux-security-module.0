Return-Path: <SRS0=l9QZ=TQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9215C46460
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 01:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703F20873
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 01:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="leKX6iwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEPBql (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42403 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfEPBCD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 May 2019 21:02:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id 145so643256pgg.9
        for <linux-security-module@vger.kernel.org>; Wed, 15 May 2019 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kB1kmUsnU0wPfFGEdIrU26lZ3ENdFfZVOF7R429DJpY=;
        b=leKX6iwd+E3ikfGY1//ltoNgIH4UsQxaJiOP4LVdzgDaHwTPnmCflqgZj3iMSpPogi
         PgC4m5zp6O/OVfdH+hwsuGJbVzzncxBPRxzYWSA2cFKS10nMMGAdTlvTBBz9PRWqBtXG
         0IY/4ObX8iKZI38lWxYnqS+6NDlXUzJI3O9zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kB1kmUsnU0wPfFGEdIrU26lZ3ENdFfZVOF7R429DJpY=;
        b=caQM57xjpFY7vMZk4Fu3fuJgMm5zVh2rdQrDKfVxpRgFHkhRJpZ7moaBvFw4hGTZJC
         opykzEMnt+ojpps+LNm/KPzgBXygJj5T1b7YWAW2gcCfv6G+QWd7xrLFlLnlfU0aIipl
         xKNRobkV2V5jQqeFD66/L+Z4j5NFVsZGj0IQqHapG0QTGpgzv0eW747QVkAC0AqK/HVz
         OwrwVxt9VFFgHwjHTr2018MVuBG4d9fz1+B2EIsWYuNMDmY03SXaN+NfCsB9wYII2eL6
         NRig4X4+IYnRyDXDIo+0j06VsP4F3Vk+nmN6JKZMedterK14NaZhw97ba7Aeenp8BtQk
         tAkQ==
X-Gm-Message-State: APjAAAUgAhoH8XMeXAS4V2uB6t/EUO8k+q94eoCHLNQX/e0JmlEEoZnc
        7AgXnBfRGMHcaN555EKsN94sSw==
X-Google-Smtp-Source: APXvYqwVz17Dgzf/syT6+WT0zM62IWrmEQAWI9YG2skem8A0ptTGY41DM3GMUa2e6NgcM+k+1vVkWw==
X-Received: by 2002:a63:c046:: with SMTP id z6mr47778396pgi.387.1557968522985;
        Wed, 15 May 2019 18:02:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16sm3288629pgv.89.2019.05.15.18.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 18:02:02 -0700 (PDT)
Date:   Wed, 15 May 2019 18:02:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com,
        kernel-hardening@lists.openwall.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 2/4] lib: introduce test_meminit module
Message-ID: <201905151752.2BD430A@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-3-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 14, 2019 at 04:35:35PM +0200, Alexander Potapenko wrote:
> Add tests for heap and pagealloc initialization.
> These can be used to check init_on_alloc and init_on_free implementations
> as well as other approaches to initialization.

This is nice! Easy way to test the results. It might be helpful to show
here what to expect when loading this module:

with either init_on_alloc=1 or init_on_free=1, I happily see:

	test_meminit: all 10 tests in test_pages passed
	test_meminit: all 40 tests in test_kvmalloc passed
	test_meminit: all 20 tests in test_kmemcache passed
	test_meminit: all 70 tests passed!

and without:

	test_meminit: test_pages failed 10 out of 10 times
	test_meminit: test_kvmalloc failed 40 out of 40 times
	test_meminit: test_kmemcache failed 10 out of 20 times
	test_meminit: failures: 60 out of 70


> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

note below...

> [...]
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> new file mode 100644
> index 000000000000..67d759498030
> --- /dev/null
> +++ b/lib/test_meminit.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-2.0
> [...]
> +module_init(test_meminit_init);

I get a warning at build about missing the license:

WARNING: modpost: missing MODULE_LICENSE() in lib/test_meminit.o

So, following the SPDX line, just add:

MODULE_LICENSE("GPL");

-- 
Kees Cook
