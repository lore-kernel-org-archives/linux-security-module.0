Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E111E94133
	for <linux-security-module@archiver.kernel.org>; Fri,  6 Oct 2023 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjJFWUO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWUN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Oct 2023 18:20:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E5E4
        for <linux-security-module@vger.kernel.org>; Fri,  6 Oct 2023 15:20:12 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c7373cff01so28803885ad.1
        for <linux-security-module@vger.kernel.org>; Fri, 06 Oct 2023 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696630812; x=1697235612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a45KGJOK0lNMKA48/FSSfQen0gMhbbqMC081n0Yh3GE=;
        b=SZ+LArAHRcE4rFsdyUlszct4kw+wflUStU67dmnffh0j7yL0V+d41Ku7tXU6yKaY0F
         ElhVPjRZEM6jYOOv9wrWsoZy139xcNSiI3D3EcEMNpO5GJblQYDV+rCiA3d0EWfuZVni
         3s0qVwY3137hG6Nao1Ukly8VTnMuKPJ9Tc+mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696630812; x=1697235612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a45KGJOK0lNMKA48/FSSfQen0gMhbbqMC081n0Yh3GE=;
        b=vUOsbNeIcZRz4XzueQ1U9AMOG7eBvqn+TNjLlJzHgsBf4lIdPMfs8Er/f1xqVmFErO
         AY75q8hVh4bCA99cyeii7ASi+2IqsBuhlziDcmhKy6MJNo+LlT6IdakLWRS0s7unmqTC
         dUUW6xb1uNMcU9r9w2exaNrmGgDaZjsNbrKXfA26vUgbJzWHLeWkyS33HvUgHy2cdvXw
         kYcOspRUMkCaZryZ/VNs9C4j/rGExr8cQOgkPeMFudHFmr8oJv5h/rI2JlpLRtptycmr
         JK7RwdLp5ik3uh4612+HxQiZxZy2tXgMUR0jxz8zF72Kceef6hH7oDNA+pQH1jypgyc4
         REbg==
X-Gm-Message-State: AOJu0Yw3xJQdgUsYrXQRbNWAjyEUtscvBwgHu9FCkf/bywoXUWG+SC7W
        QVd+vNOu2paLB15sMeThjUZvMg==
X-Google-Smtp-Source: AGHT+IFkyQFr+Srsd18oIXq0XAKKGbVW+B3IfqxGoZy+QvFuFcl1PQlLow2cebiuz5cTsk8Cr+N6lA==
X-Received: by 2002:a17:903:2290:b0:1c6:2655:625d with SMTP id b16-20020a170903229000b001c62655625dmr8500567plh.15.1696630812284;
        Fri, 06 Oct 2023 15:20:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001c61901ed2esm4391498plg.219.2023.10.06.15.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 15:20:11 -0700 (PDT)
Date:   Fri, 6 Oct 2023 15:20:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
        pabeni@redhat.com
Subject: Re: [PATCH v6 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202310061520.8C935383@keescook>
References: <20231006204701.549230-1-kpsingh@kernel.org>
 <20231006204701.549230-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006204701.549230-6-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Oct 06, 2023 at 10:47:01PM +0200, KP Singh wrote:
> This config influences the nature of the static key that guards the
> static call for LSM hooks.
> 
> When enabled, it indicates that an LSM static call slot is more likely
> to be initialized. When disabled, it optimizes for the case when static
> call slot is more likely to be not initialized.
> 
> When a major LSM like (SELinux, AppArmor, Smack etc) is active on a
> system the system would benefit from enabling the config. However there
> are other cases which would benefit from the config being disabled
> (e.g. a system with a BPF LSM with no hooks enabled by default, or an
> LSM like loadpin / yama). Ultimately, there is no one-size fits all
> solution.
> 
> with CONFIG_SECURITY_HOOK_LIKELY enabled, the inactive /
> uninitialized case is penalized with a direct jmp (still better than
> an indirect jmp):
> 
> function security_file_ioctl:
>    0xffffffff818f0c80 <+0>:	endbr64
>    0xffffffff818f0c84 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0c89 <+9>:	push   %rbp
>    0xffffffff818f0c8a <+10>:	push   %r14
>    0xffffffff818f0c8c <+12>:	push   %rbx
>    0xffffffff818f0c8d <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0c90 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0c92 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0c95 <+21>:	jmp    0xffffffff818f0ca8 <security_file_ioctl+40>
> 
>    jump to skip the inactive BPF LSM hook.
> 
>    0xffffffff818f0c97 <+23>:	mov    %r14,%rdi
>    0xffffffff818f0c9a <+26>:	mov    %ebp,%esi
>    0xffffffff818f0c9c <+28>:	mov    %rbx,%rdx
>    0xffffffff818f0c9f <+31>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0ca4 <+36>:	test   %eax,%eax
>    0xffffffff818f0ca6 <+38>:	jne    0xffffffff818f0cbf <security_file_ioctl+63>
>    0xffffffff818f0ca8 <+40>:	endbr64
>    0xffffffff818f0cac <+44>:	jmp    0xffffffff818f0ccd <security_file_ioctl+77>
> 
>    jump to skip the empty slot.
> 
>    0xffffffff818f0cae <+46>:	mov    %r14,%rdi
>    0xffffffff818f0cb1 <+49>:	mov    %ebp,%esi
>    0xffffffff818f0cb3 <+51>:	mov    %rbx,%rdx
>    0xffffffff818f0cb6 <+54>:	nopl   0x0(%rax,%rax,1)
>   				^^^^^^^^^^^^^^^^^^^^^^^
> 				Empty slot
> 
>    0xffffffff818f0cbb <+59>:	test   %eax,%eax
>    0xffffffff818f0cbd <+61>:	je     0xffffffff818f0ccd <security_file_ioctl+77>
>    0xffffffff818f0cbf <+63>:	endbr64
>    0xffffffff818f0cc3 <+67>:	pop    %rbx
>    0xffffffff818f0cc4 <+68>:	pop    %r14
>    0xffffffff818f0cc6 <+70>:	pop    %rbp
>    0xffffffff818f0cc7 <+71>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0ccd <+77>:	endbr64
>    0xffffffff818f0cd1 <+81>:	xor    %eax,%eax
>    0xffffffff818f0cd3 <+83>:	jmp    0xffffffff818f0cbf <security_file_ioctl+63>
>    0xffffffff818f0cd5 <+85>:	mov    %r14,%rdi
>    0xffffffff818f0cd8 <+88>:	mov    %ebp,%esi
>    0xffffffff818f0cda <+90>:	mov    %rbx,%rdx
>    0xffffffff818f0cdd <+93>:	pop    %rbx
>    0xffffffff818f0cde <+94>:	pop    %r14
>    0xffffffff818f0ce0 <+96>:	pop    %rbp
>    0xffffffff818f0ce1 <+97>:	ret
> 
> When the config is disabled, the case optimizes the scenario above.
> 
> security_file_ioctl:
>    0xffffffff818f0e30 <+0>:	endbr64
>    0xffffffff818f0e34 <+4>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e39 <+9>:	push   %rbp
>    0xffffffff818f0e3a <+10>:	push   %r14
>    0xffffffff818f0e3c <+12>:	push   %rbx
>    0xffffffff818f0e3d <+13>:	mov    %rdx,%rbx
>    0xffffffff818f0e40 <+16>:	mov    %esi,%ebp
>    0xffffffff818f0e42 <+18>:	mov    %rdi,%r14
>    0xffffffff818f0e45 <+21>:	xchg   %ax,%ax
>    0xffffffff818f0e47 <+23>:	xchg   %ax,%ax
> 
>    The static keys in their disabled state do not create jumps leading
>    to faster code.
> 
>    0xffffffff818f0e49 <+25>:	xor    %eax,%eax
>    0xffffffff818f0e4b <+27>:	xchg   %ax,%ax
>    0xffffffff818f0e4d <+29>:	pop    %rbx
>    0xffffffff818f0e4e <+30>:	pop    %r14
>    0xffffffff818f0e50 <+32>:	pop    %rbp
>    0xffffffff818f0e51 <+33>:	cs jmp 0xffffffff82c00000 <__x86_return_thunk>
>    0xffffffff818f0e57 <+39>:	endbr64
>    0xffffffff818f0e5b <+43>:	mov    %r14,%rdi
>    0xffffffff818f0e5e <+46>:	mov    %ebp,%esi
>    0xffffffff818f0e60 <+48>:	mov    %rbx,%rdx
>    0xffffffff818f0e63 <+51>:	call   0xffffffff8141e3b0 <bpf_lsm_file_ioctl>
>    0xffffffff818f0e68 <+56>:	test   %eax,%eax
>    0xffffffff818f0e6a <+58>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e6c <+60>:	jmp    0xffffffff818f0e47 <security_file_ioctl+23>
>    0xffffffff818f0e6e <+62>:	endbr64
>    0xffffffff818f0e72 <+66>:	mov    %r14,%rdi
>    0xffffffff818f0e75 <+69>:	mov    %ebp,%esi
>    0xffffffff818f0e77 <+71>:	mov    %rbx,%rdx
>    0xffffffff818f0e7a <+74>:	nopl   0x0(%rax,%rax,1)
>    0xffffffff818f0e7f <+79>:	test   %eax,%eax
>    0xffffffff818f0e81 <+81>:	jne    0xffffffff818f0e4d <security_file_ioctl+29>
>    0xffffffff818f0e83 <+83>:	jmp    0xffffffff818f0e49 <security_file_ioctl+25>
>    0xffffffff818f0e85 <+85>:	endbr64
>    0xffffffff818f0e89 <+89>:	mov    %r14,%rdi
>    0xffffffff818f0e8c <+92>:	mov    %ebp,%esi
>    0xffffffff818f0e8e <+94>:	mov    %rbx,%rdx
>    0xffffffff818f0e91 <+97>:	pop    %rbx
>    0xffffffff818f0e92 <+98>:	pop    %r14
>    0xffffffff818f0e94 <+100>:	pop    %rbp
>    0xffffffff818f0e95 <+101>:	ret
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
