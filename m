Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011709;
	b=jqT58dMKJ7A/TXSNUABXroNrVs0J06o6GTWSPyL9WpVt/3e5FAz2cTteBf3luFskjJmr
	 G5C7UE9tg9mSl63pRI+EjMrCDjgSosdN/wY+wWIX+5Cgoj0oEvXoLbXk+99oGuytdftvS
	 Rapsba/Ugskh3E6hiV1vILrdjbYwWwUOQWa3gtuHRyI+JIKKMxOHlZm6/ze1bkC4bxmXa
	 K/i9oIFlP+V+Xfv6HE/dfUCG+RY/P0fLfhVLYkrdj3Osimqk88AMqw8+a+688fQYi21Xe
	 sV4fO368gal3Ml9O/95Mico2RTXi8JEUJUG8en9xOBFTeiUkGg02IGsdLujnPn8H0dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011709;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PmNOFMPRkZkI2TL/atFGjmJngs7HdhLeCOXWAZV85XQ=;
	b=nWqA3H4t9mW0ss8orZK5t1ynyqI2cvcaHATvVCwEQYU856pYkdYnMQ7CR+8pBjVYP2xA
	 0HhvfYS+XFk1rObIuSr8xQOQ1nz2md4Xn5O/V0AOzmx8eIfslRCnZAdfazG3MCRQ4OrMH
	 awXR1YOwsUM5UkHcpcgaL9dTR0J3dzrYGeimQ//93EdcyUpVEPtKaODWCBHXMzBEKUSzY
	 nReiVSO+1mtgAd2aecRHjTqdJYJABgSQcUhsoBTQrMDxreVMRdWrMA2pi/CJM9vMEDA5T
	 9ppPoSVOHRhBwjTnk1eQD7hM/pBVRgLP3s2695xD6v3tID5+4vv0iO35/pQFCYM4WWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7D4v+Bs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F2606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7D4v+Bs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E941F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011708;
	bh=PmNOFMPRkZkI2TL/atFGjmJngs7HdhLeCOXWAZV85XQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S7D4v+BsW4+fUGYpurN3u9cwxCMjOh4Nc99bx97wXPXnRD4A90XkFLffvBNnUFB4R
	 BrNXfmG4EpmcmDsgzb1/BR3TqFXrZiB2NHhm0NxDcDgHzFOIbGmmc0ahHSZj4G4Hmd
	 WhMu7wXCt65KysvGU+xk5sRGbb86KrvIKuYrlJBzSlBBwXGOZucMrK0WdB5VDNuCtl
	 +DZpXY/WqsLW9j/bgUd+noKSWFTUbNg8NRrNBcnll1YAundDTEU5mbVhQcS5dd3+kQ
	 Ei2MdVwgv65mCwX06rrdmn9opllJ0VidnE9jXqgUIHba92g3nxG9B3apelWm/vpC0T
	 BiL0DStBwz5Pw==
Message-ID: <sashiko-outbox-221192@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/9] KEYS: keycrypt: Add the sw backend
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118140421.584086-3-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118140421.584086-3-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:21:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Systems with neither a TEE nor a crypto engine able to keep keys still
> want keys that user space cannot read and that are bound to one
> algorithm and purpose, and the same interface on every device.
>=20
> Add the "sw" backend, of the kernel tier: it seals each key with
> AES-256-GCM under a key derived with HMAC-SHA256 from a "trusted" key
> named by master=3D, authenticating the keycrypt header with it, and runs
> the operations with the kernel's crypto library. A loaded key is in
> clear in kernel memory until revoked or destroyed, which the kernel
> log says when the backend registers and when the first key is loaded;
> the backend is chosen only by tier=3Dkernel, by backend=3Dsw, or when no
> backend of a higher tier is registered, and a system that must not use
> it raises the system tier above it (CONFIG_KEYCRYPT_SYSTEM_TIER_*), or
> leaves this option off.
>=20
> In that derivation the trusted key's material is what the HMAC
> processes, under a label and a random salt as its key, and not the
> other way round: AF_ALG lets user space name a trusted key by its
> serial number as the key of an HMAC socket, so with the material as the
> key anyone allowed to search the master could recompute the sealing
> key of every blob.
>=20
> It depends on TRUSTED_KEYS and is a module when trusted keys are one.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D2

