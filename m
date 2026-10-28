Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194933;
	b=LStztDDFHDNfCwuoEPk2y6DbpNL3UybU5HodmhiZgW3gC8IRtJR123wTllMcK3j8K4JD
	 jV+UfZTigLuFZ4fJjWgEWMX5Gh8yxhXyK4F3WFbYf+cOzGWAXO7RdSssnhFLrcldINlD9
	 km3GjCgm8QwrTdC/YEje7fu3T7fPd8xWmCmPGqdBGJF9IdQ3mGnhf07fJzE0uCxdFv6lT
	 P8hP2HfxLJgR8jc0TINnqBDqHGgIk6ENmexfMWxheBYMd+XLGGxh9ROm4UH/LhGCber9D
	 hzlba5phY5JxPl6L4J9VjsStSP2mOP4ETVIwWdZbWn1V7p8r3NkDzlsRR0NDfO6oOEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/jt1h+2EJlePaviTGaOhElhEOFBCp0nr+DP8msw7uBM=;
	b=pKM4VnukQScCdSSk6830kic2OGmlc2nBhec4UsD4WbqTIod/Y9gcrRuQ3TMn3UQ2c9zf
	 EUL+d+Vqm6CUUvzP24cM9gc+1MBlHRJ4BvKPSZx6M3qledjGB2oDEWCRYVGM8XT7B97qP
	 xVHiyELVZiNoADl0huRoliFCNhl2m4zl3q130Fug7Fok4K+5fcDZvOopjYEyI6HilBWvO
	 Aw4OMoAJQZWnM5PL4BICm2bXUBDb2U9u+JOw5AhylVNJ3XacjBmczpM65T5t0I/rkzfdu
	 N/+w/rSAIRR2Tbum0ps+zXbNUuHRmTCksKOVjT1r1quVI2u9IL/T7SKSUIA+p6MCPEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwYA2fTc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433E606A31E
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwYA2fTc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE61F01829
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793194933;
	bh=/jt1h+2EJlePaviTGaOhElhEOFBCp0nr+DP8msw7uBM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gwYA2fTcItuhXsablxfPNdkmKZoLEK6VDtepkuZDA9vTJlpThjrHipCUw2aLTzgBS
	 Kh1o5MrSSY8yz/l0IvM89Yy6f8GMuHopwc7g3+0hzVXoVSLT9i7T7xfay1iJ/KYoJn
	 1jDwlU8Ixg5ZLHx4rkKJclh321BvHGA8ACKtVJMS4A7xYIRvPUJUnC7HRLljMnK3sU
	 UQF9qdUBXC9rWTr7WlP7WS3v48T0vEuOj5Abp5D64GjdCkpGiWpz1uPH+GR+b5Que+
	 EGcqroyeAfncov/EhqpiynQkAIiLU7chjHYi164ygDr74xKEsjyCvScoDf+oiOyp3W
	 BLYOywF/CECEQ==
Message-ID: <sashiko-outbox-187936@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/6] security: kap: add the LSM ID and internal
 headers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028133335.75899-3-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
 <20261028133335.75899-3-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:42:12 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Reserve an LSM ID for KAP and add the declarations its files share.
>=20
> The ID is the next free value in the target tree. It is provisional
> and is for the LSM maintainers to confirm.
>=20
> Assisted-by: Claude
> Co-developed-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
> Assisted-by: Codex
> Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028133335.7589=
9-1-ketan@armoriq.io?part=3D2

