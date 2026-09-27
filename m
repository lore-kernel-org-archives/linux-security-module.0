Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42B2DFA3A
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526972; cv=none; b=UTXJ2cVuz2zt5Zy152gjtp48NcgRvBfea1Ik5XNjmKQge04OpCE0g/XySZ2B+ZcpWdLXVx2+hYUN7DSrVTYfyR9X7cLg6UGTdB1FQFGiHVmsJqetBtW+9b/SaJEGQruykjnK4h8voZ1i9byDb1xqdZsPTi4wcmliJ/Fp7fhVNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526972; c=relaxed/simple;
	bh=C0FGML8azIuUdCQVjnDYEf5z5vYlOtCXKQt+7aXQwQY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIBLtAAzWmdNtsyFzR++A1DotNc1hkb6jSdYcjf2qbAaof9SMErSXXsFuGXWwYF6jg8QqdfDVdBm0CQ1zzc+EACYtm/jduPIAh5czAZrjHo3C2N/fvplGMLuQ20KyyFCKlKKAlwM+v9+MruNgSOGzKAluwzCtSR4DjZY9rwy1eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyEMVZ25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyEMVZ25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1007C1F000FF
	for <linux-security-module@vger.kernel.org>; Sun, 27 Sep 2026 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790526971;
	bh=sQhjsv0SswElouONW0HYXmzmxfap10EIQd+c+QK7HKY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FyEMVZ25s19DnCP7FiM4y6bD57LAISm5Xi/wHaZJ9bzP+x+TMyLW9y5JGXJbSZsdc
	 wyTialIP44KiSpfm2OPLTU1pHJ6F2Nh1thXoz1eFzFgDcBNSKhxEvcqXM70iSTETK2
	 ECjD1Fvl5lrenMk+nDQ/oevS3sQrxReardZyOCK85N9Qhr41h+Aih0FopSI1qqGZoT
	 Ja0apEL8FU1UZQtYVWelUAc/Iec7alid8Gyh5BVSMfWSiASjnGv/ah0qXmgMdqkxPK
	 S2dCr6jVqhm4D0InkhbIEhRot4FlqjYce9FTvgQh3QfIyC+bI4eNGVbZyKhb1V4A8q
	 aHgM8GJoytgYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] keys: Protect key_user lifetime during ownership
 changes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260927162528.943886-2-nicoyip.dev@gmail.com>
References: <20260927162528.943886-1-nicoyip.dev@gmail.com>
 <20260927162528.943886-2-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 16:36:10 +0000
Message-Id: <20260927163611.1007C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> keyctl_chown_key() replaces key->user under key->sem and drops the
> reference to the previous owner after releasing the semaphore. Readers
> which do not hold that semaphore can still be using the previous owner
> when key_user_put() frees it.
>=20
> For example, namespace filtering in /proc/keys can race with chown:
>=20
>   /proc/keys reader                 keyctl_chown_key()
>   user =3D key->user
>                                     key->user =3D newowner
>                                     key_user_put(old)
>                                       kfree(old)
>   read user->uid
>=20
> An earlier instrumented run reported:
> [ ... ]
> outside the new critical sections for the separate accounting fix.
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927162528.9438=
86-1-nicoyip.dev@gmail.com?part=3D1

