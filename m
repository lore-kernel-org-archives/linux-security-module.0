Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB8305057
	for <linux-security-module@vger.kernel.org>; Wed, 28 Jan 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635921; cv=none; b=UwyBXHWXwp1DzQwmlKfpmeb3jazHt76kqzVlMAlwcHf4iEOG1wWeGuC+/p/Le2uRFpebEGMBepi5PqnYvpv4OLVWHDTn99Upaf1JSTSaEJzGoxp5w/orq8LeFTNa7McEgZ1ske+DsDthdm/ji6t2TxSi2R0/N2v2Em9t9DVIcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635921; c=relaxed/simple;
	bh=5TKHyQCAbbn0JlxA1eTzlTXLptx0aHcLc6QN6B+xFvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSTvIho+JdkPzO4k7BkexcTzkBbkBqyz0XJCNB4vVKnk3QB9e1dUfW9hz/pURN5feV9uPvMTCsd0BjJNJnW3zYLUwZxo0M6V9wIVHPZkRSm9Hf+qauw7bo38DARbtTWC3qBpin7Nv3LjbP18kZw3sOfM7Z0lymyZO74dcClvhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=mWIYb3J1; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="mWIYb3J1"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f1b7t03L9zmGM;
	Wed, 28 Jan 2026 22:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1769635913;
	bh=Q0XFlLfalXFLd5qUulEnxsIkRKxezvIIVyV7Q44dOjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mWIYb3J1qm26ABGy3j67tmqGcMgxlgU2cLKVkoSa0NjDy7kntTksk0WsXzGDzLpOD
	 reMT/1iVGuITjDMuYY2QzjQI00GQXex76youtzKmNTv57DlfDLqrzKsMHJSOv8b7Mk
	 ekAGyYEWU2ggALaE2gBD02+E3sKMI9UGwTGfZpZc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f1b7s3MZdz9ZN;
	Wed, 28 Jan 2026 22:31:53 +0100 (CET)
Date: Wed, 28 Jan 2026 22:31:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/3] landlock: access_mask_subset() helper
Message-ID: <20260128.raiD8oseH2ee@digikod.net>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260125195853.109967-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Jan 25, 2026 at 08:58:52PM +0100, Günther Noack wrote:
> This helper function checks whether an access_mask_t has a subset of the
> bits enabled than another one.  This expresses the intent a bit smoother
> in the code and does not cost us anything when it gets inlined.
> 
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  security/landlock/access.h | 6 ++++++
>  security/landlock/fs.c     | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 7961c6630a2d..5c0caef9eaf6 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -97,4 +97,10 @@ landlock_upgrade_handled_access_masks(struct access_masks access_masks)
>  	return access_masks;
>  }
>  
> +/** access_mask_subset - true iff a has a subset of the bits of b. */
> +static inline bool access_mask_subset(access_mask_t a, access_mask_t b)

What about renaming "a" to "subset" and "b" to "superset"?

> +{
> +	return (a | b) == b;
> +}
> +
>  #endif /* _SECURITY_LANDLOCK_ACCESS_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 8205673c8b1c..bf8e37fcc7c0 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1704,7 +1704,7 @@ static int hook_file_open(struct file *const file)
>  		ARRAY_SIZE(layer_masks));
>  #endif /* CONFIG_AUDIT */
>  
> -	if ((open_access_request & allowed_access) == open_access_request)
> +	if (access_mask_subset(open_access_request, allowed_access))
>  		return 0;
>  
>  	/* Sets access to reflect the actual request. */
> -- 
> 2.52.0
> 
> 
