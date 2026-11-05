Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890483;
	b=iBhPcGVHszBiTKwxLYUoHqko+aHbCRoc/W3i6rBpUfJnQuuQv0XOxP97TBQKcgnZeHLg
	 idpXSOcZ14vkt6URQKmV6511AKReE2jnLBlPTMuGnsdsgNLpEp9kihsJTkkZfEr+gtmky
	 Rvx8vEymdy/TM6BApDJAkWwu9I+UCxuN1won+c7OQYx4GRmwnI34kjSn5NvsLH64uG24F
	 japXH3P6/8RGbKCdSa/GxuANZHKejDXMp6NBS7clHVi4sS8hA4+kkY6vFpxU86OPzKNwR
	 Pb9W5DNi4eD1aeS6fgI5F7yC06/4/MnFatW7s21oGOQ8hYqW3V0zNe0ZngADoIRP3cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vMg+xGDCIGOm3Y+GE9bqcL7lSc6/F/J4YW0KO6Q/Z5E=;
	b=VAVjoftI3LwSODRJktUsSs9Jr5MCn26n8fNpcyQwhtKRGNw//2/mPpbkLX3i0aHIkGG/
	 TQ12Rc7yzFxgB7EadFn9VrIFxRfPgRrAc2EC6gke146NAr3ZBcAE5iwtmZl7F6q4s40Fj
	 qFu/HNmigZXbX980Z4aAjzwVUpUrpriVvvyAlksOeCgiRe/RcSGlSixYhyXbmLzBKzunp
	 cjxOMNwIfwPpgT3EwQqTFDnr9u42Uw80XQslUsinXhHJRGUOtowmNrs/to5LEvay6UyBO
	 Hkxw/YKf3rEpa8EADxTLgIw9ZEQ4wW2be/kCWI9ROy9//ZObeNee8ONTAv48tqnqcAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrfGZmTO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B2606A328
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrfGZmTO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6780F1F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890482;
	bh=vMg+xGDCIGOm3Y+GE9bqcL7lSc6/F/J4YW0KO6Q/Z5E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FrfGZmTON6/JOorQzDnT9EEsyKzKqusmHXkcKUhOhQfEH0ze+Ueh1PnlCZF2LJAoP
	 wlqR5wNjqG3r6ALzbYzDM/15QTvthJkcQkUmrwG/9rF4U6mu85s8AcqA/4CuM8Z7Ox
	 QrLFcx/Dq33+Ml7n6xA3XCTjjuRwN2howP2xbPM3hellSBYHCIlUXEudASqUv3LPJI
	 7b7QgL7c7w5rAD2nKES92HzTth593DwpRd//4cyMq8TsGSAXC8tKN411BBh7qT84ue
	 w8YbwvQFn5y7ePdeTf5aZ6wVfumZbLKQfkKvKLhguaE4SaSwSWeLMZnrZHScso9G00
	 YoEg/UTiuaWdQ==
Message-ID: <sashiko-outbox-199273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] keys/trusted_keys: clear sensitive PKWM buffers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-4-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:54:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The input buffer to PKWM seal and the output buffer from PKWM unseal
> contain plaintext trusted-key payload data. Freeing these buffers with
> kfree(), without wiping the contents, can leave sensitive key material
> in memory.
>=20
> Use kfree_sensitive() to wipe the sensitive key material when freeing
> these buffers.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D3

