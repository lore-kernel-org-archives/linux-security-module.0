Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795498453;
	b=iTmMSrGJG/heDQp5U5rI60irofUgeJvYbdHrw16+9jtWIQqInzU/nzKqXlJUgGGa6FJr
	 1452TAramAnoOQ8k0KmdjkORqBAav8C7QieGuT0SiToS2GdbiwAq1Z/G5pAAxS13O/Oll
	 lVB5599LxJJ5a91GGobZxqNM7cymCB46SRznKhWZB7R5WWVadvdsluFHL48sRGD+N5tsj
	 EPYUWwy6EqIIrxV8k7JGCHRNUl2aunjF7dxtYrDrOQfY7O6tXn4ayiM63W2dRXrrzbbEn
	 o0wxyufo6kWVawwrKAsEmL0WXwZaIB77Yalrpe2TJwJN1uyIP+1VVYlMVRQxmAsuRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795498453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N/p0tB7TyM6GON3hAGtep/qQQCnrVRLFrCKNNFS0ilY=;
	b=ETsLIriJELuJkE34yZbQzrGTxYT/8K+7TE67F2OiEr1upeulATA4CYwy8+HgFjWAk8GS
	 i+c3VOPRcvn9r6IEhsIZuLm/D9PRHjklK+FFAAg8Dfth21der14lXC3EcAokiEveZ9a5o
	 /eo/Y7hJXsuRiDSuUzILhbO83QmGENAFMcboidClzuqH6XIv/Oxc6g+vtiUC+LI4p91Jc
	 WN7ofa0jWGTfU/mWjZSVRNH5s+IZ3F8ex3Sc08m9tchAt3qt3PwB1SrwdAGoT9MHJ8ICG
	 LVmGwO1w0oYQnhBLnZvX7c2Vw72wVplmAwvtheEctU0UtwWwTvj6La59VS5RHYpKswQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyOL3yjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92075606A31E
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyOL3yjT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5711F000CA
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795498452;
	bh=N/p0tB7TyM6GON3hAGtep/qQQCnrVRLFrCKNNFS0ilY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gyOL3yjTCX/lSbEpuPNNEea6CR3uFW6Qz8FfKd6Z5C6LjcIdyZ5engxxbG6okBn7s
	 XBX+NDWv4eITzhWg0+jMCrZT3sWka15tSkFkCorVmvVBLLDtXK8Y4Du6Z3Snn9bI1Y
	 ao1+RHuAIB6eI2bAYD/KopLY6lG2aj8AVmptutH7kLPgTvwHoqeXJPdXlIxfZEPWg0
	 tUP2QPtiHXZDHLnOJ2Z2Bfv4nJNU6lGo7E7paK0+X/+0Bq7kOMyJNYhBDbHeYH1IyD
	 /YpZIX1AYa7BZRi54UngVY8Xg7CcvObw1X0RS29vRo23BUk5D73qhg8TtpJDJwY1GO
	 5bWNAyAadIkCQ==
Message-ID: <sashiko-outbox-230552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Use kfree_sensitive() in keyctl_pkey_e_d_s()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261124052849.940005-1-maguicai@kylinos.cn>
References: <20261124052849.940005-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 05:34:11 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_e_d_s() frees the temporary 'in' and 'out' buffers with
> kfree(). For encrypt, decrypt and sign operations these buffers hold
> plaintext or other sensitive data.
>=20
> Free them with kfree_sensitive() instead.
>=20
> Closes: https://sashiko.dev/#/bug/linux-4199b169-0b8d-4055-9a71-6b5b79e38=
eb3
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guicai Ma <maguicai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124052849.9400=
05-1-maguicai@kylinos.cn?part=3D1
