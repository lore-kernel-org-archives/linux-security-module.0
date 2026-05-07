Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D293890EE
	for <linux-security-module@vger.kernel.org>; Thu,  7 May 2026 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146698; cv=none; b=uAg5W4jYrPsNuewzXSCEGvNqLYBrrkJ9QIcs7ALK9se063PjORoucRDHZoinm225IbIpKOL1ZCf+zr4IxZW2eKGJ50rLHOcrms/ubNnjmGgaNtn/Mxx5a8BeyQFifxeh23urfWkvak7wFIQOy4MujjZcXMpX504/Op45G14xRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146698; c=relaxed/simple;
	bh=/yiXf/5xl8o57guTin2z3QusbJ6kQ1jyJsibAKS23/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dae7DG4WoPd6USBokl920V3u9KkersBzAj9S31xICRCA8/Bb6yPRBFSa4KGYOkIb6g3+JEVF8sKfXVnRKfJXdI9qZkVtexTDFmF0AEqpETh6fTlgecaNu9s94g7NZ2EqTWbLdBDFg74+60lCNlSodlTpT6yYP0eXYcAOn/qZJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0z/hb76z; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0z/hb76z"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1EtwIOJFv3Rp2Bm4yjCgwUNB1UQEo7p0rYJxQXYpGOg=;
	b=0z/hb76zEED3eO21So/Oq6U7lpj3ByW58qbLnOQLwYiYgGdesx/jbe1+wNbOZsNXrc6lud+Y5
	JKXPCFf9Tr7quvUFYhAao+oiwv/xzs03i5dhHiTDbfwrYcuKTjF6PVQOUXBtEkduQiGHb5eeRSq
	BJW1gW3z3xag/Vw0qB1NG74=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gB6Rz5DyGz1T4fn;
	Thu,  7 May 2026 17:30:39 +0800 (CST)
Received: from kwepemj100004.china.huawei.com (unknown [7.202.195.249])
	by mail.maildlp.com (Postfix) with ESMTPS id 98F1740537;
	Thu,  7 May 2026 17:38:12 +0800 (CST)
Received: from [10.34.207.117] (10.34.207.117) by
 kwepemj100004.china.huawei.com (7.202.195.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 17:38:12 +0800
Message-ID: <d3393689-ef1a-4c79-b6db-9d4fb1c9f5ae@huawei.com>
Date: Thu, 7 May 2026 17:38:11 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdown: remove useless decrement operation
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Kalevi Kolttonen
	<kalevi@kolttonen.fi>
CC: <linux-security-module@vger.kernel.org>, <xiujianfeng@huaweicloud.com>
References: <20260501174448.47154-1-kalevi@kolttonen.fi>
 <afm9F_neup5eiD5z@archlinux>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <afm9F_neup5eiD5z@archlinux>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100004.china.huawei.com (7.202.195.249)

On 5/5/2026 5:51 PM, Nicolas Bouchinet wrote:
> Hi Kalevi, thanks for your contribution,
> 
> While it is true the len variable decrementing is not used anywhere and
> that it would be cleaner to remove it, ideally we should go through a
> more in depth Lockdown code cleaning.
> I'll include it with Cai's one[1] when a more consequent patch will be
> ready. I'll thus keep it somewhere with the patch until then.
> 
> I have a two week holiday starting this Friday and will thus not be available
> until the 26th of may. Xiu, and Cai, if you want to work on it I'll gladly
> review the patch set.

Hi Nicolas,

Have a nice holiday!

I'm in favor of a cleanup where it makes sense, but I don't see any
code that specifically needs it at the moment. Feel free to point out
any areas of concern when you have a moment.

> 
> [1]: https://lore.kernel.org/all/20260119091226.3195309-1-caixinchen1@huawei.com/
> 
> Best regards,
> 
> Nicolas

