Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676931487C5
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653006; cv=none; b=ahEGZsuFwve7xryS7ByCrnYknQO6JoLNXvk0uoe83/2B3jUGCTFy3l6v2cGL6HKhWTiYbS7EpqtWpSfUJs9SFJDiEe7k9NuhV3Jqk8gv5pPHsEU3LT1C0xQSYrxHmF4CibsL6LLgtQQEn57OyfnbCpP3T6Mix040WKlF3C1Ex6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653006; c=relaxed/simple;
	bh=MR+Kr1bkV1XMefcvqgtxEKI7Fq5P0KU+uwLvv78f7Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeXIfn0Q8LAU3kecWGZzufXojTtTgm0ld3BcQBk4xhhPPPGCTGXPZowQc3gFz40hdf7z5g+UnFDGEawcAqpRbNN/aXq2QodkGFZCdA/pHibSAy18PmLLV39EOs3+t8IK+o/8EDJUHNyhxT5NBp6PKeGN3z1BT/0VCHI9+fk9aiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=He3ELrNs; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="He3ELrNs"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2D31240A66;
	Wed, 10 Jul 2024 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720653002;
	bh=4s4w4yH8cdpJByOu587/EVuoYIowyEY/D9u2RzPtH2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=He3ELrNsCg4UaoZZuqQC5WhAiYk1AapYgA7mK6BWjyspZXmXQOQ977Xq+YZLeTiuT
	 3Fhe4oSmnIUHiHACqK/EsGVOTEWtw1fvyUjY6hl61FYl0yQSK2RrRhjwhpJld25gRj
	 iIYP2ryedVcNBFgKTk8df8KH+zQTACGX3Hc7Ac2Or7rNrThaVQLh7iUXWx74oS7lVH
	 xahgpe8cdA6lhnErOUsjgk8DtYocFMNBJutw9NwdKVwZ2ZKMB3abCV0GOLn9JWxAKC
	 R2JzBwWZK1UeNvfKewLKQ8TN4DiklOq23CawUFsJiHB4xub+e5mN8g+Uwhf0VtpPgm
	 qPXCksb3PezwA==
Message-ID: <eea55c14-84d6-4d38-83b1-8b7d6dd90f70@canonical.com>
Date: Wed, 10 Jul 2024 16:09:56 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] LSM: Infrastructure management of the infiniband
 blob
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240710213230.11978-1-casey@schaufler-ca.com>
 <20240710213230.11978-6-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240710213230.11978-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 14:32, Casey Schaufler wrote:
> Move management of the infiniband security blob out of the individual
> security modules and into the LSM infrastructure.  The security modules
> tell the infrastructure how much space they require at initialization.
> There are no longer any modules that require the ib_free() hook.
> The hook definition has been removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>


looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hook_defs.h     |  3 +--
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 17 +++++++++++++++--
>   security/selinux/hooks.c          | 16 +++-------------
>   security/selinux/include/objsec.h |  6 ++++++
>   5 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index f1e0d6138845..7c979137c0f2 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -372,8 +372,7 @@ LSM_HOOK(int, 0, mptcp_add_subflow, struct sock *sk, struct sock *ssk)
>   LSM_HOOK(int, 0, ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey)
>   LSM_HOOK(int, 0, ib_endport_manage_subnet, void *sec, const char *dev_name,
>   	 u8 port_num)
> -LSM_HOOK(int, 0, ib_alloc_security, void **sec)
> -LSM_HOOK(void, LSM_RET_VOID, ib_free_security, void *sec)
> +LSM_HOOK(int, 0, ib_alloc_security, void *sec)
>   #endif /* CONFIG_SECURITY_INFINIBAND */
>   
>   #ifdef CONFIG_SECURITY_NETWORK_XFRM
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 0ff14ff128c8..b6fc6ac88723 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -72,6 +72,7 @@ struct security_hook_list {
>   struct lsm_blob_sizes {
>   	int	lbs_cred;
>   	int	lbs_file;
> +	int	lbs_ib;
>   	int	lbs_inode;
>   	int	lbs_sock;
>   	int	lbs_superblock;
> diff --git a/security/security.c b/security/security.c
> index f1eb93b65ae9..e8f34cbb1990 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -219,6 +219,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   
>   	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>   	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
>   	/*
>   	 * The inode blob gets an rcu_head in addition to
>   	 * what the modules might need.
> @@ -402,6 +403,7 @@ static void __init ordered_lsm_init(void)
>   
>   	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> +	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
>   #ifdef CONFIG_KEYS
> @@ -5070,7 +5072,18 @@ EXPORT_SYMBOL(security_ib_endport_manage_subnet);
>    */
>   int security_ib_alloc_security(void **sec)
>   {
> -	return call_int_hook(ib_alloc_security, sec);
> +	int rc;
> +
> +	rc = lsm_blob_alloc(sec, blob_sizes.lbs_ib, GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	rc = call_int_hook(ib_alloc_security, *sec);
> +	if (rc) {
> +		kfree(*sec);
> +		*sec = NULL;
> +	}
> +	return rc;
>   }
>   EXPORT_SYMBOL(security_ib_alloc_security);
>   
> @@ -5082,7 +5095,7 @@ EXPORT_SYMBOL(security_ib_alloc_security);
>    */
>   void security_ib_free_security(void *sec)
>   {
> -	call_void_hook(ib_free_security, sec);
> +	kfree(sec);
>   }
>   EXPORT_SYMBOL(security_ib_free_security);
>   #endif	/* CONFIG_SECURITY_INFINIBAND */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 34ed787a4bfa..11f4bdabda97 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6776,23 +6776,13 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
>   			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
>   }
>   
> -static int selinux_ib_alloc_security(void **ib_sec)
> +static int selinux_ib_alloc_security(void *ib_sec)
>   {
> -	struct ib_security_struct *sec;
> +	struct ib_security_struct *sec = selinux_ib(ib_sec);
>   
> -	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
> -	if (!sec)
> -		return -ENOMEM;
>   	sec->sid = current_sid();
> -
> -	*ib_sec = sec;
>   	return 0;
>   }
> -
> -static void selinux_ib_free_security(void *ib_sec)
> -{
> -	kfree(ib_sec);
> -}
>   #endif
>   
>   #ifdef CONFIG_BPF_SYSCALL
> @@ -6964,6 +6954,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>   	.lbs_tun_dev = sizeof(struct tun_security_struct),
> +	.lbs_ib = sizeof(struct ib_security_struct),
>   };
>   
>   #ifdef CONFIG_PERF_EVENTS
> @@ -7282,7 +7273,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(ib_pkey_access, selinux_ib_pkey_access),
>   	LSM_HOOK_INIT(ib_endport_manage_subnet,
>   		      selinux_ib_endport_manage_subnet),
> -	LSM_HOOK_INIT(ib_free_security, selinux_ib_free_security),
>   #endif
>   #ifdef CONFIG_SECURITY_NETWORK_XFRM
>   	LSM_HOOK_INIT(xfrm_policy_free_security, selinux_xfrm_policy_free),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 461c6985977d..b1878f9395b5 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -213,4 +213,10 @@ selinux_tun_dev(void *security)
>   	return security + selinux_blob_sizes.lbs_tun_dev;
>   }
>   
> +static inline struct ib_security_struct *
> +selinux_ib(void *ib_sec)
> +{
> +	return ib_sec + selinux_blob_sizes.lbs_ib;
> +}
> +
>   #endif /* _SELINUX_OBJSEC_H_ */

