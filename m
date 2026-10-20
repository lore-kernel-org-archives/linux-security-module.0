Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518410;
	b=BiuamIrPt4ed5KXMdeuZVNl0NG1eqU+wqawCZ/g5C6PopnFZn3zbMgPN9zMxIr4Fi2JA
	 IUa+tKFO2eGiNeaU1bA38kgrC9lgNE+oH35UJjxt5QeMQY3nfI+zEPD3QDJ7PLCYap3l/
	 AD+fx2wP2hVHcZLtw3knwaVZiDQmRPjiN6T2VMU/XGRyTZfTSVoSj/ZnLb7vBqFZRnc5X
	 z1Kr93o0SdOyzMzY6B3zhiyoUD8xnEYosoWWkJIZQqUdKJCQK6g+sxbuBl/QsaYqZUbnC
	 84Oq1aurpx7Z4dolAIWeCfjqsUZv4ezdwlObi7uGd/ZV1yT8ewr+2cgvvlW89aHJ5cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518410;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=44bzu0VgSzii5P333+my2S0mfW+IMW4sVwAKQa0O2Mk=;
	b=nyG3TX3ullACLEmG/3CTfomZ3JGZfH/4Dk/gwUR0EBTXccVwxb4Nsg9l3iOUSSY1HfQ0
	 YU1fe2I451C0EpLIGZIRKCigI/fvekqDhgjF3CsPxOH6goNNVPad0UQTWjNsZr7xE7ter
	 b5dq2FDMzFspku5TIeqzZ88790PIxf0rq2tF1afxdyRdHjfEIOkoy9A+/v3+/tbKenBiv
	 TuiGlPmXyKRj9FOLaWKEJnOgcvedXxnRejCPXjqTIQXj5FYH4zNcYom0D6BV7tXeYmRMB
	 qaJgHb02WO9QjOHjFDW+v+c7g4mCJl0bI0E3We0DTrn5gyOWul5uvt9CPILDh6ys/NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWo9xUbY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF18606A31A
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWo9xUbY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DED1F000C9
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792518410;
	bh=44bzu0VgSzii5P333+my2S0mfW+IMW4sVwAKQa0O2Mk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CWo9xUbYEjR1XKETXbfbmVPkgGB769TwV00+4VyHbZPReO0JqkZ7zHrQSs+wgEqPB
	 Mr93xPzhuryFGPUI2TwhVKuegBxshZUWXOmI2BjVyiCJV8RLr1i5xOI2EhwqY643oP
	 I4Ke+oExnhiLCwxqWjJZiq1+8eVHd0NekrheTlXkWjq5DWXFIuvf6t9/lHx0aVA+0C
	 HT7xjzVYZsEpe7n0FCNiwkNjcAsBLbEg9tk20mQibf2OFN1D8E5eoBdCqfnHqnT9I+
	 YZQvIuYXZKgKugzR4PKimMvXjaFIQFx21C09rKgHxrHu3sAPE9yybGFatkNLboEw+l
	 hE5yQogLzUBSw==
Message-ID: <sashiko-outbox-179443@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] KEYS: Verify the key identity in
 __key_unlink_begin
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020174325.2229448-4-jarkko@kernel.org>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <20261020174325.2229448-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 17:46:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When two keys have identical type and description, linking the second key
> replaces the first in a keyring. However, attempting to unlink the first
> key (no longer in the keyring) unlinks the second key.
>=20
> This happens because __key_unlink_begin() calls assoc_array_delete() with
> &key->index_key, matching only on type and description rather than the
> key's identity.
>=20
> Example:
>=20
>   keyctl new_session >/dev/null
>   keyctl newring ring_a @s
>   keyctl newring ring_b @s
>   A=3D$(keyctl add user A ss %:ring_a)
>   B=3D$(keyctl add user A qq %:ring_b)
>   keyctl newring R @s
>   keyctl link $A %:R
>   keyctl link $B %:R
>   keyctl unlink $A %:R
>   keyctl show
>=20
> Verify the key identity before unlinking, and return -ENOENT on mismatch,
> instead of unlinking the key with the wrong identity.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020174325.2229=
448-1-jarkko@kernel.org?part=3D3

