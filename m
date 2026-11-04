Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761388;
	b=JnyKO9CqYrmrbTfLwLQmsHvHFTbh/+ML867pPNNCMXkDjmZjfoS54mKc3saIQ0+BzDvO
	 mYyo7BRHkcDAxEf5XDk5uwL8W0Z9YT/8i5X5GAslCRQAC13njlLg3BkI/QrVjUtHDSBpn
	 +24JfSMooOsdinmstAmaP3kpIJps8UgSWAGWP9Gdu6IpKhSfWH1JTFRKeaTZeZaHRYinn
	 FyrGpGqhU3kmnrOA/ys1HrR+kO/hKnIRBieXtTG17cbELi6mHBDfJwBXclTrEZSgyfmgd
	 1WpqtY/Xe0W46lcpbSwHlkkcgR8d3bFgkwJTIBmyOT+xMViKzelQAki7ScPkd1ydacw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8XaulE9s3ZauRmkZWtTmOCdvfrOe6dwkeKOVkgEyRdw=;
	b=HO9pR2OMzm2FaBBwWEDDD0ErT7yqckA5msczEIZlBZvOFHL9gqm8Fntt0eVfFeOKfukg
	 Ixx+ApGRxQ3Ep2AER4K8glURdOZcg8qJK5KKKORLL9lKxozN3ubw7yWho1x2NSIdUoAdG
	 XACGO2uj8eLytJjM+cj7YQpZfsMXAbm7YhUu0rdj9rV7AQWR7ycHfOc6OxkMAZICBsJGC
	 s1JdsKyaFsj4HHzXbvNKJdLu7LLXCGDEyqikoCKGdyv8+AoXbRQFNt9ZKfK8Iwn6gtoR7
	 1f48NSevAmy1oo3rrqQ0N4HkjRe1JsLS033MU9wLApHVpXB7ISBYyoB2ppRSWeCUXqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lh4oDk4U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648BA606A337
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lh4oDk4U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DC91F00A17
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761388;
	bh=8XaulE9s3ZauRmkZWtTmOCdvfrOe6dwkeKOVkgEyRdw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lh4oDk4UQOoV/RR3KDWLrhz9Kf2Bsp8pH7d7uHEVjX5ZMaNgmFN3135BSZUpOpC3v
	 UHCjwXKku+TjNRYbFCuSuISTPjIrHEERGtMTUuIfAHFR180v9OyQoBegAWx4ybJcLN
	 xJiLp1Bl4AsG1H4meuTnpXH6uS3fKj6B2j9GS/U6/2n9qDxD6JaaB8mcDA+RTa2mqh
	 yc+Ne5vx4O5Uob2ACBvltb3nZUiKkJqLP08BuVGYCAUXOa75ofS983os+dQkTqgAn1
	 txmBQ4am2TTjhHkhG6ZedPuQ8AJO96PO8v+N0HVvTZrO27JI0OSkCL/i8nBMngX2c0
	 wVe5c24QgiBNw==
Message-ID: <sashiko-outbox-196572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/11] KEYS: trusted: TEE: Synchronize session
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-9-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-9-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Even with sysfs bind attributes suppressed on trusted_key_driver, the
> parent TEE device can still remove trusted_key_device while live trusted
> keys keep trusted.ko loaded, and init_trusted() updated static calls
> only after backend init() had already registered key_type_trusted.
>=20
> Update the static calls before invoking backend init() and reset them on
> failure. In the TEE backend, guard session context state with a mutex,
> publish pvt_data.dev before registering key_type_trusted, sanitize
> pvt_data on probe failure and remove, and reject seal/unseal/get_random
> with -ENODEV when no active TEE session is bound.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D8

