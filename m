Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDB20B817
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508291; cv=none; b=LbmzN1W9TFVbF4Q2iO/HeqmC86/6KtqmYpnwYPMFxrhQPFtJC0ZQ1b3T7Bzitjk7CC8zB9P6gzW2RlmxdzaNmVru8qq9U77aD7yIVDl35OWq+N/liAVvnaXhFlVYSlXcyZA0+67n9TeS/vgggzc+GEv2aELkKg37TvM9XmI9CoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508291; c=relaxed/simple;
	bh=xYu7mv+AKl6RD847kj+30pqzI/UU505MEfuhmi3dCmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDk4+PRY5pgwRtCLpmaeTFK7vCWLlAE48uu9SN3TgxQ0hthsbkvqi6A/J9sigYCFqLHd0B+WtKAIs3XeE/NQVZolS9+aR1OiiqxiyId/VZmmh2RJUuoJ8Xd0DNCPAqnFYDM9V1Pe99IMsk6QK6p299NJbe4B1xa3dxMuy8FzIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wLpNHGQA; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wLpNHGQA"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzp11x9Vz3n5;
	Fri, 10 Jan 2025 12:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508281;
	bh=5lL+heYdB/ShYMoCch+jsXhFcK8Z6nwMDhjvne5414o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wLpNHGQAsAoghNZFrQyiGFXOopSjbondI+lwiofDgUx9sbMf3v7aNUrGy/dhxWnGL
	 rXy33R9ngurHZH6ePbQa08UfTM6ogUlBDGRTYtUIDnJppTwa7QMRLhyPquf5jI2nxB
	 ZOuq4awP0mMbwbd+111Et52g50xgHn8YIjJcxxYo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzp01ckTzZ5X;
	Fri, 10 Jan 2025 12:24:40 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:39 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: Ben Scarlato <akhna@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, 
	Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, 
	Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 13/30] landlock: Optimize file path walks and prepare
 for audit support
Message-ID: <20250110.ahKa1heipoh9@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-14-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-14-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:21PM +0100, Mickaël Salaün wrote:
> Always synchronize access_masked_parent* with access_request_parent*
> according to allowed_parent*.  This is required for audit support to be
> able to get back to the reason of denial.
> 
> In a rename/link action, instead of always checking a rule two times for
> the same parent directory of the source and the destination files, only
> check it when an action on a child was not already allowed.  This also
> enables us to keep consistent allowed_parent* status, which is required
> to get back to the reason of denial.
> 
> For internal mount points, only upgrade allowed_parent* to true but do
> not wrongfully set both of them to false otherwise.  This is also
> required to get back to the reason of denial.
> 
> This does not impact the current behavior but slightly optimize code and
> prepare for audit support that needs to know the exact reason why an
> access was denied.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-14-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v2:
> - New patch.
> ---
>  security/landlock/fs.c | 44 ++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index ddadc465581e..01f9d5e78218 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -854,15 +854,6 @@ static bool is_access_to_paths_allowed(
>  				     child1_is_directory, layer_masks_parent2,
>  				     layer_masks_child2,
>  				     child2_is_directory))) {
> -			allowed_parent1 = scope_to_request(
> -				access_request_parent1, layer_masks_parent1);
> -			allowed_parent2 = scope_to_request(
> -				access_request_parent2, layer_masks_parent2);
> -
> -			/* Stops when all accesses are granted. */
> -			if (allowed_parent1 && allowed_parent2)
> -				break;
> -
>  			/*
>  			 * Now, downgrades the remaining checks from domain
>  			 * handled accesses to requested accesses.
> @@ -870,15 +861,32 @@ static bool is_access_to_paths_allowed(
>  			is_dom_check = false;
>  			access_masked_parent1 = access_request_parent1;
>  			access_masked_parent2 = access_request_parent2;
> +
> +			allowed_parent1 =
> +				allowed_parent1 ||
> +				scope_to_request(access_masked_parent1,
> +						 layer_masks_parent1);
> +			allowed_parent2 =
> +				allowed_parent2 ||
> +				scope_to_request(access_masked_parent2,
> +						 layer_masks_parent2);
> +
> +			/* Stops when all accesses are granted. */
> +			if (allowed_parent1 && allowed_parent2)
> +				break;
>  		}
>  
>  		rule = find_rule(domain, walker_path.dentry);
> -		allowed_parent1 = landlock_unmask_layers(
> -			rule, access_masked_parent1, layer_masks_parent1,
> -			ARRAY_SIZE(*layer_masks_parent1));
> -		allowed_parent2 = landlock_unmask_layers(
> -			rule, access_masked_parent2, layer_masks_parent2,
> -			ARRAY_SIZE(*layer_masks_parent2));
> +		allowed_parent1 = allowed_parent1 ||
> +				  landlock_unmask_layers(
> +					  rule, access_masked_parent1,
> +					  layer_masks_parent1,
> +					  ARRAY_SIZE(*layer_masks_parent1));
> +		allowed_parent2 = allowed_parent2 ||
> +				  landlock_unmask_layers(
> +					  rule, access_masked_parent2,
> +					  layer_masks_parent2,
> +					  ARRAY_SIZE(*layer_masks_parent2));
>  
>  		/* Stops when a rule from each layer grants access. */
>  		if (allowed_parent1 && allowed_parent2)
> @@ -902,8 +910,10 @@ static bool is_access_to_paths_allowed(
>  			 * access to internal filesystems (e.g. nsfs, which is
>  			 * reachable through /proc/<pid>/ns/<namespace>).
>  			 */
> -			allowed_parent1 = allowed_parent2 =
> -				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
> +			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
> +				allowed_parent1 = true;
> +				allowed_parent2 = true;
> +			}
>  			break;
>  		}
>  		parent_dentry = dget_parent(walker_path.dentry);
> -- 
> 2.47.1
> 
> 
