Return-Path: <SRS0=wQ8B=B4=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F01FC433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7111C20578
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Aug 2020 15:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UXlGAiGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHRPKl (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgHRPKh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Aug 2020 11:10:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A891DC061342
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 08:10:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so18591097wrh.10
        for <linux-security-module@vger.kernel.org>; Tue, 18 Aug 2020 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zxe+HJmIWMfQ1RElqmaY0GiV1Gl7b0KgtI/GKiLoLwc=;
        b=UXlGAiGLTmMimNPojD1cHSTRsErRHNBbtrZT5pI3TeFxNQmf20CwFIdDFAcb0a7n4+
         vmKVl8ds6JZwjQwoEtNGzQL7v/yP6SqgzMeGFesFIPLs4fKR2BNPUoR/6xUfk19656yl
         JRTAGLhb+3nGmbMEI88v/pCOE7murI68EWPJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxe+HJmIWMfQ1RElqmaY0GiV1Gl7b0KgtI/GKiLoLwc=;
        b=tQHBykNq7/LmK/tHZpxgDxVIO843nyux943k/0fEMHN12OUiB1HfNAlAfh75zuRIt+
         YPD2htnmcRuLdwR3lv8nWX6dDee6D6xUD6DYJNUj4j2zjoMRE9WX/gzHa3J3EhXm1Mwy
         Ez4MC9JBrQt4k6S0W/eVdsfYhk9sHrdjADu21u64CllPJNvhzvRwZGqnOKr2jasW6Rq/
         75fQLYhRSzo0uwcdLUI1lcCHbg1/gSmNKnOSvneNBTdo+Fpflb2oL70GM1kJAnrY1D9i
         XKCdU8QNRuKDDn8Zu33j/jy4z+c9+pM62wRvBC0APcBjGI5+uVFvPUoY3twCh7Wke+Md
         cwCw==
X-Gm-Message-State: AOAM533AgWRg7U3zrj8Xg7mBDGg0HcRravUwAOnw/IP9oNU7XHHZbKTF
        02ZbcLukma9+ycVbBRVwvqZ8zw==
X-Google-Smtp-Source: ABdhPJwMZXOzExdHgzzwPRNZtVauhbOakNrr5oH3e0Yl8Lg/4VVrGTLwLZqELVDHQ2B0C62wz/T+gw==
X-Received: by 2002:adf:e504:: with SMTP id j4mr21174389wrm.205.1597763435276;
        Tue, 18 Aug 2020 08:10:35 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id z6sm279421wml.41.2020.08.18.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:10:34 -0700 (PDT)
Subject: Re: [PATCH bpf-next v8 5/7] bpf: Implement bpf_local_storage for
 inodes
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-6-kpsingh@chromium.org>
 <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <60344fad-f761-0fee-a6ef-4880c45c3e52@chromium.org>
Date:   Tue, 18 Aug 2020 17:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818012758.4666zlknkr4x6cbl@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 8/18/20 3:27 AM, Martin KaFai Lau wrote:
> On Mon, Aug 03, 2020 at 06:46:53PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Similar to bpf_local_storage for sockets, add local storage for inodes.
>> The life-cycle of storage is managed with the life-cycle of the inode.
>> i.e. the storage is destroyed along with the owning inode.
>>
>> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
>> security blob which are now stackable and can co-exist with other LSMs.
>>
>> Signed-off-by: KP Singh <kpsingh@google.com>
>> ---
>>  include/linux/bpf_local_storage.h             |  10 +
>>  include/linux/bpf_lsm.h                       |  21 ++
>>  include/linux/bpf_types.h                     |   3 +
>>  include/uapi/linux/bpf.h                      |  38 +++
>>  kernel/bpf/Makefile                           |   1 +

[...]

ata *inode_storage_lookup(struct inode *inode,
>> +							   struct bpf_map *map,
>> +							   bool cacheit_lockit)
>> +{
>> +	struct bpf_local_storage *inode_storage;
>> +	struct bpf_local_storage_map *smap;
>> +	struct bpf_storage_blob *bsb;
>> +
>> +	bsb = bpf_inode(inode);
>> +	if (!bsb)
>> +		return ERR_PTR(-ENOENT);
> ERR_PTR is returned here...
> 
>> +
>> +	inode_storage = rcu_dereference(bsb->storage);
>> +	if (!inode_storage)
>> +		return NULL;
>> +

[...]

>> +		kfree_rcu(local_storage, rcu);
>> +}
>> +
>> +
>> +static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct file *f;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	f = fcheck(fd);
>> +	if (!f)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	get_file(f);
>> +	sdata = inode_storage_lookup(f->f_inode, map, true);
>> +	fput(f);
>> +	return sdata ? sdata->data : NULL;
> sdata can be ERR_PTR here and a few other cases below.
> 
> May be inode_storage_lookup() should just return NULL.

I think returning NULL is a better option. Thanks!

> 
>> +}
>> +
>> +static int bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
>> +					 void *value, u64 map_flags)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +	struct file *f;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	f = fcheck(fd);
>> +	if (!f)
>> +		return -EINVAL;
>> +
>> +	get_file(f);> get_file() does atomic_long_inc() instead of atomic_long_inc_not_zero().
> I don't see how that helps here.  Am I missing something?

You are right, this should not not be an fcheck followed by a get_file
rather fcheck followed by get_file_rcu:

#define get_file_rcu_many(x, cnt)	\
	atomic_long_add_unless(&(x)->f_count, (cnt), 0)
#define get_file_rcu(x) get_file_rcu_many((x), 1)
#define file_count(x)	atomic_long_read(&(x)->f_count)

But there is an easier way than all of this and this is to use 
fget_raw which also calls get_file_rcu_many 
and ensures a non-zero count before getting a reference.

- KP

> 
>> +	sdata = bpf_local_storage_update(f->f_inode, map, value, map_flags);
>> +	fput(f);
>> +	return PTR_ERR_OR_ZERO(sdata);
>> +}
>> +
