Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674805;
	b=aq2oIH4mYqJ25vJmLmUrzjJgI2zy5Z02H0gLWzpCqNRkq7nvJG8f/FtqAjkBzQP8sb4C
	 kTTZWocwS0eq/vw4oHoE47rdnACddx9aTSsyblHlL4MKTk5B9OLPrNoy9km0veLv3CL5K
	 8zsvKosuz20ePh9fQzyDNhkDFnkPJ4a/m+l0Ei4hHKLsjiNBCkttbaDOF0kQvwPcY0skH
	 q+/vKI0TiUmX0IqaEbwW8IPfjvTzRbqYh/weImzKGMuDhSAImbOm0ZP+GSN8Gt9+4EakF
	 ikB06VFQzJOtC/MNiGvVwGyH2nhpehgotPY6ejEXZVVZWyQa458GGkZjo9VP/cfkwsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YpF1ZvX3jdIyA/DKVNZ+ox27e7ik4KjNO9dDCTrAK2A=;
	b=vqLHTyHp9Z8/JJpvXhbsjEK7ZWDVUFs704ukOri0AO0Lt3i4fEej7Y19m+pg+1MQSg1v
	 WKa5Z16Th95J20a7W2oSt0KwCVD3YykMwo5vV6qT5KSX4nFFmSWO++HHg+twIwlCUUXGo
	 OQE4wYzYdbSGWaSl+xmVjG6ltgzoUjnvHy8V4p4w6sGHvhJ80QeXA0eOMdMiR4/eJhY1l
	 Wb7dpvkjxCtf1wZLUwUHICaBfbpbzAAL2D6evx63T8bGA7VAWYK7bcb/5tH463Cm/cI8a
	 dJQgLSNm1hCoyUnoXn9iBHtw9mK1HT4Drt2WvTZ53Oxwy6fh+RSIKsMhZESGw3Qf6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aITTms/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2005606A330
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aITTms/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249571F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674805;
	bh=YpF1ZvX3jdIyA/DKVNZ+ox27e7ik4KjNO9dDCTrAK2A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aITTms/Hm5uzLy8mIinFwNx3qD7xKpzIfHKlEljdWM97JHiIe7utDA+PuFyd+8/8j
	 nRGdSqaAJso9D6nizYonZKainTltN0Sknrry+4BcUFb5Q/AuMUAtyLY8RCur2QpOuY
	 Ed+T2Pk2MjKsn4ayNZu4yaGMP4U0WGKUPNKiME7293t7Wmcukb/9Jsp3uUCsmklioB
	 KL3L+gowOwESIMz0AJV+XVv0faa9XfOdaBiJUwjXHD8K5YPfDsCvlyf14v67k/YQT4
	 dB7WuNqTvp7ds7z6Mm1oBh8W2ulsyE2s3i/ZCpEMEibhXATUb+HLw6pnT2RHNmOwUF
	 sTxVXA+COSCHg==
Message-ID: <sashiko-outbox-214784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/6] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114164139.429814-5-jarkko@kernel.org>
References: <20261114164139.429814-1-jarkko@kernel.org>
 <20261114164139.429814-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:46:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Ignat Korchagin <ignat@linux.win>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114164139.4298=
14-1-jarkko@kernel.org?part=3D4

