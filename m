Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70732D441
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774293031; cv=none; b=Vz8JZk4c0Fbqj60zdtwJRqOHukFcXEKiqkBZInvxNTdJzwoFKk/BBK5LxND0xtKi129BZXbq0f+yzw1egExQWhon8Nv6ekO6sY+ieAKEEzwol9PXkfjHEYZTcAFEadfs9YvceXmJNismalUwOJsmzO6pXLHHGpVLJv3fHa99e9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774293031; c=relaxed/simple;
	bh=u70jMS93ZGGf12b9u664ZuoNzvkPh/Jd7rvrgWDjRkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTculOdgTeEdBdr3+bxG/DJE5mR0/Hkkek+qDIsekajR7OOHxp+XBP+eliHLmWQtMo6tPxb3+4Djw71N6OdcrxurWFq4k2U2FcEUdwairyq79hot283qXfUNrqyoLU229U4jDBKSsf62oX57PXrFYfQD/wsBJcD7pqDR8h/Mfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix6dWKgQ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix6dWKgQ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b7c844b20so771159f8f.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774293027; x=1774897827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D9t95D8xEX/7Je1aEX2cgVLU/Fxa2+umElabflj3GR8=;
        b=ix6dWKgQQNdskix454coJXm1sgLYJcojCNl15XUvAxNE3GS9+uiKg2HHhuCZbiC+oy
         Mb/SI3YGgAepmQKoPfrBILoOaUBbd0oceB5wF12j8cK8jYRw+uVGvWegoIJziOj2zbC+
         2vmyBrj1BDUbi2zZm3ML7epS92hF6hKsFHfajjfwcrc4LWKf81GFaHJr4CDX7MMzNTLu
         1uY5KmWlldehiBV4lGpJXU91SzpG4k44/EovbXTsFWQUxAX0mGH1rLu7rA+RI7l1GAGk
         DPxrFPSVkRaXdJnJDIIaasa58nP8W1qeb2mpv3ZHBConH+RuDstW85jJ7w06nVXPYwhb
         rx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774293027; x=1774897827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9t95D8xEX/7Je1aEX2cgVLU/Fxa2+umElabflj3GR8=;
        b=ZDV5LUAD0JvLcV/rhmA77a8hMqW9DWZLXHgOvm4J8NFReHBmdusLqQa2mWmIfbQjgH
         dd2vEUnQMsO6swcK314L1sM1ghrNdRpWk1xhE+PQQc+bezUANMZFJ1qCzKa+rt7Ho4OB
         I9/FvKKx9zNnVcHUpo9sdSdGlpFMxEVkQs+2cgmxKBJZgGF/8ijwixfXa6qgLQQhAO9f
         VMsbG0oucCOSM0CZMI5etmUrC6gyEjRaLKR0OvEOsmFEwctZOiVTCBMrwrRmNPGmY/Ls
         uQ5vra+QsoIYqYKPfGDnFBH6XltRL92+s/b6aDsqzh6zWr2/zDdmr55yqEn/TdeSD2AG
         /B8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZPtm1IcgVARFhGgcAoAeaS9V5XPzN7EeLgvS4oVgTzU/QaD41Vroc/ggCn/a+BwrthY8uTzknK7RWwYhCVQPBV6flyo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFd9SNV0sqlxsYkmfprsjkniN/YppZmXb7VV1cVHd7YaU4+QW
	uyNIFfDgIec7hAaRESVHEkVDuLn4VKX4fJXxXhTYdiN3tZWCjq2qbMK1
X-Gm-Gg: ATEYQzx0hK1mZZJGYZ0ABcmS1cLwpw2pvAL6xEXOx6yfukTn5ca3HDmKqu6bXDe+qMi
	LUu5ZNCngfA6ff6PBM4QKQRn1iTIj0VHxeq2zdgtGUIlGRC7ZDehxxr5rs08woEFw+Nrp/O49SL
	b9jxv/tIr4PuKUSd/ZDHOb+eMXcsMLAY6hHhSWdXTQX0+Ne4wBW3ZrVGR9OgkwhpYm3BfOVprrz
	Q3CIhvbeVqq9+r0IAJPGvWXctC7V3VUKh00NZIHzz5LmDCHXzXGr+hZ0NXyQNN3vi5g9s7uQKLc
	PkYODNYxeDii8cRxeOZWMB8FIYI7AsD1kTkmFXQuSBVoSQlKuIzW6VK4Ojatvm3XmOpQF+X7LQ0
	XGDuyL9Dg8KF/oa6/JnYzrst5Z+JSfM1Y6ennTs/XEGXx+CWPvVARqIvzhFB03AhtK8clB0Cy8U
	dKOjp6O5QCMf30WFLOMp8mcajdaujKzWbJ5alUFV/kJUCufwDM0GsVzCVoWnE=
X-Received: by 2002:a05:6000:420e:b0:439:ddf9:a205 with SMTP id ffacd0b85a97d-43b64232830mr19438002f8f.10.1774293026166;
        Mon, 23 Mar 2026 12:10:26 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b647120a1sm32247095f8f.30.2026.03.23.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:10:25 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:10:24 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 01/11] lsm: Add LSM hook security_unix_find
Message-ID: <20260323.4eae8ac1df61@gnoack.org>
References: <20260323165654.193957-1-gnoack3000@gmail.com>
 <20260323165654.193957-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323165654.193957-2-gnoack3000@gmail.com>

On Mon, Mar 23, 2026 at 05:56:43PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
> Add an LSM hook security_unix_find.
> 
> This hook is called to check the path of a named UNIX socket before a
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
> Consumers of the hook wishing to reference @other are responsible
> for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
> therein, ensuring the socket hasn't died since lookup.
> 
> Cc: Günther Noack <gnoack3000@gmail.com>
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Mickaël Salaün <mic@digikod.net>
> Cc: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/linux/lsm_hook_defs.h |  5 +++++
>  include/linux/security.h      | 11 +++++++++++
>  net/unix/af_unix.c            | 10 +++++++---
>  security/security.c           | 20 ++++++++++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)
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
> index 3756a93dc63a..5ef3c2e31757 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,11 +1231,15 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
>  		goto sock_put;
>  
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
> +		goto sock_put;
> +
> +	touch_atime(&path);
> +
>  	path_put(&path);
>  
>  	return sk;
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..28ccea205874 100644
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
> + * AF_UNIX socket. The caller does not hold any locks on @other.
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
> 2.53.0
> 

P.S. I noticed it too late today, so it's not on the commit message,
but we also got a Reviewed-by from Georgia Garcia in
https://lore.kernel.org/all/c3fccd822db5fc76b7fab00a9515eb276a71b421.camel@canonical.com/
(in response to V6 of the patch).

Thanks, Georgia!
–Günther
