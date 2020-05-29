Return-Path: <SRS0=ngOM=7L=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B845C433E1
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 16:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B97E207F9
	for <linux-security-module@archiver.kernel.org>; Fri, 29 May 2020 16:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYoiy6jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgE2QJc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 29 May 2020 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2QJb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 29 May 2020 12:09:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA2C08C5C6
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2020 09:09:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so1327982plt.5
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2020 09:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7tFtwZgvZE5hW33XbmmKt8eqRyrQtOfEzKnpZP3Z4fw=;
        b=GYoiy6jTScqVloKoIjwXCzc+l+EG1hBVzc+mtPa5HPhYQ+A9L305gHi07UgwFOnw0T
         dmosi0h18RvyDg3UGAzomXNRW6wIzIZZL3hZWylaxIlGuYfTHyHke0x3akAlw9VyfnG6
         WTl5A0LIqRV7YK4EIxscvhAZaoHgOBRPACxHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7tFtwZgvZE5hW33XbmmKt8eqRyrQtOfEzKnpZP3Z4fw=;
        b=s6B8nUrGck3wWlneFDPcfkF1DwX4bWk635IFy89KnuGh7zRWZJ1rZV0Phrr42Mihbi
         jo0vKVOILEPm/D1lEPPeNPj8/i/P2K+KNjuXN1YrXgWhGuTL2nVF9qApdFZGMUXBhKDf
         yyGD08h/TXA4twConbOB6MPzdA35w0yWsqXjGw3op0kBry0ROBZPJggQ+opb6z6JW/me
         xDj835BclPp7utbWzo96hbA0rjOMoOq9U/MqM9Wgi4VX9khR4sCdlOn2/kMpsBwTbdnJ
         0nNyKxuROp+WgTOcbKhkUh0OCr5rBJGwwxSi8qwSv8J/FCBGMIH+rHO+E7LiKLxpcZNH
         Y7dw==
X-Gm-Message-State: AOAM530alqPB0AQP2BtXR9JkLxkh1IaXCclx2SipXFuDXLdVLxIl5P7m
        NCfeKaMxa62UiDxvwymQ6FDCUA==
X-Google-Smtp-Source: ABdhPJwiF0InviA286xZMds7P6A3F23qpGlkmzD4rF6zE18n7jXKvqQI9cH5t4J0qPX2tBr2hsnccA==
X-Received: by 2002:a17:90a:950b:: with SMTP id t11mr10570641pjo.35.1590768570208;
        Fri, 29 May 2020 09:09:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h3sm1993834pfr.2.2020.05.29.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 09:09:29 -0700 (PDT)
Date:   Fri, 29 May 2020 09:09:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202005290903.11E67AB0FD@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 29, 2020 at 08:43:56AM -0700, Alexei Starovoitov wrote:
> On Fri, May 29, 2020 at 5:50 AM zhujianwei (C) <zhujianwei7@huawei.com> wrote:
> >
> > Hi, all
> >
> > 　　We're using seccomp to increase container security, but bpf rules filter causes performance to deteriorate. So, is there a good solution to improve performance, or can we add a simplified seccomp mode to improve performance?

Yes, there are already plans for a simple syscall bitmap[1] seccomp feature.

> I don't think your hunch at where cpu is spending cycles is correct.
> Could you please do two experiments:
> 1. try trivial seccomp bpf prog that simply returns 'allow'
> 2. replace bpf_prog_run_pin_on_cpu() in seccomp.c with C code
>   that returns 'allow' and make sure it's noinline or in a different C file,
>   so that compiler doesn't optimize the whole seccomp_run_filters() into a nop.
> 
> Then measure performance of both.
> I bet you'll see exactly the same numbers.

Android has already done this, it appeared to not be the same. Calling
into a SECCOMP_RET_ALLOW filter had a surprisingly high cost. I'll see
if I can get you the numbers. I was frankly quite surprised -- I
understood the bulk of the seccomp overhead to be in taking the TIF_WORK
path, copying arguments, etc, but something else is going on there.

-Kees

[1] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/

-- 
Kees Cook
