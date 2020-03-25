Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E490DC2D0E5
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72B72074D
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 19:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gPfPaVQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYT3C (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:29:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43703 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgCYT3C (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 15:29:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so1629903pgb.10
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rVEA1fnFFcIWOeL5zXMHQTp1aBPMsrLrZyBjvLPiLRU=;
        b=gPfPaVQai63uk6Om4qjYnBgTUEKBxmnzI5iwkr04eOe09U4mQ196leEbp+I9r0X+hd
         RuO4hYZwrZKxduFI/hzfN7cxCASTZhkfCKv8gJ8ZGwpfdyZXAGMrrnlzswDJqSdxTmuo
         Ug1Lw7eBXbZ87kRitG8EYK2HRjYkeioDTW9mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rVEA1fnFFcIWOeL5zXMHQTp1aBPMsrLrZyBjvLPiLRU=;
        b=GAi96PIoKhzF9NLrWJQpXi5D0alIIA7CqbPhnhicSqNtpITOPpMlTR9JiFyAPJhxUY
         RObqSO9uA3QpvnZPh7Am0o8YFKE3kBfuqs7fNPKbnwzMuNmmlK6Sgk3kFIN7OU1WGJLx
         fD/RAxb9n+OqfgYyYgIRRvpMAq+nyo7u7su1Gw+0+i2LhbERgFRmuD/Jfx/ThRpda4Zn
         uuJS1F8fdthvTdA/6Rwp+RLf8DTH1H9BIjFKfH2FjYqwBtwEZzvtXaqySjQeO6AXgRYk
         Z+c6yHbb9WWtSvnzqsVhPG03FJFQnj7QtYVzApIApMsched8V2uvOBjqlTFe7MPzilp0
         cwyQ==
X-Gm-Message-State: ANhLgQ0sVv57hr+jAUFfc4geHAQz9+zInP2jwYpKRzFLs4xx5SGVKsB4
        jTOxbmFiaOEOGumEQ5CShvaJKw==
X-Google-Smtp-Source: ADFU+vsu2Cw98SHfFXx1pKAQY4JSLE3Orstirbhflq9fp1jD+tqPTkyGP+3heKz/M20ohMKz4Uu2Lg==
X-Received: by 2002:a65:5383:: with SMTP id x3mr4566831pgq.279.1585164541179;
        Wed, 25 Mar 2020 12:29:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b17sm19245567pff.81.2020.03.25.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:29:00 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:28:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v6 3/8] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202003251225.923FF1DD7@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325152629.6904-4-kpsingh@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 25, 2020 at 04:26:24PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nop functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These functions are initialized as LSM
> hooks in a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf_lsm.h | 22 ++++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 14 ++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..83b96895829f
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +
> +#ifndef _LINUX_BPF_LSM_H
> +#define _LINUX_BPF_LSM_H
> +
> +#include <linux/bpf.h>
> +#include <linux/lsm_hooks.h>
> +
> +#ifdef CONFIG_BPF_LSM
> +
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +	RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82875039ca90..1210a819ca52 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,20 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook that allows attachment of BPF programs, declare a nop
> + * function where a BPF program can be attached.
> + */
> +#define LSM_HOOK(RET, DEFAULT, NAME, ...) 	\
> +noinline __weak RET bpf_lsm_##NAME(__VA_ARGS__)	\

I don't think the __weak is needed any more here?

> +{						\
> +	return DEFAULT;				\

I'm impressed that LSM_RET_VOID actually works. :)

-Kees

> +}
> +
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
>  
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
> -- 
> 2.20.1
> 

-- 
Kees Cook
