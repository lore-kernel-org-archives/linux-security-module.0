Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316086;
	b=Z2WY0U7tws9Rd3KWSBPemmt1qLiHA4l76BsB8qh0o/JcH/ksK7mXTTK92xWvdjdD+D5H
	 Ft3e1QmFPMTyUQu7EPO/D8qlyZ9e7JtcLp3OLyIF/5c9asgl7MK+pweIzuax7n/w5qRpD
	 f0uXW25+9+dE0AtMXX8VXVk6LnTX85iMHoxba/d3yq9v3U6HKPZHlFxEkI+beYN54VZdT
	 m1Ba/QB9z4mWJRxtPskkRvndFkf4h/LjJF57f7ytmnOS9gMpMLfPH3whpsJdMW1Hkat+y
	 ZDAJnbYPkV3NUMzVYPKexUaNf5fTUI3hn1oHD6uHx4m+1455wjyWSAsxRGE02JfwCdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x5Fcd8kxjp+xJ/ncOhAWO/Dfvk1FdAyqB6hlubI3Y3U=;
	b=LssWAtZ+q1m0hOYuoCYQLoFZlgImrxnvqzxgCxQB3LzjrzEuRW9nd9DB80ijoKwRgMhv
	 8zQvbiRlcYayBfkLCiMV9f0uEztJGgWDK3Tf4EqhxMxJ+8PQVHNSLsK+z58jSZld4D0Xb
	 o+fx6sjoMH/D0zlDEZGcXJoR7n0kQ4EHVz1Kq++JGsKAID/HDl18Lmj/mhtas1oGlCD0Z
	 yeGeS/IAQeUa8J07J+CUygE8+2PyuFy+OKZzO1sw/02xR0hDt0gw9TP5B3QPQ8AW0rV9C
	 4NeHqt2Z3uQslUsN6YwSaEb6zi6hj3M8SFgYrMvtM1AE87895m4jIq4PkblLX+t6t9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUGeahDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88F606A321
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUGeahDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7ADB1F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794316086;
	bh=x5Fcd8kxjp+xJ/ncOhAWO/Dfvk1FdAyqB6hlubI3Y3U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hUGeahDuiGuOYIO/+bBoi1CRhAApo9HcbAPqDedVfFYlF0ywSRK28IKykSOO2CJCO
	 gn7nvDB4YTLf8nuSGaOlHJxhWpxoBA/UcY9nIm+R2NBlG4VwNZBMF3RoTffxdLpOkK
	 A/I/gB1d5X+qwcMNjj3B6owJxLxA3zuRTjUtUq3lL43/BvfFwYeN9OnqAH6+gcFQPQ
	 d7fYHqBHDlQ9RDZn1SHwiFksJmDldov2LACpemzlcLbcuGAaa3yPxevT6o+6Ibj36y
	 r446pvm4ptOuHi9rMAnD6oQxub+ejchtzcbf1KpI3ZO0maLLXEv+2Iw07USdDk61h8
	 oqg1aQo7izt3A==
Message-ID: <sashiko-outbox-207085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 4/8] lsm: remove unused lockdown audit data
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-5-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-5-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:08:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit f5d0e5e9d72d ("selinux: remove the SELinux lockdown
> implementation") removed the only producer of LSM_AUDIT_DATA_LOCKDOWN.
> The type, the u.reason union member and the audit formatting case are now
> dead, so drop them.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D4

