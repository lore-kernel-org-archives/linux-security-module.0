Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BDD20B816
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508254; cv=none; b=hw1RmQySGBqLXyPMqlZHt/2mv1tYXsaELZCwlXMb3dv8zRSG0T605zNuF0BZ1NXMKd6Pmwaq9pgCPbhBqn82qkwqQBSooyvMvKbWZfZR6swXIajGcEP0eEN4b25DQ2FT6DgCp023duzYk48ddT+KFtJWlXi1Y5Owt0Bvevgkd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508254; c=relaxed/simple;
	bh=/N0KIqyLRiaSWcMGV9utkPlQK03mxO5bdBUXhzHD8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+5T7rF74srM6pbVB26PLDLBddxmCrHyqKs70TIBKJqS1YNPMH5kiY3gQo8JUZS6x067hp7t6MCXGfXfDgj2Ixc0ZTt+2ADalNNNA9YisMmpu0+2B/Iv69VwulhpcurkTO7iKAFKIiLa3+pqv36L1/rx6Dpy3ULH+j1UXHvIDnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=w4i75Lf5; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="w4i75Lf5"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTznJ2T38zXYS;
	Fri, 10 Jan 2025 12:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508244;
	bh=NE4BqeM75LCdZC7qq41D9xBQe3I6eY4MowIEGlNpsvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w4i75Lf5MBp8SaR6voAoII0oIX1rc6925D6pWGbrUUUmjQgcMC7Om4GxBh5XAA7Ri
	 EUbinOQhTzXUf9DdDpDFU1jp8yb6Iy8bRtm+9QjlQFP+GOcNB6lFlbidllHbEykpv+
	 4GLvT7OSAyFPx8TdNGQVhZBJP6aCBywRpkCbhyOU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTznH4mp3zL2Z;
	Fri, 10 Jan 2025 12:24:03 +0100 (CET)
Date: Fri, 10 Jan 2025 12:24:03 +0100
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
Subject: Re: [PATCH v4 06/30] landlock: Simplify initially denied access
 rights
Message-ID: <20250110.lie1eeCiefoo@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-7-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:14PM +0100, Mickaël Salaün wrote:
> Upgrade domain's handled access masks when creating a domain from a
> ruleset, instead of converting them at runtime.  This is more consistent
> and helps with audit support.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-7-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v2:
> - New patch.
> ---
>  security/landlock/access.h  | 17 ++++++++++++++++-
>  security/landlock/fs.c      | 10 +---------
>  security/landlock/ruleset.c |  3 ++-
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/security/landlock/access.h b/security/landlock/access.h
> index 9ee4b30a87e6..74fd8f399fbd 100644
> --- a/security/landlock/access.h
> +++ b/security/landlock/access.h
> @@ -20,7 +20,8 @@
>  /*
>   * All access rights that are denied by default whether they are handled or not
>   * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
> - * entries when we need to get the absolute handled access masks.
> + * entries when we need to get the absolute handled access masks, see
> + * landlock_upgrade_handled_access_masks().
>   */
>  /* clang-format off */
>  #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
> @@ -59,4 +60,18 @@ typedef u16 layer_mask_t;
>  /* Makes sure all layers can be checked. */
>  static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
>  
> +/* Upgrades with all initially denied by default access rights. */
> +static inline struct access_masks
> +landlock_upgrade_handled_access_masks(struct access_masks access_masks)
> +{
> +	/*
> +	 * All access rights that are denied by default whether they are
> +	 * explicitly handled or not.
> +	 */
> +	if (access_masks.fs)
> +		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> +
> +	return access_masks;
> +}
> +
>  #endif /* _SECURITY_LANDLOCK_ACCESS_H */
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 3da5f1945158..9779170d9199 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -389,14 +389,6 @@ static bool is_nouser_or_private(const struct dentry *dentry)
>  		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
>  }
>  
> -static access_mask_t
> -get_handled_fs_accesses(const struct landlock_ruleset *const domain)
> -{
> -	/* Handles all initially denied by default access rights. */
> -	return landlock_union_access_masks(domain).fs |
> -	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
> -}
> -
>  static const struct access_masks any_fs = {
>  	.fs = ~0,
>  };
> @@ -788,7 +780,7 @@ static bool is_access_to_paths_allowed(
>  		 * a superset of the meaningful requested accesses).
>  		 */
>  		access_masked_parent1 = access_masked_parent2 =
> -			get_handled_fs_accesses(domain);
> +			landlock_union_access_masks(domain).fs;
>  		is_dom_check = true;
>  	} else {
>  		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
> diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> index cae69f2f01d9..dbc528f5f3b7 100644
> --- a/security/landlock/ruleset.c
> +++ b/security/landlock/ruleset.c
> @@ -385,7 +385,8 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
>  		err = -EINVAL;
>  		goto out_unlock;
>  	}
> -	dst->access_masks[dst->num_layers - 1] = src->access_masks[0];
> +	dst->access_masks[dst->num_layers - 1] =
> +		landlock_upgrade_handled_access_masks(src->access_masks[0]);
>  
>  	/* Merges the @src inode tree. */
>  	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
> -- 
> 2.47.1
> 
> 
