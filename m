Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F3C10F0E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E902171F
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 15:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHgWugbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDLPX2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:23:28 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44136 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLPX2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 11:23:28 -0400
Received: by mail-ua1-f68.google.com with SMTP id p13so3343158uaa.11
        for <linux-security-module@vger.kernel.org>; Fri, 12 Apr 2019 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jdh+W4Qf+xTtMx1pbPDAwIHjsRVYZ/Q+sKKFxSr1S5U=;
        b=DHgWugbdN7k8WF/sQearF4OyKrHJdb5hf50SuyoxB3kU/CiRboqwFfj2wYdrBEhOTa
         bI3ytacddW8ZGOLF+aM2ibYnS3aqftIz5fpa41wBBQY/lBeVoi9bxZArS87hTj5B+oQa
         e6YoadgctME8FYDxlYQOjT5AsWvouGFv25+11SSQIoT5I4KjHOOT2+HT5+JIY8EBVFhG
         iupA/WSB5wrUMAA7M1H2+wYKxJinGjv7qT8bnQNElyD0B4SM4ImVe4ISU0C/uqyR/CZr
         q0UG48A2lGzFcQvi61xWlCTu+FscZU1RDZGJaqdlGcZSvo2FkJdbV3WgMe+55P4SdjDW
         yB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jdh+W4Qf+xTtMx1pbPDAwIHjsRVYZ/Q+sKKFxSr1S5U=;
        b=a8EdtWNhU4gPzlzEHn3Q0Reo/snhi9ISS53Tf42ZL8aq8XNQ2331eM5cg/DQipgDsQ
         j17WhYoSMCuOg1E5k3NhFGXLqGh36wVnfUD7DPjm+uK31MzQs00dTcg8AdQbXqRCa/ya
         T07wHXlG8g0jS1+MEJNPDvDE6Q4+1ZJxCg7PyQD6uP7m7jBPd1aBhybzM/OUv3rlZGEm
         qsGQGzvFk3jJUhmuGcRBhC4PBc+FpwYhJEmEDOcgcwJ2HHhePyZUnIIlKISAIZXnPWyn
         wNmPrsvQzBDQbvfVBz1Ge3WGE3j3MI7qth5Req/Ok7P5v64vcomPRPAaAg3UXEV5ysL1
         X7wA==
X-Gm-Message-State: APjAAAWpDEuYzskpFirPkYFUNSE651oopHVNnB4Tb3cRLkmSoDic+TOM
        FdZUczMIdzGdb+5Rmmm0KG6d4PpFIpir59gNshfMmw==
X-Google-Smtp-Source: APXvYqzbnOslz7WeYrsEitO9Tc3kH0tdnMuzW6L6fk3geG8DMcoHJIJERFGCopoR0I6stuauCLJ+mpIFXamNirb6J8k=
X-Received: by 2002:ab0:2399:: with SMTP id b25mr29928095uan.129.1555082607026;
 Fri, 12 Apr 2019 08:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124501.132678-1-glider@google.com> <1555078584.26196.50.camel@lca.pw>
In-Reply-To: <1555078584.26196.50.camel@lca.pw>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 12 Apr 2019 17:23:15 +0200
Message-ID: <CAG_fn=UrF6+yvXrok0Ca3dP2WZK7EOqE0NB24sR9WgMb=UuR-Q@mail.gmail.com>
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 12, 2019 at 4:16 PM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-04-12 at 14:45 +0200, Alexander Potapenko wrote:
> > This config option adds the possibility to initialize newly allocated
> > pages and heap objects with zeroes. This is needed to prevent possible
> > information leaks and make the control-flow bugs that depend on
> > uninitialized values more deterministic.
> >
> > Initialization is done at allocation time at the places where checks fo=
r
> > __GFP_ZERO are performed. We don't initialize slab caches with
> > constructors or SLAB_TYPESAFE_BY_RCU to preserve their semantics.
> >
> > For kernel testing purposes filling allocations with a nonzero pattern
> > would be more suitable, but may require platform-specific code. To have
> > a simple baseline we've decided to start with zero-initialization.
> >
> > No performance optimizations are done at the moment to reduce double
> > initialization of memory regions.
>
> Sounds like this has already existed in some degree, i.e.,
>
> CONFIG_PAGE_POISONING_ZERO
Note that CONFIG_PAGE_POISONING[_ZERO] initializes freed pages,
whereas the proposed patch initializes newly allocated pages.
It's debatable whether initializing pages on kmalloc()/alloc_pages()
is better or worse than doing so in kfree()/free_pages() from the
security perspective.
But the approach proposed in the patch makes it possible to use a
special GFP flag to request uninitialized memory from the underlying
allocator, so that we don't wipe it twice.
This will be harder to do in the functions that free memory, because
they don't accept GFP flags.




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
