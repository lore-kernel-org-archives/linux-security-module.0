Return-Path: <SRS0=Dl7R=BN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6766FC433DF
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46413207FB
	for <linux-security-module@archiver.kernel.org>; Mon,  3 Aug 2020 15:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h3lU+1ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgHCPl5 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHCPl5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 3 Aug 2020 11:41:57 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F4C061756
        for <linux-security-module@vger.kernel.org>; Mon,  3 Aug 2020 08:41:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so34592876wrj.13
        for <linux-security-module@vger.kernel.org>; Mon, 03 Aug 2020 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zDbpSdI+Kg7J21FMtDaptpRpDHvK4QQHCXQIzqF2Kt8=;
        b=h3lU+1oxPPOe5Swh2bMYvJ8QZyr2RAeEDsNKI3Wl0DqmhQRbEmjGM9H9UUkrmZjOdw
         l/rSdNWDp4v0+B7g2+pXgW2Wx8kp2vICMRLuNoWtWfNrzS7HUjIjvcdffOBXILgAYOgO
         ELENyyZDMqP+Xc8OTSYTHH03K5WrobUBwa/AA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zDbpSdI+Kg7J21FMtDaptpRpDHvK4QQHCXQIzqF2Kt8=;
        b=pv+OYyfxtkyQQvEUhicDDvgqPaxJA5fyJSbvJ51yiXd/Y0lV7g8CZ0vUnkKiuSq1x0
         O92XD5LFWNNllt8uFvFmYPxNIzJ5kyQMABIIIDktHHyfLUfjWk5a/BSDCo/TLQIfUzhd
         YmUDTRPQWa7pVBBpcYlZyFYFSGSVWt824w8vAJR+eih4DCAwdWEVHjCBU+zlU2iHct9h
         197Hu0iZSRETRa92i1zUSQq0CTTG8C6khF0bfxc+idYIGIxm2HBHOyO8Y9jB3SyaPSnO
         MaVvr+yk2XpVR+ku0gAwvmtzB+ih6vnuIqHXDFB6O8e1DN49BuvmyMPLCIDXpem1LDur
         fLAg==
X-Gm-Message-State: AOAM532SBorovNru9MU0WEESmFIpkqpN8nZkcfEkbgZT5smzVaCuQOro
        AXaXUDyT41E29WKVrjjsNzpLeQ==
X-Google-Smtp-Source: ABdhPJxpsj//aPwb+f5tDc2RkKT8w2hW8MyYJ8torm6jn/JP7wErdFoQ472ZVtlUEzpAdIldlnSmig==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr17070883wro.271.1596469315419;
        Mon, 03 Aug 2020 08:41:55 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id q4sm25807370wme.31.2020.08.03.08.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 08:41:54 -0700 (PDT)
Subject: Re: [PATCH bpf-next v7 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200730140716.404558-1-kpsingh@chromium.org>
 <20200730140716.404558-6-kpsingh@chromium.org>
 <20200731010822.fctk5lawnr3p7blf@kafai-mbp.dhcp.thefacebook.com>
 <adbfc73e-bd32-d9ba-4dab-4ccc39b40fdd@chromium.org>
 <20200731190226.6ugmk6cnl2yortgt@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <c376c46c-f8e9-8a4c-3f81-300faddac831@chromium.org>
Date:   Mon, 3 Aug 2020 17:41:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731190226.6ugmk6cnl2yortgt@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 31.07.20 21:02, Martin KaFai Lau wrote:
> On Fri, Jul 31, 2020 at 02:08:55PM +0200, KP Singh wrote:
> [ ... ]
>>>> +const struct bpf_map_ops inode_storage_map_ops = {

[...]

>>
>> btf  dump file /sys/kernel/btf/vmlinux | grep "STRUCT 'inode'"
>> "[915] STRUCT 'inode' size=984 vlen=48
>>
>> So it seems like btf_id[0] and btf_id[1] are set to the BTF ID
>> for inode. Now I think this might just be a coincidence as
>> the next helper (bpf_inode_storage_delete) 
>> also has a BTF argument of type inode.
> It seems the next BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
> is not needed because they are the same.  I think one
> BTF_ID_LIST(bpf_inode_btf_ids) can be used for both helpers.
> 

Cool, yeah. I have fixed it and also for sock helpers. Will
send a new series out.

- KP

>>
>> and sure enough if I call:
>>
>> bpf_inode_storage_delete from my selftests program, 
>> it does not load:

[...]

>> ./test_progs -t test_local_storage
>> [   20.577223] btf_ids[0]=0
>> [   20.577702] btf_ids[1]=915
>>
>> Thanks for noticing this! 
>>
>> - KP
>>
>>>
>>>> +
>>>> +const struct bpf_func_proto bpf_inode_storage_get_proto = {
>>>> +	.func		= bpf_inode_storage_get,
>>>> +	.gpl_only	= false,
>>>> +	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
>>>> +	.arg1_type	= ARG_CONST_MAP_PTR,
>>>> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
>>>> +	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
>>>> +	.arg4_type	= ARG_ANYTHING,
>>>> +	.btf_id		= bpf_inode_storage_get_btf_ids,
>>>> +};
>>>> +
>>>> +BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
>>>> +BTF_ID(struct, inode)
>>>> +
>>>> +const struct bpf_func_proto bpf_inode_storage_delete_proto = {
>>>> +	.func		= bpf_inode_storage_delete,
>>>> +	.gpl_only	= false,
>>>> +	.ret_type	= RET_INTEGER,
>>>> +	.arg1_type	= ARG_CONST_MAP_PTR,
>>>> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
>>>> +	.btf_id		= bpf_inode_storage_delete_btf_ids,
>>>> +};
