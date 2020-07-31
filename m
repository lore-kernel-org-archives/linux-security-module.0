Return-Path: <SRS0=u9BV=BK=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B7FC433E3
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Jul 2020 12:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EBC208E4
	for <linux-security-module@archiver.kernel.org>; Fri, 31 Jul 2020 12:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5BCiRw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgGaMJA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgGaMI7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 Jul 2020 08:08:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFAC06174A
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2020 05:08:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so18985061edv.13
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2020 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qrIvFFFLQgJ+wOtTOJrVCrzJgyAjVEkVe42TSriGtHo=;
        b=j5BCiRw+8dnqTCVEQ7eBHOIi16HFlxS/y+/9uA3B3T3QLrRhH9krKpa36AzeA1Ai6M
         PnHQiVGbJ4y6ZBPQMsZlRO7G4A6bRkRwmfMRQldHoqzNOCLzJuD5Huw4TPapTCeT5Ae5
         hA46xf6q2lA3nyzz1bsKb+Z8HAseneokZyg5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qrIvFFFLQgJ+wOtTOJrVCrzJgyAjVEkVe42TSriGtHo=;
        b=ZW8sxm7JickJXOrB5x9hcPbkzpKK7Bxgr7wEyw4Ahb9DqJOj88prQfzx4jDx27mA22
         tYqTw8rzCh7mffu1cOs8UumjkUVEK2tgPlOVqzbrnpnEjlieMLaaGOfaS9Otkc+q+YTs
         5iBT2G+VNeDcgJ2Bff8NfihY8h36mmzjrB7DvLuAaYmjpf2oI6xXI0CsfVWY7gwh/iMz
         tPJw0Vmy4NhJW3a/SuyCc47RAlzQN3dOfussX5Tmr7XOx0pPSDFG/iztUC62ek80iZy1
         iZImaNke31GdFC+lklp+ET9XS79UixRNzBfx/wqGSXVAk/RN3bjeyM8GIH31lRHsazI+
         od3g==
X-Gm-Message-State: AOAM5315KfRT+tv+ixxIxujqgadeVYV6CKT5soF6Z4ccQfw9UjSPKvwT
        391sWb+F+8ezFAwZcgChHG1B0w==
X-Google-Smtp-Source: ABdhPJxXn168xhcJJSOMcMHvZFFuGB2/SRSJxOp6Pa29ibMk4y9dTpxsXRCuoXsV9RMgHH9vaxFr8Q==
X-Received: by 2002:a50:fc13:: with SMTP id i19mr3538204edr.363.1596197336814;
        Fri, 31 Jul 2020 05:08:56 -0700 (PDT)
Received: from [192.168.2.66] ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id q19sm9124292ejo.93.2020.07.31.05.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 05:08:56 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
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
Message-ID: <adbfc73e-bd32-d9ba-4dab-4ccc39b40fdd@chromium.org>
Date:   Fri, 31 Jul 2020 14:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731010822.fctk5lawnr3p7blf@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 31.07.20 03:08, Martin KaFai Lau wrote:
> On Thu, Jul 30, 2020 at 04:07:14PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Similar to bpf_local_storage for sockets, add local storage for inodes.
>> The life-cycle of storage is managed with the life-cycle of the inode.
>> i.e. the storage is destroyed along with the owning inode.
>>
>> The BPF LSM allocates an __rcu pointer to the bpf_local_storage in the
>> security blob which are now stackable and can co-exist with other LSMs.
>>
> 
> [ ... ]
> 
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
>> +	sdata = bpf_local_storage_update(f->f_inode, map, value, map_flags);
> n00b question.  inode will not be going away here (like another
> task calls close(fd))?  and there is no chance that bpf_local_storage_update()
> will be adding new storage after bpf_inode_storage_free() was called?

Good catch, I think we need to guard this update by grabbing a reference 
to the file here.

> 
> A few comments will be useful here.
> 
>> +	return PTR_ERR_OR_ZERO(sdata);
>> +}
>> +
>> +static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +
>> +	sdata = inode_storage_lookup(inode, map, false);
>> +	if (!sdata)
>> +		return -ENOENT;
>> +
>> +	bpf_selem_unlink(SELEM(sdata));
>> +
>> +	return 0;
>> +}
>> +
>> +static int bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
>> +{
>> +	struct file *f;
>> +	int fd;
>> +
>> +	fd = *(int *)key;
>> +	f = fcheck(fd);
>> +	if (!f)
>> +		return -EINVAL;
>> +
>> +	return inode_storage_delete(f->f_inode, map);
>> +}
>> +
>> +BPF_CALL_4(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>> +	   void *, value, u64, flags)
>> +{
>> +	struct bpf_local_storage_data *sdata;
>> +
>> +	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>> +		return (unsigned long)NULL;
>> +
>> +	sdata = inode_storage_lookup(inode, map, true);
>> +	if (sdata)
>> +		return (unsigned long)sdata->data;
>> +
>> +	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
>> +		sdata = bpf_local_storage_update(inode, map, value,
>> +						 BPF_NOEXIST);
> The same question here

This is slightly different. The helper gets called from the BPF program.
We are only allowing this from LSM hooks which have better guarantees
w.r.t the lifetime of the object unlike tracing programs.

I will add a comment that explains this. Once we have sleepable BPF we can
also grab a reference to the inode here.

> 
>> +		return IS_ERR(sdata) ? (unsigned long)NULL :
>> +					     (unsigned long)sdata->data;
>> +	}
>> +
>> +	return (unsigned long)NULL;
>> +}
>> +
>> +BPF_CALL_2(bpf_inode_storage_delete,
>> +	   struct bpf_map *, map, struct inode *, inode)
>> +{
>> +	return inode_storage_delete(inode, map);
>> +}
>> +
>> +static int notsupp_get_next_key(struct bpf_map *map, void *key,
>> +				void *next_key)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
>> +{
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	smap = bpf_local_storage_map_alloc(attr);
>> +	if (IS_ERR(smap))
>> +		return ERR_CAST(smap);
>> +
>> +	smap->cache_idx = bpf_local_storage_cache_idx_get(&inode_cache);
>> +	return &smap->map;
>> +}
>> +
>> +static void inode_storage_map_free(struct bpf_map *map)
>> +{
>> +	struct bpf_local_storage_map *smap;
>> +
>> +	smap = (struct bpf_local_storage_map *)map;
>> +	bpf_local_storage_cache_idx_free(&inode_cache, smap->cache_idx);
>> +	bpf_local_storage_map_free(smap);
>> +}
>> +
>> +static int sk_storage_map_btf_id;

This name needs to be fixed as well.

>> +const struct bpf_map_ops inode_storage_map_ops = {
>> +	.map_alloc_check = bpf_local_storage_map_alloc_check,
>> +	.map_alloc = inode_storage_map_alloc,
>> +	.map_free = inode_storage_map_free,
>> +	.map_get_next_key = notsupp_get_next_key,
>> +	.map_lookup_elem = bpf_fd_inode_storage_lookup_elem,
>> +	.map_update_elem = bpf_fd_inode_storage_update_elem,
>> +	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
>> +	.map_check_btf = bpf_local_storage_map_check_btf,
>> +	.map_btf_name = "bpf_local_storage_map",
>> +	.map_btf_id = &sk_storage_map_btf_id,
>> +	.map_owner_storage_ptr = inode_storage_ptr,
>> +};
>> +
>> +BTF_ID_LIST(bpf_inode_storage_get_btf_ids)
>> +BTF_ID(struct, inode)
> The ARG_PTR_TO_BTF_ID is the second arg instead of the first
> arg in bpf_inode_storage_get_proto.
> Does it just happen to work here without needing BTF_ID_UNUSED?


Yeah, this surprised me as to why it worked, so I did some debugging:


diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9cd1428c7199..95e84bcf1a74 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -52,6 +52,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
        switch (func_id) {
        case BPF_FUNC_inode_storage_get:
+               pr_err("btf_ids[0]=%d\n", bpf_inode_storage_get_proto.btf_id[0]);
+               pr_err("btf_ids[1]=%d\n", bpf_inode_storage_get_proto.btf_id[1]);
                return &bpf_inode_storage_get_proto;
        case BPF_FUNC_inode_storage_delete:
                return &bpf_inode_storage_delete_proto;

./test_progs -t test_local_storage

[   21.694473] btf_ids[0]=915
[   21.694974] btf_ids[1]=915

btf  dump file /sys/kernel/btf/vmlinux | grep "STRUCT 'inode'"
"[915] STRUCT 'inode' size=984 vlen=48

So it seems like btf_id[0] and btf_id[1] are set to the BTF ID
for inode. Now I think this might just be a coincidence as
the next helper (bpf_inode_storage_delete) 
also has a BTF argument of type inode.

and sure enough if I call:

bpf_inode_storage_delete from my selftests program, 
it does not load:

arg#0 type is not a struct
Unrecognized arg#0 type PTR
; int BPF_PROG(unlink_hook, struct inode *dir, struct dentry *victim)
0: (79) r6 = *(u64 *)(r1 +8)
func 'bpf_lsm_inode_unlink' arg1 has btf_id 912 type STRUCT 'dentry'
; __u32 pid = bpf_get_current_pid_tgid() >> 32;

[...]

So, The BTF_ID_UNUSED is actually needed here. I also added a call to
bpf_inode_storage_delete in my test to catch any issues with it.

After adding BTF_ID_UNUSED, the result is what we expect:

./test_progs -t test_local_storage
[   20.577223] btf_ids[0]=0
[   20.577702] btf_ids[1]=915

Thanks for noticing this! 

- KP

> 
>> +
>> +const struct bpf_func_proto bpf_inode_storage_get_proto = {
>> +	.func		= bpf_inode_storage_get,
>> +	.gpl_only	= false,
>> +	.ret_type	= RET_PTR_TO_MAP_VALUE_OR_NULL,
>> +	.arg1_type	= ARG_CONST_MAP_PTR,
>> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
>> +	.arg3_type	= ARG_PTR_TO_MAP_VALUE_OR_NULL,
>> +	.arg4_type	= ARG_ANYTHING,
>> +	.btf_id		= bpf_inode_storage_get_btf_ids,
>> +};
>> +
>> +BTF_ID_LIST(bpf_inode_storage_delete_btf_ids)
>> +BTF_ID(struct, inode)
>> +
>> +const struct bpf_func_proto bpf_inode_storage_delete_proto = {
>> +	.func		= bpf_inode_storage_delete,
>> +	.gpl_only	= false,
>> +	.ret_type	= RET_INTEGER,
>> +	.arg1_type	= ARG_CONST_MAP_PTR,
>> +	.arg2_type	= ARG_PTR_TO_BTF_ID,
>> +	.btf_id		= bpf_inode_storage_delete_btf_ids,
>> +};
