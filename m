Return-Path: <SRS0=YXOF=5I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA17C4332E
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254CE20719
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HY0cWUyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgCWTdu (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:33:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45913 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbgCWTds (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 15:33:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9so6334711pls.12
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2020 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QK1jZXR8lSHrMmCV4BaYuYh+4tyJTB+kyT8mffooOtA=;
        b=HY0cWUyiO+tlb7hC5bbViSYOfF0QR6yS/1XYhTW2nFMIXjADrDzAxBWqUWl09jzXYi
         3tQQblO3u2Xd6Lslklk+9nGAGLXb0BWsi83Uc5JrUD4ztiVDckfTvwJqUaPWGCMGQvQo
         wMTNDwOJIF8n6FNk1wvZaHcl9wbszdMe71fUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QK1jZXR8lSHrMmCV4BaYuYh+4tyJTB+kyT8mffooOtA=;
        b=YNQLy1fb/HSyi2xXyn+wINrBFwuE4+K9ET0Vxh5TUefRC18vebwpc9559sDgG1sx44
         uoEsI9rHh4F/WfB+W1RIjuKDrbFOv3wSjF3LQKbolzC8fY0yklkqxCqzCH3yHx06H2Xc
         xPvE+E31e6D4NVW8iQOvTtVkDqet78RL2zs2Gw97dnGFJsGoYEPH376ZbpKcag9Ctlr6
         lxJYisCSBxu8XLrnySVYBWGA0PvrU5dg79q/i18AZOEyfv4DZ4hccFkYE/k2xZCKdDDg
         M+O5593RN+JDZ+0Dhv4yC0++Cw4Fmy+gDwIoJVC1FqN0MhzDNs5F5mNtyrezKRYWwv+/
         kT2A==
X-Gm-Message-State: ANhLgQ0xgpuCwusCWlyOd6FkuvgQrC3RgKFIv0v7zLweQWztFaPmcYsi
        mIRB/H9eCcnpvksWW0uQBYlokw==
X-Google-Smtp-Source: ADFU+vvWLmXaf6AUKUF5V6qy/3SqirUY/UMVqEGOYugH0BR4CvrraHrsBBXWHeoHg3BMrlOSLtzdRw==
X-Received: by 2002:a17:90a:1a43:: with SMTP id 3mr993827pjl.35.1584992026093;
        Mon, 23 Mar 2020 12:33:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm14827161pfk.99.2020.03.23.12.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:33:45 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:33:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: lsm: provide attachment points for
 BPF LSM programs
Message-ID: <202003231233.9C1E0B830@keescook>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-4-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323164415.12943-4-kpsingh@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 23, 2020 at 05:44:11PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> When CONFIG_BPF_LSM is enabled, nops functions, bpf_lsm_<hook_name>, are
> generated for each LSM hook. These nops are initialized as LSM hooks in
> a subsequent patch.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  include/linux/bpf_lsm.h | 21 +++++++++++++++++++++
>  kernel/bpf/bpf_lsm.c    | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 include/linux/bpf_lsm.h
> 
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> new file mode 100644
> index 000000000000..c6423a140220
> --- /dev/null
> +++ b/include/linux/bpf_lsm.h
> @@ -0,0 +1,21 @@
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
> +#define LSM_HOOK(RET, NAME, ...) RET bpf_lsm_##NAME(__VA_ARGS__);
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
> +
> +#endif /* CONFIG_BPF_LSM */
> +
> +#endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 82875039ca90..530d137f7a84 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,25 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +/* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> + * function where a BPF program can be attached as an fexit trampoline.
> + */
> +#define LSM_HOOK(RET, NAME, ...) LSM_HOOK_##RET(NAME, __VA_ARGS__)
> +
> +#define LSM_HOOK_int(NAME, ...)			\
> +noinline __weak int bpf_lsm_##NAME(__VA_ARGS__)	\
> +{						\
> +	return 0;				\
> +}
> +
> +#define LSM_HOOK_void(NAME, ...) \
> +noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> +
> +#include <linux/lsm_hook_names.h>
> +#undef LSM_HOOK
>  
>  const struct bpf_prog_ops lsm_prog_ops = {
>  };
> -- 
> 2.20.1
> 

-- 
Kees Cook
