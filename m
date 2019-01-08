Return-Path: <SRS0=cuGm=PQ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA3C43387
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF7C20883
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jan 2019 21:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m1jQUEw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfAHVMJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:12:09 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33265 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfAHVMH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jan 2019 16:12:07 -0500
Received: by mail-ua1-f67.google.com with SMTP id t8so1759609uap.0
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3yd9D37qc6JkHvOXsqsDpNI+Gs7w2ansAKhkfNPYkQ=;
        b=m1jQUEw6q81E5DJnpX9Bi50bdMo3bQ783+zQzPbIDROzuE2KV/3MSJjqJc16ITLvHP
         mp98HXB0eok6EICYWssiLxSUYqtYFqtW9mPPvxrVe/Xsp//AWIIUp6FOjFqCyjpeJKcL
         ImzuG+niwzj4xxJzZt6f12U8av3gGFfgqmdoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3yd9D37qc6JkHvOXsqsDpNI+Gs7w2ansAKhkfNPYkQ=;
        b=YrBswYfMkbhzRWNH0R5MH1riEGWDw+B7bw7t5o8Rs1c24X5BdspojXqc12T9z1CGQK
         FX8NKEXjIVKwsrEmZmkClCJZOyfTBYPGfeX1Y2seEfw3gIpt/F3OeevBwFN1LrA7G5Ht
         F1hzWVBmcDEM/7xLByTOefXD7NhpqQXK89hQUU30ekNxM64YQgqNSHA5f+j2TkrJshlW
         20hZ3v0dc4979tSIAKsQ3F+8jUcPC+dRvTPfB9nev6SesniSVAjX8E125DZbcgbXPUFe
         BSSuDfuwWVc04U1K740L70vnzIBNtt9chP1wDZtE1teFpk7Q5o25xvJFXPZTfzAgcyO5
         Vo/Q==
X-Gm-Message-State: AJcUukdfuR5rHSWvQ9lajNfygzz8orYAWuQYmkUWtvJtGpDTR0PpprPr
        M5t6vbKbx0mcCSVdnieLhmKNfz3bTJI=
X-Google-Smtp-Source: ALg8bN5DKsmheq8mfz03Pw8lgI1dwCYqa3sHOVpvduGwJdvfQAGiMm2qRXIU0JsUkS+4OM805w7nMA==
X-Received: by 2002:ab0:740a:: with SMTP id r10mr1144615uap.14.1546981924825;
        Tue, 08 Jan 2019 13:12:04 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a187sm40081951vkf.26.2019.01.08.13.12.03
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:12:03 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id x28so3377732vsh.12
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jan 2019 13:12:03 -0800 (PST)
X-Received: by 2002:a67:e15e:: with SMTP id o30mr1425746vsl.66.1546981922995;
 Tue, 08 Jan 2019 13:12:02 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1901090803120.24546@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901090803120.24546@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 13:11:51 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
Message-ID: <CAGXu5j+wvi9t-oHf4cX999aYWMhmTJ1zA1mKuNQEB_n5ixiC5w@mail.gmail.com>
Subject: Re: [GIT PULL] seccomp: build fix for v5.0-rc2
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This was already picked up by x86-urgent...

-Kees

On Tue, Jan 8, 2019 at 1:04 PM James Morris <jmorris@namei.org> wrote:
>
> Please pull this fix for a build regression in seccomp.
>
> The following changes since commit 7b55851367136b1efd84d98fea81ba57a98304cf:
>
>   fork: record start_time late (2019-01-08 09:40:53 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc1
>
> for you to fetch changes up to cba54b44d0be4eb66dbc7709e1f3f0d65e851f69:
>
>   samples/seccomp: fix 32-bit build (2019-01-08 13:00:00 -0800)
>
> ----------------------------------------------------------------
>
> Tycho Andersen (1):
>       samples/seccomp: fix 32-bit build
>
>  samples/seccomp/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> ---
>
> commit cba54b44d0be4eb66dbc7709e1f3f0d65e851f69
> Author: Tycho Andersen <tycho@tycho.ws>
> Date:   Mon Jan 7 14:46:34 2019 -0700
>
>     samples/seccomp: fix 32-bit build
>
>     Both the .o and the actual executable need to be built with -m32 in order
>     to link correctly.
>
>     Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
>
>     Signed-off-by: Tycho Andersen <tycho@tycho.ws>
>     Reported-by: Ingo Molnar <mingo@kernel.org>
>     Signed-off-by: James Morris <james.morris@microsoft.com>
>
> diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
> index 4920903c8009..a5607668a5c7 100644
> --- a/samples/seccomp/Makefile
> +++ b/samples/seccomp/Makefile
> @@ -37,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
>  HOSTLDLIBS_bpf-direct += $(MFLAG)
>  HOSTLDLIBS_bpf-fancy += $(MFLAG)
>  HOSTLDLIBS_dropper += $(MFLAG)
> +HOSTLDLIBS_user-trap.o += $(MFLAG)
>  HOSTLDLIBS_user-trap += $(MFLAG)
>  endif
>  always := $(hostprogs-m)



-- 
Kees Cook
