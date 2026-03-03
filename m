Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE5381AE0
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561398; cv=none; b=W0KzkfrPQ3aR//MJSNkN3EafFJwoVNeppvQkcH0vlEA+Mm3/bhVEIih00rN09aI2EAQu3q77JDIaHJDpT6D4uJfi5FdYok/R9BoZBbA9ZB159nI9fT2encK7nqRGwsOFw6WxaMSM/0W7/YZelx2yj+zJJGKmg4hs/jldy9BYT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561398; c=relaxed/simple;
	bh=bTlVoUFASzxzQOoqEL434Bvdcu0BWUwPP+dzvuDRPlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETNkxEblvzC1mr3GTA2AcOwMhnDJ9IdgNButvmuAMKs4D2cObQPlxy+iULaBa9p0nPhU+Y3o/5x/WPf2FBGU+BexXMoxo2OVjQRfOj5wmCHlrv1pjzrINvZ3aB/MnPhO2mq6ccZ8M/UM2bIlKDRWm1IYsjYKy01VIQDphZe0wYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBWblSA6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBWblSA6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso53143515e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772561395; x=1773166195; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5r8A6bO48R5z8dhrhRLGMY+vxIfFF0NvmBiDfOUr4EM=;
        b=fBWblSA6IazgRDL+uHmqZFTu5ApNjcf3v/hDwKgvJPgxBmdBe/BgJy5XKhD9rb1N5z
         y2JXxX2deouFNxn3UIfGuVxTgQrwXiRF1HAP9l3ARVB28nUPApkt/egiiR9dvQR1L4qG
         Y0W97ZvD3G2NdkViCD3nnRtSgjyKkUMvyX1E6U/Eud/8/RmXAx6PNZcVAFvMY/mCvSqx
         b9HOXEYQAPd9H9wDQX6wjyb2ylq0NvzMRRBGZjlSqtgJw05H9/reXmhyDf3Z2qQX1qvq
         aE3wMco7nIpcDQ0iH4sHXZJnEpBEfk2v9cfITOFtn/lYHOen/ZubjHSNTLLTdJNsQKVs
         vWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772561395; x=1773166195;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5r8A6bO48R5z8dhrhRLGMY+vxIfFF0NvmBiDfOUr4EM=;
        b=I+VBiVAe8uT80dDkjVoXN8pQddYySZ+JUuhNp4k+S9BIawHwREil+7a9gJlB3VRG5B
         /noBJHu4S58McfhesiTtjdsom5vr+WMk4SAjVPMpTuIsHw5/7bB/3XIPH6LOU5cISf76
         RBWlUvSaiwOHCew2NYG+6SK6lrtSIG5ljVeWyzNWj4OwNMMhhfdT1NSf4cAqC1RlQDqg
         H471w+djaUikZbhXCmdPmSIkNJzMgVZ7VNBv7Kd5AMmadnMHCkPSKbs5Im833ZufTz+i
         jEJeG3hWOqcWzLGNsLkG8o3dpxyavsxRD11Omk5CQdtUINWYsuCVxpgSAsqBfgUR7EHO
         T6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkJyYxvzPTPdSd6tbbG58TxP5wEoKT2I1u3ii1vM2SGH4qrvH+OXU1NZV1NzjJ/Mr0xczVZl/RXvgVnc/I/5riExcZCIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiPoT+guKKue9CpmLXglKI0JwDXhWXqQ7x8ps1leYh+00AN5u
	2JnzKzEVk48oTgnGo/Kxr4zvej9K+BYFtauVx7HZokCwZN2BUyNpPIYV
X-Gm-Gg: ATEYQzwEUwJGdeKBTprKP0cU0D+DpamPpE8ZAxMOpPVOCsvh0T5W1oB1oPOLjzSyjS5
	fsXAUWloQ+nvQ2MgKoWnkqzmie3VZwEmpN/nE5Gyfb7S9kYeLH4W1eDrQoalvsRQUfnb5ywi1op
	y2hIkwXJ5UDwA636MIQptw4A5cVJffBtYzk5XxUi+V2QuS1TqdM4Ei55GCd9TV1IVJMJ4lE5GTZ
	m9n3+U9/FYt6NFA30wPrnLHeSYOgseBBBXQVNrgPjnMRbWZtBdYAyeeUbCd41/jck6dbDoxukms
	i5bOiWQtxNgdj1cNWVPKHwTeYCVw/7OfyR+M6QbqMkox8xgHu33aujNp3ZWgjTb8rWjqyHJ+0pX
	eLKWHKjrBRyy/Xw5Itocmc7doHB/JYM/+XQdmkb3IUd/rBUH+cm88HWxDYQ8kvUcYY7BpRmz4Jj
	yw5kdoBGHRO3n4itkyLlOYJ7fotK5zZJAmi3HLaqV/CfI5WVeT
X-Received: by 2002:a05:600c:4f07:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-483c9bb1d2cmr255634085e9.6.1772561395026;
        Tue, 03 Mar 2026 10:09:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135d52f6sm20919355e9.31.2026.03.03.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:09:54 -0800 (PST)
Date: Tue, 3 Mar 2026 19:09:40 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v1] landlock: Fix formatting
Message-ID: <20260303.55923ece9536@gnoack.org>
References: <20260303173632.88040-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303173632.88040-1-mic@digikod.net>

On Tue, Mar 03, 2026 at 06:36:31PM +0100, Mickaël Salaün wrote:
> Auto-format with clang-format -i security/landlock/*.[ch]
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/landlock/domain.c  | 3 +--
>  security/landlock/ruleset.c | 9 ++++-----
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index f5b78d4766cd..f0d83f43afa1 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -94,8 +94,7 @@ static struct landlock_details *get_current_details(void)
>  	 * allocate with GFP_KERNEL_ACCOUNT because it is independent from the
>  	 * caller.
>  	 */
> -	details =
> -		kzalloc_flex(*details, exe_path, path_size);
> +	details = kzalloc_flex(*details, exe_path, path_size);
>  	if (!details)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index 319873586385..73018dc8d6c7 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -32,9 +32,8 @@ static struct landlock_ruleset *create_ruleset(const u32 num_layers)
>  {
>  	struct landlock_ruleset *new_ruleset;
>  
> -	new_ruleset =
> -		kzalloc_flex(*new_ruleset, access_masks, num_layers,
> -			     GFP_KERNEL_ACCOUNT);
> +	new_ruleset = kzalloc_flex(*new_ruleset, access_masks, num_layers,
> +				   GFP_KERNEL_ACCOUNT);
>  	if (!new_ruleset)
>  		return ERR_PTR(-ENOMEM);
>  	refcount_set(&new_ruleset->usage, 1);
> @@ -559,8 +558,8 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
>  	if (IS_ERR(new_dom))
>  		return new_dom;
>  
> -	new_dom->hierarchy = kzalloc_obj(*new_dom->hierarchy,
> -					 GFP_KERNEL_ACCOUNT);
> +	new_dom->hierarchy =
> +		kzalloc_obj(*new_dom->hierarchy, GFP_KERNEL_ACCOUNT);
>  	if (!new_dom->hierarchy)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.53.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thanks!
