Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89481356779;
	Sat,  1 Aug 2026 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785581442; cv=none; b=Du5BTvmJSH3yDNmP0xajtnYGWARzxU88hxMLup6PR/VhWBbG/t8qLrStqYwQg/EIj2gqz3KjQZWS3JhHgByTR5S/rtRFcAZB4+9xYCMaIoR/Gw8IPRFnc1HbXv4ZsYhm3ebsvgfGGiGuMNS2x3ofUlIMOpMnFhPDdSziMg2SWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785581442; c=relaxed/simple;
	bh=qbdGdQ0vX5nBmmNEW/ebU5aGv2pcmHS5+hZFZD2/pPc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rTtCXW/j3lXe/Y6rr1nnK6GPXTFyej9gm4wOgeTg6MB15hNIxWDm4qAM19BvYr9qIDsBN33snS5fG8xNSE2iVobMQYnMrMBbA6W590u+6QEQZ0P4YXzfZP6ztFq8+ImDZZblrCjU29m8D1S+3f4OiLTrwW5shWpza9XAo2hsxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oW8bDy9r; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oW8bDy9r"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nccBkP+GF+slKpe9GzM0ylF9zJrhK837R45xbFlW+Rs=;
	b=oW8bDy9raAm5putEUxrp/uGIxJOMWiAhcZ6FCEd52pxy+L3eGNIKZEupKgvhFg6x//688dVdU
	zNze0Jp45/tgJFStPHLaJLhvUMRE6qDAgy3+Awh+6s0yWYzipja70sJHqrpgkPDw8wVfahaIB15
	5aXD6hjc6aUCYmLd2B/HA/4=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hBzxT58sxzRhQt;
	Sat,  1 Aug 2026 18:41:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FECC4056E;
	Sat,  1 Aug 2026 18:50:29 +0800 (CST)
Received: from kwepemq500013.china.huawei.com (7.202.195.103) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 1 Aug 2026 18:50:29 +0800
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemq500013.china.huawei.com (7.202.195.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 1 Aug 2026 18:50:28 +0800
Subject: Re: [PATCH -next,v3] ima: add cond_resched() in
 ima_calc_file_hash_tfm loop
To: Eric Biggers <ebiggers@kernel.org>
CC: <lujialin4@huawei.com>, <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>
References: <20260728123350.2751590-1-cuigaosheng1@huawei.com>
 <20260728171414.GA3355536@google.com>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <0c590f6c-8ab0-f0ed-25a8-fa8a2ec6008e@huawei.com>
Date: Sat, 1 Aug 2026 18:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260728171414.GA3355536@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500013.china.huawei.com (7.202.195.103)


On 2026/7/29 1:14, Eric Biggers wrote:
> On Tue, Jul 28, 2026 at 08:33:50PM +0800, Gaosheng Cui wrote:
>> When hashing large files, the while loop in ima_calc_file_hash_tfm
>> processes PAGE_SIZE chunks without any scheduling point, which can
>> cause soft lockup warnings:
>> watchdog: BUG: soft lockup - CPU#0 stuck for 50s!
>> Call Trace:
>>    _sha256_update+0x12d/0x1a0
>>    ima_calc_file_hash_tfm+0xfb/0x150
>>    ima_calc_file_hash+0x6e/0x160
>>    ima_collect_measurement+0x202/0x340
>>    process_measurement+0x3a9/0xb30
>>    ima_file_check+0x56/0xa0
>>    do_open+0x11b/0x250
>>    path_openat+0x10b/0x1d0
>>    do_filp_open+0xa9/0x150
>>    do_sys_openat2+0x223/0x2a0
>>    __x64_sys_openat+0x54/0xa0
>>    do_syscall_64+0x59/0x110
>>    entry_SYSCALL_64_after_hwframe+0x78/0xe2
>>
>> Call cond_resched() every 4MB to yield the CPU when needed, rather
>> than at every loop iteration, to reduce overhead.
>>
>> Using IS_ALIGNED(offset, SZ_4M) to trigger cond_resched() is fragile
>> because integrity_kernel_read() -> __kernel_read() can return fewer
>> bytes than requested (short read). Short reads can occur across
>> various filesystems — while common on remote (NFS, CIFS) and FUSE
>> filesystems, they are also possible in edge cases on local
>> filesystems (e.g., reading near EOF). Once a short read occurs,
>> the offset becomes permanently misaligned and cond_resched() may
>> never be called again for the remainder of the file. Replace the
>> alignment check with a cumulative byte counter that tracks the
>> actual data hashed since the last reschedule point, which is robust
>> regardless of short read behavior.
>>
>> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> Which architecture are you seeing this issue on, and which kernel
> version?  In current mainline, most architectures (x86, arm64,
> loongarch, riscv, s390) offer only lazy preemption and full preemption.
> In all these cases, cond_resched() is obsolete and unnecessary.
>
> I understand the concept of cond_resched() as a whole is on its way out.
> It is an approach that has never worked well.
>
> Is it possible that you're seeing this issue only on an older kernel
> version and not mainline?
>
> - Eric
> .

Thanks for the clarification and the context on the preemption model direction.

I encountered this soft lockup on the 6.6 stable kernel with PREEMPT_VOLUNTARY
(arm64 and x86_64), where ima_calc_file_hash_tfm() can spin for tens of seconds
on large files without any preemption point, starving the watchdog's migration thread.
I verified on linux-next 7.2.0-rc4 (x86_64, PREEMPT_LAZY) that the issue is not
reproducible, so mainline does not need this fix.

Thank you for the insight.

