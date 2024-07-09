Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4E1474BE
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568833; cv=none; b=FZuiQsLQpPOAqW4ymvQECHUa0bqflEgX1ujBGOd0GntMW74gxqTNFJRC4xwOyKk/y1K7VTv8mBzO+dqyz3eUBZEvo8asHGvhwtvWn7Gct/vM4ENEix9caTgKX3UK/LXceUXiUaAASt9kmPoA6qVuTv+3ul2r7rjTcU5LqGbxKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568833; c=relaxed/simple;
	bh=DOdkezCRGjW4vCA0QreYiTudYjvVlX5pCKMzIQJNPVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPkYzOK+M8h4zIV84s49KY80ta5hztHbpX6TyIEp8llTXHTFFHs342FEH36A0FW9jYw32WS0nQ9XgelJRoQAYALbimpbYts+cTAw1phAacSN0mWPL2tlj9WYzaNtc241Y1luOmVdoSrkzozltlmh0I7Ge58EnxDtkFb3B64fOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rxMscYt+; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rxMscYt+"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9769240D7C;
	Tue,  9 Jul 2024 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720568828;
	bh=WBedXmkJ61yYj6zEeAvfFzydRMhh6LJ+jXh0i6nSOKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=rxMscYt+gE8ET5rTGIg4yERC2I/UCaNLpRB43VWabOOiKyG6hyY4HSK/nT9THDhus
	 sWE/KS/SEEivgF6F929l3cNFlBqZM/eSROSuGuTDNONFvfmMqcjOlJQscdQqXOQ3ZV
	 PeJ3NPMdkRoXbiFItqTq+WZys507LMIuevDDbO3xYVLgN1lCoCnIWlxB0chU5irAsZ
	 DvaxlRdF3sJA4XKnRL/7DVLQFeX8rkAgXEbB9aR2HkRm6fToVK0LbxfKrHT0EIgKtg
	 /wzbCsz3c0dxdpBLPPfUq3R/bzYvgMFQcBq7zSCogfmWta/yrLowOKUw9HnfJ83mVh
	 M93pH8JJWyANA==
Message-ID: <76721989-04e1-4b30-ae82-eec4f0bcce4c@canonical.com>
Date: Tue, 9 Jul 2024 16:47:04 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] LSM: Infrastructure management of the perf_event
 security blob
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-7-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240708213957.20519-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/24 14:39, Casey Schaufler wrote:
> Move management of the perf_event->security blob out of the individual
> security modules and into the security infrastructure. Instead of
> allocating the blobs from within the modules the modules tell the
> infrastructure how much space is required, and the space is allocated
> there.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

again, issue below, and other than Paul's point about the free hook the
rest looks good

> ---
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 12 ++++++++++++
>   security/selinux/hooks.c          | 18 ++++--------------
>   security/selinux/include/objsec.h |  6 ++++++
>   4 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index b6fc6ac88723..f1ca8082075a 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -79,6 +79,7 @@ struct lsm_blob_sizes {
>   	int	lbs_ipc;
>   	int	lbs_key;
>   	int	lbs_msg_msg;
> +	int	lbs_perf_event;
>   	int	lbs_task;
>   	int	lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>   	int	lbs_tun_dev;
> diff --git a/security/security.c b/security/security.c
> index 731a54fabc79..da2111f8d9df 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,6 +28,7 @@
>   #include <linux/xattr.h>
>   #include <linux/msg.h>
>   #include <linux/overflow.h>
> +#include <linux/perf_event.h>
>   #include <net/flow.h>
>   #include <net/sock.h>
>   
> @@ -232,6 +233,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
>   #endif
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> @@ -414,6 +416,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>   	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>   	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> @@ -5653,6 +5656,13 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
>    */
>   int security_perf_event_alloc(struct perf_event *event)
>   {
> +	int rc;
> +
> +	rc = lsm_blob_alloc(&event->security, blob_sizes.lbs_perf_event,
> +			    GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +

again similar issue. While free_event_rcu() is called that one doesn't
actually take care of the security field

>   	return call_int_hook(perf_event_alloc, event);
>   }
>   
> @@ -5665,6 +5675,8 @@ int security_perf_event_alloc(struct perf_event *event)
>   void security_perf_event_free(struct perf_event *event)
>   {
>   	call_void_hook(perf_event_free, event);
> +	kfree(event->security);
> +	event->security = NULL;
>   }
>   
>   /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 79fe75603881..d1d6adfdfbc7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6952,6 +6952,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_key = sizeof(struct key_security_struct),
>   #endif /* CONFIG_KEYS */
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +#ifdef CONFIG_PERF_EVENTS
> +	.lbs_perf_event = sizeof(struct perf_event_security_struct),
> +#endif
>   	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
> @@ -6983,24 +6986,12 @@ static int selinux_perf_event_alloc(struct perf_event *event)
>   {
>   	struct perf_event_security_struct *perfsec;
>   
> -	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
> -	if (!perfsec)
> -		return -ENOMEM;
> -
> +	perfsec = selinux_perf_event(event->security);
>   	perfsec->sid = current_sid();
> -	event->security = perfsec;
>   
>   	return 0;
>   }
>   
> -static void selinux_perf_event_free(struct perf_event *event)
> -{
> -	struct perf_event_security_struct *perfsec = event->security;
> -
> -	event->security = NULL;
> -	kfree(perfsec);
> -}
> -
>   static int selinux_perf_event_read(struct perf_event *event)
>   {
>   	struct perf_event_security_struct *perfsec = event->security;
> @@ -7312,7 +7303,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>   
>   #ifdef CONFIG_PERF_EVENTS
>   	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
> -	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
>   	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
>   	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
>   #endif
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index b1878f9395b5..d632a9180b41 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -219,4 +219,10 @@ selinux_ib(void *ib_sec)
>   	return ib_sec + selinux_blob_sizes.lbs_ib;
>   }
>   
> +static inline struct perf_event_security_struct *
> +selinux_perf_event(void *perf_event)
> +{
> +	return perf_event + selinux_blob_sizes.lbs_perf_event;
> +}
> +
>   #endif /* _SELINUX_OBJSEC_H_ */

