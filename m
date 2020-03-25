Return-Path: <SRS0=gnGb=5K=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E31C2D0E7
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267DC2074D
	for <linux-security-module@archiver.kernel.org>; Wed, 25 Mar 2020 19:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YabBaUbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgCYTaI (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:30:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35218 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgCYTaI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Mar 2020 15:30:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so1430527pjp.0
        for <linux-security-module@vger.kernel.org>; Wed, 25 Mar 2020 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6L4EoCXGl4SVLeZhCWnOV/ZKmujTYSYnek7Jb5npJGM=;
        b=YabBaUbMQjsfrDiMHMNiWG/FA2jbcQt0bT057IUzTqNiMDPKbRfB14T8vgqazbi1P2
         C9luJarJBIu3AkhwHUuYewfmHRFrp5p2Xqtck5S0GXUPowKq53pmk7vlQJxb4n+jAISF
         jsCyTCukefEdL8fXbDg2vVJgsV8IMWRHxhFL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6L4EoCXGl4SVLeZhCWnOV/ZKmujTYSYnek7Jb5npJGM=;
        b=rjFBqquOU2uybcZsZBmlhKVIEx2fxz2LLVUO3xFbkWnxIayabLZM/S48v5EG8b8bOk
         m0/BmAIoyFCSdBX40mE9VrM43mi4zS/gZzj8UVLgv+iNoIcub96MbGBdv6pT7vl0aK2q
         b4LbJjlDax1QwzynXK2Dyi5iW+EXw7ftIgwBTDgZje//x1G5IkyXcYJ3WVrhNQtG3RE2
         Qb8qzLMhTjOpyDJrXLjZfKCRtl2t11oDikj1MBUCjs9cpz0G9+KevAstXxmVIox4JtW8
         lCs7THkTujC1UV59L/DBsIC+qd3h1wOpAgWojmrgvPZSOLsPppq/TmZ7fh+FmRocbe+9
         J/jQ==
X-Gm-Message-State: ANhLgQ2StkVW5dS19KFfYPn8Hz8qCRKGNW7tao6d7Vye9z97pEQrlOyc
        Er4tKdWSMNt/ezUvEecho+WQJg==
X-Google-Smtp-Source: ADFU+vs5orbFYF3Rkglvd7lPCdetVTM8pa1syGgcz48eqAAE6vFJ+7X1kruyDJDakVLI9fX3oeD1Og==
X-Received: by 2002:a17:90a:c715:: with SMTP id o21mr5602539pjt.160.1585164606560;
        Wed, 25 Mar 2020 12:30:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8sm18746616pfn.2.2020.03.25.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:30:05 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:30:04 -0700
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
Subject: Re: [PATCH bpf-next v6 5/8] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <202003251229.C146482793@keescook>
References: <20200325152629.6904-1-kpsingh@chromium.org>
 <20200325152629.6904-6-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325152629.6904-6-kpsingh@chromium.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 25, 2020 at 04:26:26PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> * The hooks are initialized using the definitions in
>   include/linux/lsm_hook_defs.h.
> * The LSM can be enabled / disabled with CONFIG_BPF_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  security/Kconfig      | 10 +++++-----
>  security/Makefile     |  2 ++
>  security/bpf/Makefile |  5 +++++
>  security/bpf/hooks.c  | 26 ++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 5 deletions(-)
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/hooks.c
> 
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..cd3cc7da3a55 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -277,11 +277,11 @@ endchoice
>  
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor" if DEFAULT_SECURITY_SMACK
> -	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo" if DEFAULT_SECURITY_APPARMOR
> -	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo" if DEFAULT_SECURITY_TOMOYO
> -	default "lockdown,yama,loadpin,safesetid,integrity" if DEFAULT_SECURITY_DAC
> -	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
> +	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> +	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> +	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list will be ignored. This can be
> diff --git a/security/Makefile b/security/Makefile
> index 746438499029..22e73a3482bd 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -12,6 +12,7 @@ subdir-$(CONFIG_SECURITY_YAMA)		+= yama
>  subdir-$(CONFIG_SECURITY_LOADPIN)	+= loadpin
>  subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
>  subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
> +subdir-$(CONFIG_BPF_LSM)		+= bpf
>  
>  # always enable default capabilities
>  obj-y					+= commoncap.o
> @@ -30,6 +31,7 @@ obj-$(CONFIG_SECURITY_LOADPIN)		+= loadpin/
>  obj-$(CONFIG_SECURITY_SAFESETID)       += safesetid/
>  obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>  obj-$(CONFIG_CGROUP_DEVICE)		+= device_cgroup.o
> +obj-$(CONFIG_BPF_LSM)			+= bpf/
>  
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+= integrity
> diff --git a/security/bpf/Makefile b/security/bpf/Makefile
> new file mode 100644
> index 000000000000..c7a89a962084
> --- /dev/null
> +++ b/security/bpf/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020 Google LLC.
> +
> +obj-$(CONFIG_BPF_LSM) := hooks.o
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> new file mode 100644
> index 000000000000..32d32d485451
> --- /dev/null
> +++ b/security/bpf/hooks.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2020 Google LLC.
> + */
> +#include <linux/lsm_hooks.h>
> +#include <linux/bpf_lsm.h>
> +
> +static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
> +	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> +	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),
> +	#include <linux/lsm_hook_defs.h>
> +	#undef LSM_HOOK
> +};
> +
> +static int __init bpf_lsm_init(void)
> +{
> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> +	pr_info("LSM support for eBPF active\n");
> +	return 0;
> +}
> +
> +DEFINE_LSM(bpf) = {
> +	.name = "bpf",
> +	.init = bpf_lsm_init,
> +};
> -- 
> 2.20.1
> 

-- 
Kees Cook
