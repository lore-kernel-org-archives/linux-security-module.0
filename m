Return-Path: <SRS0=MGza=UZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B71C48BD3
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6320B1F
	for <linux-security-module@archiver.kernel.org>; Wed, 26 Jun 2019 12:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LA9vnejy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZM1K (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:27:10 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38236 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZM1K (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 08:27:10 -0400
Received: by mail-vs1-f66.google.com with SMTP id k9so1440876vso.5
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6kfkIhuHoPIjfMfVB0Ztiwt1Me6klHBycZVbDOiK0gk=;
        b=LA9vnejysG80LoRMNK06zRKNClzSYlPIdhO2BG8R5WimhgksbZNGFBE1+GUiQLEifw
         eagA1Ss7o118bXvq49QRHs+qJqELP+XQixvQAYDIsNY3C8BcfX7mpLNtT8ORoVLO0I87
         c0MDtIeXo60EqlRh1gnyMvvuq9qf0CzKX64dtRn0ifZI4hXXE0kqy16Q5v4HugyKWeK2
         UuwCITTAl5UFtiD9Rs4b/geol+F+Nyj5TAz6c5zFvVJKZYPyKWMPY2Z6T+8dQC+CzHVK
         xBAsf8dcoFTgafsDg4Thp/2Chqjg9t5WhkYXBT/PqOpgZF0AEy8MdUMfUE56k+QPMpzj
         VlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6kfkIhuHoPIjfMfVB0Ztiwt1Me6klHBycZVbDOiK0gk=;
        b=h8B4qTY5IwwKzniUl4S60Xx5O784Of7tdb4v24KKPKg4Qv7KDDdOZwCrl4mAkWV9iV
         uwVyX/Fw/yxfIAWWA+AVGGR9t5d1F2UEIzeK6wvcyaF+nxRYqB/rqEAdRJQGCSakVt22
         gKFunABfpDjrPrsIIypG86sIdKCary1dssshzK5IHl7mKzhnhJU/6XXhrP/7/xSJoJsG
         k8htWDtvNAX9x30V3XonuKtDP54iiL+JXs9+ioOpMmJx54IZBZOxJu/SYYGHw2gXnrNb
         HvFvr4j0hVurWmFeF5BhuxGaBk7XZyNzdXmt5Y1VCJ7tzqrzLgJ3sR4rqsk/0W6aQoaO
         MhbQ==
X-Gm-Message-State: APjAAAXY0vZ5bPwSylkkTf5HAj+Xuvmcrtc2h+ZAmVJeaDRJUfxNWgW4
        zeZDMh7kz3n+YjABoGtR6OHr9pqFJnq8w4zaGoGJiw==
X-Google-Smtp-Source: APXvYqzFVn7+Sobi3957YqMqzgXYiYzf1aj+EhLLCRNEuqntRTM8bUrv2ro9eKC8ad0q35LYmIjx6cO3FPMvsDikbes=
X-Received: by 2002:a67:11c1:: with SMTP id 184mr2733987vsr.217.1561552028933;
 Wed, 26 Jun 2019 05:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com>
In-Reply-To: <20190626121943.131390-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 26 Jun 2019 14:26:57 +0200
Message-ID: <CAG_fn=V5o-wt5PQ4LSarpXrEGfbrdbtSFqOOag=nmMrxf4gfnA@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] add init_on_alloc/init_on_free boot options
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
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
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 2:19 PM Alexander Potapenko <glider@google.com> wro=
te:
>
> Provide init_on_alloc and init_on_free boot options.
akpm: May I kindly ask you to replace the two patches from this series
in the -mm tree with their newer versions?

> These are aimed at preventing possible information leaks and making the
> control-flow bugs that depend on uninitialized values more deterministic.
>
> Enabling either of the options guarantees that the memory returned by the
> page allocator and SL[AU]B is initialized with zeroes.
> SLOB allocator isn't supported at the moment, as its emulation of kmem
> caches complicates handling of SLAB_TYPESAFE_BY_RCU caches correctly.
>
> Enabling init_on_free also guarantees that pages and heap objects are
> initialized right after they're freed, so it won't be possible to access
> stale data by using a dangling pointer.
>
> As suggested by Michal Hocko, right now we don't let the heap users to
> disable initialization for certain allocations. There's not enough
> evidence that doing so can speed up real-life cases, and introducing
> ways to opt-out may result in things going out of control.
>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Christoph Lameter <cl@linux.com>
> To: Kees Cook <keescook@chromium.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: linux-mm@kvack.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
>
> Alexander Potapenko (2):
>   mm: security: introduce init_on_alloc=3D1 and init_on_free=3D1 boot
>     options
>   mm: init: report memory auto-initialization features at boot time
>
>  .../admin-guide/kernel-parameters.txt         |  9 +++
>  drivers/infiniband/core/uverbs_ioctl.c        |  2 +-
>  include/linux/mm.h                            | 22 ++++++
>  init/main.c                                   | 24 +++++++
>  mm/dmapool.c                                  |  4 +-
>  mm/page_alloc.c                               | 71 +++++++++++++++++--
>  mm/slab.c                                     | 16 ++++-
>  mm/slab.h                                     | 19 +++++
>  mm/slub.c                                     | 43 +++++++++--
>  net/core/sock.c                               |  2 +-
>  security/Kconfig.hardening                    | 29 +++++++++
>  12 files changed, 204 insertions(+), 19 deletions(-)
> ---
>  v3: dropped __GFP_NO_AUTOINIT patches
>  v5: dropped support for SLOB allocator, handle SLAB_TYPESAFE_BY_RCU
>  v6: changed wording in boot-time message
>  v7: dropped the test_meminit.c patch (picked by Andrew Morton already),
>      minor wording changes
>  v8: fixes for interoperability with other heap debugging features
> --
> 2.22.0.410.gd8fdbe21b5-goog
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
