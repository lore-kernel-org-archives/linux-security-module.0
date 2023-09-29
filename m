Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DCE743D0
	for <linux-security-module@archiver.kernel.org>; Fri, 29 Sep 2023 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjI2AiF (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2AiF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 Sep 2023 20:38:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3B180
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:38:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c61bde0b4bso79043355ad.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Sep 2023 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695947882; x=1696552682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LZU5nl5sl1ZJksHpJ5pIG92drxuDqyyvT2504X7TLE=;
        b=R50k1wUl61xONIitUNeDifFK3RmGjZfWNo86sqrYn60DEEVPf6mIMUhpnyw/SUqcs4
         EnDGE/O5I2xr/ZUWFlNTLnCe4J41EANJCiiFE56fBNNCEvrmZrOkozepN69QFTbH5GCa
         EUK+OtmVqxWJUhXTtPFeEkVfX/Jp7HwxsFFgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947882; x=1696552682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LZU5nl5sl1ZJksHpJ5pIG92drxuDqyyvT2504X7TLE=;
        b=GzE20YzNhjLebnsNQM1O83gKYnyLLROcmyZRRPDTUR6yJ+h5IPMYYnLEJ99Kv29N9Z
         QGhVgb9BTB24KDbY7Ti7rLbRZGAJ0bNepyR0ZDX9VKPqpiKMWYGEEuTkDhjLkAB7w93r
         VLKxvb0FST1vpUJIUsHH5DbKPnUNMnWaakcUF3qiS7JqGypkED9CBr3BH7T/7fMXOwTt
         org/f+hLJSrkKINej4p3jMxlpLcOaPX1t+ndp7qSqJaZLoAX9HwE1OqlOrhEAjqqc593
         2Rmmw6yd7TZdNDivLOhRXAs1+zj+Vp3idIO+2CjvoYQrmNTLj4L1UBInmox2GBLa2BwF
         WVxw==
X-Gm-Message-State: AOJu0YyOovMBGNIPl0mUyZMn0QUdrI5GfZv4cCJbr25jDCpTi1WiNs4I
        48r558KUDQIFiuy/2+XWNu334g==
X-Google-Smtp-Source: AGHT+IEwCrIqcsSEcRnWIMAZh9FVrZxVVazFkppuC+LQaVB77U9SKYsLiYuSgZOXD2WVKC5mUO17tA==
X-Received: by 2002:a17:903:181:b0:1c2:218c:3754 with SMTP id z1-20020a170903018100b001c2218c3754mr3276291plg.53.1695947882494;
        Thu, 28 Sep 2023 17:38:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902d18100b001b8b1f6619asm15754861plb.75.2023.09.28.17.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:38:02 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:38:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        paul@paul-moore.com, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, renauld@google.com
Subject: Re: [PATCH v5 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202309281737.03A25A9@keescook>
References: <20230928202410.3765062-1-kpsingh@kernel.org>
 <20230928202410.3765062-6-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928202410.3765062-6-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 10:24:10PM +0200, KP Singh wrote:
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

This looks excellent, and gives us the right balance automatically. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
