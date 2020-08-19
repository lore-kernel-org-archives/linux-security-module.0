Return-Path: <SRS0=6iY4=B5=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB870C433DF
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 22:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A99206FA
	for <linux-security-module@archiver.kernel.org>; Wed, 19 Aug 2020 22:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ef522J+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHSWTv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWTr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Aug 2020 18:19:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ABC061757
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 15:19:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so314268ejc.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2020 15:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c+nD+6rOSt5uemBROilNSHXJdZPlPNIu2EDTx+MPmGY=;
        b=Ef522J+HKC9VQ3bXTdQCKpaISrqMAApkaMt0vil8OTOF7bGl/toU8qGdBGUstpcOqL
         7TvPKLv3ULgx8c5b25OU0ONXCq5g193Cxas0ff1KGyXSKNqk3GB+VuXaMUfUh3k1AT+s
         t0tZroI67koT3PQ7a/dFTvQC3LLqKlUymmTV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c+nD+6rOSt5uemBROilNSHXJdZPlPNIu2EDTx+MPmGY=;
        b=KqbN3BGSJ+QVmntKzz9V7skxkonMkVlf5fR0ubjtpi6d9aBqPD5xeM1CCxL0fJnd+L
         aFFNopleJbafzAA804zjL1FO2mbIicjD6J0x8qfQeH6hqbEBm9pkluetG0Dr7j+p2By+
         kBxdgOBeWRfiAn6WXQhWLTQy5hISnMNsCuBGbaJztglRLbmN8HBmCBlI89a8E7h4eQ0z
         aZRmSNN9UJ3D4UvA2Z1PZg7hJFYBHriYuepKmkgNUCcBJSv3f4O/v6Y9XFn721EslkEJ
         GTmTnXfQzkB7zJozLiAtlngeZOgJHRGZ44HOD9YsNfOb6PuPS8bhjyDGRsX/8hJXIDyB
         SPug==
X-Gm-Message-State: AOAM5307jGvQwEQ53FKWtUGA2IRHaAbrSOP7WMFngqvemi+/TmLF+s6w
        0jsKdPe3ya0dYCeiEGAaMeY4KQ==
X-Google-Smtp-Source: ABdhPJx1M6OHslbrJYzGQRpPTSSNnbD5cIdvwVw/gDhCC4OwGBD5G3lDSoEC9VQuL0+As3CMMoNHHw==
X-Received: by 2002:a17:906:6d59:: with SMTP id a25mr453935ejt.193.1597875585467;
        Wed, 19 Aug 2020 15:19:45 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id x16sm47545edr.25.2020.08.19.15.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 15:19:44 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 3/7] bpf: Generalize bpf_sk_storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-4-kpsingh@chromium.org>
 <20200818010545.iix72le4tkhuyqe5@kafai-mbp.dhcp.thefacebook.com>
 <6cb51fa0-61a5-2cf6-b44d-84d58d08c775@chromium.org>
 <20200819171215.lcgoon3fbm4kvkpc@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <a69e6bdf-7a1b-3152-f26b-20175451d9c2@chromium.org>
Date:   Thu, 20 Aug 2020 00:19:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819171215.lcgoon3fbm4kvkpc@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 19.08.20 19:12, Martin KaFai Lau wrote:
> On Wed, Aug 19, 2020 at 02:41:50PM +0200, KP Singh wrote:
>> On 8/18/20 3:05 AM, Martin KaFai Lau wrote:
>>> On Mon, Aug 03, 2020 at 06:46:51PM +0200, KP Singh wrote:
>>>> From: KP Singh <kpsingh@google.com>
>>>>
>>>> Refactor the functionality in bpf_sk_storage.c so that concept of

[...]

>>>> +			struct bpf_local_storage_map *smap,
>>>> +			struct bpf_local_storage_elem *first_selem);
>>>> +
>>>> +struct bpf_local_storage_data *
>>>> +bpf_local_storage_update(void *owner, struct bpf_map *map, void *value,
>>> Nit.  It may be more consistent to take "struct bpf_local_storage_map *smap"
>>> instead of "struct bpf_map *map" here.
>>>
>>> bpf_local_storage_map_check_btf() will be the only one taking
>>> "struct bpf_map *map".
>>
>> That's because it is used in map operations as map_check_btf which expects
>> a bpf_map *map pointer. We can wrap it in another function but is that
>> worth doing?
> Agree.  bpf_local_storage_map_check_btf() should stay as is.
> 
> I meant to only change the "bpf_local_storage_update()" to take
> "struct bpf_local_storage_map *smap".
> 

Apologies, I misread that. Updated.

- KP

 up here
>> 	 * or when the storage is freed e.g.
>> 	 * by bpf_sk_storage_free() during __sk_destruct().
>>
> +1
> 
