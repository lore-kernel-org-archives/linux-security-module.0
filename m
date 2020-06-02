Return-Path: <SRS0=3Oq2=7P=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF6C433E0
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38A12077D
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Jun 2020 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEYw1+Yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBSjq (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBSjp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 14:39:45 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66DDC08C5C1
        for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2020 11:39:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s88so1934172pjb.5
        for <linux-security-module@vger.kernel.org>; Tue, 02 Jun 2020 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RtLS8+a88UB49gCeA48ay61o0FJ7r6NvEDuSLjJ15Ws=;
        b=BEYw1+YtCM8/jNfafOjZEiG/Sn4OmMKzw4L8wqdnZx8Rr7aqoQXrg9cgHYBCJWJRYe
         1g95M9p0Mb2LSzvbYAZt1HJ2esEh3EFk+NBAyMpxt7wq/iMEHjrLPUzcBgjhcshjQbPo
         vButaFp/zKOzl5MT8vC1Lflg8kRVpjxGSEXHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RtLS8+a88UB49gCeA48ay61o0FJ7r6NvEDuSLjJ15Ws=;
        b=akiFDZd+q/IH+tLbD1u5b741+919m/C5asSCOyNcbn+I3reeDYPZezAqwiaE1hMTiU
         f3NYdcZNFA0LwdhsuL7wL8J6tat5xGzuDFvY8ShvEkHtMGRNNw3ewJb45nEB92ds/2jv
         wtJ8DQKgEIAaD5MYOI8Drp/zdUXKVwZLSZpqAtXIuN38Vss+4eQAjWLSbEFGFSL3C+vj
         jn9JA/6XncSISQ5lsAsA41FvF23HF7Z0ZDdROez2Jo84sGtgGy+cNmtAlW12FyCb75qi
         OvYbaBZiAUu6n1JA7vL+ipKxOPNCn0G87ZRzWWb1GGREY7kq3HzMhbPUdgklzpomYCKx
         t0/Q==
X-Gm-Message-State: AOAM533rhNAEDbEFivilfMXP0LMgZDEOdu19r7UeZlGBtmce21MnBynl
        LV3xrCB9qVvJvHHyFlUPu73GCA==
X-Google-Smtp-Source: ABdhPJxeJZrKbRy+KqMNDTnZc8TuNFqju+DN5fMoH6TrGPjUPtP8dDdJjqSOfuUssmzxaUde+9NEbQ==
X-Received: by 2002:a17:90b:3691:: with SMTP id mj17mr518962pjb.152.1591123185308;
        Tue, 02 Jun 2020 11:39:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j17sm3081062pjy.22.2020.06.02.11.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 11:39:44 -0700 (PDT)
Date:   Tue, 2 Jun 2020 11:39:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lennart Poettering <lennart@poettering.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006021138.6E2073803@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
 <20200602125323.GB123838@gardel-login>
 <CAHC9VhShd2GLqei6MSREr_vzeVXNcObdVVgvhj1WP7_Ob2C3ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhShd2GLqei6MSREr_vzeVXNcObdVVgvhj1WP7_Ob2C3ag@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 02, 2020 at 11:03:31AM -0400, Paul Moore wrote:
> Perhaps others will clarify, but from my reading of this thread there
> is a performance advantage to be gained by limiting the number of
> seccomp filters installed for a given process.

Generally speaking, yes, though obviously the size and layout of a single
filter (i.e. is it a balanced tree?) will still impact the overhead.

-- 
Kees Cook
