Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F8C4332F
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 05:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjKFFB0 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 00:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFFBZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 00:01:25 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C991ADB
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 21:01:21 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d11fec9a5so22614156d6.1
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 21:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246881; x=1699851681; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=je4RrCBnaPDZma+LQbI7lYeKbBZd/hlyMFpI14/dzZw=;
        b=ZI/2Wj/BbtzrlWZAtg6sTSnd4qlCae67Aa0dwgT4D+vAy+gIKRHjkYAlUiVrmG+Bmd
         ZYmvAxEXf0XFr5MHzA4XQdw8+bMdqAte/NlMxJND/XXJ5rm7ozA3rIQGWX/LErxxkLjs
         EZs6pqryZupzQQLdhPIxJfD4ooLhkRNKhCCENWUbhGyE0XbYw1XH7+LMrSliSnA5tZg5
         vtdVhM5Az7h3tEFII+Pz5JErapHHz5+9Uz44wzqg4LqbxpONn0tPEis0LbYwqLlMEPiq
         IMbnEeAPKFQUXLQLnYwLS/Yni++1/bqQGlfEDnc9LHVSmiN6Vg9rpLlA+OYv6P+hCBGy
         +yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246881; x=1699851681;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=je4RrCBnaPDZma+LQbI7lYeKbBZd/hlyMFpI14/dzZw=;
        b=kfn6oKM/ly/72anWmgUD/MVbd+9GjYtduO5TyLQGgr7aV4DJ8s7sV9nJFAjx/gCntg
         oIchxYMIQ9C6a9BEGQIYIEOZCCI9UUeANeTLM/9/UUI1t6D+WYLlvAm01bCd6jBVCcEs
         VvoJqpfbPGAmji+9fU9hC55wIzPnT4VOSLy41dUijb/wYNoE5tj5tEfor1/aFLWOlSqr
         42bBWB+VctZeQ+qmv9wdtknz/PlX/M/VKwXIJlNkkhjnSUMyNRMOrOftrMYojQvOj6VJ
         ekCQvzHfdibpFGkws2YUpPDs/YJRF4k7IgCf9QiBsP5Zp5Nn7nitSVEFEIr0pWh17c8o
         LVag==
X-Gm-Message-State: AOJu0Yx3N7AdlYkRirLECdXxHwEA1/yupKqoXO4vFF6ZaXENdtno/WdI
        8drqGLte0RQ3x4Wvn03tLf1Dt9zAR4096UZfQA==
X-Google-Smtp-Source: AGHT+IEb3ptzoQZtoCEsn5a3d9x4YOVwl6lJKdcIkRv0zs7pCgsbuNwO3+dvv5v/cl+r6OhlXjIqSA==
X-Received: by 2002:ad4:5961:0:b0:66d:19b5:9a9 with SMTP id eq1-20020ad45961000000b0066d19b509a9mr28419071qvb.65.1699246880776;
        Sun, 05 Nov 2023 21:01:20 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f2-20020a0ccc82000000b0066d04196c3dsm3121705qvl.49.2023.11.05.21.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:20 -0800 (PST)
Date:   Mon, 06 Nov 2023 00:01:19 -0500
Message-ID: <7ff273d368f3f7dd383444928ca478ef.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 9/17] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM  hooks
References: <20231103190523.6353-10-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-10-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Based on upstream discussion ([0]), rework existing
> bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and instead
> of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
> program struct. Also, we pass bpf_attr union with all the user-provided
> arguments for BPF_PROG_LOAD command.  This will give LSMs as much
> information as we can basically provide.
> 
> The hook is also BPF token-aware now, and optional bpf_token struct is
> passed as a third argument. bpf_prog_load LSM hook is called after
> a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux were
> allocated and filled out, but right before performing full-fledged BPF
> verification step.
> 
> bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
> consistency. SELinux code is adjusted to all new names, types, and
> signatures.
> 
> Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can be
> used by some LSMs to allocate extra security blob, but also by other
> LSMs to reject BPF program loading, we need to make sure that
> bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc one
> *even* if the hook itself returned error. If we don't do that, we run
> the risk of leaking memory. This seems to be possible today when
> combining SELinux and BPF LSM, as one example, depending on their
> relative ordering.
> 
> Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
> sleepable LSM hooks list, as they are both executed in sleepable
> context. Also drop bpf_prog_load hook from untrusted, as there is no
> issue with refcount or anything else anymore, that originally forced us
> to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certain LSM
> hook arguments as trusted"). We now trigger this hook much later and it
> should not be an issue anymore.

See my comment below, but it isn't clear to me if this means it is okay
to have `BTF_ID(func, bpf_lsm_bpf_prog_free)` called twice.  It probably
would be a good idea to get KP, BPF LSM maintainer, to review this change
as well to make sure this looks good to him.

>   [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++--
>  include/linux/security.h      | 12 +++++++-----
>  kernel/bpf/bpf_lsm.c          |  5 +++--
>  kernel/bpf/syscall.c          | 25 +++++++++++++------------
>  security/security.c           | 25 +++++++++++++++----------
>  security/selinux/hooks.c      | 15 ++++++++-------
>  6 files changed, 49 insertions(+), 38 deletions(-)

...

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index e14c822f8911..3e956f6302f3 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
>  BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
>  BTF_ID(func, bpf_lsm_bpf_map_free_security)
>  BTF_ID(func, bpf_lsm_bpf_prog)
> +BTF_ID(func, bpf_lsm_bpf_prog_load)
> +BTF_ID(func, bpf_lsm_bpf_prog_free)
>  BTF_ID(func, bpf_lsm_bprm_check_security)
>  BTF_ID(func, bpf_lsm_bprm_committed_creds)
>  BTF_ID(func, bpf_lsm_bprm_committing_creds)
> @@ -346,8 +348,7 @@ BTF_SET_END(sleepable_lsm_hooks)
>  
>  BTF_SET_START(untrusted_lsm_hooks)
>  BTF_ID(func, bpf_lsm_bpf_map_free_security)
> -BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
> -BTF_ID(func, bpf_lsm_bpf_prog_free_security)
> +BTF_ID(func, bpf_lsm_bpf_prog_free)
>  BTF_ID(func, bpf_lsm_file_alloc_security)
>  BTF_ID(func, bpf_lsm_file_free_security)
>  #ifdef CONFIG_SECURITY_NETWORK

It looks like you're calling the BTF_ID() macro on bpf_lsm_bpf_prog_free
twice?  I would have expected a only one macro call for each bpf_prog_load
and bpf_prog_free, is that a bad assuption?

> diff --git a/security/security.c b/security/security.c
> index dcb3e7014f9b..5773d446210e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
>  }
>  
>  /**
> - * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
> - * @aux: bpf program aux info struct
> + * security_bpf_prog_load() - Check if loading of BPF program is allowed
> + * @prog: BPF program object
> + * @attr: BPF syscall attributes used to create BPF program
> + * @token: BPF token used to grant user access to BPF subsystem
>   *
> - * Initialize the security field inside bpf program.
> + * Do a check when the kernel allocates BPF program object and is about to
> + * pass it to BPF verifier for additional correctness checks. This is also the
> + * point where LSM blob is allocated for LSMs that need them.

This is pretty nitpicky, but I'm guessing you may need to make another
revision to this patchset, if you do please drop the BPF verifier remark
from the comment above.

Example: "Perform an access control check when the kernel loads a BPF
program and allocates the associated BPF program object.  This hook is
also responsibile for allocating any required LSM state for the BPF
program."

>   * Return: Returns 0 on success, error on failure.
>   */
> -int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
> +int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
> +			   struct bpf_token *token)
>  {
> -	return call_int_hook(bpf_prog_alloc_security, 0, aux);
> +	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
>  }

--
paul-moore.com
