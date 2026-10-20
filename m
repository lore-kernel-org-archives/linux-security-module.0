Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518828;
	b=lvm7jt3UnmC9vXjHic1gGqxrESVDG0VzJ2eFVyrt7vVQJOQnMi9Yb7d5rTYxcmKaHJlO
	 hTuhVeTxngvYXLvj0Vb/H7XuVqsWYQv6y4UsSSufU3IFR7cmUiUtua8tZg/dWNd3LajLe
	 GsAFj/sel+L6hq8LitncUvgas5spXMoX/Di9dX9z2wF37oKrlj4/R5pbtzjOLBVaNLz7v
	 WV1hZE8xnGx3EvmJt4gUXBdKfdBWNUlC3AdPL+97623uIQEAZ98Q3qCWGmDna0xU2thfZ
	 myIEjTgJyHVpi7WMLmS4Pq3jaPPZT29M9E+aY9qy3k/0Ou9q/lSFcQs0GPCytUVjXsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T8MaUlD0AeTLUf+wODiDsdc4PU7Ikz6PxD96Q7cBTxM=;
	b=khUS7zSgwDyEzpzdBaJHqUM7Jbl4jYoHqVapnuwpUSLASHpgbexeXgEehmp9xyNTnHJF
	 OCpvNWWrSNsAm+EPY1WrdXMIyRY9PYnxn4hz+t5I5erQcntPK2vnji5pz+gvgxZf5kSxK
	 IFx5bo9E8L8LKTQwY6yoWZeODtqAmQKK8Okb8CLy3pyAs1WklHKnC65zXcb6hdyK45EHj
	 a7K12T6vYHEL9PIDTDsD9tY/WGrn9nkQ8JdSJJVFG3kw7lG+WKhsFng+aJpxXkRGFjGFA
	 nzwWFn8s8GlR4Cc10phpfsl8wzLQPMG0UM7A0+lSCaxIouq3xJmb4cQJ0x8650i2Iog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkBje6Kk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61227606A319
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkBje6Kk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80A31F000C9
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518827;
	bh=T8MaUlD0AeTLUf+wODiDsdc4PU7Ikz6PxD96Q7cBTxM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EkBje6KkRW+iRtpI3pyQuSu8p0px1U7sjTdgrHlPnmZP3OC8kJUo75UAassY7uI9m
	 Fya8CDz3AgJI/nGNql5r1e+g4JJ7vGe9H+2RaLX0Qam3XHgeNG/5ImpjPGFsm1EiwQ
	 kt5RlgwXYkaGI8Eiro1NAokVmRGPd2YdyiE9VrxU7l4wlNupY0OL+PJZq+VwDWlRkK
	 KOQGp0DWqH4R9nPpJuQXdQ41VfaW8QpFJDiOF6se040899+V60wrcSg/I+D0xR8PU3
	 JImya5tGs9pmX28xpLhO8jZw4J7zr0vWKGleOTKdzFlIKxaRReBws6ssigNI9WpD6M
	 4kr1RK9eFidOA==
Message-ID: <sashiko-outbox-179448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020174325.2229448-2-jarkko@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <20261020174325.2229448-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:53:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
> can receive values larger than USHRT_MAX.
>=20
> Example:
>=20
>   keyctl new_session >/dev/null
>   owner=3D$(keyctl newring owner @s)
>   keeper=3D$(keyctl newring keeper @s)
>=20
>   for ((i=3D0; i<16384; i++)); do
>       key=3D$(keyctl add user "k$i" x "$keeper")
>       keyctl link "$key" "$owner"
>   done
>=20
>   awk -v uid=3D"$(id -u):" '$1 =3D=3D uid {print $NF}' /proc/key-users
>   keyctl clear "$owner"
>   awk -v uid=3D"$(id -u):" '$1 =3D=3D uid {print $NF}' /proc/key-users
>=20
> Because key->datalen wraps around 65535, the quota refunded upon clearing
> is truncated, causing quota bytes to leak in /proc/key-users.
>=20
> Change the types of key->datalen and key->quotalen from unsigned short to
> unsigned int so that they can carry the full payload length without
> truncation.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020174325.2229=
448-1-jarkko@kernel.org?part=3D1

