Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596571;
	b=dmE+rR1q5UvkXWIXyFzKMORQyiWPSx7LmKdG8DGZ6GTksZHulFItX941KVLcvD/j+GC3
	 RKsvH56Kso+byDs0mScCEd2fcYA631Tih7NQFiL7Fmd7nDj3SqX2uO0PVbKunWjjw7u1X
	 sGvku6Vl4o5r7odyqdbyUHQfP0M4zf6JfCUVqHJLz2TdeYTle6jUa1hFk8p2QLmu72JsG
	 RzanJlgVyDeXD8qQCaZJgJJE7SNaWdbG8plKiLSuLv9agD/UoQaCJqDPgBmKKvUtTRTVW
	 4MyMtRCBznHq3oR8znwWrd/XirRCMYOLAubjkXvJMDuTXg79barEO5DDXSJJTBd6HjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596571;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=06PO7r5fywxUcb1upikYj195xr8JzyPRVP1dBZO2gWM=;
	b=fwJnUZ8rJklD1/73oD2ThFNf++Mff1iKUQiSXuDT++LZ1QlG001Ff5o2y5EXvNiClVW/
	 /hrcQiJhdPPVoS0NsjPKAiNdvcUfDzMfUNM+1+5h+O50SdDMDDkOt3UkjrTylvobMHcdp
	 ieGEWRDvvwUvGt+oEWG7k48GnpWqdnKWkYhoWHJ3qhC62Vjm+5Z6WwvGAE4cu1AYHIici
	 0WaY69ElbjRYv882Px0ZBqc/4B4SN8+vRxIuP76EnQG4Mw4CCqs6+oz5NiaJfXaFLhC8f
	 HL56tQ6uI+YbFfNz8Mv1L5d/WQF00pG3f/UAResWCT0HifQ4yza5fZzlnfoRICI2aYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JO6GoKUr;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307CD606A326;
	Wed, 25 Nov 2026 08:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JO6GoKUr
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=06PO7r5fywxUcb1upikYj195xr8JzyPRVP1dBZO2gWM=;
	b=JO6GoKUrYIQ1Q/CtomcPhUsGSMJNu09OP53TAY4OZ8LFILvTKj0c2EVoGl1PyxEefItW6XMFm
	gXXRBQz912EBRwKwl/EJPKZR0G9imlYG8ylzqbtp3wTOkLRNNuYUFoqwcxg23bv45VFb8Ri2htX
	MEE/k1BPuGN7EbJIahNz43A=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jZCy70pPpz1T4Gk;
	Wed, 25 Nov 2026 16:48:31 +0800 (CST)
Received: from kwepemk300018.china.huawei.com (unknown [7.202.194.246])
	by mail.maildlp.com (Postfix) with ESMTPS id C6AE64057D;
	Wed, 25 Nov 2026 16:49:20 +0800 (CST)
Received: from [10.34.206.67] (10.34.206.67) by kwepemk300018.china.huawei.com
 (7.202.194.246) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 16:49:20 +0800
Message-ID: <dfb1128d-feef-4729-b31c-a52f937dd92b@huawei.com>
Date: Wed, 25 Nov 2026 16:49:19 +0800
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next -v2 2/8] lockdown: remove useless decrement
 operation
To: Cai Xinchen <caixinchen1@huawei.com>,
	<nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-3-caixinchen1@huawei.com>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20261110132818.2231593-3-caixinchen1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk300018.china.huawei.com (7.202.194.246)

On 11/10/2026 9:28 PM, Cai Xinchen wrote:
> From: Kalevi Kolttonen <kalevi@kolttonen.fi>
> 
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Nit: checkpatch.pl warns on this patch, it's better to have a commit 
description.

> ---
>   security/lockdown/lockdown.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 263dcc80d839..8648508d49b2 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -130,10 +130,8 @@ static ssize_t lockdown_write(struct file *file, const char __user *buf,
>   		return PTR_ERR(state);
>   
>   	len = strlen(state);
> -	if (len && state[len-1] == '\n') {
> +	if (len && state[len-1] == '\n')
>   		state[len-1] = '\0';
> -		len--;
> -	}
>   
>   	for (i = 0; i < ARRAY_SIZE(lockdown_levels); i++) {
>   		enum lockdown_reason level = lockdown_levels[i];

