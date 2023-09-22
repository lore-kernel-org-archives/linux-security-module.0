Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4541E6FE58
	for <linux-security-module@archiver.kernel.org>; Fri, 22 Sep 2023 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjIVPv7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjIVPv6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Sep 2023 11:51:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43FB122
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68fdd6011f2so1828710b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695397912; x=1696002712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqnxkpKJKlEpllzMkrnHGTt/nqwg6fkqhahwNJHv70Q=;
        b=NmaglbzKlKRvdnWDNaum8H2mBBo1sqAjoevN9c27gzcrsK1B+GAOIXUI0PcS+WsLRK
         H+pjeOj9ThtQFuZZnH7PJwYS046jhsau9cycS9oDqvuXXZ+wIunzsVLSqUcYAe6uexsk
         nzXY3q8mY2qbinYoyeYxn0N4r8qlCKD9ffh5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397912; x=1696002712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqnxkpKJKlEpllzMkrnHGTt/nqwg6fkqhahwNJHv70Q=;
        b=mF1AIG7K4nTztC19O24wp9Ru2iuQB+PoDL3Z4kvSkm2ygp4R4AwFQ96qraHgVaGODZ
         zi95D3t7hbWjIUSNet5yqK02XjZ8kN2vcpfB/za16qN+1ojWLH+hLCeMYLZAEDpni3C/
         NpdmTD+DoPWUe6qbogzYuHpx2hz2a0ibnftYHBP98LxDwTHRHqefOkWQx58XcsEpnqqD
         jLy/wTfz5b1G9Us8VrkxhQzagpVrazam0UKKxF/YGnJSggw53PdTVjPppFmQukcTXUmn
         K/ltPTcV2hNz71jsrUvluJMIH/7ft2S3MoTXQpWe6NJLvI/CGqDj/+SxshyRlaVoyCFw
         1hOg==
X-Gm-Message-State: AOJu0Yw+wvQJUmYhgzPzs7cE6dFgMSHwvfW2l2TOvVc+hfv2lHyF+LOQ
        eVQKWMFaIEKs8u6CU47VusJblA==
X-Google-Smtp-Source: AGHT+IHJtMIyEo+IzowjMv7TJVJ01I7kILriFOj/Xf+GG6zskp/zORQGguwTAtk0gU3QPWRAWIy5jw==
X-Received: by 2002:a05:6a20:3ca7:b0:140:6979:295d with SMTP id b39-20020a056a203ca700b001406979295dmr10070985pzj.2.1695397912103;
        Fri, 22 Sep 2023 08:51:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b001bf095dfb79sm3624126plq.235.2023.09.22.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:51:51 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:51:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v4 0/5] Reduce overhead of LSMs with static calls
Message-ID: <202309220851.620EFFCC7C@keescook>
References: <20230922145505.4044003-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922145505.4044003-1-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 22, 2023 at 04:55:00PM +0200, KP Singh wrote:
> # Performance improvement
> 
> With this patch-set some syscalls with lots of LSM hooks in their path
> benefitted at an average of ~3% and I/O and Pipe based system calls benefitting
> the most.
> 
> Here are the results of the relevant Unixbench system benchmarks with BPF LSM
> and SELinux enabled with default policies enabled with and without these
> patches.
> 
> Benchmark                                               Delta(%): (+ is better)
> ===============================================================================
> Execl Throughput                                             +1.9356
> File Write 1024 bufsize 2000 maxblocks                       +6.5953
> Pipe Throughput                                              +9.5499
> Pipe-based Context Switching                                 +3.0209
> Process Creation                                             +2.3246
> Shell Scripts (1 concurrent)                                 +1.4975
> System Call Overhead                                         +2.7815
> System Benchmarks Index Score (Partial Only):                +3.4859
> 
> In the best case, some syscalls like eventfd_create benefitted to about ~10%.
> The full analysis can be viewed at https://kpsingh.ch/lsm-perf

Ship it! ;)

Thanks for continuing to work on this; this is a classic case for
static_call.

-Kees

-- 
Kees Cook
