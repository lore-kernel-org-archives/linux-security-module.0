Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B32F21128F;
	Mon,  3 Mar 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009765; cv=none; b=UtZyWDmRiLGL3PeKR8u6pBAt/lHrQ8TuPZ9l1rBkG1mN8ffiTz9OEDcR+UKvPosU7xD/6kz6+TmbRv8EAKcAbYaTCwZwqtjg50KBEPmclR80GieRK7fyYNw/xEgSiB20kMwgBuBldGo7rR4vHnjwJBxVXHWsdp3oq8CAr8hy6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009765; c=relaxed/simple;
	bh=/FdZFuI0IOKHUanIrzm+Ue5+S3RrxndULHeqzaUYCb0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rw/7VR58vGk3eMozk4WGT5rIjwmC6fPbr0QCkPv0+2y0uHqMOc9gfFir6KpzQcGrV3T2bk+/2sI9RHLLMWo3DZE9vkd2QGmbETnzOgFxdB95Y1/bCFxcCBGh/C1+7y8tR59DG+s2CaRe7Mx63hMiPbDn8sCnRVigNouZC8tQdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z60St47YKzCs7q;
	Mon,  3 Mar 2025 21:45:50 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 77DF11401F0;
	Mon,  3 Mar 2025 21:49:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Mar 2025 21:49:18 +0800
Subject: Re: [PATCH v2 06/11] ubifs: reorder capability check last
To: <cgzones@googlemail.com>
CC: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<cocci@inria.fr>, Richard Weinberger <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-5-cgoettsche@seltendoof.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a9257803-c5cd-bb83-21b6-a8b152c943e6@huawei.com>
Date: Mon, 3 Mar 2025 21:49:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250302160657.127253-5-cgoettsche@seltendoof.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk500005.china.huawei.com (7.202.194.90)

在 2025/3/3 0:06, Christian Göttsche 写道:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>    1. A denial message is generated, even in case the operation was an
>       unprivileged one and thus the syscall succeeded, creating noise.
>    2. To avoid the noise from 1. the policy writer adds a rule to ignore
>       those denial messages, hiding future syscalls, where the task
>       performs an actual privileged operation, leading to hidden limited
>       functionality of that task.
>    3. To avoid the noise from 1. the policy writer adds a rule to permit
>       the task the requested capability, while it does not need it,
>       violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Richard Weinberger <richard@nod.at>
> ---
> v2: split into two patches for each subsystem
> ---
>   fs/ubifs/budget.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/budget.c b/fs/ubifs/budget.c
> index d76eb7b39f56..6137aeadec3f 100644
> --- a/fs/ubifs/budget.c
> +++ b/fs/ubifs/budget.c
> @@ -256,8 +256,9 @@ long long ubifs_calc_available(const struct ubifs_info *c, int min_idx_lebs)
>    */
>   static int can_use_rp(struct ubifs_info *c)
>   {
> -	if (uid_eq(current_fsuid(), c->rp_uid) || capable(CAP_SYS_RESOURCE) ||
> -	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)))
> +	if (uid_eq(current_fsuid(), c->rp_uid) ||
> +	    (!gid_eq(c->rp_gid, GLOBAL_ROOT_GID) && in_group_p(c->rp_gid)) ||
> +	    capable(CAP_SYS_RESOURCE))
>   		return 1;
>   	return 0;
>   }
> 

