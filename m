Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356187;
	b=Tt9EjESW8rshOWfcfjEiP7AzJoQlAQajlyiLUKItQ1UitnpSgnrMXTJP9OHyMsxyr6uk
	 xc8o2x8xr4ofoRxsWHUlg9mPNBd4MvC6SW0uegArcUb4l3099/QvkO26nnlRKTirJPQtl
	 f4xt2Q9hHBWzVUFtrEeOBtNDKh28iY7UiZ0dc/7EYX7dmv9ga9jgZnBtrh631+c9GCobd
	 1hrYy+gFvuMlE9b4eD6QxYy76i5iliIGlMYKbGu2CjcYMTiCb2ZrBKsxspBudYI85RFI1
	 z9UrfyTY6FXoV5gTKB1U7U+pVvWU6CNrV0BwyrLaqcCEbGw2WRm4+Aa3XevXgVQJApw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xkeTzRg7O4mTMMjZ2MwaoQ3nLtFqHBdpSz1Yy0A1e/g=;
	b=QPjKvaoyrAIEdq6QrLzU6/a5zSZn3nt513amkCD6jPqrLk+jTEOMTgI+l03oiMeSa6N/
	 DT2rLtR8QY3IzXvsVPaul/rDMUuC8W+NKaTig2iTU/cpijsmeFfBn+KZtXG2vRqKdTMce
	 2wUSLoX9asZpE1CqYwShKx3H9/tV42a4FTCrAleeRkhjumI2cS44FehIP9ShINWtCDjWW
	 73X1QseGvVw/2PzOVzF5kWEz2D4CH4Z3q6Lr//OGOoqI4ML/+qCvTGIkNzZOpoYIvEvKL
	 1EwpDqxSveR/0to0UCB7YVOetzIY/qK6fh40Hj5AxvMrrg6sA16zEAk3p2AaR1ALEjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXnmRHTX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3A8606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXnmRHTX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323A1F0093A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793356186;
	bh=xkeTzRg7O4mTMMjZ2MwaoQ3nLtFqHBdpSz1Yy0A1e/g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aXnmRHTXSWikL54eTaULqd6vk533VxAKAMIiMhsGdBf6a+W+iObC8j24lbdCB55MK
	 xaask0D8mRyDGiV3wFwx9gDSwVfljGYrOzw4/4Uq/gk/SiTzG4JUrFAzeRmA9mmW9Y
	 u24UyMYxlEsmlEcpZuoBdQl3nsMueYJUEwefbKfaQVcddpGG6Cho0bHZMAYpnwsQIT
	 9rGCnWrIaKTfRI+zJ9waboRukG38JKW4/ORRGpwhbuhyigcG0A3cxm18Mp7ERJnaBS
	 VShWW7RFbcADeGabOq5ti7APFGj/RIG0vtoPcc9mGNXkIp904q3bvFk8yvM3rvGpdo
	 o1qeoO+5MUYTA==
Message-ID: <sashiko-outbox-190831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] selftests/landlock: Test that layering does not
 break refer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261030102411.12985-3-gnoack3000@gmail.com>
References: <20261030102411.12985-1-gnoack3000@gmail.com>
 <20261030102411.12985-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:29:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Regression test to exercise that layered Landlock domains do not
> accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
> used to be the case when layering a non-filesystem ruleset with a
> filesystem-enforcing ruleset.  In that case, REFER operations that
> would have been allowed for the individual rulesets would get denied
> when layering the same rulesets.
>=20
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030102411.1298=
5-1-gnoack3000@gmail.com?part=3D2

