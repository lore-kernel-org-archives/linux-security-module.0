Return-Path: <SRS0=UPXR=CD=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55419C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Aug 2020 14:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277AB20665
	for <linux-security-module@archiver.kernel.org>; Tue, 25 Aug 2020 14:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLnUNSiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHYOKd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYOK3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Aug 2020 10:10:29 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD1C061574
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2020 07:10:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so16728433eje.7
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2020 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBFZttGfteQiG/F6m1JwLuRmWwiLtOn1NGTSQxlL0R8=;
        b=jLnUNSiRkVPmazSgOpBGGkBIFbQgn3SubSGBtfI3udYnQF9YnvGbPLGw/Bg6gNQG51
         2HwfjMpqoLNbtQmB1chriB3Xc8+RWCRJunAgmt/FWga/wQK351I3xuMzc9ungM1zD6Tt
         VRfW5hS51m8ANRTTusv4bV+aPInEeBnWiAcyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBFZttGfteQiG/F6m1JwLuRmWwiLtOn1NGTSQxlL0R8=;
        b=Xtqri9kvJ7/3JM7hG8A4kNXvk9Tg7LuDu2NdinOfmA34GiaGCt0ud2boujM9icHpgV
         F4+uHZyuIPY9vJ0WQcyoUbY2/xG6kOxLgsrqS+rs6WFLY9Oo0a/Q+E9oQ/1V1rBakSLN
         QUuuNZmEz06X1XhWIK+SxZmK5FRlmUwaFSzmyVRJocGhvAz/hkLnzUScLmKpK4y3lXL9
         JavR53aap6zkOtzBFQmZXFmDlFDuCu3AkxM24ZKeOWjTEONjSVGdbF/hfeLV1B872rl5
         94FQhd732Ll+icpBs9jMS/miTj/6G8u+fNiT769OCO6Q4jSwj6cU6gpa5Or3C2Bqv0NM
         F+jQ==
X-Gm-Message-State: AOAM531Sl7BdVHqwlLb4XbGgZuHdKHJOUHgRAGAfCMn5WXQWH3WdHEa4
        qoXWiM8v8GaNTixAWCmUdx/0Vg==
X-Google-Smtp-Source: ABdhPJxq6mmRIKDhAU5ShGteau34Y08h7aVZadX+431P5t07HDWQQ3Kk0Yx+B6hDuJMw7xniEin/hA==
X-Received: by 2002:a17:906:553:: with SMTP id k19mr11039230eja.401.1598364627531;
        Tue, 25 Aug 2020 07:10:27 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id dj16sm7658961edb.5.2020.08.25.07.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 07:10:27 -0700 (PDT)
Subject: Re: [PATCH bpf-next v9 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200823165612.404892-1-kpsingh@chromium.org>
 <20200823165612.404892-6-kpsingh@chromium.org>
 <20200825005249.tu4c54fg36jt3rh4@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <8d188285-96f5-3b17-126f-5e842702e339@chromium.org>
Date:   Tue, 25 Aug 2020 16:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825005249.tu4c54fg36jt3rh4@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/25/20 2:52 AM, Martin KaFai Lau wrote:
> On Sun, Aug 23, 2020 at 06:56:10PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Similar to bpf_local_storage for sockets, add local storage for inodes.
>> The life-cycle of storage is managed with the life-cycle of the inode.
>> i.e. the storage is destroyed along with the owning inode.
>>
>> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
>> security blob which are now stackable and can co-exist with other LSMs.
>>
> [ ... ]
> 
>> diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
>> new file mode 100644
>> index 000000000000..b0b283c224c1
>> --- /dev/null
>> +++ b/kernel/bpf/bpf_inode_storage.c

[...]

>> +
>> +DEFINE_BPF_STORAGE_CACHE(inode_cache);
>> +
>> +static struct bpf_local_storage __rcu **
>> +inode_storage_ptr(void *owner)
>> +{
>> +	struct inode *inode = owner;
>> +	struct bpf_storage_blob *bsb;
>> +
>> +	bsb = bpf_inode(inode);
>> +	if (!bsb)
>> +		return NULL;
> just noticed this one.  NULL could be returned here.  When will it happen?

This can happen if CONFIG_BPF_LSM is enabled but "bpf" is not in the list of
active LSMs.

> 
>> +	return &bsb->storage;
>> +}
>> +
>> +static struct bpf_local_storage_data *inode_storage_lookup(struct inode *inode,
>> +							   struct bpf_map *map,
>> +							   bool cacheit_lockit)
>> +{

[...]

> path first before calling the bpf_local_storage_update() since
> this case is specific to inode local storage.
> 
> Same for the other bpf_local_storage_update() cases.

If you're okay with this I can send a new series with the following updates.

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index b0b283c224c1..74546cee814d 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -125,7 +125,7 @@ static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
        fd = *(int *)key;
        f = fget_raw(fd);
-       if (!f)
+       if (!f || !inode_storage_ptr(f->f_inode))
                return -EBADF;
 
        sdata = bpf_local_storage_update(f->f_inode,
@@ -171,6 +171,14 @@ BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
        if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
                return (unsigned long)NULL;
 
+       /* explicitly check that the inode_storage_ptr is not
+        * NULL as inode_storage_lookup returns NULL in this case and
+        * and bpf_local_storage_update expects the owner to have a
+        * valid storage pointer.
+        */
+       if (!inode_storage_ptr(inode))
+               return (unsigned long)NULL;
+
        sdata = inode_storage_lookup(inode, map, true);
        if (sdata)
                return (unsigned long)sdata->data;


> 
>> +					 (struct bpf_local_storage_map *)map,
>> +					 value, map_flags);
>> +	fput(f);
>> +	return PTR_ERR_OR_ZERO(sdata);
>> +}
>> +
> 

[...]

>> +	return (unsigned long)NULL;
>> +}
>> +
> 
>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>> index 32d32d485451..35f9b19259e5 100644
>> --- a/security/bpf/hooks.c
>> +++ b/security/bpf/hooks.c
>> @@ -3,6 +3,7 @@
>>  /*
>>   * Copyright (C) 2020 Google LLC.
>>   */
>> +#include <linux/bpf_local_storage.h>
> Is it needed?

No. Removed. Thanks!

> 
>>  #include <linux/lsm_hooks.h>
>>  #include <linux/bpf_lsm.h>
>>  
>> @@ -11,6 +12,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(NAME, bpf_lsm_##NAME),

[...]

>> +	.blobs = &bpf_lsm_blob_sizes
>>  };
