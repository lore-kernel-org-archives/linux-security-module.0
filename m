Return-Path: <SRS0=iQUf=SZ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE1C10F03
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0288121738
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Apr 2019 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JHBW4aAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDWSt0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:49:26 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35312 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWSt0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Apr 2019 14:49:26 -0400
Received: by mail-vs1-f67.google.com with SMTP id d8so8850048vsp.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/T9qo9dXOGam1pOhMSAqSonYXFNAxs4dctak+jq5XkQ=;
        b=JHBW4aAOIAjQxAPOtuiWiFgtH93O689gkxe5m6ABY0SG7DuEDYyjBjOKwdBADUDI4f
         MZbJZrn1mDNVGuM9vPk7Wqlmg7LsTZicn2PRqdF768u/nKaMExHfHw+nayNTpoEWn/jy
         GqJ4uliwl8NZJLtsd6NeZlkStKKwQDPzhqZZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/T9qo9dXOGam1pOhMSAqSonYXFNAxs4dctak+jq5XkQ=;
        b=QcMeVk3srRvWF+pfnA0BbmSiNQJEoH1X6P6EVA5oZ2U9hkwlBZsFVQDRUkZfFXzR/4
         BlWcHrrRcQlCx1zGzSXnsLtwsuQScFlgAvBabOPpQEMYwbcpydoE6YzRW5JB2xluuYqa
         6/s8GeOS+BW432BPtvhE5KCPZcoKT/PmDDSYZvcQvByFELr7Trgy8ywyO/cpqcXRRGy8
         +DqTXv1pLvB4aODuUQNalJmxbax219txRJskDo3TZszZWok+HSlKy6/MBk62BFGf9Ksi
         l+tD1Sh4PLfCnGj9W2xe8WiQNP+hdnONPJVu81EH0aSAIk4D/LDGZYu2nMvbRa7bAcuY
         mHvg==
X-Gm-Message-State: APjAAAUfD2T5dUh+w+HE4AGsfEbZIQhzQnafMLvDjg5Fq5QJSQ5X5Lmp
        59S4BbfBGm6TBbj81IF1C5kBZRiNaMU=
X-Google-Smtp-Source: APXvYqzN+S036vTjlOjaRbiOcw4UwigKj0OaSRXHTytjUwyAi804l+cNMjZ/mq430fuZqlmyTgEsDA==
X-Received: by 2002:a67:ef83:: with SMTP id r3mr14359142vsp.177.1556045363973;
        Tue, 23 Apr 2019 11:49:23 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 8sm4460469vkw.38.2019.04.23.11.49.22
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 11:49:22 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id g127so8908523vsd.6
        for <linux-security-module@vger.kernel.org>; Tue, 23 Apr 2019 11:49:22 -0700 (PDT)
X-Received: by 2002:a05:6102:417:: with SMTP id d23mr5082569vsq.48.1556045361827;
 Tue, 23 Apr 2019 11:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190418154208.131118-1-glider@google.com>
In-Reply-To: <20190418154208.131118-1-glider@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 11:49:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+tJJbyoZ=nSpSeiihD=NHwFJ6G9Ku5c21G5nQfEiKPwQ@mail.gmail.com>
Message-ID: <CAGXu5j+tJJbyoZ=nSpSeiihD=NHwFJ6G9Ku5c21G5nQfEiKPwQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] RFC: add init_allocations=1 boot option
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Apr 18, 2019 at 8:42 AM Alexander Potapenko <glider@google.com> wrote:
>
> Following the recent discussions here's another take at initializing
> pages and heap objects with zeroes. This is needed to prevent possible
> information leaks and make the control-flow bugs that depend on
> uninitialized values more deterministic.
>
> The patchset introduces a new boot option, init_allocations, which
> makes page allocator and SL[AOU]B initialize newly allocated memory.
> init_allocations=0 doesn't (hopefully) add any overhead to the
> allocation fast path (no noticeable slowdown on hackbench).

I continue to prefer to have a way to both at-allocation
initialization _and_ poison-on-free, so let's not redirect this to
doing it only at free time. We're going to need both hooks when doing
Memory Tagging, so let's just get it in place now. The security
benefits on tagging, IMO, easily justify a 1-2% performance hit. And
likely we'll see this improve with new hardware.

> With only the the first of the proposed patches the slowdown numbers are:
>  - 1.1% (stdev 0.2%) sys time slowdown building Linux kernel
>  - 3.1% (stdev 0.3%) sys time slowdown on af_inet_loopback benchmark
>  - 9.4% (stdev 0.5%) sys time slowdown on hackbench
>
> The second patch introduces a GFP flag that allows to disable
> initialization for certain allocations. The third page is an example of
> applying it to af_unix.c, which helps hackbench greatly.
>
> Slowdown numbers for the whole patchset are:
>  - 1.8% (stdev 0.8%) on kernel build
>  - 6.5% (stdev 0.2%) on af_inet_loopback

Any idea why thes two went _up_?

>  - 0.12% (stdev 0.6%) on hackbench

Well that's quite an improvement. :)

-- 
Kees Cook
