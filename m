Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434265;
	b=kxcxpTygG0AOFxHWw1HyDpSyAtOv1M6FLAVulK/03vg68EE5SEp243jUeBAvv2umfkfQ
	 ughfjCgXETAsoQbaVkghi1hSBk+sgIJ+uLFu+FXXeZZHYVDjV+tIIEUttmciG96JX28sY
	 /DU5iDqUHivvqMpfj0TK9wevMvr3B4fjUNfOyMD/t+GHh4Kc6cwvYeqH9HTOvDqEiHKXz
	 MlZvfJA8CRMqQmGPPdTrq8vayhAlIRAscfrG4WxScAookXRPd3aOMpqora5ZX8CADF2aY
	 /s49EJiiffeILoAM2L+c4tcDkAKjORfbQUlGfkZNcP8lOJTVarAK1PHqk4wK4UzTX1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iQgnrvC4GVRqSYc3S1WZLiW69VRjUsazEMIqNT6ALTY=;
	b=d5egD+KSD10YknaUuX9alHx1bLswoSfC95NXdVk8hLD6L0CxCNyrf0C3Ucxot0C1VG7J
	 MzhdVaVnd2/FkoQW1hdRH7gs99qbEDPyW/uRzVpn03EogCUS2Se2ckcWJLmkWLvBpJyG6
	 QcVHYFtx30g3Y8ysW0S9X4f0KQAFPD3Awbuxl/TYQC4suQaTTeIojehYZLglhLxMX4LLX
	 pyQjtPColzavp+TwGPOgj/OP2fxYRuorpG5JXBMvITkyMQFZvuz/QRP3/FmPQRTs/JbA2
	 Retz3vnJHHUmYCBS6lr5x0wK5odoOekm5Ub02WObgEpKhwTzWBpyOKYjB4dAFSknXiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K22PHVZz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512B606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K22PHVZz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696F51F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434264;
	bh=iQgnrvC4GVRqSYc3S1WZLiW69VRjUsazEMIqNT6ALTY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K22PHVZz1283f47LROm3aB4GZVpXv6uNrAg6Azg+uv1Nnn4CkvAEMosBRRyv5h6E3
	 k0fxCDNpAD4I9qvJJc60lixNtDjGxM9er/H1+4iBCFUW9sZVSRgEo6g1cx+alCRrTO
	 vzfkmsASg3oJxTe73kpTdC47YWh/gfQtGareJS0ujfj+VwO+aLdw3JgKVZPqethBzX
	 GzVVbXoiXSI2nfKNiEOzyWisltdwV9MO1hx33kGSU1CauGvLkFICAgwl2/Ov5d12EK
	 IuUAYQgsxTCuuY5n3t5fqWAdNnziI9vmryCLLocDK0kY2i9abqkdMRdsc4Qljcj9H/
	 59zHqGUeiH1mA==
Message-ID: <sashiko-outbox-178074@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-2-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:24:24 +0000
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
> Change their types from unsigned short to unsigned int so that they can
> carry the full payload and avoid truncation.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D1

