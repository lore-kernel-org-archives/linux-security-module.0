Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761384;
	b=M4IEw2iWjeFjkzNjIPpJkhEGX+B27mAPmBmlLM+wmDUdpjD8Z7a7E9htLUzYjCzz/z1e
	 fS+dbvMiJ9oHNbyp7AdJhtfj9fAw6eL7cpDeLfdPYYlGvFFoL1pBHQKSIDZSlXqYc+tfU
	 REdyjSf5VVijdjvPG4rj5OmVgi4V0CEdS42pC447RfHVe/R4FywRhook+tjhThVn6fzdK
	 N5JA01mtwWedfHNPMnSA7wRd2Z/H38qPMp099KbPDxVhSpIr/vk78eFULxAs0QVOSWkF9
	 Ntlx8+abf2PNoVbU3dantU32F8KjzjfsDWTDOrFZ4D9NmDOVwzWmsqy28Q/xqKUuHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761384;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Coa/uD+9eVckAHBubb/tfcOKWGfP8zPPl6V3D63SCo=;
	b=gGf7ti63qlrEt9fgTegwSrn5Nj2ETRojqo/M2vgUt9gln+kTndNWKPL8v8NkXL6gxLJZ
	 OvbpmQM8Rer5BEmrjI27HDd+C01cPsMxKKIvCT2Vn1lCxibXSH6M2qRp9e+AefIPgl6oG
	 39UirWxLVATc0dGqUoUPngAUN0Gwoi/3dTvqeOZals4TPdcmxmc0JOi9oHhupwy1pHcz1
	 ncUIEJYyKV9ojIIouUSIxNzXl8wWzSlSz3rxANgSAuNFJoFf8o5vHxB5iQHHq0LUpEA+7
	 WGl9E3uKsEUCmbd3hMHMQqhe9dBSBFh6i4RFTnJmLsz26umv+0ysKhsvOylm+nIHugA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exhHoOmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDD606A31B
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exhHoOmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847D01F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761383;
	bh=+Coa/uD+9eVckAHBubb/tfcOKWGfP8zPPl6V3D63SCo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=exhHoOmzipD1hsCbBaEKLe9S17pNNEGrPAwbEhc9Mv27yL7c1xeK6Lhxwh/ibfIKS
	 RjsUY/KnrqtK2VibuJlP7/Mz2QokbW1K4DfKIAO51Tx1FbwJDHEbgM7kpJy0ejhzso
	 m7P/s1pqi7rLMdVa+HAjI4ixwdZCrsXXiz/39IN31TyyGzH0E3UPzagbAIwrUdBoc9
	 FsdvqMn/8IM26SXs4x+JftSkj2dPUu9rN8mB2fB3lKc4liWxVwQD+dw37SbL5zx8q3
	 8/ctFMtJHaMWcex6JWMMn6yFy06IxPjVm+MV31Tpu4T3GgzjPRMYBhpNAG4RQORXIP
	 atIYXO3wOWQvA==
Message-ID: <sashiko-outbox-196566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().
>=20
> Cc: stable@vger.kernel.org # v6.12+
> Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D2

