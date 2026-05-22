Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5431A683D
	for <linux-security-module@vger.kernel.org>; Fri, 22 May 2026 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779484693; cv=none; b=XZj3Q5GP+K6mjh1dzYkyMrCKIk1Mam+xW6WCVKu/KXpSegelAcL9nSMGIZoP8crj01JKEEg0OUBr3n/vhcaQ6x0rRIPEJCAMmhlm6gJQaJYCnsk6sLmIkkda2d+VmyiVa3CTZSMzirCY9zRw7THfuRwbAN2adq/YXmcYUSHkh2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779484693; c=relaxed/simple;
	bh=cRm6eKuc7o8O738u8X4JItKJEFVo275IGkcxnxE1Wpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdZVsYQ0RXAgdj0P5J5C/p8SXcgCkfF8IU7tWRQyPWyFYovOmF6bQascwi51TgZB8fx9io1H5aVEpZbTq7n+ybjHBJxgLIKKTokfsPjsck4RZJM1we1tXnSLdAcm504fMDNpitjMJYcedebEnKmEeON2lp9OPmK8rmJ9kANCkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IJYapuKx; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IJYapuKx"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gMdRN5rkfzCGC;
	Fri, 22 May 2026 23:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1779484688;
	bh=/fNVe6W/mE7L+RDjNa5NLGQSmaiJFRvJnsRc62GJpA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IJYapuKxTruwfKMRMat2RFfXlvHe1YmSYbKZ4Bi4qFEbmQ+jDpGv7IM4SCKNQHdaB
	 +Rrz2yztUtyi+6beiiQSrVPZmj4I58R87NlDnZsh19dXuXdeyUCxGDv0hJ+mtUguLJ
	 I5O1+GQsYN5N4O8ncS8R64FFyhhFyswMNvEi5fjQ=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4gMdRM68VMzn1T;
	Fri, 22 May 2026 23:18:07 +0200 (CEST)
Date: Fri, 22 May 2026 23:18:06 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/7] landlock: Add UDP connect() access control
Message-ID: <20260522.AhMei2meelee@digikod.net>
References: <20260502124306.3975990-1-matthieu@buffet.re>
 <20260502124306.3975990-3-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260502124306.3975990-3-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Sat, May 02, 2026 at 02:43:01PM +0200, Matthieu Buffet wrote:
> Add support for a second fine-grained UDP access right.
> This first half of LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP controls the
> ability to set the remote port of a socket (via connect()). It will be
> useful for applications that send datagrams, and for some servers too
> (those creating per-client sockets, which want to receive traffic only
> from a specific address).
> 
> Similarly as for bind(), this access control is performed when
> configuring sockets, not in hot code paths.
> 
> Include detection of when autobind is about to be required, and check if
> the process would be allowed to call bind(0) explicitly. Autobind can
> only be performed when sending a first datagram, when connect()ing, and
> in some splice() EOF edge case which, afaiu, can only happen after a
> remote peer has been set (which is already covered).
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h               | 19 +++++
>  security/landlock/audit.c                   |  2 +
>  security/landlock/limits.h                  |  2 +-
>  security/landlock/net.c                     | 79 +++++++++++++++++----
>  tools/testing/selftests/landlock/net_test.c |  5 +-
>  5 files changed, 92 insertions(+), 15 deletions(-)

> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index f9ccb52e7d45..045881f81295 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -68,16 +68,17 @@ static int current_check_access_socket(struct socket *const sock,
>  
>  	switch (address->sa_family) {
>  	case AF_UNSPEC:
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			/*
>  			 * Connecting to an address with AF_UNSPEC dissolves
> -			 * the TCP association, which have the same effect as
> -			 * closing the connection while retaining the socket
> -			 * object (i.e., the file descriptor).  As for dropping
> -			 * privileges, closing connections is always allowed.
> -			 *
> -			 * For a TCP access control system, this request is
> -			 * legitimate. Let the network stack handle potential
> +			 * the remote association while retaining the socket
> +			 * object (i.e., the file descriptor). For TCP, it has
> +			 * the same effect as closing the connection. For UDP,
> +			 * it removes any preset remote address. As for
> +			 * dropping privileges, these actions are always
> +			 * allowed.
> +			 * Let the network stack handle potential
>  			 * inconsistencies and return -EINVAL if needed.
>  			 */
>  			return 0;
> @@ -134,7 +135,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr4 = (struct sockaddr_in *)address;
>  		port = addr4->sin_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v4info.daddr = addr4->sin_addr.s_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -157,7 +159,8 @@ static int current_check_access_socket(struct socket *const sock,
>  		addr6 = (struct sockaddr_in6 *)address;
>  		port = addr6->sin6_port;
>  
> -		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP) {
> +		if (access_request == LANDLOCK_ACCESS_NET_CONNECT_TCP ||
> +		    access_request == LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
>  			audit_net.dport = port;
>  			audit_net.v6info.daddr = addr6->sin6_addr;
>  		} else if (access_request == LANDLOCK_ACCESS_NET_BIND_TCP ||
> @@ -213,6 +216,50 @@ static int current_check_access_socket(struct socket *const sock,
>  	return -EACCES;
>  }
>  
> +static int current_check_autobind_udp_socket(struct socket *const sock)
> +{
> +	struct sockaddr_storage port0 = { 0 };

struct sockaddr_storage port0 = {};


> +
> +	/*
> +	 * On UDP sockets, if a local port has not already been bound,
> +	 * calling connect() or sending a first datagram has the side
> +	 * effect of autobinding an ephemeral port: we also have to check
> +	 * that the process would have had the right to bind(0) explicitly.
> +	 * Note: socket is not locked, so another thread could do an
> +	 * explicit bind(!=0) on this socket, changing inet_num to non-zero
> +	 * after we read it, but this would only have us enforce an
> +	 * additional bind(0) access check and would not bypass policy.
> +	 */
> +	if (inet_sk(sock->sk)->inet_num != 0)
> +		return 0;
> +
> +	/*
> +	 * Construct a struct sockaddr* with port 0 to pretend the
> +	 * process tried to bind() on that address.
> +	 */
> +	port0.ss_family = sock->sk->__sk_common.skc_family;
> +	switch (port0.ss_family) {
> +	case AF_INET: {
> +		((struct sockaddr_in *)&port0)->sin_port = 0;

Why is this useful? The struct is already initialized to 0.

> +		break;
> +	}
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6: {
> +		((struct sockaddr_in6 *)&port0)->sin6_port = 0;

Same question.

> +		break;
> +	}
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +
> +	default:
> +		return 0;
> +	}
> +
> +	return current_check_access_socket(sock, (struct sockaddr *)&port0,
> +					   sizeof(port0),
> +					   LANDLOCK_ACCESS_NET_BIND_UDP);
> +}
