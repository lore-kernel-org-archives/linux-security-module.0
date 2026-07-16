Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740163AA1BF;
	Thu, 16 Jul 2026 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784186989; cv=none; b=B95fdjB0y8FcFS3D3XyjLS3kxeVJahCd8hT0SVWqhjLs9XhiqtFb85AD3m80TZRr76aGKDiGVOScEgjaMVr7PDl66TvvUX1D4BwqSgVNBSF/m7hWsxUfTHXZPuSqK5osMaERk8DdUSgPDJBncm3LcxsWFpSTI/EiQM+JBAaFWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784186989; c=relaxed/simple;
	bh=jOspFsn9RWqd4RO+5Lg48YoXIYnKBFJeZ7juQ3BdMvk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qGw6H7NpUB+UCVqwVp+q5YsPwfWS8mjQjWyCG6Wgase7Lhr7OYbsZ7r3vzBbEBih+89WsLAsP61ftQ0bq2EcGovzBdZI8jSuSZha0OnCCpuKye/cFguwIBb+5QEe7bZgjfoa2Akj1kaFQvl7aKdlshyTRA2siS8tDiFvoaotknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4h14K33gwjzpTKt;
	Thu, 16 Jul 2026 15:23:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AE46640577;
	Thu, 16 Jul 2026 15:29:41 +0800 (CST)
Received: from [10.45.154.222] (unknown [10.45.154.222])
	by APP2 (Coremail) with UTF8SMTPA id GxC2BwAXKAZciFhqGmi+AA--.8840S2;
	Thu, 16 Jul 2026 08:29:41 +0100 (CET)
Message-ID: <f6ecaaf1-e226-42a5-91f9-37ecce66a5d4@huaweicloud.com>
Date: Thu, 16 Jul 2026 09:29:30 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next,v2] ima: add cond_resched() in
 ima_calc_file_hash_tfm loop
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gaosheng Cui <cuigaosheng1@huawei.com>, lujialin4@huawei.com,
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20260714091708.2802272-1-cuigaosheng1@huawei.com>
 <e6270a062ebfdbc6d9e50ffe80ee5e77b4f0678c.camel@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <e6270a062ebfdbc6d9e50ffe80ee5e77b4f0678c.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwAXKAZciFhqGmi+AA--.8840S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF15Jw13AFyDWF15uw13CFg_yoW8Krykpa
	9agayvkrWqyryUuFsrKas3tF18C3yxJFy3WrZ5tryUJF90vr1vvry7Ar4YgryfCr1Fyw1r
	tayqgryDA3Wqy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGpYT0YRDwABsx

On 7/14/2026 11:26 AM, Roberto Sassu wrote:
> On Tue, 2026-07-14 at 17:17 +0800, Gaosheng Cui wrote:
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
>> Fixes: 3323eec921ef ("integrity: IMA as an integrity service provider")
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> 
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Actually, as Sashiko pointed out, alignment does not work well, since 
__kernel_read() can return fewer than PAGE_SIZE bytes, causing the 
offset to be always misaligned. Instead, we can keep a variable with the 
number of bytes read since last cond_resched(), which we reset when we 
hit 4 MB.

Sashiko also noted that the same mechanism could apply for 
calc_buffer_shash_tfm(), but we can add it later if we have a warning 
(note that in this case we already have the buffer, we are not doing
I/O).

Thanks

Roberto

> Thanks
> 
> Roberto
> 
>> ---
>> v2: call cond_resched() every 4MB to yield the CPU when needed
>>   security/integrity/ima/ima_crypto.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
>> index 0d72b48249ee..aab2349c0c33 100644
>> --- a/security/integrity/ima/ima_crypto.c
>> +++ b/security/integrity/ima/ima_crypto.c
>> @@ -233,6 +233,9 @@ static int ima_calc_file_hash_tfm(struct file *file,
>>   		rc = crypto_shash_update(shash, rbuf, rbuf_len);
>>   		if (rc)
>>   			break;
>> +
>> +		if (IS_ALIGNED(offset, SZ_4M))
>> +			cond_resched();
>>   	}
>>   	kfree(rbuf);
>>   out:
> 

