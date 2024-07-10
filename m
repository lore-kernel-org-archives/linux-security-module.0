Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3414D701
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652948; cv=none; b=Qq6xLivtjA9y5qlsdzFbmd/SQVnUyqM2/xkWlkG0e97bEri2lMAp+/8NjWMumhopRk0jEUJLMmz2DqzBSNSnaNMFUaPWOz7e1DTLCbyxD1RsuyQPJ4ocHk2+FTAGx7O2ANc1F5mNoiERmgbWgkvDN5Nk4p+ovOxvYW8BUuH69s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652948; c=relaxed/simple;
	bh=QK4tJTIJdIEaDPrFXpTCftg5wtUppMjeppy9biHE7z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUH6M0G2/ze9TV/Q0kJP2MWTaapvge8dmPncEMm0siaeg0OVFZ8K49RCeeHGbqWcrynbS8pE/AyPvbYQrLBUrxRZAm+6RfFDqNowQGiHYTvwd3QBfLLJwO7QOJ4s17UEqYIaTaKlzwMA6cX9Q5Ev38fB67jgAswNjbTkQUnnr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FPVPrMvE; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FPVPrMvE"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 32E5840A5A;
	Wed, 10 Jul 2024 23:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720652943;
	bh=AEacUyPvJfrKsa1LYi2qbaCwFzfSA7e1/p8YtrxJB4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=FPVPrMvEJSmgh4dMlzr2+xH80wWM9GhbbAfJvvn8rU6dCEXhxyWKXZdLvQS8NqlZh
	 A5FQfqd1SaSocAUA/JosE6/YtcwVRowrwZq0ZRcKvEgkHosV9v9PRrMN6nR2Oh5Wq/
	 8J1vbZPNT7aX+d4o56h2A2MyhvBFzJXhdsAsy0FHhIoMqdVepke1La0kQrKStl0UWC
	 cXmqICk61d/RivFiraazV5Mo8rN+QIDzlmKZ9OIeepT0OGO9NTXWNhKg1qol4SwL3/
	 rq9kzPcLvUe1sGkGWlSpysF829hBMoXdL1OTuh7+FTNqVor6SjuAQnu8wMrTDrwSGs
	 VwXZJqQN1dHog==
Message-ID: <d8f8ee5f-7b30-45d8-b3fc-835f81433573@canonical.com>
Date: Wed, 10 Jul 2024 16:08:58 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] LSM: Infrastructure management of the dev_tun blob
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240710213230.11978-1-casey@schaufler-ca.com>
 <20240710213230.11978-5-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240710213230.11978-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 14:32, Casey Schaufler wrote:
> Move management of the dev_tun security blob out of the individual
> security modules and into the LSM infrastructure.  The security modules
> tell the infrastructure how much space they require at initialization.
> There are no longer any modules that require the dev_tun_free hook.
> The hook definition has been removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hook_defs.h     |  3 +--
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 17 +++++++++++++++--
>   security/selinux/hooks.c          | 22 ++++++----------------
>   security/selinux/include/objsec.h |  6 ++++++
>   5 files changed, 29 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index cc81f7f7c024..f1e0d6138845 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -352,8 +352,7 @@ LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_inc, void)
>   LSM_HOOK(void, LSM_RET_VOID, secmark_refcount_dec, void)
>   LSM_HOOK(void, LSM_RET_VOID, req_classify_flow, const struct request_sock *req,
>   	 struct flowi_common *flic)
> -LSM_HOOK(int, 0, tun_dev_alloc_security, void **security)
> -LSM_HOOK(void, LSM_RET_VOID, tun_dev_free_security, void *security)
> +LSM_HOOK(int, 0, tun_dev_alloc_security, void *security)
>   LSM_HOOK(int, 0, tun_dev_create, void)
>   LSM_HOOK(int, 0, tun_dev_attach_queue, void *security)
>   LSM_HOOK(int, 0, tun_dev_attach, struct sock *sk, void *security)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7233bc0737be..0ff14ff128c8 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -80,6 +80,7 @@ struct lsm_blob_sizes {
>   	int	lbs_msg_msg;
>   	int	lbs_task;
>   	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> +	int	lbs_tun_dev;
>   };
>   
>   /**
> diff --git a/security/security.c b/security/security.c
> index e5af4274b8aa..f1eb93b65ae9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -232,6 +232,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
>   	lsm_set_blob_size(&needed->lbs_xattr_count,
>   			  &blob_sizes.lbs_xattr_count);
>   }
> @@ -410,6 +411,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>   	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>   
>   	/*
> @@ -4849,7 +4851,18 @@ EXPORT_SYMBOL(security_secmark_refcount_dec);
>    */
>   int security_tun_dev_alloc_security(void **security)
>   {
> -	return call_int_hook(tun_dev_alloc_security, security);
> +	int rc;
> +
> +	rc = lsm_blob_alloc(security, blob_sizes.lbs_tun_dev, GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	rc = call_int_hook(tun_dev_alloc_security, *security);
> +	if (rc) {
> +		kfree(*security);
> +		*security = NULL;
> +	}
> +	return rc;
>   }
>   EXPORT_SYMBOL(security_tun_dev_alloc_security);
>   
> @@ -4861,7 +4874,7 @@ EXPORT_SYMBOL(security_tun_dev_alloc_security);
>    */
>   void security_tun_dev_free_security(void *security)
>   {
> -	call_void_hook(tun_dev_free_security, security);
> +	kfree(security);
>   }
>   EXPORT_SYMBOL(security_tun_dev_free_security);
>   
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 986825ba1cc5..34ed787a4bfa 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5573,24 +5573,14 @@ static void selinux_req_classify_flow(const struct request_sock *req,
>   	flic->flowic_secid = req->secid;
>   }
>   
> -static int selinux_tun_dev_alloc_security(void **security)
> +static int selinux_tun_dev_alloc_security(void *security)
>   {
> -	struct tun_security_struct *tunsec;
> +	struct tun_security_struct *tunsec = selinux_tun_dev(security);
>   
> -	tunsec = kzalloc(sizeof(*tunsec), GFP_KERNEL);
> -	if (!tunsec)
> -		return -ENOMEM;
>   	tunsec->sid = current_sid();
> -
> -	*security = tunsec;
>   	return 0;
>   }
>   
> -static void selinux_tun_dev_free_security(void *security)
> -{
> -	kfree(security);
> -}
> -
>   static int selinux_tun_dev_create(void)
>   {
>   	u32 sid = current_sid();
> @@ -5608,7 +5598,7 @@ static int selinux_tun_dev_create(void)
>   
>   static int selinux_tun_dev_attach_queue(void *security)
>   {
> -	struct tun_security_struct *tunsec = security;
> +	struct tun_security_struct *tunsec = selinux_tun_dev(security);
>   
>   	return avc_has_perm(current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
>   			    TUN_SOCKET__ATTACH_QUEUE, NULL);
> @@ -5616,7 +5606,7 @@ static int selinux_tun_dev_attach_queue(void *security)
>   
>   static int selinux_tun_dev_attach(struct sock *sk, void *security)
>   {
> -	struct tun_security_struct *tunsec = security;
> +	struct tun_security_struct *tunsec = selinux_tun_dev(security);
>   	struct sk_security_struct *sksec = selinux_sock(sk);
>   
>   	/* we don't currently perform any NetLabel based labeling here and it
> @@ -5634,7 +5624,7 @@ static int selinux_tun_dev_attach(struct sock *sk, void *security)
>   
>   static int selinux_tun_dev_open(void *security)
>   {
> -	struct tun_security_struct *tunsec = security;
> +	struct tun_security_struct *tunsec = selinux_tun_dev(security);
>   	u32 sid = current_sid();
>   	int err;
>   
> @@ -6973,6 +6963,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
> +	.lbs_tun_dev = sizeof(struct tun_security_struct),
>   };
>   
>   #ifdef CONFIG_PERF_EVENTS
> @@ -7283,7 +7274,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(secmark_refcount_inc, selinux_secmark_refcount_inc),
>   	LSM_HOOK_INIT(secmark_refcount_dec, selinux_secmark_refcount_dec),
>   	LSM_HOOK_INIT(req_classify_flow, selinux_req_classify_flow),
> -	LSM_HOOK_INIT(tun_dev_free_security, selinux_tun_dev_free_security),
>   	LSM_HOOK_INIT(tun_dev_create, selinux_tun_dev_create),
>   	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
>   	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 83b9443d6919..461c6985977d 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -207,4 +207,10 @@ static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
>   	return sock->sk_security + selinux_blob_sizes.lbs_sock;
>   }
>   
> +static inline struct tun_security_struct *
> +selinux_tun_dev(void *security)
> +{
> +	return security + selinux_blob_sizes.lbs_tun_dev;
> +}
> +
>   #endif /* _SELINUX_OBJSEC_H_ */

