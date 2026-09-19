Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9795388386
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856865; cv=none; b=t5lJYNt4a7X/MTKNdkPvZSYE+wzsV/Zg/LN5H+Gm1sGpToC2Jo89kqHNmV/OMfIxQIMkDlAxQCbgl8+Xe9a1nd2lghY9cHqJYa90ZeX6MLqijlwGKMAEAacnGEXlMDItnnesjeFXPoqsnSiNVwU/OwggiUGGHdBiCjToe4qsYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856865; c=relaxed/simple;
	bh=1bRQsYfjG2Xl4uqOzwEZGqSDljpvrugNB/IQt+yuU7o=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgQv/XwQORoWxCuSnfIiycgWSeaRHE0lv37J1Zo4r5jIyemNOyyuzcPwrvJdaNLTnI63EPjZP1npwkvNG34WgH8XU2H7lbTQWbif0xMsLdtXmrpSn8x26FNY3rIHKaM57QAO9Oglujmgd9BjEXvkFSbJKQsd1N1q/e4jQ9UGjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdBKsQTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdBKsQTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483391F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789856864;
	bh=Jf6v5CHUfpAVOjGZhumibznwx3Eif7Ktw3Y4pnwAwt0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gdBKsQTecj2x2m0KNJwILQWLyEbrFKW0IY3bFkqWhvc1XjtiXoT0pkamRLM+OYQIO
	 mqbTqd+jJJLcaQ/Zsjo1Tn2MH+9wjW+4CAhTdjoa0XCrtFv9e/nh9cpWs2gQzmEuaG
	 DXfxOWWuYtP4U6RH63I0iBxA9HNl7c8597WYWRWm9JbyZ/HSbqwdBsXtRiNGgH473E
	 1XbX0Do9N3fwQrwUKJ81YxJp1Pkdrx10IkYcpnFtwET0Iepc08d0MaEWDamdtp2308
	 B6urGPUSmKJxWhn8BgZvYbpoED1gIA5i9l5V4Cs5B9OtMswvL8gNDvQffVekqbd9SJ
	 4ckCORdvP3oHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: asymmetric: fix out_len bounds check and in2_len
 union clobber in keyctl_pkey
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919221742.3709658-1-benquike@gmail.com>
References: <20260919221742.3709658-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:27:43 +0000
Message-Id: <20260919222744.483391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Fix two bugs in asymmetric keyctl parameter validation:
>=20
> 1. In keyctl_pkey_params_get_2() (security/keys/keyctl_pkey.c),
>    params->in2_len and params->out_len share an anonymous union.
>    Assigning params->in2_len for KEYCTL_PKEY_VERIFY after setting
>    params->out_len clobbers out_len, and info.max_data_size is checked
>    against in_len instead of out_len for encrypt/decrypt/sign
>    operations.
> 2. In software_key_determine_akcipher()
>    (crypto/asymmetric_keys/public_key.c), ensure buffer length checks
>    properly validate both input and output sizes against the key's
>    maximum size.
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919221742.3709=
658-1-benquike@gmail.com?part=3D1

