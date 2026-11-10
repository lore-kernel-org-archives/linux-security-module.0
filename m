Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316375;
	b=Ys5TcpXMIkXbKE6XS4+6lzv+hurRuT0i/fDIZPxE35bOLbvUX1ueBtvg74P2Swb4Jws7
	 EzP0NklnKKSGEF74zjuiepu4xg/RO1ys7B+3w5FihAJe/Socx1wL0oA3b1MiAT+3XLBcB
	 guZ2qBT1PrW5Pl1Oc7DO/dp6vCIzStmbudILfM5NBY+kezXFFUcVuK77G/DrMClRBCn+7
	 KAjKN0DYMVxPsCJn4agnmFUJnvBKgZ/QpWtgVaiccFj4D3BTFqno1iLPOvivIYFLa/IIA
	 wz6698LmxGWTHk9s/QnRhU+HrYvVaK9PP5zT/qGip14SPreQrTY5118z4h4H9ITqIxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yw22XJ+FYiqu582mcWDv5NcRu/A5nz/Y7mvBHX7q6hI=;
	b=4zCPsRz8WRucQwAy7cNx+vJQs3hLL8H00tdM9OH/XxOVZrYlowJnBi50U0pQ2Cc/HVZh
	 O+Tiw9avfuE9zrPWxm1crobcfvm1iaAh5vBYJRuILPSDT4TZNfqSmJ24QDfM0CrRJryoB
	 t9pG9MdicX6GJi5eHk2cUbpGr5NFDxjF7H4E8gtFfzr3jOsbc0z3i3J9myvyvLdKPTiH9
	 Tprgl4PVyJIeU3zIx648efYtgDydGfmZIweLBFWnC1UyHr2l4vmE6iGDxFWXOXKMtoe4C
	 KYI4gqAFA7ZXLWZ1N32j7HXy367VdahCG2S8sD5nwH5ty3lcHpuHFYsNKuwxwh7g42w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fXj1Kd0P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A99606A7CF
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fXj1Kd0P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B91F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316374;
	bh=Yw22XJ+FYiqu582mcWDv5NcRu/A5nz/Y7mvBHX7q6hI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fXj1Kd0PTXZk4BIN44RbcURyUSJtqZTofJXMYq+T5d5CyUNrNniEWv9fah4AgIw13
	 g9ZrcBIuWbVHGaJjNe4Wx2b0VPI8sI7AThoSdqtybDI77nu1nQO1jss06tp5Ks3bLF
	 m2T+vHqhVuFetl4pUmpBeiqkRk+6z/91itwuuzGC/FaFfMqJwYLAV6NvPrjdoAKaWa
	 p08rbw8K+zVVlPFZdAUhyHOXWRZj/oKhBQKbK28rj49btIRsbp9L2YaXeMgotZ+5Bc
	 SuJEeAI168c3umm4mcWYb+tQvKN5wZkXpnXWRHvHC16Aa7autQ2FubBhIJXhQHGo/K
	 yfHULF2npZnxw==
Message-ID: <sashiko-outbox-207103@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 6/8] lockdown: bound the status string with
 scnprintf
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-7-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:12:54 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use scnprintf() instead of sprintf() when composing the lockdown status
> string in lockdown_read().  The current set of levels fits well within the
> 80 byte buffer, but sprintf() provides no protection if more or longer
> labels are added later.  scnprintf() makes the buffer bounds explicit.
>=20
> Store the level label strings in named arrays and point the matching
> lockdown_reasons[] entries at them.  Their sizes are compile-time
> constants, so a BUILD_BUG_ON() can verify that the status buffer is large
> enough for all level labels, their trailing spaces, and the brackets
> around the active one.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D6

