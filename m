Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23F2F8EBE
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096583; cv=none; b=l3x63aO9W0+FCVfCAk4LFHs0bz7/xpEgLvxWNQR83V8rzjBwJZwHj0gS+kfH011kRygjPSDLlVXmyMbvXd9OBqU+U6AkeCu7euiqcrSap10LYku1iYYbYETumjLb3srdIy4ZFXJ68pR9rK1uG2CCVhE+5/kZ4/5NH+wA+QEOIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096583; c=relaxed/simple;
	bh=WUUjCpZfUC2x2aEB8HSKaqRfzjiFrN8NnXYCNKt0i4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6RCa5tHQY4aQAoifBr1Y0tNuzUwZ6AbgWEZJv7M5MAAwRJ4YMDKf8DsxVbnqFGgFLScNfZ38OwzAemMtIMJEChNkUcQH2xvBQn3BFtiE0qTMUC90iOhoZ1qTJr3Hh3ysW6/mF9iyUNpdU4ulhq30QFK5KcKVEmeR9Nws1KX5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=phPVegvk; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="phPVegvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1790096579; bh=WUUjCpZfUC2x2aEB8HSKaqRfzjiFrN8NnXYCNKt0i4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phPVegvkuzvSc68WxBYPSJ6tgwUzkGU5GK0Mx5FKBrcIGbJEcJ/G62PRbLMOXnocf
	 p50vmPmNQWD3/G9FSV4sZhdJVKddf6QvRIHCI3up1/keDyUc/wY49az4XlaCAGqcS8
	 NWGSdlKwTidgoWOlte4nqoLRCoj5+Ck73G+Kwqva2CLHqGJZljS05FVg98iUXO2dvz
	 8+10A8GOJUjdQU5tnonGNNTRGR3gRtD8DK8rdA3teMs5SSf9oTiQa46usnMq2UOkjP
	 MoEhUnDDPRg35QOIo1GUmfGu63gNeaHoPfm0fDnd/p1zh98jrVPAU7cI0jCY9Y/+Gy
	 mf41RHwe09X8Q==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 65A181D11; Tue, 22 Sep 2026 12:02:59 -0500 (CDT)
Date: Tue, 22 Sep 2026 12:02:59 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] security: commoncap: clarify CAP_FS_SET comment in
 cap_task_fix_setuid()
Message-ID: <arK0w65j4F2M3e+o@hallyn.com>
References: <20260921025209.1023530-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921025209.1023530-1-adrianox@gmail.com>

On Sun, Sep 20, 2026 at 11:52:08PM -0300, Adriano Cordova wrote:
> CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so cap_task_fix_setuid() drops that set from the effective set when
> fsuid leaves 0.  Replace the stale FIXME with this explanation.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

lgtm, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

If I don't see objections soon, I can merge it into the caps-next
tree.

thanks,
-serge

> ---
> v2: reword the comment to something more concise.
> 
>  security/commoncap.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fe..1ba2ea2651fc 100644
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
> +		 * <linux/capability.h>), so we drop that set when fsuid
> +		 * leaves 0.
>  		 */
>  		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>  			kuid_t root_uid = make_kuid(old->user_ns, 0);
> -- 
> 2.51.0
