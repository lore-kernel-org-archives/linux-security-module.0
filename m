Return-Path: <SRS0=cqTL=UW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B79C43613
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE4A20820
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9KrA/BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFWAAb (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:00:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36741 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfFWAAa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:00:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so4811766plt.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMNIOFseSQcYxEjUupK03sQ66VU8PHhoSnEBiSbAi/U=;
        b=L9KrA/BXNHjmkaxVKByrkDNtPrPxcRka74HGOxpTB9HdyCU0HX6rGTdR1kesAuwNE6
         bEqA6NQtCugbqlji1SSJWR2rkIbnz/qGV2/w8Ca+uQhOf1vKSPBK2oVMvV+nGeN/xHTA
         zmwsG0H1akysKNNV2CZuBg47LFUQNbYSuCbRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMNIOFseSQcYxEjUupK03sQ66VU8PHhoSnEBiSbAi/U=;
        b=cl3NLFRUsvMniFGh/qwoTU0dxmqK3v6z25uKESHBJ4IiWRAPG4KCr4TOtKKz0Paotk
         hXRkwdaLtjGvhpXs/dxfaLXH8qdLkFhIuJW0m7RgiqecugaEiDrJRyAJxy8LjAI9QMCO
         zHxbWhNqBT0SrAyDeyHNwsGSJTrX2qnfWaLjDFnoLhL/XIB9Bzn4EXbvPB4WLB5BNKuV
         yR3Tn4p5mnYYPIgZ4h/ghOm+VEyGEImvK3/QfXMgsQhRfcxM7W3aXRCfKLEPJgtFNqQG
         XV5fCes/tEIW7XYXon/GLuJGTjNYYpOS7JivcuM/q86Ynt6wPc3xu3M2RJczNfiFLGgZ
         IXQQ==
X-Gm-Message-State: APjAAAW4sxwpKwPprLUJDJ2KxrUXlGQiyHRpYq33C4fPlWK5TuZPGmTs
        6KVl/h64ENMsNJAFxscd1xyXjg==
X-Google-Smtp-Source: APXvYqzq3+VyalxIHX6NiM6GDIL0tdfQ+7sIZImrTAuZH3u1Q2JxFvq+m39e4cxPpzJuzOkZJhTaZg==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr25804900plo.266.1561248030089;
        Sat, 22 Jun 2019 17:00:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 85sm6689598pgb.52.2019.06.22.17.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:00:29 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:00:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V34 17/29] Prohibit PCMCIA CIS storage when the kernel is
 locked down
Message-ID: <201906221700.51ABA736@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-18-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-18-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:46PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Prohibit replacement of the PCMCIA Card Information Structure when the
> kernel is locked down.
> 
> Suggested-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  drivers/pcmcia/cistpl.c      | 5 +++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
> index ac0672b8dfca..379c53610102 100644
> --- a/drivers/pcmcia/cistpl.c
> +++ b/drivers/pcmcia/cistpl.c
> @@ -24,6 +24,7 @@
>  #include <linux/pci.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> +#include <linux/security.h>
>  #include <asm/byteorder.h>
>  #include <asm/unaligned.h>
>  
> @@ -1578,6 +1579,10 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
>  	struct pcmcia_socket *s;
>  	int error;
>  
> +	error = security_locked_down(LOCKDOWN_PCMCIA_CIS);
> +	if (error)
> +		return error;
> +
>  	s = to_socket(container_of(kobj, struct device, kobj));
>  
>  	if (off)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cc2b5ee4cadd..03c125b277ca 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -90,6 +90,7 @@ enum lockdown_reason {
>  	LOCKDOWN_IOPORT,
>  	LOCKDOWN_MSR,
>  	LOCKDOWN_ACPI_TABLES,
> +	LOCKDOWN_PCMCIA_CIS,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 1725224f0024..7be3e8fb5847 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -26,6 +26,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_IOPORT] = "raw io port access",
>  	[LOCKDOWN_MSR] = "raw MSR access",
>  	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
> +	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
