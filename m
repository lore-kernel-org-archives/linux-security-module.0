Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1B2857C7
	for <linux-security-module@vger.kernel.org>; Tue,  1 Jul 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400637; cv=none; b=oBjPwtuVmWwPYyz/mTOe2AX8AbHIty7fSYnlFblN9IBcPQoSyN8CTtc7Ns9UfcMfQrMhMVVaQZHV9aaXEzeVKJ5IdwhDG8LsKjC5Ujv9BA+G2udMwGvf0wWHLFBkKyeTuwIyb+NVZDTaXTDOKXhUavcHFdtKjIZsdzjCWjhXIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400637; c=relaxed/simple;
	bh=AOEFrwQEMYLYorbfRysPCBxzTHriI7GjtIoUI51AhLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAiZ9rBKk90qjPL/KZMWJNxm1LxXXW6J2FYl7S2dME7G5DZUTWePomjDtl+KM76HoVjepb0mHgI5tLNrEu0FFruYABQo0rxn8lZ2B5pjrqdFgggBnmu8145kDbxsf4JZ6izVjw+F1A55qQhFsrmtvub2VpNbiZ7/Wc1Fqhq/4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=k+lSiKcA; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="k+lSiKcA"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bWv8z2C2VzM10;
	Tue,  1 Jul 2025 22:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1751400195;
	bh=wQsSGnPmX/DSqtXTMNJLb3ONYmVBJCbIpCXAyYU8l6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+lSiKcAs1qoR+PRl9GRbjWfE5lemzQhJbwCy7k5bX/FfMkImfvfXpneVRMH9U7/Z
	 AQ//74KFElbHHkWSkufdzjiI5L3YA02CIeJr6pwpKdJq7rR7ZW9+5fnZTB3j+auN24
	 Jv/JTpIpi6Mwtso9zd9Kyl2Y5Xnf/vL00j2Gtb4c=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bWv8y5rR2zCwY;
	Tue,  1 Jul 2025 22:03:14 +0200 (CEST)
Date: Tue, 1 Jul 2025 22:03:12 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v1] landlock: Remove warning in collect_domain_accesses()
Message-ID: <20250701.Thaey9eej8oo@digikod.net>
References: <20250618134734.1673254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618134734.1673254-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Jun 18, 2025 at 03:47:31PM +0200, Mickaël Salaün wrote:
> As in is_access_to_paths_allowed(), it is also possible to reach
> disconnected root directories in collect_domain_accesses().
> 
> Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
> fix comment.  Using an unlikely() annotation doesn't seem appropriate
> here.  A following patch from Tingmao tests this case [1].
> 
> Cc: Günther Noack <gnoack@google.com>
> Reported-by: Tingmao Wang <m@maowtm.org>
> Link: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org [1]
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

This patch hides an edge cases that I though wasn't supposed to happen.
I'll drop it in favor of this other patch which fixes the underlying
issue:
https://lore.kernel.org/all/20250701183812.3201231-1-mic@digikod.net/

> ---
>  security/landlock/fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..1d6c4e728f92 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1061,8 +1061,8 @@ static bool collect_domain_accesses(
>  			break;
>  		}
>  
> -		/* We should not reach a root other than @mnt_root. */
> -		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
> +		/* Stops at the mount point or disconnected root directories. */
> +		if (dir == mnt_root || IS_ROOT(dir))
>  			break;
>  
>  		parent_dentry = dget_parent(dir);
> -- 
> 2.49.0
> 
> 
