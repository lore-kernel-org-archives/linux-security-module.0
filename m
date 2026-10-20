Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486311;
	b=Wk4v10oBgDaurYyRwgVtK041/SoNGchoMZ62IxGFHIAaSk5vUtkLcHU8bg1Aqcb7zKxN
	 Kel/v3STUBKeFsdo8FJMgEyCSPA5wFooOag3kDgonmjHuxxDWzYfNzZNpIFbgMHsHDHRe
	 mrpXZ+EkmV/3Ei9VXiAcJBkf4hjKn4Nmg7yw4+YZzqGf0+1CoHWb4bb480VAa2bT3x243
	 rj4+KXK0/M5C6S7TLeHIVm+cQxmKqif+y+an4yBMpo/pdgfwxGh2L4JJwHOpU6G+Y1KjE
	 3nvPnTdwkd1yU7Txqf9c8GKDcu417MK0CxZQ6xW64ZH4XHTHtnuQUMa5GiI+/ckmtTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z8UfDk4OtjCNFCUrAbupGWlMXNHMe1BlhLEHbeS4Bjk=;
	b=wwrin3uuphkLGMfGFtRIdp/+mIBQVTavPVogjcKrelmKNZSK4cRAJ/lBKVPgIWwfdKFK
	 aJyYM36zayLjUgfijDLycAEFe/iQDOqE6TXf2XdIciVvAc4aJQsIUhqYV/m1I9FvIrYCY
	 9fGiQl/vSFpunQrGe1c8VDeG/UbANPSzw3vNlBqPDIiqeralcy8RPpDzBI2TEDyqRlYYD
	 Qeyj/Cdsh9au8cqcOIhEFWm4l0/v6PUOqjWxRD6U5iGxVCBcKYK/KZeuk2YVsYyovVI9t
	 x1JRyd/UbpqqjoQ5kH3S7ncVoFkFVokqcKaR3g8O84XiU3ySrWfSv2KZ1oUl0Jpz0oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQr3ycA1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4E606A31A
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JQr3ycA1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE121F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486310;
	bh=z8UfDk4OtjCNFCUrAbupGWlMXNHMe1BlhLEHbeS4Bjk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JQr3ycA1rcuWqXRgEkjqWCEn8D2nzl7e75ksvSzcxfUvFjiYE6EnbgCoGa3qeer1n
	 8m+45ez+PqOLfwajsa6wK3ctXjorzmaN0RCxTdsIa4bAOgV7zOdunY0KsR4iVGTEdD
	 V9AzxBkok1VJL7GaLSSO0z//xtatxTO6JGaRtR2Jyu4LL1JV/9izrzhwMxNFiFvy8U
	 fTpfaWrMTiOfu0w+LI3uZ1ZRDPj35gnWiDacwLhVZm7c7A9yGmz0zQH0Fco5GEArGA
	 GOvReZxt8fw5T3NvkD7M4AjRT0OYeDhml1HdItZB/KBLx/tPWQ3wzJWuoraLh5IFdM
	 SHb2eO55FTQBQ==
Message-ID: <sashiko-outbox-178637@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:51:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> buffer location through setup_data, not through the device tree, so the
> buffer is never found and the IMA measurement list is not carried over
> across kexec.
>=20
> Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> and select it for the architectures that pass the IMA buffer location
> through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> powerpc and riscv). Build the device tree implementation of
> ima_get/free_kexec_buffer() only if the new option is enabled.
>=20
> Select the new option also on LoongArch, to preserve the current behavior
> and avoid a link failure. LoongArch does not pass the buffer location to
> the next kernel yet; this will be addressed separately.
>=20
> Finally, don't select it for x86, and use x86's own setup_data-based
> implementation regardless of CONFIG_OF_FLATTREE.
>=20
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kex=
ec")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020083727.1906=
495-1-roberto.sassu@huaweicloud.com?part=3D1

