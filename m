Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618568;
	b=BgY6d3PHIdxMmwBQn7zFmqiwHWDq8wYjuQ5XCk+oEcTn8nrtER6Kn0ks8aPeQHa8Jzg7
	 slVrnIMan/lXWqmvLhD8ZceObTIVPYc6C/X11KvBaNXnVoSuyHFIcEiIzfSCBsR238Moe
	 hQCLQwvF7GmLNC7LfA9NOD2GYC6/0dVgGlDQ1FLM+HMOmdiXrDZuM0tox7gV9q6FvxjL4
	 mcAnPlvRhRtbSiQkGXoiNXX0bnxoj6jvDeA673JjvKexfC/5DVYfI3k61zKdMEMglEJqF
	 0fkk7eCNKl4K90rtWKKte/TNgoI8UIffGWTEOssExFwbEApElcn9fLAwmyu+PO86FqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/sKsZzbUbWih0Stnxp+Qwc+B7pbrb56ar5ievQUNSPY=;
	b=PlN74fZ+xOEXJH9cHA9FIO4CaDLk/zakkfW4MSVpvcfm4uNXIc7i1Ibqe/rEZ40KPq0x
	 Q1Jc+mQP4roZ1G7LDBCwn5q01C8KwSeR9hEm/jA+/ohQkKLkcVgtuck4YJsiATzl3ttzT
	 rvKGywxGf45W5o18hyuiu5MQQYX4mH2jeJ7MHZdidxgSE2LiC4U63ND3+76BwxTlVL4Kx
	 8Ja9WRy3jA0qdGgYVtSgoPjG7PSubvEycGRHsFTqNbosDFluTtwjcrDiRewf/2ZotKwUP
	 hfQ5ouadBGfmwEyQ8YQougYpdy97N8LyARdpJwRivyy2dXoKzNPlfiGKrO7EMiiMZhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwoc2LmI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCE4606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwoc2LmI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3262C1F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618567;
	bh=/sKsZzbUbWih0Stnxp+Qwc+B7pbrb56ar5ievQUNSPY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lwoc2LmIPZdVhXnwfA0hfs1qDPTjZbwCmM25PMoyydAODlkh89w1/cbGw3oEuoek7
	 6pzpD+IuYoj2Ezy1cHUIq1neTWvc9klhCROW25Uw7py0SMjvB5fAsU3WdfgJmbnllJ
	 C9dD5OG1Yh3rE/8+9qKntZfa1VGXRnKOAi9yznNCnUzBRX/lrMdoriihHCxSlqRKoH
	 9dmNLKL1OWHDrHjrrPO+TR9ZD+g3lOdbHoNgillIWZEhdHxPYRCFconDaM7RXKCm6G
	 TcesfhvDvmW8C1FhPg6Murc1u3ZJmTnd4zZH5lPK36MLX+0+iRGMDKRlMQt/CqeLqE
	 iKix7zV8LEDFA==
Message-ID: <sashiko-outbox-180711@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] ima: discard modsig when detached data cannot be
 supplied
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021210145.1851396-4-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261021210145.1851396-4-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:36:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_collect_modsig() supplies the file contents to the parsed PKCS#7
> message as detached data. If the message already contains embedded data,
> pkcs7_supply_detached_data() returns -EINVAL, but IMA ignores the error.
> ima_modsig_verify() then verifies the embedded data instead of the file
> being appraised.
>=20
> Make ima_collect_modsig() report whether the file data was supplied,
> and discard the modsig if it was not.=20
>=20
> Fixes: 15588227e086 ("ima: Collect modsig")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021210145.1851=
396-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

