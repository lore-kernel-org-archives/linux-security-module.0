Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D24C7619A
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 17:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDLRtp (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDLRtp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 13:49:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E83DEB
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 10:49:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ke16so12118721plb.6
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681321783; x=1683913783;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lUGsDupBV1YJ/OfuxJFTPlDZaaZhavzoiaTK4d7U3bE=;
        b=Yoksl5MZ+2bIpAoy//dz8luMlPj1b+oQhjR9JMot9kvsN/nWX5em4BRAHdnDjDmoNA
         m1r+txwakCJ4TaavOy6j0EWLu4i1xplXs0CufVFbjst+02yP7oio8OBOP17WqCPlAN/w
         cGWOJRcV2f2V708og8yTRfgz5QgtuaD9J7t+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321783; x=1683913783;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUGsDupBV1YJ/OfuxJFTPlDZaaZhavzoiaTK4d7U3bE=;
        b=Dam0Fk6FrpNrJe8ji3Tu133+VLaVw0lpGdgKViUZReCO55w8sDfjBjdEl8Pstq7kk6
         0s0/672xpGsaJC9nfb38/67LhH0Q3g3YMuYtIPOG+gq1Sf80aScfWPFpJAkaS3ZEkVHw
         gEwccn8Uoovg1+jBcVOoQAQtcvVJbs4nI4GIFIAvVOa9bZYNvGy4AW2ATWNzAnq1gHo6
         A3ErMDjV0qgS+yq6GpfeWxhsu1cH1933Ne9Hcxv8TyLN/+X0RLhgDQP1Qkf138eH50rN
         JUIRjqplEnwU/zVRsQmD2zFNU0X6isnD6jqJPUkvUPrzwC8Hi/eDZg1sValhfyWjjq+P
         qkIQ==
X-Gm-Message-State: AAQBX9dUxUtZ9nHlQUkmZV1RgOdzdHOy0tMdIQ0DAQxC1Wr8LVk8F761
        DlKB8og94hqUs2jjNx3yATP+XA==
X-Google-Smtp-Source: AKy350YRl/0DVD4mybQV4JC2Ljdl1oquWLp6eoj3iZLJ8jTSCn1mL4nHHgdFeW387lVD9vl0y6PJ+A==
X-Received: by 2002:a17:903:22d1:b0:1a6:386f:39a3 with SMTP id y17-20020a17090322d100b001a6386f39a3mr16692527plg.31.1681321783478;
        Wed, 12 Apr 2023 10:49:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b001a66e6bb66esm1693168plb.162.2023.04.12.10.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:49:43 -0700 (PDT)
Message-ID: <6436ef37.170a0220.d660b.33fe@mx.google.com>
X-Google-Original-Message-ID: <202304121047.@keescook>
Date:   Wed, 12 Apr 2023 10:49:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/8] bpf: move unprivileged checks into
 map_create() and bpf_prog_load()
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-2-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 11, 2023 at 09:32:53PM -0700, Andrii Nakryiko wrote:
> Make each bpf() syscall command a bit more self-contained, making it
> easier to further enhance it. We move sysctl_unprivileged_bpf_disabled
> handling down to map_create() and bpf_prog_load(), two special commands
> in this regard.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/syscall.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6d575505f89c..c1d268025985 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1130,6 +1130,17 @@ static int map_create(union bpf_attr *attr)
>  	int f_flags;
>  	int err;
>  
> +	/* Intent here is for unprivileged_bpf_disabled to block key object
> +	 * creation commands for unprivileged users; other actions depend
> +	 * of fd availability and access to bpffs, so are dependent on
> +	 * object creation success.  Capabilities are later verified for
> +	 * operations such as load and map create, so even with unprivileged
> +	 * BPF disabled, capability checks are still carried out for these
> +	 * and other operations.
> +	 */
> +	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> +		return -EPERM;

This appears to be a problem in the original code, but capability checks
should be last, so that audit doesn't see a capability as having been
used when it wasn't. i.e. if bpf_capable() passes, but
sysctl_unprivileged_bpf_disabled isn't true, it'll look like a
capability got used, and the flag gets set. Not a big deal at the end of
the day, but the preferred ordering should be:

	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
		...

> +
>  	err = CHECK_ATTR(BPF_MAP_CREATE);
>  	if (err)
>  		return -EINVAL;
> @@ -2512,6 +2523,17 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	char license[128];
>  	bool is_gpl;
>  
> +	/* Intent here is for unprivileged_bpf_disabled to block key object
> +	 * creation commands for unprivileged users; other actions depend
> +	 * of fd availability and access to bpffs, so are dependent on
> +	 * object creation success.  Capabilities are later verified for
> +	 * operations such as load and map create, so even with unprivileged
> +	 * BPF disabled, capability checks are still carried out for these
> +	 * and other operations.
> +	 */
> +	if (!bpf_capable() && sysctl_unprivileged_bpf_disabled)
> +		return -EPERM;
> +
>  	if (CHECK_ATTR(BPF_PROG_LOAD))
>  		return -EINVAL;
>  
> @@ -5008,23 +5030,8 @@ static int bpf_prog_bind_map(union bpf_attr *attr)
>  static int __sys_bpf(int cmd, bpfptr_t uattr, unsigned int size)
>  {
>  	union bpf_attr attr;
> -	bool capable;
>  	int err;
>  
> -	capable = bpf_capable() || !sysctl_unprivileged_bpf_disabled;
> -
> -	/* Intent here is for unprivileged_bpf_disabled to block key object
> -	 * creation commands for unprivileged users; other actions depend
> -	 * of fd availability and access to bpffs, so are dependent on
> -	 * object creation success.  Capabilities are later verified for
> -	 * operations such as load and map create, so even with unprivileged
> -	 * BPF disabled, capability checks are still carried out for these
> -	 * and other operations.
> -	 */
> -	if (!capable &&
> -	    (cmd == BPF_MAP_CREATE || cmd == BPF_PROG_LOAD))
> -		return -EPERM;
> -
>  	err = bpf_check_uarg_tail_zero(uattr, sizeof(attr), size);
>  	if (err)
>  		return err;
> -- 
> 2.34.1
> 

-- 
Kees Cook
