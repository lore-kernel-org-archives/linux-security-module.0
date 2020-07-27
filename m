Return-Path: <SRS0=m40R=BG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D47C433E1
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 20:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8452075D
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 20:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HAp+xdKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgG0U04 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbgG0U04 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 16:26:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CBC0619D4
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2020 13:26:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so16123683wrh.10
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jul 2020 13:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IRCcsXpaaLaM038K29AfeEzWiB+CPxs3iz1GKps2ELI=;
        b=HAp+xdKDIRDrY/SvUb4vMd8+wCOTYwQ9Ki/3l8mYLztDtSyWXywWt1/wiWyGU3J7S1
         aycDiOBu1D3qTMsKV0T4CWLdvVxMv3pqHPY32jmI0NiZV7zbXl9enC4Q/BYAxsB5uXOC
         t6E+hNM83aXgPyrXDGhWFV0ZIu3gSVElU6ZhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IRCcsXpaaLaM038K29AfeEzWiB+CPxs3iz1GKps2ELI=;
        b=NZn6agza0L/+HG2vKnRFzTbTpIidbXuXcGA+zO0uO7+G8xZQLxeigMGlKuLrVTKrAB
         4fJ5dvhr9fQ/ArwTxKDJUYKf6w+M9pIiQUtwgTkgeV1zrR+gkYtSTH/QvtlBF/Q0Y/u4
         vHWSpEdkhssnWb2xcFoBQi9X1XPBhDbvYIDv72aYbk/JMnz+gsfkBuInIDAgk7E57yyD
         H+ZSRM+Cxo1KWDuALeZtjbDCBipRoqGEfBFIwrxZ92/hVIeX4KjdiHDN6djzg7qWeQ2K
         U2BmA2y5yYcE2ujS7ltV8ZWXXUciY9gtJ3BtFjCz5cuLDaqgkCSnXYoklIxzZIZPR1HQ
         Tx3A==
X-Gm-Message-State: AOAM532zvhHlRlt17oK+6S9TV0ozpZ8R9PV0YAzzNUjjLFZ2L03d2Nu7
        V7S58O9+q2eIJ7M7DFtz9ysVqQ==
X-Google-Smtp-Source: ABdhPJwvh6fZ0T2qw9pLgRK+ON9OfQe4rJptojXuDRhaVdh788crsN7Q8b8A6JLjjNn2GxfTK5rxUQ==
X-Received: by 2002:a5d:4dc2:: with SMTP id f2mr22056598wru.399.1595881614638;
        Mon, 27 Jul 2020 13:26:54 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id l81sm924197wmf.4.2020.07.27.13.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:26:54 -0700 (PDT)
Subject: Re: [RFC PATCH bpf-next] bpf: POC on local_storage charge and
 uncharge map_ops
To:     Martin KaFai Lau <kafai@fb.com>, KP Singh <kpsingh@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200723115032.460770-4-kpsingh@chromium.org>
 <20200725013047.4006241-1-kafai@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <c3c422c7-b15e-32ee-4156-b9d26896f7a0@chromium.org>
Date:   Mon, 27 Jul 2020 22:26:53 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725013047.4006241-1-kafai@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Thanks for this, I was able to update the series with this patch and it works.
One minor comment though.

I was wondering how should I send it as a part of the series. I will keep the
original commit description + mention this thread and add your Co-Developed-by:
tag and then you can add your Signed-off-by: as well. I am not sure of the 
canonical way here and am open to suggestions :)

- KP

On 25.07.20 03:30, Martin KaFai Lau wrote:
> It is a direct replacement of the patch 3 in discussion [1]
> and to test out the idea on adding
> map_local_storage_charge, map_local_storage_uncharge,
> and map_owner_storage_ptr.
> 
> It is only compiler tested to demo the idea.
> 
> [1]: https://patchwork.ozlabs.org/project/netdev/patch/20200723115032.460770-4-kpsingh@chromium.org/
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/linux/bpf.h            |  10 ++
>  include/net/bpf_sk_storage.h   |  51 +++++++
>  include/uapi/linux/bpf.h       |   8 +-

[...]

> +
> +static void sk_storage_uncharge(struct bpf_local_storage_map *smap,
> +				void *owner, u32 size)
> +{
> +	struct sock *sk = owner;
> +
> +	atomic_sub(size, &sk->sk_omem_alloc);
> +}
> +
> +static struct bpf_local_storage __rcu **
> +sk_storage_ptr(struct bpf_local_storage_map *smap, void *owner)

Do we need an smap pointer here? It's not being used and is also not
used for inode as well.

- KP

> +{
> +	struct sock *sk = owner;
> +
> +	return &sk->sk_bpf_storage;
> +}
> +

[...]

> -/* BPF_FUNC_sk_storage_get flags */
> +/* BPF_FUNC_<local>_storage_get flags */
>  enum {
> -	BPF_SK_STORAGE_GET_F_CREATE	= (1ULL << 0),
> +	BPF_LOCAL_STORAGE_GET_F_CREATE	= (1ULL << 0),
> +	/* BPF_SK_STORAGE_GET_F_CREATE is only kept for backward compatibility
> +	 * and BPF_LOCAL_STORAGE_GET_F_CREATE must be used instead.
> +	 */
> +	BPF_SK_STORAGE_GET_F_CREATE  = BPF_LOCAL_STORAGE_GET_F_CREATE,
>  };
>  
>  /* BPF_FUNC_read_branch_records flags. */
> 
