Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426685;
	b=tfZKt4js7e8jrZL9zT6/vHkzSn2zBv3c8l1p512zQwS25g1fj18DDk6iFESIIZyfEjUe
	 /RKFisU55zgdmVBlthjQrrhI0Oq5RNe1svtHmz0sBeLYUu8Clq5p1VMdCLzRdCoMMvWlM
	 JdZWsxvWmdHqhnCBiMkD4lIv8RfbSaDFgdbVn95lmWBKhiLm0EddtzbzxX+WNld8vZTWv
	 MIdJEii13xd9OLbJalrEeYKY5cBmiE4ouNvexSXMe7OkJNZZRra9EO1Onc18kG2rrtvYm
	 0ALspOSxygneM3TobDEwCgZLgacrymZBqw94zFnUVgIRgtIXwLc8rxu/P+GrsqhnS1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o5XlxoOnfVl6/8rb/ao2q/DvqsXnpfovB72ekxSjo5U=;
	b=rUMNYJ9EGZUr1eJenHoCmJ0+0fKdOaQ99Ef0rkP28uvD63Jd24pLqUWwj7MPZbNyf+XM
	 vMRgpvco1WAiDQHMF70Yig58b0bSdgKjEpLJPgBbncIFq62f2mC7ol91rwN/5OzGtnm6N
	 RcpgC4Rt4E3b1ymPkF1Y6rsAQbRPUiGukc1MU8QzOY7hgofYYavr1XQ/9VkjPPegfv/uU
	 x07xIxivXR7rYSR4IDzdWzLUqqZhpKjK+Ray7apmRTNbUIr6J8CWp8McOnHiwRHHporKL
	 rKgpHzhB81VpPhakT14TSro6Bj4rNzdWBEDa5AQpZ5gb4X6c9V7/pXt/m6vP6soGtUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFseXqbQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBED960A260B
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFseXqbQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6D81F01809
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426684;
	bh=o5XlxoOnfVl6/8rb/ao2q/DvqsXnpfovB72ekxSjo5U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IFseXqbQv2wAEg9zfzPd5DwgJdFf6tL59LtI0e/SCc5dK2Fn9yI1iP7FYhuHDiUK/
	 wbKIGU17BTso0BCsdj8xsWF5r0pECxpmByrbIe8pP5hYbKmWFnGIFUgTfTiL4WrY5x
	 Ueq01r6r7btHwMmDVGcyHdRt8fRXgAKLaLnlthEBuQw0F5Rn+z7Z2Ob6vSN3iUHyvO
	 5qtg68AZhS5MSPaf8ApY4Y+KWCQFXnDV23D/n8CtDzqaztl681ngDOPauYLXlV2M82
	 9ayOJ2btkbMjBGXlAQufpQSZMp52iEjRUDItGGPB4/EVFMKhmHaAEINdP7o4UwDYU6
	 dvcUf+rGe7VYA==
Message-ID: <sashiko-outbox-177858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KEYS: Reject keyring creation with overridden
 credentials
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019145624.309790-2-jarkko@kernel.org>
References: <20261019145624.309790-1-jarkko@kernel.org>
 <20261019145624.309790-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:18:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> If the current task is running with overridden credentials calling
> commit_creds() is forbidden and triggers a BUG_ON().
>=20
> Reject keyring creation with -EPERM when credentials are overridden.
>=20
> Cc: stable@vger.kernel.org # v5.10+
> Suggested-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=3DM--UBauTm8sJuc+Z=
bhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019145624.3097=
90-1-jarkko@kernel.org?part=3D2

