Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A0C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39702084C
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAJkV0ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfDIIzk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:55:40 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35402 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIIzk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 04:55:40 -0400
Received: by mail-vk1-f196.google.com with SMTP id g24so3696467vki.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n/N705f5ZyWxyWfJ8A9AUDWgj16UZ43brk6IRKypk4g=;
        b=EAJkV0gaFMK93JAZJc7QYuqWPAykzEV9jNpU3T4qKw+56tY/wo4a6iifXqRhdEzkif
         C4GUeqBqtyq2tkL6CkTYycBbksyrTH7aamLPGeXIBtVppe8YitRthSOW+5LIrTuRAUZx
         1l7fXiWT7Bp+ILx7ONIpKcTuKx4wNfYxOkd691bqqH8yVCol++M4VqKE3uhz1TZTZQz4
         7dxiuYD4IzM1+NAEeTyjbv6glEWYJNdo9WwVzpWfHbivVHn2/hGo+xgFOjXd3Ludce19
         FWFWD+Y4/bA1r5t7mn6ESbCWZ6H5HwMSAwf7+dvvBi0hWbwalR1FcHjj6/cKB2JQSx5n
         DLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n/N705f5ZyWxyWfJ8A9AUDWgj16UZ43brk6IRKypk4g=;
        b=JGgYcbLIhxsZL2ASfy/OMCSyr7GJNIfnzGtde6nkgo1q7a+j2PcrSYras5bLg5wt3V
         GQAjfzTVnYAiuVnI3l99/wf2s9MxdidzBsOV+yz1MwgTjRo3eLe6X/5IZB28AzGGHQKN
         uMY9K9vvYOcN77SmAGWR2H/Fh1I1Isld1xnCcJddtsx04aTENbKU+ZyKo/sNOFij+t7G
         OCuilP+BbARjux/PWDENex3MGA7cpPhfB8yT3T3jwndkOyatuubpHk6JoPCUrI9TEzD6
         PyGG8fDpA9+898jjGIl3+ss6zpbx8LG103jbl3+KuYj6Y5M7JwtBG/8+rMDTlUyppVe4
         3FCg==
X-Gm-Message-State: APjAAAWkspgPiJaGI9aa/DugfVsYBJ5pC/ayhjMmiQ8pgZ1CWz44Klck
        vaLkv/ZZpdPfzvaN2HAQ9afCxSuo8fBkaHN39W2l5g==
X-Google-Smtp-Source: APXvYqxo3+Gh4YUPYh/i9n2SfF4YMlEh7bxTK2hNU7gXposB84hLHd1NVvF0FwJF0+yIzyv+aBWhzKTbuxZeZO1/9ng=
X-Received: by 2002:a1f:4c3:: with SMTP id 186mr19347278vke.26.1554800138744;
 Tue, 09 Apr 2019 01:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190308132701.133598-1-glider@google.com> <20190308132701.133598-3-glider@google.com>
 <497b1201-b2ae-5e0c-d191-ff1830d92fc1@redhat.com> <CAGXu5jJUWKiyW-_ygHpg9rJc7wQ2XTzjH71CtJfdefLu2zZHEg@mail.gmail.com>
In-Reply-To: <CAGXu5jJUWKiyW-_ygHpg9rJc7wQ2XTzjH71CtJfdefLu2zZHEg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 9 Apr 2019 10:55:27 +0200
Message-ID: <CAG_fn=WGOCsHZ4stECA9nUBUMCL9SA76QKTy3FifLxmTfsQivg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] initmem: introduce CONFIG_INIT_ALL_HEAP
To:     Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 7:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Apr 8, 2019 at 9:43 AM Laura Abbott <labbott@redhat.com> wrote:
> > I've looked at doing something similar in the past (failing to find
> > the thread this morning...) and while this will work, it has pretty
> > serious performance issues. It's not actually the poisoning which
> > is expensive but that turning on debugging removes the cpu slab
> > which has significant performance penalties.
> >
> > I'd rather go back to the proposal of just poisoning the slab
> > at alloc/free without using SLAB_POISON.
>
> I still agree this would make the most sense. Fundamentally it's not a
> debugging feature.
Wasn't it you who suggested using SLAB_POISON in the first round of comment=
s? :)

I actually have a working implementation that piggybacks on existing
__GFP_ZERO code to initialize page_alloc() and SLUB allocations:
https://github.com/google/kmsan/commit/4907af529ad525378a0728435c96d3812f71=
e594
https://github.com/google/kmsan/commit/69618a9668bcf27700cc5da42eebf8ab50d1=
f56a

I'd better cook a patch based on that.

There's also some overhead when allocations are initialized twice (in
page_alloc() and kmalloc()) or thrice (page_alloc(), kmalloc() and
e.g. sock_alloc_send_pskb())
We can introduce another GFP flag explicitly telling the allocator to
not initialize the memory chunk if we know it'll be initialized by a
higher level allocator
(something along the lines of
https://github.com/google/kmsan/commit/4fc8cff79d868c29688c8a4186e504fda362=
f6fd)
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
