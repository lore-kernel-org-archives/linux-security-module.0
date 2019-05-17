Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56A0C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 15:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF2720833
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q5IfUkcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfEQPv3 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 11:51:29 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34353 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfEQPv3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 11:51:29 -0400
Received: by mail-ua1-f65.google.com with SMTP id 7so2877796uah.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K3Vrlw7jjRTYTYz1AgzZI4h2eYnMN5BSgG9wzkqpLb0=;
        b=Q5IfUkcu0WjvcwlvR433YNjz64oeJCmRNDPkXbu+8hETl16gDKE6zTXpu6p7dkY4N6
         eVDjSXDI68k8ExtJHdN9UzmOP59bD8K8byBeWHXqf412MKC5e9prPRzi3StboEwqSfBQ
         8ZR2HIXUoQdqnMfp5QvDj8NFr5+DgQqGn8+ijVud/bPYdLOjbXeDS2j2K65qMHQbSC5v
         uZqu4G2sBJesTbY1c/9Aw5oiSoi6puEXKeTyG20jFKniAvjJRF/Pt1fqyb5+ev06/pNi
         1COM50IkfipdjLx3eakFwDTxCMtxfKpDbmZrjSvtJNABugPn0s2DEgjjb6XW07fkNBX/
         cpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K3Vrlw7jjRTYTYz1AgzZI4h2eYnMN5BSgG9wzkqpLb0=;
        b=lEtRrOziIq5US+YtYpCiuJUfhRPBxYK3jsMNQcCq2fV7RiNivBXuQSHyVA4UVGo1ns
         S1aUU4R/Mmy5CxvNLlrjgp4UnzdksQ4N6QrBMghRf+xBxQXL6Y4Z6F4dB7wC7Pgjg58E
         i7EcWm4KdsiGy0ozujtmCHERgkmp5yIdiDLof2m8kBwEI3xZ16tIaM3y+GW7x18Kclom
         oj1bYi9ZsfbyBuMJu3cwhFhyXUXlUWkWYyWxYOeYg88a8riEVYBGHVwAVr3/OEbjQTJ6
         dra31jU+Bjfjs2GhZcnXuhW+JuIIhv3t7TUCE6uxVDWBW/kVo5njDZhmE+mlL71YTJE5
         4Stg==
X-Gm-Message-State: APjAAAWI8I2dAlO2EO9XLyrU9mOCEPHUDvd98VBcrUzABF1dIu5+fxXT
        ZikiSd9QBp9AHz5uZt6ItH+FZaC3SfCNyRDqSHaO/Q==
X-Google-Smtp-Source: APXvYqyHBgjr6zQkV0VRITOnSTFo/Csy6VlzF4/NnOlUkrs7+IUo77Uxkz08YROnpav8K6N0iIzd8ewuExL2rchVXBY=
X-Received: by 2002:ab0:d95:: with SMTP id i21mr22915022uak.110.1558108288339;
 Fri, 17 May 2019 08:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-3-glider@google.com>
 <201905151752.2BD430A@keescook>
In-Reply-To: <201905151752.2BD430A@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 May 2019 17:51:17 +0200
Message-ID: <CAG_fn=VVZ1FBygbAeTbdo2U2d2Zga6Z7wVitkqZB0YffCKYzag@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] lib: introduce test_meminit module
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, May 16, 2019 at 3:02 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, May 14, 2019 at 04:35:35PM +0200, Alexander Potapenko wrote:
> > Add tests for heap and pagealloc initialization.
> > These can be used to check init_on_alloc and init_on_free implementatio=
ns
> > as well as other approaches to initialization.
>
> This is nice! Easy way to test the results. It might be helpful to show
> here what to expect when loading this module:
Do you want me to add the expected output to the patch description?
> with either init_on_alloc=3D1 or init_on_free=3D1, I happily see:
>
>         test_meminit: all 10 tests in test_pages passed
>         test_meminit: all 40 tests in test_kvmalloc passed
>         test_meminit: all 20 tests in test_kmemcache passed
>         test_meminit: all 70 tests passed!
>
> and without:
>
>         test_meminit: test_pages failed 10 out of 10 times
>         test_meminit: test_kvmalloc failed 40 out of 40 times
>         test_meminit: test_kmemcache failed 10 out of 20 times
>         test_meminit: failures: 60 out of 70
>
>
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Kees Cook <keescook@chromium.org>
>
> note below...
>
> > [...]
> > diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> > new file mode 100644
> > index 000000000000..67d759498030
> > --- /dev/null
> > +++ b/lib/test_meminit.c
> > @@ -0,0 +1,205 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > [...]
> > +module_init(test_meminit_init);
>
> I get a warning at build about missing the license:
>
> WARNING: modpost: missing MODULE_LICENSE() in lib/test_meminit.o
>
> So, following the SPDX line, just add:
>
> MODULE_LICENSE("GPL");
Will do, thanks!
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
