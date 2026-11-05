Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793916645;
	b=PL6ePES4/zxbF8ymlsmTJNfeYpCS1X1HTUvycsObmkAVrmEBH7P5c5YrO++4tqxYoIp0
	 MC9tHR+2xFoqh0it24S0cyntfmevsSE2wS5jlc539QXNd2bzNicFC+91f4izRgJCRiqu5
	 /yrLR4fKwuiTTDxUbzL05XMn99UuHNjzG22BKr5qKHF10/ONETIcJXxc8uoXTtTEnBqnx
	 YBoOi8QHgzEkaspvnR+lvSGcFeuZW6J8ntvj9/eTG8PoSn4Qa8ZX/QZ+Vh7YHGlbt9wpD
	 ODGsWPMEnXhoEwcTopWPt3IzMQBULjuZ2Ftc7A95ZxFARKU4/FxKFIB6AuqvTyYr0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793916645;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oW+xL9+DiJ0frZhPJhWZ6oQ+UVdf3MpaLCOEL1HaDr0=;
	b=J3LK7n40unezMK+luV0eqgkCesrm0bJHoT2gTCequcj+qkXCXMLzm4cqn4WA0AByO22p
	 RU1SUoZVl1B9Of5ALQjEiglr5XX+gx+ItJsugj8jNdhyxl+qeZg/b7bRVWppz5xr2o1nj
	 10BtkbiihMgqFdfWgXUG/+wvv82K2EXNSWKSwrL6hFXpewLK5qyojvCWtxjpHKSBs+28x
	 Jrh1/vnWET//61jFnCSoXXxJkQH8zD6+teAF4Z6efljf9Dn5U/VFdrA93v4VsKznlcENy
	 oewdAlbW4v3PSCtPHlULPpRwSNV0PwY8CDAhESkbK8ni9BxjqkNSZX3+r8tXwyFx2/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZIeWu/xX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7B606A326
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZIeWu/xX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0D81F0089F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793916644;
	bh=oW+xL9+DiJ0frZhPJhWZ6oQ+UVdf3MpaLCOEL1HaDr0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZIeWu/xXcoTdaISxa+i2UpZxIqnGIE50aDMgEi2gIDU1NlMpwWu439jw4NggtCPnL
	 U0B05EZvXV4r+Y+s5cspjfZScQnyRLDTV8jXL1hX5PkPfRHEptmmc6r+g4mCaLvGw5
	 nNGzygV7UufiKCjMwDfun65E76rYZlHxsrsH5jzkBPS94A1uit43y9OnGn1FquMrKl
	 9jvRsnltgauNHPsAMfMSgNv0YGQmCJeBfst36RZlZS/FfGaIpWqOndpuCmaBcHeTDS
	 +/ILCfvjLJzEx8wDyjSLIZVTp7M5ngzm9l+E0w9TvE/sQ5PBcekHEnLyudHEsnFyc5
	 cvd/AMaXb6BLw==
Message-ID: <sashiko-outbox-200293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] KEYS: Return user session keyring on lookup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105220050.1421842-1-jarkko@kernel.org>
References: <20261105220050.1421842-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 22:10:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A process without a session keyring looking up KEY_SPEC_SESSION_KEYRING
> without KEY_LOOKUP_CREATE mutates the credentials. This causes struct cre=
ds
> instances shared with other subsystems to become stale.
>=20
> Address this by returning the resolved user session keyring directly
> without installing it into credentials.
>=20
> Cc: keyrings@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: stable@vger.kernel.org # v5.10+
> Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
> Suggested-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/keyrings/CAG48ez0XjVSR=3DM--UBauTm8sJuc+Z=
bhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105220050.1421=
842-1-jarkko@kernel.org?part=3D1

