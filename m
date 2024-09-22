Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81E632
	for <linux-security-module@vger.kernel.org>; Sun, 22 Sep 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019769; cv=none; b=BVM1XTYkHEoc1aBG5ni0JV8P77UXvB+/ufJyyipL4OdJSQSNSQtz4k9HfiU+8WjNRHYOgbJXwQJhjxQyG8yFRXeiMU1WSILMl1crw8cNddQyk9HFQ8eKN6tod5m8I7OfJ26rE3lkd73LFhey5k4W1c3aGoQ8h3TAyI2ZhRV4VZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019769; c=relaxed/simple;
	bh=c1N5WLlxI9djqnOJOv7xSTLjLFZYg/6r38aQNFqy8PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtZFIyeT1BfjBDKMQNKKol9Wn/kKycBw9CEuMie9q18lXqmLW3MmyDHBSI/lZN09GI+OeITnUJ7aP2DBYP9vrO/c1/CzNgURTTcdtzAtfe9kGbp0iEAB4y8BMtWfsuFd698/VIHzlmTX0BtBKX85+80joPnQGYt6pk8L5PvN0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id E0A16B7E; Sun, 22 Sep 2024 10:42:36 -0500 (CDT)
Date: Sun, 22 Sep 2024 10:42:36 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: luca.boccassi@gmail.com
Cc: linux-security-module@vger.kernel.org, wufan@linux.microsoft.com,
	paul@paul-moore.com
Subject: Re: [PATCH 2/2] ipe: also reject policy updates with the same version
Message-ID: <20240922154236.GA587012@mail.hallyn.com>
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
 <20240922135614.197694-2-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922135614.197694-2-luca.boccassi@gmail.com>

On Sun, Sep 22, 2024 at 03:56:14PM +0200, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> Currently IPE accepts an update that has the same version as the policy
> being updated, but it doesn't make it a no-op nor it checks that the
> old and new policyes are the same. So it is possible to change the
> content of a policy, without changing its version. This is very
> confusing from userspace when managing policies.
> Instead change the update logic to reject updates that have the same
> version with ESTALE, as that is much clearer and intuitive behaviour.
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>

Makes sense.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

for both, thanks.

-serge

> ---
>  security/ipe/policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> index 5de64441dfe7..01da3a377e7f 100644
> --- a/security/ipe/policy.c
> +++ b/security/ipe/policy.c
> @@ -115,7 +115,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
>  		goto err;
>  	}
>  
> -	if (ver_to_u64(old) > ver_to_u64(new)) {
> +	if (ver_to_u64(old) >= ver_to_u64(new)) {
>  		rc = -ESTALE;
>  		goto err;
>  	}
> -- 
> 2.39.5
> 
