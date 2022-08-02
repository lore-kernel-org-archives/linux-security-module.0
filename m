Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496C7C00140
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Aug 2022 22:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiHBWUH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Aug 2022 18:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiHBWUF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Aug 2022 18:20:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC9740BCC
        for <linux-security-module@vger.kernel.org>; Tue,  2 Aug 2022 15:20:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kb8so13758118ejc.4
        for <linux-security-module@vger.kernel.org>; Tue, 02 Aug 2022 15:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3w2KqqM6Jon4wwPxOegeac+q79TdKrQ7N+AdrcSklFg=;
        b=H9BrTRLxOTaQlJ7/9iMdxEhU56cAjt38vgP4aXI9tjpNEj7NTnaimqQOHdoBqgS2WK
         G0vC8ZgWAYr843jGgPK9tLYckA6+aM+Iadoi+3epi1lmi/foBRdrxAob0URoiFr02BUA
         DF4HBlqMRXMHisqqe7OY1TXHjYw49r1kimsZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3w2KqqM6Jon4wwPxOegeac+q79TdKrQ7N+AdrcSklFg=;
        b=A9AkDXiDhzUmTulXUAAotEyEUKePbPBAq8IOSKrhdYOjagTKYtD42Qtg5+BR9PBR2x
         0K3f4QU9o1urLUnBSVGznlmIf/50Soz93czvLUqhwPqBYznz39yPOuzhUvo9+p6ySBY8
         2pGOacjkvRvSBVz7zziny3tWxbODEetWPAJBY7E5VpdfiusZ+LzLLys+7Ke+ud/XiCZm
         jPXnlulRHpLSnGVWLaqKPqGq3Lv5VvCmDvqSI0FY7n0DkB9bMvYXOeTw8TkG2o+m0w9H
         Ry037+Dx1N/YbLEFhfpRFbDfVLeIjdGa+SZySBeXb7FgEJkAWyLIET3XjvdJHEhWk8BD
         50Pw==
X-Gm-Message-State: ACgBeo2DPnAXI0/2isAoHxip3Fe4eqFf56Mzk6I+o70AS9Jw+HWgGovH
        Hwn5OglmtXsk0+vXk2eDTXqthZC51ETmAOo1
X-Google-Smtp-Source: AA6agR41W8FdpQOSRoOpuc/FDtLrxOook3RPERNcN5PjYOTlm9SOQEvfUaIxIm4qFiDOhGtd0H0rJA==
X-Received: by 2002:a17:907:75d5:b0:730:b051:d93f with SMTP id jl21-20020a17090775d500b00730b051d93fmr109554ejc.568.1659478802538;
        Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id ky22-20020a170907779600b00730b057d43asm28437ejc.8.2022.08.02.15.20.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id b6so7838997wmq.5
        for <linux-security-module@vger.kernel.org>; Tue, 02 Aug 2022 15:20:02 -0700 (PDT)
X-Received: by 2002:a05:600c:3553:b0:3a3:2b65:299e with SMTP id
 i19-20020a05600c355300b003a32b65299emr824925wmq.145.1659478801765; Tue, 02
 Aug 2022 15:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
In-Reply-To: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Aug 2022 15:19:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
Message-ID: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v6.0
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 1, 2022 at 7:40 PM Micah Morton <mortonm@chromium.org> wrote:
>
> This pull request contains one commit that touches common kernel code,
>
> one that adds functionality internal to the SafeSetID LSM code, and a
>
> few other commits that only modify the SafeSetID LSM selftest.
[...]

What odd MUA do you use that causes this double-spaced text email?

I can read it, but it really is a bit strange. It was all plain text,
and marked as utf-8, and otherwise looked normal except for that
double spacing.

I get flashbacks to my "writing papers at university" days.

             Linus
