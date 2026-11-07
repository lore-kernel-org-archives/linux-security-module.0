Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080265;
	b=Rrk5zp/yAIHmen3vjk+0qSD2Bhdq6KrPgniZbmHfg9OxWM+hgivguzeaaGJ45w/Mxj19
	 HOVU7Ovpbt72l9gL9FxPBjv73J+WTGB1LN1QeqaeOMlF0lRbQfuwzIpW7Gors4jr+Dwpv
	 5bMn/39tv1zj9wpv/64aCuxDgELsd2taiTrJqBPo6Zu7p4hoq4uy9F8/bm0+2TnhEZRZJ
	 oBX74xunmhVid0sMgZbsz54APW1luXzcmsHaUdYdZ5Qqke4id/p3dm3sit6wzT/TuHcHf
	 w2H0u0Qmvv9pWA+pWuBkVbfwN0yW8Qwx/2kxCs2iY17c0BeTPI54szMf1QIz59Lb5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ot0GbQaToaR0/YhUNDb/GU7lxRP8gInAC4iA6jbeTAs=;
	b=W9sq77leKPdDwP8efjZOzqXr6K//zNzuW18o++eqQD6iBEdM/Q5Q52n693NjwJyDCzoL
	 tetag5bGLsWf3MNByzVodeYjx09Hq/L+C5HKw5RosJN+zTFFIkhHv+ErAM+D2blRU8Bal
	 NN0SDJ13Z3zRNAZQwyN7MNUs6pSE8VERujoGDNnbbjNE4Bra9UCP69a1+3QYsPK4YI8Nz
	 TvQRD5zLcn1tz+SvVK8bs8x3/TdHU6YBhiQ8JCGjH/4+AxUydhdv+s7Rw/pN/OOLaKb2J
	 bRgTdj6MNsh99ZrMaY3dBOrjbZDHEaQ/wAKYXVRZKCxv6Az1xjJekpFYZuwFhVmRYJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhmnALyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC3606A326
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UhmnALyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3501F0089F
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080264;
	bh=ot0GbQaToaR0/YhUNDb/GU7lxRP8gInAC4iA6jbeTAs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=UhmnALyu5WpAKuraZRHuZortNenrpEvHROlc4mQTExOuL9Du3SBAuA/lckPH1z3oc
	 dkNeX9FCHaf75X/r4GXEFxrTCYrE405ztRt4/RUaV6z8BfwjJRnPxrJo6uZMLHQPDu
	 xb0hitSn9+m9KGb+nv40kqlxEA7aYWhfKiK/IjKYR072fqbMsVRw/KYDhqhnmLyQlv
	 7Oqgyxx2JpG+7QELifTmhtlKXoyGDC7qnjk+19o0X8ZkVYMlQKW+1TQiHfyy/0y2ts
	 3BXLMoOpQ3y6xoKdJWfXOyp6fCxNFed08vGPPDbnLodS1Ki0k6b6fYI+sBnevXsnfP
	 D8zxqoEkq0erA==
Message-ID: <sashiko-outbox-203216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18] fsverity: Tell LSMs about signature only after
 verity is enabled
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261107193226.50975-1-ebiggers@kernel.org>
References: <20261107193226.50975-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 19:37:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> commit 28d74059fddbd8ae83c7715056b303c402071f6f upstream.
>=20
> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
>=20
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
>=20
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
>=20
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatu=
res to LSMs")
> Cc: stable@vger.kernel.org
> Reviewed-by: Fan Wu <wufan@kernel.org>
> Tested-by: Fan Wu <wufan@kernel.org>
> Link: https://patch.msgid.link/20261025204534.122506-1-ebiggers@kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107193226.5097=
5-1-ebiggers@kernel.org?part=3D1

