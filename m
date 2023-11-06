Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD9C4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 05:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKFFB2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 00:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjKFFB2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 00:01:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605E1BC
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 21:01:24 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-777754138bdso265626185a.1
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 21:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246883; x=1699851683; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cR4hwl+Lz6w67yTWB4/IzZPUv5zKIhcSMoE3ZPbpkzY=;
        b=SSdavXQW9z/bqfek1ZIsQRLhu2RIAs6Gb4py4EpLR7v4PgycwW8QsBnsvpuSaXGLsg
         eeIrpsl7IisMCPvS+Df9+QRaWPkf3oOu4tkHBNTWvFCaa5a6KkQUvFNUC7mKZCRjSi8u
         LJibvdPPyf5OE4PjLG9Wp8hGZzmYrBPsRfGSO8goetwo7NlHscdmEPXZ5hOtUwQ66aXa
         nFug9DpEByz3HLXSrpMNqzvEEc3r12XYIBRsYQ+SegBjtFt+G17DGJQzc2s2ixvyngwy
         9ikO/EyfmDq3ORinT21yj+tmpLFquqgt1WKhL3f03Ho4E/Ye78OWjBpDEEEP+wFWwMy5
         riDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246883; x=1699851683;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cR4hwl+Lz6w67yTWB4/IzZPUv5zKIhcSMoE3ZPbpkzY=;
        b=HQbqWph7XdXFhBCcy5pTQ3Npxio7++4U5EZupTue12kBFmubjBIMJkB0ESBSwJYZj6
         jW7VaiSNaMBykKH2DsT+crXeBgkm/g3VaEu+h0np0BOB/jaE2vJt8GRWr+V941jtzwaY
         AkNm4+kZuGibyBbrw3K2H12g/6+jwW250ZfahEebNGyi6KDLAmvUr8RJENxbdjWlsezy
         rloelK8NfV9nzi8Fdow8x1EH9aqu3AS9aiP0HYGzukr2aD5mWLQsWgKQhym7nTn3/dOw
         /54Yc1j+E+qqpUNvxJup2hLF52bsEZVvOJ2zhlJBEcN7ogDPregx4e0LVLSzWtphvxVV
         kjSw==
X-Gm-Message-State: AOJu0YxR3km+kSr7WqoVAaWVfF5HstVjAoveSvEgduSuwG9dgxQ5gMsm
        B716FFB9eDBmXBUyPtP5QtVt
X-Google-Smtp-Source: AGHT+IGmtdOVKOy7ELOiV//ynvLuRr3HWRp2ErE9AdJ8pksk5yqacUh7nr3XUjLtbR/eY1SQNzzENw==
X-Received: by 2002:a05:620a:3728:b0:778:9a8e:575 with SMTP id de40-20020a05620a372800b007789a8e0575mr34746168qkb.25.1699246883546;
        Sun, 05 Nov 2023 21:01:23 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a13c900b007677347e20asm2988963qkl.129.2023.11.05.21.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:23 -0800 (PST)
Date:   Mon, 06 Nov 2023 00:01:22 -0500
Message-ID: <257c16919acd2ec98dac2e6c4f21c906.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 17/17] bpf,selinux: allocate bpf_security_struct per BPF  token
References: <20231103190523.6353-18-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-18-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Utilize newly added bpf_token_create/bpf_token_free LSM hooks to
> allocate struct bpf_security_struct for each BPF token object in
> SELinux. This just follows similar pattern for BPF prog and map.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  security/selinux/hooks.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Thanks Andrii, we'll need some additional code to fully enable the
BPF tokens on a SELinux system but I can help provide that if you'd
like.  Although I might not be able to get to that until after the
merge window closes.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 002351ab67b7..1501e95366a1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6828,6 +6828,29 @@ static void selinux_bpf_prog_free(struct bpf_prog *prog)
>  	prog->aux->security = NULL;
>  	kfree(bpfsec);
>  }
> +
> +static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
> +				    struct path *path)
> +{
> +	struct bpf_security_struct *bpfsec;
> +
> +	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
> +	if (!bpfsec)
> +		return -ENOMEM;
> +
> +	bpfsec->sid = current_sid();
> +	token->security = bpfsec;
> +
> +	return 0;
> +}
> +
> +static void selinux_bpf_token_free(struct bpf_token *token)
> +{
> +	struct bpf_security_struct *bpfsec = token->security;
> +
> +	token->security = NULL;
> +	kfree(bpfsec);
> +}
>  #endif
>  
>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
> @@ -7183,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>  	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
>  	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
> +	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
>  #endif
>  
>  #ifdef CONFIG_PERF_EVENTS
> @@ -7241,6 +7265,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  #ifdef CONFIG_BPF_SYSCALL
>  	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
>  	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
> +	LSM_HOOK_INIT(bpf_token_create, selinux_bpf_token_create),
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> -- 
> 2.34.1

--
paul-moore.com
