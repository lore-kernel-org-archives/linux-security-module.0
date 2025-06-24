Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2527C27C16A;
	Tue, 24 Jun 2025 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768075; cv=none; b=mdZKso76wJ8Kj3LkvnH6WFCxKl1bld4aFHCC4E1M9D3/ixOFcNTaAFg6P1KQzpBrNi9lcH+v0zmRBB/by1OISvvjhkM9rx5+WBo1GuDDaDSInmxXHGFp7cXkW9hjXzbA9wZVtKO+tP+GLP8c6GA22kTf2wX3ZLGtk7qm0Zs09X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768075; c=relaxed/simple;
	bh=k7QNQgI2bL4tonbgxVxZaKDXSZo/JrdE01ST9ousifA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJrW/pSNxeyawlrMYJSoZrA2THMC7ODa3mchejLkz766S073hQ3R+VKK9Sr75n9WNjD/nYxAF8Y625G9LL98k1ojugcnditCUepFeV1sTHb675g+Ndrvo5Jev3hei3jDo14g6byK1eggOuYULy5qwQyvu8zLIKJW/73npQ3T4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNA9quXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNA9quXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06871C4CEE3;
	Tue, 24 Jun 2025 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750768074;
	bh=k7QNQgI2bL4tonbgxVxZaKDXSZo/JrdE01ST9ousifA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNA9quXoDMMom1I9d7ZHf72mZc5vGCg+pCWEZd7q2H0oPCcSBCop+ZRM61cVO0Bgm
	 ZI/JeJn+h/KBEDxr8nQ2adMvqcNDtB6OIrrK0lj8V8usdmLQ7iAIFIWll9ohy/ob8G
	 oYMu2ZyNGFtwLFZ8fb0yvTai1qUdID74DVNW2r1HnWBiaoN1j9twIjzusoZEZY7cGw
	 zamnlYs+v1WtE4U1d5ootZp5D2DTXow29z6OIMB0w8J3pLCxXsDatiW1gzWY7CY+VU
	 5IaHNV1sqqmYl3kxv3wFcPVLidzp2+JXt3ccwowGtOgXL4jooK5lD9wS08gMBjp7cu
	 ruCqNsJKL+xDg==
Date: Tue, 24 Jun 2025 12:27:50 +0000
From: sergeh@kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] security: Remove unused declaration cap_mmap_file()
Message-ID: <aFqZxu_Slzmux6jj@lei>
References: <20250624014108.3686460-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624014108.3686460-1-yuehaibing@huawei.com>

On Tue, Jun 24, 2025 at 09:41:08AM +0800, Yue Haibing wrote:
> Commit 3f4f1f8a1ab7 ("capabilities: remove cap_mmap_file()")
> removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Hm, how did I not catch that?  Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  include/linux/security.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dba349629229..e8d9f6069f0c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -193,8 +193,6 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
>  			  struct inode *inode, const char *name, void **buffer,
>  			  bool alloc);
>  extern int cap_mmap_addr(unsigned long addr);
> -extern int cap_mmap_file(struct file *file, unsigned long reqprot,
> -			 unsigned long prot, unsigned long flags);
>  extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
>  extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  			  unsigned long arg4, unsigned long arg5);
> -- 
> 2.34.1
> 
