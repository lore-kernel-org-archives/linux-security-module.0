Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336027;
	b=HD5COJBF/VZMmaC36iMtuFVQm2EHxBaQgenwt4qX1G2T+YiA3AUBGpk/pCNLGu0LDkJ/
	 lBztapAlOeXn02vYs9qgZMS0jeS7pu0Wsx7T43vjv5vrlpHKvyS+0R1gWrLQ/CEJssWRp
	 IK+7cqhYmOJiUF9N1oX/dJi9kR1jhEGyfFo5nNRsdKwJ66gy0ggKagMQIIgAqs1EQT+LI
	 XQTOZ2f9agEihP+3ucg/Gjk+/sRWYeG1XJfH9wi78cnIKKCbMajDQLxbSj5NacqKGfPR0
	 mHwh+NcycMCb9gEn3IeiGBwy9ekYsaAgILxWCaOg6a8bLgNCQVcYT1V4JOTK07hEU+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yYs6e1QAzpoaQgwCEyR3qOOpM59an3T1a6r8hBakjEc=;
	b=C/QoOcVqQhl0bxIbMsdMQt1pJFD8j65/2nbfcIJMjOQRhRi4IIWA8XlVKQpVIKTliFcO
	 KKtHWoPpeFMRoPEV6O7VG9zCYa4x2wOn7+Ah3VfP4UYy9KUyGR0Q9WrRRws7tRDHexjDT
	 CDpExt6mFTf7nOQZOr8tyzzdwx3ab1PE15Jci+f5jaZPgS7hzazp/90znI5VyYqvij++A
	 1RHtY1Uj5M+KGVzTTuDb4MAX5M9F8t9IG3itVHkF8S16HXqtm4ekJGNT4YuorX5FFs6mr
	 jahoBYxIsGciJSYCRLm0QIpQr0tsUSbbnLGhn3vnZeDgfVpeH54RYsoqdIFlOiAtenw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZVdXDKB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8A606A31D
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZVdXDKB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D931F0093A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336026;
	bh=yYs6e1QAzpoaQgwCEyR3qOOpM59an3T1a6r8hBakjEc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aZVdXDKBnK7hU+kqnMkwvYd7i4I84b5WvvjNk7FVjut1qZSyGwrq1JmPpy9+oVjFz
	 x5GXZDAvrKmjSCDmOxOugeOJTY8/WDtNNbSMvvbGTWhShptxEZTNwe5D55xFcUUBOV
	 0ORmNe0Gj+wa6Z3LVFrcf3pg/gnYJdHJU/67sTjJPwWHM0a+CaIe6H6HiQSHFZ3A/0
	 OGdG3OQQfxYPVTDwFTCH7CYkzHZmnP9RVDnbpaA45WqF87xZa3OhMJuu9PGZfrHISf
	 O7ZhU5k9uvlL5zX53mzSHXcBpSYZp3lxXwBa0w9yHu05DkC1eEqZt84mFXxJTIQl/k
	 RRn+eeG0WECxQ==
Message-ID: <sashiko-outbox-190350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] landlock: Add UDP connect() access control
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260502124306.3975990-3-matthieu@buffet.re>
References: <20260502124306.3975990-3-matthieu@buffet.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] TOCTOU race condition allows bypassing the LANDLOCK_ACCESS_NET_BIN=
D_UDP restriction for autobinding ephemeral ports.
- [High] Spurious access denial when calling connect(AF_UNSPEC) on an unbou=
nd UDP socket.
- [Medium] Unmarked data races when reading `inet_sk(sock->sk)->inet_num` a=
nd `sock->sk->__sk_common.skc_family`.
--

commit 80ae13b5d76df96979bf826e8fb592eacdf098bc
Author: Matthieu Buffet <matthieu@buffet.re>

landlock: Add UDP connect() access control

This commit adds support for a second fine-grained UDP access right
LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP. It controls the ability to set the
remote port of a UDP socket via connect(), and includes detection of
when autobind is about to be required.

> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index f9ccb52e7d45..045881f81295 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c

[ ... ]

> @@ -213,6 +216,50 @@ static int current_check_access_socket(struct socket=
 *const sock,
>  	return -EACCES;
>  }
> =20
> +static int current_check_autobind_udp_socket(struct socket *const sock)
> +{
> +	struct sockaddr_storage port0 =3D { 0 };
> +
> +	/*
> +	 * On UDP sockets, if a local port has not already been bound,
> +	 * calling connect() or sending a first datagram has the side
> +	 * effect of autobinding an ephemeral port: we also have to check
> +	 * that the process would have had the right to bind(0) explicitly.
> +	 * Note: socket is not locked, so another thread could do an
> +	 * explicit bind(!=3D0) on this socket, changing inet_num to non-zero
> +	 * after we read it, but this would only have us enforce an
> +	 * additional bind(0) access check and would not bypass policy.
> +	 */
> +	if (inet_sk(sock->sk)->inet_num !=3D 0)
> +		return 0;

Are unmarked lockless reads of inet_num safe here?

Since the socket is not locked, inet_num can be modified concurrently by
another thread calling bind(), as noted in the comment. Should this read
use READ_ONCE() or data_race() to avoid KCSAN warnings about data races
under the Linux Kernel Memory Model?

This also applies to the lockless read of skc_family below, which can be
concurrently modified by setsockopt(IPV6_ADDRFORM).

Can a TOCTOU race bypass the autobind check?

If a process has an already autobound UDP socket (which lacks
SOCK_BINDPORT_LOCK), what happens if Thread A and Thread B race:

Thread A calls connect(remote_addr). The hook
current_check_autobind_udp_socket() checks inet_num !=3D 0 locklessly,
assumes it is already bound, and skips the BIND_UDP check.

Thread B calls connect(AF_UNSPEC). The Landlock hook explicitly allows this.
The network stack executes udp_disconnect(), which unhashes the socket and
zeroes inet_num.

Thread A proceeds into the network stack (inet_dgram_connect), acquires the
socket lock, observes inet_num =3D=3D 0, and calls inet_autobind().

Does this allow the socket to successfully bind to a new ephemeral port wit=
hout
the required BIND_UDP Landlock access check?

> +
> +	/*
> +	 * Construct a struct sockaddr* with port 0 to pretend the
> +	 * process tried to bind() on that address.
> +	 */
> +	port0.ss_family =3D sock->sk->__sk_common.skc_family;

[ ... ]

> @@ -234,14 +281,22 @@ static int hook_socket_connect(struct socket *const=
 sock,
>  			       const int addrlen)
>  {
>  	access_mask_t access_request;
> +	int ret =3D 0;
> =20
>  	if (sk_is_tcp(sock->sk))
>  		access_request =3D LANDLOCK_ACCESS_NET_CONNECT_TCP;
> +	else if (sk_is_udp(sock->sk))
> +		access_request =3D LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>  	else
>  		return 0;
> =20
> -	return current_check_access_socket(sock, address, addrlen,
> -					   access_request);
> +	ret =3D current_check_access_socket(sock, address, addrlen,
> +					  access_request);
> +
> +	if (ret =3D=3D 0 && sk_is_udp(sock->sk))
> +		ret =3D current_check_autobind_udp_socket(sock);

Can this unconditionally enforce the bind check for connect(AF_UNSPEC) on
unbound sockets?

If connect(AF_UNSPEC) is called on an unbound UDP socket,
current_check_access_socket() explicitly permits it and returns 0.

However, the hook then unconditionally calls current_check_autobind_udp_soc=
ket().
Because the socket is unbound (inet_num =3D=3D 0), it enforces the BIND_UDP
policy for port 0.

If the process does not have BIND_UDP access, the disconnect operation is d=
enied
with -EACCES. But in the network stack, connect(AF_UNSPEC) merely dissolves
the remote association (udp_disconnect) and never triggers inet_autobind().

Will enforcing a bind check here break legitimate application cleanup behav=
ior?

> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502124306.3975=
990-1-matthieu@buffet.re?part=3D2
