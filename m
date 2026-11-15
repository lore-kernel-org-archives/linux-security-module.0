Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794783054;
	b=4p5a/nrUIAc1pI5NXTX00RPY28OGiqCuLCmTuIGg4qpdnLdhSq7A13LZS19m8ecB0joZ
	 aCF22lczd/5x2mPFAcJFJMfYODu8jXucMN5ex8YLypzlDxjnU2qQjQYUU08LWoVry/dSn
	 HSQhRgBeoLubSALdahT9CaN/0h9p8z16iI0g2AMMPPnz+c8MNSg7IrlG+4osSCfUKr5++
	 iwFilZhxDflUuFbJpWT2cw4sZ4GZaWh+jYcQCKJcySRgU6HSjhSshGtzD8EfhVtT3n51i
	 b28mj3LvpsTMZmloXLtlO+7qFOMIwUXaIjyuxBRFfCsXI/jc8+4LxsKXt+QR3bFuQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794783054;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eWQXYXpR+P5OJd+7FRK1Yagb4UxHShPE/O/omucHSyg=;
	b=rG9aD0jFDkJiD9MTJDVNv7iWwbmKe4j9KcmvIquqkupUNMcm1mqCai+RvOpZvjPh3/Ar
	 /CtP3Ra9s9+5UmsQ02a7TugKUt6npj+kYpVa54pRAGsWwdvnUmSEQJrJcE5Ma7XTPBIFy
	 q28RH4zFx/TbjHNpFdrfJhc7AAIHjn1bbuUbwhk76sUN6PG5qmy5m8ueRnUxmV0Nrxp6o
	 O5NVCLLmgUCfcAbm1/5Q167fHrVgvLqYLI2ohfsZitNW+85WQgdJF2CZqcJeFESUpSpKi
	 XBMueGlMbtyf5sDEPoik98Gs6OAQdsJjO0It+MnHpOpLL5URChohJmxypFdPdrH5VGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO8ws6MN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E7606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SO8ws6MN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D0A1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 22:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794783054;
	bh=eWQXYXpR+P5OJd+7FRK1Yagb4UxHShPE/O/omucHSyg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SO8ws6MNOtZp68g65VX+thW8RRq6+pyRFNcrAUdF0uXJksp0G29EUVWmPMRX1VV/u
	 cZn5QGiaAmcZkaLwta3dbwuuzRwDwbvVm4y2CCSxtCD3Q0gxtsauIypzTdOkqenaHJ
	 xPa42hyId0lNWId5gPBNZKQkjDo7ir8aQrClbuiA7XeMpvMEOQ0R53s4KXm6+aDLpf
	 dHdJm+u5cDHvNbcllLN9ySRhJk/NuoeJNtTNyFPkDXSDRhUTP4ai2PjRR+ARi9ZWCJ
	 UrlcUsko4CbOunn5Ai/zB8gET6VDz6dcbkVhxqxMs6EVeOEHKWH6PTtwsJhBi4mBm5
	 9DScAH1EqDpOg==
Message-ID: <sashiko-outbox-215888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KEYS: trusted: Remove dead branch from
 tpm2_unseal_cmd
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115224722.1450498-4-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
 <20261115224722.1450498-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 22:50:53 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
> set up either password or HMAC session.
>=20
> Remove the branch in tpm2_unseal_cmd() conditionally setting
> TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
> run-time, and thus does not cause regressions.
>=20
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115224722.1450=
498-1-jarkko@kernel.org?part=3D3

