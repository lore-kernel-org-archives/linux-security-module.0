Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336029;
	b=THMAW1JgsrDdONLcrbX3Gqz54eLz7ZPBLnbKQDmK5pNh4anxPeTwZvBqLLm+HYIgUHEQ
	 W7A9oK+FDn/+5iNI3vWoc27jmBovXOZy3cujDk1jmY5KRQeJQP9IwgQ2Apy63+a1WjiEY
	 7H6DehPGexYb+BbOotEGOtH5NLx15ZBsnx0XlCJC1Lu/OmM3jszxo2doQMbJI3DiU9wO6
	 nGBysLuPB0i+qhDtDqg/RRNmBO5ow+7qHbd73cEdY2uXWyd0IxipiIZtxgIWc63pZp7qr
	 1dE8b32/XHssMYFjVwsZbyoohzIFrNWT0WGio+gEwJ/giUj7LetkDjdwg8qw8kCBvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ACyemNa54S9RAwf0ubAYUuFxQJx261xLPRB9RUPcGzk=;
	b=qSFcYu7b59BUqT07GHGFCZ3sD/cI4GCX1QOtcAhLXl7+aXAgqXjBKsSJ6NNvvloGe7Hc
	 Ss+jnwlcSZ5HpgLFIlGbLDZOoX1nSUF3TI8611MeillyJ9RhismMbt7wXLfTC8eOYTcLl
	 PTJyqrPIeITmKgT8dpBMgFH3QXhD5QPWsEf8mFnVLEgw0r1XCW0gkKsOjUzjbytsBYIk5
	 oArWsNPgNkKT0Q0L7tdvI1kHUMv0lO8T9WYRlfij65CjsuNSFgb4gOwc1svnL5kWP+qaw
	 xwYgkeEC/DSBBDmeTZB0t+z/FQcF2Pahcfg6k1aqD4HNamkTIMZjembc7MulqmxgE3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUaGHFRy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C3606A321
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUaGHFRy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842241F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336028;
	bh=ACyemNa54S9RAwf0ubAYUuFxQJx261xLPRB9RUPcGzk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dUaGHFRyQuTn8CiiROrfiqjiF6ayHWo+CeXAAnLd8HQFlPGYTmvhXOnz7hiAlWdfW
	 8tA7rOTjh9ieO/+LSFCqa+suPcIKRnWMPR1hZiPrZ2/9ahrTflmjmi+sAoNg2B5+x8
	 KsAMk+aGoJYnL2oFwb6X6nu450lj3agskQ9orPQvi4KDOX1ejfafxrcSBVyDJO8L1g
	 /U6PhiKETarNwU6DCXWfCJi7hftRZjEA/SC30v92oNlUj6wvHb9s7X6ynybOJpcECR
	 Y488FOnC+4ZwCMvgH+s8C5l5p4Q8R9p+Q/J2lW9HCn+edsIkGBXKV3xHBCNMQgSt0y
	 M1UBVT8tEXJNg==
Message-ID: <sashiko-outbox-190353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] selftests/landlock: Add tests for sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260502124306.3975990-6-matthieu@buffet.re>
References: <20260502124306.3975990-6-matthieu@buffet.re>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:48 +0000
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
- [Medium] Test Hang Vulnerability due to EXPECT_EQ before blocking socket =
reads
- [Medium] Stale Data Validation due to missing audit_count_records() call
- [Low] File descriptor and resource leaks in test paths
--

commit a3c5aefc4ced3649cf0e1efaac53d8674cff7d76
Author: Matthieu Buffet <matthieu@buffet.re>

selftests/landlock: Add tests for sendmsg()

This commit adds tests specific to UDP sendmsg() in the protocol_* variants
to ensure behaviour is consistent across AF_INET, AF_INET6 and AF_UNIX.

> diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/=
selftests/landlock/net_test.c
> --- a/tools/testing/selftests/landlock/net_test.c
> +++ b/tools/testing/selftests/landlock/net_test.c

[ ... ]

> @@ -1119,6 +1274,441 @@ TEST_F(protocol, connect_unspec)
> +TEST_F(protocol, sendmsg_stream)
> +{

[ ... ]

> +	/* Send to a truncated (invalid) address. */
> +	res =3D sendto_variant_addrlen(client_fd, &self->srv0,
> +				     get_addrlen(&self->srv0, true) - 1, "D", 1,
> +				     0);
> +	if (variant->prot.domain =3D=3D AF_UNIX) {
> +		EXPECT_EQ(-EISCONN, res);
> +	} else {
> +		EXPECT_EQ(0, res);
> +		EXPECT_EQ(1, recv(srv0_fd, read_buf, 1, 0))

If the send operation fails, EXPECT_EQ logs the failure but allows the test
to continue. Will the subsequent recv() block indefinitely since no data was
sent, causing the test suite to hang until a timeout occurs?

Should this be ASSERT_EQ instead?

[ ... ]

> +TEST_F(protocol, sendmsg_unspec)
> +{

[ ... ]

> +	res =3D sendto_variant(client_fd, &self->unspec_srv0, "B", 1, 0);
> +	if (variant->prot.domain =3D=3D AF_INET6) {

[ ... ]

> +	} else if (variant->prot.domain =3D=3D AF_INET) {
> +		EXPECT_EQ(0, res);
> +		EXPECT_EQ(1, read(srv0_fd, read_buf, 1))

Could this read() also block indefinitely if the sendto_variant() above fai=
ls,
similar to the recv() in sendmsg_stream?

[ ... ]

> @@ -2342,4 +2938,58 @@ TEST_F(audit, connect)
> +TEST_F(audit, sendmsg)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_net =3D LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP |
> +				      LANDLOCK_ACCESS_NET_BIND_UDP,
> +	};
> +	const struct landlock_net_port_attr rule =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP,
> +		.port =3D self->srv1.port,
> +	};
> +	const int ruleset_fd =3D
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	struct audit_records records;
> +	int sock_fd;
> +
> +	/* Sendmsg on stream sockets is never denied. */
> +	if (variant->prot.type !=3D SOCK_DGRAM)
> +		return;

Does this early return leak the ruleset_fd created just above it?

Could the check for SOCK_DGRAM be moved before creating the ruleset?

[ ... ]

> +	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(1, records.domain);
> +
> +	/* Check that autobind generates a denied bind event. */
> +	EXPECT_EQ(-EACCES, sendto_variant(sock_fd, &self->srv1, "A", 1, 0));
> +	EXPECT_EQ(0, matches_auditlog(self->audit_fd, "net\\.bind_udp", NULL,
> +				      NULL, NULL));
> +	EXPECT_EQ(0, records.access);
> +	EXPECT_EQ(1, records.domain);

Are we checking stale data here? It looks like a call to
audit_count_records(self->audit_fd, &records) is missing before checking
records.access and records.domain for this second event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502124306.3975=
990-1-matthieu@buffet.re?part=3D5
