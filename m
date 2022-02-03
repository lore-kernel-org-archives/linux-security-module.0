Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0065C433EF
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Feb 2022 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354743AbiBCWNr (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Feb 2022 17:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiBCWNq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Feb 2022 17:13:46 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3285C06173B
        for <linux-security-module@vger.kernel.org>; Thu,  3 Feb 2022 14:13:46 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id t14so5926201ljh.8
        for <linux-security-module@vger.kernel.org>; Thu, 03 Feb 2022 14:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xJKejqFUEH0gH02bsrJyrmiS9uC9eYI5/u6Jxv0S8E=;
        b=H24z7FjJDol5wBZEbnN2Imdyd1onGd0cFpHlfJZfyL+uWUtNi2aoFXif9gUr+4s3Xv
         uBmskidnVWURLL+YtWHTjHZ9PJG9hKcRd7yQhsPw58FBd4qf0Q4eTR/0/1f4tOtdnCu1
         fDPqQqRoSiBLnGmelyqJmyFNGGvecWyqTLD4PXP1wAafPBiLwFGWOmNe+uuU6wMO8cfJ
         MRPioqayInupF70/CODAACEA0JvTFoJTv+OByl6ZVBfaxCQpBYUO/HI2TkIH1YBncuQK
         Lzw6UWJ7iq3T2kAX32oz66qtHCL6s7tKSB94chdxTr8WF7WpolWrLPftMc0su3IMkMdb
         /jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xJKejqFUEH0gH02bsrJyrmiS9uC9eYI5/u6Jxv0S8E=;
        b=CUjWQz/ay4WgW0N7PPeA3ckogPThwpvpH3BD6gfErkLmO46HY1iUmu1YcwfEmu148g
         +QXbL11jpq0q+6lbTCAx4H+OZ/CaqP1cd6k/F3NVxTykPfMZYvR96AYmmz8smjKgma7+
         EqVv8PH6y/UpxdKyU+pUbpdD0eFSqG9wY63d1CBFllGYFGcxzQ79stcpeJXemGTYtbYu
         E08DHOQkXpqdsc/W+HegOznvzbcrQ1wB0U91RNkJKdNt9jXpJFRi8CTAreprnNe/HntB
         E+aF55H+DZ8apoQtzm0S8TcMPGgPrP/6EVwhBn35eyHIayDNPS0gxq5FsA73ULeyE8lZ
         V3PA==
X-Gm-Message-State: AOAM530gVpKxFLO2WjqjYyqKy0e3UInMMFy1Ng97DZqnLWo2rfYCOQIU
        hEIuuIchw2s9jG1OAUt5zxalyTzCffp0EJ7GMn5YAOCWhyZP2A==
X-Google-Smtp-Source: ABdhPJwukk4FfgGCE9DXGX12jyqxMhXq20QnpHOQ5CsAHRtiMZ0ck8ImUh9oBxHNeO9V4ehDak2Z2QOHbbWezu5b8SI=
X-Received: by 2002:a05:651c:1305:: with SMTP id u5mr27111lja.339.1643926424857;
 Thu, 03 Feb 2022 14:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20220202003033.704951-1-keescook@chromium.org> <20220202003033.704951-5-keescook@chromium.org>
In-Reply-To: <20220202003033.704951-5-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Feb 2022 14:13:33 -0800
Message-ID: <CAKwvOdkvd=2DcwEpQWBtS3p-hKB6Rvp4YXB4k+81Me6E5H+mqQ@mail.gmail.com>
Subject: Re: [PATCH 4/4 v5] fortify: Add Clang support
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 1, 2022 at 4:30 PM Kees Cook <keescook@chromium.org> wrote:
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index c45159dbdaa1..5482536d3197 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -2,7 +2,9 @@
>  #ifndef _LINUX_FORTIFY_STRING_H_
>  #define _LINUX_FORTIFY_STRING_H_
>
> -#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline))
> +#include <linux/const.h>
> +
> +#define __FORTIFY_INLINE extern __always_inline __attribute__((gnu_inline)) __overloadable

Sorry, I just noticed this line (already) uses a mix of open coding
__attribute__ and not. Would you mind also please changing the open
coded gnu_inline to simply __gnu_inline to make the entire line
consistent?
-- 
Thanks,
~Nick Desaulniers
