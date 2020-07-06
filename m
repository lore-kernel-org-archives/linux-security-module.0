Return-Path: <SRS0=KC/c=AR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA3BC433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 20:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE4B4206B6
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Jul 2020 20:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD+dZMWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGFUGo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFUGo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Jul 2020 16:06:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63FAC061755;
        Mon,  6 Jul 2020 13:06:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so43378373wml.3;
        Mon, 06 Jul 2020 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGGmqyzxuGskSDvJyw873qW0Q+lOOBiCQeQelByiYkA=;
        b=bD+dZMWyuei2FnxFA1Q6IkE8CDRLznPd/I0WivrCOr7VySxWITV42YRooGVzhC0IRs
         WSrOPBbgJS6WAcw0jaJMS23boj9E+7bJMR0/PTw+1+0yrGpXN9IhEYu5c8OnmxgWVrVg
         OOxgTfrpRTYGdm//2kkqObFIMzLjM1MrJg4d76L1bQ3shHDa68ZALmSF2HdjWGud5S0W
         Tb+ZLh8pBAl0nFmie7XpdUCp0Kbb3UT89NbT4xAqC3usY01ahmLFfI3Aqbwli/S6Mrdq
         akev28RdThTdF2RblLHMeMiEyxUs9UcW/Sve2ctBalMIA01vW22j0RKgOrswWKpaa5v7
         o6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sGGmqyzxuGskSDvJyw873qW0Q+lOOBiCQeQelByiYkA=;
        b=DzlZ1EZns/90CuwDhR1dTqpEcRCauR5YJYUChIsMw6tLiP+ATOVjuJqpuXk4q5yCNq
         umyM/CXp8xSTex6yueViejVFTIDQ1Hke7xhJGlp+XEYGsA1vOSQzZNPn4x1JbyFWS4wu
         m6vBt2RRwUVsU1MoBOP0m+iw2W0hAQiYeGHkV5Fr87wyvmd60iP6x5UGSxz2CNHrUkOj
         4hLdDNAPCdp84B+fBsf5EPVpXLlelJz89+GxevGPgz0vDkmiMYgp6ck9cXeCtjlrMpH8
         hYe/hG//6Snayvxq+NfwD7jRiCl4FrDrkEvBvhGe/+WQfJmMkWnYRG2Vr82sRLbtc5kb
         sHKQ==
X-Gm-Message-State: AOAM530j1labFmD3icZ6d6FFPZPqcUC6STmX1c936jDQXeW/ryglVp0L
        i1MObjX4g0yBAzKrLmC5//c=
X-Google-Smtp-Source: ABdhPJxm3bkgcMSKbfFeKdMYBwulZYFl/cbleEVnFxk7HN83k3M783xqIDl6YRw/CF0fNzxgCH5A5A==
X-Received: by 2002:a1c:9cd0:: with SMTP id f199mr780519wme.94.1594066002080;
        Mon, 06 Jul 2020 13:06:42 -0700 (PDT)
Received: from localhost ([95.236.72.230])
        by smtp.gmail.com with ESMTPSA id k126sm661699wme.17.2020.07.06.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:06:41 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:06:40 +0200
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
Message-ID: <20200706200640.GA234619@gallifrey>
Mail-Followup-To: Lorenzo Fontana <fontanalorenz@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Security Module list <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
References: <20200706165710.GA208695@gallifrey>
 <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
 <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ78HOP8SZ3jU0DnH0b4f8580AuP4fdG5K3xgaHa8VYaZw@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 06, 2020 at 08:59:13PM +0200, KP Singh wrote:
> On Mon, Jul 6, 2020 at 8:51 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> > > This option adds a kernel parameter 'bpf_lsm',
> > > which allows the BPF LSM to be disabled at boot.
> > > The purpose of this option is to allow a single kernel
> > > image to be distributed with the BPF LSM built in,
> > > but not necessarily enabled.
> > >
> > > Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> >
> > Well, this explains what the patch is doing but not *why* you need it exactly.
> > Please explain your concrete use-case for this patch.
> 
> Also, this patch is not really needed as it can already be done with the current
> kernel parameters.
> 
> LSMs can be enabled on the command line
> with the lsm= parameter. So you can just pass lsm="selinux,capabilities" etc
> and not pass "bpf" and it will disable the BPF_LSM.
> 
> - KP
> 
> >
> > Thanks,
> > Daniel

Hi,
Thanks Daniel and KP for looking into this, I really appreciate it!

The *why* I need it is because I need to ship the kernel with BPF LSM
disabled at boot time.

The use case is exactly the same as the one described by KP, however
for a personal preference I prefer to pass specifically bpf_lsm=1 or
bpf_lsm=0 - It's easier to change programmatically in my scripts
with a simple sprintf("bpf_lsm=%d", value). I do the same
with "selinux=1" and "selinux=0" in my systems.
From what I can see by reading the code and testing, the two ways
bot act on 'lsm_info.enabled' defined in 'lsm_hooks.h'.
So it's not just  a personal preference, I just want the same set
of options available to me as I do with selinux.

Thanks a lot,
Lore
