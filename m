Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373A1411ED
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651570; cv=none; b=BpJLWnGRPa8W4/eDfnmmIzqzLqHDSPpDd00LQ60n6QbiGdCiv8y0PXO2ri8UKAD6bZyxPyHllKFLa9vB00rWmpYZJJalfyczn1qRQI0NMPBWbUgh+pJOPF5+oCIsrlYBzlaqxxsMg85WunO4euc+QOAjpP22PDFVUkHO0p+GwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651570; c=relaxed/simple;
	bh=XJNALVEeWZqFgvjYnRfNvZIquazKlXSr7OWuAbvzdCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqz3jQu4/VvTMMW6Tr6Neh093iZeLzRv3FJy5NeWDap9XB/EdQdOm/7/3jE/Y2jBXSXC6n98dN2gveypG22g4wYmnnZOTDfvT9sD4oQ6Smf9mQW8ACeff1FUs2WAWvWf/lYZHhORfQMm4Agl7RxTdV15Kh6urP/JP8ueldB+lmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=S6NkfUOm; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="S6NkfUOm"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4FC233F20E;
	Wed, 10 Jul 2024 22:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720651557;
	bh=6kNPO1nMCj6jcaNghDa8eoPJmehc9zkJsclk0Q6v6V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=S6NkfUOmKaso9aN3JdlTDnT1KLFYECp7HVTbvSdZt6l1e1TULQtV7BmwwHY9mRt/z
	 GgBqUCBcnKHmTgI/mX2//L4yB5dguVs1BEyuRPDhlvJlONj5S5E297e/mgdv7ZPJre
	 3r9HwsQNJ8vt2UpVseBONRhy2B2FWC7F4GILvx2cOIGEeuQFDpmwWES18TFIekrK6S
	 40u5Aa0FqnFkIe7mMic5qKS0ujt/tdUpJgEenLHgSz5+s0vudv7Luo9nGnWMW88TSI
	 GRKMZnGFchR+gC/Bv2LS657G/WykfBsPZryVxZGA/WN12cYqsTb/dMRuUpQuUFtOcS
	 SLtb3N3Sin51w==
Message-ID: <8b0ae00d-6876-4f44-9e01-10d45550860a@canonical.com>
Date: Wed, 10 Jul 2024 15:45:52 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] LSM: Infrastructure management of the key security
 blob
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240710213230.11978-1-casey@schaufler-ca.com>
 <20240710213230.11978-3-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240710213230.11978-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 14:32, Casey Schaufler wrote:
> Move management of the key->security blob out of the individual security
> modules and into the security infrastructure. Instead of allocating the
> blobs from within the modules the modules tell the infrastructure how
> much space is required, and the space is allocated there.  There are
> no existing modules that require a key_free hook, so the call to it and
> the definition for it have been removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hook_defs.h     |  1 -
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 39 +++++++++++++++++++++++++++++--
>   security/selinux/hooks.c          | 21 ++++-------------
>   security/selinux/include/objsec.h |  7 ++++++
>   security/smack/smack.h            |  7 ++++++
>   security/smack/smack_lsm.c        | 31 +++++++++++-------------
>   7 files changed, 69 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 44488b1ab9a9..cc81f7f7c024 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -402,7 +402,6 @@ LSM_HOOK(int, 0, xfrm_decode_session, struct sk_buff *skb, u32 *secid,
>   #ifdef CONFIG_KEYS
>   LSM_HOOK(int, 0, key_alloc, struct key *key, const struct cred *cred,
>   	 unsigned long flags)
> -LSM_HOOK(void, LSM_RET_VOID, key_free, struct key *key)
>   LSM_HOOK(int, 0, key_permission, key_ref_t key_ref, const struct cred *cred,
>   	 enum key_need_perm need_perm)
>   LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **buffer)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index efd4a0655159..7233bc0737be 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -76,6 +76,7 @@ struct lsm_blob_sizes {
>   	int	lbs_sock;
>   	int	lbs_superblock;
>   	int	lbs_ipc;
> +	int	lbs_key;
>   	int	lbs_msg_msg;
>   	int	lbs_task;
>   	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
> diff --git a/security/security.c b/security/security.c
> index 5e93a72bdca6..92068ebd7e2b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -227,6 +227,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>   	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> @@ -402,6 +403,9 @@ static void __init ordered_lsm_init(void)
>   	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
>   	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
>   	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +#ifdef CONFIG_KEYS
> +	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
> +#endif /* CONFIG_KEYS */
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> @@ -718,6 +722,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_KEYS
> +/**
> + * lsm_key_alloc - allocate a composite key blob
> + * @key: the key that needs a blob
> + *
> + * Allocate the key blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +static int lsm_key_alloc(struct key *key)
> +{
> +	if (blob_sizes.lbs_key == 0) {
> +		key->security = NULL;
> +		return 0;
> +	}
> +
> +	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
> +	if (key->security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +#endif /* CONFIG_KEYS */
> +
>   /**
>    * lsm_msg_msg_alloc - allocate a composite msg_msg blob
>    * @mp: the msg_msg that needs a blob
> @@ -5290,7 +5317,14 @@ EXPORT_SYMBOL(security_skb_classify_flow);
>   int security_key_alloc(struct key *key, const struct cred *cred,
>   		       unsigned long flags)
>   {
> -	return call_int_hook(key_alloc, key, cred, flags);
> +	int rc = lsm_key_alloc(key);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(key_alloc, key, cred, flags);
> +	if (unlikely(rc))
> +		security_key_free(key);
> +	return rc;
>   }
>   
>   /**
> @@ -5301,7 +5335,8 @@ int security_key_alloc(struct key *key, const struct cred *cred,
>    */
>   void security_key_free(struct key *key)
>   {
> -	call_void_hook(key_free, key);
> +	kfree(key->security);
> +	key->security = NULL;
>   }
>   
>   /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 19346e1817ff..986825ba1cc5 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6658,11 +6658,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>   			     unsigned long flags)
>   {
>   	const struct task_security_struct *tsec;
> -	struct key_security_struct *ksec;
> -
> -	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
> -	if (!ksec)
> -		return -ENOMEM;
> +	struct key_security_struct *ksec = selinux_key(k);
>   
>   	tsec = selinux_cred(cred);
>   	if (tsec->keycreate_sid)
> @@ -6670,18 +6666,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>   	else
>   		ksec->sid = tsec->sid;
>   
> -	k->security = ksec;
>   	return 0;
>   }
>   
> -static void selinux_key_free(struct key *k)
> -{
> -	struct key_security_struct *ksec = k->security;
> -
> -	k->security = NULL;
> -	kfree(ksec);
> -}
> -
>   static int selinux_key_permission(key_ref_t key_ref,
>   				  const struct cred *cred,
>   				  enum key_need_perm need_perm)
> @@ -6722,14 +6709,14 @@ static int selinux_key_permission(key_ref_t key_ref,
>   
>   	sid = cred_sid(cred);
>   	key = key_ref_to_ptr(key_ref);
> -	ksec = key->security;
> +	ksec = selinux_key(key);
>   
>   	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
>   }
>   
>   static int selinux_key_getsecurity(struct key *key, char **_buffer)
>   {
> -	struct key_security_struct *ksec = key->security;
> +	struct key_security_struct *ksec = selinux_key(key);
>   	char *context = NULL;
>   	unsigned len;
>   	int rc;
> @@ -6981,6 +6968,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_file = sizeof(struct file_security_struct),
>   	.lbs_inode = sizeof(struct inode_security_struct),
>   	.lbs_ipc = sizeof(struct ipc_security_struct),
> +	.lbs_key = sizeof(struct key_security_struct),
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
>   	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
> @@ -7318,7 +7306,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   #endif
>   
>   #ifdef CONFIG_KEYS
> -	LSM_HOOK_INIT(key_free, selinux_key_free),
>   	LSM_HOOK_INIT(key_permission, selinux_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
>   #ifdef CONFIG_KEY_NOTIFICATIONS
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index b074099acbaf..83b9443d6919 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -195,6 +195,13 @@ selinux_superblock(const struct super_block *superblock)
>   	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
>   }
>   
> +#ifdef CONFIG_KEYS
> +static inline struct key_security_struct *selinux_key(const struct key *key)
> +{
> +	return key->security + selinux_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>   static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
>   {
>   	return sock->sk_security + selinux_blob_sizes.lbs_sock;
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 297f21446f45..dbf8d7226eb5 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -360,6 +360,13 @@ static inline struct socket_smack *smack_sock(const struct sock *sock)
>   	return sock->sk_security + smack_blob_sizes.lbs_sock;
>   }
>   
> +#ifdef CONFIG_KEYS
> +static inline struct smack_known **smack_key(const struct key *key)
> +{
> +	return key->security + smack_blob_sizes.lbs_key;
> +}
> +#endif /* CONFIG_KEYS */
> +
>   /*
>    * Is the directory transmuting?
>    */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a931b44bc959..c57eacf1d3b1 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4473,23 +4473,13 @@ static void smack_inet_csk_clone(struct sock *sk,
>   static int smack_key_alloc(struct key *key, const struct cred *cred,
>   			   unsigned long flags)
>   {
> +	struct smack_known **blob = smack_key(key);
>   	struct smack_known *skp = smk_of_task(smack_cred(cred));
>   
> -	key->security = skp;
> +	*blob = skp;
>   	return 0;
>   }
>   
> -/**
> - * smack_key_free - Clear the key security blob
> - * @key: the object
> - *
> - * Clear the blob pointer
> - */
> -static void smack_key_free(struct key *key)
> -{
> -	key->security = NULL;
> -}
> -
>   /**
>    * smack_key_permission - Smack access on a key
>    * @key_ref: gets to the object
> @@ -4503,6 +4493,8 @@ static int smack_key_permission(key_ref_t key_ref,
>   				const struct cred *cred,
>   				enum key_need_perm need_perm)
>   {
> +	struct smack_known **blob;
> +	struct smack_known *skp;
>   	struct key *keyp;
>   	struct smk_audit_info ad;
>   	struct smack_known *tkp = smk_of_task(smack_cred(cred));
> @@ -4540,7 +4532,9 @@ static int smack_key_permission(key_ref_t key_ref,
>   	 * If the key hasn't been initialized give it access so that
>   	 * it may do so.
>   	 */
> -	if (keyp->security == NULL)
> +	blob = smack_key(keyp);
> +	skp = *blob;
> +	if (skp == NULL)
>   		return 0;
>   	/*
>   	 * This should not occur
> @@ -4556,8 +4550,8 @@ static int smack_key_permission(key_ref_t key_ref,
>   	ad.a.u.key_struct.key = keyp->serial;
>   	ad.a.u.key_struct.key_desc = keyp->description;
>   #endif
> -	rc = smk_access(tkp, keyp->security, request, &ad);
> -	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
> +	rc = smk_access(tkp, skp, request, &ad);
> +	rc = smk_bu_note("key access", tkp, skp, request, rc);
>   	return rc;
>   }
>   
> @@ -4572,11 +4566,12 @@ static int smack_key_permission(key_ref_t key_ref,
>    */
>   static int smack_key_getsecurity(struct key *key, char **_buffer)
>   {
> -	struct smack_known *skp = key->security;
> +	struct smack_known **blob = smack_key(key);
> +	struct smack_known *skp = *blob;
>   	size_t length;
>   	char *copy;
>   
> -	if (key->security == NULL) {
> +	if (skp == NULL) {
>   		*_buffer = NULL;
>   		return 0;
>   	}
> @@ -5010,6 +5005,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>   	.lbs_file = sizeof(struct smack_known *),
>   	.lbs_inode = sizeof(struct inode_smack),
>   	.lbs_ipc = sizeof(struct smack_known *),
> +	.lbs_key = sizeof(struct smack_known *),
>   	.lbs_msg_msg = sizeof(struct smack_known *),
>   	.lbs_sock = sizeof(struct socket_smack),
>   	.lbs_superblock = sizeof(struct superblock_smack),
> @@ -5146,7 +5142,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>    /* key management security hooks */
>   #ifdef CONFIG_KEYS
>   	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
> -	LSM_HOOK_INIT(key_free, smack_key_free),
>   	LSM_HOOK_INIT(key_permission, smack_key_permission),
>   	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
>   #ifdef CONFIG_KEY_NOTIFICATIONS

