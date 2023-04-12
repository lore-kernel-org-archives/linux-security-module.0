Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D307C7619A
	for <linux-security-module@archiver.kernel.org>; Wed, 12 Apr 2023 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjDLSYk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLSYj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 12 Apr 2023 14:24:39 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60F6E65
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 11:24:38 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517bfc0119dso611244a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 12 Apr 2023 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681323878; x=1683915878;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=twvA5hfpOp6xtSv34s4W17pWwb8SiU+eK1gg2pCTrU4=;
        b=TdnyrNivmvZnmk+BtjlTnH4B+XWEloSSbfRrCL00GoNhOExwJR1V+oRHhEUmClIbG+
         npuN23sueFZh8YVv4+4CrnlOB1g6bnb4qEy82rO8TNjIMLofYnVxxiFrN2Yoybgh8+CG
         doLIZ+bfmwagRHS5of9OzTccLBP+NEOWUIuto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681323878; x=1683915878;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twvA5hfpOp6xtSv34s4W17pWwb8SiU+eK1gg2pCTrU4=;
        b=F9yanHuJ/sq68TqP753zNiS7yiGiXtDH5KKi3+yoSYegVggqWGzt6p6urbmvmG45d4
         ydz/CwrvWNXokQiBAJaWOf0lQ/vDRIozbt8pX8vxgY/iKKKTQQm6L+bZA1vpeL+DFChj
         Pw7W6lpcPX395VvP9kIMigivyQ2MUQOwEWPVrB5bnvluKx+s2S08kxpHhOYGhb0O0oWa
         0T/5ziqsNNlZGsXVcDh2KQX4wf/Yv7YHGcOON5MGqB5eEKrP8guGcmK+o+DOo391m/2M
         Y/y0Ij/v7Rg6yqp0yQXOA1m4j2nGPXk2dn8J6pp9ZqIp/TAwh0/u5/K+qk2PS/FaZkO+
         turA==
X-Gm-Message-State: AAQBX9fN8NQ+QnBUIaNPDh3trU/PXubQhsRUKJta5slgINbuSba3+CaU
        RgtZ9nq7mLbDmmjxrumtQD6byw==
X-Google-Smtp-Source: AKy350aDkKeBLxBImYkD4qYDxoK/yC60VBJYFjcSOtkpHmW1tdLb3bAHkzODPu9CS3obT8xq7cjeOA==
X-Received: by 2002:aa7:843a:0:b0:63a:e959:1499 with SMTP id q26-20020aa7843a000000b0063ae9591499mr8478501pfn.20.1681323878353;
        Wed, 12 Apr 2023 11:24:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n4-20020aa78a44000000b006338e0a9728sm8361316pfa.109.2023.04.12.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:24:37 -0700 (PDT)
Message-ID: <6436f765.a70a0220.1091d.f714@mx.google.com>
X-Google-Original-Message-ID: <202304121124.@keescook>
Date:   Wed, 12 Apr 2023 11:24:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 6/8] bpf: drop unnecessary bpf_capable() check
 in BPF_MAP_FREEZE command
References: <20230412043300.360803-1-andrii@kernel.org>
 <20230412043300.360803-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412043300.360803-7-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 11, 2023 at 09:32:58PM -0700, Andrii Nakryiko wrote:
> Seems like that extra bpf_capable() check in BPF_MAP_FREEZE handler was
> unintentionally left when we switched to a model that all BPF map
> operations should be allowed regardless of CAP_BPF (or any other
> capabilities), as long as process got BPF map FD somehow.
> 
> This patch replaces bpf_capable() check in BPF_MAP_FREEZE handler with
> writeable access check, given conceptually freezing the map is modifying
> it: map becomes unmodifiable for subsequent updates.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Is this patch stand-alone? It seems like this could be taken separately,
or at least just be the first patch in the series?

> ---
>  kernel/bpf/syscall.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d1165814efc..42d8473237ab 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2001,6 +2001,11 @@ static int map_freeze(const union bpf_attr *attr)
>  		return -ENOTSUPP;
>  	}
>  
> +	if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
> +		err = -EPERM;
> +		goto err_put;
> +	}
> +
>  	mutex_lock(&map->freeze_mutex);
>  	if (bpf_map_write_active(map)) {
>  		err = -EBUSY;
> @@ -2010,10 +2015,6 @@ static int map_freeze(const union bpf_attr *attr)
>  		err = -EBUSY;
>  		goto err_put;
>  	}
> -	if (!bpf_capable()) {
> -		err = -EPERM;
> -		goto err_put;
> -	}
>  
>  	WRITE_ONCE(map->frozen, true);
>  err_put:
> -- 
> 2.34.1
> 

-- 
Kees Cook
