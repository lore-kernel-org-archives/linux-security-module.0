Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F9C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 18:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EF7206E2
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 18:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jG+lazoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFBSc2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBSc2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 14:32:28 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD451C08C5C0
        for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2020 11:32:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so5474231pgm.13
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a2mRWMJqisP+4kZOxG0NFiixReTuotfL9/7Ot3cVDIU=;
        b=jG+lazoTiScqyobCNQleaecWfCAYnh0oCzeqs7Fno2ZwIpFnGZyhNnkoZzyMSLOtcD
         86ybSmFKGGw8osdw8+znwL3w233Ds/l1lreu3vSRjmT0j7hTva5NmgWJkLuCEmXUhW6V
         4CnSUkAWCAuAiKW1nA1DKFAXmDvPoN0M/ubs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2mRWMJqisP+4kZOxG0NFiixReTuotfL9/7Ot3cVDIU=;
        b=srPM1BpPWxRdtRoH0I8e9w/QFxTS3FMFvMBrN3NKy82VjuFF6AEwREOHQ/hvgjzXEE
         SeHOzr1kqdRXWiBakWs/Zje4x/q1fLg/Wc51hqwFWoXmndaUgdRM2kZY/FGzGnNRXdcr
         dm5fPvN9mP3KZmbwmera+v2jPEo4ir1coRWF73kISLhjye+F1Eq5EarVV088+dnJgl+I
         etcUyzEjeGEvkOTVVTCJXA3QQT2C3WQsBxYAxM9CdgftSZEOeG91IntwJLVVBIgCdKEd
         139GPpzTYw6UGAVLSPZKzzlRr1BXkcTglIluZCSWa2vNg9YUpI0DICQEe9Rolqawaxzj
         MMEQ==
X-Gm-Message-State: AOAM530CNepQ6haif7lyzgxhm/i7Z6zm0QzhIKPykVX1tS8ThAwk66BF
        ldrmoUs8Tk/7wZyUBQ6hqWoaKQ==
X-Google-Smtp-Source: ABdhPJx05oSiwwveWwJb4PM8N2gPFvjEXHiSzSD6Q/QflCtslWHtpbSHLgtNVEZvcW76Ec51wbGNjg==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr27504998pfh.60.1591122747381;
        Tue, 02 Jun 2020 11:32:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b63sm2917795pfg.86.2020.06.02.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:32:26 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:32:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "zhujianwei (C)" <zhujianwei7@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Lennart Poettering <lennart@poettering.net>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= new seccomp
 mode aims to improve performance
Message-ID: <202006021111.947830EC@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <ff10225b79a14fec9bc383e710d74b2e@huawei.com>
 <CAADnVQK2WEh980KMkXy9TNeDqKA-fDMxkojPYf=b5eJSgG=K0g@mail.gmail.com>
 <7dacac003a9949ea8163fca5125a2cae@huawei.com>
 <20200602032446.7sn2fmzsea2v2wbs@ast-mbp.dhcp.thefacebook.com>
 <07ce4c1273054955a350e67f2dc35812@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ce4c1273054955a350e67f2dc35812@huawei.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 02, 2020 at 11:34:04AM +0000, zhujianwei (C) wrote:
> And in many scenarios, the requirement for syscall filter is usually
> simple, and does not need complex filter rules, for example, just
> configure a syscall black or white list. However, we have noticed that
> seccomp will have a performance overhead that cannot be ignored in this
> simple scenario. For example, referring to Kees's t est data, this cost
> is almost 41/636 = 6.5%, and Alex's data is 17/226 = 7.5%, based on
> single rule of filtering (getpid); Our data for this overhead is 19.8%
> (refer to the previous 'orignal' test results), filtering based on our
> 20 rules (unixbench syscall).

I wonder if aarch64 has higher overhead for calling into the TIF_WORK
trace stuff? (Or if aarch64's BPF JIT is not as efficient as x86?)

> // kernel modification
> --- linux-5.7-rc7_1/arch/arm64/kernel/ptrace.c	2020-05-25 06:32:54.000000000 +0800
> +++ linux-5.7-rc7/arch/arm64/kernel/ptrace.c	2020-06-02 12:35:04.412000000 +0800
> @@ -1827,6 +1827,46 @@
>  	regs->regs[regno] = saved_reg;
>  }
>  
> +#define PID_MAX    1000000
> +#define SYSNUM_MAX 0x220

You can use NR_syscalls here, I think.

> +
> +/* all zero*/
> +bool g_light_filter_switch[PID_MAX] = {0};
> +bool g_light_filter_bitmap[PID_MAX][SYSNUM_MAX] = {0};

These can be static, and I would double-check your allocation size -- I
suspect this is allocating a byte for each bool. I would recommend
DECLARE_BITMAP() and friends.

> +static int __light_syscall_filter(void) {
> +   int pid;
> +	int this_syscall;
> +
> +   pid = current->pid;
> +	this_syscall = syscall_get_nr(current, task_pt_regs(current));
> +
> +   if(g_light_filter_bitmap[pid][this_syscall] == true) {
> +       printk(KERN_ERR "light syscall filter: syscall num %d denied.\n", this_syscall);
> +		goto skip;
> +   }
> +
> +	return 0;
> +skip:	
> +	return -1;
> +}
> +
> +static inline int light_syscall_filter(void) {
> +	if (unlikely(test_thread_flag(TIF_SECCOMP))) {
> +                 return __light_syscall_filter();
> +        }
> +
> +	return 0;
> +}
> +
>  int syscall_trace_enter(struct pt_regs *regs)
>  {
>  	unsigned long flags = READ_ONCE(current_thread_info()->flags);
> @@ -1837,9 +1877,10 @@
>  			return -1;
>  	}
>  
> -	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (secure_computing() == -1)
> +	/* light check for syscall-num-only rule. */
> +	if (light_syscall_filter() == -1) {
>  		return -1;
> +	}
>  
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);

Given that you're still doing this in syscall_trace_enter(), I imagine
it could live in secure_computing().

Anyway, the functionality here is similar to what I've been working
on for bitmaps (having a global preallocated bitmap isn't going to be
upstreamable, but it's good for PoC). The complications are with handling
differing architecture (for compat systems), tracking/choosing between
the various basic SECCOMP_RET_* behaviors, etc.

-Kees

-- 
Kees Cook
