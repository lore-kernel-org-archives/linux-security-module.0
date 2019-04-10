Return-Path: <SRS0=my8L=SM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738CC10F11
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 21:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBA02082A
	for <linux-security-module@archiver.kernel.org>; Wed, 10 Apr 2019 21:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gv1MQ9tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfDJV6C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:58:02 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:34241 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfDJV6C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Apr 2019 17:58:02 -0400
Received: by mail-vs1-f52.google.com with SMTP id t78so2310507vsc.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ6wwUQrK1NqHrZtbqa5TkZR4Gt0ENtEbKzfcyHpppE=;
        b=gv1MQ9tGqukjy1cxAUfCcBksLGw3OlCHJEx6K+6Mj+1qUsoKucc/YgqMNaG86eMB1D
         WTZemX8QDCe1WFlW0Juf+fhQeN08D7xVWNfo88NerKEYK9jpXnm7gPmG9WLWOA3Q0qGA
         0Zf/bWUhqXgosvN7oHj639aOLqJscqb1wUEVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ6wwUQrK1NqHrZtbqa5TkZR4Gt0ENtEbKzfcyHpppE=;
        b=tfcOpZj4gJQTc/cA2Jk+s3UEVT9d0Jn+cBTxi9sQriWJ//lXPCJ5V6V9fHoHHZta7Y
         qRDyhOi1g3bljVvbS9aagl0Wx/5cDEaMC7CtvSUeZwF0sP2CopXU1B8O4mcgprOXhRjZ
         G4cmK/f9QuNq5t969yFnAXxDw8in/r1C+4c/4zbhnTJw+7vHp4qM8HaIj8QjXnhE1goR
         kG6KWajvXTLFD/SJZEUZf2IV+ZIdxEADcFvMm3ac5GxpPGLZ6jp5EddCY+58blQS7syH
         w41tZ7K5H/gBRVEe9C6XT4L/qbPLOQtrtj98xoOE2lz+ZzrhxNPZ+a+ndWGP52NLVPz4
         BhSg==
X-Gm-Message-State: APjAAAXL7RqcCIPZjc0qiXx3Lm4+rFkjo6QIdGfcZ53OsYEBTWHtvrgG
        D5BQwd+/9bKpsY0IhbcdWS99Do6w7+8=
X-Google-Smtp-Source: APXvYqwO0my1VEVCiODLK6+q66FgKk/qLY/x2qbDN4fgcBdhtUVqI6A55ziq0pwRPKeL3j/KaxEUYQ==
X-Received: by 2002:a67:69d7:: with SMTP id e206mr24248585vsc.79.1554933481016;
        Wed, 10 Apr 2019 14:58:01 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 2sm15744598vke.27.2019.04.10.14.57.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:57:59 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id n4so2302366vsm.3
        for <linux-security-module@vger.kernel.org>; Wed, 10 Apr 2019 14:57:59 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr24870637vst.30.1554933478741;
 Wed, 10 Apr 2019 14:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWhx0-kspDyLOgTp+9udiBpkMHULSGyMg9uPPV16=FWQg@mail.gmail.com>
 <20190319170911.GB202956@gmail.com> <20190320185719.GB180195@gmail.com>
 <CAGXu5jL-5C1ZGZ1JgaNFqK-z1Pp1N1X8gD3_ysKTCa=omD+_VQ@mail.gmail.com>
 <20190321175122.GA1587@sol.localdomain> <20190410031734.GB7140@sol.localdomain>
 <CAGXu5j+SZ2+Zkc=Vp5CXQUHhiR9f_OOnca684JTRW3T0yXdaNQ@mail.gmail.com> <20190410190729.GA120258@gmail.com>
In-Reply-To: <20190410190729.GA120258@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:57:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
Message-ID: <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
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

On Wed, Apr 10, 2019 at 12:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
> That didn't answer my question.  My question is what is the purpose of this?  If
> there was actual buffer overflow when __GFP_COMP isn't specified that would make
> perfect sense, but AFAICS there isn't.  So why does hardened usercopy consider
> it broken when __GFP_COMP isn't specified?

The goal of CONFIG_HARDENED_USERCOPY_PAGESPAN was to detect copies
across page boundaries in memory allocated by the page allocator.
There appear to be enough cases of allocations that span pages but do
not mark them with __GFP_COMP, so this logic hasn't proven useful in
the real world (which is why no one should use the ..._PAGESPAN config
in production). I'd like to get the kernel to the point where hardened
usercopy can correctly do these checks (right now it's mainly only
useful at checking for overflows in slub and slab), but it'll take
time/focus for a while. No one has had time yet to track all of these
down and fix them. (I defer to Laura and Rik on the design of the
pagespan checks; they did the bulk of the work there.)

Does that help explain it, or am I still missing your question?

-- 
Kees Cook
