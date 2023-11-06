Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C58C4167B
	for <linux-security-module@archiver.kernel.org>; Mon,  6 Nov 2023 05:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjKFFB2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 6 Nov 2023 00:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFFB1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Nov 2023 00:01:27 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3317FF
        for <linux-security-module@vger.kernel.org>; Sun,  5 Nov 2023 21:01:22 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7788fb06997so289256485a.0
        for <linux-security-module@vger.kernel.org>; Sun, 05 Nov 2023 21:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699246882; x=1699851682; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LgkGL13BgwhVaF5JvPkLO8u/Sq6KAYlBvK2AjFLPOhI=;
        b=WnUe5Oi5hQ642wF7YtxIN5yBpyXL08awHcmFcKjwGMFwR25lW4Q20+/oiD9TosMVPR
         olhPSWK8JdXqpp2BikpsILQljTIEgGxJdhqrswQKPzUnUW7+5lNldX7nOORaDzUx7hYk
         wICmTkYOiKx8w5EFZNhf0vtK6M8aeEWYM2oHshEb2I4B5Q4egX2AxMrFyXhGxzmEZKyz
         c019A/nW6Dnd9qAQ2EbxXO3fDxYQF42zYCortmM1WlnEJ68tDLuwCzetmuiCv5d1+msw
         gnwX0t6veUaEPyD7zBginAnzemkD0QE7qT1Fvwz9REjveVP+DB0z32rRYrAmc/gM6lBV
         cN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699246882; x=1699851682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgkGL13BgwhVaF5JvPkLO8u/Sq6KAYlBvK2AjFLPOhI=;
        b=OHcoUVeG6A+MwCwtp+Ppsho2m2t9SWba51x28cpT8b0R7kajJMPSZloH/isL/bPQK6
         0ytK81SvdPXVMBSYQRwMhYpHWBR1lLKalIj5hZv7bBNLA71D5cjxDcMLePIuI5KiRRGQ
         jOJdAv6VBm2+BWKb3hMJPfttC0hFMOrTvOKsDFUnoKFWywIkvnq17iymXBkd2O+/2GBB
         jk0y4pAJPCTiBqObW89D2plN8EzmNTU1f13DQlrXTXY4EVEffz1+9A86wRt2NhLMF3JD
         REAECqiZiTgfpD9HGaujwtvjhmIHgfjR/gqUbKmk8gaHrYUJ4ltcdd5oSJhSK92DwRl9
         YtMg==
X-Gm-Message-State: AOJu0YxTJdmiYtMuPaYpOtbzU8XmiCSVxm2IRoYEyrb80VckwgUPxPaI
        29iviuSWuOc2rMiY0SyQCTGx
X-Google-Smtp-Source: AGHT+IEaTgvPP6kzsEEWzYutCxRoNhV4ImXyISw6RvmALCDNeOvp8z7ukff85hVdaAuaid2eKqqQIQ==
X-Received: by 2002:a05:620a:2844:b0:77a:5f8d:f079 with SMTP id h4-20020a05620a284400b0077a5f8df079mr11935047qkp.60.1699246881753;
        Sun, 05 Nov 2023 21:01:21 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j8-20020a05620a410800b007743671a41fsm2979825qko.72.2023.11.05.21.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 21:01:21 -0800 (PST)
Date:   Mon, 06 Nov 2023 00:01:20 -0500
Message-ID: <df2ecc560256f98a4fddf66529b72d38.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <brauner@kernel.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: Re: [PATCH v9 10/17] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM  hooks
References: <20231103190523.6353-11-andrii@kernel.org>
In-Reply-To: <20231103190523.6353-11-andrii@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Similarly to bpf_prog_alloc LSM hook, rename and extend bpf_map_alloc
> hook into bpf_map_create, taking not just struct bpf_map, but also
> bpf_attr and bpf_token, to give a fuller context to LSMs.
> 
> Unlike bpf_prog_alloc, there is no need to move the hook around, as it
> currently is firing right before allocating BPF map ID and FD, which
> seems to be a sweet spot.
> 
> But like bpf_prog_alloc/bpf_prog_free combo, make sure that bpf_map_free
> LSM hook is called even if bpf_map_create hook returned error, as if few
> LSMs are combined together it could be that one LSM successfully
> allocated security blob for its needs, while subsequent LSM rejected BPF
> map creation. The former LSM would still need to free up LSM blob, so we
> need to ensure security_bpf_map_free() is called regardless of the
> outcome.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++--
>  include/linux/security.h      |  6 ++++--
>  kernel/bpf/bpf_lsm.c          |  6 +++---
>  kernel/bpf/syscall.c          |  4 ++--
>  security/security.c           | 16 ++++++++++------
>  security/selinux/hooks.c      |  7 ++++---
>  6 files changed, 26 insertions(+), 18 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
