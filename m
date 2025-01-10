Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832820B1F1
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508229; cv=none; b=lNSqVRrYSnHbHpf3WuEyoc6G3ed1Il52VjP3c3jrw+cqKVvMFf4i7pjrOhPHLln0T9ssQBhkTEpr6JJBfLr4zPPlCd+PpwT+RpLlcBSO2kEEuonfny3jKbvGsvRwwN93C//cXmFaF3jd2TRUTWxzimBh3b9AjSy1Kk2zfPUqBH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508229; c=relaxed/simple;
	bh=P/e0dY5XMyiw0YEWIgSL05snUYcZJ43RnVDi/y8oMsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpMKbZFf6IqzWXYfULKAfadRnQeSn5HEBiZCJIStpVkMri+d2lqFfjsPLTk4p2rWhRjHrUhKEDD2xALq3JfJRY5x/j7iEPbughP6+9suIiFW/HZmRYLylzbIRzJK1yP72j8DFK3maMG2WMJxpOLfXVq59KwbnLzvBU830rQ9L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QTKvBD+p; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QTKvBD+p"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YTzmn6BBhz458;
	Fri, 10 Jan 2025 12:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736508217;
	bh=3a63Wx3OsDwDGItCFvlvrHG86rphCff+zCWgaHsznAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTKvBD+psbWwXMeGw9xaDslFpLH5M5c+sL/OBfoA2bYl9Pz3CNQrRp2FMYtgAgKDX
	 Vo/3y/VQLA3t8/ECD2oYAimIi1WsYtqN+jQ/Td6FsoDNAGUSeQgh6u664IOsUwpGnx
	 HyWPENuS6E+DOlb9+ONU0p4aNPQrq5aQE5nnQmWU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YTzmm4KKBzmMM;
	Fri, 10 Jan 2025 12:23:36 +0100 (CET)
Date: Fri, 10 Jan 2025 12:23:35 +0100
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
Subject: Re: [PATCH v4 03/30] landlock: Factor out check_access_path()
Message-ID: <20250110.dieb2ie6eeC0@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-4-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jan 08, 2025 at 04:43:11PM +0100, Mickaël Salaün wrote:
> Merge check_access_path() into current_check_access_path() and make
> hook_path_mknod() use it.
> 
> Cc: Günther Noack <gnoack@google.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-4-mic@digikod.net

Pushed in my next tree to simplify next patch series.

> ---
> 
> Changes since v1:
> - Rebased on the TCP patch series.
> - Remove inlining removal which was merged.
> ---
>  security/landlock/fs.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index e31b97a9f175..d911c924843f 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -908,28 +908,22 @@ static bool is_access_to_paths_allowed(
>  	return allowed_parent1 && allowed_parent2;
>  }
>  
> -static int check_access_path(const struct landlock_ruleset *const domain,
> -			     const struct path *const path,
> -			     access_mask_t access_request)
> -{
> -	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
> -
> -	access_request = landlock_init_layer_masks(
> -		domain, access_request, &layer_masks, LANDLOCK_KEY_INODE);
> -	if (is_access_to_paths_allowed(domain, path, access_request,
> -				       &layer_masks, NULL, 0, NULL, NULL))
> -		return 0;
> -	return -EACCES;
> -}
> -
>  static int current_check_access_path(const struct path *const path,
> -				     const access_mask_t access_request)
> +				     access_mask_t access_request)
>  {
>  	const struct landlock_ruleset *const dom = get_current_fs_domain();
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
>  
>  	if (!dom)
>  		return 0;
> -	return check_access_path(dom, path, access_request);
> +
> +	access_request = landlock_init_layer_masks(
> +		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
> +	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
> +				       NULL, 0, NULL, NULL))
> +		return 0;
> +
> +	return -EACCES;
>  }
>  
>  static access_mask_t get_mode_access(const umode_t mode)
> @@ -1414,11 +1408,7 @@ static int hook_path_mknod(const struct path *const dir,
>  			   struct dentry *const dentry, const umode_t mode,
>  			   const unsigned int dev)
>  {
> -	const struct landlock_ruleset *const dom = get_current_fs_domain();
> -
> -	if (!dom)
> -		return 0;
> -	return check_access_path(dom, dir, get_mode_access(mode));
> +	return current_check_access_path(dir, get_mode_access(mode));
>  }
>  
>  static int hook_path_symlink(const struct path *const dir,
> -- 
> 2.47.1
> 
> 
