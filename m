Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD433C503;
	Thu, 22 Jan 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074278; cv=none; b=CEuhSBQXARZSmUOSiKHUf4RrgB7nfBm/QzAX1Dcs+U76SJkmp3BdnS7UenVP3pCKAliPLPXB3d9iGWmg7dIQGWX/Oh2vV/otT8CM+GXVW7A2X52q90JFy4uYu21+cH52GpNExdFS7jjwNIh8kPvt9ASsbHcU3VwAMytAyzS+I8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074278; c=relaxed/simple;
	bh=fNqz5iu4XD+qDmV9V9dkAhZIAbyPMwTkON5MxSs9UB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DVW+IDgnOjV+fX5ukZ5OTPRfnUKkFUfRZCjV6+0/f5eN5O7M/WNeUgupS9GIDcpir8+XaVmlmKWV6FDY3CqQbaDDA5UcNHsSgfzqpm2iRjro1cwBHRQSxAvKG32KLGs5nRePdFOo+Dow1C/M4pV5knKQ7WVQQosKvhctI1pf8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=naQz8QKB; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="naQz8QKB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kLEBaW/ltq0uH5rAQZSILKVWRyb/EIf5g9uPtCE6aRU=;
	b=naQz8QKBZ33k8ZzeuDdZDYtxkwwFgV14FogusIx0YXdWTfMzdqkIX/TZtLMyYsf5NiBRmC7qj
	dkkYybjMJ0tKCLHC+fqfLHwlzolIHyc7MBOppQ49TUJivGbtmTGUXhD8B12MVwhsuc4Id7VNMO/
	jZ7rgIWB/aaSFvGa6wt0qK4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dxbM14ZhYzKm4Z;
	Thu, 22 Jan 2026 17:27:41 +0800 (CST)
Received: from kwepemj100004.china.huawei.com (unknown [7.202.195.249])
	by mail.maildlp.com (Postfix) with ESMTPS id AF92940563;
	Thu, 22 Jan 2026 17:31:06 +0800 (CST)
Received: from [10.34.206.51] (10.34.206.51) by kwepemj100004.china.huawei.com
 (7.202.195.249) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 22 Jan
 2026 17:31:06 +0800
Message-ID: <b12a0d60-da15-4ba7-a526-247b5a7d97ad@huawei.com>
Date: Thu, 22 Jan 2026 17:31:05 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] lockdown: Add break in lockdown_write
To: Cai Xinchen <caixinchen1@huawei.com>,
	<nicolas.bouchinet@oss.cyber.gouv.fr>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <serge@hallyn.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260119091226.3195309-1-caixinchen1@huawei.com>
From: Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20260119091226.3195309-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100004.china.huawei.com (7.202.195.249)

On 1/19/2026 5:12 PM, Cai Xinchen wrote:
> After the label is matched successful, any other levels judgements
> are meaningless. Therefore, add break to return early
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Looks good to me, thanks.

Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Paul,

Would you mind if this patch went through the LSM tree? :)

Best regards
Xiu Jianfeng
