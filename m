Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0A2D5C8B;
	Sun, 12 Oct 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282295; cv=none; b=sKIfZJWunkL7NSwGCSOHTQVYRh+XYfR/os5Eyh84/DQTMnQQL5ownYSb6+Wv6wQnKZp7G+mBHVch904nyIvOn+s+XXWu1Wc8Urr6q5qr7Vw4iHHtiiKv3QXA89U2l0uxAowVGL1zn8+DitiJ+CtQQgcpq08UtXqOpTgSz4/uE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282295; c=relaxed/simple;
	bh=wt77LmNnwFo6UI841ru/pL7ok7hvQWJrGnshi+TZyig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXMep0J1QALAcJOr8eb2EvtFrpT9mOhm7o17OSc1H8RlbZtYkUK07/wGuGYZgVpN0sQaYW4CEAlDHNlPCzSAqi4vOIOlEPlvF7upOFi3Hc0BFEpk0mSXlVaXiROlPGttaEIjMwF8FFybh+kOaNrSXAUPrEZGw3QWEWS7TeHWP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6224D758; Sun, 12 Oct 2025 10:07:45 -0500 (CDT)
Date: Sun, 12 Oct 2025 10:07:45 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-hardening@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] apparmor: Replace sprintf/strcpy with scnprintf/strscpy
 in aa_policy_init
Message-ID: <aOvEQVqYUnMXrMxI@mail.hallyn.com>
References: <20251011164645.46822-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011164645.46822-2-thorsten.blum@linux.dev>

On Sat, Oct 11, 2025 at 06:46:46PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated and sprintf() does not perform bounds checking
> either. Although an overflow is unlikely, it's better to proactively
> avoid it by using the safer strscpy() and scnprintf(), respectively.
> 
> Additionally, unify memory allocation for 'hname' to simplify and
> improve aa_policy_init().
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/lib.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
> index 82dbb97ad406..acf7f5189bec 100644
> --- a/security/apparmor/lib.c
> +++ b/security/apparmor/lib.c
> @@ -478,19 +478,17 @@ bool aa_policy_init(struct aa_policy *policy, const char *prefix,
>  		    const char *name, gfp_t gfp)
>  {
>  	char *hname;
> +	size_t hname_sz;
>  
> +	hname_sz = (prefix ? strlen(prefix) + 2 : 0) + strlen(name) + 1;
>  	/* freed by policy_free */
> -	if (prefix) {
> -		hname = aa_str_alloc(strlen(prefix) + strlen(name) + 3, gfp);
> -		if (hname)
> -			sprintf(hname, "%s//%s", prefix, name);
> -	} else {
> -		hname = aa_str_alloc(strlen(name) + 1, gfp);
> -		if (hname)
> -			strcpy(hname, name);
> -	}
> +	hname = aa_str_alloc(hname_sz, gfp);
>  	if (!hname)
>  		return false;
> +	if (prefix)
> +		scnprintf(hname, hname_sz, "%s//%s", prefix, name);
> +	else
> +		strscpy(hname, name, hname_sz);
>  	policy->hname = hname;
>  	/* base.name is a substring of fqname */
>  	policy->name = basename(policy->hname);
> -- 
> 2.51.0
