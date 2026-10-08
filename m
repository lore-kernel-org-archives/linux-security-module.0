Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F54AC162
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469978; cv=none; b=SMXLbB90ybN/GJ3HsB0SqFTeavPxzgx7U+zQR24VSLPACagy6j7ArINEOiUaaRDCPuLbbYeB55FhLJ85YKvcT/gQcRHA+f1O7SHJ79VT4XeJJbJI5e8vQxhSU39LepIVdambyJb78F2bKHNiczqwUX+keXko5KgWJlGJA8CiaLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469978; c=relaxed/simple;
	bh=52+5uUzWVQOcadljkL15WyZs7kBP1IGvlyRqM7NRzlg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qeHLKGlpWjyLLBxtJdnQZxczpdQu7ED8HNCCbUKXPulgCTJYP2WTnn+7Hoz3IP0r/aSc3EGYs27jjHRl1E50yz1hOtaZTzALFCpkaMC8La6Zt+Viu1F3ExO4+z9yzBJYrKwuxfjq3hH4kMcUJUxz1nZtSqyHK7DkIfLqCxrEy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nubMsC3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nubMsC3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240AC1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469977;
	bh=52+5uUzWVQOcadljkL15WyZs7kBP1IGvlyRqM7NRzlg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nubMsC3hSW5OGK69JxxWGwWlhAOsCzrGUoR7tLiE4Bh3uKaL8fUbf/fjLtoFzyJwF
	 ufq9I1bIuR5C/FjrQPOV3fVdSaLYoxW2P9zC9iQFlF4fIDm8KMoLRuEw4MUz1zxhkY
	 RMRH2/d7al19p0xTtWylrN37zweohZ/es4QYfLoLCKxppME14gzBEpvtvQM+TT5sjl
	 3hCBamgCsc0xcISGwJqwjAwAGOG/6RlKVorjC7g0nRiDrYFGyw5L73zLdk8WFFIV2F
	 4V/JwDq3yVCEN8aqkhvjyUqB0P69d8NEDWRqEn9NBT6TqlsnhMI6tjmw/tKaKvyNiq
	 2pqzXiSdNclsw==
Message-ID: <sashiko-outbox-164291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/27] selftests/landlock: Check the thread result in
 audit.thread
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-5-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-5-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:32:56 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> thread_audit_test() reports failures through its return value, but
> audit.thread joins the thread with a NULL result pointer, so these
> failures go unnoticed.
>=20
> Check the returned value, as the other thread-based audit tests do.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D3

