Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BE3C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD40220883
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOCDO7A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfDII3o (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:29:44 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43049 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDII3n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 04:29:43 -0400
Received: by mail-vs1-f68.google.com with SMTP id i207so9280552vsd.10
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 01:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ugCi4wSufzvPQhakuyN4WYm2qyJjDpyHxEL0pNGqAyM=;
        b=eOCDO7A1ruxoEkPL+a+a7rTpJ2/XMwj+HN+g/xM2Nb8FRH+PIthV+DgY6sj3tHbgRG
         lFeBQZpy8P90eMSLPYZg9wOC0H/o1YAAif9aNTEqwOuv8h9IPp/sUznr9RObP2UvEQAk
         d7F5fOtDDSF+fqLCnTuO+MLVyJP8BO13KYB8tRtY+cnoiEEYUBO1+/00r70QRnmAUcDu
         vOmp3cvtg0Btn3H171SmNC3qt/YtBdn23/C1e+vCwFaB3XzLW1u0gV+kz/6EhsdvDVKR
         xZrM6Zu18Xtt2t+lkONQoQU67DHWb39gtEKm2+1/gpVTfiELqPtfKhteaFniiiGVeySA
         mRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ugCi4wSufzvPQhakuyN4WYm2qyJjDpyHxEL0pNGqAyM=;
        b=fNOPyr9fz7oHQ6ockK6508je3OnYKRzz9c6jsHOVw+2xMe0DglNByx9+py5I8in0I5
         v/e2j1C6JoXxoEpXn+mhDtJZkxFFmH3NfZIcG/PFkIN4hR+BSBYowrp5Dd5JdxYq5oFL
         EEFcUDNnyiYIfmSM1mBnrOakq2/qPBk06l0hELHOFF8NATF/jOCRtKbXq5Hh0Dyy0Kzn
         BB0uL3b/fVBa3hRv93+uEviD9sqhKDIUxl5E5Z2aZukyrMC8bk43JqG2QCTWsnz1CRjB
         3cOQAf0tQpeL1PQR60P1HMrCNDVdV838thl+bpyzMVqB2SqGnXJBdV0YyX9RpWL2tGfs
         vISw==
X-Gm-Message-State: APjAAAVUWBjYPUF2b19HV6U1EPEuM3g7c/LHKtzONIqY6DSKUalYB0c2
        ponCFv1k/8wvFcDMaHt/nzyrewJhB8rk3UKitIfU6A==
X-Google-Smtp-Source: APXvYqxA++yH0nKtTIIW5Uboh0XsMDP3uUOXlUZsnfnNGFTyuDffuCnml94Xvd/RqXzlg6tYdCDPuIGL6GQJVKlNImo=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr1257238vsn.96.1554798582136;
 Tue, 09 Apr 2019 01:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190408170418.148554-1-glider@google.com> <20190408170418.148554-2-glider@google.com>
 <adb23353-2e02-ecd2-7506-50f4db814b25@infradead.org>
In-Reply-To: <adb23353-2e02-ecd2-7506-50f4db814b25@infradead.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 9 Apr 2019 10:29:30 +0200
Message-ID: <CAG_fn=V2aMoWnKfqC7eomEgFtjedcfmF0O2FF-ZPxC9x0aMDcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] initmem: introduce CONFIG_INIT_ALL_MEMORY and CONFIG_INIT_ALL_STACK
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sandeep Patil <sspatil@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 9, 2019 at 12:15 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/8/19 10:04 AM, Alexander Potapenko wrote:
> > diff --git a/security/Kconfig.initmem b/security/Kconfig.initmem
> > new file mode 100644
> > index 000000000000..5e49a55382ad
> > --- /dev/null
> > +++ b/security/Kconfig.initmem
> > @@ -0,0 +1,29 @@
> > +menu "Initialize all memory"
> > +
> > +config CC_HAS_AUTO_VAR_INIT
> > +     def_bool $(cc-option,-ftrivial-auto-var-init=3Dpattern)
> > +
> > +config INIT_ALL_MEMORY
> > +     bool "Initialize all memory"
> > +     default n
> > +     help
> > +       Enforce memory initialization to mitigate infoleaks and make
> > +       the control-flow bugs depending on uninitialized values more
> > +       deterministic.
> > +
> > +if INIT_ALL_MEMORY
> > +
> > +config INIT_ALL_STACK
> > +     bool "Initialize all stack"
> > +     depends on INIT_ALL_MEMORY
>
> This "depends on" is redundant with the "if INIT_ALL_MEMORY" above it.
Ack, thank you!
> Similar comment for patch 2/2 and INIT_ALL_HEAP.
>
> > +     depends on CC_HAS_AUTO_VAR_INIT || (HAVE_GCC_PLUGINS && PLUGIN_HO=
STCC !=3D "")
> > +     select GCC_PLUGINS if !CC_HAS_AUTO_VAR_INIT
> > +     select GCC_PLUGIN_STRUCTLEAK if !CC_HAS_AUTO_VAR_INIT
> > +     select GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if !CC_HAS_AUTO_VAR_INIT
> > +     default y
> > +     help
> > +       Initialize uninitialized stack data with a fixed pattern
> > +       (0x00 in GCC, 0xAA in Clang).
> > +
> > +endif # INIT_ALL_MEMORY
> > +endmenu
>
>
> --
> ~Randy



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
