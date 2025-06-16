Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F490214818
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107296; cv=none; b=BYmUv9640AkIFmusEsCKyunFzu8yRGdytYGHQWCKm8Y7JN0LknSnP62ja0CyqJqlUSUjgyVruA5WPxKRQavG+eIEu0pTx9GES1oRIaxcPigMdv0uLeKBVYWvSoW2fJqhPzt7FpZM0F9Ptkw3wq93Wzi96e/gniJVGwA1q//X9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107296; c=relaxed/simple;
	bh=WeFHWq34W+43H6uratRZJiRVhMyQ1JfCVFX3Ws23nEc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=JPr+8bW/z3lS8oeFyj4OzmBIQWgHgK4Br5I/QOSaefs+inhe6DZwEQuvBwyoNT01pb5D5nx1rCT/VkqZOzJFlJtSgstaH6rUuzs69O/kdzxuCbbUGDM3h9lLmwZMBN4dDUlRLbIsEOkxFRr7nMJgnBBb68ErwGDRBuFeAcwqqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ANJRJ1y5; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ANJRJ1y5"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fac7147cb8so93779726d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750107292; x=1750712092; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmlqvh0W8yQgpBh47gMPvcslIqX+GzMv2+xmELRJNcc=;
        b=ANJRJ1y56Qn0V1f4dsxcFeSjGolPKL6AMmdFnG2LHWou54PMXUygKDJYWKBsEyjzfD
         v2fgr5xFSVSYIhE4PoRCm3pAiz4pPSK5AwcjkdYIRt/RJGmOYCkp1Ck0hnkATqVPv5UF
         QnMndW0WdwR5TH7ATpEzwtUggetMdi0RRov7CPoX+6Z1JJfnkrYXTALBcz4U1zdI3JwI
         3g9/adKy8NRu/lrVcQeHE3kkde5Pn+LyoLX0tPenHncp2RzLzM3XicKgLAUKbruwTgCu
         kJo9ps+PhLpKBAzX9BW1+M5xhmRXrgmCO4baIZvxhCpACLAwp85AxHlya97qAbT9uUsv
         0XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107292; x=1750712092;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gmlqvh0W8yQgpBh47gMPvcslIqX+GzMv2+xmELRJNcc=;
        b=SkMhmRjaVew/apfpifQQBEcCukGGIelotdEZh/Ds5V9yeRQ/r1Qml2xirrCwzVUoj/
         ky8kivZUEFxiGsfGKBi6HWV44NiTvEa2WgPCZFU8KGsAtXZmbi5z4VQpobTlfaLSHo6b
         fLO8eHiS2a6hitcfE5Mg966Kbm4y5lfolpWXC09aEiZFN1CvkR6GRPO28YikqQkwxz6M
         iPW3ndcYqMMop0yxm0SzvcSUSu5UHKiAlOdAzyXpD91jlVkf7MKyc5mhJd1hicSD2tf4
         6vysuAFYia+jWLKoVx/rxddVcjKjwk3kwQfQi9kJP1XPlLd4cHwRrAqkzLW0zUyPZN+c
         Pu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFaGG8wtuU/+tX3WL1nGi8z8rxdT3XEll4ghwm90pxfm0EvZoLIAcnQvyDkuL2H8NHcnWzf7sYkXvZBHZkxq56NlcJIyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmTmAwPvMo1RvXjuQfFxxNmNnHU/hTlh9KOn3ytSm46eULtS1
	72JlKUPlxOe4/lppOrB2iFBd1Mobf9QO5JlCaUnPg84dtyDDKkFCcStZXKXagqY6GQ==
X-Gm-Gg: ASbGnctXi2PSN4ablLX8r/9EgWNthAl2UtqzadjvrrLEcUasSVFxUpvy/EgzgQthyRC
	SVA9takjcEQXpeF2riMJqFwCi+jPbAteFhQNsXEYS+8vjzm7pGWaeG3FXFPdYPmDms8PJB5Rhkp
	iMr0J+bhJcMcL6kh4cWGTzVFIbEsr5ejB4dciGTTKaa3gU/ng88U5nLtaj3VW+MVgjkSFuEUEVW
	IUb1aJ839I/idstLRiUJhpOxeFUlBTTQl39969gGK51Oup+3gdAeeoAAh9b77SetWIcy8cyEBNE
	/rCpa0sZGJUS6KCX1V7SbCIfHbPft+NB1Nee67XB39ZOEu8kkbI233k5qt+en3YOPynijOVOXYv
	2H7xaj5KeBb4dGtsC4x7NDNv3VeHyWjs=
X-Google-Smtp-Source: AGHT+IH9wYJP22fHEP6zvq6Q4jGcwiVsEcuwUMqWYcxJ0AqQEi9Vb3A4NCKYu8LejemwOPJBvXmMkA==
X-Received: by 2002:ad4:5d6c:0:b0:6fa:fea5:4d7c with SMTP id 6a1803df08f44-6fb478028fcmr183027716d6.40.1750107292012;
        Mon, 16 Jun 2025 13:54:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb5759b5d7sm12194646d6.15.2025.06.16.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:54:51 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:54:51 -0400
Message-ID: <fc242f4c853fee16e587e9c78e1f282e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250616_1212/pstg-lib:20250616_1001/pstg-pwork:20250616_1212
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v4 3/4] Audit: Add record for multiple task security  contexts
References: <20250607005134.10488-4-casey@schaufler-ca.com>
In-Reply-To: <20250607005134.10488-4-casey@schaufler-ca.com>

On Jun  6, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/lsm.h               |   4 -
>  security/lsm_init.c          |   5 -
>  security/security.c          |   3 -
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  10 files changed, 202 insertions(+), 52 deletions(-)

...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 0050ef288ab3..5020939fb8bc 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -37,6 +37,8 @@ struct audit_watch;
>  struct audit_tree;
>  struct sk_buff;
>  struct kern_ipc_perm;
> +struct lsm_id;
> +struct lsm_prop;
>  
>  struct audit_krule {
>  	u32			pflags;
> @@ -147,6 +149,9 @@ extern unsigned compat_signal_class[];
>  #define AUDIT_TTY_ENABLE	BIT(0)
>  #define AUDIT_TTY_LOG_PASSWD	BIT(1)
>  
> +/* bit values for audit_lsm_secctx */
> +#define AUDIT_SECCTX_SUBJECT	BIT(0)

More on naming below, but how about AUDIT_CFG_LSM_SECCTX_SUBJ?

> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 9a4ecc9f6dc5..8cad2f307719 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -148,6 +148,7 @@
>  #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
>  #define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
>  #define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
> +#define AUDIT_MAC_TASK_CONTEXTS	1425	/* Multiple LSM task contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 6bbadb605ca3..0987b2f391cc 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -278,6 +286,27 @@ static pid_t auditd_pid_vnr(void)
>  	return pid;
>  }
>  
> +/**
> + * audit_lsm_secctx - Identify a security module as providing a secctx.
> + * @lsmid: LSM identity
> + * @flags: which contexts are provided
> + *
> + * Description:
> + * Increments the count of the security modules providing a secctx.
> + * If the LSM id is already in the list leave it alone.
> + */
> +void audit_lsm_secctx(const struct lsm_id *lsmid, int flags)
> +{
> +	int i;
> +
> +	if (flags & AUDIT_SECCTX_SUBJECT) {
> +		for (i = 0 ; i < audit_subj_secctx_cnt; i++)
> +			if (audit_subj_lsms[i] == lsmid)
> +				return;
> +		audit_subj_lsms[audit_subj_secctx_cnt++] = lsmid;
> +	}
> +}

Naming is hard ... but since this function has nothing to do with logging
the current state of execution, and is instead more about signaling and
configuring audit, let's try and make that a bit more clear in the
function name while also not getting us stuck with just a secctx config.

How about "audit_cfg_lsm(...)"?

> +/**
> + * audit_log_subj_ctx - Add LSM subject information
> + * @ab: audit_buffer
> + * @prop: LSM subject properties.
> + *
> + * Add a subj= field and, if necessary, a AUDIT_MAC_TASK_CONTEXTS record.
> + */
> +int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
>  {
> -	struct lsm_prop prop;
>  	struct lsm_context ctx;
> +	char *space = "";
>  	int error;
> +	int i;
>  
> -	security_current_getlsmprop_subj(&prop);
> -	if (!lsmprop_is_set(&prop))
> +	security_current_getlsmprop_subj(prop);
> +	if (!lsmprop_is_set(prop))
>  		return 0;
>  
> -	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
> -	if (error < 0) {
> -		if (error != -EINVAL)
> -			goto error_path;
> +	if (audit_subj_secctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return 0;
> +		}
> +		audit_log_format(ab, " subj=%s", ctx.context);
> +		security_release_secctx(&ctx);
>  		return 0;
>  	}
> -
> -	audit_log_format(ab, " subj=%s", ctx.context);
> -	security_release_secctx(&ctx);
> +	/* Multiple LSMs provide contexts. Include an aux record. */
> +	audit_log_format(ab, " subj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < audit_subj_secctx_cnt; i++) {
> +		error = security_lsmprop_to_secctx(prop, &ctx,
> +						   audit_subj_lsms[i]->id);
> +		if (error < 0) {
> +			/*
> +			 * Don't print anything. An LSM like BPF could
> +			 * claim to support contexts, but only do so under
> +			 * certain conditions.
> +			 */
> +			if (error == -EOPNOTSUPP)
> +				continue;
> +			if (error != -EINVAL)
> +				audit_panic("error in audit_log_task_context");

Wrong function name, maybe use __func__ or something similar.

> +		} else {
> +			audit_log_format(ab, "%ssubj_%s=%s", space,
> +					 audit_subj_lsms[i]->name, ctx.context);
> +			space = " ";
> +			security_release_secctx(&ctx);
> +		}
> +	}
> +	audit_buffer_aux_end(ab);
>  	return 0;
>  
>  error_path:
> -	audit_panic("error in audit_log_task_context");
> +	audit_panic("error in audit_log_subj_ctx");
>  	return error;
>  }
> +EXPORT_SYMBOL(audit_log_subj_ctx);

...

> @@ -2423,25 +2575,16 @@ int audit_signal_info(int sig, struct task_struct *t)
>  void audit_log_end(struct audit_buffer *ab)
>  {
>  	struct sk_buff *skb;
> -	struct nlmsghdr *nlh;
>  
>  	if (!ab)
>  		return;
>  
> -	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);
>  
> -		/* setup the netlink header, see the comments in
> -		 * kauditd_send_multicast_skb() for length quirks */
> -		nlh = nlmsg_hdr(skb);
> -		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
> -
> -		/* queue the netlink packet and poke the kauditd thread */
> -		skb_queue_tail(&audit_queue, skb);
> +	/* poke the kauditd thread */
> +	if (audit_rate_check())
>  		wake_up_interruptible(&kauditd_wait);
> -	} else
> -		audit_log_lost("rate limit exceeded");
>  
>  	audit_buffer_free(ab);
>  }

Don't make wake_up_interruptible() dependent on audit_rate_check(),
wake up the kauditd thread regardless.  Yes, arguably there will be
some cases where the wake will likely be unnecessary, but
audit_rate_check() exists to limit the number of records emitted by
the kernel which is being handled in __audit_log_end(); we don't want
to limit waking the kauditd thread.  There is also the issue of the
spin lock which we should try to minimize.

If you're really bothered by calling wake_up_interruptible() without
taking into account if any records have been queued, you could always
have __audit_log_end() return a count/flag/etc. to indicate if any
records have been queued for kauditd, but I suspect that's more
trouble than it's worth.

--
paul-moore.com
