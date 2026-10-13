Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6D4FD279;
	Tue, 13 Oct 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896748; cv=none; b=AC+t1mwAa0zGdM6bQK1JF1Xs8QlPbhJ6cb5n4/eT57xbHS/U3/5t9tS/OhcXzGbDB1cPG/rV1Pmxxivmk4nw8+pX/HlQUxSptW1KXaDT71KdKV6bDiKs3wq4QKMG7d0pmwRkYTVAXD+68UyURZlwkQDHy978sff94tXrQ5kHGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896748; c=relaxed/simple;
	bh=XLVDDsJ9SkLDOPsRoHBlkN1g12Muht7f6+awpZoSXhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bhfQhN9xikyVLan1IQ50lV+T3JTVSQ0tDsHdnRh8bNnJb0Rit2JEFfM1oegD5H9H/pvd9q8VoCfjkQaI0KDykjbxuVOF27d631MWwxSLh7wijGbsxNL1BzdHDK3RTixve5O89wGVsEplrw+Kc3Aw5qjmWjBs52pb6Bn5ThTOR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6F7V5ju2; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6F7V5ju2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wYQuXQ0KfHa17CDRJUy3J57K/iJLMTM6lvkW2CcSDiQ=;
	b=6F7V5ju2QgWQ9eZjW3MED7pvYgSKl/itfkouUmXO5AnPvg4CViMZ+cJbrkHhH87RerZ3E2r8M
	GCZPwWzNbKZLEmW98TNci7+YUNiTmHaBGjPkmvgfhRB6SvQAAfJuoDmaTpgxKg9SY9c6ir2ICg/
	saTm5ZL2eP+7OY3gxwfW1xg=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j3vQQ6Q24zKm4b;
	Tue, 13 Oct 2026 20:53:18 +0800 (CST)
Received: from kwepemo100015.china.huawei.com (unknown [7.202.195.69])
	by mail.maildlp.com (Postfix) with ESMTPS id 17A474055B;
	Tue, 13 Oct 2026 21:05:40 +0800 (CST)
Received: from [10.67.111.244] (10.67.111.244) by
 kwepemo100015.china.huawei.com (7.202.195.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 13 Oct 2026 21:05:39 +0800
Message-ID: <1451a49c-f37a-486f-ac47-e2ff86fef28a@huawei.com>
Date: Tue, 13 Oct 2026 21:05:37 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] security: ima: support TSM measurement registers
To: Yeoreum Yun <yeoreum.yun@arm.com>
CC: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Eric Snowberg
	<eric.snowberg@oracle.com>, <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, Dan Williams <djbw@kernel.org>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Suzuki
 Poulose <suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>, Sami
 Mujawar <sami.mujawar@arm.com>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
References: <20260930-ima_tgx_integration_v2-v1-0-722c35370548@arm.com>
 <ebe68f6463f8ece8a5cd8ce70bba292ec4f64a41.camel@huaweicloud.com>
 <c4fe5315d70fc162f1e5648e3fccb1676710d5e6.camel@huaweicloud.com>
 <ar5tOUor0bp3MtQ6@e129823.arm.com>
 <9e74ff9d-e8a3-425e-bf7c-f973d06e6cdf@huawei.com>
 <as3uzQ7L6tJ-Lu-Q@e129823.arm.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <as3uzQ7L6tJ-Lu-Q@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100015.china.huawei.com (7.202.195.69)

On 10/13/2026 4:41 PM, Yeoreum Yun wrote:
>> On 10/1/2026 10:24 PM, Yeoreum Yun wrote:
>>> Hi Roberto,
>>>
>>>> On Thu, 2026-10-01 at 13:27 +0200, Roberto Sassu wrote:
>>>>> On Wed, 2026-09-30 at 14:43 +0100, Yeoreum Yun wrote:
>>>>>> Confidential computing guests without a TPM can use TSM measurement
>>>>>> registers to record IMA measurement digests instead of TPM PCRs.
>>>>
>>>> + Gong Ruiqi, of course.
>>>>
>>>> Roberto
>>
>> Hi Roberto,
>>
>> [...]Thank you for involving me!
>>
>>>>
>>>>> Hi Yeoreum
>>>>>
>>>>> a similar patch set has been sent to the linux-integrity mailing list:
>>>>>
>>>>> https://lore.kernel.org/linux-integrity/20250630125928.765285-1-gongruiqi1@huawei.com/
>>>>>
>>>>> Could you please work with Gong Ruiqi to have a unified proposal?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Roberto
>>>>>
>>>
>>> Thanks for letting me know and I think the proposal is almost the same
>>> with the different terminology only.
>>>
>>> @Gong, what do you think?
>>
>> Hi Yeoreum,
>>
>> Nice to see this topic picked up again — I'm glad the IMA RoT framework
>> series I posted last year is still of interest.
>>
>> Yes, I'd be happy to work with you on a unified proposal. It's been a
>> while since I last worked on that series, so I'll first revisit my
>> previous patch set, and then follow up with you to discuss the code details.
>>
>> Looking forward to working with you.
>>
>> BR,
>> Ruiqi
> 
> Hi Ruiqi :)
> 
> Thanks for replying and I'm happy with you too.
> However, I think we need to rework based on the Jiri's patch [0].
> 
> Any thought?

Hi Yeoreum,

I'd rather not base our work on Jiri's patch at this stage: it is
a pre-RFC draft of the new attestation subsystem, whose design is
itself still in progress. Building upon it instead of current
mainline would be quite risky — we would be rebasing on a moving
target, and merging would be blocked until the whole framework
lands, which is realistically far off.

I'd suggest we develop the proposal on current mainline, and
switch to the new attestation subsystem once it lands. As I
understand it, for us that is mostly just a matter of switching
to a different set of APIs.

BR,
Ruiqi

> 
> Link: [0] https://github.com/jpirko/linux_mlxsw/tree/wip_attestation_pre_rfc_draft1 
> 
> 

