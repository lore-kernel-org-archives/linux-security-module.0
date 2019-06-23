Return-Path: <SRS0=cqTL=UW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A4DC43613
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E742084E
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WV9AXB4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFWABH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:01:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39167 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFWABH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:01:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so4808214pls.6
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vf/VONB8kWORk0urEjqan+tCHppej7MXR/YXJUsa0HU=;
        b=WV9AXB4HuwG5qKrUjJbnwhh8BSCKPbV5Z0WtpFH8X5nzh2pPb+ZkhbRV/35XoB6SoH
         ZqjbO9lsU0HUrmJivU6eUH5DbGoKNp/N189leaZDPJXtSBb+Xvx73jS0eLV6u/Llki5/
         vz1DCPihVMsK/F8zHKs4lENvWrufgq9tHdIIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vf/VONB8kWORk0urEjqan+tCHppej7MXR/YXJUsa0HU=;
        b=VBGuHJuB9hTv8Vl2qXDtW/kfFHEdZMCrJXVnp0KhPfBgVBhQO145P/a4F18+xiryTh
         GnAPSqlkwJ5DR4jcnI5CI+8P1FPDddqO0iVTgnYTnFU5HANH2BwTdgISfdYnrPjK0N+d
         +9wTmy73YE3+7Viqyth6FIOf+c/vfDCqZpxEnn2L9HQSdZsjqYea864zbZgIFwx2JbJ6
         Svrn+xYIDXHHZDBBkG4AbW2QJd06iDVCv/QKd4TTph3uZWB+X0IJ7nc4eY7Aq75e5SuZ
         8z8nWM96Pt4WAW7YeESM/OtRVI7wXIlkFEpUu9DhNIpTBmi8wIQUVyiQVx1XUYAtd5CX
         Q4Vg==
X-Gm-Message-State: APjAAAVoPJQ9x0uCcmUsnws9e20/cc8wgUgVZvgVxgyc0BfanTWR6dUp
        pCXQAG8cwg+hz0xQjsdxF5X/0g==
X-Google-Smtp-Source: APXvYqy/H1YA0XpscCuzeJn2RleJeh2Z9FiCinQQRpYy6jfHXgSIp/NLTSI12WTjikye2YEYyZ7rXw==
X-Received: by 2002:a17:902:d915:: with SMTP id c21mr73889826plz.335.1561248066891;
        Sat, 22 Jun 2019 17:01:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm6824350pjp.19.2019.06.22.17.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:01:06 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:01:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH V34 18/29] Lock down TIOCSSERIAL
Message-ID: <201906221700.852B22FCE0@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-19-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-19-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:47PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Lock down TIOCSSERIAL as that can be used to change the ioport and irq
> settings on a serial port.  This only appears to be an issue for the serial
> drivers that use the core serial code.  All other drivers seem to either
> ignore attempts to change port/irq or give an error.
> 
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/serial_core.c | 5 +++++
>  include/linux/security.h         | 1 +
>  security/lockdown/lockdown.c     | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 351843f847c0..a84f231a5df4 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -22,6 +22,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/delay.h>
>  #include <linux/mutex.h>
> +#include <linux/security.h>
>  
>  #include <linux/irq.h>
>  #include <linux/uaccess.h>
> @@ -852,6 +853,10 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  	new_flags = (__force upf_t)new_info->flags;
>  	old_custom_divisor = uport->custom_divisor;
>  
> +	retval = security_locked_down(LOCKDOWN_TIOCSSERIAL);
> +	if (retval && (change_port || change_irq))
> +		goto exit;
> +
>  	if (!capable(CAP_SYS_ADMIN)) {
>  		retval = -EPERM;
>  		if (change_irq || change_port ||

This should be moved after the capable test. With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 03c125b277ca..61e3f4a62d16 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -91,6 +91,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MSR,
>  	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_PCMCIA_CIS,
> +	LOCKDOWN_TIOCSSERIAL,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 7be3e8fb5847..c89046dc2155 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -27,6 +27,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MSR] = "raw MSR access",
>  	[LOCKDOWN_ACPI_TABLES] = "modified ACPI tables",
>  	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
> +	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
