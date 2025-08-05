Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1A221710;
	Tue,  5 Aug 2025 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377049; cv=none; b=mnvOwD1O8oJY2qHPAk+k5bFucqQb8tI1Fi2tDgA0MKVTRwHv5Ru4d0hRZ0on1W/gpHoL7mz1abcbrHp26sK9Mn5Gl5i6aak+wrS6bo3Lf/wWsKQ0CWK7HjUZ0g21olZDIoiBbZThKXwD5GBtq1CqKMu9Va1tUUIOAp/zi0wkqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377049; c=relaxed/simple;
	bh=eBwIi8kiuq4Hr6QR0KApYpwSO5nTRiqpl2duBh2TT/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=psuhv4rne224MviWnH5hM7BYvSIvZP6/SKenwZWzkGLlqeXzGDhVpnOzA+tyHOzN6fNF700hz71cHXuQZezYO3tzM2qfx8EvtLxOECihKFZZ/u/p5+vnEW7ZZ+D+YwgWceqIwMKOeajT58dXF/PLnmcQZmMh6zJz+++r6h1yzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bx40L6WC5z13N2q;
	Tue,  5 Aug 2025 14:54:10 +0800 (CST)
Received: from kwepemg500012.china.huawei.com (unknown [7.202.181.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 95DA21401F3;
	Tue,  5 Aug 2025 14:57:24 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 kwepemg500012.china.huawei.com (7.202.181.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 14:57:23 +0800
Message-ID: <42b2cf1b-417e-1594-d525-f4c84f7405b0@huawei.com>
Date: Tue, 5 Aug 2025 14:57:23 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Content-Language: en-US
To: Nikolay Borisov <nik.borisov@suse.com>, Nicolas Bouchinet
	<nicolas.bouchinet@oss.cyber.gouv.fr>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <jmorris@namei.org>,
	<dan.j.williams@intel.com>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
 <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <9b6fd06e-5438-4539-821c-6f3d5fa6b7d1@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg500012.china.huawei.com (7.202.181.74)



On 2025/7/29 20:25, Nikolay Borisov wrote:
> 
> 
> On 29.07.25 г. 15:16 ч., Nicolas Bouchinet wrote:
>> Hi Nikolay,
>>
>> Thanks for you patch.
>>
>> Quoting Kees [1], Lockdown is "about creating a bright line between
>> uid-0 and ring-0".
>>
>> Having a bitmap enabled Lockdown would mean that Lockdown reasons could
>> be activated independently. I fear this would lead to a false sense of
>> security, locking one reason alone often permits Lockdown restrictions
>> bypass. i.e enforcing kernel module signature verification but not
>> blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
>> used to disable the module signature enforcement.
>>
>> If one wants to restrict accesses to `/dev/mem`,
>> `security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.
>>
>> My understanding of your problem is that this locks too much for your
>> usecase and you want to restrict reasons of Lockdown independently in
>> case it has not been enabled in "integrity" mode by default ?
>>
>> Can you elaborate more on the usecases for COCO ?
> 
> Initially this patchset was supposed to allow us selectively disable
> /dev/iomem access in a CoCo context [0]. As evident from Dan's initial
> response that point pretty much became moot as the issue was fixed in a
> different way. However, later [1] he came back and said that actually
> this patch could be useful in a similar context. So This v2 is
> essentially following up on that.

Hi Nikolay,

I share a similar view with Nicolas, namely that using a bitmap
implementation would compromise the goal of Lockdown.

After reading the threads below, I understand you aim is to block user
access to /dev/mem, but without having Lockdown integrity mode enabled
to block other reasons, right? How about using BPF LSM? It seems it
could address your requirements.

> 
> 
> [0]
> https://lore.kernel.org/all/67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch/
> 
> [1]
> https://lore.kernel.org/all/68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch/
> 
> <snip>
