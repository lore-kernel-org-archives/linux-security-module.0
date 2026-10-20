Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460800;
	b=sVACzKg3gZR3hhugP+xEZ6OEhx3ffqJ1C1zZUXqfqmpKdrAjIWSBdqISXgGzeOUQFEYz
	 bXOb6SbzQYiPKICKdibRY21szZcKID6R/8IGHelo+Snk+BI0aL9VRg3VFsnZNgnGiCtOw
	 Q0l2T3rse6VFm6ZSM0xgcL3BX6sH1MZ6Cw9ar/lXg6t77FNuz00y+PsEhwyfIdJOLzwgz
	 magb3s7X3oz0MHCiJl2RZU86o3T+a2GhFSiBWDKJyySw+X9RnpEIMxl/beNfcOdh0PpyO
	 iaKZAGm/8Ct/yk7Utf3U8bD+1QuDv0EmjKFRQgzd6j6Up+sISXFcEy8ui62014mDgmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460800;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SO+3tbtTvgSZkiGuFKMmVK0bdCgQzzmcM2DVGniwUmA=;
	b=3OC+73ZzQmEV7MNLZyjw9ZFgT77KwhQ4bQO8Vq0kN7FRBwndsOGH8jiG7I8NlUJHl71O
	 Eoipz0DaOyDLHd5NrXGguvVzQ6/cBZXioDgR4uP/2d4J8wDuvOp0hfuP0NB4lFuhg2Nl6
	 DkM4Pokliecmmg0Y3peQpr6FRlwrf6RArNnW7u0NIiJicHprI3Z+UrYxPLLvvoFt2cmOF
	 R0QHLZ1qjacqgT3N31MZD3t11Hk2IFt8Py7a5RqP/AV4KCKaIeTfceDZcWXePzMydfErE
	 T9QDfx1teA+WSRJI/jsFMrq28FXtD317bWnLqnO4LJsH4HeEvuNpaS2DOcSn3MsHLGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHQ42RdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4C606A319
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHQ42RdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2141F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 01:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460800;
	bh=SO+3tbtTvgSZkiGuFKMmVK0bdCgQzzmcM2DVGniwUmA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nHQ42RdYZyVgNfBe97EKjqs3XwyhLb9sY5E4QvdU+YmVXHhbKoGt04SsSdfeIH/K8
	 uKRnmzONNdpU/+JGdn0lLQLwJKuaq6m03kA0IXrgngKPht7bmpNvh+iNPIdRlFln0U
	 fDt5PUOfcD3dOfsblC2YRGTCvqnmoSA3Ssq+PkjLukJTY6Qzvx/bsGjo2OYVTc0jur
	 DJMF1NdDf3JCuFJc35x1eVRx5Hc4Ui3iS0elg+YnuWym5RkrvW/qbkAUIhd9qOJsOL
	 +uQs4oIy8H4sN00uQyW+7bwHsBvsL+7XFC/PErAoGRAZo5JtrWg3c+NiMjPnPxccAm
	 +XzY8p6MJW6jA==
Message-ID: <sashiko-outbox-178415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261020013903.1244157-2-jarkko@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:46:39 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In key_alloc() and key_payload_reserve(), key->quotalen and key->datalen
> can receive values larger than USHRT_MAX.
>=20
> Example:
>=20
>   keyctl new_session >/dev/null
>   owner=3D$(keyctl newring owner @s)
>   keeper=3D$(keyctl newring keeper @s)
>=20
>   for ((i=3D0; i<16384; i++)); do
>       key=3D$(keyctl add user "k$i" x "$keeper")
>       keyctl link "$key" "$owner"
>   done
>=20
>   awk -v uid=3D"$(id -u):" '$1 =3D=3D uid {print $NF}' /proc/key-users
>   keyctl clear "$owner"
>   awk -v uid=3D"$(id -u):" '$1 =3D=3D uid {print $NF}' /proc/key-users
>=20
> Because key->datalen wraps around 65535, the quota refunded upon clearing
> is truncated, causing quota bytes to leak in /proc/key-users.
>=20
> Change the types of key->datalen and key->quotalen from unsigned short to
> unsigned int so that they can carry the full payload length without
> truncation.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020013903.1244=
157-1-jarkko@kernel.org?part=3D1

