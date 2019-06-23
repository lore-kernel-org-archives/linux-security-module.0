Return-Path: <SRS0=cqTL=UW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24974C48BE8
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F074B20675
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ct2lfBjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfFWAES (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:04:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41199 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFWAEO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:04:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id y72so5113939pgd.8
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DuNgn1fRt0Noe9N4WIHGYdZESNZFk024t1Yh3J6ERz4=;
        b=Ct2lfBjnVJPTEv7MYTkSuL/J5d02jyxLNp5MuZoTl62m8WbBUCS5ZEbl4qzp9PHvZe
         IhBpYAq2Tb/swRsBkNbWuBaW1DC9jFk6/K6mwB1mK8GnhF6rI2lgo/cwjX2Z1YoOJs6I
         NoY6xpODp1Ica7/emSHq5ZSoC1KfS5oBtJhZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DuNgn1fRt0Noe9N4WIHGYdZESNZFk024t1Yh3J6ERz4=;
        b=D4QBhe6xcITi/PW1ki3JnrHey8IVcLtOy9aNUBvOhOYYV2yuy2ZOXdjeIE574VqTdw
         NYlX4fG7UvCygYFsxEpQXUGZ9EynXsjClzd7eaEH0i3dBe3J+7D0H7lD6fX+cLVL+ZcK
         2u4MI6zZUVJHMj0NykalxE2XXqUJWtnULqwiEDyvz3rqz9fEyakS2V/isn5e8aW9R4ri
         DKV04ug0GCmvldr+8A4/sTOPTfPVmTx2aQc/DmLiofbgNT5QbjbTtpub8c2nwWT+2VH8
         VVqDlpqYXlDbGebpo+DL/cA/qgoWuZlqnicILtWYaM+N74dnNEhoFZP+ldgVrFS9awwM
         2w2g==
X-Gm-Message-State: APjAAAXgV4cKTL897pBLdi7xnw08Ycgh5GmtxXf7LTZMeQU5482hRyYd
        Pq6tBDAmXhOWkNxPGrx0bSJEX0Wp4I4=
X-Google-Smtp-Source: APXvYqwaIDzKad46kDNiClSQHObakBjhyqKSnOoLnkDN9BIg83b8jF8EiGY2I91oVhzrAKEZqxXzFw==
X-Received: by 2002:a63:4518:: with SMTP id s24mr21561827pga.123.1561248253505;
        Sat, 22 Jun 2019 17:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm5502250pgq.40.2019.06.22.17.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:04:12 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:04:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
Message-ID: <201906221704.BB65DED6E5@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-20-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-20-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:48PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  include/linux/security.h     |  1 +
>  kernel/params.c              | 27 ++++++++++++++++++++++-----
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 61e3f4a62d16..88064d7f6827 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -92,6 +92,7 @@ enum lockdown_reason {
>  	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_TIOCSSERIAL,
> +	LOCKDOWN_MODULE_PARAMETERS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/params.c b/kernel/params.c
> index ce89f757e6da..f94fe79e331d 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -24,6 +24,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/ctype.h>
> +#include <linux/security.h>
>  
>  #ifdef CONFIG_SYSFS
>  /* Protects all built-in parameters, modules use their own param_lock */
> @@ -108,13 +109,19 @@ bool parameq(const char *a, const char *b)
>  	return parameqn(a, b, strlen(a)+1);
>  }
>  
> -static void param_check_unsafe(const struct kernel_param *kp)
> +static bool param_check_unsafe(const struct kernel_param *kp,
> +			       const char *doing)
>  {
>  	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
>  		pr_notice("Setting dangerous option %s - tainting kernel\n",
>  			  kp->name);
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>  	}
> +
> +	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> +	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> +		return false;
> +	return true;
>  }
>  
>  static int parse_one(char *param,
> @@ -144,8 +151,10 @@ static int parse_one(char *param,
>  			pr_debug("handling %s with %p\n", param,
>  				params[i].ops->set);
>  			kernel_param_lock(params[i].mod);
> -			param_check_unsafe(&params[i]);
> -			err = params[i].ops->set(val, &params[i]);
> +			if (param_check_unsafe(&params[i], doing))
> +				err = params[i].ops->set(val, &params[i]);
> +			else
> +				err = -EPERM;
>  			kernel_param_unlock(params[i].mod);
>  			return err;
>  		}
> @@ -553,6 +562,12 @@ static ssize_t param_attr_show(struct module_attribute *mattr,
>  	return count;
>  }
>  
> +#ifdef CONFIG_MODULES
> +#define mod_name(mod) (mod)->name
> +#else
> +#define mod_name(mod) "unknown"
> +#endif
> +
>  /* sysfs always hands a nul-terminated string in buf.  We rely on that. */
>  static ssize_t param_attr_store(struct module_attribute *mattr,
>  				struct module_kobject *mk,
> @@ -565,8 +580,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
>  		return -EPERM;
>  
>  	kernel_param_lock(mk->mod);
> -	param_check_unsafe(attribute->param);
> -	err = attribute->param->ops->set(buf, attribute->param);
> +	if (param_check_unsafe(attribute->param, mod_name(mk->mod)))
> +		err = attribute->param->ops->set(buf, attribute->param);
> +	else
> +		err = -EPERM;
>  	kernel_param_unlock(mk->mod);
>  	if (!err)
>  		return len;
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index c89046dc2155..d03c4c296af7 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
>  	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>  	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
> +	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
