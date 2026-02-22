Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849161BC46;
	Sun, 22 Feb 2026 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793949; cv=none; b=aU+TLd9JTlu3RjfFq3j6KLSikv+IuRE8HB0JzrqHrcQHprl4/9HF3Vrj7IGrCWfFqHgBbqWGmalkN3721FGZ+lTq+DBsqGnmm85befMBnCov+J+lkwMzJnfDfCGmaK29r64n5kaGlG9Ex+d5kgPxjiCwdidCG38aaEKgVAPzGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793949; c=relaxed/simple;
	bh=rBR6mKA2YTWqFBrvr1bBxZQaQCdGcFHlkMKutJewIj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3fjHFE+A1m7P1Hc+xvmPWTWQa7A4VaxkM35XF533KlQqD+Xq+h+8zRAKO8Fot8A3n84wPjrwxn9SDlWB0XyboomKYORgwskoRBccg5PcB3/lwHcDfTO+NqshtMCBKNwmEcVRU+mbqwdEhqvEzhQiGVgLK3FPnEaI6MaH0570e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=wEn05ERF; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="wEn05ERF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1771793587; bh=rBR6mKA2YTWqFBrvr1bBxZQaQCdGcFHlkMKutJewIj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEn05ERFEe2N1GPBVte78a078GlaXXGHzLndIa1hlcGD61ukrW4MzYXlByXtFdtaa
	 H9H2WOs3Nw/pH22lzVOy1nqJVOq+reqUwwT/JQwZsb0XuVkOY8SKl5DgOZv1mge8zI
	 BdAvwLVNjB286Mn0LG1+/t+EIptaDblmfjgVllf8GBMxD1/ELm68/xGpvv7weA3H/J
	 4eU+ovqVBZoPVDXvEXT4n+5p064JtW+i8PLsDj6r1tTnQAvrrG1PRqc4pcTgwvykKN
	 vZTiteOJc1p8bazaONCrFXbwMTZLa23XFiXIGtiVm0fV3THD87oXAcKC76LDj7BXFR
	 k6wTckYGi6bYA==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B78FB5A4; Sun, 22 Feb 2026 14:53:07 -0600 (CST)
Date: Sun, 22 Feb 2026 14:53:07 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] apparmor: Replace memcpy + NUL termination with
 kmemdup_nul in do_setattr
Message-ID: <aZtss2/FsdJSrk0y@mail.hallyn.com>
References: <20260222204645.285727-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222204645.285727-1-thorsten.blum@linux.dev>

On Sun, Feb 22, 2026 at 09:46:44PM +0100, Thorsten Blum wrote:
> Use kmemdup_nul() to copy 'value' instead of using memcpy() followed by
> a manual NUL termination.  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks correct, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/apparmor/lsm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index c1d42fc72fdb..49aa6ad68838 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -858,12 +858,9 @@ static int do_setattr(u64 attr, void *value, size_t size)
>  
>  	/* AppArmor requires that the buffer must be null terminated atm */
>  	if (args[size - 1] != '\0') {
> -		/* null terminate */
> -		largs = args = kmalloc(size + 1, GFP_KERNEL);
> +		largs = args = kmemdup_nul(value, size, GFP_KERNEL);
>  		if (!args)
>  			return -ENOMEM;
> -		memcpy(args, value, size);
> -		args[size] = '\0';
>  	}
>  
>  	error = -EINVAL;
> -- 
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
