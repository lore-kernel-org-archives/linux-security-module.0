Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA144AF14B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387221; cv=none; b=BmXM1wQDRF4m9uSpSre8/QhGAbelw6rlvP0CIqCuGPL9NFP/vh1UMdcyIOrNASZ7ERESRB+q1+1vLbdFOLytECVswcaAY4o3ctjDLcqUV5XwklgmVOOF+79WdwucvgH3R1E4SkuLyREVf/V/8qFAPxLB1Tv8ZOkPbpuAY49gq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387221; c=relaxed/simple;
	bh=kPblszfaOQnW5wemeocG23kq2X8LTRUlZiLTAecVfck=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=j8uWytwIqbTOnODk7TEARFmPVDdwxGmRt09oNni+HF9y9Zy5hvj6OcKL+Z2LnC6N/LGzHOVfs0Yw5mtywxDefJsCLdR7Qnrb4sPkMA39PtWAOMoHwP76uTJIsmzHipgkHm/s0mgUW4Me+jsbQarx26/Z+2W8fcYsq7ZWnvi4s9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nml355Ym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nml355Ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501F91F000FF
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791387217;
	bh=P9tfvI058i7w69z09z0n4Uq+9xjBhoIvfVmMrUhwb0M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nml355Ymw0wb6a7H5w9TGxXE2I/aL7s0OQqyFmmHiDM+9iqrXJLQGDNAnHh3QOR+Z
	 61ZJFNhpvPraNH5zLVZVQjCFUnMy3BL05/Wv58ac3IkYTkCnCQTbOerqVYmOs1wUQb
	 LkB36Jao/cw+0scFkqDjmTehykioyV1xgSdL1Qi+Wkct0cUh3yNvtobLK7WyRHXoEm
	 AWI8DO/aOJ6Imtpiq3OXd2Jo2UyjXK+KZIIyfTA+AVNpwq78pNlv76U/U1chwDz8il
	 UWRCU+qUrLRYj0b791qTpRRF4Ip1W3Fi4vosNi3103ZBMSjj0rTtBQN1HJXr7yd4OM
	 AmxkUa/lXFtmQ==
Message-ID: <sashiko-outbox-163152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] calipso: hash the cache key, not the option
 start, in calipso_cache_add()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <179138670045.80227.16155454353416856947@gmail.com>
References: <179138670045.80227.16155454353416856947@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 15:33:36 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> calipso_cache_add() stores calipso_ptr + 2 as the cache key, but
> computes entry->hash over calipso_ptr, i.e. starting two bytes earlier
> at the option type and length.  calipso_opt_getattr() looks entries up
> with calipso_cache_check(calipso + 2, calipso[1], ...), which hashes the
> key itself.
>=20
> The two hashes only match on a jhash collision, so the CALIPSO label
> cache never hits and every labelled packet takes the full DOI lookup and
> category conversion path.  The memcmp() on the key keeps lookups
> correct, so this is a performance bug only.
>=20
> Hash the stored key, as cipso_v4_cache_add() does for CIPSO.
>=20
> Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179138670045.80227.=
16155454353416856947@gmail.com?part=3D1

