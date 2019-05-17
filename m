Return-Path: <SRS0=DuHk=TR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D9C04AB4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683D216F4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 May 2019 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhjgdN7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEQOLp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 May 2019 10:11:45 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38359 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfEQOLp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 10:11:45 -0400
Received: by mail-ua1-f67.google.com with SMTP id r19so2128305uap.5
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yPJC3km5fQmSqwkKg0IjAisXnGkZMwPlofzvwmFfzTw=;
        b=EhjgdN7emCfeHXsoZMJ6Wj40u+K0XLKFFOKVL9cg3V+WH/c2YCU/n4ecYmVtHgKjHJ
         dtcKp1uarWS6UvEpwooJa4R7FNsW2kXMw4xOacmOPwlyZidzuxlrR+0uvSHkNLn5yUII
         +XP3M436OKMrLZSqSNxWKTmBL+mve4IC0pu2mPDyLlKaIRWUa/MqVE/uQn0Eu9tNH0Ab
         H1TItWp/mTaqBicBRuNPZ/zsD8Yl8IgYY4D/Eg47qVFNmJqUR9MFTMapElXkIPIIVeNF
         RfmK79DUWvsHRfjG9l+OaVKWPE9M65hLfms3E9J6bR595KANlWKWG/AscHpg+TRC5Ga6
         EJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yPJC3km5fQmSqwkKg0IjAisXnGkZMwPlofzvwmFfzTw=;
        b=brxN26Be0uQJKsLjQyVDvoZ037APwo5apF3so7RpV6ev7DVApg8bYnJtR5+sqWJGcA
         gWmjof+6KGaygRqNQWFwdc+bjL3dOvo6L7a8gN3DWpu28gAYZ5YhAp6X8PmXh5bJ5ICs
         9dG5iPAOGCUjqVNIuJVvQtZLGAyIEXPDeK/cEWkDcNH0dg73SMaKhSSl55BFgE9KcTkN
         L38DgB01mmDW+1qCvICuKAN8pIDE+tvuBw/JiZmVM6l9syOVCV4WNT+hwkJzc4qHGe4D
         uAD5C+KQjxi+ZA/LlfDtSgKUbeP6kkAtkIqrfzlQ/EWTXnOlGPFGnbgxNZ61kz52rdbS
         8VhQ==
X-Gm-Message-State: APjAAAURUR7nbIhjgYbbZzgM11E/e5gnvhv401XmWrUOwkppMzeMFJjz
        Gkpw4bNRVbhdRKyc4M9GHCK5r/uGmN4ILQcP6C/xDQ==
X-Google-Smtp-Source: APXvYqzNwEP3/rmvtRb4XJJMVsKuA4IxchtkUNa8GybLvlIZbRD9HfA6ovC4X627LbY06pBrs3DVvrUPTJ2RagiavLQ=
X-Received: by 2002:ab0:1d8e:: with SMTP id l14mr6084453uak.72.1558102303960;
 Fri, 17 May 2019 07:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190514143537.10435-1-glider@google.com> <20190514143537.10435-2-glider@google.com>
 <20190517140446.GA8846@dhcp22.suse.cz>
In-Reply-To: <20190517140446.GA8846@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 May 2019 16:11:32 +0200
Message-ID: <CAG_fn=W4k=mijnUpF98Hu6P8bFMHU81FHs4Swm+xv1k0wOGFFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
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

On Fri, May 17, 2019 at 4:04 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 14-05-19 16:35:34, Alexander Potapenko wrote:
> > The new options are needed to prevent possible information leaks and
> > make control-flow bugs that depend on uninitialized values more
> > deterministic.
> >
> > init_on_alloc=3D1 makes the kernel initialize newly allocated pages and=
 heap
> > objects with zeroes. Initialization is done at allocation time at the
> > places where checks for __GFP_ZERO are performed.
> >
> > init_on_free=3D1 makes the kernel initialize freed pages and heap objec=
ts
> > with zeroes upon their deletion. This helps to ensure sensitive data
> > doesn't leak via use-after-free accesses.
>
> Why do we need both? The later is more robust because even free memory
> cannot be sniffed and the overhead might be shifted from the allocation
> context (e.g. to RCU) but why cannot we stick to a single model?
init_on_free appears to be slower because of cache effects. It's
several % in the best case vs. <1% for init_on_alloc.

> --
> Michal Hocko
> SUSE Labs



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
