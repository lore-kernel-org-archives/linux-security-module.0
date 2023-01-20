Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB64C38159
	for <linux-security-module@archiver.kernel.org>; Fri, 20 Jan 2023 03:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjATDsg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 19 Jan 2023 22:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjATDsf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Jan 2023 22:48:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683B7D657
        for <linux-security-module@vger.kernel.org>; Thu, 19 Jan 2023 19:48:33 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b6so3181927pgi.7
        for <linux-security-module@vger.kernel.org>; Thu, 19 Jan 2023 19:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5xYlYYwidFMsYGMcEAqTW/TSYKnVvBTImcdKv0esWOg=;
        b=I/hCvBgArkRJYrKjLErfJ1lV42+ANPGFDVtEjg6t987XpBK3FBhyVvno/lo4aSL/dT
         PbuweWutUZ+PwzDMbE9ARqEpJ4VlkEB7BmhMUcYqaXJCEIfzK/wy2yok7ogGYaPEERa8
         ++kpPOQJ2yDe+cLBQUaU3kKK08drO+kynVThk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xYlYYwidFMsYGMcEAqTW/TSYKnVvBTImcdKv0esWOg=;
        b=uRGd8/VKT0n32LgEPkVH1IoGX0Ea8UdkpP8hxxA+2Fp+NO5SVvqE8eR/u3EHgtDaiF
         SVo5vPQMMbp4dzXAHqqKagP3KkN7ROV2es+DUlTddtfOihbSGu+h+TI3A+RRRW/5aabp
         pjVVWwrh/pAZf8XhwHyWHXqiBF1n+5sLyXaNTwjYzSQSEn+jMeV3ekBtAgLD6If6lJKf
         lYc05ha5AzwbwXTWuRxspHQFPf4z9RfR8RVBDi0kpgIBfHE/kMnSr7RM6OFqLPvkrH27
         k9r5bnoq0YnWh3SBZy1FKOFVGIid49JSZCLtkYAqnk5n76/DHe1l5ubGbmzAWlOprdJH
         A+Kg==
X-Gm-Message-State: AFqh2kpESU8lN3DF1v9sFi+dedNQyZ89y6H82NJOhCfkvunb9b9i5Qqy
        t6I96fhqj8ujA70nbn2JFXpikg==
X-Google-Smtp-Source: AMrXdXuax1LzobrWZKP/qQYBYMBg3lpUvoOqNaUBZ09TA0aRtS+pTYsDlgKqY/lBz5hhwaYk+J6s4g==
X-Received: by 2002:aa7:88d5:0:b0:58d:a683:bb2d with SMTP id k21-20020aa788d5000000b0058da683bb2dmr18113345pff.30.1674186513080;
        Thu, 19 Jan 2023 19:48:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4-20020a626104000000b0058de0998f17sm4629415pfb.154.2023.01.19.19.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 19:48:32 -0800 (PST)
Date:   Thu, 19 Jan 2023 19:48:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, casey@schaufler-ca.com,
        song@kernel.org, revest@chromium.org
Subject: Re: [PATCH RESEND bpf-next 1/4] kernel: Add helper macros for loop
 unrolling
Message-ID: <202301191938.A7465D123@keescook>
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-2-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120000818.1324170-2-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jan 20, 2023 at 01:08:15AM +0100, KP Singh wrote:
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
> 
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
> 
> As an example:
> 
> 	#include <linux/unroll.h>
> 
> 	#define MACRO(N, a, b)            \
> 		int add_##N(int a, int b) \
> 		{                         \
> 			return a + b + N; \
> 		}
> 
> 	UNROLL(2, MACRO, x, y)
> 
> expands to:
> 
> 	int add_0(int x, int y)
> 	{
> 		return x + y + 0;
> 	}
> 
> 	int add_1(int x, int y)
> 	{
> 		return x + y + 1;
> 	}
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/unroll.h | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 include/linux/unroll.h
> 
> diff --git a/include/linux/unroll.h b/include/linux/unroll.h
> new file mode 100644
> index 000000000000..e19aef95b94b
> --- /dev/null
> +++ b/include/linux/unroll.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef __UNROLL_H
> +#define __UNROLL_H
> +
> +#define __UNROLL_CONCAT(a, b) a ## _ ## b

#include <linux/kernel.h>
and just use CONCATENATE

> +#define UNROLL(N, MACRO, args...) __UNROLL_CONCAT(__UNROLL, N)(MACRO, args)

Which would be, and it just loses the _, which isn't important here:
#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL, N)(MACRO, args)

> +#define __UNROLL_0(MACRO, args...)
> +#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)

But yeah, I like it. It's an expression version of the __MAP() macro
used by the syscall wrappers for arguments.

-- 
Kees Cook
