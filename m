Return-Path: <SRS0=spL8=4W=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDBC3F2D1
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C053208CD
	for <linux-security-module@archiver.kernel.org>; Thu,  5 Mar 2020 17:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B7ByMAXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCERnh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:43:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44222 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCERng (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 5 Mar 2020 12:43:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id n7so8046150wrt.11
        for <linux-security-module@vger.kernel.org>; Thu, 05 Mar 2020 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bHAy6+6uVDKeAvvnXhbkpLjB9BJYv+SeoKQESBQgb5A=;
        b=B7ByMAXR5naWc1+YE2RUrPsLSK32XIdadhkGFNwpvWzfffhIEjyiJWifTv9SKmv2bO
         n6BsQ128MM+4tDd6R+anpfCUKI51CQNcGsIvj3p8zlFWuNrhBJ1v8KHRYadbIalTqT3o
         pSjWXL9ZcF3jRR+fpXN7Kbt9KAIy/VkoiKneU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bHAy6+6uVDKeAvvnXhbkpLjB9BJYv+SeoKQESBQgb5A=;
        b=A/bOCM07WqIXTPBRLRbVX0OR3FyrDMDE4EzPaO62PbKdodbiEbBqiA/POug1osSrYV
         JaMxuM8L8zyL6+gZl3DrHwRZwNIjHYi1Aam0BsxwlgyvTzTwZthHls/x/JjWAozEOIxO
         SWD9GzsJRw9hiZVdzWlMepdIrPJzD0KlrbKXvGKVnxvlyXsx3/K9yFrfyAMuGbnlexmc
         Vq6dgLjlkV0pzpZ7ZLmudvRWEXhwo/h7A9DyUh/mLt+j0h3DAV4O3VLX0mfqgQABXETk
         m2L8fTljKyGg6TPuG7V+uAtp8lKf5s7hXoN+zaFb2B5nytzcrby0F+zJ6dKG6wRUINaR
         q+AQ==
X-Gm-Message-State: ANhLgQ1B2ayaN4/ZHnKDGWd04L/JQHGYzcn2DpvhCkV2FpvuPZPItGCm
        eKvagbjD/QUZyJOr+X91iwMwGQ==
X-Google-Smtp-Source: ADFU+vuBaQeq7T+aAwt7sz91tfVB0ZAv9LkjOxPLyX/Y+ANhz2j+FsQMTsQ8cYSfkzQK1svpOp3/Tg==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr44839wro.219.1583430214477;
        Thu, 05 Mar 2020 09:43:34 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id k66sm7470957wmf.0.2020.03.05.09.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:43:33 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 5 Mar 2020 18:43:32 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v4 0/7] Introduce BPF_MODIFY_RET tracing progs
Message-ID: <20200305174332.GA167686@google.com>
References: <20200304191853.1529-1-kpsingh@chromium.org>
 <20200304221729.d6omw6tltqhbw5xr@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304221729.d6omw6tltqhbw5xr@ast-mbp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 04-Mar 14:17, Alexei Starovoitov wrote:
> On Wed, Mar 04, 2020 at 08:18:46PM +0100, KP Singh wrote:
> > 
> > Here is an example of how a fmod_ret program behaves:
> > 
> > int func_to_be_attached(int a, int b)
> V> {  <--- do_fentry
> > 
> > do_fmod_ret:
> >    <update ret by calling fmod_ret>
> >    if (ret != 0)
> >         goto do_fexit;
> > 
> > original_function:
> > 
> >     <side_effects_happen_here>
> > 
> > }  <--- do_fexit
> > 
> > ALLOW_ERROR_INJECTION(func_to_be_attached, ERRNO)
> > 
> > The fmod_ret program attached to this function can be defined as:
> > 
> > SEC("fmod_ret/func_to_be_attached")
> > int BPF_PROG(func_name, int a, int b, int ret)
> > {
> >         // This will skip the original function logic.
> >         return -1;
> > }
> 
> Applied to bpf-next. Thanks.

Thanks.

> 
> I think it sets up a great base to parallelize further work.

Totally Agreed!

> 
> 1. I'm rebasing my sleepable BPF patches on top.
> It's necessary to read enviroment variables without the
> 'opportunistic copy before hand' hack I saw in your github tree

:) Sleepable BPF would indeed make it much simpler.

> to do bpf_get_env_var() helper.
> 
> 2. please continue on LSM_HOOK patches to go via security tree.
> 
> 3. we need a volunteer to generalize bpf_sk_storage to task and inode structs.

This is quite important, especially for some of the examples we had
brought up.

I can take a look at the generalization of bpf_sk_storage.

Thanks!
- KP

> This work will be super useful for all bpf tracing too.
> Sleepable progs are useful for tracing as well.
