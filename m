Return-Path: <SRS0=l9QZ=TQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA615C04AAF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA6D20815
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqrofeOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEPQUA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 12:20:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40543 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfEPQUA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 12:20:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so1863175plb.7
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yP0cE4pkGcJKdZW9ZXRUC1LKbWz6dsrqiIXXwI8zTkw=;
        b=OqrofeOSP4xGgbSa919UicUmiJIY7a17QopQmpjZGC12Qp2G0pFiBpicR3AMAuhKAI
         r7C0WU5Smn/UMH1Klt5YhfyIJC7Qjd/AJx7o7zjf/xdnrpP9CXJuO/CXymY3Fqd6uCMm
         If0iGWx2csNJG0uAl7NIatFjqgY/SrMySeC4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yP0cE4pkGcJKdZW9ZXRUC1LKbWz6dsrqiIXXwI8zTkw=;
        b=TUgT4aNkG1dHRPhJFO9epItl8BPXvz5Fuc/JrhbcRUvxRlX+KWNy/VtIeA0jUg7bIg
         12eDmvc+5vdGCaLIBHa3zf5VVocw7XyjJvTKBjnjTMIJ+FGlgro5CEOkrCk0g5zSgYvq
         96i+UBTr7RYDIR1gAXYf/rIKCuqFZLCmfNRYSI156sHUpsOZR3C0QvVgnJKnIXDiN+/v
         O4uGkhWzuEz4+ezvJK5BeQuFolgvtOJKyk6r1jmxOD4DkopOgjyJfOXhq9rcreb05NSu
         VjOHrm/eQL7C93LVUO/2a60IzJWzEDC/FV/N+oEhveiFpGGxpMvY/c9d5F/+a6XvXTwf
         ey2g==
X-Gm-Message-State: APjAAAWTkmYw15zp0Ej+Aecus4sjjEDYFLCaEKBn4daRpm6rzfs9zK2g
        scnv/J6LhuyqlNxlG192qTKt5w==
X-Google-Smtp-Source: APXvYqwwdVxU3RArLVptXXf5WDtbyUwQfbfyfrx6F7sflsYNsu9rOlPCdFs7Ea9DF7EOfykQSK+7Lw==
X-Received: by 2002:a17:902:8c82:: with SMTP id t2mr43276568plo.256.1558023599081;
        Thu, 16 May 2019 09:19:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s72sm7007143pgc.65.2019.05.16.09.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:19:58 -0700 (PDT)
Date:   Thu, 16 May 2019 09:19:56 -0700
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
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201905160907.92FAC880@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514143537.10435-2-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, May 14, 2019 at 04:35:34PM +0200, Alexander Potapenko wrote:
> Slowdown for the new features compared to init_on_free=0,
> init_on_alloc=0:
> 
> hackbench, init_on_free=1:  +7.62% sys time (st.err 0.74%)
> hackbench, init_on_alloc=1: +7.75% sys time (st.err 2.14%)

I wonder if the patch series should be reorganized to introduce
__GFP_NO_AUTOINIT first, so that when the commit with benchmarks appears,
we get the "final" numbers...

> Linux build with -j12, init_on_free=1:  +8.38% wall time (st.err 0.39%)
> Linux build with -j12, init_on_free=1:  +24.42% sys time (st.err 0.52%)
> Linux build with -j12, init_on_alloc=1: -0.13% wall time (st.err 0.42%)
> Linux build with -j12, init_on_alloc=1: +0.57% sys time (st.err 0.40%)

I'm working on reproducing these benchmarks. I'd really like to narrow
down the +24% number here. But it does 

> The slowdown for init_on_free=0, init_on_alloc=0 compared to the
> baseline is within the standard error.

I think the use of static keys here is really great: this is available
by default for anyone that wants to turn it on.

I'm thinking, given the configuable nature of this, it'd be worth adding
a little more detail at boot time. I think maybe a separate patch could
be added to describe the kernel's memory auto-initialization features,
and add something like this to mm_init():

+void __init report_meminit(void)
+{
+	const char *stack;
+
+	if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
+		stack = "all";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
+		stack = "byref_all";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
+		stack = "byref";
+	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
+		stack = "__user";
+	else
+		stack = "off";
+
+	/* Report memory auto-initialization states for this boot. */
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
+		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
+		want_init_on_free() ? "on" : "off");
+}

To get a boot line like:

	mem auto-init: stack:off, heap alloc:off, heap free:on

And one other thought I had was that in the init_on_free=1 case, there is
a large pause at boot while memory is being cleared. I think it'd be handy
to include a comment about that, just to keep people from being surprised:

diff --git a/init/main.c b/init/main.c
index cf0c3948ce0e..aea278392338 100644
--- a/init/main.c
+++ b/init/main.c
@@ -529,6 +529,8 @@ static void __init mm_init(void)
 	 * bigger than MAX_ORDER unless SPARSEMEM.
 	 */
 	page_ext_init_flatmem();
+	if (want_init_on_free())
+		pr_info("Clearing system memory ...\n");
 	mem_init();
 	kmem_cache_init();
 	pgtable_init();

Beyond these thoughts, I think this series is in good shape.

Andrew (or anyone else) do you have any concerns about this?

-- 
Kees Cook
