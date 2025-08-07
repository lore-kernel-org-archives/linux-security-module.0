Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875C944F
	for <linux-security-module@vger.kernel.org>; Thu,  7 Aug 2025 01:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529692; cv=none; b=dvGHZQXqgiCde0JE/uTGBe3WZUpXEuk3Mt4waXVlhFpPZ2UWrDYUn9yHYCfj+AB35R24igJ+PLIt2TokaGNA4dlmjJJZI4yGzCM8E4+NC0foyOZe6OipXw6mCPZp61rXmwzVDsit5JSJzUVuacYJbh3Wk+7jFjv66+v/4xZjbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529692; c=relaxed/simple;
	bh=FlP0x0oLGQPAiITfjD225Go3KM+bobOzEHjsXcawplE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBvEccGBkRdY7ywi9q4Gq+HHv+IDQBWE6HJxZkvokzuNTeS+2WF7dXFN+UtBHEddhxgsA6PjlJ66epVFT4Uet8zF/AkqALjexxk+DUlyGHaJzkEuOx5l4xINjLJMh//UsdaY3RY3a5qlo/e8nDVfBn8zImKgIyKjEWyNmF/zKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E4B5B867; Wed,  6 Aug 2025 20:13:18 -0500 (CDT)
Date: Wed, 6 Aug 2025 20:13:18 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] lsm: use lsm_blob_alloc() in lsm_bdev_alloc()
Message-ID: <aJP9rnEH1OJA2JJ6@mail.hallyn.com>
References: <20250806212552.240730-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806212552.240730-2-paul@paul-moore.com>

On Wed, Aug 06, 2025 at 05:25:53PM -0400, Paul Moore wrote:
> Convert the lsm_bdev_alloc() function to use the lsm_blob_alloc() helper
> like all of the other LSM security blob allocators.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/security.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..a88ebfca3224 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -823,16 +823,8 @@ static int lsm_msg_msg_alloc(struct msg_msg *mp)
>   */
>  static int lsm_bdev_alloc(struct block_device *bdev)
>  {
> -	if (blob_sizes.lbs_bdev == 0) {
> -		bdev->bd_security = NULL;
> -		return 0;
> -	}
> -
> -	bdev->bd_security = kzalloc(blob_sizes.lbs_bdev, GFP_KERNEL);
> -	if (!bdev->bd_security)
> -		return -ENOMEM;
> -
> -	return 0;
> +	return lsm_blob_alloc(&bdev->bd_security, blob_sizes.lbs_bdev,
> +			      GFP_KERNEL);
>  }
>  
>  /**
> -- 
> 2.50.1
> 
