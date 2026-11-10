Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299754;
	b=AMNJTD9maDThBMGseK2Uip10pXM6N7r9nbZH7+4+kMQvo56Fkic4NUznH8k7OI6gSgSF
	 r+7HYEZZDgD1Ca/uJRGhGl24bEDcCYHwWfksUd3nziIgJ3ao6PUHbPHyuL09J3qXaLQkr
	 mCHLt6ehZgTbRS14SBVv9oT4kctWCYuV7zAe9xD5PIvRkjsgrb/fKJ/YDKCrjuOcmw5zC
	 lj57Q0CEwBV1TBWqVD+SOIoMSAGte/mGxbH55rt95tMG/O8pd9ZV6YIXuUV9MpBt2UMO5
	 ISocOsiRdK7l9lBCzDDCSfhNB/IfJgftCQ9Ji7yNUL30wA+kaRAX1w/PvibwRH5Oehg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299754;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=xAUrBlWbL2FZ/S0+otqcReK5SDInHMzk1Z3yvO27XrA=;
	b=pphyjDAY+RkqmWvzPCEx58LOIR+d3rcuKjf/vM0udufXgznoEzEXU8DygpKaylo8AILp
	 Q0MdtFeJwL3+oZ+tdyqz0QdFaYmkALYgBzIO1PlASUcbnpqWKD+Q12Wug8j79/9i2ykoK
	 NeocloAzAFjX1xCEnQJuCZntDdH+54OPDflI/KfA7eZxUrsyeoU+g3PzivI/SXIj1B64c
	 Wek4NhSoO2hlOyuutM0lcndl2NVN5mwp2b4wiK9EFWPbB4JLxi4GDlPZwqkMYDbNMrVEl
	 sx+dJll32xQlyL/gnIXUhm5V4dSS9oJrRCtKeUWzKP+qa9wwiLKogpNQ/7JJhEMcTgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=g0Ry608X;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E66606A321;
	Tue, 10 Nov 2026 08:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57E66606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=g0Ry608X
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xAUrBlWbL2FZ/S0+otqcReK5SDInHMzk1Z3yvO27XrA=;
	b=g0Ry608XAh6K75vIGFwwKMnQ+iCOGc1f6sCJJfthXuMalF176r4v09FE9EMNLTuRtkP74BMRk
	A9m9PF40rDLryqEdenumhvv+BuvQGp+htiUt84zjrsW+ZTOEwrc586+foRELX7mEZyhyxD1d215
	SCEGU46WJ96z0W79HMSm9j4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jP0Mj59m3z1T4Jq;
	Tue, 10 Nov 2026 16:35:13 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id E75CA202E6;
	Tue, 10 Nov 2026 16:35:41 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 10 Nov 2026 16:35:40 +0800
Message-ID: <0e74a753-d967-4caa-b6a5-7aae7c517e92@huawei.com>
Date: Tue, 10 Nov 2026 16:35:39 +0800
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
Subject: Re: [PATCH -next 0/9] lockdown: fix the securityfs interface and add
 tests
To: <nicolas.bouchinet@oss.cyber.gouv.fr>
CC: <xiujianfeng@huawei.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<serge@hallyn.com>, <shuah@kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <f118d32f369dff7182956b64e6bc1dd8@oss.cyber.gouv.fr>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <f118d32f369dff7182956b64e6bc1dd8@oss.cyber.gouv.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100010.china.huawei.com (7.152.184.41)

Hi, Nicolas, no inconvenience at all. Thanks for the review.

I will change selftests in v2 and look forward to your testing next Monday.

On 11/9/2026 5:08 PM, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> Those looks good to me, I've added comments in patch 9.
> I'm not at work this week so I'll tests your series next monday. Sorry
> for the inconvenience. 
