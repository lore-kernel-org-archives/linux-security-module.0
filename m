Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630972;
	b=bKRqUK4Ezl/5gFsfJKOYlDLXvlz6r1AB6D3eafQqjfikOV1fthMTRx3WYHj3wGL4Lfug
	 8PHcRne7yKkygqrLr6m0yxpuWN7/WtBeaNJviDoNTDy2o9yJPIf7UiNFVMGZsVd+KrGFB
	 YDC0JiZEYUVoaeCANN85jJHBgxsl5eZrX2I8TN3Ftfu4MPmuGicrHAzmqYeVaUMv2ooPr
	 MUkLoBi559tEzWgHeHAbvdOVjNgeb0mnCO6ZA2C/R4D/vIQZVoKgGxqia8WIgVAviMVlX
	 lPo4gITE6bGuLlwHujl1IxR/ei1+Sua7TkYhFXGoOquwbASKoM5Ogflv1M6zhHswnsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630972;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CkdaZTAVnKyPHtlEDupfRWksI6zQOhWgqaihAEmWjG0=;
	b=AkqBrC+ayMvHPYjbPx+9tUTItuAX/tCaDDrlsAZl+la/maHM8N90Bp0T2AeMLtGlmY+6
	 eRgszz088PwUZWc4vvqLyvBhpVbuZsfrhuUqIqOdBCBFiZf7ysRazB6huANcNi5uCTkAo
	 oGYdvYB/UWkUID4HfmO/Pr+cMOH3pEdMUXMsQy3/i8JjeQPWgBpLRYpnlIcqxWY2SVD1i
	 spvsybfT+16Sksu1ZombZIwc6kI5XmqfByRn/K9NdRkZKdvkeQbANV1r5YMYOnLb7hD3R
	 UV4b+NnermNtI3mhvYF9U6zzgxC8N9lcw5zh1MCvhhjvcW6MJPDArZSfnBL8lfMY0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhCCneDP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0026606A337
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhCCneDP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E601F0093E
	for <linux-security-module@vger.kernel.org>; Wed, 25 Nov 2026 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630972;
	bh=CkdaZTAVnKyPHtlEDupfRWksI6zQOhWgqaihAEmWjG0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=HhCCneDPV1dVhhfit9F1lBQbeYfbxWY42SRWSHFoCq9hMQ7x/WygiS4Bt4htneIlc
	 AzY7jsB/uSLuTMi9BTekJQJi9HZpYi8lBd68ebBIiYZ5FOwhqrGIIVX8js1/h1L9vU
	 nawKi6ZowyzvJNt6tNy0ll8KFkH/LWn/8x6oeX20xBOxOdxMRJyycc+0ZRNZvY2Flk
	 SVpnlSAT7Lrv6lLJpUAmOXdv1qHRp7ldeSNcDojMgInf0e31UH4pItgLCAv9mA38In
	 +KvQmXcGkroJxMPg2oyD3IEbTJ9eY4cvKeKb7FAie98r1kw0P1K0+9JGqHYewUSxsB
	 zW42cmN4iazHw==
Message-ID: <sashiko-outbox-233978@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/9] KEYS: trusted: asymmetric keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261125180616.1854753-1-jarkko@kernel.org>
References: <20261125180616.1854753-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:22:52 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 9-patch series:

- Patches 2-7 and 9: no issues found.
- Patch 1 ("KEYS: Factor out opt-in KEYCTL_PKEY"): 1 potential issue (1
  Medium)
- Patch 8 ("KEYS: trusted: Factor out TPM2 blob loading"): 1 potential
  issue (1 Low)

Detailed reviews have been sent as separate replies to patches 1 and 8.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125180616.1854=
753-1-jarkko@kernel.org
