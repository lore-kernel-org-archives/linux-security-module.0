Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336028;
	b=NIvgAuAGORFvBofEjuIibgC4Anog8C6ktq2q9ylKB+PFeTWTdHeatYiZaLf+KD6NC5vi
	 ym4FkHE+HibB7UQfMgd7plkvSujHNORbZFbrA+hoETPQHZoUGr/FBDxcM8ZKTiPpjUN6y
	 RqmIs0iNZ4eAcKXLROm4wptu2JYl1JNHx/oA7PxP4Rw/IQswGBCnY4AFhDPIXR0Hr8YCr
	 OndkhcmvtbhU5ZIKOwoZHWb8lDSlYcVNhwH0snGJAryMR+UhZ51NCaCgxIE8xQFWTMLUi
	 HBiYdFqe3OWTy4fLkI9LuioxRwn2NZm4oYA/RneakC1fHyEMh1zJeE3ZkgtyWoVH4eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9wOHzVxsBoLRaFVvgbr0QXZpoTkZuvLgwLY3MOLzi+o=;
	b=a48ppfRCpW3p+cMg2L/zYdGrClXA935sBFo6OQIQBi0LVaGuvYJDB7FusRWW6i4UNOzu
	 /31CkCl0B9zcpIJfdnZ9zHnFZpuvoesmXrRPJ3Rp8B/Rm/OaNlR7xfGfD9e0qg9Zfb6Kp
	 litmuE644OYiMSeRsWQelVYrCabPAvVYIDT/f37UNMTF17p+sxwQAD3hGYLcSh/nM+PQw
	 GIh8/m1OjHQinO23ILBaaddXrPcu+lE7CphG/DaJvCvu0LMRyaFC4y1J5Aqz/2IM8gSVC
	 oPCCFXs0EXTceBrJ9fYDO7MEVANS6Ub5axUrXdjmUow6TVHoJGHCj3MKhml50qcDtcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9FxtQdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADF606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9FxtQdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE761F0093A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336028;
	bh=9wOHzVxsBoLRaFVvgbr0QXZpoTkZuvLgwLY3MOLzi+o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Z9FxtQdK/TQccWWYnrjwrYvZTEz8DE68WlTOa6r1V2urJZnE8Ouc6fy0oyym2FcVA
	 Vr5vhs3SLF1cLXqqvC6VF1rMOlGn/hrpow3Qt67JSOaz/GuGdwosB/TBrmzL2QgvfK
	 f1bzGpDnfF0jm6EM1m7YHZRFI7iYZ76JoZ0briCiSZybIUROI1ioHj78WPQ/dV/nl1
	 z/1KtxqtUQcJKUn/TwM3TGaIIcQZBNdvOhlR12VEDnNHsxPAZFirWpkV9ADo7E8129
	 9n1cb04i/583e01b7NeqfBpl8g7VPtKohfV+spjNCosRrC1EFOz+nmDEsa8L4OIGq9
	 8is8jsQ9j+uNQ==
Message-ID: <sashiko-outbox-190352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] selftests/landlock: Add UDP bind/connect tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260502124306.3975990-5-matthieu@buffet.re>
References: <20260502124306.3975990-5-matthieu@buffet.re>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `SO_RCVTIMEO` and `SO_SNDTIMEO` socket timeouts added in `so=
cket_variant()` are set to an aggressively short 100 milliseconds.
- [Medium] The patch introduces a file descriptor leak in `TEST_F(port_spec=
ific, bind_connect_1023)` by overwriting `connect_fd` without closing the p=
reviously allocated socket.
- [Low] The 64-bit Landlock access rights bitmasks are assigned to signed 3=
2-bit `const int` variables, which discards the upper 32 bits.
--

commit 9a737284d2bae1dcd34a40323c4679a1e1cb1593
Author: Matthieu Buffet <matthieu@buffet.re>

selftests/landlock: Add UDP bind/connect tests
   =20
Make basic changes to the existing bind() and connect() test suite to
cover UDP restriction.

> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> index 016c7277e370..568a6ed7139c 100644
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c

[ ... ]

>  static int socket_variant(const struct service_fixture *const srv)
>  {
> +	/* Arbitrary value just to not block other tests indefinitely. */
> +	const struct timeval timeout =3D {
> +		.tv_sec =3D 0,
> +		.tv_usec =3D 100000,
> +	};

Could this 100 millisecond timeout cause false-positive test failures in he=
avily
loaded CI environments or nested VMs?

In test_bind_and_connect(), the parent process calls accept() or read() and
waits for an unsynchronized forked child process to execute socket(), conne=
ct(),
and write(). If process scheduling delays the child, the parent's blocking
operations might time out and return -EAGAIN.

[ ... ]

> @@ -737,16 +895,20 @@ TEST_F(protocol, connect)
> =20
>  TEST_F(protocol, bind_unspec)
>  {
> +	const int bind_access =3D (variant->sandbox =3D=3D TCP_SANDBOX ?
> +					 LANDLOCK_ACCESS_NET_BIND_TCP :
> +					 LANDLOCK_ACCESS_NET_BIND_UDP);

Should bind_access use __u64 instead of int?

The 64-bit Landlock access rights bitmasks are assigned to signed 32-bit int
variables here and in several other tests, which discards the upper 32 bits.
While current flags use only the lower bits, this type mismatch might risk
future sign-extension or truncation bugs if Landlock introduces flags using
higher bits.

[ ... ]

> @@ -1815,23 +2035,35 @@ TEST_F(port_specific, bind_connect_1023)
>  	int bind_fd, connect_fd, ret;
> =20
>  	/* Adds a rule layer with bind and connect actions. */
> -	if (variant->sandbox =3D=3D TCP_SANDBOX) {
> +	if (variant->sandbox =3D=3D TCP_SANDBOX ||
> +	    variant->sandbox =3D=3D UDP_SANDBOX) {
> +		const int bind_right =3D (variant->sandbox =3D=3D TCP_SANDBOX ?
> +						LANDLOCK_ACCESS_NET_BIND_TCP :
> +						LANDLOCK_ACCESS_NET_BIND_UDP);
> +		const int access_rights =3D
> +			(variant->sandbox =3D=3D TCP_SANDBOX ?
> +				 (LANDLOCK_ACCESS_NET_BIND_TCP |
> +				  LANDLOCK_ACCESS_NET_CONNECT_TCP) :
> +				 (LANDLOCK_ACCESS_NET_BIND_UDP |
> +				  LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP));

Similar to the above, should bind_right and access_rights be defined as __u=
64
to match struct landlock_ruleset_attr.handled_access_net?

[ ... ]

> @@ -1867,8 +2104,19 @@ TEST_F(port_specific, bind_connect_1023)
>  	ret =3D bind_variant(bind_fd, &self->srv0);
>  	clear_cap(_metadata, CAP_NET_BIND_SERVICE);
>  	EXPECT_EQ(0, ret);
> -	EXPECT_EQ(0, listen(bind_fd, backlog));
> +	if (variant->prot.type =3D=3D SOCK_STREAM)
> +		EXPECT_EQ(0, listen(bind_fd, backlog));
> =20
> +	connect_fd =3D socket_variant(&self->srv0);
> +	ASSERT_LE(0, connect_fd);

Does this overwrite the connect_fd variable and leak the previously allocat=
ed
socket file descriptor without calling close()?

connect_fd appears to be allocated via socket_variant() earlier at the start
of TEST_F(port_specific, bind_connect_1023).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502124306.3975=
990-1-matthieu@buffet.re?part=3D4
