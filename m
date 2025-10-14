Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D2FAC0B
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483577; cv=none; b=SZzXKp1ut9LiwOUkRqkHsL8mFsgRLHMLgSiDJOMdqvWPsKe/PC+zbrWnCzl6sHm4BvDSam7e6HKYIyyWHTAfFsR3q9cXRnLF+C6Pg3a+Rn+TeU9kC8pXfz9VKKyK9/00OLPU14veSvXmojoVVVg9pLsUdOHFmWSZy41nq1Fw11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483577; c=relaxed/simple;
	bh=pqapgx3SjFaiVLjTtl9ZYj2hBgm63UGXxUD3Vh5H9m0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sbeBUG1ZBWwzFjvAyxvxrge0xJsg6ihg0bXz+u7Eh8uxWN55Ycx0/r3wJ/tAMyb7wFqizikQVkUgnsLcAGE7TJ+HiZLhR1e0yodThY0arG4FjCYv/0PqjYHXX+6SBbIcVUxGbSoQ6VqARkB1tNwNNQNmTDeitI/jk6PssEE+Co0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MQaqD3U9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MQaqD3U9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8593bcdd909so807417785a.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483573; x=1761088373; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=MQaqD3U9+xOyUqIFdbpUou2sBimqG5nyiMeV/xmWu1Wl7qA+KnYmQesHKndJCEV0Jo
         5/mgTsFavaip7r0VuFrXc00yS6oSo52I6WLPLd5j+3jompo7qqRcRWgco+qMdWYYnef4
         S1kAcXAt2YK2o8nkSgfAVOvqnxvUXZSnADKYMM5A5etSeCgqA+WXx36KlmyeQhttfY1v
         xppq5+CZmPQEsbYXVjzZW2OtFwewYo+z4qosKFf5TKDOu4mmMLPPCV8JeG4kdIdBIOz6
         UvS6jY7MmxY1WceJAgfVt1Ung41gYynYSp33hREqSVO5USmj084Hbc8PDnoA4x7ShylE
         4bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483573; x=1761088373;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ps8OB349up+2JiXOOAUFOzgYyyG71oedxuIe/5L+TTI=;
        b=RHxiotjgorrjlt6dYFQbLoehm9Wn78fptIVHCk+HNdA+W+qJFCYHRE6BEdYMx2D9aJ
         0u735e+XKzNt1t/M0F0AxVKnDCnsPM6eSUQVRf+XPOAHozcuPZmh/WE/oEYR0cLJi9fb
         /gUFRqQmyejW4FJeYsTdjrWH2TLOd4AYFf31pLFx/cLbXw+tPDTm+s6ZTYwh3vJn7Rci
         Rtp9eZ6MfqgVOJ0NUcK/7U9dz6wnL7meai/rGeqTp7WJxyMQ4oqgeOu8NreWFEKaDzEB
         IuClOJxV0uvDfApZ8icBwhNW0yo1NwQaUMF8du0A11lFJGSLKMYoQtTq5M6CEtIyoP6X
         hm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnBcoW6LXs6odVAPZVzWE5gXTBLFDcehQWHaoH1DC3lj8BkUpP9wtFxfK+pDkA5mJw/hpxn5QvcQp+yk+J089d2A4+VCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzYe5yni8GCBMMkwW/VT6BcgaDBNxazNHCS2O8HpgsV1+8Dw/
	SxGVAt+PNV3kOEZA3P6U8Ktw81U6qfqRtSAh915FDR0/5psTvitWTnd9m545/P7cgA==
X-Gm-Gg: ASbGncsdX0I0Kj7tZWSj401/z6QXoq149uKFJn/7B3awgFrbN9w6cCe5FRIrKEIefW9
	JJTYnvEA1rQlJjuHtx18h1fSJzsYmBiIX1tbD4li1B6Tiu2gIow/u+y4lN4MTrD10Ys4QynBRtn
	fQRx55xFHwAJI0KGWmibeKlm8AckHNAqzZo4P2rOsMllyr/ZoUJQh79BL8PMjQfhOCBXpQuDyzx
	4A6+Su0A8iK32LZg9hDGmMj/yONFEUNGFaKAS33rpJiGsUEmh92KdsPlT1iTcHd8I3ekCLZzZYD
	PRwBSb430VpMd3iT3jJuTd2OdN6Q2k2I/hdLlsQ+7obppNoHXjN02PrvF7xuBMjD76KLwb/ijpi
	CVlGCNi488kcRWsQa3xDGzUF0iiPe6a+s8jcsMd6h1Fqw5cuk1jhKgKeH99P8DEXyGyTaLNok7K
	5RdNEM+KG6UgQ=
X-Google-Smtp-Source: AGHT+IH2kJu3p5TXj14jePlOqpBlixzbhxeJPUr5Dl1KA11KjKhjkHDMYoCi0UavIwCqCbLXkHZG5A==
X-Received: by 2002:a05:622a:1b1d:b0:4e3:16bd:3e16 with SMTP id d75a77b69052e-4e6ead5b614mr441408041cf.56.1760483572924;
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e881c86dd0sm7554211cf.15.2025.10.14.16.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:51 -0400
Message-ID: <36f0c22554337b4d5551eabee2d86479@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 7/15] Audit: Call only the first of the audit rule  hooks
References: <20250621171851.5869-8-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-8-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> The audit system is not (yet) capable for distinguishing
> between audit rules specified for multiple security modules.
> Call only the first registered of the audit rule hooks.
> The order of registration, which can be specified with the
> lsm= boot parameter, is hence an important consideration.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 2286285f8aea..93d4ac39fe9f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5056,7 +5056,13 @@ void security_key_post_create_or_update(struct key *keyring, struct key *key,
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>  			     gfp_t gfp)
>  {
> -	return call_int_hook(audit_rule_init, field, op, rulestr, lsmrule, gfp);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_init) {
> +		return scall->hl->hook.audit_rule_init(field, op, rulestr,
> +						       lsmrule, gfp);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_init);
>  }

Similar to the comments in patch 5/15, what would it look like to do the
enforcement of this callback restriction at LSM registration time?

>  /**
> @@ -5070,7 +5076,12 @@ int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
>   */
>  int security_audit_rule_known(struct audit_krule *krule)
>  {
> -	return call_int_hook(audit_rule_known, krule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_known) {
> +		return scall->hl->hook.audit_rule_known(krule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_known);
>  }
>  
>  /**
> @@ -5082,7 +5093,12 @@ int security_audit_rule_known(struct audit_krule *krule)
>   */
>  void security_audit_rule_free(void *lsmrule)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_free) {
> +		scall->hl->hook.audit_rule_free(lsmrule);
> +		return;
> +	}
>  }
>  
>  /**
> @@ -5101,7 +5117,13 @@ void security_audit_rule_free(void *lsmrule)
>  int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
>  			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, prop, field, op, lsmrule);
> +	struct lsm_static_call *scall;
> +
> +	lsm_for_each_hook(scall, audit_rule_match) {
> +		return scall->hl->hook.audit_rule_match(prop, field, op,
> +							lsmrule);
> +	}
> +	return LSM_RET_DEFAULT(audit_rule_match);
>  }
>  #endif /* CONFIG_AUDIT */
>  
> -- 
> 2.47.0

--
paul-moore.com
