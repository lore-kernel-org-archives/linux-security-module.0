Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F5C10F14
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A1A21479
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSLGPvOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbfDRQub (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:50:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:47010 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRQub (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 12:50:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id e2so1493944vsc.13
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3GywmUi66KpKpQU9IlmyohbD35g+PWotSiWItfTBzrM=;
        b=ZSLGPvOZQCvhbwomx0gv2KJNtURxN7em796H/i+CY8JSHB10A7IVj6bI0983tiy05C
         sXGblrmBvnXYVPsFGY78XLlYrtV7RJCNTDnJCue99JfT+0LZTa9pt/kawQ5UJq9xtZEq
         k/Mntynsx1085QGHjRiDaKa4dImiBgifz5/Udg8NvIvu3XnUfCo8W4YfwLHMqGlPsxw5
         K4aIVhcMUGwTa05YUN9fBpQLg4zPFOHYZnnJ2p3qcP3xFDmee/EjUYF4Bm8GYwQxfiE1
         D1rL3xgIXJbQGQ9ILV4judJ94wuIoOZRhFI+20J4cpMXwPJ/y9tOhaUkQqH0c6UovUaa
         Cg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3GywmUi66KpKpQU9IlmyohbD35g+PWotSiWItfTBzrM=;
        b=E4Q1T/NrlSrpgMKVZbEjt+jKlEWwuNHYXBaugO2kx5OXAirEyf66YTRXJUUaa89ioP
         wAnnlKPgF7lQG1veymiqjwvNOhmDaaTCm+5Xomx56hIFr06jQ24G9/ltS+Dw8+fRBrBH
         zqXGp97/oJmlU7tTJ1hJUqCYAK7pSsDCwyvIk1dsFStkxHESp1DVlhSuzdqN9+ayHDi6
         eigEkVAnc/GMBK5EEd7pmZcZYRAuD0TXmC4Ge/ZshfQpNLrSwwDz9Q/YzftMoEQBNvIY
         D6kPmi5kuZ3MuDYHI9hZzp+EOP7cWES3Nvlj1tELkDDC0SrjasixiVQuTcxwOy6z3LLf
         zS+Q==
X-Gm-Message-State: APjAAAXJntNwKWQrpI5Znb9MbvRtLcnkd07N4BhEySiQpJT78J/AkZNF
        JFYa2z97azpqhnoKUju0AkcuT/D58/+sDTEeSOjCMw==
X-Google-Smtp-Source: APXvYqwbSsVeJOYKT02dy71PfyAASXr/lW85K2foIwP5XcCyaonmeusw7x+fi25E9bwj6h3WhjCxvUXCNDXA7mNi/10=
X-Received: by 2002:a67:dd91:: with SMTP id i17mr28847115vsk.217.1555606230011;
 Thu, 18 Apr 2019 09:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-2-glider@google.com>
 <981d439a-1107-2730-f27e-17635ee4a125@intel.com> <CAG_fn=URD0WL+RE90ZE2FZM4=p2zE9V+YA2RW-LrWnuqYTwvKQ@mail.gmail.com>
In-Reply-To: <CAG_fn=URD0WL+RE90ZE2FZM4=p2zE9V+YA2RW-LrWnuqYTwvKQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 18 Apr 2019 18:50:18 +0200
Message-ID: <CAG_fn=WQJRB_kb79F9ri2_Gj-gh2rmgSDa9WD7wF-pLeCKprjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: security: introduce the init_allocations=1 boot option
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 18, 2019 at 6:43 PM Alexander Potapenko <glider@google.com> wro=
te:
>
> On Thu, Apr 18, 2019 at 6:35 PM Dave Hansen <dave.hansen@intel.com> wrote=
:
> >
> > On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> > > This option adds the possibility to initialize newly allocated pages =
and
> > > heap objects with zeroes. This is needed to prevent possible informat=
ion
> > > leaks and make the control-flow bugs that depend on uninitialized val=
ues
> > > more deterministic.
> >
> > Isn't it better to do this at free time rather than allocation time?  I=
f
> > doing it at free, you can't even have information leaks for pages that
> > are in the allocator.
> I should have mentioned this in the patch description, as this
> question is being asked every time I send a patch :)
> If we want to avoid double initialization and take advantage of
> __GFP_NOINIT (see the second and third patches in the series) we need
> to do initialize the memory at allocation time, because free() and
> free_pages() don't accept GFP flags.

On a second thought, double zeroing on memory reclaim should be quite rare.
Most of the speedup we gain with __GFP_NOINIT is because we assume
it's safe to not initialize memory that'll be overwritten anyway.
I'll need to check how e.g. hackbench behaves if we choose to zero
memory on free() (my guess would be it'll be slower than with
__GFP_NOINIT hack, albeit a little safer)
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
