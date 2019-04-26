Return-Path: <SRS0=T836=S4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D7FC43218
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 12:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB00206A3
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Apr 2019 12:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m26A6N93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDZMj4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:39:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46061 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMj4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Apr 2019 08:39:56 -0400
Received: by mail-ua1-f65.google.com with SMTP id o33so1110988uae.12
        for <linux-security-module@vger.kernel.org>; Fri, 26 Apr 2019 05:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7AawR3O9LUFS8kj7n0V35j45u1KfiRyWzvO/3OxrAE=;
        b=m26A6N93bZJXT6UlaTWtTMsI53w5OVL8HSRwdT1/cquOlHa70Nuz69k33IlTgtWpoc
         HMUj8YpAX3lQQ8mb/nXQA5am3IQVjQhjxstTjFfh8iScQEvro47qgn/8MjDcuPHb9jkf
         6GqXBu2DYardxU8i3XS+9z3AkNDQCCrdNxx0NxX0+Qnxy75R3c9nHUouW1QC7XIW3wmL
         WEETj+ZHkC+ouC8JHRvDRX582jx8YtJ72o5lkDOZI2RpmQx3ZMgQTSUr5c4rM1AceOAl
         WN4nluwmMQkSJRukq5vSC3uX7OsMNRSPKCuuWAKOSxcW7FmYWVXz6qeFUjljTnPPcvww
         Z0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7AawR3O9LUFS8kj7n0V35j45u1KfiRyWzvO/3OxrAE=;
        b=GoPeXzvUG3H2POwOFPzBtivw2zbjxWBl84/9l8ZvJF5v2iYFIBpj+g1xfDxAkwXhkS
         oulAD/UzPUhchDNFv78T/yqIWc4S+lWwqAyTaadfYUsxOFnzwRv3/kqmBZ4K/JlCSTPo
         6K+2x1SawJdEPVK2wfPYWBgobifgIQ1i8Irtkv/0hPtg6RS1DBNiVqyztawdbF7vpbpF
         ueimEF6o3WViLz1cPhqRqKj3WnbbNQcOMyiCDLfek6HGjY879MegRH8GDaqMzJcAwlLV
         mjNEkixr9zAKi6Wslp8vyU8XVamhee5rYL6alLcXgNW64U5ukcStDkYlDLe8XqOwNfXe
         /wFw==
X-Gm-Message-State: APjAAAVR3riHcDom9LLsBZ6n4XX3gel4X4Ep76XDNDouroDf5Hm1hPJq
        5VY6+0O8w+o+EVkykvr8Sp8DnZlvcXsi0OgmFni8Ag==
X-Google-Smtp-Source: APXvYqzYTr1kpS8dYgBhDfPdqedl7565LwdCIfJCzPIpaGiHrI2c19+u7oNKWzbrOaBScV3cHo/Y8XKYWKFwwcEK1Lo=
X-Received: by 2002:ab0:d95:: with SMTP id i21mr14349633uak.110.1556282394874;
 Fri, 26 Apr 2019 05:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <CAGXu5j+tJJbyoZ=nSpSeiihD=NHwFJ6G9Ku5c21G5nQfEiKPwQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+tJJbyoZ=nSpSeiihD=NHwFJ6G9Ku5c21G5nQfEiKPwQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 26 Apr 2019 14:39:43 +0200
Message-ID: <CAG_fn=WmTh8hesU0RDpbdYDf0iYSdmAWH1dMkejRg5sBnaCw3g@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: add init_allocations=1 boot option
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 23, 2019 at 8:49 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Apr 18, 2019 at 8:42 AM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > Following the recent discussions here's another take at initializing
> > pages and heap objects with zeroes. This is needed to prevent possible
> > information leaks and make the control-flow bugs that depend on
> > uninitialized values more deterministic.
> >
> > The patchset introduces a new boot option, init_allocations, which
> > makes page allocator and SL[AOU]B initialize newly allocated memory.
> > init_allocations=3D0 doesn't (hopefully) add any overhead to the
> > allocation fast path (no noticeable slowdown on hackbench).
>
> I continue to prefer to have a way to both at-allocation
> initialization _and_ poison-on-free, so let's not redirect this to
> doing it only at free time.
There's a problem with poison-on-free.
By default SLUB stores the freelist pointer (not sure if it's the only
piece of data) in the memory chunk itself, so newly allocated memory
is dirty despite it has been zeroed out previously.
We could probably zero out the bits used by the allocator when
allocating the memory chunk, but it sounds hacky (yet saves us 8 bytes
on every allocation)
A cleaner solution would be to unconditionally relocate the free
pointer by short-circuiting
https://elixir.bootlin.com/linux/latest/source/mm/slub.c#L3531
Surprisingly, this doesn't work, because now the sizes of slub caches
are a bit off, and create_unique_id() in slub.c returns clashing sysfs
names.

> We're going to need both hooks when doing
> Memory Tagging, so let's just get it in place now. The security
> benefits on tagging, IMO, easily justify a 1-2% performance hit. And
> likely we'll see this improve with new hardware.
>
> > With only the the first of the proposed patches the slowdown numbers ar=
e:
> >  - 1.1% (stdev 0.2%) sys time slowdown building Linux kernel
> >  - 3.1% (stdev 0.3%) sys time slowdown on af_inet_loopback benchmark
> >  - 9.4% (stdev 0.5%) sys time slowdown on hackbench
> >
> > The second patch introduces a GFP flag that allows to disable
> > initialization for certain allocations. The third page is an example of
> > applying it to af_unix.c, which helps hackbench greatly.
> >
> > Slowdown numbers for the whole patchset are:
> >  - 1.8% (stdev 0.8%) on kernel build
> >  - 6.5% (stdev 0.2%) on af_inet_loopback
>
> Any idea why thes two went _up_?
>
> >  - 0.12% (stdev 0.6%) on hackbench
>
> Well that's quite an improvement. :)
>
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
