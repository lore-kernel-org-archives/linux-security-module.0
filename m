Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923783;
	b=K8ezASEu5IZ2NqBg3jeJimAPScoynH2cCcbBI6VsW1zh+XoKdBy2cm8C3Ff5BRPV2lJr
	 mz2rz9VHv/VRwl5WVxXQF5znRugIMVz0reAy1Lpp+1nzXMdO/3ZFC8aLTaOqZaSZ2PCDW
	 76CC5GtnXoiaf9IVfWII5tHNlb/3Ze5dINDVJONw5rThIvCoXcASERCz0OWN33mSnhxol
	 1vsuLXnbYXZC2dnnc/t7a0A6strkMKZQMxnyv/sRHslyaGC0QU1S/l4ynw8XKpJzmXmLx
	 Z1AKld9SmEpJdTdaVqkhS8eEKnNir+OClRgoOyk5PioLTkY39xUuYZ6z9OceK5kMppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=TrARtNuZPl0Lpgj7SQ8LbGOsanuNPRyo5Y7yT6NLi14=;
	b=XnFGfDFNk78oCV6LbvsSJ46+Fc+BAe9TzSNj5fnF7V3hUI+X1NjzH6t+t/KBY9PM25zX
	 6jIYuWzCUFOut4edJfhZp4JHMSQWZvdkK8TvBmHRoqP1wiYARz0lALXsj4UnwAmLQmgPR
	 J6KkvmtLfAqe9fFAIiXjgAmRX+ci/WSi77Hrxu61uBaQCLBThsKoiAAfXxGm6dvglfW/T
	 YNmONTXvxXdewI13vZL71Ts9ZwsGhUwz/wPqHpSI8sItgV+OaKvSTjr35gxFR/MVe+fUJ
	 nQpv4JG1qa6ZUIpaZbaNwfpJjUF42evU9wBlNXsp4e2ydDSDbxnWKlRkFUBapQGMuzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IHcOYks9;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD9606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ECD9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IHcOYks9
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so21588635e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 05:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794923781; x=1795528581; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TrARtNuZPl0Lpgj7SQ8LbGOsanuNPRyo5Y7yT6NLi14=;
        b=IHcOYks9eSNaHn1swvavQHcR9aEbWHKJUS/ibRAIIhf6a9OkjuOwBGcH/30vbD4GCn
         9kNCvnpovgARWT+Xt051poIm6fXkPNAo82TA8RJVBzDuZwVk1uC2380g/v9lOUVAoOmS
         lHfsGioVpnhdHcKaKHMsKjqJpooLOU8XScYkuOeBHmiDyzJeAvcyrz9JWSaGbs7xI3nC
         N+TYIyIfq5KWyIdC/6g6O/M3ZQTiF3U5/8cRVRV4QxMPwEfQuZCWtD9m7+I/oFrlXzw/
         hXmrXdX8hc4xnAVJprllTpT38pDjwptWv+rb6Ix2eW56nSk/2mKBQYaiTgGE9s7QTpuN
         CC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923781; x=1795528581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TrARtNuZPl0Lpgj7SQ8LbGOsanuNPRyo5Y7yT6NLi14=;
        b=mPSyPX8RIzKVhe7bsFNkaqkqM6EC5gKea3owiXUXrD0yOPSJ97YE8ZR05vTZ5VHd63
         pmA4TTe7NkqIPyBjHaVB5GzlQHpiRIgmGfiCpujWsrWLvnrqXpekzGChzahC4yjxeL5z
         ldZMuYS9FYZRUITE5sKictLFRJ36eyj2STaL9Y5LBVxUGnLEZZto5llefd6Rt0Zj9EWU
         j3TJ1cZ2bTcusYgHJFbeC62gfv3R2bnsQc9NN1GGPFfFBSyHXdc+LBAn63oL1UvH6imY
         ++LUcLSBfzhM8zgSJzyy31/8Nerk4mR5aI2jnnh9j66y3NplI0zlrSRulcq8Oifk2jJp
         BRjg==
X-Forwarded-Encrypted: i=1; AL+hErGomR70aUlR0ra1NKTXGUvtX836mP9tYdO4Nd3ZkmY9AUJRyrGbVa2fsRQk67kUBlE1/STcBD4/huXllJOSmP04HY7wJ7M=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IGLIy3oVeOaNbir1eCrE2HmCKdV+V6jBBaUbvNd5kSaKLzFgp
	dPWZN7sncoqTc/JVtVtepGmTGvAdjRPePfxuBtNPOj085zkm6xpV/F1PdZndcq+NGQ==
X-Gm-Gg: AYBFou3ngYDebFjaV3Awp3N7qaoIrf0EFm0qOsqrJ5nXtI/O+rmjdI04Np8XTpNPrby
	2zK24401tESfeGdgBiTKJBk5HEHttOT73sYcBhWQvHKBBhobFvvYbeoB+kqjJ67MFlf6r25QgvK
	DzpILuDKEx76xlECEDs4hAaMpJFrezgGg8ajaoW5ROKzKfxAFjiiSOZ09xRMjb7FzrkMVq97AMA
	P1QwwPr13kX+My/ri+PrNyn0c+GvzUipte34zcpY46lA7UWm1xOMGICDDcKwMBwk4+bFOxhXjPE
	pdpi2Zy5LwbN52LJZvoY872DW/6lpHolcOVc/Nt8s14gdyN6itHk7zh/kr5HwcMaMbXIOkKeca/
	EkdZUnt5cM+gBHIn1nFtzqsR6vajngVGfWwAZVH+aoTGbc+htVZrgZ+sPS6nsnZTgu1OzHqLx9S
	MWhawmkgKrxj5fHcTLPcJ3ItVh0LT3fY+6ACh808D676fUns4WQbq0NxtsRrSviOQC2MxJoAakh
	QMCLlMecmUEmVPkrFc6Qzq1CCvS4fC0Gz1deYUJQvAs4yryaqMINAPs+ce+vyRibEZIYsdDdU4D
	b0Ueul6rqnp8vQL62L1TEPH89hZGOr6tv9PFA+sUPzp7WWWOXEOvraV8jBOYWIMlci/aYMwxDk8
	GXqI8Tg==
X-Received: by 2002:a05:600c:2c7:b0:4a7:8fe8:130c with SMTP id 5b1f17b1804b1-4bb55a71180mr192448425e9.28.1794923780717;
        Tue, 17 Nov 2026 05:56:20 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:12e4:4602:d8d8:3043])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60d9fff8sm29716380f8f.52.2026.11.17.05.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:56:20 -0800 (PST)
Date: Tue, 17 Nov 2026 14:56:15 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Ada Smith <adasmithgt@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
	James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/6] landlock: Factor out capability denial checks
Message-ID: <avxc_yI1fYx2qQ03@google.com>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-2-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117101157.2520463-2-mic@digikod.net>

On Tue, Nov 17, 2026 at 11:11:51AM +0100, Mickaël Salaün wrote:
> hook_capable() is the only place that checks a capability against a
> Landlock domain.  commoncap also makes capability decisions from other
> LSM hooks, and the following commits add Landlock counterparts for them.
> Move the check and its denial logging into check_cap() so that these
> hooks share it.
> 
> No functional change.
> 
> Cc: Günther Noack <gnoack@google.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v1:
> https://patch.msgid.link/20261110202436.2408244-2-mic@digikod.net
> - Add Serge Hallyn's Acked-by.
> ---
>  security/landlock/cap.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/security/landlock/cap.c b/security/landlock/cap.c
> index b4f491b09baa..fa59118e3486 100644
> --- a/security/landlock/cap.c
> +++ b/security/landlock/cap.c
> @@ -24,25 +24,21 @@ static const struct access_masks cap_permission = {
>  };
>  
>  /**
> - * hook_capable - Deny capability use for Landlock-sandboxed processes
> + * check_cap - Check a capability use against the domain of @cred
>   *
>   * @cred: Credentials being checked.
> - * @ns: Target user namespace (intentionally ignored; policy depends on the
> - *      acting credentials and @cap, not namespace ownership).
>   * @cap: Capability number (CAP_*).
>   * @opts: Capability check options.  CAP_OPT_NOAUDIT skips the denial record:
>   *        no audit record, no trace event, and no denial count.
>   *
>   * Pure bitmask check: denies the capability if it is not in the layer's allowed
> - * set.  This hook is purely restrictive: commoncap is registered with
> - * LSM_ORDER_FIRST so cap_capable() always runs first, which means Landlock can
> - * deny capabilities that commoncap would allow, but never grant capabilities
> - * that commoncap denied.
> + * set.  It does not check that @cred holds @cap: only call it for a capability
> + * that commoncap already granted.
>   *
>   * Return: 0 if allowed, -EPERM if capability use is denied.
>   */
> -static int hook_capable(const struct cred *cred, struct user_namespace *ns,
> -			int cap, unsigned int opts)
> +static int check_cap(const struct cred *const cred, const int cap,
> +		     const unsigned int opts)
>  {
>  	const struct landlock_cred_security *subject;
>  	size_t denied_layer;
> @@ -72,6 +68,28 @@ static int hook_capable(const struct cred *cred, struct user_namespace *ns,
>  	return -EPERM;
>  }
>  
> +/**
> + * hook_capable - Deny capability use for Landlock-sandboxed processes
> + *
> + * @cred: Credentials being checked.
> + * @ns: Target user namespace (intentionally ignored; policy depends on the
> + *      acting credentials and @cap, not namespace ownership).
> + * @cap: Capability number (CAP_*).
> + * @opts: Capability check options, see check_cap().
> + *
> + * This hook is purely restrictive: commoncap is registered with LSM_ORDER_FIRST
> + * so cap_capable() always runs first, which means Landlock can deny
> + * capabilities that commoncap would allow, but never grant capabilities that
> + * commoncap denied.
> + *
> + * Return: 0 if allowed, -EPERM if capability use is denied.
> + */
> +static int hook_capable(const struct cred *cred, struct user_namespace *ns,
> +			int cap, unsigned int opts)
> +{
> +	return check_cap(cred, cap, opts);
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, hook_capable),
>  };
> -- 
> 2.56.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>
