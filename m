Return-Path: <SRS0=QYhf=SU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22AC10F0E
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B47621900
	for <linux-security-module@archiver.kernel.org>; Thu, 18 Apr 2019 16:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSoUbECw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfDRQnk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:43:40 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37338 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbfDRQnj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Apr 2019 12:43:39 -0400
Received: by mail-vk1-f196.google.com with SMTP id o187so594057vkg.4
        for <linux-security-module@vger.kernel.org>; Thu, 18 Apr 2019 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qzDLwBi5wGEl1QgiX6QazcN46g8jvDRco924zpUMTMs=;
        b=PSoUbECw7vwP45yX9rJ82zoosI6vrtSOcSvfexvtf9HX8wWoR5wUcRHsD9B7m5U2L7
         jm9HH/bjxBGxi5+RCrCNLXetskJuMX2wfqmhBCXUlHJ5ijkxaWsjVIfbRyqsmp7XKLdh
         gYaCyM7a99gS3drFWq3+iozBqgt+Qo29xLYJQvM/9GciLdkCCn30jwwNsdm+C4McJcqX
         Ch2reOgZolGTpLBTrvtU/hr3aOBRzPcAWcPskgQk1pCvXRAGZ/MNcAluPTK+LTpj6hfe
         oANJOvhbEp4yaN6R0AknZ+86wyCf7mZASFmzpqE0QfOYMcxeh4Oe96IoxGwr6LTvlJTJ
         qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qzDLwBi5wGEl1QgiX6QazcN46g8jvDRco924zpUMTMs=;
        b=AG5IISgODO/OpGx/+YYkbpaDyAGtjAhS+wPVsAvdJt1yATSliD5JgXmTFClQe5radw
         I/+tMLvDVq5Cr6bhv74j8Q/x5RktmW0yzyH9swNrxLmFGGUddmFfA4YcURqbUSd5hJcK
         OyOeK9yAHm/zab07GAT84pSzqqCrwzjlaXGERR2RwNBA45a68FZO9D1muEkcW77SZ4xY
         mblertDAeuB6P+BPYVCnBDOjf4PzTNCxW1zvXuSqgYUS8WfqizEHtJfdpiBcGdJL4flu
         jGAh0fwUWT4kJh7sgSxNPbEp9hffH+ddw8E++SxxYUvoDiWamGsbk3Kd4GnBLKTv5WEr
         +TIg==
X-Gm-Message-State: APjAAAWq91zR5BRtVl1ZglOANvm3PNTu3y+3THuTbPOF5ur9B66+ogc7
        G9doxQdNvyfb1PyrxClxr23WS6FTmfxxnChUnCbR0Q==
X-Google-Smtp-Source: APXvYqyn9J+QqZgKJjQGoBk6T1xIB+6KLK6AJT56KZhqtsU+SxO6Kwx1Y5gtrSBkkcrVh5eG2zk2CkqmsC41n5XBaIc=
X-Received: by 2002:a1f:aa93:: with SMTP id t141mr50445492vke.64.1555605818227;
 Thu, 18 Apr 2019 09:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-2-glider@google.com>
 <981d439a-1107-2730-f27e-17635ee4a125@intel.com>
In-Reply-To: <981d439a-1107-2730-f27e-17635ee4a125@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 18 Apr 2019 18:43:27 +0200
Message-ID: <CAG_fn=URD0WL+RE90ZE2FZM4=p2zE9V+YA2RW-LrWnuqYTwvKQ@mail.gmail.com>
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

On Thu, Apr 18, 2019 at 6:35 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> > This option adds the possibility to initialize newly allocated pages an=
d
> > heap objects with zeroes. This is needed to prevent possible informatio=
n
> > leaks and make the control-flow bugs that depend on uninitialized value=
s
> > more deterministic.
>
> Isn't it better to do this at free time rather than allocation time?  If
> doing it at free, you can't even have information leaks for pages that
> are in the allocator.
I should have mentioned this in the patch description, as this
question is being asked every time I send a patch :)
If we want to avoid double initialization and take advantage of
__GFP_NOINIT (see the second and third patches in the series) we need
to do initialize the memory at allocation time, because free() and
free_pages() don't accept GFP flags.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
