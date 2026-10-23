Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759110;
	b=ANtzR+JI8XoJwy2SKA2RYbkVitT1hAj9frwWsjpp8DU9uUREqGD/wIwIhZoNrU3rNEHq
	 h911qECmwfRL4AW2qVA/n73mqFuFd811YaXpwevG5/9aEyS1H/RpUaxh/b+9HiT2IqVrN
	 hiCfStsuS9Iy4fBE0UplMqcKE8RbbADIMA2xKUdC19tGPv7rsnD5J+b0JFaaoENiZBqVx
	 fWG+Qx0vXR2pICgh5VH38HtYCN6ZSKv2ICkrxxEkaLavMK+Orhk84Hfm657AgPfe0CUYD
	 V3P1VGg37BR2dmoyaaeN8TYY4fgEmeznLOVRsVUwkVtXh1U7y6o+n6Oy2hW+9okO67w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759110;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JJGNkNA22nd02G29Rd1FQUXYrWImM24cE6sN7yHMkDw=;
	b=0T9k3lhASI80lMTN43cq6ihlR2x5a4l2KkaOXrqsMt3UgJW9uC8yxbqILe0Wg+BKShiP
	 BOuAg12pHw9qKG3Vv8zg9u4c3LpaSKL+J9mUVOL99FFaeF0ICZ/SzRaxML1+Gjb/NA3C9
	 tNVrljDfmFr2VPtsodiJ5QhGhMGgTXSCInNmktdc0PL9CjSrufYriSI4AupzwZopfjFXV
	 GrpcGj1twcdPHDE6ZQ4YmPdGI4ju8Yl+PpIZTReCUzI65o0An/LqeuiC24TJF3AXtCafi
	 wzIuYYqNuPAJzY6I19Yt94jLKo3Qugccq4KeVkjyBHPOI6rJrnSdsRn8zaACI/Pbhzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vpykbp1j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16C606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vpykbp1j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71561F01825
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792759109;
	bh=JJGNkNA22nd02G29Rd1FQUXYrWImM24cE6sN7yHMkDw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Vpykbp1jFOo+miuZtFQgK7yYyeARURqSZh0jPj5SOYpmSCnvdNRI3f/nldcbGHRbw
	 FKO6+utudzRSFnZWaro5Ejh8bB4d/p4JIZ67DU3vEf1gClmra6DIrA83dKc2VVaA6w
	 GBT9sD5SVrph2jNd8KWfr9zQcyUaOw4SdMogHvvHQsloUK4hw/JYry2Sj4GJ/mW0tr
	 W+mN7VStbYHV81FCNq4TTBoySXsdZMuKISKWxQhF+C0ZaoQYOVbFW2MTeFuFubd3bY
	 coNICB8ythQ0rmy2hKpkt8XAAK2sV7v/6/PaOUd3k7fkyaFhzZrsnhceDXKSDOO32N
	 LDj2sJA5vZyYQ==
Message-ID: <sashiko-outbox-182784@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] KEYS: Reject descriptions larger than
 KEY_MAX_DESC_SIZE
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261023120953.1206778-3-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:38:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> KEY_MAX_DESC_SIZE includes the trailing NULL character. Descriptions
> generated from payloads and in-kernel paths bypass the userspace limit.
>=20
> Reject descriptions at or above KEY_MAX_DESC_SIZE with -EINVAL at the
> following sites:
>=20
> - key_alloc(): before quota calculation
> - __key_create_or_update(): before key_set_index_key()
> - keyring_search(): before match_preparse
> - request_key_and_link(): before match_preparse
> - request_key_rcu(): before check_cached_key()
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: f771fde82051 ("keys: Simplify key description management")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/r/20261020174325.2229448-3-jarkko@kernel.org
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023120953.1206=
778-1-jarkko@kernel.org?part=3D2

