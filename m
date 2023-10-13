Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414E3CDB47E
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Oct 2023 21:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjJMVPs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Oct 2023 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMVPs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Oct 2023 17:15:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7EAC0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Oct 2023 14:15:39 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7bbcc099fso32310897b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 13 Oct 2023 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697231739; x=1697836539; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wYzHXGOUHBWgy4f8CLaqiKrpM1b0/h0Z9hKcRAULFAg=;
        b=ONoscX7yPlZH1JpmU+8ZtZplBrXzpsAJfXkImr65WnXsrtqXYsLcO80NXADu8ff7zZ
         h+RS6RPcLGvPQNpMHnjoGAZc6zI1yOToANR3YnfgAZ82adYDgoIq8C1YC1e23IAPLFIB
         gPudwhGML7QLHR6bFJvWAo2++A7327LARO9m8L6JRF40iLheZ4jjasCYVfmjsAvcYVzG
         G8TVq3CJUVMNJcTFZhDLrMqggeuISTWb1HYmf7OIoDr8RnSKeH91m6DdcKuex5F9e256
         4QrWc9fXcN+xAkyDlFcxlmw/yFXfUxv4Um5F5OUaHvPqzyOTrHkQnO4d+amh/6wPWrEj
         ZxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231739; x=1697836539;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYzHXGOUHBWgy4f8CLaqiKrpM1b0/h0Z9hKcRAULFAg=;
        b=RIVCVNslK7M6acYtITxC+Q6x+cdNITk0nc7nKSXe6BHEsaqkYQ1Xfv32G5p5+wXOQH
         sbDmlnI8aS2ygbxgab0sP8iVr82CwgyzsLZsDYSYVlgKRtIhhofCLOQ/rkXBRkTG61yp
         WZHGvBP5QfJ3xvJMrRYq1Y4cmpKCCGvUD+amltKA/QErf0OvBxFtiEMZtYEi/qN6IiE9
         Qx8s6F9xuGLPdG0dX5QQeQp6sEiS0bSsU0/B4D5dDokv6Zun3S8P9KSbyz05mm8dXHve
         YLA51InduzQ9YD5WeYn4w1sA/Ymju3m4casbJWsrcGhbKJRR3aQG6CcY4k7Dz+tjp85U
         z3XQ==
X-Gm-Message-State: AOJu0Yzlrj6g3XwJ8tfnBaJPSNsrJaCtN4a9TtQZiKdS0MQNNC8HgpUo
        wmhg1pQrL9l4X6PRvKsu9+cM
X-Google-Smtp-Source: AGHT+IHFl8cQ1roo+h5Gs3S6OL6iA0G1c4x7pX1/CR0n3hXIRGlEPeKHSqa27ohzG+vd+gNQKcLJiA==
X-Received: by 2002:a0d:df11:0:b0:5a7:b81a:7f5d with SMTP id i17-20020a0ddf11000000b005a7b81a7f5dmr14483089ywe.18.1697231738729;
        Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id eu2-20020ad44f42000000b0066cfbe4e0f4sm971106qvb.26.2023.10.13.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 14:15:38 -0700 (PDT)
Date:   Fri, 13 Oct 2023 17:15:38 -0400
Message-ID: <91ed4874a98b620dfa2bd6fe2966f8a7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v7 11/18] bpf,lsm: add bpf_token_create and bpf_token_free  LSM hooks
References: <20231012222810.4120312-12-andrii@kernel.org>
In-Reply-To: <20231012222810.4120312-12-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Oct 12, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> allocate LSM security blob (we add `void *security` field to struct
> bpf_token for that), but also control who can instantiate BPF token.
> This follows existing pattern for BPF map and BPF prog.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h           |  3 +++
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 11 +++++++++++
>  kernel/bpf/bpf_lsm.c          |  2 ++
>  kernel/bpf/token.c            |  6 ++++++
>  security/security.c           | 28 ++++++++++++++++++++++++++++
>  6 files changed, 53 insertions(+)

...

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> index d4e0cc8075d3..18fd1e04f92d 100644
> --- a/kernel/bpf/token.c
> +++ b/kernel/bpf/token.c
> @@ -7,6 +7,7 @@
>  #include <linux/idr.h>
>  #include <linux/namei.h>
>  #include <linux/user_namespace.h>
> +#include <linux/security.h>
>  
>  bool bpf_token_capable(const struct bpf_token *token, int cap)
>  {
> @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
>  
>  static void bpf_token_free(struct bpf_token *token)
>  {
> +	security_bpf_token_free(token);
>  	put_user_ns(token->userns);
>  	kvfree(token);
>  }
> @@ -183,6 +185,10 @@ int bpf_token_create(union bpf_attr *attr)
>  	token->allowed_progs = mnt_opts->delegate_progs;
>  	token->allowed_attachs = mnt_opts->delegate_attachs;
>  
> +	err = security_bpf_token_create(token, attr, &path);
> +	if (err)
> +		goto out_token;
> +
>  	fd = get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0) {
>  		err = fd;

As long as bpf_token_alloc() remains separate from bpf_token_create()
I'm not comfortable not having a security_bpf_token_alloc() hook in
bpf_token_alloc().  If you really don't want a LSM token alloc hook
can you fold bpf_token_alloc() into bpf_token_create()?

--
paul-moore.com
