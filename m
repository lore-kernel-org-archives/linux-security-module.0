Return-Path: <SRS0=D23n=VC=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87630C4649B
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jul 2019 11:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A0821850
	for <linux-security-module@archiver.kernel.org>; Fri,  5 Jul 2019 11:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSqLNOgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfGELmn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:42:43 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36954 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfGELmm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 Jul 2019 07:42:42 -0400
Received: by mail-wm1-f44.google.com with SMTP id f17so9042527wme.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jul 2019 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=01zxlzZZgdQBadoroEenLMip5oJRIQid45uWpbovAgY=;
        b=CSqLNOgT3DPRKJOTJhlJPbddgwmpDSYZGH25JEySVHTsu0XU7BDrLa/6bEqcmyCLJs
         Qb5TRJ2k6aC7sg9aofoO9JBUst8Pn8rUrJho+UMWjmmZrBlpYiSUVP7gcPq9UAw3+wYL
         rvo8gnHLtxUKzF+xkzthtpS2LUSoMhgtj58eTveYqB8eyrvf7nTTtfeSK/XECH3hKAuT
         3hyKIx6nHWbkmjTb7bKnetMRot2D/Es/Z/3DASqdgZmezfvSlkQZ2ftFjUI+t1s0mN/d
         k7k7nVA6Dw3d7OPZBDRT7xo6Qm9zmMAetEhtb8sU7hFFYTmpYe/Jn9HcdI3o3ODj0uZQ
         29VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=01zxlzZZgdQBadoroEenLMip5oJRIQid45uWpbovAgY=;
        b=qf1pAqeGdM99wpj/GwbBz2XNTR7scSAZMhAAHhbxbNi9U16bXG+99wM5gUFrSqDImP
         499iSqiaKmZVkuu7wcbTqOlPlDfzW9hgMvs4a8PLW+hgUv+hF8DBbUURIdyUGKc/fWdE
         Xv4SS8XgTxAE1iZ3wLalhFnQ5uFllgKnzwTYMsYh/jjN10rFciYD52PmdHvFrhOD3Kpx
         irPl9lxObgpyIa6afm+ylX6m4YqU8nf/lZ4O5cT9BwJ7hKRY+nbB9jB4FovhLAtupleu
         7Vw0OHUfzqqbLSgNXBrTPm0zJfngMSzdyCAAnMIDsO+glmiuiLgil3OGd8vjl+APwrl7
         ajPw==
X-Gm-Message-State: APjAAAXcTs4wKOMYpdJRo90Y5wQFK/TPMsCBH0OUKyO7BLtjsINIDlM5
        BG5h5wPCVR4CZC+4PTdvFHKc58GfWexcBLyYgsJqdw==
X-Google-Smtp-Source: APXvYqx/OY4zBNwIhW4n7zgDdQYtf734ZBesQ+vDt89ijc88G9R0xwVearpBfsQPk2fpIvYTYJ/QbTwYpm60GfCPAWA=
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr3297458wmd.131.1562326960206;
 Fri, 05 Jul 2019 04:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190628093131.199499-1-glider@google.com> <20190628093131.199499-2-glider@google.com>
 <20190702155915.ab5e7053e5c0d49e84c6ed67@linux-foundation.org>
 <CAG_fn=XYRpeBgLpbwhaF=JfNHa-styydOKq8_SA3vsdMcXNgzw@mail.gmail.com> <20190704125349.0dd001629a9c4b8e4cb9f227@linux-foundation.org>
In-Reply-To: <20190704125349.0dd001629a9c4b8e4cb9f227@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 5 Jul 2019 13:42:28 +0200
Message-ID: <CAG_fn=VbxOUS2wqaEbv4C0fG_Ej7sc7Dbymzz6fG8zndCwfasQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        James Morris <jamorris@linux.microsoft.com>,
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

On Thu, Jul 4, 2019 at 9:53 PM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Wed, 3 Jul 2019 13:40:26 +0200 Alexander Potapenko <glider@google.com>=
 wrote:
>
> > > There are unchangelogged alterations between v9 and v10.  The
> > > replacement of IS_ENABLED(CONFIG_PAGE_POISONING)) with
> > > page_poisoning_enabled().
> > In the case I send another version of the patch, do I need to
> > retroactively add them to the changelog?
>
> I don't think the world could stand another version ;)
>
> Please simply explain this change for the reviewers?

As Qian Cai mentioned in the comments to v9:

> Yes, only checking CONFIG_PAGE_POISONING is not enough, and need to check
> page_poisoning_enabled().

Actually, page_poisoning_enabled() is enough, because it checks for
CONFIG_PAGE_POISONING itself.
Therefore I've just replaced IS_ENABLED(CONFIG_PAGE_POISONING)) with
page_poisoning_enabled().

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
