Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE77E6
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409113; cv=none; b=IiLLRxyTK9BrXhqp3yNJj+wMet/E+u4pzhT3dW6L6kFME9oqmS0sm2QIXdwXnZPaqG223uNJRTpkD47Ayu42J7/uNYqOKO+aEKPfg+Tk2wRNHo7PjQAd8kB7bGF5yDnWxa3WkWYczpGdHauqnDPz1p1tetTbrZ7Q61d+l4sQHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409113; c=relaxed/simple;
	bh=HBQoF3HtfYQxuAqCQ+Y/8lhz9qkLFKMuynT9oA2WX7Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=cUlNz+2aKYjOg7jWMmd3gXha2+rvZMhn+Pc3v47985FH7A5EAhB9JYOu5hYPUpgFHBzgKAb+aiWxPc3OdRs1Le597hmmJi0E6q89Jo7zFgQSHOmBfccq7+FxaYG4Q5xXt6PZtOOAXXk5GiR+unKoJATnA70BEhMi2cCuxqHPtx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HttlPFEJ; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HttlPFEJ"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-498d14b9b8cso2091696137.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Sep 2024 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725409110; x=1726013910; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbjivha3tnV2wlr9FBxXT0NKlpwCxsDgqm1qjAVzk0E=;
        b=HttlPFEJfAtpttyUw1X1TwhK1Ea6GGb7ihwBrS6no2CWAbyE96WHrUjBO4A7fGsPsF
         n8NK1F9OK7AODT0ty+h3wFZvaZUEyjROOs2vP0VPJ7tD2hRPSuqWuKDAooYnbBrhQ06M
         gNO9kzui0C9G5mPill0tI9tsNzIL7kOsxTL+v4PT00juUj0nh0eESdeVLU3c+8a0fDPj
         B9/ls+kUExvXMnmg8GHzIGTsFmL1dNM9Pca/gcv+yedCJSumDLuwKKSbLKdKaPhi5s9+
         f07FukqPnZTGDambBYag2apLzt3LvxusEgj+PbzG+aPhhdvkXQiSB96KCy58vm3wtuOD
         9rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409110; x=1726013910;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbjivha3tnV2wlr9FBxXT0NKlpwCxsDgqm1qjAVzk0E=;
        b=WokSBO4PXoruut32E6pDPbYFbZCStTVsFX9NUyghjH3vf6bNDA1+93vlnoDjyB7MK6
         CzIW2/rAHeI0keNlvp2M/cZzDzq9EmScCKYhFuFmu5bpU7dgK/BKYQ2B8EbbwN74IR/N
         WKlHNynedSKx5Ebw9U13T9nEr51aO2H5RtD5zNzBtOUBp70nZ1sIYw5cYD5f5InAazCP
         0EGtZXHtyMb8OdETd8ezXeU/Ev5dMM/LTzet6MZ6MiFWOgewFdhXUrNA28HalpT7kS9w
         dckbakVoK/f8OJLpqat/RZQChOe+OJQp5nV2irl7Q7+LLPASBvxSW2bMDuiL/lPS6k9s
         CcFw==
X-Forwarded-Encrypted: i=1; AJvYcCXtpBZ6mAiYZMIH96OgKM6Dy777sFEeB/Rw5tvdEuS1ipebKNVHvYnunVkBG4XdxUvNXDhxbCk5nXanzp9pSzjNqPL0328=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTKNmtpfo+l3L2mLtgX71Dkikdr66ak3TQPbzPhxq5rFmXF08
	nbY9HUhSBypqqeWj5pvB8BouRMmWRcyTYQgi3RHDJ0uVsOTPHxwqjb6iZvIcxg==
X-Google-Smtp-Source: AGHT+IEZllgwDYStRg/PLHCyY4hU/cGh61WMVkefjIHeFYT8KRvoVn/pM5Vssec22+MShvG64mo3sw==
X-Received: by 2002:a05:6102:3590:b0:493:ddd1:d7fc with SMTP id ada2fe7eead31-49bad26f92amr5059457137.11.1725409110579;
        Tue, 03 Sep 2024 17:18:30 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c291cdsm568449585a.52.2024.09.03.17.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:18:30 -0700 (PDT)
Date: Tue, 03 Sep 2024 20:18:29 -0400
Message-ID: <faf28485e8d2846e78f89c39d2f737ac@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v2 3/13] LSM: Add lsmblob_to_secctx hook
References: <20240830003411.16818-4-casey@schaufler-ca.com>
In-Reply-To: <20240830003411.16818-4-casey@schaufler-ca.com>

On Aug 29, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Add a new hook security_lsmblob_to_secctx() and its LSM specific
> implementations. The LSM specific code will use the lsmblob element
> allocated for that module. This allows for the possibility that more
> than one module may be called upon to translate a secid to a string,
> as can occur in the audit code.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hook_defs.h     |  2 ++
>  include/linux/security.h          | 11 ++++++++++-
>  security/apparmor/include/secid.h |  2 ++
>  security/apparmor/lsm.c           |  1 +
>  security/apparmor/secid.c         | 25 +++++++++++++++++++++++--
>  security/security.c               | 30 ++++++++++++++++++++++++++++++
>  security/selinux/hooks.c          | 16 ++++++++++++++--
>  security/smack/smack_lsm.c        | 31 ++++++++++++++++++++++++++-----
>  8 files changed, 108 insertions(+), 10 deletions(-)

...

> diff --git a/security/security.c b/security/security.c
> index 64a6d6bbd1f4..bb541a3be410 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4192,6 +4192,36 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
> +/**
> + * security_lsmblob_to_secctx() - Convert a lsmblob to a secctx
> + * @blob: lsm specific information
> + * @secdata: secctx
> + * @seclen: secctx length
> + *
> + * Convert a @blob entry to security context.  If @secdata is NULL the
> + * length of the result will be returned in @seclen, but no @secdata
> + * will be returned.  This does mean that the length could change between
> + * calls to check the length and the next call which actually allocates
> + * and returns the @secdata.
> + *
> + * Return: Return 0 on success, error on failure.
> + */
> +int security_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +			       u32 *seclen)
> +{
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> +		rc = hp->hook.lsmblob_to_secctx(blob, secdata, seclen);
> +		if (rc != LSM_RET_DEFAULT(secid_to_secctx))

Wrong default value/hook, but see below ...

> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(secid_to_secctx);

Same problem, I'm guessing a cut-n-paste-o.

> +}
> +EXPORT_SYMBOL(security_lsmblob_to_secctx);

We should be using the call_int_hook() macro instead of open coding using
hlist_for_each_entry() and I believe the code above could be converted
without any difficulty.

It should also solve the compile problem seen when using lsm/dev or
lsm/next as the base.

>  /**
>   * security_secctx_to_secid() - Convert a secctx to a secid
>   * @secdata: secctx
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..102489e6d579 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6610,8 +6610,19 @@ static int selinux_ismaclabel(const char *name)
>  
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> -	return security_sid_to_context(secid,
> -				       secdata, seclen);
> +	return security_sid_to_context(secid, secdata, seclen);
> +}
> +
> +static int selinux_lsmblob_to_secctx(struct lsmblob *blob, char **secdata,
> +				     u32 *seclen)
> +{
> +	u32 secid = blob->selinux.secid;
> +
> +	/* scaffolding */
> +	if (!secid)
> +		secid = blob->scaffold.secid;
> +
> +	return security_sid_to_context(secid, secdata, seclen);

We should probably just call selinux_secid_to_secctx() here so we limit
the code dup/sync issues.

>  }

--
paul-moore.com
