Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761389;
	b=uOV+T9bIiswGto0agelQRVSN0b3esAQChiKoB80RLTSlE6dP445+rh/E55XgJdjsgfvJ
	 sjCednHLNMcbPKMvyzoB8gS5pW07Otn47BWQAjGN69gyReD5rc2IzT+kzcAw4sc4qZVfz
	 dmtgfKlynrmN/a2NY8vcvk2h0EjuCegOZStNSLZYALMLSmoQuiRqIgVBE+dWy2zfm2GIC
	 BH1K/nkvSucuqe9O7Rs7+Nrp4ubbD9qFta9fQrUTBE7wBzoWUWuIZc8S1ShnRvq6qi6HQ
	 fPMqi8WVWrBiNvAdKsCgHNQCf79iObD2hn2aNhmX9ZG7n4jkktxQjpslfmk/1Og4LcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761389;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e34MkMqCFuc8CrlskFvztOgMsd0c7jsQuERfMla1tcE=;
	b=Q4y4dWuSp0wE/TPcMaxoYTOlIsEzgh/CF5kTh8ehi/GGDFzqba+yQYLKNuBlOnql5QQa
	 rSo+pUrGyWRUXE+Kb+kDIqp6X8yNTCAZXqO61/Kz2Kzp3qb6y0cGGZE3LLEh3T1nzI3w2
	 kbIYxYrNCmV9vGw09OGbcLFG4McF9uPRa8w7nHyxCqcftjLwiZG5/YSVMoGYAlnF67oIc
	 fYA5P9Ukrj8aTN5ly7schhfL0VcH9fi5pRkfJvDIzvbnbTtDYctKbtDLXlmnJR/JgmVIn
	 wB0xVTyiYBJBYPIVIMMX6inDh5IvuLkwySSt3oRCo5HU7aMc9EReCdBQGpX5S2W/yzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpdsscp0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBC606D814
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpdsscp0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D531F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761388;
	bh=e34MkMqCFuc8CrlskFvztOgMsd0c7jsQuERfMla1tcE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cpdsscp0vPvBKk5WNdZIc+Wx1MfVsAd5kE3Ka1R1nwMUpGsrWI5g+GPtJoMHVY1Yk
	 m52Q1Usxv/N57LjUZ4KCNb4/ZLzaV4A4OTJVwkwsD9OMZbmN+F6u4JfhDJ1DUCNRu0
	 nnfSSZPmxC7t7RjEho0bJEfNEIHobM1AYU2dvlffJ6abFUvuWiOzZajqcP+WCAIxXQ
	 +ONivB+eGIW0wIvGPmUpxBGfy8K1pybWbzgKKofafhtKrG81je/bYvdV25lWE5g5tE
	 p8bl7+4CKfS6aFC4WAhiKb3wJYZiSrW/RAvzesvTI6m/Vvik01FYONEvr8ib9wtpFz
	 Mi9ve6eax34Sw==
Message-ID: <sashiko-outbox-196573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 09/11] KEYS: Pin the backing kernel module for a
 key type
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-10-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:08 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add the owner field (populated with THIS_MODULE) to struct key_type.
>=20
> Pin the module in key_alloc() and keyring_restrict(), and release it in
> key_gc_unused_keys() and keyring_destroy(), which are wires to the keys
> and restrictions.
>=20
> Reject module owners still in MODULE_STATE_COMING so that the failed
> module_init() paths cannot leave behind referenced keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D9

