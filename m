Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439431;
	b=UKU1Mmmmn04UpbcY13k3060IEkdpvZxJigXaKRAzXv5aHccLf38rfPNfEXrROjscWX3K
	 TnrBkS5VtTpOjCDXyr7R3pAxOvMAEc4k8Tu0Ajl00mxXFvrY3Ovgo3IMqOW9u3sPgPnqm
	 6QuxB9TPyQC0ZQzlRDfiOsLb7oaarLBD+hLhCy7/WkSyH6rVCTEWKurG0j/lw2XX388W7
	 Jcbj5WfWt+ToDiWmjaIQDXAPXjK3nri4w94P0JJZGa2rx4LluUYf4JJ847n8e4y0OYaf3
	 48ZS0xiTuc+cqGhNot7U9siEgeeCIFn6IZGJQ9Js5ESBUQJu817rDB48X/lnWnwGI5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uMfxOktTB9aM4Blc+ij0IaX2tYhbIEYp+CBQPRS+Jkc=;
	b=UXqxdE/76Dm//mFw0lvy1vmtMklP6WNU2wCSrQHCamYnLA+fze1sXAFhmRyeF1TONmdH
	 3fVo50MWIczvuknEVArk7986pNcZLinx+tI2DrFDy5DxoVhKv5avAq0NlTvr57TJHminP
	 fkpQS8A178YI624m9fEUy8pCsU/ZfQfFSEHYC0gYnbTYpPSIIwbtVKoAzoHly97x2qML4
	 9D6QbxG7PebATzacc/k94GzY8oO+pfH/Z9c5WvvvQCWY77KMcOVlzWh4VR8ASd8fyoQw3
	 3gsefyXQMhDXC16dsw/YGPYN16j/XxibYlHEUDrgDnqO9wGVjY/oNWOt1pE8DqVJe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktyu7C0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372F606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktyu7C0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF621F000C1
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439431;
	bh=uMfxOktTB9aM4Blc+ij0IaX2tYhbIEYp+CBQPRS+Jkc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ktyu7C0DQSMg10iEX/LGgKorCithcVAMy776QMf70SBUwcwhw5mSPBf6rttej68Nw
	 FZ47og/cN2b5pGukQF9drmhv+lObKqUMjcXBSdWtkIbw+Ky9x/rLiVWujDWpMNQJt2
	 y7+7CtbgAePnMT4/+UIM8lYf34X2CxaZ/veROiDIQn9da3PMZbYhsr352UaqIVdr83
	 hCPQUvyjHwY61xnOwAhV2J5Hl/IfHGzzUmNZhsRduc6x0j2h7yTZIAGqp+21FSApx6
	 jtNKAe9iJ3Gq6mHnTcTcUxIPIGmGk0WF3t3L1/4V2nHOHIBEz5zsoziUOlrTI6IAnM
	 Jol5QnZpwzoYg==
Message-ID: <sashiko-outbox-191876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Reject restricted dest_keyring in
 construct_alloc_key()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261031092820.497238-2-jarkko@kernel.org>
References: <20261031092820.497238-1-jarkko@kernel.org>
 <20261031092820.497238-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 09:37:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> construct_alloc_key() links keys into dest_keyring without checking
> restrict_link, allowing keys whose key->state reaches KEY_IS_POSITIVE to
> remain in a restricted keyring when instantiated without relinking into
> dest_keyring. Reject restricted destination keyrings with -EPERM after
> __key_link_lock() unless KEY_ALLOC_BYPASS_RESTRICTION is set.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a k=
eyring")
> Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> Closes: https://lore.kernel.org/keyrings/20261030173930.40948-1-permissio=
ntogallop@gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031092820.4972=
38-2-jarkko@kernel.org?part=3D1

