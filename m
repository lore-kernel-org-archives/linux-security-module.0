Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94406C282E1
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6488B217D9
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 19:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQicmEXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDWTOv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:14:51 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45688 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTOv (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 15:14:51 -0400
Received: by mail-vs1-f65.google.com with SMTP id o10so8933745vsp.12
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32U2dfxVGqorGsN9k10OetrKjC+7ZLylQlERitBS26g=;
        b=YQicmEXJvE7Tow30ovfEeQ7OOnLVp5QOpQuA2Yp/05T8K4KyNMZUwRCEOT7qsv8jUW
         ji6LVmFsFQl5hazahb/dIo7+RTDl77DuX1J/52+4KgqU4FDGj2s/XsiCzYXx0E48D276
         o38sdIgkaDZOG1/7dTK3PqR9YH4+X9a14h5O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32U2dfxVGqorGsN9k10OetrKjC+7ZLylQlERitBS26g=;
        b=BOum2TbDOPCy7KaHTSm2ta+BKcuPlebXV0Z3jbzl5pmaj31EUsGPcJ89u+wszur3kx
         CRCn6SIyJAOso6UC3VMqVWx/VTf69Ye5bgYw1aVFzmIOA7i9el3Ybh1Zi7rNVpzkEI8Y
         ndUywLFxbjra5UUzbFBNbAxdawtO2uP36paX1bMffyo6IEHIqudUs9k6/uR6+4wBoQSp
         lUtXZn+BTUDNFLOJ7FEqjoCjq031ufCuziQ+4pUWtBuVD2jn/+EdydRrM+kDMpgnhD4x
         7zr0fnMbhf3LZvs/g1gc2RU6Y1Fx2P6IPZR19eq4gMS5uhBK3kwGr1zXBwxdlsmNPysj
         TKVA==
X-Gm-Message-State: APjAAAVXwkswlxJ+ym1r6+ZJCu+nk8+Ed2evCMxfY2/JKDZugBQBzSjF
        nZ4AFFBCOidOs0jamZfAaP4bZjVbdqk=
X-Google-Smtp-Source: APXvYqzig+FIXJFSMEnbgs4WEK9D90yIExrRxKS0MCZYOjUKYxOFLgIAmym615wlR43wumMmQ944OA==
X-Received: by 2002:a67:e258:: with SMTP id w24mr14202555vse.20.1556046889486;
        Tue, 23 Apr 2019 12:14:49 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id 2sm18547599vke.27.2019.04.23.12.14.48
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 12:14:48 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 195so3460416vkx.9
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 12:14:48 -0700 (PDT)
X-Received: by 2002:a1f:7d8e:: with SMTP id y136mr8461809vkc.40.1556046888180;
 Tue, 23 Apr 2019 12:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com> <20190418154208.131118-3-glider@google.com>
 <7bf6bd62-c8e0-df3d-8e98-70063f2d175a@intel.com>
In-Reply-To: <7bf6bd62-c8e0-df3d-8e98-70063f2d175a@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 12:14:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Lm0ba4ZQ91vZ8nZFvpJSxu_j_bEKMaa0NMsurmyZjjA@mail.gmail.com>
Message-ID: <CAGXu5j+Lm0ba4ZQ91vZ8nZFvpJSxu_j_bEKMaa0NMsurmyZjjA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gfp: mm: introduce __GFP_NOINIT
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Apr 18, 2019 at 9:52 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 4/18/19 8:42 AM, Alexander Potapenko wrote:
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index be84f5f95c97..f9d1f1236cd0 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -302,7 +302,7 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
> >  {
> >       struct page *pages;
> >
> > -     pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
> > +     pages = alloc_pages((gfp_mask & ~__GFP_ZERO) | __GFP_NOINIT, order);
> >       if (pages) {
> >               unsigned int count, i;
>
> While this is probably not super security-sensitive, it's also not
> performance sensitive.

It is, however, a pretty clear case of "and then we immediately zero it".

> These sl*b ones seem like a bad idea.  We already have rules that sl*b
> allocations must be initialized by callers, and we have reasonably
> frequent bugs where the rules are broken.

Hm? No, this is saying that the page allocator can skip the auto-init
because the slab internals will be doing it later.

> Setting __GFP_NOINIT might be reasonable to do, though, for slabs that
> have a constructor.  We have much higher confidence that *those* are
> going to get initialized properly.

That's already handled in patch 1.

-- 
Kees Cook
