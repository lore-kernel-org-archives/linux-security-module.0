Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48D3164DF;
	Fri, 10 Apr 2026 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782731; cv=none; b=IlnFgWHijwoch9xR+AYS6UMF9kEKmAwhObxAX1A131h7NS4FFaSD6LvgGo8jsMtU82lhOAuVfEoNOdh/VsEleXb7xYr/B/tTxyyXhIBb/ZK+N9JYOFtRSmaMdx0CFWFF6BHBzMaMeDnp3JGH7JmHyC2HVCLIhFbmCVwNJVbrRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782731; c=relaxed/simple;
	bh=HCSNVoD/YllngQzvSjLWcpOvgW8s6TRweG9I13+lFZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfYEihSVXl5ctcXe7/4HD+0C5FoRN3mNL/kHdMYQGEJUf0ddZfQ4Z5gf0mqgZT3b4TS4tg1g4Xyro2ebFqrJz5AjtnH3AIBqo2X9xjiINE+1uf4VBf+W9MuVfJtU2lQl0i27r5af6PasWUbZQAgT5onAL3BPSCC6iRu1t3ws3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=Ybf5FrOG; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="Ybf5FrOG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1775782720; bh=HCSNVoD/YllngQzvSjLWcpOvgW8s6TRweG9I13+lFZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ybf5FrOGniVDfBCVENPjTXcJPBl6fuXsr5v8tQ5OuJfXTqQyWSMhTbuuFEkWiFYQX
	 +5FclaYUVXSjVemy+XGRIJEr6G4u+OgeitMBqrO2BtnxRf44dVNRdhQ54Hhl32hKfW
	 UlyDM1VcxZa7JUNAtrzeaOixD3PJaYvMYCGH944nDpVlgiVDfGdLvWx6UDXK2sqpBx
	 nRjc8K8k1ey+TIXoC/JDiONH+HN59KHRNi2iwPjtrbaClFJRE2ZLUmp7lenE+q0BaN
	 ZLFvNYKOj6d3JbH8OPMsg0f9GHc0ljdHJdki48jsPDZb+r47azBtH3vnW92rGx7bLp
	 Tl/eRh3Q8qtGQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id B16B1DD4; Thu,  9 Apr 2026 19:58:40 -0500 (CDT)
Date: Thu, 9 Apr 2026 19:58:40 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org,
	Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH] security: remove BUG_ON in security_skb_classify_flow
Message-ID: <adhLQDIILT/sHpzL@mail.hallyn.com>
References: <20260408114257.298500-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408114257.298500-1-jiayuan.chen@linux.dev>

On Wed, Apr 08, 2026 at 07:42:57PM +0800, Jiayuan Chen wrote:
> A BPF program attached to the xfrm_decode_session hook can return a
> non-zero value, which causes BUG_ON(rc) in security_skb_classify_flow()
> to trigger a kernel panic.

It would seem worth it to have pointed at the previous discussion at

https://lore.kernel.org/all/CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com/

Based on that, I guess this is probably ok, but still,

> Remove the BUG_ON and change the return type from void to int, so that
> callers can optionally handle the error.

but you don't have the existing callers handling the error.  It's
conceivable they won't care, but it's also possible that they were
counting on a BUG_ON in that case.

What *should* callers (icmp_reply, etc) do if an error code is
returned?  Should they ignore it?  In that case, would it be
better to change security_skb_classify_flow() to return void?

> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/4c4d04ba.6c12b.19c039b69e6.Coremail.kaiyanm@hust.edu.cn/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/linux/security.h |  7 ++++---
>  security/security.c      | 16 +++++++++++-----
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ee88dd2d2d1f..6d210dc4c649 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1975,7 +1975,7 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
>  				       struct xfrm_policy *xp,
>  				       const struct flowi_common *flic);
>  int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid);
> -void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic);
> +int security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic);
>  
>  #else	/* CONFIG_SECURITY_NETWORK_XFRM */
>  
> @@ -2038,9 +2038,10 @@ static inline int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
>  	return 0;
>  }
>  
> -static inline void security_skb_classify_flow(struct sk_buff *skb,
> -					      struct flowi_common *flic)
> +static inline int security_skb_classify_flow(struct sk_buff *skb,
> +					     struct flowi_common *flic)
>  {
> +	return 0;
>  }
>  
>  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
> diff --git a/security/security.c b/security/security.c
> index a26c1474e2e4..26a34eb363c2 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4990,12 +4990,18 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
>  	return call_int_hook(xfrm_decode_session, skb, secid, 1);
>  }
>  
> -void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
> +/**
> + * security_skb_classify_flow() - Set the flow's secid from the security label
> + * @skb: packet
> + * @flic: flow common structure to set
> + *
> + * Decode the packet in @skb and set the flow's secid in @flic.
> + *
> + * Return: Return 0 if successful.
> + */
> +int security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
>  {
> -	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
> -			       0);
> -
> -	BUG_ON(rc);
> +	return call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
>  }
>  EXPORT_SYMBOL(security_skb_classify_flow);
>  #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
> -- 
> 2.43.0
