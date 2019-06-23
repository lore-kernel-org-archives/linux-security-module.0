Return-Path: <SRS0=cqTL=UW=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872E4C43613
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524D020673
	for <linux-security-module@archiver.kernel.org>; Sun, 23 Jun 2019 00:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/Hji0SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfFWAJj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 22 Jun 2019 20:09:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44876 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfFWAJj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 22 Jun 2019 20:09:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so5420468pfe.11
        for <linux-security-module@vger.kernel.org>; Sat, 22 Jun 2019 17:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NG7nomNIPwxqmG4LxRLswXls78O7wQ5+xJa/DwxCyKE=;
        b=H/Hji0SYg1fH86DYvsJI7X+8dn5kU6pRmDUpmPkjU13nWthuxcr1seWrhpVyesUTGc
         McVlNxmMiLfLd5s5iZTniqL7krDztr1k0t2qVKQqqG8VkkYi0/ZYxp80p53z9T0s9i+0
         41FhnKUukzsuXpG07A+yrT4id43WUqhW2d1M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG7nomNIPwxqmG4LxRLswXls78O7wQ5+xJa/DwxCyKE=;
        b=Y8Vfp1J9Td0py/FmlLqg/gr7b2+3ooIHVgKAe0KeDXbxqBiV8DHAUOK0XPFU7mKqXF
         B11a7Q7xI+a7y6YxCYxOCOLCoQtuoLoboPqcCMWJxssS/hJJwxrZUiSdLmRInWEwCQkx
         n+PBhsAK42YM2R/z4f+aPtJgQBnfCfk4hoNe3gyw8WdXIqja2vhk9cUrN1syjafEw2tl
         U1j8RYOLDrA5KlF8pCMbITUICya3hhDjGHVDd4qrEmzOp674Bud+O270VTuupdUTQhe0
         Wf3M/6FO2TNxmK+ehU1HT/4rAm+AAzj7YimfhW/5za0T1HVGembP19dqhPzGHGYc0JN1
         a0FA==
X-Gm-Message-State: APjAAAWCDn0hX5Ov8amOiBIsLo0hSkpPfN0//LaAT3s0jGh4t6q5IFNy
        YGjTXPeP1MkS8cBNEdFgiN7OtA==
X-Google-Smtp-Source: APXvYqzfQ41nLARmjJBxC3IkKJB9ycWuosbFzRin+JI6rCXZ5UAltKqk9/1Va+B7GLM4m+2MD6Bkaw==
X-Received: by 2002:a17:90a:372a:: with SMTP id u39mr15770033pjb.2.1561248577993;
        Sat, 22 Jun 2019 17:09:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h62sm11402153pgc.54.2019.06.22.17.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:09:36 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:09:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>, netdev@vger.kernel.org,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH V34 23/29] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
Message-ID: <201906221709.FC3AA888B@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-24-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-24-matthewgarrett@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jun 21, 2019 at 05:03:52PM -0700, Matthew Garrett wrote:
> From: David Howells <dhowells@redhat.com>
> 
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program and kernel memory to be altered without
> restriction. Disable them if the kernel has been locked down in
> confidentiality mode.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: netdev@vger.kernel.org
> cc: Chun-Yi Lee <jlee@suse.com>
> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/linux/security.h     |  1 +
>  kernel/trace/bpf_trace.c     | 20 +++++++++++++++++++-
>  security/lockdown/lockdown.c |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index e6e3e2403474..de0d37b1fe79 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -97,6 +97,7 @@ enum lockdown_reason {
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_KCORE,
>  	LOCKDOWN_KPROBES,
> +	LOCKDOWN_BPF_READ,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
>  
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d64c00afceb5..638f9b00a8df 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -137,6 +137,10 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
>  {
>  	int ret;
>  
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret)
> +		return ret;
> +
>  	ret = probe_kernel_read(dst, unsafe_ptr, size);
>  	if (unlikely(ret < 0))
>  		memset(dst, 0, size);
> @@ -156,6 +160,12 @@ static const struct bpf_func_proto bpf_probe_read_proto = {
>  BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
>  	   u32, size)
>  {
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Ensure we're in user context which is safe for the helper to
>  	 * run. This helper has no business in a kthread.
> @@ -205,7 +215,11 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
>  	int fmt_cnt = 0;
>  	u64 unsafe_addr;
>  	char buf[64];
> -	int i;
> +	int i, ret;
> +
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * bpf_check()->check_func_arg()->check_stack_boundary()
> @@ -534,6 +548,10 @@ BPF_CALL_3(bpf_probe_read_str, void *, dst, u32, size,
>  {
>  	int ret;
>  
> +	ret = security_locked_down(LOCKDOWN_BPF_READ);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * The strncpy_from_unsafe() call will likely not fill the entire
>  	 * buffer, but that's okay in this circumstance as we're probing
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5a08c17f224d..2eea2cc13117 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_KCORE] = "/proc/kcore access",
>  	[LOCKDOWN_KPROBES] = "use of kprobes",
> +	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
