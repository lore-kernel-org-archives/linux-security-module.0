Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF87143C61
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524178; cv=none; b=uYRTzQD5moYNQHJXyU3wKhuIurSewHGg4IwgehXprX6Qi/o0YbjHS2vAI4oP3cRTNViR0l9vl2BNAqBiBV1PVQ4PjY81afQEPvRNmWnXuRapCEc/29KeeLidVTIjQDwLd/A8sXcD1VEiwtrL/RRV6ReR8Pafm4o42I3dIc092T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524178; c=relaxed/simple;
	bh=i6AO1pntvPQPQp19tjxoWVc0qyMcT1HUcByjchxi+gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WgI3If+pyvtdKetj/lQ56cTVa+9c8RZvCj04IdrX7k/pnuxmCdWnv7AY2Z3+6fGk3aEYAGj9vr3c4EM9Abf/B5Xmp1oC41qREZRAtjM041jdbwSbKnsQ10502elIGP9iaz0Die1WPViUmwwtzoHW18aVdiOLOKrhlwgZ4eojOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dB6sr3JNJzKHMKJ
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 11:49:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 124F21A08AE
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 11:49:32 +0800 (CST)
Received: from [10.34.206.51] (unknown [10.34.206.51])
	by APP2 (Coremail) with SMTP id Syh0CgCXQHdKPh1p_lEABQ--.728S2;
	Wed, 19 Nov 2025 11:49:32 +0800 (CST)
Message-ID: <5508241d-7c8f-4caa-a62e-3d8eb2426b55@huaweicloud.com>
Date: Wed, 19 Nov 2025 11:49:30 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsm: use unrcu_pointer() for current->cred in
 security_init()
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
References: <20251119002808.444259-2-paul@paul-moore.com>
From: Xiujianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <20251119002808.444259-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCXQHdKPh1p_lEABQ--.728S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZF4kWw17XF1rJFy3JrWfuFg_yoW8Jry3pF
	WvgF4vkry8AFZ29rsrGr4xKryaka95ur45GrZxuwnFvasxKrn8ur4UJFWUZr45u3ykGa4S
	qF4IqF93Gw1UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi Paul,

On 11/19/2025 8:28 AM, Paul Moore wrote:
> We need to directly allocate the cred's LSM state for the initial task
> when we initialize the LSM framework.  Unfortunately, this results in a
> RCU related type mismatch, use the unrcu_pointer() macro to handle this
> a bit more elegantly.
> 
> The explicit type casting still remains as we need to work around the
> constification of current->cred in this particular case.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>   security/lsm_init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 6bb67d41ce52..4dec9199e4c2 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -467,7 +467,8 @@ int __init security_init(void)
>   						    blob_sizes.lbs_inode, 0,
>   						    SLAB_PANIC, NULL);
>   
> -	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
> +	if (lsm_cred_alloc(unrcu_pointer((struct cred __rcu *)current->cred),
> +			   GFP_KERNEL))

Since the casting from const to non-const is inevitable, why not
directly cast it to (struct cred *)?

>   		panic("early LSM cred alloc failed\n");
>   	if (lsm_task_alloc(current))
>   		panic("early LSM task alloc failed\n");

