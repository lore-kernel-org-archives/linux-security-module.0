Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFF1D95A9
	for <linux-security-module@vger.kernel.org>; Wed,  6 Nov 2024 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885260; cv=none; b=b4dGHQvOcUEXAlISc+iie18veM9NX4qGkXU45aQGNv4NhAyMKLdq0BWUHG/oiR1ZooEJxrKSoHGgTy5E4j5FobHcYmmI5mkpVKkfyZ0JyDFy5qsqZpmKymA5Ua8LbMtBMcqJRNmfCV229hcILbx8RqOZBC36xwvgjM94vid7eDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885260; c=relaxed/simple;
	bh=IlQRW+U0HT9WXPAc0PCiZNtPDCwhANWE5HP76BZjEc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eDBPFPZdflSvAir9HHyJqPmXF1smtbuK3KrrR/xfBHnxhOZ9cKmyEiogzNovyzK3D2gGxmoxY9uieXBbpUw1nSEJYaGYIj6tqme5rxipSIqdyHbfOwNL1w2klJeDUhEg7PY2nsIErBVx908ml/T0LMd6+DBXyZ+0nGuUjYEHKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xk0Gk1CfZz6LD8d;
	Wed,  6 Nov 2024 17:27:26 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A5E2140B3C;
	Wed,  6 Nov 2024 17:27:28 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 6 Nov 2024 12:27:27 +0300
Message-ID: <1b51f713-0ee1-91e5-6c51-2763464e7ac5@huawei-partners.com>
Date: Wed, 6 Nov 2024 12:27:25 +0300
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/8] landlock: Fix inconsistency of errors for TCP
 actions
Content-Language: ru
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, <mic@digikod.net>,
	<gnoack@google.com>
CC: <linux-security-module@vger.kernel.org>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-4-ivanov.mikhail1@huawei-partners.com>
 <6be6d6dc-ab48-4399-8460-2b82dfb59742@I-love.SAKURA.ne.jp>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <6be6d6dc-ab48-4399-8460-2b82dfb59742@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 10/17/2024 3:48 PM, Tetsuo Handa wrote:
> On 2024/10/17 20:04, Mikhail Ivanov wrote:
>> +#endif /* IS_ENABLED(CONFIG_IPV6) */
>> +	default:
>> +		WARN_ON_ONCE(0);
> 
> WARN_ON_ONCE(0) is pointless.

thanks! will be fixed

> 
>> +		return -EACCES;
>> +	}
> 
