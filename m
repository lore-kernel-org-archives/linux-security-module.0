Return-Path: <SRS0=f9XP=75=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB1C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E428520C09
	for <linux-security-module@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCJ8C9Th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgFPMVH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPMVH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB78FC08C5C3
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 05:21:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g3so3310322ilq.10
        for <linux-security-module@vger.kernel.org>; Tue, 16 Jun 2020 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dyDpoLwIzV8Y2oUVWLUvllKR0lYbevMOUFT0R36afQ=;
        b=WCJ8C9ThcrJ9JyM+LwYLoP8teUs6OOqWzFt0B+WKUmQEDEJARfMFSYesiYcnxggBAO
         SL62uH4RsxB8ER24y/h+PA6x7JTVxMhOg82AcTYagDooAJo3f6UHmLWMlARu4z8y2MXE
         bg+RASloJPg/QWVzEyAuA+mQ4WSLUZ/NfgurTZYfatDjrt4aB7v1BSo8AvY0W5sy3/fb
         VtDpxR/N1pieOam7mj9O7r/vuPpWYEA7fthd7HnxpWgeUJU87sx3d2INqr+nBlfc+iTf
         bhZug5enKk5d8LgFHimwLSQamDALpuEszfYS7E2bz4CIH8K3GH/f1KbtgNHCeDJ8sxF9
         0yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dyDpoLwIzV8Y2oUVWLUvllKR0lYbevMOUFT0R36afQ=;
        b=tfpApydsS776VHlP7nqwfMyU1M0hAFn0H6N5L6fdxnN/5HqscYrNZnHm7xImKrtxYy
         Jb+vRBub2+5gXQDPnIE1pv6wpTQyhe4CoDgPi/IHHF1sEi1QLprCdVAQmYWr5GX9jSYz
         aRSWX6DuJpaYZwrEtVKirtUrhtrt4GwCuxyhVOYRDb+SGqpKkOCHQgVfGROkVzzbn3ww
         CwRVMUGFTrT7TaKE02RN7xMPi8OE5f98uD9ClNnc66gFmLgDsyWcZ8b3MieqCi4HUKeT
         Rlc2yFtvGtySB5Cdpo76PTg+9vnoDn3JgHJ5XSGQ4Ll+I+TbFXQ0T46EwfPS+Nf9qsHi
         CndA==
X-Gm-Message-State: AOAM531f1HAetAx1KeuM98ZJurdDYY+D4p5M2BAj48DfoIc//9fyCp3R
        Az2JXTjQHjjz8toSIGU6pk9HwdI7WtalpHfJA2PxPw==
X-Google-Smtp-Source: ABdhPJxj/2UeGjR3VV5+VjjQqoipCAURYR0tK23aElL4GV7YqaJuZWLccb/peB86Plo7mlYW03p0aOiHACNJMDUEU0g=
X-Received: by 2002:a92:a112:: with SMTP id v18mr2615151ili.278.1592310065900;
 Tue, 16 Jun 2020 05:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com> <20200616100309.GA2614426@kroah.com>
 <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
In-Reply-To: <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 16 Jun 2020 05:20:54 -0700
Message-ID: <CANP3RGcvZ-TBoTo2MeCbF=TWoY2sGv21TQ5btJoh+952rscLKg@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     Alexander Potapenko <glider@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> We could make INIT_STACK_ALL_ZERO fall back to INIT_STACK_ALL_PATTERN
> if the compiler flag goes away - does this make sense?

No, I'm pretty sure failing to build, or at least not setting anything
is better.
AFAIK pattern actually introduces new bugs that aren't visible at all
with neither of these flags set.
(because in practice the default no flag behaviour seems to zero some
stuff [probably padding] that it doesn't with pattern)
