Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22D18EA8
	for <linux-security-module@vger.kernel.org>; Fri, 15 Mar 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515263; cv=none; b=CBSX/DHXYxpCi+swlZCiECnRa/X9+Lm4eriVjs3gNzE905hFXQD+Nfpv3l/vDk5LxkotGRrH13W4zQr7QRuCIR+Jvb0TyOviPqdZOWVOa6SvUpI+1NZRLbWX6nbOLw8zVUX0QJB7iP+jkzY/TAABGAs4iOYP/SPkaDqCIHUsftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515263; c=relaxed/simple;
	bh=p4tnq7/vMjan4zLSn1XJRt2ypTigSeLCtr4TRWiQ1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmo7V6nh6zsayCl+P+Dsy8nZzk3vWgkYQfxvwCNsfE8w3Z9PqbM8QaO3KOSprPMGR7NoyU7Ad+PvY4gNQudusMOwoVO5CZYzHyjCPvEqQnoRbMOEGYwzcNt5q2EZpaNcLrxxV2cqHhOOFtdVVaADIQ0RzvAuiWlIvZ9S9ENOVX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 8570CC12; Fri, 15 Mar 2024 10:02:08 -0500 (CDT)
Date: Fri, 15 Mar 2024 10:02:08 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: handle the NULL buffer case in lsm_fill_user_ctx()
Message-ID: <20240315150208.GA307433@mail.hallyn.com>
References: <20240314022202.599471-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314022202.599471-2-paul@paul-moore.com>

On Wed, Mar 13, 2024 at 10:22:03PM -0400, Paul Moore wrote:
> Passing a NULL buffer into the lsm_get_self_attr() syscall is a valid
> way to quickly determine the minimum size of the buffer needed to for
> the syscall to return all of the LSM attributes to the caller.
> Unfortunately we/I broke that behavior in commit d7cf3412a9f6
> ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> such that it returned an error to the caller; this patch restores the
> original desired behavior of using the NULL buffer as a quick way to
> correctly size the attribute buffer.
> 
> Cc: stable@vger.kernel.org
> Fixes: d7cf3412a9f6 ("lsm: consolidate buffer size handling into lsm_fill_user_ctx()")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/security.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/security/security.c b/security/security.c
> index 5b2e0a15377d..7e118858b545 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -780,7 +780,9 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   * @id: LSM id
>   * @flags: LSM defined flags
>   *
> - * Fill all of the fields in a userspace lsm_ctx structure.
> + * Fill all of the fields in a userspace lsm_ctx structure.  If @uctx is NULL
> + * simply calculate the required size to output via @utc_len and return
> + * success.
>   *
>   * Returns 0 on success, -E2BIG if userspace buffer is not large enough,
>   * -EFAULT on a copyout error, -ENOMEM if memory can't be allocated.
> @@ -799,6 +801,10 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
>  		goto out;
>  	}
>  
> +	/* no buffer - return success/0 and set @uctx_len to the req size */
> +	if (!uctx)
> +		goto out;

If the user just passes in *uctx_len=0, then they will get -E2BIG
but still will get the length in *uctx_len.

To use it this new way, they have to first set *uctx_len to a
value larger than nctx_len could possibly be, else they'll...
still get -E2BIG.

So I'm not sure this patch has value.

>  	nctx = kzalloc(nctx_len, GFP_KERNEL);
>  	if (nctx == NULL) {
>  		rc = -ENOMEM;
> -- 
> 2.44.0
> 
