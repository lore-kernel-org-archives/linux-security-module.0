Return-Path: <SRS0=VGHz=ZW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6AAC432C0
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8EA2082E
	for <linux-security-module@archiver.kernel.org>; Sat, 30 Nov 2019 18:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Krbcqo0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfK3SgY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:36:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36302 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3SgX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 30 Nov 2019 13:36:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so1818263pls.3
        for <linux-security-module@vger.kernel.org>; Sat, 30 Nov 2019 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qZ1o2V3hAh/qfyjdU5nFlpejCe/YJXXlPCs+yZeVIok=;
        b=Krbcqo0YdXhaTUUJVl/+2Fce1HFgU7JSucA6c0LvoNeHn5a8nVFWDeRd3IlABfnCt0
         jNaIEyL3cw79CD0QeHt+7nQdyhABbsuNml875G+pi2FVAD6U2ud39aDFyGMjXb/2xa9a
         MstjhiqYfhb3hWCrBzHbzHTJuc223bfQBsGzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qZ1o2V3hAh/qfyjdU5nFlpejCe/YJXXlPCs+yZeVIok=;
        b=uHwzaRbq9rCw0Y8y5V1FPVIgQNX/eWyFXFfbS+9wJwz/iR6qUJBoUyLliqSM3xo98m
         gXW1GY6Qp5vE/va/NCdJSYsZ82hHFSenKhl1xVG6JFkwJ0ymiDJ6UXuDAmgaR/QSdn2Z
         O3XA4QuoltanlCybbQ4AADZoW8erfe+Ye5cuXdU2Xx9JiLxwhIR+IOfTrDKnbaEu5YLm
         f3kjIrxVPRji8jc3JlllifzZV4bfnuVvRXVn9wcQ7guaiqr4L0gKSZL8XhXaA9fZRZCy
         ytmVo+ndjOUyLUvc75hhRYMsSBgREqgEExQAUEDAKTaumeTQronge3K4oV5Qxdo8uSU5
         iAWQ==
X-Gm-Message-State: APjAAAW6Vv3XbghJ3je+JRo3pkD4EeuS2fEYLxjS2ttEBfNMmQ0InqAO
        XZ2dkeBPtQnSSU6eqpi2fsgFJA==
X-Google-Smtp-Source: APXvYqy+diVD0tUscZd4+OkE0EBOpBhEIWtRpnIfmfkzt2DXRZZpwiFYupUDqpQEfsa2faMqQg8Blw==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr23550712pje.9.1575138982021;
        Sat, 30 Nov 2019 10:36:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k4sm28633711pfa.25.2019.11.30.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 10:36:21 -0800 (PST)
Date:   Sat, 30 Nov 2019 10:36:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Matt Parnell <mparnell@gmail.com>
Cc:     linux-security-module@vger.kernel.org, dhowells@redhat.com,
        matthew.garrett@nebula.com
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
Message-ID: <201911301035.74813D4533@keescook>
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, Nov 30, 2019 at 12:49:48AM -0600, Matt Parnell wrote:
> From 452b8460e464422d268659a8abb93353a182f8c8 Mon Sep 17 00:00:00 2001
> From: Matt Parnell <mparnell@gmail.com>
> Date: Sat, 30 Nov 2019 00:44:09 -0600
> Subject: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access even
>  in confidentiality mode.
> 
> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
> while this isn't something normally used in userspace, it does cause false
> positives for the "Forshadow" vulnerability.
> 
> Additionally, Intel CPUs use MSRs for voltage and frequency controls,
> which in
> many cases is useful for undervolting to avoid excess heat.
> 
> Signed-off-by: Matt Parnell <mparnell@gmail.com>

I would expect this to just be implemented via LSM policy, not ifdefs
and Kconfig?

-Kees

> ---
>  arch/x86/kernel/msr.c     |  5 ++++-
>  security/lockdown/Kconfig | 12 ++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
> index 1547be359d7f..4adce59455c3 100644
> --- a/arch/x86/kernel/msr.c
> +++ b/arch/x86/kernel/msr.c
> @@ -80,10 +80,11 @@ static ssize_t msr_write(struct file *file, const
> char __user *buf,
>      int err = 0;
>      ssize_t bytes = 0;
>  
> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>      err = security_locked_down(LOCKDOWN_MSR);
>      if (err)
>          return err;
> -
> +#endif
>      if (count % 8)
>          return -EINVAL;    /* Invalid chunk size */
>  
> @@ -135,9 +136,11 @@ static long msr_ioctl(struct file *file, unsigned
> int ioc, unsigned long arg)
>              err = -EFAULT;
>              break;
>          }
> +#if defined(LOCK_DOWN_DENY_RAW_MSR)
>          err = security_locked_down(LOCKDOWN_MSR);
>          if (err)
>              break;
> +#endif
>          err = wrmsr_safe_regs_on_cpu(cpu, regs);
>          if (err)
>              break;
> diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
> index e84ddf484010..f4fe72c4bf8f 100644
> --- a/security/lockdown/Kconfig
> +++ b/security/lockdown/Kconfig
> @@ -44,4 +44,16 @@ config LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
>       code to read confidential material held inside the kernel are
>       disabled.
>  
> +config LOCK_DOWN_DENY_RAW_MSR
> +    bool "Lock down and deny raw MSR access"
> +    depends on LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY
> +    default y
> +    help
> +      Some Intel based systems require raw MSR access to use the flush
> +      MSR for MDS mitigation confirmation. Raw access can also be used
> +      to undervolt many Intel CPUs.
> +
> +      Say Y to prevent access or N to allow raw MSR access for such
> +      cases.
> +
>  endchoice
> -- 
> 2.24.0
> 
> 




-- 
Kees Cook
