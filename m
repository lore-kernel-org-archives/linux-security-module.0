Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E308328B56
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921075; cv=none; b=GfvEhrNos+ry+JGM3cB5qOJ56QouCBfh0d66o7YBGU7PohG+DqE4DpCffiuWor2jl/eIwI5h64feH13lS23b0da1WOtW3kOBR7YS0yDXP1+M/trfp2MdRU2Z6kzba4dKXfm5VnTxPL4hpFBjHHGZbwVzOVcVC8h4QyEuFHwJmMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921075; c=relaxed/simple;
	bh=q6i6i87UMhelcqxGp6vPYhTMzeGbcyTrXJVBaB8Kp0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9Npl0vONb2pauv6zC0nEntfsMrVBFihurUK9AyLnhGK8RxF9AZbsTt2iUz1D9DxbdXlwVWWfDu+D/hXA7WpZnTwBknvqJ9LUiibGa9MWkicOBFOUVtDvIejr2dTmOISg0f/hRGRbVJQb3jlLliiRI1vtz022/wiajvwD0J9A6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=Sd1wvq7X; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="Sd1wvq7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1789921064; bh=q6i6i87UMhelcqxGp6vPYhTMzeGbcyTrXJVBaB8Kp0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sd1wvq7X8KkSNxwKgakUxoVISQb2CDefphLoC9s4VCzssNbLmUJFn49d4A8rTw3JY
	 NIpd7sgRaQ1j51aMvJ7BBHIu9M6098K6nf/gWPfd7GnVhNXYpdjdITWZeFcbQKLS2q
	 YSTG5HNHoL3jAld1ebcr23Z9gKK5cYlGjWBKQPD1VkNIR9b/7UvASK5Sji7kPUBOLd
	 k7jzpj/u6yeD9IrmSDNYjNHzrt4M1F5E+kb1hyLq0XHz0BFX9iqNWPLOJVfPyL+TKu
	 o3zlLHdgSC43Rs0p6kRwolE0eatXmHAml+1dilgf52lfytjzpfaVKWh8l8OjTZ2vXr
	 YK18z06aOPiNA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 3F1198A5; Sun, 20 Sep 2026 11:17:44 -0500 (CDT)
Date: Sun, 20 Sep 2026 11:17:44 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: commoncap: clarify CAP_FS_SET comment in
 cap_task_fix_setuid()
Message-ID: <arAHKMq3yF3uHcTZ@hallyn.com>
References: <20260919130112.849932-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919130112.849932-1-adrianox@gmail.com>

On Sat, Sep 19, 2026 at 10:01:12AM -0300, Adriano Cordova wrote:
> CAP_FS_SET is defined as exactly the capabilities an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so dropping it when fsuid leaves 0 is correct by construction, not
> "too harsh". Replace the stale FIXME with this explanation.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Thanks, but,

> ---
>  security/commoncap.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fe..e0a2f386c556 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1169,11 +1169,13 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>  		break;
>  
>  	case LSM_SETID_FS:
> -		/* juggle the capabilities to follow FSUID changes, unless
> -		 * otherwise suppressed
> +		/* Juggle the capabilities to follow FSUID changes, unless
> +		 * otherwise suppressed.
>  		 *
> -		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
> -		 *          if not, we might be a bit too harsh here.
> +		 * CAP_FS_SET is exactly the set of capabilities that an
> +		 * fsuid of 0 historically granted (see CAP_FS_MASK in
> +		 * <linux/capability.h>), so dropping that set when fsuid
> +		 * leaves 0 is intentional rather than too harsh.

"rather than too harsh" seems like arguing against the past comment.  Just
make it something like:

 +		 * CAP_FS_SET is exactly the set of capabilities that an
 +		 * fsuid of 0 historically granted (see CAP_FS_MASK in
 +		 * <linux/capability.h>), so we drop that set when fsuid
 +		 * leaves 0.

or

 +		/* Juggle the capabilities to follow FSUID changes, unless
 +		 * otherwise suppressed.  We drop the CAP_FS_SET when uid leaves
 +		 * 0, since that is the set of capabilities that an fsuid of 0
 +		 *  historically granted.

or even shorter.

>  		 */
>  		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>  			kuid_t root_uid = make_kuid(old->user_ns, 0);
> -- 
> 2.51.0
