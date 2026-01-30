Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7F188713
	for <linux-security-module@vger.kernel.org>; Fri, 30 Jan 2026 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769736703; cv=none; b=h/2uxnkjOWKMwDa1sj5dFxfWeDDgYg7MCou7wGfgEDpzWG/OtmwW8e0XevvIyvNQRezo1Gj9Ge9Wjs8RINLU2Bn6PGZbpKi9B8z61pT1RujRYJCfmedwvx4otiqzYZewWDNCQ3n9sZUht7MVDy8DWr+BDEhmXdMX84MpqhJUwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769736703; c=relaxed/simple;
	bh=8cKq9AUozNFDXxvISOg02yWkfQ7EXvQvA0V9S9ELwWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFs/zS0FeOqfO87JoMfgQCZ4zaKsM+KebjufPwnyUo7nOKh1Br7N3iqMh5FUTJxgJixWdSJcVk+ntYf07t93Ktm7OgnG3G/9rCrcQh6Uo1NwCTtLpKHo5S7Pjfpzhqglhgn2J6ZCGoTc09OHNt4OrAgrwJL3/CyCcv6cI9iLm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8waZ2ss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8waZ2ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254BCC4CEF7;
	Fri, 30 Jan 2026 01:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769736703;
	bh=8cKq9AUozNFDXxvISOg02yWkfQ7EXvQvA0V9S9ELwWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8waZ2ssLE2mo86qQyqJx1jIYseMIoKmqdeKhqgBjTisvD6JjmovazsvkCaQD3SPO
	 Oyc4XHPvIrQQ5Rs3tAUaQEGu33G3lNKHlxwgUDCC4WIMgZd48CqUaKdjssr0kwOuHg
	 xZ03Wx3Ulkb7KFqFYGg0QNf7tJjMX5685hWMHnDX5qItlpF/qngrddtN82JBiA3wcV
	 pKAYnzDZxAth8PBVh+lIAiReXY2EBCC/HTmcXKJ5NJ8kg126eGgXE7YVHDKY1Us4wZ
	 06piOKS8Asrw5pa1goM5lu8X4TyOlkhn4EG1O/f6VVT8HitALTO0PTOlDDCLP3gKBU
	 3v8PvXzd2/3cQ==
Date: Thu, 29 Jan 2026 17:31:42 -0800
From: Kees Cook <kees@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com
Subject: Re: [PATCH] lsm: preserve /proc/sys/vm/mmap_min_addr when
 !CONFIG_SECURITY
Message-ID: <202601291730.45120C1A@keescook>
References: <20260129225132.420484-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129225132.420484-2-paul@paul-moore.com>

On Thu, Jan 29, 2026 at 05:51:33PM -0500, Paul Moore wrote:
> While reworking the LSM initialization code the
> /proc/sys/vm/mmap_min_addr handler was inadvertently caught up in the
> change and the procfs entry wasn't setup when CONFIG_SECURITY was not
> selected at kernel build time.  This patch restores the previous behavior
> and ensures that the procfs entry is setup regardless of the
> CONFIG_SECURITY state.
> 
> Future work will improve upon this, likely by moving the procfs handler
> into the mm subsystem, but this patch should resolve the immediate
> regression.
> 
> Fixes: 4ab5efcc2829 ("lsm: consolidate all of the LSM framework initcalls")
> Reported-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Good catch and fix!

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  security/lsm.h      | 9 ---------
>  security/lsm_init.c | 7 +------
>  security/min_addr.c | 5 ++---
>  3 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/security/lsm.h b/security/lsm.h
> index 81aadbc61685..db77cc83e158 100644
> --- a/security/lsm.h
> +++ b/security/lsm.h
> @@ -37,15 +37,6 @@ int lsm_task_alloc(struct task_struct *task);
>  
>  /* LSM framework initializers */
>  
> -#ifdef CONFIG_MMU
> -int min_addr_init(void);
> -#else
> -static inline int min_addr_init(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_MMU */
> -
>  #ifdef CONFIG_SECURITYFS
>  int securityfs_init(void);
>  #else
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 05bd52e6b1f2..573e2a7250c4 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -489,12 +489,7 @@ int __init security_init(void)
>   */
>  static int __init security_initcall_pure(void)
>  {
> -	int rc_adr, rc_lsm;
> -
> -	rc_adr = min_addr_init();
> -	rc_lsm = lsm_initcall(pure);
> -
> -	return (rc_adr ? rc_adr : rc_lsm);
> +	return lsm_initcall(pure);
>  }
>  pure_initcall(security_initcall_pure);
>  
> diff --git a/security/min_addr.c b/security/min_addr.c
> index 0fde5ec9abc8..56e4f9d25929 100644
> --- a/security/min_addr.c
> +++ b/security/min_addr.c
> @@ -5,8 +5,6 @@
>  #include <linux/sysctl.h>
>  #include <linux/minmax.h>
>  
> -#include "lsm.h"
> -
>  /* amount of vm to protect from userspace access by both DAC and the LSM*/
>  unsigned long mmap_min_addr;
>  /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
> @@ -54,10 +52,11 @@ static const struct ctl_table min_addr_sysctl_table[] = {
>  	},
>  };
>  
> -int __init min_addr_init(void)
> +static int __init mmap_min_addr_init(void)
>  {
>  	register_sysctl_init("vm", min_addr_sysctl_table);
>  	update_mmap_min_addr();
>  
>  	return 0;
>  }
> +pure_initcall(mmap_min_addr_init);
> -- 
> 2.52.0
> 

-- 
Kees Cook
