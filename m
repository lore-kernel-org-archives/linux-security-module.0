Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B21450FE
	for <linux-security-module@vger.kernel.org>; Fri, 19 Dec 2025 21:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178925; cv=none; b=Z4mqyHFZpFkicTZyw6tqXR5HlCaNJ5Yx3xGtLNiSshYL3DLW1kaknHXBTHth7e53tbBqnlC7dbUnL0ojLYvOnKtznSkvnONRPeDAhwXFtf8QJk353fUsedE+gNL0ZquLN3Uu4bjXfg+T+QTeDvHYaDPBs9NMxug7nkHs6MMn4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178925; c=relaxed/simple;
	bh=uOSv+Yrzo+QnbII04YRXv+9zjF7K3kPmqIMDkpiS0n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMyxRL03WeJLEjid3PY8+0yI8ATui6BuhG9z5XwguH3Avu2R4g/ujYBFc9QEPHKDLZE2PRTPozUKxcrMB+m4X4NMyAPGiQE6JVf7F6sIKtGubRePLMGGyIjjLf6SY9KUfFL//4lCPUS9BWikm7Bh+ROvdq7m1T3yWe2a88pDYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ibm959hq; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ibm959hq"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dY0Vk6QNfzb9g;
	Fri, 19 Dec 2025 22:07:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1766178478;
	bh=zSk0Yarg5Eb1vJE3kgHegfZVsorfrWp2s/WpsGUqnvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibm959hqiFO+3O7WfdvxEQVDNu9wwJAw9Pq3+pKem2Y1omdCT+pVatAos38P4jxKs
	 0jZ5NrWb3Lt2Mg0tyVfEaLhlWxzSC0QdHFmuboGvzy0kEVoqrTb81tv1WBzgJ1a7Y7
	 CmHzSGHI3q0XcPCgJcHsO6eJSrXgec/3lW0kdsAY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dY0Vj5gZbzSSc;
	Fri, 19 Dec 2025 22:07:57 +0100 (CET)
Date: Fri, 19 Dec 2025 22:07:51 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [RFC PATCH v1 3/3] landlock: Fix TCP handling of short AF_UNSPEC
 addresses
Message-ID: <20251219.toh6Xe3ea9iN@digikod.net>
References: <20251027190726.626244-1-matthieu@buffet.re>
 <20251027190726.626244-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027190726.626244-4-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Oct 27, 2025 at 08:07:26PM +0100, Matthieu Buffet wrote:
> current_check_access_socket() treats AF_UNSPEC addresses as
> AF_INET ones, and only later adds special case handling to
> allow connect(AF_UNSPEC), and on IPv4 sockets
> bind(AF_UNSPEC+INADDR_ANY).
> This would be fine except AF_UNSPEC addresses can be as
> short as a bare AF_UNSPEC sa_family_t field, and nothing
> more. The AF_INET code path incorrectly enforces a length of
> sizeof(struct sockaddr_in) instead.

Good catch!

> 
> Move AF_UNSPEC edge case handling up inside the switch-case,
> before the address is (potentially incorrectly) treated as
> AF_INET.

And that's cleaner this way too.

> 
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>

I pushed this series to my -next branch, but moving the tests after the
kernel fix. This makes it possible to cleanly bisect commits.  Thanks!

> ---
>  security/landlock/net.c | 118 +++++++++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 51 deletions(-)
> 
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 1f3915a90a80..e6367e30e5b0 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -71,6 +71,61 @@ static int current_check_access_socket(struct socket *const sock,
>  
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +			/*
> +			 * Connecting to an address with AF_UNSPEC dissolves
> +			 * the TCP association, which have the same effect as
> +			 * closing the connection while retaining the socket
> +			 * object (i.e., the file descriptor).  As for dropping
> +			 * privileges, closing connections is always allowed.
> +			 *
> +			 * For a TCP access control system, this request is
> +			 * legitimate. Let the network stack handle potential
> +			 * inconsistencies and return -EINVAL if needed.
> +			 */
> +			return 0;
> +		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> +			/*
> +			 * Binding to an AF_UNSPEC address is treated
> +			 * differently by IPv4 and IPv6 sockets. The socket's
> +			 * family may change under our feet due to
> +			 * setsockopt(IPV6_ADDRFORM), but that's ok: we either
> +			 * reject entirely or require
> +			 * %LANDLOCK_ACCESS_NET_BIND_TCP for the given port, so
> +			 * it cannot be used to bypass the policy.
> +			 *
> +			 * IPv4 sockets map AF_UNSPEC to AF_INET for
> +			 * retrocompatibility for bind accesses, only if the
> +			 * address is INADDR_ANY (cf. __inet_bind). IPv6
> +			 * sockets always reject it.
> +			 *
> +			 * Checking the address is required to not wrongfully
> +			 * return -EACCES instead of -EAFNOSUPPORT or -EINVAL.
> +			 * We could return 0 and let the network stack handle
> +			 * these checks, but it is safer to return a proper
> +			 * error and test consistency thanks to kselftest.
> +			 */
> +			if (sock->sk->__sk_common.skc_family == AF_INET) {
> +				const struct sockaddr_in *const sockaddr =
> +					(struct sockaddr_in *)address;
> +
> +				if (addrlen < sizeof(struct sockaddr_in))
> +					return -EINVAL;
> +
> +				if (sockaddr->sin_addr.s_addr !=
> +				    htonl(INADDR_ANY))
> +					return -EAFNOSUPPORT;
> +			} else {
> +				if (addrlen < SIN6_LEN_RFC2133)
> +					return -EINVAL;
> +				else
> +					return -EAFNOSUPPORT;
> +			}
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
> +		/* Only for bind(AF_UNSPEC+INADDR_ANY) on IPv4 socket. */
> +		fallthrough;
>  	case AF_INET: {
>  		const struct sockaddr_in *addr4;
>  
> @@ -119,57 +174,18 @@ static int current_check_access_socket(struct socket *const sock,
>  		return 0;
>  	}
>  
> -	/* Specific AF_UNSPEC handling. */
> -	if (address->sa_family == AF_UNSPEC) {
> -		/*
> -		 * Connecting to an address with AF_UNSPEC dissolves the TCP
> -		 * association, which have the same effect as closing the
> -		 * connection while retaining the socket object (i.e., the file
> -		 * descriptor).  As for dropping privileges, closing
> -		 * connections is always allowed.
> -		 *
> -		 * For a TCP access control system, this request is legitimate.
> -		 * Let the network stack handle potential inconsistencies and
> -		 * return -EINVAL if needed.
> -		 */
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP)
> -			return 0;
> -
> -		/*
> -		 * For compatibility reason, accept AF_UNSPEC for bind
> -		 * accesses (mapped to AF_INET) only if the address is
> -		 * INADDR_ANY (cf. __inet_bind).  Checking the address is
> -		 * required to not wrongfully return -EACCES instead of
> -		 * -EAFNOSUPPORT.
> -		 *
> -		 * We could return 0 and let the network stack handle these
> -		 * checks, but it is safer to return a proper error and test
> -		 * consistency thanks to kselftest.
> -		 */
> -		if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP) {
> -			/* addrlen has already been checked for AF_UNSPEC. */
> -			const struct sockaddr_in *const sockaddr =
> -				(struct sockaddr_in *)address;
> -
> -			if (sock->sk->__sk_common.skc_family != AF_INET)
> -				return -EINVAL;
> -
> -			if (sockaddr->sin_addr.s_addr != htonl(INADDR_ANY))
> -				return -EAFNOSUPPORT;
> -		}
> -	} else {
> -		/*
> -		 * Checks sa_family consistency to not wrongfully return
> -		 * -EACCES instead of -EINVAL.  Valid sa_family changes are
> -		 * only (from AF_INET or AF_INET6) to AF_UNSPEC.
> -		 *
> -		 * We could return 0 and let the network stack handle this
> -		 * check, but it is safer to return a proper error and test
> -		 * consistency thanks to kselftest.
> -		 */
> -		if (address->sa_family != sock->sk->__sk_common.skc_family)
> -			return -EINVAL;
> -	}
> +	/*
> +	 * Checks sa_family consistency to not wrongfully return
> +	 * -EACCES instead of -EINVAL.  Valid sa_family changes are
> +	 * only (from AF_INET or AF_INET6) to AF_UNSPEC.
> +	 *
> +	 * We could return 0 and let the network stack handle this
> +	 * check, but it is safer to return a proper error and test
> +	 * consistency thanks to kselftest.
> +	 */
> +	if (address->sa_family != sock->sk->__sk_common.skc_family &&
> +	    address->sa_family != AF_UNSPEC)
> +		return -EINVAL;
>  
>  	id.key.data = (__force uintptr_t)port;
>  	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
> -- 
> 2.47.2
> 
> 
