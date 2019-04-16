Return-Path: <SRS0=WmJh=SS=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1735C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 03:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6320868
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Apr 2019 03:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8xqOZaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfDPDPI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:15:08 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41517 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfDPDPH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Apr 2019 23:15:07 -0400
Received: by mail-vs1-f66.google.com with SMTP id g187so10701863vsc.8
        for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2019 20:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mk6BIBLLGO0U80tLWMVE0489EqA725xprr9VtegXBQw=;
        b=Y8xqOZaS7jkwKovka8QtC0wCgsNCE4WBE8pK3EDq4eKI6sO+T80f/S1bmRcL3mxz/l
         Cvk05b4RCyjWoI0j+pNA99L3vDReq81bLIvF4e378eH+fFvsHhaQpkt9P2QwQ9zEhlaW
         p792GG7NkrUjaFmz8u13GMr+5hDAtUDZo0rY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk6BIBLLGO0U80tLWMVE0489EqA725xprr9VtegXBQw=;
        b=j5TrZsW6KIkrLMBF+jNov714J1IK9MbP5ZaJu6DDwQhmnsADfumOHM72Ll/EEAdDc/
         /BwBocUTdY4YrXdIocrwxGADp/x7liDu3B0341tvkDtJ6kZ5XmFgc6vRWu0scfGn6Q5r
         Du5z2ENa+OxbbcgfSJlYhUAmSl3j+HLuAMcbxrpw4ZBl/vOSbT88BgR5rd0Dsdyc+04e
         nQNZ0U+S8iczXy9pCqWOR1V9QcpgBF1Egno1DkcYNG0CP9tVmG9HkgJu94m4Rzfp46m7
         +izGOQK6l9ucRH4FWSQVxSk+VMRL/OQdvrJkNEKxgaQCLx8QAAyUn8YG1APcGvSrot9O
         AtNg==
X-Gm-Message-State: APjAAAWfIeKFwanhgt1nOlKWAUBl/QhFqsdrdIlPCZQpl9HcLrnkgkAY
        K5tJ3VgN0HHbUDp7oASp3TyG2MRB/fU=
X-Google-Smtp-Source: APXvYqy+CL4snRebOfEJX+UYYzFgbbC+jl07IcsqC3QyLPdXtwB1soIwqDDuaX9MsE2+w5p8EJv1IA==
X-Received: by 2002:a67:f256:: with SMTP id y22mr27178226vsm.19.1555384506265;
        Mon, 15 Apr 2019 20:15:06 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t198sm10931279vst.11.2019.04.15.20.15.04
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:15:04 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id o10so10697824vsp.12
        for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2019 20:15:04 -0700 (PDT)
X-Received: by 2002:a67:f04e:: with SMTP id q14mr43541834vsm.133.1555384503717;
 Mon, 15 Apr 2019 20:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190411192607.GD225654@gmail.com> <20190411192827.72551-1-ebiggers@kernel.org>
 <CAGXu5jJ8k7fP5Vb=ygmQ0B45GfrK2PeaV04bPWmcZ6Vb+swgyA@mail.gmail.com>
 <20190415022412.GA29714@bombadil.infradead.org> <20190415024615.f765e7oagw26ezam@gondor.apana.org.au>
 <20190416021852.GA18616@bombadil.infradead.org>
In-Reply-To: <20190416021852.GA18616@bombadil.infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 22:14:51 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKaVB=bTJCBWhsxAny7-OkzXQ+8KCd5O+_-7hKcJFiqKw@mail.gmail.com>
Message-ID: <CAGXu5jKaVB=bTJCBWhsxAny7-OkzXQ+8KCd5O+_-7hKcJFiqKw@mail.gmail.com>
Subject: Re: [PATCH] crypto: testmgr - allocate buffers with __GFP_COMP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 15, 2019 at 9:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> I agree; if the crypto code is never going to try to go from the address of
> a byte in the allocation back to the head page, then there's no need to
> specify GFP_COMP.
>
> But that leaves us in the awkward situation where
> HARDENED_USERCOPY_PAGESPAN does need to be able to figure out whether
> 'ptr + n - 1' lies within the same allocation as ptr.  Without using
> a compound page, there's no indication in the VM structures that these
> two pages were allocated as part of the same allocation.
>
> We could force all multi-page allocations to be compound pages if
> HARDENED_USERCOPY_PAGESPAN is enabled, but I worry that could break
> something.  We could make it catch fewer problems by succeeding if the
> page is not compound.  I don't know, these all seem like bad choices
> to me.

If GFP_COMP is _not_ the correct signal about adjacent pages being
part of the same allocation, then I agree: we need to drop this check
entirely from PAGESPAN. Is there anything else that indicates this
property? (Or where might we be able to store that info?)

There are other pagespan checks, though, so those could stay. But I'd
really love to gain page allocator allocation size checking ...

-- 
Kees Cook
