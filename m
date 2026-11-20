Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200590;
	b=bvLz+bvH7EnaOhWFeR3/A9I2ig23OpFCoOS9/afWGXHvHRoeI1YLOBtCK0dyMl4gFn1I
	 CyIw2YAOwhMtvUkWaO9ajWaMVGGuh2LkxMjxEM+Oda6nPmpgjGfL+UlPrN3fSG5CkHKZs
	 zZ1KQUfxsbcHfS5J8tH/LaGBb9k6sws1vrrfZG7c0GJudxxxO9t13BAotJyMkU20QUWwf
	 UQcpWIvDtDrpZ5oYq7tnewtZyZQynRVlBB3ytuhmnQWyw+NalrgWyXEHImwfYjnVx+8H+
	 SSnG/zuUZ3U9id6Rq4SL0OdA4x7gymFfWLl+gQCUp0AExfRVU2Iad9SLwye8ZBzBbTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200590;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=XYtsVlEZl8Fj/hcnDHPqSyT31OJt3z5iI8BgLW1/8dc=;
	b=3TVA3KrOTTgeV4bZ1Iy1GbPu7yyNKogs2DJzUrdh7CGy7sDDWB9Jacmt2ehqwdJ+yt7v
	 jwhWYiWKct12STPMgb4iw5ikm7lMzdQU4uJCMOEmlIBuzg1m8qUkjCSBEU+5yu8Fuq9f8
	 vcshQpfxSeID3zUGhvfrKPFdb28UzbEtf/QI3VpFPeg1fPOE9vrH0Mhj3Z6XM/kQEJf9f
	 rUfuzsaTGAnnq0DM4ejfO0eSfcfKJZ4B0JsAy74DqcFwTWgYemnAitob0uLdtQi+5+Y4d
	 fJtAUarz3rGlbvqiHPHHT/OrsGrT+cWxfZY+mlamix3P1Mk/r/epEldsEH4QQWQerYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lXASmD6A;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168560A2624
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 18:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F168560A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=lXASmD6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1795200583; bh=o6eA2nTORk6Ad4cWAZ5rXooOfuwXUMBEXoYuz7q6THw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lXASmD6ASd7wpiQSuue7DPWA0tUyodwIWVXeqjsOn79edcHRU3Tdl404T7AXQFU59
	 K6dGfqYEh0lyQFo8cLMrCPPYJJj/Nv+zyDwBZvyXY1Wo9PK6+AYsJXKDYxgBolBTDM
	 /Wikqd1xw9eaBUG9Ag/4y7o+Ij6Q5WqfWOyP5nVk5pRYBrtd7KJYdsrzZtc1EWrRAw
	 2lkKxeMBJQouI19Rd9nRy14pIZ0GIGPFGNVv4+979sX0evF6ALK8iwfaQupbjGfFRl
	 YfLxmDvbB+Q91Jd3CbhYn2FnNmpHP4SCg1q0fLqgsKxP9DOOU4xcLt8K22tPdBVg7y
	 hhQhLaki1+mkg==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id D73D7FDC; Fri, 20 Nov 2026 12:49:43 -0600 (CST)
Date: Fri, 20 Nov 2026 12:49:43 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Serge Hallyn <sergeh@kernel.org>, Paul Moore <paul@paul-moore.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	John Johansen <john.johansen@canonical.com>,
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH v1] lsm: Set PF_SUPERPRIV only when all mmap_addr hooks
 allow a mapping
Message-ID: <awCWRzL9Y2uEm9pp@hallyn.com>
References: <20261118165603.2573289-1-mic@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118165603.2573289-1-mic@digikod.net>

On Wed, Nov 18, 2026 at 05:56:02PM +0100, Mickaël Salaün wrote:
> cap_mmap_addr() sets PF_SUPERPRIV when commoncap grants CAP_SYS_RAWIO
> for a mapping below vm.mmap_min_addr, before the other LSMs' mmap_addr
> hooks run.  If one of them then denies the mapping (e.g. SELinux's
> mmap_zero check), process accounting still reports a use of privileges.
> 
> Set the flag in security_mmap_addr() once all hooks allowed the mapping,
> as ns_capable() does after security_capable().  commoncap runs first and
> denies such a mapping without CAP_SYS_RAWIO, so a successful hook chain
> means that the capability was used.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Although I have two suggestions that you can take or leave - first, I
think rc == 0 would be nicer than !rc.  Second, you could keep the
PF_SUPERPRIV setting in one place by having security_mmap_addr defined
only once in security.h, and having it call do_security_mmap_addr(),
which changes based on whether CONFIG_SECURITY is set.  Otherwise I
could see the two spots getting out of sync after some future update.

> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: Günther Noack <gnoack@google.com>
> Closes: https://patch.msgid.link/avxjfHybQBcATFKV@google.com
> Fixes: 9c0d90103c7e ("Capabilities: move cap_file_mmap to commoncap.c")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  include/linux/security.h | 6 +++++-
>  security/commoncap.c     | 6 +-----
>  security/security.c      | 7 ++++++-
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1e89bc1fec17..faf118b58ade 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1209,7 +1209,11 @@ static inline int security_mmap_backing_file(struct vm_area_struct *vma,
>  
>  static inline int security_mmap_addr(unsigned long addr)
>  {
> -	return cap_mmap_addr(addr);
> +	int rc = cap_mmap_addr(addr);
> +
> +	if (!rc && addr < dac_mmap_min_addr)
> +		current->flags |= PF_SUPERPRIV;
> +	return rc;
>  }
>  
>  static inline int security_file_mprotect(struct vm_area_struct *vma,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 9794a594bdd9..36c7b394867d 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1471,13 +1471,9 @@ int cap_mmap_addr(unsigned long addr)
>  {
>  	int ret = 0;
>  
> -	if (addr < dac_mmap_min_addr) {
> +	if (addr < dac_mmap_min_addr)
>  		ret = cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
>  				  CAP_OPT_NONE);
> -		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
> -		if (ret == 0)
> -			current->flags |= PF_SUPERPRIV;
> -	}
>  	return ret;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index 36365fac5801..fd6717de31ad 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2687,7 +2687,12 @@ EXPORT_SYMBOL_GPL(security_mmap_backing_file);
>   */
>  int security_mmap_addr(unsigned long addr)
>  {
> -	return call_int_hook(mmap_addr, addr);
> +	int rc = call_int_hook(mmap_addr, addr);
> +
> +	/* commoncap granted CAP_SYS_RAWIO and no LSM denied the mapping. */
> +	if (!rc && addr < dac_mmap_min_addr)
> +		current->flags |= PF_SUPERPRIV;
> +	return rc;
>  }
>  
>  /**
> -- 
> 2.56.0
