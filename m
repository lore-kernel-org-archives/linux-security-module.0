Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EC3FA5D9
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948772; cv=none; b=JKy5YRtH89hn8yijaHMZifUhVVHPFGl2CGGVGeHx9f+MbwB6vnafcBTIOaNn4nd5hiwYmLS6Db3Vst9T0ZEsmcweFxd+3CRHopH+XuDUSpJO+YKwx4QMcsDtXP3OihXAEaX3v2ODoi8J0X0lLfjNyaqv3Fme3lNj6BvjfJkWqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948772; c=relaxed/simple;
	bh=UHQDz3UJ4OADxaOh/QMyFUEv1yZW2MJEjWROO9nHE/k=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZlzU+HYfn5d6Ft8jCsO4ZZRlyh6CMDmoPEDJ0mUvWvplK0sgqqInOmgcLEA4rB3zfL2fpvGxxPlc+hx7cZ/dRfRdj1nzoAbXG6OIjFCo+r6BX9nNJHna8FyOYJuW9qMXMz3d+m5eU2eCgeuZ7xYBkDEbIZXJrMZ90jO+AWo3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5/UUY7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5/UUY7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4613F1F000FF
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 23:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948771;
	bh=UHQDz3UJ4OADxaOh/QMyFUEv1yZW2MJEjWROO9nHE/k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=g5/UUY7NnJtMT3mw9V1V6CtuzJ028OLZlAi53RNYB3ae47M0Eg8hgot9myfF7GJ7X
	 fT+zom23v77exf21rUuI9C76Mhe+pbM1h1++37GC84kUYTwoxRLYa6LBhPt6ntytIO
	 BwYeN1q52uF2+qCH+b0ZI1NVP+LqW+cwSn3UsY0e6UbG0oI7YtUNNU4LQwNomF35p6
	 X8nuEn3/D6dcVpSyzgBmMe/y9pYbQLi0GXxYK5YUMXdcSZ0uVfdCltbT2vQyLjv1Uk
	 1Hc7vZlo3BlHDHdhmPq79Ovm4f4YrQknkY22oJQZzjoFS6UN9BiZRVEkuOw91+l7rD
	 CEPJChKYlGFvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] certs: x509: duplicate cert->tbs when
 sig->algo_takes_data is set
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260920235249.260530-1-benquike@gmail.com>
References: <20260919223438.3883567-1-benquike@gmail.com>
 <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
 <20260920235249.260530-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 23:59:30 +0000
Message-Id: <20260920235931.4613F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> In x509_get_sig_params(), when sig->algo_takes_data is true, sig->m is
> assigned (u8 *)cert->tbs with sig->m_free =3D false. However, cert->tbs
> points into the temporary ASN.1 buffer (prep->data) passed to
> x509_cert_parse(), while cert->sig is retained in
> prep->payload.data[asym_auth] by x509_key_preparse() after prep->data
> is freed by the caller. Subsequent signature verification on the key's
> public_key_signature dereferences the freed TBS buffer.
>=20
> Duplicate cert->tbs with kmemdup() and set sig->m_free =3D true so sig->m
> remains valid for the lifetime of struct public_key_signature.
>=20
> Tested in QEMU against Linux 7.3.0-rc3 with KASAN enabled by adding an
> ML-DSA-44 (OID 2.16.840.1.101.3.4.3.17) X.509 certificate via
> add_key("asymmetric", ...) and linking it into a signature-restricted
> keyring via keyctl(KEYCTL_LINK), which triggers the following KASAN
> [ ... ]
>=20
> Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digest=
ion it wants itself")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920235249.2605=
30-1-benquike@gmail.com?part=3D1

