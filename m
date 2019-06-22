Return-Path: <SRS0=kyj6=UV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042CC48BE8
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 23:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9DE20820
	for <linux-security-module@archiver.kernel.org>; Sat, 22 Jun 2019 23:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dGAAyY5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfFVX6Z (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:58:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41855 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFVX6Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 19:58:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so5421743pff.8
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QkZqiu2e/y7+phBcsq5SoX4+beWXUj/CML40Z1zWPDw=;
        b=dGAAyY5eundVFCsa+eIl/VJN4Acqx7GYdJxXAKE3xONM/98BgVGI2N6I0p7PwaBqST
         zQUgtbOOrGDpELJmQE2730Lf8twlogB9yOxEmrOrcX12TwKTwEDFDsqNUieOmT7Uzl/X
         GgaaWR100aNp1cSTdmWHKbrHVznJvWlCS+YEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QkZqiu2e/y7+phBcsq5SoX4+beWXUj/CML40Z1zWPDw=;
        b=kkrOfMlKyhesdH7FyXeoJfvpC92bfNvWdZKzzjW6vpab4kAtM5+hft4b+tz6rNNqbe
         OcaIs4m/fRsHjpg45mivIYUbqwkkY+EUEmEj+vUybMQ08ZERRvwLE+O0ydjOVx5AZCF5
         HattvqeNRnkp8TI+DzpHC5/DsOjOpDQOEiVkOZ8Fgo6kVYBOq0GLdy4f/Twh2w2Ks+AW
         HJIj8B0vy7fouDU6gaUN3UHwuDILwNtqBOQQm7B2W0B7S9xD/2UGbeytMu3HIsXxv+Nv
         LAOu8fnwdClud/9YNAEJJitL+zLbLQBOr6qvPYokevgQ2TMxfh8vOXZczrd10HEO6erS
         zakA==
X-Gm-Message-State: APjAAAXATzK1ZuUICey5TOMerCEFDtYi4UokBIxjvGzPGC5s6Wq2hCW5
        h33tCVz/kb7LC6LyIAAmhUaCBYNxAoQ=
X-Google-Smtp-Source: APXvYqzm1p5YWR0w/fMpvfsFwA3ESTNRKevh3beHc+EUhTCbkUth0WpZMYBecOeL87uvvPdELiZIJQ==
X-Received: by 2002:a63:5202:: with SMTP id g2mr25404741pgb.386.1561247903777;
        Sat, 22 Jun 2019 16:58:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13sm6832459pje.28.2019.06.22.16.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:58:23 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:58:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V34 12/29] x86: Lock down IO port access when the kernel
 is locked down
Message-ID: <201906221658.C4956B7@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-13-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-13-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:41PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> IO port access would permit users to gain access to PCI configuration
> registers, which in turn (on a lot of hardware) give access to MMIO
> register space. This would potentially permit root to trigger arbitrary
> DMA, so lock it down by default.
> 
> This also implicitly locks down the KDADDIO, KDDELIO, KDENABIO and
> KDDISABIO console ioctls.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: x86@kernel.org
> ---
>  arch/x86/kernel/ioport.c     | 7 +++++--
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
> index 0fe1c8782208..61a89d3c0382 100644
> --- a/arch/x86/kernel/ioport.c
> +++ b/arch/x86/kernel/ioport.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/ioport.h>
> +#include <linux/security.h>
>  #include <linux/smp.h>
>  #include <linux/stddef.h>
>  #include <linux/slab.h>
> @@ -31,7 +32,8 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
>  
>  	if ((from + num <= from) || (from + num > IO_BITMAP_BITS))
>  		return -EINVAL;
> -	if (turn_on && !capable(CAP_SYS_RAWIO))
> +	if (turn_on && (!capable(CAP_SYS_RAWIO) ||
> +			security_locked_down(LOCKDOWN_IOPORT)))
>  		return -EPERM;
>  
>  	/*
> @@ -126,7 +128,8 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
>  		return -EINVAL;
>  	/* Trying to gain more privileges? */
>  	if (level > old) {
> -		if (!capable(CAP_SYS_RAWIO))
> +		if (!capable(CAP_SYS_RAWIO) ||
> +		    security_locked_down(LOCKDOWN_IOPORT))
>  			return -EPERM;
>  	}
>  	regs->flags = (regs->flags & ~X86_EFLAGS_IOPL) |
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1b849f10dec6..60569b7e9465 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -87,6 +87,7 @@ enum lockdown_reason {
>  	LOCKDOWN_KEXEC,
>  	LOCKDOWN_HIBERNATION,
>  	LOCKDOWN_PCI_ACCESS,
> +	LOCKDOWN_IOPORT,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index e2ee8a16b94c..895ef3ba1b4c 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -23,6 +23,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_HIBERNATION] = "hibernation",
>  	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
> +	[LOCKDOWN_IOPORT] = "raw io port access",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
