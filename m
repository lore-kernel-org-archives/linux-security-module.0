Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795697452;
	b=Doh0isXi1d8m+pgrQ5BK49oti2HbGNNMrYSGjSYQBfzw2F3ulkPNti+O/wN/+o3Dl5Hn
	 14s0ZkZbQr4hRxa0nYZM78X33Wo6DQMTcAp92DLXdWDpCNy7cyVgWuAZuNa2MmOuGlQ51
	 uRFjxSHUDCPcdXE7ooHn3Wgt5j/JDEVLFGhgefM3XKJH2NK4jwG+7C2KomTqvPDJjPEAJ
	 d7KZJyHZqEVXVNpivh3x1wK4Y0+HxFp6MiB2XpM7M/U94NnxuUpRJArDYB/A/rLiIBtLJ
	 eO1dK15ZhndroUtfBRWdONERDn28j0405zFrl6reDd1YM2xlYHglflDFrNNSZUXYI1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795697452;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=lUFCf/i33f0gFEHdJJLi5vE7e9M4uWkbvzZAlGrisW8=;
	b=m39UoD/XRhuZ0J1hWw6q1HWZAC1LUqQZIRLwwoz+JEODRn6a4+tOy3m0jvIEQ5EtyGqR
	 hhkilWqUbLOo75YPi8qhLUU8NvXafWFYBTqPAbhLYP5Dlq2gOkkH/mnVf/LQFoJoIprul
	 nnyQci4bms2cIR6Zd/BAL0JYtFKjInrOSBxL2607iWIQrIHhLe7G5uA4s6kgvnyx/QJ2o
	 Yx8XWUkTdIF3Lys/nZWM0TH/UJSF3xtqOGIDgZdkKFECnZYe0BhhEHYknB3t9hrW9Hao1
	 npaK9CMLwtBnTK5NPyGk+KM03VQAikjFGo3ZiLQxJ3QoAWmmhcEseT+5ZgDyXpXLIEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=47+3007Y;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC6606A323;
	Thu, 26 Nov 2026 12:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CC6606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=47+3007Y
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lUFCf/i33f0gFEHdJJLi5vE7e9M4uWkbvzZAlGrisW8=;
	b=47+3007YhjxQwZG0R5za/zsqMyQW7tRu8Zd+abGNeBJ5+rj85f+FRKzOp1l/5mYeLUPfE1HvT
	5CP0MzbyNbTDW+COXLrP8ByfdcWTmULbA+t+zYeBT37GLIfuKfnUQ4NH3hhD3KdeX5MTbjicjWt
	wGbMONsRxjOSqtfXa6lq3Uo=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jZxGg64F5z1cyRy;
	Thu, 26 Nov 2026 20:50:19 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id B5A3240563;
	Thu, 26 Nov 2026 20:50:44 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 26 Nov 2026 20:50:43 +0800
Message-ID: <00eed8d3-2444-4517-ab47-731a1a987386@huawei.com>
Date: Thu, 26 Nov 2026 20:50:42 +0800
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
Subject: Re: [PATCH -next -v2 0/8] lockdown: fix the securityfs interface and
 add tests
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	"xiujianfeng@huawei.com" <xiujianfeng@huawei.com>
CC: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<shuah@kernel.org>, <kalevi@kolttonen.fi>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <179553449228.44882.5530794140051904297.b4-review@b4>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <179553449228.44882.5530794140051904297.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100010.china.huawei.com (7.152.184.41)

Hi, Nicolas

Thank you for your review. I have revised following the comments above, 
including Xiu's,
and sent v3.

On 11/24/2026 11:34 PM, Nicolas Bouchinet wrote:

> For your information, your e-mail subjects starts with '[PATCH -next -v2 x/8]'
> and break tools like b4 that help tracking your contributions, could you
> fix it to [PATCH v3 x/8] ?
>
> Thanks in advance,
>
