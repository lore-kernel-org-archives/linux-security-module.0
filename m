Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292409;
	b=arYNyXVRRWTkASCZrLV4f0uBWykPbZdZOvwumr3ZlIu8iTyScVD65QzU1annFi7suoBW
	 0VUqyR5D7Uv2Cn6+t+g0fbmLTS7rU6ltujnzCj3SicNoOdi5TxIXjAm2PJtvWFnSGnwkr
	 ajyiL81wop+uPR8y0Pk7x5GvluTPbcesAlgEhnTplnWfzTihka4nlFZe1jWCr883ZGvVo
	 g82c1R/V4/KmGXUpArByYWbJqqmfWP23PFLCaSYsUiARv/K94WzX3Au8Zibj/lfrM+9HD
	 GpXlENADW9Oga+V1+rhUzkuUEwsFE7q+eqD8RhOMUimw9Brutw38zrLxMH04kB/c3oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292409;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HZXRBtphFDecSh5B4/oWsb+VjZr5QY5+KjNgdRDGNtQ=;
	b=BZyBRb1TbrfapQZZaHERmrDihlJbQP0tItxTs9aosYLSsDRxOokrgU90gU0KUgHi/GXX
	 Jn8Ocby7lFqn/Jje7N8jL0ULMIuXKvmepYBpOHu1e8y9LObOfIe2iz8QNh1eE1cgi9eVU
	 HOJxAyTgnvUIuw3hqGbgEBlwd94BvxarSb2xNt9UDEsxCMpj2UEKrWhjXaY/abYSOMXO+
	 F/hWCjX3j4hRPNuLzlmOhiie4vnGjGAvGJWacgxgd5gYEiWbgjHbwXZUE1y1L1j7LKgXj
	 mxmE/E20Rx54OJKlcXCu5saKmsdBbwgJWAoir2Q7f2QE4CpgdMrRLLnjE+YpQCJn9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fONZQIkr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A13606A333
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fONZQIkr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96C1F01829
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292409;
	bh=HZXRBtphFDecSh5B4/oWsb+VjZr5QY5+KjNgdRDGNtQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fONZQIkrWSRl5K1y9tG0LnfY0Axt51g/hMdOgceS5bIqnBIecqtD1OuxkDtF399T6
	 aguFS+6fURRVyFmnV6hiTsX4LkSKnZlKBhg6H4bAjSslGvwHQvr3gk1X2jHKzYXYXv
	 WqtSg3SNlL+PzbL/HoHWRw6RuEaqcD4MOOzFwtdrZynvgi02fTxWiHIsJ0NfiZ7YhS
	 7PM6hIa7bdgSIzwF5XsaXNbWyduRvyDqOOfkSsp9zj3EEffe5BGEPRRCMd+O/Ux6ZX
	 BNO+xADwx3PyrgAKzphBnvJdr4lGPgztU7cv8nMYYxs/1xXyH2Vv6mYTeaQpVFbJqq
	 8hjK3FpWTFPWA==
Message-ID: <sashiko-outbox-189673@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] selftests/bpf: add verifier tests for the
 namespace LSM hooks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-3-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-3-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:46:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add a test kfunc that takes a trusted struct ns_common and check that:
>=20
> - namespace_init and namespace_free arguments can't be passed to it
>=20
> - namespace_install arguments can
>=20
> The test fails if namespace_init and namespace_free are treated as
> trusted.
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D3

