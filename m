Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA8F1F16B
	for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667250; cv=none; b=isWlOYXMvN2CHkSLKXYQcDrYS284N7tSqqlh8PlNilh4l1Qm0x5O1dTgFbHywDEx/Af2v3HV+lQpTWxmnHc/so6GG8KGm3cicJht6HTLOZBgjeZGHaZt3PmTv5yXvpwjx0Tks9oDxoUxx40bjsGgWvup9C35i2aMJiTxhITzpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667250; c=relaxed/simple;
	bh=GDGuh3clDKjEw5snTq19rxYOvagJxpjo4DkoPdwdWBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sRbbfpJGgq9xnhfYuaSTl+SaGV1O515kHeJ+dmK7kA1JMxFoNGVlODuOkZX84q6tb4ySgdyuzxzju7gr1he3FDFASSW0HNcLu8jZ2o4nvWfaNS3Jz9s/n8xLvCOEsjnducFGO5TzsstPgdhwWSf68EgYuXV2kncDCmJWjWY/X/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tA664/3a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tA664/3a"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d3e062dbeeso13610617b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Sep 2024 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726667248; x=1727272048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3arr1pvSrk2D4BO1nfT8AuNkLP625w0RydkxLLREKo=;
        b=tA664/3auIRR09iHTWZnDv2J0PBTI8OpjBhA3Eq5WDx3MbPPc513Xo79GOpykkfRg7
         WZavwb4j6ckJ/8F+n0p9tuEatR9A42Lw/8xjq424cKXPheH+kOHKhjt6VVPIRtsZwT9U
         7gzeTRlCbE2lTCiYBWKB+AdTqHcgRM9+dqZmjsR8mJz227pjkmhQ7wYTwA1zzoJ5/bun
         KGH/s2s8YqLyJyA6bNV4fC3syeAezi5Ots9wcEQGeceDQQsk/PvJelPcbezvHUl7VwSr
         6QOXFvR9NX2PMllQFbETvTUkxqCp89M9RE10oAp/cPmJQn5xwni4b9qPQhbodezr8i09
         Z3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726667248; x=1727272048;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x3arr1pvSrk2D4BO1nfT8AuNkLP625w0RydkxLLREKo=;
        b=hHr49MpC3w4Zpt5kwMo0Fli/58uleeco1yBVZN/vKeqLSoQ+rh6IWBoO7iQswSOngT
         AORSvOYueIlO8y6m1/BaNXQqTNa/+hWNI50dEaMRVwA++onqCNZYVpRiYV3kcpEoT6Mt
         qknb7of1PJ8D/Hx4BeeqChHleKvKRBPvQGEDdGYfmjwb3uYDl8Wjjzc/2MFreSHaCif1
         M4GaE0augQ7Au9r7/+iOMvZ49QFhT7TN8A8w8imWj8YtrbY7YO/0Mq8f3ibfnBHZajHK
         fQRe2SwdNfTRJsv0HJonGlkpJWT7f7JvaqU1LaRpAYMTekyJR1IzIN15AoDsGxACd2uf
         +t2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIwreNcWI/y0ccmjRju906U3PTFiqG3OHg06Lv/r2oTvrsD8qNZTWGjD7BR6bDixSoqpAljMGtvG23yhNCT8suTOqDjyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEM/6PT6NdtPjRduDhG/cS+a7QJCFy5tkivDt6vsTbG/rMOtlY
	zSOZWGItUm7TqVmCwi1kp8Qr5jumF+tbjrCKczk701/zMvS1YY1Gcnlhgk02Cc/k5ZOvXhWEHo7
	1VA==
X-Google-Smtp-Source: AGHT+IEEB12fvnLWRPDj+ULkH8v6urxdoUDoN3OGG9937DOBkTZ1Zw3W5tTPSNVuGk+HOrg6Ar6WbdEqeMY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:b104:0:b0:6dc:836a:e272 with SMTP id
 00721157ae682-6dc836ae8bamr3579447b3.0.1726667248274; Wed, 18 Sep 2024
 06:47:28 -0700 (PDT)
Date: Wed, 18 Sep 2024 15:47:26 +0200
In-Reply-To: <20240904104824.1844082-15-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com> <20240904104824.1844082-15-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZurZ7nuRRl0Zf2iM@google.com>
Subject: Re: [RFC PATCH v3 14/19] selftests/landlock: Test socketpair(2) restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 04, 2024 at 06:48:19PM +0800, Mikhail Ivanov wrote:
> Add test that checks the restriction on socket creation using
> socketpair(2).
>=20
> Add `socket_creation` fixture to configure sandboxing in tests in
> which different socket creation actions are tested.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> ---
>  .../testing/selftests/landlock/socket_test.c  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>=20
> diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testi=
ng/selftests/landlock/socket_test.c
> index 8fc507bf902a..67db0e1c1121 100644
> --- a/tools/testing/selftests/landlock/socket_test.c
> +++ b/tools/testing/selftests/landlock/socket_test.c
> @@ -738,4 +738,105 @@ TEST_F(packet_protocol, alias_restriction)
>  	EXPECT_EQ(0, test_socket_variant(&self->prot_tested));
>  }
> =20
> +static int test_socketpair(int family, int type, int protocol)
> +{
> +	int fds[2];
> +	int err;
> +
> +	err =3D socketpair(family, type | SOCK_CLOEXEC, protocol, fds);
> +	if (err)
> +		return errno;
> +	/*
> +	 * Mixing error codes from close(2) and socketpair(2) should not lead t=
o
> +	 * any (access type) confusion for this test.
> +	 */
> +	if (close(fds[0]) !=3D 0)
> +		return errno;
> +	if (close(fds[1]) !=3D 0)
> +		return errno;
> +	return 0;
> +}
> +
> +FIXTURE(socket_creation)
> +{
> +	bool sandboxed;
> +	bool allowed;
> +};
> +
> +FIXTURE_VARIANT(socket_creation)
> +{
> +	bool sandboxed;
> +	bool allowed;
> +};
> +
> +FIXTURE_SETUP(socket_creation)
> +{
> +	self->sandboxed =3D variant->sandboxed;
> +	self->allowed =3D variant->allowed;
> +
> +	setup_loopback(_metadata);
> +};
> +
> +FIXTURE_TEARDOWN(socket_creation)
> +{
> +}
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(socket_creation, no_sandbox) {
> +	/* clang-format on */
> +	.sandboxed =3D false,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(socket_creation, sandbox_allow) {
> +	/* clang-format on */
> +	.sandboxed =3D true,
> +	.allowed =3D true,
> +};
> +
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(socket_creation, sandbox_deny) {
> +	/* clang-format on */
> +	.sandboxed =3D true,
> +	.allowed =3D false,
> +};
> +
> +TEST_F(socket_creation, socketpair)
> +{
> +	const struct landlock_ruleset_attr ruleset_attr =3D {
> +		.handled_access_socket =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +	};
> +	struct landlock_socket_attr unix_socket_create =3D {
> +		.allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
> +		.family =3D AF_UNIX,
> +		.type =3D SOCK_STREAM,
> +	};
> +	int ruleset_fd;
> +
> +	if (self->sandboxed) {
> +		ruleset_fd =3D landlock_create_ruleset(&ruleset_attr,
> +						     sizeof(ruleset_attr), 0);
> +		ASSERT_LE(0, ruleset_fd);
> +
> +		if (self->allowed) {
> +			ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
> +						       LANDLOCK_RULE_SOCKET,
> +						       &unix_socket_create, 0));
> +		}
> +		enforce_ruleset(_metadata, ruleset_fd);
> +		ASSERT_EQ(0, close(ruleset_fd));
> +	}
> +
> +	if (!self->sandboxed || self->allowed) {
> +		/*
> +		 * Tries to create sockets when ruleset is not established
> +		 * or protocol is allowed.
> +		 */
> +		EXPECT_EQ(0, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +	} else {
> +		/* Tries to create sockets when protocol is restricted. */
> +		EXPECT_EQ(EACCES, test_socketpair(AF_UNIX, SOCK_STREAM, 0));
> +	}

I am torn on whether socketpair() should be denied at all --

  * on one hand, the created sockets are connected to each other
    and the creating process can only talk to itself (or pass one of them o=
n),
    which seems legitimate and harmless.

  * on the other hand, it *does* create two sockets, and
    if they are datagram sockets, it it probably currently possible
    to disassociate them with connect(AF_UNSPEC).

What are your thoughts on that?

Micka=C3=ABl, I believe we have also discussed similar questions for pipe(2=
) in the
past, and you had opinions on that?


(On a much more technical note; consider replacing self->allowed with
self->socketpair_error to directly indicate the expected error? It feels th=
at
this could be more straightforward?)

=E2=80=94G=C3=BCnther
