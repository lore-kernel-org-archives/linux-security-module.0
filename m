Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481030;
	b=r4EIBRmxDAjUoYmNlzK0FcHMqzOMryDro/Jyn9Bi/lD8PuWmLwuGqm7dBaSRSoGEoHFu
	 BjaCI4DF6EWX1IGktTrQ2GQtHyN3huF4Um1w/HA1cBoXKieEVtass4xi20Ips8Lm311Ya
	 1Y52VZRc5ccyTRKjOt24dwymrfA0me1q+j5t2ac/29ldIKZwdywcoNMjUBIKW1OfLA+26
	 IZI03+fggFxF/sNz51rLqT24uZafd6AHeDx/bhDyqMTWjZJ5eaZ6XOp5u5jZ/Td4qpPM7
	 WKf+pCOnl1j+6YJ++nwL9MKEO2GaEdXtTMJ97tYBOqYJ5Yvl+yS4CXT7SG4vvUgMpvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481030;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uoe4jNadfk2FRsYHGG3hdZtNummnvS9LSp32ijDn1WQ=;
	b=SE572/Ew2lUx/02lvXfKaC+ObOrHfn0Oq/L6Vg8yEGM67TcZCWYLdFoCj1lIdg0M6D1f
	 GaQmYXgXgoZhGY0DywjRDT3ncZS4ro/OqLMpt8Fg4wGj4yhcNKnCyso60GLNfkykH3DEz
	 8Xl/2iNFVCWz1pkkiKihB9syP7h92dBbaSt+8JeAthxAh8CPv+RU2zxQaB0sUyLAyR6RG
	 LIi18lvMTFZjuN3eNceW3p+Cf9ylfRgfgSYPzG0C/zN/2s3/45K3R4fWS/oWFO1ricJKM
	 vWx1qVjgdVcbNIuPQTRb9D4zTO0aRgvQWb3byUx112PMpt9r8Q3lbNCS1YzfbNwTrmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTNbwEoE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62662606A31C
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JTNbwEoE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB61F000C1
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481030;
	bh=uoe4jNadfk2FRsYHGG3hdZtNummnvS9LSp32ijDn1WQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JTNbwEoELHzOVPeoq9tMJu0WTbsIQixN/umrK09z4pBsOk6tNjpdN5VvCs8UFjC3J
	 KfU5fAQ3Yzlb0KFCITNudrY2FaniU7IiHRJMiWOLhefdBqHIEtCFll79WbP/zd5i1R
	 gKPJ1NaQezVZqsmjdEujoj1NwivigmU8y7gI4s5wMBSq7hnCbPR+FCZo6dD/woPAaa
	 xpDeXHcFyouGh/2EvSxpduoX3W58JJj308ZRFuHTcumrxvi3JJlU3f1uFWoDX1/1NU
	 muJ81DN9YnQdkuN8pHroQS7N7PqV6GT6Kd6IQubvVt1PjnhqSRazud4AIa3pYPbdFA
	 RiuvkR2h2+low==
Message-ID: <sashiko-outbox-192150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] ima: skip algorithm availability check until
 initramfs unpacking is finished
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261030210944.2143778-2-dannyhu@arista.com>
References: <20261030210944.2143778-1-dannyhu@arista.com>
 <20261030210944.2143778-2-dannyhu@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:10:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> With CONFIG_IMA_APPRAISE=3Dy, restoring xattrs during initramfs unpacking
> can deadlock the kernel if the xattr being restored is signed with a hash
> that the kernel does not already have available. This occurs when the
> ima_inode_setxattr() hook calls crypto_has_alg(). crypto_has_alg() may
> synchronously request a module leading to a circular dependency where the
> userspace helper waits for initramfs unpacking to complete while initramfs
> unpacking waits for the userspace helper.
>=20
> Guard this crypto availability check in validate_hash_algo() until
> initramfs unpacking is complete. This prevents the kernel from requesting
> a module during unpacking and allows security.ima xattrs to be restored
> even if the hash algorithm is unavailable in the running kernel.
> Essentially, this flag distinguishes restoration of existing metadata
> during initial population from setting/changing an xattr during runtime.
>=20
> A benefit of this approach is that once unpacking is complete, all
> subsequent xattr updates go through the same codepath as before which
> preserves the existing behavior during normal userspace operation.
>=20
> Signed-off-by: Danny Hu <dannyhu@arista.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030210944.2143=
778-1-dannyhu@arista.com?part=3D1

