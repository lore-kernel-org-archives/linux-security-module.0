Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C81FB3;
	Sun,  9 Mar 2025 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741534115; cv=none; b=WZFNVvwpArGoqYVfy74REy2ZYUjWwZv+hCLZEcwr1ez0PqSi1lCzPSb21x4W0vonplXmmwtwdTR8Uik6+JP2N/6Tqifj9e8iejQcFv+UOA/qBcCqSPOZaXyOVUmRyKmv+ZFnmFCuglaxzgIPiM8XH6Iot01FqRPJeAXIo6Jf7O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741534115; c=relaxed/simple;
	bh=GLqJn90NpOB3NVZWTuF9R7824jnA7oFHGKAlTXcxvW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYdmfakJz1dc0MILW38Iy34ey1GzqrasC5I57rIXrLr4VxZHm2znoQj702ZeS690loIDWXtZpbHS0j1i0FhENZ4jXCzWHoGlLSv7sAlWvMm5t/BpHgriEME3dwiHoqKtnR11+tVxGWnbQatIo0COkOMrJsjgt35i5dhrFBmaGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 5F8B33F3; Sun,  9 Mar 2025 10:19:07 -0500 (CDT)
Date: Sun, 9 Mar 2025 10:19:07 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Max Kellermann <max.kellermann@ionos.com>,
	Andy Lutomirski <luto@kernel.org>
Cc: serge@hallyn.com, paul@paul-moore.com, jmorris@namei.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
Message-ID: <20250309151907.GA178120@mail.hallyn.com>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306082615.174777-1-max.kellermann@ionos.com>

On Thu, Mar 06, 2025 at 09:26:15AM +0100, Max Kellermann wrote:
> If a program enables `NO_NEW_PRIVS` and sets up
> differing real/effective/saved/fs ids, the effective ids are
> downgraded during exec because the kernel believes it should "get no
> more than they had, and maybe less".
> 
> I believe it is safe to keep differing ids even if `NO_NEW_PRIVS` is
> set.  The newly executed program doesn't get any more, but there's no
> reason to give it less.
> 
> This is different from "set[ug]id/setpcap" execution where privileges
> may be raised; here, the assumption that it's "set[ug]id" if
> effective!=real is too broad.
> 
> If we verify that all user/group ids remain as they were, we can
> safely allow the new program to keep them.

Thanks, it's an interesting point.  Seems to mainly depend on what users
of the feature have come to expect.

Andy, what do you think?

> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  security/commoncap.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 58a0c1c3e409..057a7400ef7d 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -861,6 +861,26 @@ static inline bool __is_setuid(struct cred *new, const struct cred *old)
>  static inline bool __is_setgid(struct cred *new, const struct cred *old)
>  { return !gid_eq(new->egid, old->gid); }
>  
> +/**
> + * Are all user/group ids in both cred instances identical?
> + *
> + * It can be used after __is_setuid() / __is_setgid() to check whether
> + * this is really a set*id operation or whether both processes just
> + * have differing real/effective ids.  It is safe to keep differing
> + * real/effective ids in "unsafe" program execution.
> + */
> +static bool has_identical_uids_gids(const struct cred *a, const struct cred *b)
> +{
> +	return uid_eq(a->uid, b->uid) &&
> +		gid_eq(a->gid, b->gid) &&
> +		uid_eq(a->suid, b->suid) &&
> +		gid_eq(a->sgid, b->sgid) &&
> +		uid_eq(a->euid, b->euid) &&
> +		gid_eq(a->egid, b->egid) &&
> +		uid_eq(a->fsuid, b->fsuid) &&
> +		gid_eq(a->fsgid, b->fsgid);
> +}
> +
>  /*
>   * 1) Audit candidate if current->cap_effective is set
>   *
> @@ -940,7 +960,8 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  	 *
>  	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
>  	 */
> -	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> +	is_setid = (__is_setuid(new, old) || __is_setgid(new, old)) &&
> +		!has_identical_uids_gids(new, old);
>  
>  	if ((is_setid || __cap_gained(permitted, new, old)) &&
>  	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
> -- 
> 2.47.2
