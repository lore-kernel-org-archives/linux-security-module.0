Return-Path: <SRS0=Yqxb=TI=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C427C04A6B
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC20B21019
	for <linux-security-module@archiver.kernel.org>; Wed,  8 May 2019 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m92uaGS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEHTCz (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 8 May 2019 15:02:55 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33533 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEHTCz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 15:02:55 -0400
Received: by mail-ua1-f68.google.com with SMTP id 49so4381955uas.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2019 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX9oXO6R8RSoriR7UuMavFbYp9KwYJM8lFYFBoOuLJY=;
        b=m92uaGS7BzxI1wVpXXvaee5KcFPVbYEfR4QwuEzpRo01tnMlXnsfG1+9jSbDgVZcpc
         XNHNcYd8H5QtBO9qWK6wCVr9bpXIoXzsClBTyRoZZCbqfbL+fltIwZpitSG3qyPECNqE
         EJ6/PUuxsKSI0Z7dM32euMjjSJDl+Ux09evt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX9oXO6R8RSoriR7UuMavFbYp9KwYJM8lFYFBoOuLJY=;
        b=qeIkN0LCpTh/tYoVCC55bl9DpykaKBEmClT5f7jM4gvLiDsANW+lYcrKYFY7s9cp52
         AbkOeHl0BtQUxPg2WJWvk6xGZ+9ZdfaNQi/4NcnTfVeP3sbLQMrHdI/aS6OdJkSfqZ1z
         5IEGHj8H4i1smoWzKozEm5gjuuuNQxrD/SG2sY+pcHmD+k/ieJbr0TlblV//3OrXyKyT
         6etOIpR7qc9dnl8e/3E3CuZlS6njihC3m4+yggWOU0EKMbNJfpE1KYaNNGRz37PN7Cph
         /AiJPnCCJzF3xQvkjdDIC5/0mzfoAm5JDaU1Qouvz6I0L5TzkgR0CVdyUC9eAR54ZXms
         ZE0g==
X-Gm-Message-State: APjAAAX2fzNWGLPjn9t66NHStwG7VuaPgurvTDOrlUbIf5Z9APkO3cAh
        2mbiUbNE9HjgQui8Y/SlxoBuztgEWPk=
X-Google-Smtp-Source: APXvYqw1rcBXBediuoXHx5YKz8uEyrtwbHug2N+thEkhdDYMv1Npl/S+wtHyv/KNRGewtCC+d7VOvw==
X-Received: by 2002:a9f:3273:: with SMTP id y48mr20748314uad.38.1557342173027;
        Wed, 08 May 2019 12:02:53 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id s17sm1841076vsn.23.2019.05.08.12.02.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 12:02:51 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id c24so6457819vsp.7
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2019 12:02:51 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr15808201vsp.188.1557342170854;
 Wed, 08 May 2019 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190508153736.256401-1-glider@google.com> <20190508153736.256401-2-glider@google.com>
In-Reply-To: <20190508153736.256401-2-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 May 2019 12:02:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKfxYfRQS+CouYZc8-BMEWR1U3kwshu4892pM0pmmACGw@mail.gmail.com>
Message-ID: <CAGXu5jKfxYfRQS+CouYZc8-BMEWR1U3kwshu4892pM0pmmACGw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 8, 2019 at 8:38 AM Alexander Potapenko <glider@google.com> wrote:
> The new options are needed to prevent possible information leaks and
> make control-flow bugs that depend on uninitialized values more
> deterministic.

I like having this available on both alloc and free. This makes it
much more configurable for the end users who can adapt to their work
loads, etc.

> Linux build with -j12, init_on_free=1:  +24.42% sys time (st.err 0.52%)
> [...]
> Linux build with -j12, init_on_alloc=1: +0.57% sys time (st.err 0.40%)

Any idea why there is such a massive difference here? This seems to
high just for cache-locality effects of touching all the freed pages.

-- 
Kees Cook
