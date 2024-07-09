Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1414D439
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720565474; cv=none; b=JhcrsBkU2yguGwHjx7SCgs3pk9Y3N4H9xQP5ZQ72BwwybtbrhVWOcc+spW5G6WgEBS3nCCOw86yvCii9qiKXt+OOHTLlg0Co/TLs1d4V1tlFBv5qqDlhQp7TfMR7AnUi0Ifz1JeeWlXXBX79xUFRcTY2y/uZ7xX30VXeOQ34iHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720565474; c=relaxed/simple;
	bh=9lWqMYzf1u5aoxQnj8D2YWYuAPFc1MFnbV5WdKrrz7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1SFFwTL0RWnBfRDg478sBxtJAc6rvNgfjY8s5rhoau+HRcdCdFmSqwxCnPTDlozhC+MKO6SKUgNws/uh5KR04alYb/q7UGvXtRxvu9hSMSeX1TZxUXAuDuMeNB8VF+OgHi2pbEGPJ3mtjCD5PMd1f1GIUowScXv0ZY7TBhKva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vRCSZgg0; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vRCSZgg0"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8CE003F201;
	Tue,  9 Jul 2024 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720565469;
	bh=3i5WJvw3AJOTj7YucJY+KubX1B0rb5BkjDK5IVtU2ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=vRCSZgg0yrfl5OuxNhnD7dSXCFPKhDYx5d4azuMBS2yiGGH/yZUD4+nmCeGD2AQaj
	 KIdbI4G1Lcvg0sHA01fVYgLcZGBd2oFSSaaHxWFjb5vTEORph+xaYE5Qw+2xuvtUgo
	 X1z4m1PKaplgSv6GrglXulFiR4v19ZE2Lojofd/OhcSjcs7oWsYtfAdxOBb+HvBAZX
	 mr+JmbFLwHaljfI4LjIw3Ow6ij/khKREZKLb/vLegAyK4m58j4l5dC5SnkBKpPhmf3
	 V3WMX6qQM5aafrpITkx8nCTLTpdT8JLd2C25vnKcmOz85T/X5xEoKrC7ERwu6Ad9ea
	 NQqKAtwmTxuEA==
Message-ID: <955484a5-9598-46fc-b64b-f8884d0fdd31@canonical.com>
Date: Tue, 9 Jul 2024 15:51:05 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] LSM: Add helper for blob allocations
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-4-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240708213957.20519-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 14:39, Casey Schaufler wrote:
> Create a helper function lsm_blob_alloc() for general use in the hook
> specific functions that allocate LSM blobs. Change the hook specific
> functions to use this helper. This reduces the code size by a small
> amount and will make adding new instances of infrastructure managed
> security blobs easier.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/security.c | 97 +++++++++++++++------------------------------
>   1 file changed, 33 insertions(+), 64 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index aae37481b7be..438ec6708eb3 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -605,27 +605,42 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>   EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
>   
>   /**
> - * lsm_cred_alloc - allocate a composite cred blob
> - * @cred: the cred that needs a blob
> + * lsm_blob_alloc - allocate a composite blob
> + * @dest: the destination for the blob
> + * @size: the size of the blob
>    * @gfp: allocation type
>    *
> - * Allocate the cred blob for all the modules
> + * Allocate a blob for all the modules
>    *
>    * Returns 0, or -ENOMEM if memory can't be allocated.
>    */
> -static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +static int lsm_blob_alloc(void **dest, size_t size, gfp_t gfp)
>   {
> -	if (blob_sizes.lbs_cred == 0) {
> -		cred->security = NULL;
> +	if (size == 0) {
> +		*dest = NULL;
>   		return 0;
>   	}
>   
> -	cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
> -	if (cred->security == NULL)
> +	*dest = kzalloc(size, gfp);
> +	if (*dest == NULL)
>   		return -ENOMEM;
>   	return 0;
>   }
>   
> +/**
> + * lsm_cred_alloc - allocate a composite cred blob
> + * @cred: the cred that needs a blob
> + * @gfp: allocation type
> + *
> + * Allocate the cred blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +{
> +	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
> +}
> +
>   /**
>    * lsm_early_cred - during initialization allocate a composite cred blob
>    * @cred: the cred that needs a blob
> @@ -692,15 +707,7 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> -	if (blob_sizes.lbs_task == 0) {
> -		task->security = NULL;
> -		return 0;
> -	}
> -
> -	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
> -	if (task->security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL);
>   }
>   
>   /**
> @@ -713,15 +720,7 @@ static int lsm_task_alloc(struct task_struct *task)
>    */
>   static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>   {
> -	if (blob_sizes.lbs_ipc == 0) {
> -		kip->security = NULL;
> -		return 0;
> -	}
> -
> -	kip->security = kzalloc(blob_sizes.lbs_ipc, GFP_KERNEL);
> -	if (kip->security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&kip->security, blob_sizes.lbs_ipc, GFP_KERNEL);
>   }
>   
>   #ifdef CONFIG_KEYS
> @@ -735,15 +734,7 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>    */
>   static int lsm_key_alloc(struct key *key)
>   {
> -	if (blob_sizes.lbs_key == 0) {
> -		key->security = NULL;
> -		return 0;
> -	}
> -
> -	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
> -	if (key->security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&key->security, blob_sizes.lbs_key, GFP_KERNEL);
>   }
>   #endif /* CONFIG_KEYS */
>   
> @@ -757,15 +748,8 @@ static int lsm_key_alloc(struct key *key)
>    */
>   static int lsm_msg_msg_alloc(struct msg_msg *mp)
>   {
> -	if (blob_sizes.lbs_msg_msg == 0) {
> -		mp->security = NULL;
> -		return 0;
> -	}
> -
> -	mp->security = kzalloc(blob_sizes.lbs_msg_msg, GFP_KERNEL);
> -	if (mp->security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&mp->security, blob_sizes.lbs_msg_msg,
> +			      GFP_KERNEL);
>   }
>   
>   /**
> @@ -792,15 +776,8 @@ static void __init lsm_early_task(struct task_struct *task)
>    */
>   static int lsm_superblock_alloc(struct super_block *sb)
>   {
> -	if (blob_sizes.lbs_superblock == 0) {
> -		sb->s_security = NULL;
> -		return 0;
> -	}
> -
> -	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
> -	if (sb->s_security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&sb->s_security, blob_sizes.lbs_superblock,
> +			      GFP_KERNEL);
>   }
>   
>   /**
> @@ -4682,23 +4659,15 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
>   /**
>    * lsm_sock_alloc - allocate a composite sock blob
>    * @sock: the sock that needs a blob
> - * @priority: allocation mode
> + * @gfp: allocation mode
>    *
>    * Allocate the sock blob for all the modules
>    *
>    * Returns 0, or -ENOMEM if memory can't be allocated.
>    */
> -static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
> +static int lsm_sock_alloc(struct sock *sock, gfp_t gfp)
>   {
> -	if (blob_sizes.lbs_sock == 0) {
> -		sock->sk_security = NULL;
> -		return 0;
> -	}
> -
> -	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
> -	if (sock->sk_security == NULL)
> -		return -ENOMEM;
> -	return 0;
> +	return lsm_blob_alloc(&sock->sk_security, blob_sizes.lbs_sock, gfp);
>   }
>   
>   /**

