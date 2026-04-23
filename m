Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F7191F84;
	Thu, 23 Apr 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776909174; cv=none; b=XOJwrfQ+aCGIVrV6NRKXRGWneb7Ox0DBtVc5KYFFaBcIO5TOXmt1zx6TdX7c/ntLbz/CJQPocSsD646z9DquYaLU1O8x39NGqygh6YTsy1eEd4XkehpUEL72kL/17tpcHE8Gz9azRDOnXjZBdERDPPUOz7fPf8tKA7PSRNjf4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776909174; c=relaxed/simple;
	bh=0W+csMXC7HjZ5kmsWP8/5KngV6al4HnbZW7+ndmJ4zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDwNDzbFlDmWF9/JS5IkExU7NvhzXiJDl2xI8e+o2ulxFCUCg/eT9KwKSQAnpNkA7h7SxGNv9qyNpJNwJYg4ftc5/6/nhPNMpt4HSZYmOQcdjwLbq863XGVLMLleL4P8GBYuhMaVQP+ERz8bar5I2utayA33bD065FSz7ryH3OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ulNU9Q7X; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ulNU9Q7X; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ulNU9Q7X";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ulNU9Q7X"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QjVoapmA6eCEER6DNFDJcYCiww5xLhiLyifdfAzhYUk=;
	b=ulNU9Q7XXknrmiYtBINRNGfWv5mcILMASEydzduEnDZZwHDbpWeUq5jlgnB4lDVLA+4trdx7b
	AzIrBxiGJqNDcUNPUrLaUXYUaSPCHkA1RIOMDM7k31I8XyfAtp9cdL5tYAT1R92PlXKoDfY+wbA
	RpedlSkY6WOjXBhNIu8ejp8=
Received: from canpmsgout08.his.huawei.com (unknown [172.19.92.156])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4g1Jwy0DN1z1BG4g;
	Thu, 23 Apr 2026 09:51:46 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QjVoapmA6eCEER6DNFDJcYCiww5xLhiLyifdfAzhYUk=;
	b=ulNU9Q7XXknrmiYtBINRNGfWv5mcILMASEydzduEnDZZwHDbpWeUq5jlgnB4lDVLA+4trdx7b
	AzIrBxiGJqNDcUNPUrLaUXYUaSPCHkA1RIOMDM7k31I8XyfAtp9cdL5tYAT1R92PlXKoDfY+wbA
	RpedlSkY6WOjXBhNIu8ejp8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g1JpQ0gYrzmV7c;
	Thu, 23 Apr 2026 09:46:06 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9659E402AB;
	Thu, 23 Apr 2026 09:52:30 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Apr
 2026 09:52:30 +0800
Message-ID: <923f5188-a3b3-45cf-8b28-37f77a34544c@huawei.com>
Date: Thu, 23 Apr 2026 09:52:29 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix two bugs of aa_setup_dfa_engine's fail
 handling
To: Georgia Garcia <georgia.garcia@canonical.com>, John Johansen
	<john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James Morris
	<jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>, zhaoyipeng
	<zhaoyipeng5@huawei.com>
References: <20260403035119.2132418-1-gongruiqi1@huawei.com>
 <1b87ab3652ca165364e1bb86623f2b26a135dae7.camel@canonical.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <1b87ab3652ca165364e1bb86623f2b26a135dae7.camel@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100018.china.huawei.com (7.202.194.66)

Hi Georgia,

On 4/23/2026 5:51 AM, Georgia Garcia wrote:
> ...
>> @@ -2486,7 +2487,6 @@ static int __init aa_setup_dfa_engine(void)
>>  
>>  fail:
>>  	aa_put_pdb(nullpdb);
>> -	aa_put_dfa(nulldfa);
> 
> This isn't right. aa_dfa_unpack does kref_init(&dfa->count), and later
> we have nullpdb->dfa = aa_get_dfa(nulldfa);
> So the second is put on aa_put_pdb but the first, from the init, does
> need to be put too.

Thanks for the feedback, and yes you're right. I didn't notice there's a
kref_init in aa_dfa_unpack...

I will submit a patch that only contains the first fix.

BR,
Ruiqi

> 
>>  	nullpdb = NULL;
>>  	nulldfa = NULL;
>>  	stacksplitdfa = NULL;
> 

