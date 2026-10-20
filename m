Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505442;
	b=guyGgnGv9XJ6MWgGyZ3vSo8sW4q0UFDnoxVhrQhiB4UOWsJc3i8faqazdX9h9YEJRyia
	 vGNoOSjVoKWYQIj8+0tZbHym2KPBeuQcQn2t0tpxofKBsdQeD9EVTnziyNHCYK50RSiv8
	 gu30yJIZyKD8mVRW4uvsk+NyGAWk3iOZsZnNOviJsN+/RYmzcnCpCrpDzgW3lJUnnPuye
	 2cuIz3e3zBzheZJ/KKrG0rmdlnm24dTUdzrD5VlkFJZrTOXqIzyJJornQi2hoCKlgdKCd
	 f2h9iHiLZHIgoGXS6rGCddIUuahzoJW42NS2b4OSiKl7YqbaOaAHG9qjKROQlg3eP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+B3rk7vRraxSC7OE+BCX6U4AfwdIFhtuKqVTSeRolxo=;
	b=unKAtuSvGHRdTRhPbXalsFIVvpZIzGt0jma4uz36rQPiqvWbtpNbmCu3jwTyu45LjXo5
	 /+QcBBqne//0OpQrZqUmdIMG3qqFi/6gGXZ7VLBH6UEq2OSSt62ADVbh0huUE0YQd3x7D
	 97CNaDyO4uZMwGThWR06psH27nt2QV1aILWkcQtyWyAQRwhGr0A2EWDUfCHZldUAILL9w
	 GGNs3RmSTO4n8yQKMT5ba7UgX2llP8GJmGSXUxxJmVNVKQRRZo5za60Zd7dHmw/ADYUoK
	 5pV6o3DXV2MyaHY8MCgu0YMCJsBEMjgT+gduSi+N+a4bScxRoZOHKKSUENx2GEN4yMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckORGnH6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B1606A31A
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckORGnH6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BC91F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505442;
	bh=+B3rk7vRraxSC7OE+BCX6U4AfwdIFhtuKqVTSeRolxo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ckORGnH6S2MK6BY2T+wtPkOtSYrrd/oWK2Ji3oEFCT8tKxa7631GZ4e1nJUr49cUq
	 BSmcHj/qtGRFwFLq7GS9KKCe3q7JP99CRHYi9r3ePllk+1jry02lwGBdlO3JywDQdX
	 qaEGGAoozCsvyp29mwaLwGQ+MiU5dnJ+IyglZjSOiDARTetIUiAuwToajL+cC3fOBf
	 WtTErvXmyjY2Fi0pQ+IrzNBvN72Qsy8nY05+3TLpIQfZNFWisZ2gn3eqdq2SSFatN+
	 4r9iVK+unFH+H9mggD+N9k08lL2bI356Cn+hOW9FwmXK0T68sC+fAQiRvr4ugztcyB
	 7sURcMw7xo8kQ==
Message-ID: <sashiko-outbox-179089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: check address length before reading AF_UNSPEC
 bind address
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261020140030.92643-1-mike.michalo@gmail.com>
References: <20261020140030.92643-1-mike.michalo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:10:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> bind_map_addr() handles AF_UNSPEC on an IPv4 socket by reading
> addr4->sin_addr.s_addr to check for INADDR_ANY. At that point the only
> length check done is addrlen >=3D offsetofend(struct sockaddr, sa_family),
> i.e. 2 bytes, while sin_addr sits at offset 4. move_addr_to_kernel()
> copies only addrlen bytes into the on-stack sockaddr_storage, so a
> bind() with a short AF_UNSPEC address makes AppArmor branch on bytes the
> caller never supplied.
>=20
> Depending on those bytes, a confined task gets -EAFNOSUPPORT instead of
> the -EINVAL that inet_bind_sk() returns for the same request. Kernels
> built with CONFIG_INIT_STACK_ALL_ZERO read zeroes and happen to behave
> correctly.
>=20
> Check the length first, as inet_bind_sk() does, and as the AF_INET6
> case above already does for inet6_bind_sk().
>=20
> Fixes: 89ac6aa752ec ("apparmor: push inet mediation into profile callback=
s, and improve auditing")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020140030.9264=
3-1-mike.michalo@gmail.com?part=3D1

