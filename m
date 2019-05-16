Return-Path: <SRS0=l9QZ=TQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165CFC04E84
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD07720848
	for <linux-security-module@archiver.kernel.org>; Thu, 16 May 2019 16:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Okxi5lkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfEPQmv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 May 2019 12:42:51 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34753 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfEPQmv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 May 2019 12:42:51 -0400
Received: by mail-ua1-f67.google.com with SMTP id 7so1553448uah.1
        for <linux-security-module@vger.kernel.org>; Thu, 16 May 2019 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qGP3s0Ih6OqVOl4yoE5OjhGMu8j59fK2Yi9/glM9Xrw=;
        b=Okxi5lkWUzIdKTINNYUM9x0CnMaOx+4nMm60iubKUC2qCx6xrcp+TpF7VhW0Fisia6
         F0nxNliuFmYXNy3jH/xpwkRoe1hzGWV9CqMzTYNwzraz5N2DueWrpxTEAf82+p1DoA9v
         W7HoBYmrAbuLZJaDIXah0OnRhmBrTDImi1h/vpZe7aomuRRUQhT+21d3qJFMmoGOHGEf
         g/B+yNhFTjBlOi6JP8Arm/xbaNfqiKOALKh2nOYaulXmSpF5zKSdQEmkXWfFFY4ULB68
         Y9Z0a/sxvRghtt+6NzvOiV00D0R8jsBlQzQv5g2tIyt5mrGvwv4P8hjZwAXpWnodcN10
         bJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qGP3s0Ih6OqVOl4yoE5OjhGMu8j59fK2Yi9/glM9Xrw=;
        b=RJY20/SfQjfMKiF0KvpZgIG5Jea4pDQt5U6BuLH515uG7g2HD7Y5ulx9C45FNVZYAz
         GyC4PLYnqyMcGCK2xZa5CkvO+cxaBaLD/5H5MVUecSRfox7deTqSYhVMY5dbZUhuFNPB
         BSjw68R9p3pGC4WY7S3QnaTZHGw9+D9v05LMVRRM7q1a/GED2vWY6UiNp0h+ezreJh2h
         igx+bF4cM99FqCNdszdEIFw7QkpOEC5kMezMl9PROdBoqIWgb3F0BH0VVZ7/9Z1kSa7K
         /QrRkuOR3IfwgtEyww3YqF6dtk4WmOUTk4/uL+Yi+d3qO4FHhfbqHbOFqaJoanIp4K7N
         XBgg==
X-Gm-Message-State: APjAAAUxhigupNy/XDYR+QR6aqt+6fTUDXd2YA1NTswsPXLTohF2zOf5
        3XzWf1xWHx6a0/0xUibWyPtglcm7vD6efDkuvaajjg==
X-Google-Smtp-Source: APXvYqy1VuDI7sbqIeBSUq7vxcBjJYXZpt3wUC0XAgfrB4Epp7KDM4s3DQdaAV9PG0f2kxYun1qfBmQzNSJDtinvt9w=
X-Received: by 2002:ab0:29cc:: with SMTP id i12mr16086901uaq.12.1558024969202;
 Thu, 16 May 2019 09:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-2-glider@google.com>
 <201905160907.92FAC880@keescook>
In-Reply-To: <201905160907.92FAC880@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 May 2019 18:42:37 +0200
Message-ID: <CAG_fn=VsJmyuEUYy16R_M5Hu2CX-PJkz9Kw4rdy9XUCAYHwV5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>
Date: Thu, May 16, 2019 at 6:20 PM
To: Alexander Potapenko
Cc: <akpm@linux-foundation.org>, <cl@linux.com>,
<kernel-hardening@lists.openwall.com>, Masahiro Yamada, James Morris,
Serge E. Hallyn, Nick Desaulniers, Kostya Serebryany, Dmitry Vyukov,
Sandeep Patil, Laura Abbott, Randy Dunlap, Jann Horn, Mark Rutland,
<linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>

> On Tue, May 14, 2019 at 04:35:34PM +0200, Alexander Potapenko wrote:
> > Slowdown for the new features compared to init_on_free=3D0,
> > init_on_alloc=3D0:
> >
> > hackbench, init_on_free=3D1:  +7.62% sys time (st.err 0.74%)
> > hackbench, init_on_alloc=3D1: +7.75% sys time (st.err 2.14%)
>
> I wonder if the patch series should be reorganized to introduce
> __GFP_NO_AUTOINIT first, so that when the commit with benchmarks appears,
> we get the "final" numbers...
>
> > Linux build with -j12, init_on_free=3D1:  +8.38% wall time (st.err 0.39=
%)
> > Linux build with -j12, init_on_free=3D1:  +24.42% sys time (st.err 0.52=
%)
> > Linux build with -j12, init_on_alloc=3D1: -0.13% wall time (st.err 0.42=
%)
> > Linux build with -j12, init_on_alloc=3D1: +0.57% sys time (st.err 0.40%=
)
>
> I'm working on reproducing these benchmarks. I'd really like to narrow
> down the +24% number here. But it does
I suspect the slowdown of init_on_free is bigger than that of
PAX_SANITIZE_MEMORY, as we've set the goal to have fully zeroed memory
at alloc time.
If we want a mode that only wipes the user data upon free() but
doesn't eliminate all uninit memory, then we can make it faster.
> > The slowdown for init_on_free=3D0, init_on_alloc=3D0 compared to the
> > baseline is within the standard error.
>
> I think the use of static keys here is really great: this is available
> by default for anyone that wants to turn it on.
>
> I'm thinking, given the configuable nature of this, it'd be worth adding
> a little more detail at boot time. I think maybe a separate patch could
> be added to describe the kernel's memory auto-initialization features,
> and add something like this to mm_init():
>
> +void __init report_meminit(void)
> +{
> +       const char *stack;
> +
> +       if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
> +               stack =3D "all";
> +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
> +               stack =3D "byref_all";
> +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
> +               stack =3D "byref";
> +       else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_USER))
> +               stack =3D "__user";
> +       else
> +               stack =3D "off";
> +
> +       /* Report memory auto-initialization states for this boot. */
> +       pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
> +               stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
> +               want_init_on_free() ? "on" : "off");
> +}
>
> To get a boot line like:
>
>         mem auto-init: stack:off, heap alloc:off, heap free:on
For stack there's no binary on/off, as you can potentially build half
of the kernel with stack instrumentation and another half without it.
We could make the instrumentation insert a static global flag into
each translation unit, but this won't give us any interesting info.

> And one other thought I had was that in the init_on_free=3D1 case, there =
is
> a large pause at boot while memory is being cleared. I think it'd be hand=
y
> to include a comment about that, just to keep people from being surprised=
:
>
> diff --git a/init/main.c b/init/main.c
> index cf0c3948ce0e..aea278392338 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -529,6 +529,8 @@ static void __init mm_init(void)
>          * bigger than MAX_ORDER unless SPARSEMEM.
>          */
>         page_ext_init_flatmem();
> +       if (want_init_on_free())
> +               pr_info("Clearing system memory ...\n");
>         mem_init();
>         kmem_cache_init();
>         pgtable_init();
>
> Beyond these thoughts, I think this series is in good shape.
>
> Andrew (or anyone else) do you have any concerns about this?
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
