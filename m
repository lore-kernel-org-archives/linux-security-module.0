Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CD274B35;
	Thu, 20 Nov 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624286; cv=none; b=E4rdY9dlKMQZIVg6yGgvGaihPRdPIvOfSmSb9sV2T5NMsyw6RkoHz+zYg4um/s2k/neVEHR8uDdLcfysJ4izbBMLLoD9Lm+4ZSnC6wixSzmTILC9nC3z0t+Jq6MCIVA3Yh1ATg4NK/3qgDEJzqJaTWG8nVHE5H1POzxWzd62ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624286; c=relaxed/simple;
	bh=qYdDkXHbx0lJWnNN3/63WZtR2QjIKfQ6W753xg2FgBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWx0ol8SR8daVuu/l5dAzjn6KSwSckB4cFtG7TAmjTXqEgttWx59ebbQnSGr6CxfSekmh1VMJF54xQSkLSuFhOjRNb7CwsLmZIv52VBSxkIEGIwtzh5a11Pm4PxSi1AlPp0QieMeUx5rYWEYYGphcRKmnwUvpmKoANXMLb5kESM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBqtx0z02zKHMbW;
	Thu, 20 Nov 2025 15:37:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 76ABF1A0B65;
	Thu, 20 Nov 2025 15:37:58 +0800 (CST)
Received: from [10.34.206.51] (unknown [10.34.206.51])
	by APP2 (Coremail) with SMTP id Syh0CgCXQHdVxR5pdBaHBQ--.18135S2;
	Thu, 20 Nov 2025 15:37:58 +0800 (CST)
Message-ID: <2f4a1af8-adc6-4cbc-813f-4cc8e9bc75ae@huaweicloud.com>
Date: Thu, 20 Nov 2025 15:37:56 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lockdown: Only log restrictions once
To: Daniel Tang <danielzgtg.opensource@gmail.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>,
 Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
 James Morris <jmorris@namei.org>
References: <3641397.L58v44csPz@daniel-desktop3>
 <CAHC9VhQNGnm6NBSrUmfwoEwAxqedYbHckEkb+J47W5gWjrKBOA@mail.gmail.com>
 <1961790.USuA9gRusQ@daniel-desktop3>
From: Xiujianfeng <xiujianfeng@huaweicloud.com>
In-Reply-To: <1961790.USuA9gRusQ@daniel-desktop3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXQHdVxR5pdBaHBQ--.18135S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW5Ar1ruw4DXFyxXF18Zrb_yoW8Zry3pa
	10gFy2qr42vFy7XF1xtr43XF4UG398Gr17JFy5Gr47tFn8WrnxXr1xtFyDCa17GrZ3Zrn8
	tryqga9xuw1qqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi Daniel,

On 11/20/2025 2:07 AM, Daniel Tang wrote:
> KDE's lockscreen causes systemd-logind to spam dmesg about hibernation.
> systemd declined to cache /sys/power/state due to runtime changeability.
> 
> Link: https://github.com/systemd/systemd/pull/39802
> Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
> ---
>   security/lockdown/lockdown.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index cf83afa1d879..83b50de52f21 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -58,13 +58,16 @@ early_param("lockdown", lockdown_param);
>    */
>   static int lockdown_is_locked_down(enum lockdown_reason what)
>   {
> +	static volatile unsigned long lockdown_reasons_seen;
> +	static_assert(ARRAY_SIZE(lockdown_reasons) < sizeof(lockdown_reasons_seen) * 8);
> +
>   	if (WARN(what >= LOCKDOWN_CONFIDENTIALITY_MAX,
>   		 "Invalid lockdown reason"))
>   		return -EPERM;
>   
>   	if (kernel_locked_down >= what) {
> -		if (lockdown_reasons[what])
> -			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
> +		if (lockdown_reasons[what] && !test_and_set_bit(what, &lockdown_reasons_seen))
> +			pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
>   				  current->comm, lockdown_reasons[what]);

Currently lockdown does not support the audit function, so I believe the
logs here serve a purpose similar to auditing. Based on this, I think
this change will meaningfully degrade the quality of the logs, making it
hard for users to find out what happens when lockdown is active，
especially after a long time running.

Is it possible to adjust the printk_ratelimit & printk_ratelimit_burst
in /proc/sys/kernel/ to reduce the logs in your scenario?

Anyway, I will wait for Nicolas's comment.
>   		return -EPERM;
>   	}

