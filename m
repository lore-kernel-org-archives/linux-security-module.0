Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F2403EA1
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428422; cv=none; b=VazK1FkBRY+P2eqXFRZBkbhF5lM5x7CU3yfyJVsGDi4NVGFIteOWb9+HXu5T8h4HEaWV+e+gCGuz4OO7bjF2A87bAFQVRsAkqBvL9u6tWgl3sSE/ujW/GXYKjRI3imslwm7KmLCXl3EcKC2dwDlC1g2kHiiMvNEiiPhAsk6Ql9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428422; c=relaxed/simple;
	bh=RVY5KRyKZZG2Y+gJh7LxXAAi3xdCkxmVkaTQ446fAwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb29wi5uxBxctKf8oWLQ5yp5LCN3H98MvsPVXa9fAoXv78LPcPPW2O1ONOOQT+vgwG4RMZk0faD+1xq1nbe3s2HYlne/b97jbdArSDKgrtv/4oG7BxohU4U8sV8XOof0le4h7tf0zKcFF/f3ZGT7rnsf3H2TeSC+1YPQi+Xy23I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=NnRYiOAu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="NnRYiOAu"
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E1954293C
	for <linux-security-module@vger.kernel.org>; Thu,  3 Sep 2026 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788428418;
	bh=UnqC0vVCveGL8BfKzx1mgmJlLA7UfcDCGVJE34qJcis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=NnRYiOAuXVs6LhpWCvOWLJrBbVsxRoNOg7vP6ovVcsk2+3/xgnbwIsChB4ygUKSCh
	 DWA7ub5zMoKCQPmeG9UZCfpBZ2o8IgaB0peccHwHvpoRExG+ZHdwuJp1rXQ0rACXWk
	 1EXJkcvmbp/BP16cmmY7YOCnN8wOuF03qk4Jv0cCZI1GN0LkUkDJBaJLUu8nUBR+Vc
	 d6nW7/+FT5Izq1w6aLj4a+kuHsueUbF2z2Od/hD9k3ZlVne/+tky3gnqDRrf4dRZ3r
	 KZwvm1WgSEC0qERLzS3NQSKO0YJMq81x+FMkqHGFvnNryGalbGw5CDMR/oKcfbRvCY
	 OD/wcg5VC9X91BSf0F+vn9AXHUKNWVTDnQvGeR0tNN24xQ89qFYy5FgNHPKbyvs56x
	 K/5k9VA2WrJdAW5Shz7HAp55L6RylKo06dquDNuAuSlXrAOVInQRipOyh7bEVKahSu
	 zjUKIgPSL1y6+07MQjBdKnaVQ5O3P8gcl6C/O58Lv/AZLCdt1gGYQ1e3FMT6S9LCf4
	 72loptRoEQZwqpbsI6al7Q7WTAklN27ZjHowKEHhXJU1tIU75v2SOZ2iEid/BWKWo2
	 79ATPPMPbJiMOOEBQQDXwDmwljkaP9k2daI86LfJbhGuRPqklxu8jbngRnEVrMBfnd
	 sWVOomGJCGFTsmiZL3kKn3yU=
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85f1f3620bcso903957b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 03 Sep 2026 02:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788428416; x=1789033216;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UnqC0vVCveGL8BfKzx1mgmJlLA7UfcDCGVJE34qJcis=;
        b=kVQLgnqkqTwgQm+OgXKGKeBpt4X/FnZ7jSkW5HjFWdWo5B01ORDMQOjGmyaiP5O/H2
         QoF7eFBO5wxmz4IChVQR1ryl8FZgUWf/z9QzyDyrpDuv0Y7xMgtDySTeqZY5p0XcJopl
         MryC7NskCbcAhL3ijoiK4t+rEoB1U2ZnW358U8K3tKl2/uMnldUBmWi9J9t8wuKDBJyF
         WcrGIUX4YH2Od7ccauHReq/n0BaM7FX8IYQqdWJhPUNJsmwZv6oBekNrMZE1L99R3v13
         a6HrKllJ6oMs4c/zh/sWwvFCyyFQG8MerZBlANn4OGcXFXA0q3KNSxdSvdP3QCSpGroM
         GeBg==
X-Forwarded-Encrypted: i=1; AKwUvBz5Kwv9Wo95n8gD3xMA7EJw2IcznlzAkgOc8tXXArH/jNrOTmJlqQ5lhgZ3QpJVXfmtCkPFU9uKPqr6byAitrwCUYoaH20=@vger.kernel.org
X-Gm-Message-State: AFuF++mkyn3tb3bFTKzC/0IDiEApbXn1+RhoJNqP0AXmyaKqiNIhZK9J
	B6i5E4wfjVXGz6XTJ8ST1G8yTPGNKXjuIXkw17EO74x7zDIfnX7L7dntCeyj0qsByKFR25XjuA3
	c0K2HSSk6uN59CgP3Nv0K+C/p5HgnSzDINSHUU3AKdP+EBx4TPW5t15f8Llt3uJmYXCFGPEYZko
	hVHWeYrwZwCbh7/IdArQ==
X-Gm-Gg: AYBFou2nUqUqGGbzZp8ky6RVXrLbEFXXXNvU1NqEQ2y7OvuFReSn3Q3pIHChnUtjJ9H
	4WRjOLsDxa/L64GlG6TaX0QK/PzptInweOuGTuB10Nbht7qWPAGFdbTqDj10EKoXzLL3p1lYMKX
	v5Lim7Eh7DP5TtWyicetZtmq7N5W2NMIrbrlIFI3a8Ilr6opyjhWf5gMCMXNRqE0Y2tRO6riUqd
	sHZd0XWVASVV5OJ71wDOqyIzmA9W/HhL9a7J1bLOYJyKJm2fHxF1SQnXC6S19o7woJLPKJ+dCZ2
	bX5aeR5nl1CjJcXCEXbgVy1smzdijaFb1VEosHkIoN/JNXKFHzk1dl61XFcrlM9keUpS6ldpXC3
	CMByZ5U+LMFi+GnM=
X-Received: by 2002:a05:6a00:6c8d:b0:848:48d0:934 with SMTP id d2e1a72fcca58-85ffe10a034mr4079636b3a.18.1788428416586;
        Thu, 03 Sep 2026 02:40:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c8d:b0:848:48d0:934 with SMTP id d2e1a72fcca58-85ffe10a034mr4079592b3a.18.1788428416154;
        Thu, 03 Sep 2026 02:40:16 -0700 (PDT)
Received: from [192.168.192.72] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-85db24f20besm2739047b3a.7.2026.09.03.02.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 02:40:15 -0700 (PDT)
Message-ID: <5502dfbf-29cb-4ed3-b635-44d3bda80d60@canonical.com>
Date: Thu, 3 Sep 2026 02:40:14 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] LSM: Two hooks for manipulating struct lsm_prop
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org, pablo@netfilter.org, fw@strlen.de,
 phil@nwl.cc
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, jmorris@namei.org, serge@hallyn.com,
 keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, selinux@vger.kernel.org
References: <20260902220150.18586-1-casey@schaufler-ca.com>
 <20260902220150.18586-4-casey@schaufler-ca.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20260902220150.18586-4-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 15:01, Casey Schaufler wrote:
> security_update_lsmprop() updates the property of the
> specified LSM in the @dest structure with that in the @src.
> 
> security_secctx_to_lsmprop() sets the @prop field associated
> with the LSM specified to the value of the passed security
> context.
> 
> LSM specific implementations of these hooks to follow.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

lgtm

Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/lsm_hook_defs.h |  4 ++++
>   include/linux/security.h      | 16 ++++++++++++++++
>   security/security.c           | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 65c9609ec207..679c40a8e127 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -305,7 +305,11 @@ LSM_HOOK(int, 0, ismaclabel, const char *name)
>   LSM_HOOK(int, -EOPNOTSUPP, secid_to_secctx, u32 secid, struct lsm_context *cp)
>   LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
>   	 struct lsm_context *cp)
> +LSM_HOOK(void, LSM_RET_VOID, update_lsmprop, struct lsm_prop *dest,
> +	 struct lsm_prop *src, int lsmid)
>   LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
> +LSM_HOOK(int, -EINVAL, secctx_to_lsmprop, const char *secdata, u32 seclen,
> +	 struct lsm_prop *prop)
>   LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
>   LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
>   LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 153e9043058f..19adc19eb9af 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -576,6 +576,11 @@ int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
>   int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
>   			       int lsmid);
>   int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
> +int security_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop, int lsmid);
> +
> +void security_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +			     int lsmid);
>   void security_release_secctx(struct lsm_context *cp);
>   void security_inode_invalidate_secctx(struct inode *inode);
>   int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
> @@ -1581,6 +1586,11 @@ static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline void security_update_lsmprop(struct lsm_prop *dest,
> +					   struct lsm_prop *src, int lsmid)
> +{
> +}
> +
>   static inline int security_secctx_to_secid(const char *secdata,
>   					   u32 seclen,
>   					   u32 *secid)
> @@ -1588,6 +1598,12 @@ static inline int security_secctx_to_secid(const char *secdata,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int security_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +					     struct lsm_prop *prop, int lsmid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline void security_release_secctx(struct lsm_context *cp)
>   {
>   }
> diff --git a/security/security.c b/security/security.c
> index 71aea8fdf014..1dec0037370b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3965,6 +3965,13 @@ int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
>   }
>   EXPORT_SYMBOL(security_lsmprop_to_secctx);
>   
> +void security_update_lsmprop(struct lsm_prop *dest, struct lsm_prop *src,
> +			     int lsmid)
> +{
> +	call_void_hook(update_lsmprop, dest, src, lsmid);
> +}
> +EXPORT_SYMBOL(security_update_lsmprop);
> +
>   /**
>    * security_secctx_to_secid() - Convert a secctx to a secid
>    * @secdata: secctx
> @@ -3982,6 +3989,31 @@ int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>   }
>   EXPORT_SYMBOL(security_secctx_to_secid);
>   
> +/**
> + * security_secctx_to_lsmprop() - Convert a secctx to a lsmprop
> + * @secdata: secctx
> + * @seclen: length of secctx
> + * @prop: prop
> + * @lsmid: which LSM the context is appropriate to.
> + *
> + * Convert security context to an lsmprop.
> + *
> + * Return: Returns 0 on success, error on failure.
> + */
> +int security_secctx_to_lsmprop(const char *secdata, u32 seclen,
> +			       struct lsm_prop *prop, int lsmid)
> +{
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, secctx_to_lsmprop) {
> +		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
> +			continue;
> +		return scall->hl->hook.secctx_to_lsmprop(secdata, seclen, prop);
> +	}
> +	return LSM_RET_DEFAULT(secctx_to_lsmprop);
> +}
> +EXPORT_SYMBOL(security_secctx_to_lsmprop);
> +
>   /**
>    * security_release_secctx() - Free a secctx buffer
>    * @cp: the security context

