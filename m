Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3425A2CF;
	Tue, 25 Mar 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921385; cv=none; b=GiBiDukrDkP3JP9UQHaHa79gVE5lMtYvQZ27fPZE3OhXub4NIVFrXlAc1kYwWHiZmXfvaoqOClF1gl4J02cYOy3CsNc1kd8Jem33LIC+7kgmwYg78rSPCZA0L6RZ0VGXjC+PwVrjZsbkRER7msKXaeBldqX4r4Eqk5dp5G+QyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921385; c=relaxed/simple;
	bh=zoU3gwFolxp7eipK1+P+Baqd3/1sqUEWtu2YpZVO8AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTo0ypb9H8c11lAKOA0aGleH0ya7YRwk5VmF7XNmInVW9ZHNd895WC8O3f48BQ4CkcDW5sZpP9i/NEw0xPlCuVGulgHyzzCfY72DamjNI4H2KqyLyTBhkt2bL3E84G2uAAqaFhJINkNnl9ExEkiZJmo4OPsVTL2cKX4/MJqk8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZMb4W74V5z1HBQX;
	Wed, 26 Mar 2025 00:30:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DA684140392;
	Wed, 26 Mar 2025 00:30:44 +0800 (CST)
Received: from [10.221.98.126] (unknown [10.221.98.126])
	by APP1 (Coremail) with SMTP id LxC2BwDHS0or2uJn7PTYBA--.47295S2;
	Tue, 25 Mar 2025 17:30:44 +0100 (CET)
Message-ID: <ed260472-c07e-4172-b389-deb8e92f416f@huaweicloud.com>
Date: Tue, 25 Mar 2025 17:30:32 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
 James Morris <james.l.morris@oracle.com>, "Serge E. Hallyn"
 <serge@hallyn.com>, linux-ima-devel@lists.sourceforge.net,
 linux-ima-user@lists.sourceforge.net, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-team@cloudflare.com
References: <20250325155934.4120184-1-fred@cloudflare.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20250325155934.4120184-1-fred@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDHS0or2uJn7PTYBA--.47295S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFWkGF17KFWDCFW5Kw17Wrg_yoW8CFWfpa
	1ktF48Ar1UKFyakry7Jan0yrZ5G3ykKr4UJw15ZF1UAan5XF1vvrZ0y3Wj9ryfXrnYy34S
	qa1agrW3Aan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgASBGfiVdoI3gABsJ

On 3/25/2025 4:58 PM, Frederick Lawler wrote:
> On IMA policy update, if a measure rule exists in the policy,
> IMA_MEASURE is set for ima_policy_flags which makes the violation_check
> variable always true. Coupled with a no-action on MAY_READ for a
> FILE_CHECK call, we're always taking the inode_lock().
> 
> This becomes a performance problem for extremely heavy read-only workloads.
> Therefore, prevent this only in the case there's no action to be taken.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>   security/integrity/ima/ima_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2aebb7984437..78921e69ee14 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>   	action = ima_get_action(inode, mask, func, &pcr);
>   	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>   			   (ima_policy_flag & IMA_MEASURE));
> -	if (!action && !violation_check)
> +	if (!action && (mask == MAY_READ || !violation_check))
>   		return 0;

Hi Frederick

thanks, nice catch!

Thinking... in fact you are saying that there are conditions for which 
ima_rdwr_violation_check() does nothing.

For better clarity, I would add the conditions for which we are doing a 
violation check in violation_check directly. So that, one can just go to 
the function and see that in fact nothing special is done other than 
doing the same checks in advance before taking the lock (the conditions 
you are checking on are immutable, so it is fine).

So, it is not a write, and the file is not being measured (this would be 
a bit redundant given that we are checking anyway !action).

Thanks

Roberto

>   	must_appraise = action & IMA_APPRAISE;

