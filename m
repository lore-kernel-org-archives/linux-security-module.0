Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544E33C52F;
	Wed, 22 Apr 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841389; cv=none; b=ifiLNHsqas1OxP7fzKSe2BXypypemByJt7uwxPt4l/NvK3H/OgMm6FY5enwSQw8lsxin1CePPRkTL5ZG/xJRFXQMV0KHTmf4+6kNERpRzHJki4A6LHbGfVSTgyK5zPoVPr16V6kC/5DUE9/o97AZMxOJDQjp2qskutQakhIf72M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841389; c=relaxed/simple;
	bh=GerxzjzL5/iX2A+mmJ/WsS1zVhOlfR7P9SqZsGPzd/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pBIlgU5jEgI5tGd55xZk39mJQHLWMNUYAYKA2TBkVgqaggohPzfq9RGkf536wPEorDU7HM2lqIaSLkFAKe0wjxKMIsm77WHTAP+59o1x4x5uBw5AMWBp2L9uWCcjwALecNxgkKe3X/GIhEBJ+mXPmdBzlPsjV06siiKdy/kNuCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vxed3IXD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vxed3IXD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6zgAh1lwI3Dwph2UKuzgW+oG09QC3No/l5U0zh07Bik=;
	b=Vxed3IXDAj30Sh9HN80jbc0Tz6nKydaGcJFCz7qlHa4jaj8eC4O/t+wkGAts6nu+n7tD20Ku+
	JpXznascIQeQc/yPJgvZu1FFnI6qcaSGWdAqxJ0w/uO4Q37j/O/mRMfJNYhLxqOuRshcVWmWr+b
	0cfMUF02vinZKlZnIdu1JSg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4g0qlG1ykYzRhTY;
	Wed, 22 Apr 2026 14:56:42 +0800 (CST)
Received: from kwepemk100018.china.huawei.com (unknown [7.202.194.66])
	by mail.maildlp.com (Postfix) with ESMTPS id C68064056D;
	Wed, 22 Apr 2026 15:03:04 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by kwepemk100018.china.huawei.com
 (7.202.194.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Apr
 2026 15:03:04 +0800
Message-ID: <62855018-467c-4959-8c90-44e8ed33901d@huawei.com>
Date: Wed, 22 Apr 2026 15:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] apparmor: Fix two bugs of aa_setup_dfa_engine's fail
 handling
To: John Johansen <john.johansen@canonical.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>
CC: <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lujialin4@huawei.com>
References: <20260403035119.2132418-1-gongruiqi1@huawei.com>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <20260403035119.2132418-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100018.china.huawei.com (7.202.194.66)

Kindly ping.

On 4/3/2026 11:51 AM, GONG Ruiqi wrote:
> First, aa_dfa_unpack returns ERR_PTR not NULL when it fails, but
> aa_put_dfa only checks NULL for its input, which would cause invalid
> memory access in aa_put_dfa. Set nulldfa to NULL explicitly to fix that.
> 
> Second, aa_put_pdb calls aa_pdb_free_kref -> aa_free_pdb -> aa_put_dfa,
> i.e.  it will free nullpdb->dfa. But there's another aa_put_dfa(nulldfa)
> after aa_put_pdb(nullpdb), which would cause double free. Remove that
> redundant aa_put_dfa to fix that.
> 
> Fixes: 98b824ff8984 ("apparmor: refcount the pdb")
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..be82ec1b9fd9 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -2465,6 +2465,7 @@ static int __init aa_setup_dfa_engine(void)
>  			    TO_ACCEPT2_FLAG(YYTD_DATA32));
>  	if (IS_ERR(nulldfa)) {
>  		error = PTR_ERR(nulldfa);
> +		nulldfa = NULL;
>  		goto fail;
>  	}
>  	nullpdb->dfa = aa_get_dfa(nulldfa);
> @@ -2486,7 +2487,6 @@ static int __init aa_setup_dfa_engine(void)
>  
>  fail:
>  	aa_put_pdb(nullpdb);
> -	aa_put_dfa(nulldfa);
>  	nullpdb = NULL;
>  	nulldfa = NULL;
>  	stacksplitdfa = NULL;

