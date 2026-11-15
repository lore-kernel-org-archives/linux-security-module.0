Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785756;
	b=c6oKUy8V2rmXkqCCSMnPi1EW8Bcn5bg1v1TI9nBLJjJQyF9hRifoER6+lmrqTVM6jUgE
	 MBrCZCPE85C2u/UgypZstKkSbYP2n/MrP5xuUURvmlJHi0v6ob3Q0JapW41skdSi11giJ
	 GUH3SKyQx8fGAF0iaIiv3EiB/dw3UTF2T0HSc1QObjqp4b71gIXsmHuSZ4UNDBuss6tYn
	 Ipi7GiV0vhufa4fehN93tXNSKPzj4NSRrEWGzRQfXzcAqSt6kTaSCMF0t8r6JMw2g8cxz
	 FgUKekrux7EftV58jcmD6QlO9BhhQhEkUshoNVcT1QOLTurWPlSH5L4fhTjsQvmEYQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785756;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zOZSExS6D99A+mRC67Izr+rK8eU49523Qp86bvP2s5M=;
	b=AnIMZXU3ZP6d95Kavqe5hbf8CX99ZuCoqSF7cTJNRRZP0JjIZNK7phIDhbKf4nuOZfaV
	 VPjv9GVQkcIbtwKXzavV8el32mZ4SgqEHzsEam8x2fmXrKUGcw87UPSzDCM01B+RN38Tg
	 T7xDXiA7NUa63Raj06PZGh9FgZwhWOSSP+JksTE89EZrpv7zAIkmf5UgfQ8Ma6ElixunY
	 4DXME3N7sVV/Pt091G/aUmI+CayMmG3niTjf+xURLVXr/57nU3ClOVUquuQu0XJvvtKbM
	 3TjZwy+6ZEffIhR9z+DxB4pOIaBFvxuRbjMM71vaUarj3XMg+Z0A+IgTo9iWFtR2HTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YLkJ/bOD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657D606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YLkJ/bOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E5F1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785756;
	bh=zOZSExS6D99A+mRC67Izr+rK8eU49523Qp86bvP2s5M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YLkJ/bODKfw4/0jyRiiaOfhLFabAu0hUldvzb7CIqbnhyzzLOBXh3oNXCh6QDpGpH
	 LvqwmiBACDXqnu7VGShT67C5DWG3LqGEMgHNOnk/09u9tZmsOo06b8DSfcXPw6dyKV
	 wmilIEWlfB4tjsTyNgIiuGblG2eLFd98C2/e4qA/XhyNMITdo8kKZjG7NqMG88fX2g
	 9iuZ0v1AxOgEgBjREuiHMldsemh+suQptnKhaT1Fn1JUGpCaRFw3W7kCxcV9+Q8J+y
	 tWoj3sXlHTgUOCsTlJoYQGwDsZJ3rNhHjET5ZMcXeJ2mJJDugEU12iD2v3lg3P3S6A
	 32IhMS0RW3Z9g==
Message-ID: <sashiko-outbox-215905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] tpm2-sessions: Drop TPM2_NAME_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115233156.1485238-2-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <20261115233156.1485238-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 23:35:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
> were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
> convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
> redundant TPM2_NAME_SIZE definition.
>=20
> Cc: stable@vger.kernel.org # v7.3+
> Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the comman=
d header")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115233156.1485=
238-1-jarkko@kernel.org?part=3D1

