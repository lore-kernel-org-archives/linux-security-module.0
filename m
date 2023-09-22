Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB88E6FE58
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 15:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjIVPuM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjIVPuM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 11:50:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2319D
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69101d33315so2131340b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397805; x=1696002605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjDy5OSCF7yLkj7euFiTOoaO+slE+Y2FxPf45PENuII=;
        b=HEZzUCAkkQvJ2N1CC2jf2rv0nZmofjok0nwgWiJ2uNXxNR/rFl+sDzuKySJ7eolN5Z
         Djqk5Wekbol0L6slEANuHFJI31facKBlzyK4E6MaLDTjqRQv3idpAE6hJEVTqp3cSQDQ
         /mr2SrQmQ7btUkYTHN56/GmxBWxmU9KeCR9DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397805; x=1696002605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjDy5OSCF7yLkj7euFiTOoaO+slE+Y2FxPf45PENuII=;
        b=JZdnBJNiwBXGF5lkMw1twn2+Z4CFix2WorcZII5UvUHbNz8Np3heeIMM7Ep6HkCMqT
         ln0eQpjeCRIW0O68ODsJXeQMp9hZwxjB6Fgs10vXlrySgglzpUCssQd7ATNcz/MR5WLj
         A6V2YhCBTaIDOMtBEEmv3QDk8C5Up9iOhF4n+4Y+MzyiX6c4/lWYSywLd035l/rWwZK5
         Jo+yL4iiCFakHAIoEteZN+LoEA/oXf5uFAzjIs9k2NHsjlaSE3CiQXC0z9VbkNqlSlUm
         /lzcT8loKD5yihuWEZ8l9+ebK0Duhx5xMWucBRpbahgBfXozb32TT5j3C257BTfEnLXw
         qMkg==
X-Gm-Message-State: AOJu0Yy/C2eUggCZg9KgSDAfjq4uMv6S3+Frcw9wHHluia3ZH86W74Sv
        kX1o6JGzVasZVc0L7ZjgffqOhq61+R97XkIS9as=
X-Google-Smtp-Source: AGHT+IEyyf+eoxkS475t1c2a/GoGX7CVxeb+OCII96IfP6uUaUp7ghV1v6M46ZydurIEd8ewkEU02Q==
X-Received: by 2002:a05:6a20:564c:b0:15d:8b15:8266 with SMTP id is12-20020a056a20564c00b0015d8b158266mr3389008pzc.32.1695397805085;
        Fri, 22 Sep 2023 08:50:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b0068fe6ad4e18sm3362264pfm.157.2023.09.22.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:50:04 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:50:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        Kui-Feng Lee <sinquersw@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v4 2/5] security: Count the LSMs enabled at compile time
Message-ID: <202309220848.010A198E7@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
 <20230922145505.4044003-3-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-3-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 04:55:02PM +0200, KP Singh wrote:
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
> 
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
> 
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Thought below, but regardless of result:

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  include/linux/lsm_count.h | 107 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 include/linux/lsm_count.h
> 
> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..4d6dac6efb75
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __LINUX_LSM_COUNT_H
> +#define __LINUX_LSM_COUNT_H
> +
> +#include <linux/args.h>
> +
> +#ifdef CONFIG_SECURITY
> +
> +/*
> + * Macros to count the number of LSMs enabled in the kernel at compile time.
> + */
> +
> +/*
> + * Capabilities is enabled when CONFIG_SECURITY is enabled.
> + */
> +#if IS_ENABLED(CONFIG_SECURITY)
> +#define CAPABILITIES_ENABLED 1,
> +#else
> +#define CAPABILITIES_ENABLED
> +#endif

We're in an #ifdef CONFIG_SECURITY, so CAPABILITIES_ENABLED will always
be set. As such, we could leave off the trailing comma and list it
_last_ in the macro, and then ...

> +/*
> + *  There is a trailing comma that we need to be accounted for. This is done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)

This wouldn't be needed...

> +
> +#define MAX_LSM_COUNT			\
> +	COUNT_LSMS(			\
> +		CAPABILITIES_ENABLED	\
> +		SELINUX_ENABLED		\
> +		SMACK_ENABLED		\
> +		APPARMOR_ENABLED	\
> +		TOMOYO_ENABLED		\
> +		YAMA_ENABLED		\
> +		LOADPIN_ENABLED		\
> +		LOCKDOWN_ENABLED	\
> +		BPF_LSM_ENABLED		\
> +		LANDLOCK_ENABLED)


	COUNT_ARGS(			\
		SELINUX_ENABLED		\
		SMACK_ENABLED		\
		...
		CAPABILITIES_ENABLED)

-Kees

-- 
Kees Cook
