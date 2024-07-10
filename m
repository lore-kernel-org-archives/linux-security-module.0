Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5D1487C5
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653066; cv=none; b=Ei2/vwn94WAeKD7xBTahSUNMK2JRdQEDYgPM/bDaHPRKYgbkMKGn9zwwOQ86TBtjNlq/H0bWV+d3RPw3gMM/VOcouxbKwba/59hoegqV9IJp8W7wAu4SFa83XUttieQK1/vD6VqsQ28v9tHDZlU8vxS3lrDuWBPufVSBQYo4umI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653066; c=relaxed/simple;
	bh=e77Q6AvOB4dDYAjvXIVPvsZbMoVv+VPFfSmRlTHwJiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QM9bj0AGDT8Y/0c1GH+4s7IBmuBxPdQ3NsHExl8cjsRVN9gsSBYayrjJX2OLvxOEoLDxYgKKHUb/okJK4yxSk6ZVlYcV5/0paOrRGgjfiis1W8xlRFyK8nUdMyvqZvu0xQnLaUqQml6MkThb8PHkB/qUxe7CA+ts7WJlhaRkpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FfmiZAMp; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FfmiZAMp"
Received: from [192.168.192.84] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B3C0840A68;
	Wed, 10 Jul 2024 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720653059;
	bh=gTDPWeTx8Gkx9n0XiKCfSh6JeIkJc3oYA0gT/dack1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=FfmiZAMpFR9hAE68xhXxUZMkemhhd7THm5yZwT293JFnpvVWgU0iMD3asKHxy51xD
	 AJ/v2Px9eJpizPwB1gbI+oiXMZpCOhEMwPNysAy/pR7V61RpXCf4HSmhmwLMLraEHX
	 DE87BXx9azICqQOWEXZ3nyfulaGIKPsXOJt2XXqdsu2s4hAboG0dXnsIuCNbuKJXRB
	 bWE6r5tRkAqc81nSIcQdsS+U0k+MEsZNXGYtIqUYFYaIfWvQSf0TpP2+Fz1is47KhW
	 KpMZJ7wXmVcc1hp0kgITePT9Mc6+k0WGfFzhQtmHl2igSv6A0h2L9nNIscFtRRhoV4
	 0XN/k61DQtkCQ==
Message-ID: <5ad05864-2b0b-434c-a726-ef327b54a08a@canonical.com>
Date: Wed, 10 Jul 2024 16:10:55 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] LSM: Infrastructure management of the perf_event
 security blob
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net
References: <20240710213230.11978-1-casey@schaufler-ca.com>
 <20240710213230.11978-7-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240710213230.11978-7-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 14:32, Casey Schaufler wrote:
> Move management of the perf_event->security blob out of the individual
> security modules and into the security infrastructure. Instead of
> allocating the blobs from within the modules the modules tell the
> infrastructure how much space is required, and the space is allocated
> there.  There are no longer any modules that require the perf_event_free()
> hook.  The hook definition has been removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

looks good

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hook_defs.h     |  1 -
>   include/linux/lsm_hooks.h         |  1 +
>   security/security.c               | 20 ++++++++++++++++++--
>   security/selinux/hooks.c          | 18 ++++--------------
>   security/selinux/include/objsec.h |  6 ++++++
>   5 files changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7c979137c0f2..658e4ba282e6 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -438,7 +438,6 @@ LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>   #ifdef CONFIG_PERF_EVENTS
>   LSM_HOOK(int, 0, perf_event_open, struct perf_event_attr *attr, int type)
>   LSM_HOOK(int, 0, perf_event_alloc, struct perf_event *event)
> -LSM_HOOK(void, LSM_RET_VOID, perf_event_free, struct perf_event *event)
>   LSM_HOOK(int, 0, perf_event_read, struct perf_event *event)
>   LSM_HOOK(int, 0, perf_event_write, struct perf_event *event)
>   #endif /* CONFIG_PERF_EVENTS */
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
> index e8f34cbb1990..444b0ea28c04 100644
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
> @@ -230,6 +231,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>   	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>   	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
>   	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> @@ -412,6 +414,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>   	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>   	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>   	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
> @@ -5659,7 +5662,19 @@ int security_perf_event_open(struct perf_event_attr *attr, int type)
>    */
>   int security_perf_event_alloc(struct perf_event *event)
>   {
> -	return call_int_hook(perf_event_alloc, event);
> +	int rc;
> +
> +	rc = lsm_blob_alloc(&event->security, blob_sizes.lbs_perf_event,
> +			    GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +
> +	rc = call_int_hook(perf_event_alloc, event);
> +	if (rc) {
> +		kfree(event->security);
> +		event->security = NULL;
> +	}
> +	return rc;
>   }
>   
>   /**
> @@ -5670,7 +5685,8 @@ int security_perf_event_alloc(struct perf_event *event)
>    */
>   void security_perf_event_free(struct perf_event *event)
>   {
> -	call_void_hook(perf_event_free, event);
> +	kfree(event->security);
> +	event->security = NULL;
>   }
>   
>   /**
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 11f4bdabda97..f42f6af55a73 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6950,6 +6950,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>   	.lbs_ipc = sizeof(struct ipc_security_struct),
>   	.lbs_key = sizeof(struct key_security_struct),
>   	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +#ifdef CONFIG_PERF_EVENTS
> +	.lbs_perf_event = sizeof(struct perf_event_security_struct),
> +#endif
>   	.lbs_sock = sizeof(struct sk_security_struct),
>   	.lbs_superblock = sizeof(struct superblock_security_struct),
>   	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
> @@ -6981,24 +6984,12 @@ static int selinux_perf_event_alloc(struct perf_event *event)
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
> @@ -7310,7 +7301,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
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

