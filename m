Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A0CC10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 15:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9E52183E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5+tz0AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389535AbfDRPod (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:44:33 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45300 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbfDRPod (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 11:44:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id c13so886138uao.12
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XKqKQT0z8uVafmk205Lc9H8n7pW8a7n6L2F4uw5JQKI=;
        b=j5+tz0AJFtyJzHuErEHF+kxnXTWD/csOQdip3YJLRbf7e2jidiWMmZaRCot5M+wrkC
         OujW4JyzRtiVxRMSlxqJdX87IQD7GFwQWET7aDTzZst2Ik2c97BCxX04i9o4H4irSoKK
         u9qLHZ5N5eSwE/Rls2in8Li1OkJzh22uvfVAINwJ47OCiTGWXHPrn5AVqpbc8ISJ0gcE
         QWmGPxUZf41Xr/ql5zusGGOx7fU9U1eEiOJ2oQnOI3og8bWRcHcEH7RZ+CjzwQprFb3q
         x3UBZadD/405RcVSsmUZC4mS4ObTgqxiegY3H9Gt3Nk4HkTBQmp+ShR6w4z/M7LZCZyC
         qJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XKqKQT0z8uVafmk205Lc9H8n7pW8a7n6L2F4uw5JQKI=;
        b=lnABAq573au6d18pOwJGle+VvjYSsPkBEmAUL9JcvEZOld04OaEcJxQGPPEbAYeZou
         f+MTabqhvKwfo7mLlE1P5r97890nj/8wZDLNqMEzt9OYaUhc38yx3YqmT2szO8hkHhye
         G/DTz3MohKDEnCB6K1umLPaDD+e1xB1LpShEBVBigEaTPj8lBK2GXujnFbhr2ZS5pptU
         lgh/gZdQ9owyeHWBR4IQuYg1Gf1gJpyV5l/YI7MquTn49lP+9ufFt2m6/DwbOeB9mXpM
         rSyiTC8g8Qr03j6yWZZVypFmc32+FBnF9yGIziohDWLAvlvY4lh6YJxWj7CZ8O5QaXYa
         grnw==
X-Gm-Message-State: APjAAAVzJrBtAB8KkASmwG2dr2BeSbjtBrKrZten4q/P1JCs8BMSpnyv
        xC0rgpO2zfqiTI+OCuxtwP0EjFY/jjVmFT023o4WmQ==
X-Google-Smtp-Source: APXvYqy2REoK/bFJdMT+jP45oghXzeqqEWNYTxO2L5mIesKVuNRVMBGEHfYVUcO7LbBmGg2mFlf7+UWbkbruYIsS5Do=
X-Received: by 2002:ab0:44e:: with SMTP id 72mr50490792uav.110.1555602272470;
 Thu, 18 Apr 2019 08:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com>
In-Reply-To: <20190418154208.131118-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 18 Apr 2019 17:44:20 +0200
Message-ID: <CAG_fn=WZbf8CfxHB2SXpR5OON3NP3GkfPWQ1OeooqJRBao28rQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: add init_allocations=1 boot option
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 18, 2019 at 5:42 PM Alexander Potapenko <glider@google.com> wro=
te:
>
> Following the recent discussions here's another take at initializing
> pages and heap objects with zeroes. This is needed to prevent possible
> information leaks and make the control-flow bugs that depend on
> uninitialized values more deterministic.
>
> The patchset introduces a new boot option, init_allocations, which
> makes page allocator and SL[AOU]B initialize newly allocated memory.
> init_allocations=3D0 doesn't (hopefully) add any overhead to the
> allocation fast path (no noticeable slowdown on hackbench).
>
> With only the the first of the proposed patches the slowdown numbers are:
>  - 1.1% (stdev 0.2%) sys time slowdown building Linux kernel
>  - 3.1% (stdev 0.3%) sys time slowdown on af_inet_loopback benchmark
>  - 9.4% (stdev 0.5%) sys time slowdown on hackbench
>
> The second patch introduces a GFP flag that allows to disable
> initialization for certain allocations. The third page is an example of
> applying it to af_unix.c, which helps hackbench greatly.
>
> Slowdown numbers for the whole patchset are:
>  - 1.8% (stdev 0.8%) on kernel build
>  - 6.5% (stdev 0.2%) on af_inet_loopback
>  - 0.12% (stdev 0.6%) on hackbench
>
>
> Alexander Potapenko (3):
>   mm: security: introduce the init_allocations=3D1 boot option
>   gfp: mm: introduce __GFP_NOINIT
>   net: apply __GFP_NOINIT to AF_UNIX sk_buff allocations
Oops, I was hoping git send-email would pull all the Cc: tags from the
patches and actually use them.
>  drivers/infiniband/core/uverbs_ioctl.c |  2 +-
>  include/linux/gfp.h                    |  6 ++++-
>  include/linux/mm.h                     |  8 +++++++
>  include/linux/slab_def.h               |  1 +
>  include/linux/slub_def.h               |  1 +
>  include/net/sock.h                     |  5 +++++
>  kernel/kexec_core.c                    |  4 ++--
>  mm/dmapool.c                           |  2 +-
>  mm/page_alloc.c                        | 18 ++++++++++++++-
>  mm/slab.c                              | 14 ++++++------
>  mm/slab.h                              |  1 +
>  mm/slab_common.c                       | 15 +++++++++++++
>  mm/slob.c                              |  3 ++-
>  mm/slub.c                              |  9 ++++----
>  net/core/sock.c                        | 31 +++++++++++++++++++++-----
>  net/unix/af_unix.c                     | 13 ++++++-----
>  16 files changed, 104 insertions(+), 29 deletions(-)
>
> --
> 2.21.0.392.gf8f6787159e-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
