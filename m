Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82C2C10F13
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 12:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62F42054F
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5FJ1dSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfDPMFD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:05:03 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36945 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPMFD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Apr 2019 08:05:03 -0400
Received: by mail-ua1-f67.google.com with SMTP id l17so6632164uar.4
        for <linux-security-module@vger.kernel.org>; Tue, 16 Apr 2019 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6d0Pvgzrg/FmC5CP2ha7gINMxyg3P7BhpdWAeKewFg=;
        b=m5FJ1dSxPq9N1yfTJovgaWYa5NFqG2+ItFUiNA/h5JnVSVkqXiCJfcDhBDgbFV11wS
         Z7Q/W3zS3sB8uFIohFm8BRqcH5yGiTYemqCz0XikfFKnx67EaiziVKyVDP0ncncUWkDn
         MNITMvclkCfB6Bwkt1P6WBWYNkHP4o3JO3gNtYKpA3+tcmF7TxhcUSUxFqvRlLT4ac4P
         xwjz1hKpqJXFvpp2+7esW4d8GAN/M5NtHkGgaNCA8saW5Rd6rEW6nlCD3i6wB5UaKxV3
         A7Lv6I8oTz5pAG7gxbb9rAAhW+DCtaTzAtvfqbL0dO6CuA2wa+ESao0DWE3MQ4sQEVTX
         tjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6d0Pvgzrg/FmC5CP2ha7gINMxyg3P7BhpdWAeKewFg=;
        b=ST8tfdFLi/kfUwMKbGLl8iZsMBVkMkN0Er9lvEkO8KdaJ5f1mNC99ZA9Z8J2uvzvVO
         Ap73DNnd4sPJ9YzZE9zWNfKfLKMyEmjmAx69/DXsIT9mDH3JpdZA3JCnhLfTDRuJZS+g
         cmPg4XVrMRAMSZC+v80lz6Es0iMJl2MAkCGNofMZSJ0xwkrtVnUaTK+qm9cgeBsp9oNK
         0GH3qCGz03ZrvstcYc3yyj7tcdDJzJVtpKzNdg1ciDNuF/61gUnwF8MFhgB+CRtXRqYo
         EKqeOhFfWsYJnl3nKIa7X13wUiSGcS6Ji5nQ8SqIMZbE1qa8xm/aHo7dQvRVsCma83CH
         yB9w==
X-Gm-Message-State: APjAAAWNXlCMf4xJrz/i6bnfvMSmWKr8R2iq2TbOakvFq/e2fgblzsWr
        ji+7B9yZsYN7fV37x0pxHgFslO62GqfjhteifYnkWoSKXC8=
X-Google-Smtp-Source: APXvYqyWqZeF0fEmsHx1epJQny3J0neTEO0LACZRViyfMSGIG0I4vBO2Rx9YCjnFU8Xj23TYjNlIDDNGyEJCMdPsvc8=
X-Received: by 2002:ab0:60cd:: with SMTP id g13mr2954540uam.85.1555416301693;
 Tue, 16 Apr 2019 05:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190412124501.132678-1-glider@google.com> <35935775-1c0d-6016-5bb3-0abee65a7492@suse.cz>
In-Reply-To: <35935775-1c0d-6016-5bb3-0abee65a7492@suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 16 Apr 2019 14:04:49 +0200
Message-ID: <CAG_fn=VYa0CtxDeXOV0Mpj3q_i150NJioyJWGLA3OEij3iSH1A@mail.gmail.com>
Subject: Re: [PATCH] mm: security: introduce CONFIG_INIT_HEAP_ALL
To:     Vlastimil Babka <vbabka@suse.cz>
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

On Tue, Apr 16, 2019 at 10:33 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 4/12/19 2:45 PM, Alexander Potapenko wrote:
> > +config INIT_HEAP_ALL
> > +     bool "Initialize kernel heap allocations"
>
> Calling slab and page allocations together as "heap" is rather uncommon
> in the kernel I think. But I don't have a better word right now.
We can provide two separate flags for slab and page allocator to avoid this=
.
I cannot think of a situation where this level of control is necessary
though (apart from benchmarking).
> > +     default n
> > +     help
> > +       Enforce initialization of pages allocated from page allocator
> > +       and objects returned by kmalloc and friends.
> > +       Allocated memory is initialized with zeroes, preventing possibl=
e
> > +       information leaks and making the control-flow bugs that depend
> > +       on uninitialized values more deterministic.
> > +
> >  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
> >       bool "Report forcefully initialized variables"
> >       depends on GCC_PLUGIN_STRUCTLEAK
> >
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
