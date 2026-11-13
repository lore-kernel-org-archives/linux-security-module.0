Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.66.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605982;
	b=dBz9YtpeIPBTYvQ/jBsG0KnwSvYyizIfrXASnCzWnZ8SzKAzYlzX93N2BlSc44Hn37ET
	 D42mhQ/lkXAsgK1frZk+wuUUQPsLEvuDCLcKIvxX0mLa53OdFk7+y0W3j0kMJpWsJ7A4d
	 WEw3aVI8omuHFzIs5oQKLH72vSzAk1NsGH7uIywL93LFJsUGnvezE2autoEtLH0wxx+6v
	 Brn/Uyu79oQQjk7VlPpXpHBTmJfbdXKt0stfrRKzmozFS/uxKa6vTIHdvqx53WUVZ5By3
	 hxJ60Qm4Nmn7tBBxkDFCPwPwfHTWTVEx8cSNhAfBz5L/upkht+QtKxsReh3DFSo/ORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605982;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qCl0FM4D5hbd6BuBZCWtuwyK/AdR8J6n7oaD+82ev5E=;
	b=48hI8r6bvJgfeN7wMNkDX7Oln874un2koc4Gc5q2qgfdtYNLEhGn2Et1iCwOLE1QEKQt
	 eCE8+cFFKLivdK9M6JbpczcZvd1ys9FXx1HcWoLwyxYO9hnnCbRSEYX4VLo3JoVaoalXX
	 nHX6ca9rcPQJXPCZMxX3Htr18HXjNskOaWFd1yXaWT8G7yMGtRavJB1OajzAf4Rom0q28
	 ae2HGiew+eWo9YAsU5ynqit6LpS2NeZ5R0xe8kkTzSXylmKEEWto2D8CJiQbjRjKmD40f
	 khXGTxw/Xn8XQeuxGb1LitNETB+tmwqji+tq2zjFeBWxnWWAIKDLIR+peoX+pi3+t9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hallyn.com;
	spf=pass smtp.mailfrom=hallyn.com;
	dkim=pass header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=LWHHXKvB;
	arc=none smtp.remote-ip=178.63.66.53
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E2606A332;
	Fri, 13 Nov 2026 21:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C25E2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hallyn.com header.i=@hallyn.com header.a=rsa-sha256 header.s=mail header.b=LWHHXKvB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1794605973; bh=bcJMN9ZOHAZMoUBZwYV1cTt3QNFc63I/onNMzL9vYe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWHHXKvBec1e4WC080N0a3TlJmkAMIQnpB8v9zPvHlkQDt13hL2gks1hgyrfpBAv0
	 dvnsOdfM3MUTvUEF3trF+Vpe6ngoBz6Q0iBK2dmUmMjvFHzVmMACYMptC+XNozCV6s
	 I4Vt1DCyzPh0HPryV0dWb2WkkEUbXD+PMavaNyQ9dPVd9hdL0b6Pz+ozWjZZgkWdpa
	 buP958XOaul/2j5bKZu8ber4dZIbuoxzcMlxNsinMCaHmKAiqaiZ1+ZQEPBbB9OvvD
	 Ba/emKxQN6xKWtoc/L8lvnJPwyHOyoN4G0GZFPpiI0SE4PYHcOuYIH2K6ERgZxRqmO
	 4azvqg4/p/GjQ==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 833DC1962; Fri, 13 Nov 2026 15:39:33 -0600 (CST)
Date: Fri, 13 Nov 2026 15:39:33 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userns: security: Inform LSMs of capability check during
 userns creation
Message-ID: <aveDlb6PlPSVoLD9@hallyn.com>
References: <20261111205814.3282968-1-bradley.morgan@linux.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111205814.3282968-1-bradley.morgan@linux.dev>

On Wed, Nov 11, 2026 at 08:58:14PM +0000, Bradley Morgan wrote:
> Right now security_capable() gets called in create_user_ns() to snapshot
> whether the parent could setfcap, but the LSM gets zero context on where
> the check actually came from. It is the same story as setid: without a
> dedicated flag, security modules cannot tell this apart from regular
> capability checks.
> 
> Add CAP_OPT_USERNS_CREATE and pass it along from create_user_ns().

This should be patch 1/N in a set that introduces a user of it
in some lsm.

> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/all/20261111-kommt-gischt-ohnedies-469998d2f219@brauner/
> Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
> ---
> Thanks Christian for the suggestion :).
> ---
>  include/linux/security.h | 2 ++
>  kernel/user_namespace.c  | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 40831fab54709..d24666a0b4833 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -75,6 +75,8 @@ struct nsset;
>  #define CAP_OPT_NOAUDIT BIT(1)
>  /* If capable is being called by a setid function */
>  #define CAP_OPT_INSETID BIT(2)
> +/* Is capable being called from the user namespace creation path? */
> +#define CAP_OPT_USERNS_CREATE BIT(3)
>  
>  /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>  #define SECURITY_LSM_NATIVE_LABELS	1
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 57b7f10be74e1..37480f6d8369f 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -134,7 +134,8 @@ int create_user_ns(struct cred *new)
>  	 * audit: the creator may never map uid 0.
>  	 */
>  	ns->parent_could_setfcap =
> -		!security_capable(new, parent_ns, CAP_SETFCAP, CAP_OPT_NOAUDIT);
> +		!security_capable(new, parent_ns, CAP_SETFCAP,
> +				  CAP_OPT_NOAUDIT | CAP_OPT_USERNS_CREATE);
>  
>  	ret = ns_common_init(ns);
>  	if (ret)
> -- 
> 2.53.0
