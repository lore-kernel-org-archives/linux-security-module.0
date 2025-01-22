Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE818E764;
	Wed, 22 Jan 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576220; cv=none; b=lZpU+SAjwUyj2s2M8h+9A3jpDrNaIUDoIr4eyZzwlkKFbI+G43dZs3CNJGB24i40h9zRrCdn7aREJFpWsJsigs9VNBHDtOw63o6azrY2U+JLcWVfopgL1gLeQOskiVpivR/v9xzhDdoba5r12bAFH1NjD4Ni8XVs82rXcYm/SOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576220; c=relaxed/simple;
	bh=a8vlR2h7r221zxwQin4KuS7YppqlN5ICjvlUENG/OP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH0/lZNKMUcCdBuYo7j70gSeM8lVD0Uwl81YlpWLMzHzKfrf/xs5Fsxwqj07kWQh9vD0lERnd6lbti5ejF7W0dhTF0+RQkjtVpCHK1p7HtaCeGOXkwnSp/XGWbNZm/fSexXmVLwBRH9K+M34rFUW707SkgoR7cw1EoChFYCwbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGbevviN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGbevviN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61344C4CED2;
	Wed, 22 Jan 2025 20:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737576219;
	bh=a8vlR2h7r221zxwQin4KuS7YppqlN5ICjvlUENG/OP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGbevviNaE5+ZriE0+DZM1A0CRhr2Bw2mFKw28O9vJ+ziquTDDHl62mLQRGAqEcfv
	 amRNVNDurbrjc8hBEEOFHFEgWWhlVgDxo9GSZHYxgQlGjeMSIH5YLOFF1at05FYl7g
	 P25eKUMNOH+JNAW1e1COjx7NGjxXsLjvE37bOy2qhvsO7KPMfmL4wRQv6bkiHAQFyr
	 M7HOHtmHFULg06PM1AhGRF4igXfhmmkrSPujiNo6z9x5XCqYnDo9/cu9KyCOMcMKPt
	 7ds2+TkF/HD97um7TzPDWPlc2Q67cSTTPLj+z7ilCzbLutBXEetOGJ9rWTZ2ftiPwv
	 JoO6GUhhhBh8A==
Date: Wed, 22 Jan 2025 20:03:34 +0000
From: sergeh@kernel.org
To: Arnd Bergmann <arnd@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: remove unused variable
Message-ID: <Z5FPFhc9w0aemqL_@lei>
References: <20250122065543.1515519-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122065543.1515519-1-arnd@kernel.org>

On Wed, Jan 22, 2025 at 07:55:35AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The local 'sock' variable has become unused after a change to the
> aa_sock_file_perm() calling conventions:
> 
> security/apparmor/file.c: In function '__file_sock_perm':
> security/apparmor/file.c:544:24: error: unused variable 'sock' [-Werror=unused-variable]
>   544 |         struct socket *sock = (struct socket *) file->private_data;
> 
> Remove it here.

That's interesting.  The aa_sock_file_perm() further in will
still trip the AA_BUG(!sock) if there's some shenanigans going
on so no big loss in dropping the AA_BUG.

> Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/file.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/security/apparmor/file.c b/security/apparmor/file.c
> index 85f89814af1e..e3a858649942 100644
> --- a/security/apparmor/file.c
> +++ b/security/apparmor/file.c
> @@ -541,11 +541,8 @@ static int __file_sock_perm(const char *op, const struct cred *subj_cred,
>  			    struct aa_label *flabel, struct file *file,
>  			    u32 request, u32 denied)
>  {
> -	struct socket *sock = (struct socket *) file->private_data;
>  	int error;
>  
> -	AA_BUG(!sock);
> -
>  	/* revalidation due to label out of date. No revocation at this time */
>  	if (!denied && aa_label_is_subset(flabel, label))
>  		return 0;
> -- 
> 2.39.5
> 
