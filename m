Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826922;
	b=tuChwRenZr1TirUqcXgFhCtrZx/g/nUmrZS3UQ7B4fozj6IogjID7Le9inl9Be2Lr6FL
	 obVU6X2C/aGzaRQylNN+9WCIVZ2TlrfJGt9MpzMC94myi2luhlPKDx6Q7HQzVBWd1nrJb
	 yMV0E+9gMOgm0O8hQwcqkovjq0qE0qXjhs1NiYezt+pmu0RCNeKAZ+/P+qY+zsZScMhPf
	 tc6nBFl61gKX8IHZh5Q4r0bNV59F5stf90VLsIgGc0z1U8z7uAUhX0csg/cYW+CFd74Hq
	 1ZjD13jchFMLcpwtq+Qs4/c2XRHfls2apbp4azI655GXGn32nn2CfdgtvueWUayXxBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826922;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pq+PsAB7DdQwP+4JdXC8yMDM0ZDazI7v5AsvgEOfzBM=;
	b=eM1FBdJZb1T/JZl+E8JisXnZqcka9/orQ4AhmcaEgqPKFrKrAxm/n5LjWqgxQKRKSztN
	 ECDnloT5GxOZr5yCMxs1Jsf1eT1q9wPe5XfZHXR4wfTX4rFZEUueyPlvWpeJD96i61G0e
	 lxZ4VSaNZsk7T76KLODi5ithey+E1xOzd5CMHoxYdVESxq5kDArTdzs5VcrGaApu4qMJV
	 efFEgz0TH0XjrIWwO+WjcHoWVj2z0bhnvKdff5pRH+Tl4TRtUkmjRkbtjLx68JpAzYrUI
	 qKAzqyzQC0tZFQoOrc0m0ERSIeyIuVe5xuW/V0BHh6Yuk9zlNQ5bwoU6tYXv+GaqLnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPytOJ7M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A846072F89
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPytOJ7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629C81F00A02
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826922;
	bh=pq+PsAB7DdQwP+4JdXC8yMDM0ZDazI7v5AsvgEOfzBM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CPytOJ7MiLEiGs3qFERbQezC43+5XMO9GfvNBtHWWlI1Dp70QVnhVpzXdmQqU9S5N
	 k4Jjg8iCoz4HNBQjOxHYK0pUseXKfwIZ75gcSB5WLeQhNYEAsNfllauhBf+FHbIuNc
	 o2DxR5mfX1z04QNhR7W6pI0PwPWJ7fpvqgUSDAdc7kRbir5+WTgEMhaZNMvKzSxzXX
	 pX9318LmOSRjubdzXgemzaYhwnAWAja+q4JWZiik18I6mmxdIR7qTmMqB6Pug3N4Y0
	 RfDyxqXLl2qzfcqbFIvjvc/4xae9E2tJIM42MotEAY7tscKk//jqxm9Grvpz6c7rwV
	 Hy6E+AZQFS/xw==
Message-ID: <sashiko-outbox-198078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/27] selftests/landlock: Fix messages and comments
 in helper programs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-22-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-22-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:15:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> * sandbox-and-launch: Describe the actual argument order.
> * sandbox-and-launch, wait-pipe, wait-pipe-sandbox: Report failed
>   read(2) calls as read failures, not write failures.
> * wait-pipe-sandbox: Terminate error messages with a newline, and fix
>   comments naming "." instead of the opened "/".
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D22

