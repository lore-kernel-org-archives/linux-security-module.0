Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4F120C005;
	Thu, 26 Jun 2025 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909343; cv=none; b=fndLTV/em6COJ3cyq9dsdfDezZgjNziCSgHd9cUkYruGacN3uH+3S2y2rC57WjX+rcir/gMbTjXwVJWcdAHIoWcU9gskgnYHnYYvPzaxNIe+RiGpR5HA5GRxAeV5kMYXdLkyWNjfDeVNWH8VRNUuwGwL41KHbVsrUNMxy4k0DLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909343; c=relaxed/simple;
	bh=bEK63Ql+xAIJd4FMmdSbFgwWNsCmsX3m02h2rfKQbg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JcJwdHgL115JYulKhwiSZki7hdGjCXtV2qntJ4dbev/uI2pNfGXpTu+SY2iW2exF1k6e7p94xzlc8ECs4HIgFCl0v9wL5DUgkV2ML9gb7ci28j81l+MzfrqskoyhxfQtjo43K+xnDphfEm2ek20AqSqN+6vPwBTBynAvWVynVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bSPXp1vtFzdbl6;
	Thu, 26 Jun 2025 11:38:18 +0800 (CST)
Received: from kwepemg500012.china.huawei.com (unknown [7.202.181.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F08D1402C1;
	Thu, 26 Jun 2025 11:42:16 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 kwepemg500012.china.huawei.com (7.202.181.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 11:42:15 +0800
Message-ID: <2417ea19-ff81-9f06-f862-e86e59fd3e51@huawei.com>
Date: Thu, 26 Jun 2025 11:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] MAINTAINERS: Add Xiu and myself as Lockdown maintainers
Content-Language: en-US
To: <nicolas.bouchinet@oss.cyber.gouv.fr>, Paul Moore <paul@paul-moore.com>
CC: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
References: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250624-add_myself_to_lockdown_maintainers-v1-1-bed2bc934666@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemg500012.china.huawei.com (7.202.181.74)



On 2025/6/24 22:48, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> 
> The Lockdown LSM has been unmaintained for some time now. It requires
> some work to ensure it works as intended.
> 
> Xiu Jianfeng and I volunteer to maintain the LSM.
> 
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c1d245bf7b84f8a78b811e0c9c5a3edc09edc22..776c7fffcaec08f71faf2740599f0b4570179832 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14060,8 +14060,10 @@ F:	Documentation/admin-guide/LSM/LoadPin.rst
>  F:	security/loadpin/
>  
>  LOCKDOWN SECURITY MODULE
> +M:	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
> +M:	Xiu Jianfeng <xiujianfeng@huawei.com>

I'm honored, and will gladly contribute to maintaining the LSM, thanks!

Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>

>  L:	linux-security-module@vger.kernel.org
> -S:	Odd Fixes
> +S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	security/lockdown/
>  
> 
> ---
> base-commit: 9fc86a85f36c51dd9e628c82091326151c8ff638
> change-id: 20250624-add_myself_to_lockdown_maintainers-e65b471febf9
> 
> Best regards,
