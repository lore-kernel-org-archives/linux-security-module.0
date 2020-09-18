Return-Path: <SRS0=iYml=C3=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB75C43464
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 21:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D29222BB
	for <linux-security-module@archiver.kernel.org>; Fri, 18 Sep 2020 21:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qm/FmtT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIRVfP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 18 Sep 2020 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRVfO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Sep 2020 17:35:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E44C0613CE
        for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2020 14:35:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so3677695pld.0
        for <linux-security-module@vger.kernel.org>; Fri, 18 Sep 2020 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OsXO9Vng0uZ8zdPlCQEPUkvMN685QAvewZuZv3id6Vk=;
        b=Qm/FmtT5Dnyrxf4BCgQpgqbDw7sS/zTtWsVgCPYD/Z8fGcfQ5xbRlGReuouD+SHCd9
         dZJK4vmeSlLB9LbvCFrufdgXKAOEcR0Sj+Z6M4GjiMmOMsAqZazgwvwTj14O7ZQgEo98
         fFyktTytinUg2oHTwmTXsDyGhM3irl/3gs0Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsXO9Vng0uZ8zdPlCQEPUkvMN685QAvewZuZv3id6Vk=;
        b=S2wAkJUgdMOLL86myLLm7rwd2dM4+SngNkzppjdgNcnIv+qz2esT1x9kqCNOrIZvEJ
         TAOOd8h25PsIipqVsv+HfkHETVCPCbFm+kxGDtjIqzdQ1zWNVlwVwjbFERzCStpCCDWD
         ixWQS/NHj1qL1YnC6KtdGaXovHu5VC/7Fl89qeffAPojqMvR1c8bzf302e0xqSWx1Bao
         BAET6NfSaa60m8x9llV/RRCBSZmXNqP8rW08uTyGbwEIXwUqgh9Nfp/Ozu9axO9RGZcq
         09ZK8dQw+iWgjZs8z4SzmGhL1yQwtlAWWnXQL/sc4XF5LP3lBdcQW0S+cZnuF/vL4fZv
         t8Fw==
X-Gm-Message-State: AOAM531LIGwJo84ZxRmlP3AyAp7Z4I0NOB+ZBZbniODuo48lFeuKQ6Zc
        56CG14y5Vh0FMwwV/+OwT71n+w==
X-Google-Smtp-Source: ABdhPJyK4NrndRd3u8+tWx5b+nRCti5n/xaxbJJsCKhy+21AIJjWUWUQo+BNLBjVu3tDwrR5itradw==
X-Received: by 2002:a17:90a:156:: with SMTP id z22mr14965929pje.140.1600464914535;
        Fri, 18 Sep 2020 14:35:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f19sm4097785pfj.25.2020.09.18.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:35:13 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:35:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Wood <john.wood@gmx.com>
Cc:     kernel-hardening@lists.openwall.com, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] security/fbfam: Mitigate a fork brute force
 attack
Message-ID: <202009181433.EAF237C36@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-7-keescook@chromium.org>
 <202009101649.2A0BF95@keescook>
 <20200918152116.GB3229@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918152116.GB3229@ubuntu>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 18, 2020 at 06:02:16PM +0200, John Wood wrote:
> On Thu, Sep 10, 2020 at 04:56:19PM -0700, Kees Cook wrote:
> > On Thu, Sep 10, 2020 at 01:21:07PM -0700, Kees Cook wrote:
> > > +		pr_warn("fbfam: Offending process with PID %d killed\n",
> > > +			p->pid);
> >
> > I'd make this ratelimited (along with Jann's suggestions).
> 
> Sorry, but I don't understand what you mean with "make this ratelimited".
> A clarification would be greatly appreciated.

Ah! Yes, sorry for not being more clear. There are ratelimit helpers for
the pr_*() family of functions, e.g.:

	pr_warn_ratelimited("brute: Offending process with PID...

-- 
Kees Cook
