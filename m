Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E48C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F66204FD
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OzkQiwAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfEQP7m (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 11:59:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40636 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbfEQP7m (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 11:59:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g69so3539526plb.7
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INvyXgRgpc11QEZcWPLU82BNdrovIrWqBF0OwWnNsfE=;
        b=OzkQiwAzJuMdG5Dif12dSl+nTEipCyWX7+SdFof6s8LaG66yLc+ruN0gDAGBN3TefY
         bbuIBXARgwmT4asXLVzMmCU0JRbt6/7DH9DwiCiJAnIJzLM1zPJP0ntHL5Ncxor2ZBxm
         kAshtNmIfG7mixRQlpwxZ/vwWgWZBCTFL4juE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INvyXgRgpc11QEZcWPLU82BNdrovIrWqBF0OwWnNsfE=;
        b=lMjzSRRpQlyneD2kcW6Srg9rYvBcdoB1KB82kdiQa7+vBN2uca1bCvADhGX2RlawzQ
         MCTBaBT9F4eX8czf3qAy9YNeBSh9ESiBXr4C4nLDuXEuj+oZuAXaMWumDHVtf8+Ca4m4
         GU3NHifsCBxpuzDda5RAtZ1lapzkjT9V9r+ylQk+1ggQNN2fCfy7SeC5nZn8gE0e/l6s
         XaJE46fTcxgWAqYw1UxKnXMOJqMqtnGkxIAvFJkpzO9ZJFEl5rVY7fF3o6qnQI7bRMz+
         EgXRR73jzIn/SMmHs4kcVi7G6r8mgf9zEW39tJt2ITYjiNumzGP3I9hB9ypzInwgMlmh
         3cMg==
X-Gm-Message-State: APjAAAWMdfsImzjQJliLeP4SNGjSBGnZKOEeBEhxJ6clSTABsHTfpp0C
        UKbuSwePOI+IfIAyMCvJY2M67g==
X-Google-Smtp-Source: APXvYqxjjymERosAhEH8xGgc+gUj/iwHDQd5pedl+FQfW0PvQNBci/Cem9LJMaQfelInYHey+/OBlA==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr12777643pll.163.1558108781558;
        Fri, 17 May 2019 08:59:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z14sm6716152pfk.73.2019.05.17.08.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 08:59:40 -0700 (PDT)
Date:   Fri, 17 May 2019 08:59:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 5/4] mm: Introduce SLAB_NO_FREE_INIT and mark excluded
 caches
Message-ID: <201905170858.CE4109E77@keescook>
References: <20190514143537.10435-5-glider@google.com>
 <201905161746.16E885F@keescook>
 <CAG_fn=W41zDac9DN9qVB_EwJG89f2cNBQYNyove4oO3dwe6d5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=W41zDac9DN9qVB_EwJG89f2cNBQYNyove4oO3dwe6d5Q@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 17, 2019 at 10:34:26AM +0200, Alexander Potapenko wrote:
> On Fri, May 17, 2019 at 2:50 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In order to improve the init_on_free performance, some frequently
> > freed caches with less sensitive contents can be excluded from the
> > init_on_free behavior.
> Did you see any notable performance improvement with this patch?
> A similar one gave me only 1-2% on the parallel Linux build.

Yup, that's in the other thread. I saw similar. But 1-2% on a 5% hit is
a lot. ;)

-- 
Kees Cook
