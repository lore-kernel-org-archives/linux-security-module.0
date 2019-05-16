Return-Path: <SRS0=l9QZ=TQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D335C04AAF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34BA20815
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibB5Z1OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEPQxE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 12:53:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34862 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfEPQxE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 12:53:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id g5so1921269plt.2
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6LcSRBYGYblE8KnG9YkzHNeJWSKv1kS+36NXuNsO3Vk=;
        b=ibB5Z1OYQwc98aDEYCmgshR4HnNV1ewVWdMdm/6CKYXPVekT2bhzH4PkYIc0CBN6g0
         3RVcq3LMmZ5Q5lyRNGhCySSZnXDeQlR3o+rYJ7XjtWaWqiP4S8z4OyyjXHTScR2eI/lD
         BGuI6KsW5NIL4fQ067WG0tUG+O+QUq3y5B3pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LcSRBYGYblE8KnG9YkzHNeJWSKv1kS+36NXuNsO3Vk=;
        b=HoGn6pYjuXho/iSZ+ZP3H56pVqYaGZ/kweu4XzCBwSbf8AkrAM9TH3XAotfmjgsjc8
         Jwfgs9r60LMIsKHk2jU7ztx6vvnIul9aT8uPLXwKPQbZ+nqdzcJQAFt9+sp7V6nf9Cfg
         3TC+9Lf0Zyh2tKE05kVPNCRobvSITayP8NGkE1cbhkykQELHKy+Fo9s6fXECuK+hN/mj
         76U1XofwyJr8xifLhRyB/Z/YU9hUeFEYc8NZgt5wooyg84YMlz00Bl1CjwyAPrrnmbqX
         r9iYgxlmwVt/km3rziWHkA92WlebXqRU8lWNY2AJjzIBe943TILplhqxG04DSOXuiMyB
         RBfg==
X-Gm-Message-State: APjAAAUdb5OeYoLXNn5oichqp1fbcpyrttKH/m81LDExAFzBAJwO1S2X
        zKcrSbp7V4gQMtzqVdkE0QSV1A==
X-Google-Smtp-Source: APXvYqzxktrdR74/jozDFmScyT7V6rFj+OxDZS8IbmNkChFWgpOSZeP4blgwp9KkSVtUQXVkKb0mfw==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr50309891pll.147.1558025583725;
        Thu, 16 May 2019 09:53:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f29sm16984632pfq.11.2019.05.16.09.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:53:02 -0700 (PDT)
Date:   Thu, 16 May 2019 09:53:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     akpm@linux-foundation.org, cl@linux.com,
        kernel-hardening@lists.openwall.com,
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
        Mark Rutland <mark.rutland@arm.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: apply __GFP_NO_AUTOINIT to AF_UNIX sk_buff
 allocations
Message-ID: <201905160923.BD3E530EFC@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-5-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-5-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 14, 2019 at 04:35:37PM +0200, Alexander Potapenko wrote:
> Add sock_alloc_send_pskb_noinit(), which is similar to
> sock_alloc_send_pskb(), but allocates with __GFP_NO_AUTOINIT.
> This helps reduce the slowdown on hackbench in the init_on_alloc mode
> from 6.84% to 3.45%.

Out of curiosity, why the creation of the new function over adding a
gfp flag argument to sock_alloc_send_pskb() and updating callers? (There
are only 6 callers, and this change already updates 2 of those.)

> Slowdown for the initialization features compared to init_on_free=0,
> init_on_alloc=0:
> 
> hackbench, init_on_free=1:  +7.71% sys time (st.err 0.45%)
> hackbench, init_on_alloc=1: +3.45% sys time (st.err 0.86%)

In the commit log it might be worth mentioning that this is only
changing the init_on_alloc case (in case it's not already obvious to
folks). Perhaps there needs to be a split of __GFP_NO_AUTOINIT into
__GFP_NO_AUTO_ALLOC_INIT and __GFP_NO_AUTO_FREE_INIT? Right now __GFP_NO_AUTOINIT is only checked for init_on_alloc:

static inline bool want_init_on_alloc(gfp_t flags)
{
        if (static_branch_unlikely(&init_on_alloc))
                return !(flags & __GFP_NO_AUTOINIT);
        return flags & __GFP_ZERO;
}
...
static inline bool want_init_on_free(void)
{
        return static_branch_unlikely(&init_on_free);
}

On a related note, it might be nice to add an exclusion list to
the kmem_cache_create() cases, since it seems likely that further
tuning will be needed there. For example, with the init_on_free-similar
PAX_MEMORY_SANITIZE changes in the last public release of PaX/grsecurity,
the following were excluded from wipe-on-free:

	buffer_head
	names_cache
	mm_struct
	vm_area_struct
	anon_vma
	anon_vma_chain
	skbuff_head_cache
	skbuff_fclone_cache

Adding these and others (with details on why they were selected),
might improve init_on_free performance further without trading too
much coverage.

Having a kernel param with a comma-separated list of cache names and
the logic to add __GFP_NO_AUTOINIT at creation time would be a nice
(and cheap!) debug feature to let folks tune things for their specific
workloads, if they choose to. (And it could maybe also know what "none"
meant, to actually remove the built-in exclusions, similar to what
PaX's "pax_sanitize_slab=full" does.)

-- 
Kees Cook
