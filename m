Return-Path: <SRS0=cqTL=UW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301AC43613
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99A320673
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oXxHB58C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFWAJD (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:09:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46333 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFWAJD (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:09:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5414759pfy.13
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vWIjWJgohtlUoEwu3+7zUIlhLSIs1C/QTS8o7CJbmYY=;
        b=oXxHB58CnJuSsv8e6M+Hv435kyh+G5amzn9487tXyJ/z1gwAX1/iqax2cRXrSQui/V
         dpewHIy8N9N9V8GZ4/BIe3R/O/iFF2vJq1IUNXXLMEyj5gmBVudu0i12Wp0itb6zp4nC
         roTiUqbSHiLr5TB50VhMJeLam+l0vAsTaPE1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWIjWJgohtlUoEwu3+7zUIlhLSIs1C/QTS8o7CJbmYY=;
        b=Jb7JTNB7GRhtBI2SQUeM+lMdv2Y2JvWfMJtjWrfgEYv/3yRd3+TaYRFLSJwi+AxV5+
         WsNvoc9EdrmQ/Q60xveNsGLuZ9mfW6PIuPcMfOxZLasZenavv0glL4kMXblY7Wzkrbb2
         9HFB4vQl33Povqb25BOj8l/lEUJyWf89Mk75hMtiIyPowloHwOHz5F8pnLVQVJbw6t0k
         pUp4dEMeNp6Jyxxc9otuRO/lAkbbTS5myXirQREzW/gXL2VdqXgZtP9UlZpwU40yXjc+
         4OF1r4Au0iCV6YAnZoL6GfEe9c0196q6yan9LtFGhY/vyC8jqMQ2sfQ5yYTC7iAK+q68
         bqQQ==
X-Gm-Message-State: APjAAAV0w+5SenZqyh2hcd1wDLKvePZVZ8xkSJbBhE0L/x98bA7Cwi0d
        +OvAClFIvrkjHEWAYhSxI3oX/baEzXk=
X-Google-Smtp-Source: APXvYqw9bsgIEBdp2vXwfunv3HziFxADVp4U6vZw+FfIejnJHpPVurAILG6xEwEHAzf+41/aBF+MGQ==
X-Received: by 2002:a17:90a:b883:: with SMTP id o3mr15506972pjr.50.1561248542488;
        Sat, 22 Jun 2019 17:09:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm7096532pff.59.2019.06.22.17.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:09:01 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:09:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH V34 22/29] Lock down tracing and perf kprobes when in
 confidentiality mode
Message-ID: <201906221708.4E617CD@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-23-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-23-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:51PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Disallow the creation of perf and ftrace kprobes when the kernel is
> locked down in confidentiality mode by preventing their registration.
> This prevents kprobes from being used to access kernel memory to steal
> crypto data, but continues to allow the use of kprobes from signed
> modules.
> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: davem@davemloft.net
> Cc: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h     | 1 +
>  kernel/trace/trace_kprobe.c  | 5 +++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3875f6df2ecc..e6e3e2403474 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -96,6 +96,7 @@ enum lockdown_reason {
>  	LOCKDOWN_MMIOTRACE,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
> +	LOCKDOWN_KPROBES,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5d5129b05df7..5a76a0f79d48 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -11,6 +11,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/rculist.h>
>  #include <linux/error-injection.h>
> +#include <linux/security.h>
>  
>  #include "trace_dynevent.h"
>  #include "trace_kprobe_selftest.h"
> @@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
>  {
>  	int i, ret;
>  
> +	ret = security_locked_down(LOCKDOWN_KPROBES);
> +	if (ret)
> +		return ret;
> +
>  	if (trace_probe_is_registered(&tk->tp))
>  		return -EINVAL;
>  
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 4c9b324dfc55..5a08c17f224d 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
> +	[LOCKDOWN_KPROBES] = "use of kprobes",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
