Return-Path: <SRS0=kyj6=UV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE272C43613
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 20:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B012B2070B
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 20:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PJubyZXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFVU0F (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:26:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46600 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVU0E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 16:26:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so4651123pls.13
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LSJX+LSGEGQXGztmOIE004OfGh43169X3pcb5+bEdo=;
        b=PJubyZXgmBMF9k6yZxMLMCoxJX3lLbrfjE/x11wxvT4SyKzC7lqaSzwuAzKsdvRECT
         JX+yyONHgatgA52lc2VKENZDXJ0oJQJPvb4ClFK6LmUuGM2m096eJJ2k956gRVMIZcq1
         vzetQM/j9ky6lgW/ScwHIPlBGEHxdCZpSDcV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LSJX+LSGEGQXGztmOIE004OfGh43169X3pcb5+bEdo=;
        b=B/2Dw7qITjrqdl19cD5hlkzzW4XboDC+otIPooRthh0WM8v3+wFTyGY8PoPGjGsrI0
         FRJ8q+HgfRQN9NwrGB5jV0LP7btVXC8WWvx0+GJTyYvSObTnn9KJqCApQesXrQkOHqdv
         4n1rZmvGLChtVi2p1DgOyCiWrla7BOJCP2500EbEg76tH/lzxLZ6G82efWmuk9rT3gfX
         9AZNxgi9ylSi8x34rCBwzqilb/RwXi35SepqqswPkksrjVloSV4TENTVlpiLfLZw5sZG
         XHyoUp6L4Fy3R9exIl/QyumhvBP0hcBdJUumPWcaS8vkh83fcv2ix4cTjOvkxmGaA4gv
         +3ng==
X-Gm-Message-State: APjAAAVwZZWsHH61kHeGMT6IsbvjKHM3sF1GCdRGeo7OpXPDn0lPhhKW
        RC6TS/nuCkpWKRKuDBwabGWHIQ==
X-Google-Smtp-Source: APXvYqwsWh+Rhre5Q6lIWu0XK+GpHk0JyBbDpywnv/6/g83T3V7rSeoORcYPnSeq6m705DN4ZF+rnQ==
X-Received: by 2002:a17:902:2ae8:: with SMTP id j95mr96325450plb.276.1561235163946;
        Sat, 22 Jun 2019 13:26:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o74sm10129957pfg.91.2019.06.22.13.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 13:26:03 -0700 (PDT)
Date:   Sat, 22 Jun 2019 13:26:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with
 KASAN_STACK
Message-ID: <201906221324.C08C1EF@keescook>
References: <20190618094731.3677294-1-arnd@arndb.de>
 <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
 <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
 <CAK8P3a2d3H-pdiLX_8aA4LNLOVTSyPW_jvwZQkv0Ey3SJS87Bg@mail.gmail.com>
 <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9p017iPva85dPMdnKW_MSOUcthqcy7KDhGEYCN7=C_SA@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 03:50:02PM +0200, Ard Biesheuvel wrote:
> On Fri, 21 Jun 2019 at 15:44, Arnd Bergmann <arnd@arndb.de> wrote:
> > One pattern I have seen here is temporary variables from macros or
> > inline functions whose lifetime now extends over the entire function
> > rather than just the basic block in which they are defined, see e.g.
> > lpfc_debug_dump_qe() being inlined multiple times into
> > lpfc_debug_dump_all_queues(). Each instance of the local
> > "char line_buf[LPFC_LBUF_SZ];" seems to add on to the previous
> > one now, where the behavior without the structleak plugin is that
> > they don't.

Ewww.

> Right, that seems to be due to the fact that this code
> 
> /* split the first bb where we can put the forced initializers */
> gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> bb = single_succ(ENTRY_BLOCK_PTR_FOR_FN(cfun));
> if (!single_pred_p(bb)) {
>     split_edge(single_succ_edge(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
>     gcc_assert(single_succ_p(ENTRY_BLOCK_PTR_FOR_FN(cfun)));
> }
> 
> puts all the initializers at the beginning of the function rather than
> inside the scope of the definition.

Do you see a sane way to improve this? I hadn't noticed that this
actually moved it up to the start of the function. :(

-- 
Kees Cook
