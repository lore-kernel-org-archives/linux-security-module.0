Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725654AEBF7
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470030; cv=none; b=AEG8jJKZfDpK/NpDVnCv8tT7/g3Fa2x5j60zo15epO27xj6NRAvUOY4ZFa/dE9ZzJmmYFa6hAyw9c7zRef0zV4Z5vV6vVuCHWu8rS5jsIz/R+yx18kHlhNXQ4fbP1hhMvcI0KNnbMCxClEhYbAX9jo0in4JAdRnqyZy9xfnouw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470030; c=relaxed/simple;
	bh=N6aNFiDZaSAzzYrQRpCK4cpaz1D110EteC/JM8PNFdM=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nQRXEWUGEz5RrgljF9fQVQ5upIzgbWXNtlLHiMkXmocHecTvQ9p37ulUuWOpfliiR7NQUyh22LMAOIr4WPE9shjeEYkm8BTPHmpzY7UqQUe9JKoT18fLmM94uWFpg20J/CCgp9LURpZ9uDyqhIZ3wnNTvwC2viXB5GQUGf2u9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUd6K5ja; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUd6K5ja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A15A1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470021;
	bh=Q0taHBEHMagRHU9AFLfOSIKDABJnBx+uO3417oSHHRs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SUd6K5ja90jz0dyMH+F9JY7tp9ENmOsFYUQ7S83FrDZH8q1mMqvyYxoBOAVkYFMyL
	 cCv4D/JTfnrBi3NFSIzcILBfOlyiwe69KNwHt6UKOxqtmGsdhSyTI7Udn5WUl2lcZr
	 RiMMYkn/jpXEQhUSG40uOgLreBLdX138/S/fD66LSlCcYtu8QYiZ72gbzd1DSk6xgS
	 WNRMhRPnqiSBbDCPlOH60Rya+nFQVkfSJNqgDRY6eBF6pbtcm9nv4iqO3v9WPmwG6E
	 1plJmOsfAf9v20m4atcRty1af47mNbrIsONguqvqTCnpfHnBsfIVJaowvq0Thttk12
	 Es+kpydLMULNA==
Message-ID: <sashiko-outbox-164296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/27] selftests/landlock: Fix the reported clock tick
 rate in fs_bench
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-8-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-8-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:40 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Since time is measured using times(2), ticks per second are obtained
> using sysconf(_SC_CLK_TCK) instead of CLOCKS_PER_SEC.  (c.f. times(2)
> man page)
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D6

