Return-Path: <SRS0=lnE7=U2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BE0C48BD9
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682F22086D
	for <linux-security-module@archiver.kernel.org>; Thu, 27 Jun 2019 13:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OC1UYhpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0NRN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:17:13 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43544 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NRN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 09:17:13 -0400
Received: by mail-ua1-f67.google.com with SMTP id o2so812233uae.10
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vy9qWbldNZVn/tHHwiK7Of/LXRmbGzfYDFquQFBj1LU=;
        b=OC1UYhpBFS959lMOYt/IcpryLBaWsNxeZVjDmulenf6LUHVyIdy908unuOq9TESJxu
         /jkJrUavVPEjsBXhsHduYzVOFoca0ZCd4/4qS+y7GeZOz2qnbNZ6yE2ezvymUQUwMXnR
         1VBmCcxbiwfi2K6u4ZxvPrSSuN3Y9Ij2zo7Bae2jaObMlfvrnv5Ov4dPgNdHTK+qdcws
         Xt7uk5cQg4hAD3lWE8r3HMBcfVDD3YNIQ0V1yLsVqZXyx0KXXdvzjV0oKSwobxrX9bD6
         jVZoIO6OtjAntp/8ckwjiNzV+G7Xru+qFaE5KcbKor98V1qhpmDHM3UagK4fo3NvTHvd
         Qs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vy9qWbldNZVn/tHHwiK7Of/LXRmbGzfYDFquQFBj1LU=;
        b=ip/GkaigZiNL3m9TcDDeY4DurwxDa/Aljq4rqVK9DVMEokbjxeN0sp6c8/4YCIFasW
         GoNr00m6XIaKNPr9Q6+hplir4b2bvD35lDKjs2Kf/7xLleqQLmUygS5alcMA45kLvz6P
         izS0e5D6rMiGZNZln3sUCYiKoQGX6b3ag5e/YrBuHqLxKdO76RlAVoJ+Ow2TtjGFnFAi
         rjkTwueag+TGhfUWGXwXJfyqxR1zKRTCQthslF69lhiNDmFGH9ToeSUQ1agCVi3OHay2
         Re1MSYHW3nUIMFLC5mgccC9eeejLqWpCSL07gEDFHy2k2/jeumBC+pVHSfwvStltf2vO
         gLGw==
X-Gm-Message-State: APjAAAUlMmtHPhX0mlvKUlm2a7CBgzYNinuxQH9g7wjBIjOJZ1gv/ujz
        oa424HUea6uB+XLxY8pWPuca1AoUgALDIutOkbLIng==
X-Google-Smtp-Source: APXvYqztRBRUmdw5LT1ObTf3jCkBOxfHFV2ozeQLBqAbyAIQTUUdoZukbB+6Skv3+6Fb/xNGQlqQRi+6N5axxh0px5w=
X-Received: by 2002:ab0:308c:: with SMTP id h12mr2232235ual.72.1561641432229;
 Thu, 27 Jun 2019 06:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121943.131390-1-glider@google.com> <20190626121943.131390-2-glider@google.com>
 <20190626162835.0947684d36ef01639f969232@linux-foundation.org>
In-Reply-To: <20190626162835.0947684d36ef01639f969232@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 27 Jun 2019 15:17:00 +0200
Message-ID: <CAG_fn=WM_x9wUQNCwGB7BnKJqSpTMZGcf1Jxae-PHij8E9igjg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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

On Thu, Jun 27, 2019 at 1:28 AM Andrew Morton <akpm@linux-foundation.org> w=
rote:
>
> On Wed, 26 Jun 2019 14:19:42 +0200 Alexander Potapenko <glider@google.com=
> wrote:
>
> >  v8:
> >   - addressed comments by Michal Hocko: revert kernel/kexec_core.c and
> >     apply initialization in dma_pool_free()
> >   - disable init_on_alloc/init_on_free if slab poisoning or page
> >     poisoning are enabled, as requested by Qian Cai
> >   - skip the redzone when initializing a freed heap object, as requeste=
d
> >     by Qian Cai and Kees Cook
> >   - use s->offset to address the freeptr (suggested by Kees Cook)
> >   - updated the patch description, added Signed-off-by: tag
>
> v8 failed to incorporate
>
> https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_a=
lloc=3D1-and-init_on_free=3D1-boot-options-fix.patch
> and
> https://ozlabs.org/~akpm/mmots/broken-out/mm-security-introduce-init_on_a=
lloc=3D1-and-init_on_free=3D1-boot-options-fix-2.patch
>
> it's conventional to incorporate such fixes when preparing a new
> version of a patch.
>
v9 contains these patches (I've also exported init_on_free), so should
now be fine to drop them.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
