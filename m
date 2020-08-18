Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDEC433E3
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70805206B5
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 14:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iI8x+Bpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHROa2 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgHROaY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 10:30:24 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23990C061343
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 07:30:24 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c10so15417506edk.6
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 07:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uNMrh+oJtAzOJ4E1aOl6mhIopG05pjfwxNFOrBzLENY=;
        b=iI8x+BptaRYQcW/koMeu8EHod+gqmM3hwGdLJ4DuI8Ip83avJh3xK8SjvXJ9dxEBx2
         x8qZQbZQxX9PQK3Iys50h20c8YpsLbJDP6Zupf+eX031yEQ7W2igaavvUK/u+W4RYgeY
         CG/Ne7SKF68NwmMnxGv10VshBAEJdMKES0mTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uNMrh+oJtAzOJ4E1aOl6mhIopG05pjfwxNFOrBzLENY=;
        b=MsFKDpJWF9wQCK5NGOKTjKuFFzoX+k4YxBsjMmY0Ls5pvUGTKz2cctX5uTNhzjjTpX
         m+UJSRsJjAwMcZ0JIdryckkMOD+LTy85D5mziKg66cmQN+F9opLNI7NSVqA5qmoDYu+e
         GNqx4CHs0J49l/SUvww87sm8AUAre0ZqDAz+ahtkBrmyDBS4phj2GG8JYTp43MFB/cwV
         xuZ7bqfvBUC5pUoAKFIKgF7eomybIapGytqPBS6f92F1FZwELBkJyHq8Qt8ihyNvPn8B
         MfoQVpEGsyk/3CYZDoUD/dOB17QrhsgXf67EtNZLvqy3QlvyeEME8CeufqOlw/GlT65T
         BkMg==
X-Gm-Message-State: AOAM533XT3DZBsNJWcyl5oRMjncoByD1qU40TVqN4kr1H7Q0WNhUnT6F
        SQSzli+mLWj2XfflKiVyO5gzcQ==
X-Google-Smtp-Source: ABdhPJzNl2xbyrcto/z2JWk8p8a3T6cWnVMNIsGNZsnotgtthOq7WYEBNZXFKLaRQU4YjK+f4fRQmQ==
X-Received: by 2002:a05:6402:b67:: with SMTP id cb7mr20158831edb.216.1597761022560;
        Tue, 18 Aug 2020 07:30:22 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id re10sm16759810ejb.68.2020.08.18.07.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 07:30:21 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 1/7] A purely mechanical change to split the
 renaming from the actual generalization.
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-2-kpsingh@chromium.org>
 <20200817235621.ulkqw6mqd2uu647t@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <51554981-21be-5b42-2827-f6c90b587b95@chromium.org>
Date:   Tue, 18 Aug 2020 16:30:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817235621.ulkqw6mqd2uu647t@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/18/20 1:56 AM, Martin KaFai Lau wrote:
> On Mon, Aug 03, 2020 at 06:46:49PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Flags/consts:
>>
>>   SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
>>   BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
>>   MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE
>>
>> Structs:
>>
>>   bucket			bpf_local_storage_map_bucket
>>   bpf_sk_storage_map		bpf_local_storage_map
>>   bpf_sk_storage_data		bpf_local_storage_data
>>   bpf_sk_storage_elem		bpf_local_storage_elem
>>   bpf_sk_storage		bpf_local_storage
>>
>> The "sk" member in bpf_local_storage is also updated to "owner"
>> in preparation for changing the type to void * in a subsequent patch.
>>
>> Functions:
>>
>>   selem_linked_to_sk			selem_linked_to_storage
>>   selem_alloc				bpf_selem_alloc
>>   __selem_unlink_sk			bpf_selem_unlink_storage
>>   __selem_link_sk			bpf_selem_link_storage
>>   selem_unlink_sk			__bpf_selem_unlink_storage
>>   sk_storage_update			bpf_local_storage_update
>>   __sk_storage_lookup			bpf_local_storage_lookup
>>   bpf_sk_storage_map_free		bpf_local_storage_map_free
>>   bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
>>   bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
>>   bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf
>>
> 
> [ ... ]
> 
>> @@ -147,85 +148,86 @@ static struct bpf_sk_storage_elem *selem_alloc(struct bpf_sk_storage_map *smap,
>>   * The caller must ensure selem->smap is still valid to be
>>   * dereferenced for its smap->elem_size and smap->cache_idx.
>>   */
>> -static bool __selem_unlink_sk(struct bpf_sk_storage *sk_storage,
>> -			      struct bpf_sk_storage_elem *selem,
>> -			      bool uncharge_omem)
>> +static bool bpf_selem_unlink_storage(struct bpf_local_storage *local_storage,
>> +				     struct bpf_local_storage_elem *selem,
>> +				     bool uncharge_omem)
> Please add a "_nolock()" suffix, just to be clear that the unlink_map()
> counter part is locked.  It could be a follow up later.

Done.

> 
>>  {
>> -	struct bpf_sk_storage_map *smap;
>> -	bool free_sk_storage;
>> +	struct bpf_local_storage_map *smap;
>> +	bool free_local_storage;

[...]

>> +	if (unlikely(!selem_linked_to_storage(selem)))
>>  		/* selem has already been unlinked from sk */
>>  		return;
>>  
>> -	sk_storage = rcu_dereference(selem->sk_storage);
>> -	raw_spin_lock_bh(&sk_storage->lock);
>> -	if (likely(selem_linked_to_sk(selem)))
>> -		free_sk_storage = __selem_unlink_sk(sk_storage, selem, true);
>> -	raw_spin_unlock_bh(&sk_storage->lock);
>> +	local_storage = rcu_dereference(selem->local_storage);
>> +	raw_spin_lock_bh(&local_storage->lock);
>> +	if (likely(selem_linked_to_storage(selem)))
>> +		free_local_storage =
>> +			bpf_selem_unlink_storage(local_storage, selem, true);
>> +	raw_spin_unlock_bh(&local_storage->lock);
>>  
>> -	if (free_sk_storage)
>> -		kfree_rcu(sk_storage, rcu);
>> +	if (free_local_storage)
>> +		kfree_rcu(local_storage, rcu);
>>  }
>>  
>> -static void __selem_link_sk(struct bpf_sk_storage *sk_storage,
>> -			    struct bpf_sk_storage_elem *selem)
>> +static void bpf_selem_link_storage(struct bpf_local_storage *local_storage,
>> +				   struct bpf_local_storage_elem *selem)
> Same here. bpf_selem_link_storage"_nolock"().

Done.

> 
> Please tag the Subject line with "bpf:".

Done. Changed it to:

bpf: Renames in preparation for bpf_local_storage
    
A purely mechanical change to split the renaming from the actual
generalization.

[...]

> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
