Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336028;
	b=RWuygGKuYtAc8pvyqrRDV7/ZZFYqh+VXAWcgpn3b4PVPvGmC2zILkAmqC2D+WUco7QKL
	 pLJLQT5RXb47Wm6ZptH/AcNTmXryQpa/XHmqNi63GtUc9ucbW1IunIwBYHhwye3Ecrixe
	 lJU1RRFlITGYP9q1bNnfpu0uC3IBgXCyvcLIAD1q7pn8G700+ij/GKESsmInyAKutti+v
	 EBABQvx7xfCNZT42Hmbndx73nEplbnvZGcpTF8Ojz91dlRPS/MWSW1HkkxUcX7AkFyTMO
	 UlYeJ8B8I3Wcec+7rFL2GwpvgxdIeltxrlmVHdTkZK3GUKV0w6UZqd+df3EeIbv40nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UufczwWvT5q8SDe5UnUUcBrkurRuURka5lx5XMwhi0g=;
	b=Ro2X1lz59uDOFc8jr59gzkoLO2TgNUuTt0Za3bIVoEv/sgOXJ8vzsq/4T4XhkY+ky5ur
	 uKWEALIICV+CHNpZY9As73stjSSG8M70HA4DgWO/idGSHqJwhn+UtRtvyxejhomneydxk
	 3kjE/Ung2bPeNhLZ8zmhRa+8PxAnWxH7Ijw+lfHeG2iARZECbvsGQ/px3/PYPOFJWs+v0
	 Cc40lToL55owt3zUjLjYOWsJ81k3wSMeYepn+X4sBn/trB7aJNeBsaWF0dB4wlwFmcQGe
	 XGkL/YoMygFIoYBmCn/4tO0py3RrnW3npsJD0joW+WbVpF2LPpQG8ykTUeb8u/4AFFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQqBJiCE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B84606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQqBJiCE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659651F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336027;
	bh=UufczwWvT5q8SDe5UnUUcBrkurRuURka5lx5XMwhi0g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kQqBJiCEoyXOqREnpEqrUty9YvUgv1cO0VTm1rEFrHAOVHtIGuJM2irrDtMf5FV56
	 +bcB1aNdjKBnyM70Ni7xzHMzbBKXYHzlDkhpI7BEOApNKUPpJMwWpTZAq91lDuvPBp
	 MjF+OHCo6+bmg3P2iOwobx9XiSdgMrDxoJV8yOOCG/tRbrWlz2zF68TgSlXgSmHzgX
	 I4kq2t0TsSX0Y4MXnVu8lx1cPg5eafxKxubX1SE1m3pPxlCra1tExvB0HvdEvsULTp
	 SpOl90LafmhEv+kR9FMuAEMYfXQNewxW9jBXlfhoB/iKIZkY18XPrbzF2xcaDLal5t
	 gqkoxyMPc8OIA==
Message-ID: <sashiko-outbox-190351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] landlock: Add UDP send access control
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260502124306.3975990-4-matthieu@buffet.re>
References: <20260502124306.3975990-4-matthieu@buffet.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] TCP Fast Open (MSG_FASTOPEN) via sendmsg()/sendto() bypasses L=
ANDLOCK_ACCESS_NET_CONNECT_TCP enforcement.
- [Medium] Lockless plain reads of concurrently modified socket state (`skc=
_family` and `inet_num`) introduce data races.
--

commit b84eacd95b135c773c622b9361a03b428f1f3bce
Author: Matthieu Buffet <matthieu@buffet.re>

landlock: Add UDP send access control

This patch adds Landlock access control for sending UDP datagrams to
explicit destinations via sendto() and sendmsg(). It introduces a new
socket_sendmsg hook that applies the LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP
policy.

> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index 045881f81295..8a53aebdb8c6 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c

[ ... ]

> @@ -82,6 +84,35 @@ static int current_check_access_socket(struct socket *=
const sock,
>  			 * inconsistencies and return -EINVAL if needed.
>  			 */
>  			return 0;
> +		} else if (access_request =3D=3D
> +			   LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP) {
> +			if (sock->sk->__sk_common.skc_family =3D=3D AF_INET6) {

The comment below notes that the socket's family can change under our feet
due to concurrent setsockopt(IPV6_ADDRFORM) calls. Since this is a plain C
read of a concurrently modified variable, should we use READ_ONCE() here to
avoid data races and KCSAN warnings?

Additionally, since skc_family is evaluated multiple times in this function,
would it be safer to read it once into a local variable to prevent
inconsistent evaluations due to compiler reloads?

The same question applies to the lockless read of inet_sk(sock->sk)->inet_n=
um
in current_check_autobind_udp_socket(), which also acknowledges concurrent
modifications in its comments.

> +				/*
> +				 * We cannot allow sending UDP datagrams to an
> +				 * explicit AF_UNSPEC address on IPv6 sockets,
> +				 * even if AF_UNSPEC is treated as "no address"
> +				 * on such sockets (so it should always be allowed).
> +				 * That's because the socket's family can change under
> +				 * our feet (if another thread calls setsockopt(IPV6_ADDRFORM))
> +				 * to IPv4, which would then treat AF_UNSPEC as
> +				 * AF_INET.
> +				 */

[ ... ]

> @@ -299,9 +333,33 @@ static int hook_socket_connect(struct socket *const =
sock,
>  	return ret;
>  }
> =20
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)
> +{
> +	struct sockaddr *const address =3D msg->msg_name;
> +	const int addrlen =3D msg->msg_namelen;
> +	access_mask_t access_request;
> +	int ret =3D 0;
> +
> +	if (sk_is_udp(sock->sk))
> +		access_request =3D LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
> +	else
> +		return 0;

Does returning 0 for all non-UDP sockets leave a pre-existing bypass open f=
or
TCP Fast Open?

If a sandboxed process calls sendmsg() on an unconnected TCP socket with
MSG_FASTOPEN and a target address, it routes through sys_sendmsg() to
security_socket_sendmsg() and then tcp_sendmsg_fastopen(). This entirely
bypasses the connect() wrapper and the security_socket_connect hook where
LANDLOCK_ACCESS_NET_CONNECT_TCP is normally enforced.

Since this patch introduces the socket_sendmsg hook, could we also evaluate
TCP sockets here when address !=3D NULL to enforce the
LANDLOCK_ACCESS_NET_CONNECT_TCP restriction and close this gap?

> +
> +	if (address !=3D NULL)
> +		ret =3D current_check_access_socket(sock, address, addrlen,
> +						  access_request, false);
> +
> +	if (ret =3D=3D 0)
> +		ret =3D current_check_autobind_udp_socket(sock);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502124306.3975=
990-1-matthieu@buffet.re?part=3D3
