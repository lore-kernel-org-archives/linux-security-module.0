Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB37D531
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624913; cv=none; b=YpxJq9EhggzsJQbCiJ/XGs644iAKo4WPuihxe/5YZw54LjVCPmnHecwHUaQ5qaqMi+XTrTpedDI/CpfLzEILzPztV3lEoFgrMZZkhe++RNqYJCBkS1ot2SUj2ec8/vzzZ5yKK2mRvRDynEHAoUMzBDCocxT+VSwtJ8hSDm7XwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624913; c=relaxed/simple;
	bh=r9wClB51F2lPi4DQas4wk9bbKqWrRQjUvZ8+VghAvks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VEja3C1pu1+mkXhv4Io4NBj3Wl/l3Ikijg6+DNKk40qJ4lNABGuIf/BW61LJrfWG33/RWSQBtIkXeTlunkAmn+UkSYH07ak2atmdttdg8+vrqR1Kd7+sYWweob+89KbomoLxUREBeosWzE6bYwG05E+oNFsJZd1ZzMIknWqv4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QOFQgnVM; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QOFQgnVM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HVfnFAQ+H7+aB0DuSl+sAkv4iLX4WTySOmaMjw9WVRc=;
	b=QOFQgnVMIVJ0QZ1MS5T1KIcI8u3KeXcHfXKL3AHmxSazupim/vNzuqoW7PAzwPVNtcYvKcVsf
	+0JQ8vT30saBhHM0SjI9RYBVnb4Q/nMxvpSBrv9aQZ0y0q2SV72WazGS2E1E7CFQAMeXRryJvGY
	ikA+nAnAKREPfV0yj/HY8pM=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dBr5Z1H0QzKm6B;
	Thu, 20 Nov 2025 15:46:42 +0800 (CST)
Received: from kwepemj100004.china.huawei.com (unknown [7.202.195.249])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC68140277;
	Thu, 20 Nov 2025 15:48:26 +0800 (CST)
Received: from [10.34.206.51] (10.34.206.51) by kwepemj100004.china.huawei.com
 (7.202.195.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Nov
 2025 15:48:26 +0800
Message-ID: <f3631b3b-4461-4176-9178-27fa1dc66226@huawei.com>
Date: Thu, 20 Nov 2025 15:48:25 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lsm: use unrcu_pointer() for current->cred in
 security_init()
To: Paul Moore <paul@paul-moore.com>, <linux-security-module@vger.kernel.org>
References: <20251119153636.15243-2-paul@paul-moore.com>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20251119153636.15243-2-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100004.china.huawei.com (7.202.195.249)



On 11/19/2025 11:36 PM, Paul Moore wrote:
> We need to directly allocate the cred's LSM state for the initial task
> when we initialize the LSM framework.  Unfortunately, this results in a
> RCU related type mismatch, use the unrcu_pointer() macro to handle this
> a bit more elegantly.
> 
> The explicit type casting still remains as we need to work around the
> constification of current->cred in this particular case.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   security/lsm_init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 6bb67d41ce52..05bd52e6b1f2 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -467,7 +467,8 @@ int __init security_init(void)
>   						    blob_sizes.lbs_inode, 0,
>   						    SLAB_PANIC, NULL);
>   
> -	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
> +	if (lsm_cred_alloc((struct cred *)unrcu_pointer(current->cred),
> +			   GFP_KERNEL))
>   		panic("early LSM cred alloc failed\n");
>   	if (lsm_task_alloc(current))
>   		panic("early LSM task alloc failed\n");

