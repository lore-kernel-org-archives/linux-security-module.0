Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143938E100
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850417; cv=none; b=TOHU2wxIoHaT7amvg1978bFqpcLz1eu/v9XJV9XJ8hWwb3GVek6LkuLWVPC2NaZnaMXdIxARAWczCuqg3gmcOzYCH74724J9syZzinPdgjskHwfDpg6hC9PQYh2k+5lM7jNV1FVZgkmsTJQUPuABhgOvicF+XRKwLQdINEWeWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850417; c=relaxed/simple;
	bh=eZMXrw2SCuFNrE6P+5bPeQYoKr3DN/sT7hW6kdf8U/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLwbMiGPJeiYSEzVU16fJbAygZy1ay10ERZYx0roowj16jjBnJecY6Hhln/hAI/k4u6cnxvHHXePrvmsZtHuR2TBsf9QNGY4K/kJ80MuN5lvgnPLCwAEEsJ1/0QzhR80d02D5M8xDJjQHtW5Zdh2N+az5EDC4wXu08Xlu6EXGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9lErXKa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9lErXKa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso40633125e9.1
        for <linux-security-module@vger.kernel.org>; Mon, 07 Sep 2026 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788850413; x=1789455213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+AcoDBsNq2DQpDuYowxQcgnBIDZxDH8kNLsjfYNXKE=;
        b=M9lErXKa8JZpYtwvOjUpHChPU5Zp8T9j3t6uf6iXa0qpr20OYKf9YgaA9Qxt1ioAX7
         6oNCxx+s8PRsa3QMtiN6c/n+SVP85WzakLqzb4q6+TRXSFNbGXMm1E0Nf6zoVlNbaOsD
         HYL9C2EKLk9kNyDww7VN5zmbx6oygCsj7PghAzl0tEICu5Gf0e5MbIb4qhhgZ07mqTId
         wMDdm+oCK22I+5WRsZsjGujAWHdBK82qHw+XVkFzZP/6F23j+oCdYK3R+DWewnDcup4e
         CV4Lo6ZIGe39kBYya21oeFXbR+BvugC19r2Cdg75/TzfnSLc/KRTnuvxPuugFfSX4Qku
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788850413; x=1789455213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7+AcoDBsNq2DQpDuYowxQcgnBIDZxDH8kNLsjfYNXKE=;
        b=LyMY5NvD7co6M2MxUGYk3NAmcQQPOI4CX8Qyh1eGb+g8UaRww+Ra5/F1BH8+4RKtza
         Lhch3K8IlYMbW2VcefT4e71g0OLNEu/9C07UIJlICwF9OxanmBIVfhlJ49IuCd/CPJS9
         kSD/0PVrkAkL1mnz6lGLc5W6mlHGpMBCSHTLYlcSm0ygmmLIY+tKKplh79ivaQrOvIcy
         9ZL6yZwGatAMSM28fc1O73aTfL3lYSfxyT2TdJ2dGBhbV+96v9zfH7yk99oEwSRGJnui
         IYydRO/BAkmwFsruTYfbfkzhlRWIyZAMMYoridQDQlbtmUlPfPbVX2ukj7xlHRvIuSHU
         Z4bg==
X-Gm-Message-State: AFuF++mwiRI4i8xWpHFY0Ub7s/Jpf0IZWQJKvVwVftb5PtBF3IYM3Eb7
	BQ08k7URPVEcEiVfSUeN3/BNf9ln7c7JyfogEYKtmB9BhpioO1UTa5JJpupH9qokLw==
X-Gm-Gg: AYBFou2uybVcS947T4b/ecwJrEzh0LZHv7NY6YzN1QGx0R90APXKlVjKb7em25Cr8Yx
	ZFk9Yw1W9s4MB1U74u7Cdrg9otdMFHpFU6S1JREKem+ElU5+AG+Bp/Xv9vU7ytOEC3hjI5u95pH
	ztq4WZBgT3hWh5Ik9AE1hHZO3Px3pni0tBP2s19Q1DV8BytLMr1CTaohSHfc9S3gfKFXX1onN1W
	2AJsDe73ziI3EenxN1HvcKCV97iAfPeSxu9qRF197VoeV9a8m6z7RyPlUjcMQfkCpntHf8x4bwO
	JeTFo1FuFhDQ10Ovq5v+jbuhwoYlG31meNkR1/UxYT5tGK86poQAREkgaNsPCQduAbmtN2fCiue
	Dffxg1IcvB9vNKZyXQ/1xN6xfCrJrqrx3+nfQn8HieBHgEi/t28mgNrSiQA50489gLl5fKEEUPz
	gNSNBt9IzkJGMR6WWo5lTienCUzaBCRZKilU/udmEF6vD7nZQo5pfWmVvvySx7+gyx0o3yGslda
	Z0WhVmM08dZgb3at64=
X-Received: by 2002:a05:600c:5492:b0:49c:fa21:1c7e with SMTP id 5b1f17b1804b1-49cfa211d31mr241350685e9.19.1788850402558;
        Mon, 07 Sep 2026 23:53:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:72c8:d941:2666:e2d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm319940615e9.0.2026.09.07.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:53:21 -0700 (PDT)
Date: Tue, 8 Sep 2026 08:53:16 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Charles <dmcjisalive@gmail.com>
Subject: Re: [PATCH v1] landlock: Clean up ruleset validation checks
Message-ID: <ap-w3FtafxJSQJNL@google.com>
References: <20260907103609.113325-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907103609.113325-1-mic@digikod.net>

On Mon, Sep 07, 2026 at 12:36:08PM +0200, Mickaël Salaün wrote:
> landlock_merge_ruleset() checks for a NULL ruleset after dereferencing
> it in lockdep_assert_held().  Move the assertion after the check so the
> defensive path remains effective.
> 
> The mask-validation comment originated in landlock_add_fs_access_mask()
> to explain that its WARN_ON_ONCE() checked a caller invariant.  It
> became self-referential when this helper and its network and scope
> counterparts were inlined into landlock_create_ruleset().  Restate the
> invariant without naming the caller.
> 
> Keep both as defensive callee checks.  Moving the assertion preserves
> the NULL check's ability to warn and return -EINVAL, while invalid masks
> remain warned about and masked.
> 
> Reported-by: Günther Noack <gnoack@google.com>
> Closes: https://patch.msgid.link/aobYhIt3vcs2xN0b@google.com
> Closes: https://patch.msgid.link/aobasxUDQ8b7GYXl@google.com
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/domain.c  | 3 ++-
>  security/landlock/ruleset.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 93c7104fd6b2..4031b581be07 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -439,10 +439,11 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
>  	int err;
>  
>  	might_sleep();
> -	lockdep_assert_held(&ruleset->lock);
>  	if (WARN_ON_ONCE(!ruleset))
>  		return ERR_PTR(-EINVAL);
>  
> +	lockdep_assert_held(&ruleset->lock);
> +
>  	if (parent) {
>  		if (parent->num_layers >= LANDLOCK_MAX_NUM_LAYERS)
>  			return ERR_PTR(-E2BIG);
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 0d07707523cd..a5d135d085cb 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -58,7 +58,7 @@ landlock_create_ruleset(const access_mask_t fs_access_mask,
>  	new_ruleset->id = landlock_get_id_range(1);
>  #endif /* CONFIG_TRACEPOINTS */
>  
> -	/* Should already be checked in landlock_create_ruleset(). */
> +	/* The caller must only pass supported access rights and scopes. */
>  	if (fs_access_mask) {
>  		const access_mask_t mask = fs_access_mask &
>  					   LANDLOCK_MASK_ACCESS_FS;
> -- 
> 2.55.0
> 

Reviewed-by: Günther Noack <gnoack@google.com>

Thanks!
—Günther
