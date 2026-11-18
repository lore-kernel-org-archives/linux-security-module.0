Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011889;
	b=HdAHBf7gjgIPKux65dCpa70wu2Yk8R9GkxyexaB+NbphuShcV8qzHNAjWdrCZvlhCcWe
	 sfkJmKDsIkZVcXpUWIfY9u96rXnpQ+PdS8bwmvSY5w+1Vk6QWXFhan1qvQPaeKxVibK7C
	 EoG8+f9FdqVs9aBaEBBUL6XHF/FUIix2c7FereYiE/eydR49A6TCXaluLF6qG0sUV2W94
	 vW72uXDOlIF7gSQnrLkWVbK6i8faVphG0OQVnw0uXcvcgR7pHrpEZVtb2JVPy8ytjFdqP
	 RE1vYWs/W1tRYPNcmmESoIkd2KFyzro85iD3nydNk7VIsos4mTULqhH3cp4AzeefXAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WkMezfpk5L6Iaw2QI8Eoo9V/JKZp2Qyy3fZqyzjORzc=;
	b=ZSl4JKRawRPLFv/lwOS8WDgpfaGPTDcgwN1AzcbJxl1edLQE67k9CQb2nWeFUIo7BWJy
	 cwaCiJIOYoxLFjzC4CQwRIQOBzusWd+pZLGqz0myaP1Bxl6ZOsQ/mzq+UHC7rKmtOJK/0
	 uWM2kM5K0+87ob4MZY/fqHs3Wj+4v2G+gzorBKS0DKYtDKV4+/TUzHIf2eqv4pXnMB+Xc
	 D4+FX1rwtGRrRdCJiJTP5Pcf8jtgoFkhpRi1Hfg/jtgVOPv9s7eBzjKObuc473w27guYc
	 fohPFmqWXOkmNclIh+T4r8/+TOUXX81A3c7UA3lPmVC7PYVUVP5QX/oGbLzkjfBSYuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAohTR7y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D6606A338
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eAohTR7y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397251F000C9
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011889;
	bh=WkMezfpk5L6Iaw2QI8Eoo9V/JKZp2Qyy3fZqyzjORzc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eAohTR7yiRb2j3NwpTvDGyS8PWLgsvGTle1jKQp9R3JKYevjawJBBx94QZqm0NlsL
	 pCUYMxY2I14AeqlUSwGTXzL+dH5QG4XcP30zV7aw6L0ZS7MNina9LfFlKLlMd9e7Xa
	 ih6CFjfvBfBq/HigfWPS9BFfi4TOsCemqy9igUInImQFQ7sXGQOQdBVyOg952iBgi2
	 d+2hqm5QeZuoGR38S0EUA7BsH+7etpojnaL5EMbHvAhKwLS1Rt+wkUSXR2QfGiwHqq
	 WRzoWy314QjcaoinxMF6LMs94zu5H4OO7vFcyGQ2MMvI0BrBuD299hiMdcJyD6oL3E
	 lAdf5oweg1D0g==
Message-ID: <sashiko-outbox-221196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/9] crypto: caam - add an internal cbc(paes) taking
 the blob's key modifier
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118141047.616989-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141047.616989-1-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:24:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cbc(paes) decapsulates every blob with the fixed key modifier
> "SECURE_KEY", the one trusted keys use for their "pk" keys, and is
> reachable from AF_ALG: a blob made for either can be used through the
> other by whoever holds CAP_NET_ADMIN or CAP_SYS_ADMIN (with AF_ALG's
> default restriction), for whatever operation they choose. A kernel
> user that wants its blobs bound to something of its own, such as the
> metadata of the key they protect, has no way to say so.
>=20
> Add a second cbc(paes), cbc-paes-km-caam, flagged CRYPTO_ALG_INTERNAL
> so that only kernel code asking for that flag can allocate it, as the
> DCP's paes is, which trusted keys allocate by driver name with that
> flag; its key names the key modifier to decapsulate with.
> caam_encap_blob() already takes a caller's key modifier, so a kernel
> user can now bind its blobs to a value of its own.
>=20
> Its only user is the keycrypt CAAM backend, which is a proposal, and
> so is this.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D7

