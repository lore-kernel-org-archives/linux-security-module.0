Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826862;
	b=OI0eqVVESFLoUou0qGxz3kZn0/jEmfIs3hdUZMhDHGval6aTDOzlFB1gub9NCjcCmOYJ
	 Rbf4vUo/x+cjuaB28q8dmL5EotrFZA8M8ni0NQb/FQKHJLAOtfglIjYIvzK+le3dFBsB1
	 BwuJAmoMr1nlCBOwmTNB0bC8k4jW65S+YjiTj/F5Ne1Tzb7TLIYt2fOklj1MpeqrSqc/u
	 kQdU3rT+RekSXGgjo2rTOgdy5b6Ntbapsv/JqgXL77gqM6XXmAxMoj7HMASQSW1QRWmid
	 hvSHGL4Xnp7r94XaZmuj5JUbEIwZGYuRsK2DmZr7QKJqqJtJokcqgNNWcgZkl33ewUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xi9VJegPmQbspsUAzh4NjH/qzLEEHinRHvXEhyauy0Y=;
	b=IXk97iSJ6NRnnYHud1lqPHOOcm7tSRwWqh2tJfi3o8ThqAtoy+i/wvE/HgG7BF61Jl1h
	 dZoqeA2aBfuKQFC5hIUuzo17t7Hn9lQ5ya/6ojgFZs4u7ODJ452q+TmH46Qza+KG4pHhP
	 wZFYxZFs8MCkCZOB83D6zc2RkSZ+chqprfx3zKZB3ZSjQNSUVdlBps1SVXw3cooai2Q8Z
	 IvsThAinqk2NX33J3B2MykpXRaHJYeT65+zAljYPmAZgOk/4k71yw87A4v9PMJqRB1WAO
	 FqKMFE+CD0c0pQm7+k/OdR35bORjfvHBDtEu2iiFORwqiy2eUNXXT4bR1Zv/vPE52ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lOy4AW/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A9607E4A5
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOy4AW/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDBB1F00A02
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826862;
	bh=xi9VJegPmQbspsUAzh4NjH/qzLEEHinRHvXEhyauy0Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lOy4AW/mgjkFK9AorTmePYeTMd9PR7fKZoPhl47zz2nvcj/+rXDvAuLqDSoz1XIkL
	 s04FMK3ZAccH2MaUURQ4L7kiyyo/b6kp+VJm8uZprGLaO5BP7U3nKmZ/ZhoG3JNJTl
	 X+djCerHuIlS+BRXo9ofT8zXRA8069adfIupq3IG04YbYEGpoWigvh9cNFnIWCRJ40
	 m3lto93QjCC7TZE3SK6sspEUtb6Hm9mz1NSpG6eiBksdcuo1DarMbO+MpXNMRTNJ+E
	 jeGNUoOeUqL0iyN6UcGENgOd0tjbii4dm2Br99SbJ/KHikk88IQFasKN1F+kgkkxl/
	 y4EfwCIesPRzA==
Message-ID: <sashiko-outbox-198065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/27] selftests/landlock: Fix the reported clock
 tick rate in fs_bench
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-6-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-6-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Since time is measured using times(2), ticks per second are obtained
> using sysconf(_SC_CLK_TCK) instead of CLOCKS_PER_SEC.  (c.f. times(2)
> man page)
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D6

