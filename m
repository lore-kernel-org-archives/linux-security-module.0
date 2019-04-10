Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F0C10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 23:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8AA20850
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 23:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/mq2Rkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfDJX1n (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 19:27:43 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:35308 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJX1n (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 19:27:43 -0400
Received: by mail-vs1-f50.google.com with SMTP id d8so2415949vsp.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNlKPyKG8+QtNce73/Iv5lOFma4r0K9qU8E9XvP2Jc0=;
        b=d/mq2RkwjH/zieHh3yaXl4fAgXqLQzmIqXqRsSzThUGDzWSawNIzYLSWf+yMcriAuF
         jQocb31jPcSY+7iOFq4j6sJK1CG4f2z1a35AnhDdew0cXY08ZjccG9HAzJelvXlmZ+zy
         KZnKq/5SR1OK4jq/kK0g4UBSbqqx2mG6Dl7XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNlKPyKG8+QtNce73/Iv5lOFma4r0K9qU8E9XvP2Jc0=;
        b=H6rxpyy8f83vpQ09qeWkkVUmTAR36BJlc0nyBBees1McnToX8rRJufTS67/I/p4Br2
         vopWsoOJ4Y3QVrDKX9U82lR58gismTnX1sAv099LTjSWh4iWbrvXMpbdkT4M7nwEMs8C
         WfbqsHUTBG153G10h7WBIvLltQgfyGlTH6esKsBqtLdDTh1bWSFbEReZiTGCvgV9N/Ty
         awHCCYLRIMZN9QNDWV7/wWRIFTJGxrnHCfookp3gxFt6sP3xGIK4UUH7YtVtKc0pj2l2
         WTu2+6rsCWAzS5Ybh//M4oaP4IayGS0umKi/LiKzlP5Cor/FmU7hw0KzJdtdEKZaMOfN
         KBVA==
X-Gm-Message-State: APjAAAWv+X7sbQZ/7TQn3s0x8oQ/LaH5i41Ka7OXRMg/nAZdXXMg+Jk+
        E9UmSki+A/zX6MWDT+utYWUqymYfr40=
X-Google-Smtp-Source: APXvYqxLvQ7J5N/8cBdPu+KfORG4ry6Td+BHNVngJ9ZmybCjFcbPSmhpoVYUY3iI2iZ+/jzG2oQ9JQ==
X-Received: by 2002:a67:e9c3:: with SMTP id q3mr10680769vso.174.1554938861172;
        Wed, 10 Apr 2019 16:27:41 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id d187sm6976690vsc.17.2019.04.10.16.27.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 16:27:40 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id e2so2375798vsc.13
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 16:27:40 -0700 (PDT)
X-Received: by 2002:a67:76c7:: with SMTP id r190mr27002454vsc.196.1554938859577;
 Wed, 10 Apr 2019 16:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWhx0-kspDyLOgTp+9udiBpkMHULSGyMg9uPPV16=FWQg@mail.gmail.com>
 <20190319170911.GB202956@gmail.com> <20190320185719.GB180195@gmail.com>
 <CAGXu5jL-5C1ZGZ1JgaNFqK-z1Pp1N1X8gD3_ysKTCa=omD+_VQ@mail.gmail.com>
 <20190321175122.GA1587@sol.localdomain> <20190410031734.GB7140@sol.localdomain>
 <CAGXu5j+SZ2+Zkc=Vp5CXQUHhiR9f_OOnca684JTRW3T0yXdaNQ@mail.gmail.com>
 <20190410190729.GA120258@gmail.com> <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
 <20190410231156.GB120258@gmail.com>
In-Reply-To: <20190410231156.GB120258@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 16:27:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKg+oN7yUY=N69U93afOVHBPgwz6Osf=eMDPfiwbzEqmw@mail.gmail.com>
Message-ID: <CAGXu5jKg+oN7yUY=N69U93afOVHBPgwz6Osf=eMDPfiwbzEqmw@mail.gmail.com>
Subject: Re: crypto: Kernel memory overwrite attempt detected to spans
 multiple pages
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 10, 2019 at 4:12 PM Eric Biggers <ebiggers@kernel.org> wrote:
> You've explained *what* it does again, but not *why*.  *Why* do you want
> hardened usercopy to detect copies across page boundaries, when there is no
> actual buffer overflow?

But that *is* how it determines it was a buffer overflow: "if you
cross page boundaries (of a non-compound allocation), it *is* a buffer
overflow". This assertion, however, is flawed because many contiguous
allocations are not marked as being grouped together when it reality
they were. It was an attempt to get allocation size information out of
the page allocator, similar to how slab can be queries about
allocation size. I'm open to improvements here, since it's obviously
broken in its current state. :)

-- 
Kees Cook
