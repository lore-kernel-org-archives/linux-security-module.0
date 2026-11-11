Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416307;
	b=s3BmxNolP3C8af6XPXK0l+xjCoTMlJMS4WTNFq/CRJJEbCfYoZgJGVdAEeUjwbtzIJBa
	 hU/ZHI/WD36SR3w5G6AP8p5iKyLTmJ6XCPQsn8lvfeQKqp0Thw4xKStmez7vDdzh7bqZ2
	 f88VS1Su80uV8rOm9lFu5uj2YUYEiCIQ1w+En2KAcji6E0ekX7rDhmropPaXRWlSONpfc
	 uYcNJaElB/bl+nXSfxy/I2cvUKenpnlJZJA2NOASf+aooWq5E1rYeSb/YNYmtpYs9QBCA
	 EvekAwq3NERJfreCTO2xRniwpv5o4coDdFh5TJivbPLYEADtkFwFBLacnfOw37IwzNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3LEM+p8WzV/9ORDagzxLgjYVvMVxrEaCuYPZ0QwoRYg=;
	b=0r1yJdpJY4P9H0fzaqgeSjLhetU0s3SGBF8Z85UzjdA1t957XozokBTol3IXjYzyR9aN
	 uZJsBBS15y1Lq9YFVEjGZq8KCg0X3Hi8FjpRggvquWi9D+qLNVOnnpuu1f2ZVC9YIDz6A
	 lp5681B5icg5WrH/1w0KlLAK7ov0k26GiHy1PXZ0aK4iVeB9xDbXZIE4udU7f5auGaAoM
	 7RRMB/TaO8onTlHz5XnFbAMBBQek9ZlksxVvswcQ0pwXhSmmRoNfTWq+6Ia2zviENTE2/
	 5DV6mPuWzdSRlJs/I2BxswOyVtySgCq2u7vf1rqSA1jiQ1PCPEzihq+KvsETpepwW6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neNgJORa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FCC606A881
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neNgJORa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6971F00A08
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416306;
	bh=3LEM+p8WzV/9ORDagzxLgjYVvMVxrEaCuYPZ0QwoRYg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=neNgJORaAb+/rloRVWXG4ne62D9Te4tKje76nZyneEReQbAj3TDjNq3+3N2uQwLob
	 3KKx1llfB5k6RJuPWHXImgTW1etAeKwaODCo0pIfBBiEas4ZXtQhmojQSU9PwGiQYT
	 lEbVoJDOtBskd7Uo4Lxz6P9KQj64B/K9jFI91TMkpgMLFNIf32uEo0VucNVyYhKnPY
	 Pw/LItBbJlQh21fugy/s20LnOYX0OrhfQSeeAop0xWR89e0ON9gVbs6sR7yoGRi7cq
	 RjAoawP6N7I7ixHtWhlEdf7aLeZzA2b9g3IE0JPKahbB0X7TjmuyY/5PhXPJWYGNVZ
	 e+IQcH++AKRZg==
Message-ID: <sashiko-outbox-209349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/capabilities: test_execve: drop supplementary
 groups
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111164645.260593-1-lylin1023@gmail.com>
References: <20261111164645.260593-1-lylin1023@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:58:26 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When run as root, test_execve keeps the caller's supplementary groups,
> which usually include group 0.
>=20
> Since commit 337490f0007f ("exec: Correct the permission check for
> unsafe exec"), a setgid exec is not an id change if the new egid is
> already one of the caller's groups. As group 0 is one of them, the
> ambient capabilities survive exec of the sgidroot helper, and two
> cases fail:
>=20
>   # [RUN]	Root, gid !=3D 0, +ia, sgidroot =3D> eip
>   # Wrong ambient state (AT_SECURE is set)
>   # [RUN]	Non-root +ia, sgidroot =3D> i
>   # Wrong effective state (AT_SECURE is set)
>=20
> Clear the supplementary groups before switching UIDs.
>=20
> An AI coding assistant (Claude) was used to analyze the failure and to
> draft the fix and this changelog. Tested on v7.4-rc2: as root, all 21
> cases now pass (2 failed before); the unprivileged user namespace path
> is unchanged.
>=20
> Fixes: 337490f0007f ("exec: Correct the permission check for unsafe exec")
> Signed-off-by: Kurt Lin <lylin1023@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111164645.2605=
93-1-lylin1023@gmail.com?part=3D1

