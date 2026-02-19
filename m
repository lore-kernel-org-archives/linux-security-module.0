Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13602F28FC
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771532777; cv=none; b=n+ID7m+NIZCe30J5i+qKOKWHEaVRBRAd+Rpmvz3gZo4ARY11Hv6H/kTJvvp/tkNcCzZXJiRSHHqa51ftw3/MRASWX8j6dWvyVHdDIN2LvxCHmh2YJS1/u+5nkiYNxkAMNZgEd6ijkAhaO4pAD/59AW7FbEsdmFrV0NpWgo4gyGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771532777; c=relaxed/simple;
	bh=lU3vpxRoA7Lrd5Mcj7am2OVGUSxLkLjaNQK6YWgO4kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay5yuSvsrlWDocCiUe6AsIYV833mT7UGez2s8Lf78q0P4zF9Eg98wAwwHfDJ5mUklQT/3ugEItOZ3F/GeJcoxbfIm4C5kK4Qksp47l+Os8yy0lEVL+jNKCr3Vu381fIVAPvb5XW9zDQC0zWj0+7KyE/tRvy8UB2z/LUqEeMUyJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu4TYd1I; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu4TYd1I"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48371bb515eso17832325e9.1
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 12:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771532773; x=1772137573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jRM8tuheMzh9OOGizoOHRGNoarMk96qRAJKHeKpf0es=;
        b=Cu4TYd1IM/hSHKmJBC1rOhOQMjCrbR6EVA3vUPUqgdiKWCZKfnie0VjJqmxC2WCSh2
         IgCbglIU8P/ezmJVrugSsgXaByBchHNku8tEalAMMBcoUds6xFllChhYFWhILQnshPNC
         gJ69skCi3LBGEsDeO5/kMyGmSjH60ZtGRCGNWJcoRvsdBe8zlV9bYWXZUK3oZmuUcG7I
         WBZIiLXdFGfSuhgxlM8luSK8desgQG7MUCy4pMYo3LBm85fvWKkME8KWjuwCJZqZTzLO
         vp1VFzXII8PsymJIuT4j2IjY1dXUleZsx8ZMPk0FePAXpKG6G2gFNlNLRiwHJyNpmcA8
         oxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771532773; x=1772137573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRM8tuheMzh9OOGizoOHRGNoarMk96qRAJKHeKpf0es=;
        b=PCQKt6sStE0RlS+YZfKf3QKOx7ZBMYcIxIWiswEaB/dFDojwDyWC3moUNbvLcDRJP9
         B96EnucbM56AzRuOk5R8XsVkx02LOTF/N+bgJ0sdGZjolsqyTNu7PoJTXEWauOn9e0E7
         xfY53JLGT+51CMkQFkoie5hBkPU3Xe+zSpL0850B3jX7ZPjrHNlJ9VCRgXYVrnMWgWXh
         9IiNif30LJWZiEKxotUu973Y25x17vS9GCoQSSGd7TK5wMND05Ipwp05YN6AGh0+GFEK
         dnYn2FLn4t1fxj4ExhSFQsvcMn4tMoqxm3Nz3srMYiVNLTS67MN/jIYm8wFS7HHTLHlZ
         /OnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEm3+p511oSHU21DxVFXtciHf14NW3hnbnij0NHRH1fE2cnoZu464A0qgjS4015aKTzqpG8dWr1igdS7hV780aL4BhLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSHs/L8Qoqpp2CdDyPHOQJADvHkDAskHKBwpVuL//g/zI5z7V
	51pytfxQn4/ay9T9DXoFa+QvB4CQ/sbEVO7inkkfzPeTmk+roCxKkTos
X-Gm-Gg: AZuq6aIG+NhzyGoXglbYb8s/LL2d+QnfNxQW8BD7zpZ9CT0OmV4wLB05M39RANDUYu2
	7M35JTDdXEPx6Y6nwyuPmkqwrBwV764sKifwkqYZMs9WJmYh3ZRSOu+K08OLiFST2XZG2KQM5Dr
	KO2RMurMwaZ49zrQYRGyE91Dtbb3nXJIu1y9TvQ/jjdXIxaAHIIk+ERY67oWya5wgTotxuTDPLr
	qXayCrBCVwPZHGRbfdxU4PlCLvOPiGBQTeavRjYIXqICxbKVc38xS6INBAgXI2QW5xC9k0LYwiL
	mVcscpgvGYd+JzOVrjlEReDw6KnbRu+tx+OOqfsnjDXZtqs9MpsV/t/LYCpE1dYyBiglqnC01KS
	EYSJRYUhKwjDqPM8a+Vv2roKoQhMO3HmQYfWhNf0JdUW3jN9O4gxu87L5dgccX6bS0Dxs53f+D+
	lkZ+9vagHqAQIBlKx1mjvwbhKvf1T8SahrvXwSDzNg/WH8uLfd
X-Received: by 2002:a05:600c:3e0c:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-48398a65ecdmr99591345e9.2.1771532772772;
        Thu, 19 Feb 2026 12:26:12 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b0e63sm47342245e9.2.2026.02.19.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:26:12 -0800 (PST)
Date: Thu, 19 Feb 2026 21:26:10 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	paul@paul-moore.com, samasth.norway.ananda@oracle.com,
	serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <20260219.de5dc35ec231@gnoack.org>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219200459.1474232-1-utilityemal77@gmail.com>

On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> Add a LSM hook security_unix_find.
> 
> This hook is called to check the path of a named unix socket before a
> connection is initiated. The peer socket may be inspected as well.
> 
> Why existing hooks are unsuitable:
> 
> Existing socket hooks, security_unix_stream_connect(),
> security_unix_may_send(), and security_socket_connect() don't provide
> TOCTOU-free / namespace independent access to the paths of sockets.
> 
> (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> This requires another path lookup. A change in the path between the
> two lookups will cause a TOCTOU bug.
> 
> (2) We cannot use the struct path from the listening socket, because it
> may be bound to a path in a different namespace than the caller,
> resulting in a path that cannot be referenced at policy creation time.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 13 ++++++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..7a0fd3dbfa29 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -317,6 +317,11 @@ LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
>  LSM_HOOK(int, 0, watch_key, struct key *key)
>  #endif /* CONFIG_SECURITY && CONFIG_KEY_NOTIFICATIONS */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +LSM_HOOK(int, 0, unix_find, const struct path *path, struct sock *other,
> +	 int flags)
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  LSM_HOOK(int, 0, unix_stream_connect, struct sock *sock, struct sock *other,
>  	 struct sock *newsk)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 83a646d72f6f..99a33d8eb28d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1931,6 +1931,17 @@ static inline int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  }
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +
> +int security_unix_find(const struct path *path, struct sock *other, int flags);
> +
> +#else /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +static inline int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
>  int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f6d56e70c7a2..41698460194b 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,10 +1231,17 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
> +		goto sock_put;
> +
> +	/*
> +	 * We call the hook because we know that the inode is a socket and we
> +	 * hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
>  		goto sock_put;
> +	touch_atime(&path);
>  
>  	path_put(&path);
>  
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..c73196b8db4b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/**
> + * security_unix_find() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @other: peer sock
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_unix_find(const struct path *path, struct sock *other, int flags)
> +{
> +	return call_int_hook(unix_find, path, other, flags);
> +}
> +EXPORT_SYMBOL(security_unix_find);
> +
> +#endif	/* CONFIG_SECURITY_NETWORK && CONFIG_SECURITY_PATH */
> +
>  #ifdef CONFIG_SECURITY_INFINIBAND
>  /**
>   * security_ib_pkey_access() - Check if access to an IB pkey is allowed
> -- 
> 2.52.0
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>

Thank you, this looks good. I'll include it in the next version of the
Unix connect patch set again.

–Günther
