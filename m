Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685319;
	b=5TwP/kL7RJURy/6fg0Z9+iT1taR6HTEG416qZts0hsL6hL3FJSUe91IUDCihpHP4MSB0
	 ZRkl1eaoyWm65i2h6la2wHmE2zYmIvXjMZsZNoC1ywNxK5kR8bmgndCFL4CZ6xIZxw09Z
	 7A/8A+HNSeX/Io0Syolrc2WaiJNg2yABCgpmibmLzcItrKm9zkgMbwR7T/r1RV4771gbE
	 7V85p/OEdI0i7RM3SyBUqa8HfvHGv1LMvX+JNXx1LWvZnW6sjFITniUl3bstC2DbDnkIe
	 Xj4jx0ykqTmT/2x18AHx/NXVRaSvEIMLILSGhEjwxmvHXvds57dkVHvXKrKwqRRZ9Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m2pgFr+82HV6PAjQE1SwSNw5FzL7sFQpfEin8uJqvws=;
	b=FGdb0wI9xMZ63nEVN6bmdr76pHOm2/eyciS7WXzlgNXBAF/6aGzvX9E7AIGgLN1sYXM/
	 KAWsxni6igJeX5OmIuiqWjaU2VmIDmYwhEaf0MHViSVXk42Cf92+4ebhv4Es51W3Y5mAn
	 NjciGQmqcyHZ4gG7z/ZjuTeNKhPj7b3MJ3P88mnI5dF3I3o49swmy0d2pSz/b48WJWJrH
	 cl7sQ9wBl85ECbEPcwlVoBJ9LL9Hj6yNV2sH/08w89NuAW4RlRezbE4wyhEYBuzTKesva
	 ZnenwbKxsp5EquwOxbSMOjMQFgBtd8Lc+jSh2OHUyqzf7dlYVukPrsnEKUDOZZTJtUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJUFNNOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42143606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJUFNNOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE31F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685318;
	bh=m2pgFr+82HV6PAjQE1SwSNw5FzL7sFQpfEin8uJqvws=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JJUFNNOPYQhZ+GkAjnCee8jlCcWNHoSJ11x4GTAbLYHiC5A9NA/IbfhRcKZr6SAVc
	 emE0wkpBSjYYCr8KHYonmBJHof01seT+pQpp1YEBKh9Cas8X9iz8Gu/c8IzuBLLSBl
	 uxEFx0PA5ANpV5wmRaaD2N9SW3yfcV+0+zBvTXvLgEnT71sdh3yPMg3E0i4zYIooq+
	 ZgE5H9NfQkn6LxRoHPzRW1iv/uSW2+84UffX57lG7qADQb3smMcm6VYjfK+cLeNbb+
	 Ri1FbPUu9B/ffTMGeOVPR6+uJ89ShKtCVRQBPdSSv9xg82PFQkLhPBv6UxBfcaPkls
	 B3ajwRXgaGXHw==
Message-ID: <sashiko-outbox-214980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/7] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-6-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:41:58 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D5

