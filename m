Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187042;
	b=bKqOPeDmxK0FZGl+qAxDuM4asbsTAsRiBdCkje3/poLiRjcQfVOJqN/2vi1S9p0UnGps
	 I5yBTNIm+Q/JV7B9Kk3TiMfWVrPy7E3ZUj33vS0XCNN4iDAYJKntunD4FDgOXAOfheywN
	 FfXfWlWQPSYAozzuH6IUlFUpvqzLc2ay7By79okaCb25KVwRc9xnWNY/68Gr4e9cDc9jN
	 Hm59g3P/xpl5I3DlO/EgVD8Wm604gkWWHCcCfTJEkCBMBZCVnf+AFZ17f+AHApSEfkwJf
	 uTQtLKTNEXYEhVj4SMXAUMe5ycX2yqe2h4R+3wF8LFMiGOKqOVcbMOxpxeLJ4q7Rteg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187042;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=yY98EimkYwoSC4veLCocaKOPiAsfw8Chonm7o9A4A9M=;
	b=rrI70LFnWXYBteD4pRiuygm4mhXJqhhpW9dDgnaapdeAvVQU8m/XjQbhyqsKw7IraYTf
	 y2myaMRgUBu9MvXAUO47pjc4p6lnfepga7fF6TFe42vGI5xKtXL5yfK1ChJ0HWHgDUQ+v
	 iL0UzbSxiaSjFC+KDJbZ1hzPH0gfHsxjR0SlEactvJhRl/R66DyZ9Zoxzmu3C6fuKk4Z7
	 k1VHatVogjg4vrh1u7/FNzL3pAvxcJQNz/z73BpYpm5QggLCMgZeOyIODTPZSceqewBcE
	 7HfJg2wcURuu5BPJHLCz9emlsOwGQN3LZdrwCIe5807CHgDSSDXri/Eq3REErjo7sdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qeQgFRRB;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B39606A31C;
	Mon,  9 Nov 2026 01:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=qeQgFRRB
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yY98EimkYwoSC4veLCocaKOPiAsfw8Chonm7o9A4A9M=;
	b=qeQgFRRBd00Rn4rcGiGW4cLpU42DjSLiYLuY0iPOxJjAWnf7mo7BPBywaBk6dbPUWAHU7dDoH
	5Dk0lgW8/XEXIKaJb5jUbAbZdI6PYC+11Vcy1XbFjudWMWJwt82sSUOSfXtHgxtAMTm8KKQSI1X
	BOb9/Xsi3W61XFBYhWMjjPo=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jNBhT4PhYzmVcF;
	Mon,  9 Nov 2026 09:16:57 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 3ACDA40572;
	Mon,  9 Nov 2026 09:17:11 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 9 Nov 2026 09:17:09 +0800
Message-ID: <a890e04e-acbc-472a-ac06-d241c3e9f721@huawei.com>
Date: Mon, 9 Nov 2026 09:17:08 +0800
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
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: <nicolas.bouchinet@oss.cyber.gouv.fr>, <xiujianfeng@huawei.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <shuah@kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<lujialin4@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <au4wx1+7+Bkg3wgz@hallyn.com>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <au4wx1+7+Bkg3wgz@hallyn.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100010.china.huawei.com (7.152.184.41)

Hi, Serge. Thanks for review.

I will change these two patches and send v2 later.

On 11/7/2026 3:55 AM, Serge E. Hallyn wrote:
> In patch 3, it would be nice if we had a BUILD_BUG_ON if
> the temp len became not long enough.  In patch 6, I think
> the original was nicer to read.
