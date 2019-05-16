Return-Path: <SRS0=l9QZ=TQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC97C04AAF
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41E20815
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ros4p2hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEPRDP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 13:03:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45064 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfEPRDO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 13:03:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so1844534pgi.12
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2OkSls3BBuVCd2Q9OzzUfEJIECS5yJPO8xcocfnTaN4=;
        b=Ros4p2hkOqmoHbdixDDcfrW1H7jyK9zIQYjqlUFzXr5CiZP+1t7cTKrai4i8J8Q1Jc
         TzF8dMleKNk7RbmmoaakWyHRVMp2G/Ig5tkzDXUlXt800e0jwOfhD+WEBmHapdlbmP4M
         EBbEoq8OjOlQ/XJdZ16uZvhYu/dMHPBTDkc+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2OkSls3BBuVCd2Q9OzzUfEJIECS5yJPO8xcocfnTaN4=;
        b=Ug/5y+BmesAuqczQ/CDLrpReCSBmDlFvkKxlNM7PqDMmFG3LOxliNBstN8HP1007vF
         5r6BZU1QOvfih0/JehmEwj/A3MMt0yzhHwyaBwdtGTKou/9TUDPeLTMVvspGErYKbvE6
         PWdwFmYdOH/RQ94n61bW43/R1DJhNJdCc+1V+ACsSHV3026EwpVUGXwFz2MgzV8cY8qL
         VhKTHz3srTTuXqL4/yGSJsW+aHeRQbjtSqHnxY08mquuAma4JzQ72tIHlPSBD+tWPsnW
         9ZhHyd/aJxt1KfiUMNk4y8C9V574MepmRpWQuyCXwHdgmMWnpF56tzChsBJyDqzzdaqf
         hbsg==
X-Gm-Message-State: APjAAAWRMxCM3FNi5H1V3eSseHPukpGSTc6D3LJ0WTVmy/hpikzdgt0p
        VRSUJwSkWkrqArYqH+YOXNGDQw==
X-Google-Smtp-Source: APXvYqxf86X0I5LWFcSKWu+jd0qD6qpD2y7bXzGg9HBoYqsOh3qhcsFm36RFG3tU2Ws97h56kHXWnw==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr54743779pfi.187.1558026193892;
        Thu, 16 May 2019 10:03:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b3sm10386588pfr.146.2019.05.16.10.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:03:12 -0700 (PDT)
Date:   Thu, 16 May 2019 10:03:11 -0700
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
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
Message-ID: <201905160953.903FD364BC@keescook>
References: <20190514143537.10435-1-glider@google.com>
 <20190514143537.10435-2-glider@google.com>
 <201905160907.92FAC880@keescook>
 <CAG_fn=VsJmyuEUYy16R_M5Hu2CX-PJkz9Kw4rdy9XUCAYHwV5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VsJmyuEUYy16R_M5Hu2CX-PJkz9Kw4rdy9XUCAYHwV5g@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 16, 2019 at 06:42:37PM +0200, Alexander Potapenko wrote:
> I suspect the slowdown of init_on_free is bigger than that of
> PAX_SANITIZE_MEMORY, as we've set the goal to have fully zeroed memory
> at alloc time.
> If we want a mode that only wipes the user data upon free() but
> doesn't eliminate all uninit memory, then we can make it faster.

Yeah, I sent a separate email that discusses this a bit more.

I think the goals of init_on_alloc and init_on_free are likely a bit
different. Given init_on_alloc's much more cache-friendly performance,
I think that it's likely the right way forward for getting to fully zeroed
memory at alloc time. (Though I note that it already includes exclusions:
such tradeoffs won't be unique to init_on_free.)

init_on_free appears to give us similar coverage (but also reduces the
lifetime of unused data), but isn't cache-friendly so it looks to need
a lot more tuning/trade-offs. (Not that we shouldn't include it! It'll
just need a bit more care to be reasonable.)

> > +void __init report_meminit(void)
> > +{
> > +       const char *stack;
> > +
> > +       if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
> > +               stack = "all";
> > +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
> > +               stack = "byref_all";
> > +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
> > +               stack = "byref";
> > +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
> > +               stack = "__user";
> > +       else
> > +               stack = "off";
> > +
> > +       /* Report memory auto-initialization states for this boot. */
> > +       pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
> > +               stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
> > +               want_init_on_free() ? "on" : "off");
> > +}
> >
> > To get a boot line like:
> >
> >         mem auto-init: stack:off, heap alloc:off, heap free:on
> For stack there's no binary on/off, as you can potentially build half
> of the kernel with stack instrumentation and another half without it.
> We could make the instrumentation insert a static global flag into
> each translation unit, but this won't give us any interesting info.

Well, yes, that's technically true, but I think reporting the kernel
config here would make sense. If someone intentionally bypasses the
stack auto-init for portions of the kernel, we can't meaningfully report
it here. There will be exceptions for stack auto-init and heap auto-init.

-- 
Kees Cook
