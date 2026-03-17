Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A173859D7
	for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782647; cv=none; b=S9HC4/jgBtJcKfmj8ad6/C1WjGaPh+OhPn4ea4eWHRTqXngQnM65z77mfBHoGHLqtovbPvOF4wk6lyYSoJdH1PqiYBSTzRNmZvMw+zyjWHg/WsHSaT4TKzRmHyjaxu7fUplmp4b2VkF/bEl8Y/eAunjGIZO8koAZm/CPMgt+HNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782647; c=relaxed/simple;
	bh=TGqDQVKenKst7ulkB8U2FPYOSqBdO6CBrwx/TU5vxvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovebx/bxoFxcd9/4mDZfSp4t3o+pDkrArplI5PIw1i3umcqxapEiu50AWcRK5+sZjrf5asbi+hbFpbrecBru8xYGSzhZbvGGR19CTgEwYXukGD9v7/uSWM1jLIr2NK4EtnGSbr1I/JE9G9S+JJSl2iyHGTtIXSDYZ6qgCCHdkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=AE2sstpk; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="AE2sstpk"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fb4TZ5w39z2RS;
	Tue, 17 Mar 2026 22:14:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773782066;
	bh=9PdX0GoF+dwhSnTxhQP6xSC/aUKyJh+SmOgu8OgcULE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AE2sstpkYihXXRJ/A5ZQNWjOTKCFVk/U3E+sNDnugqB1XY1KLhpwj6DB+YKpZm43l
	 2PUNziPG4SeM6bTGMhuqudDTn550ikIdgTwjMwQCCVG2dhoL35gIOWSslx6MMVyy42
	 PyHcbAeO7Ou4BrIZJZDn4pYyIJKvj2g8qNWW0tTs=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fb4TY2dTNzrFg;
	Tue, 17 Mar 2026 22:14:25 +0100 (CET)
Date: Tue, 17 Mar 2026 22:14:23 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 1/9] lsm: Add LSM hook security_unix_find
Message-ID: <20260317.Re1jaiThoo5i@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315222150.121952-2-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

Paul and netdev folks, I think this new hook is now good.  I'd like to
push this series to -next this week.  Please let us know if you find any
issue, otherwise I guess we'll get more eyes and bots in the -next tree.

On Sun, Mar 15, 2026 at 11:21:42PM +0100, Günther Noack wrote:
> From: Justin Suess <utilityemal77@gmail.com>
> 
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
> index 3756a93dc63a..aced28179bac 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1231,11 +1231,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
>  		goto path_put;
>  
>  	err = -EPROTOTYPE;
> -	if (sk->sk_type == type)
> -		touch_atime(&path);
> -	else
> +	if (sk->sk_type != type)
>  		goto sock_put;
>  
> +	/*
> +	 * We call the hook because we know that the inode is a socket and we
> +	 * hold a valid reference to it via the path.
> +	 */
> +	err = security_unix_find(&path, sk, flags);
> +	if (err)
> +		goto sock_put;
> +	touch_atime(&path);
> +
>  	path_put(&path);
>  
>  	return sk;
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
> 2.53.0
> 
> 
