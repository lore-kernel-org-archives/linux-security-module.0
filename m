Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786024;
	b=ejpxEgIZrNYoUQYFJ6S4OK4udTgDOY9/rsr0X6Ye3MVJKx+2/lHy7LHHmLvUZFPN9s1o
	 NQvUjq15WCnhz2raraP0Bvn+ft6YNBcFe0Yq4whG5uTCgzPcj/L7OMCxEO1gc7/ZMQdj1
	 h1Csg/7hCOJODE6sRuRCikAEu6y535RVhfdUsjvnww7Wxq7+v24+Upgtaf+ulUENRFlni
	 8aA21neHOqfC8ik4trzlc76Xqdib7kYbGtyLbAObZQekfFysXSa9sPGKlZNd9JIsfCaqR
	 WKHrZz2YuCtfFP6IM6qTuCMATcRTWT1zNayLb0W6iNVkoTYKviaHEQu3ROKJFaLhdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786024;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aKXk8ExV4Zcvb45DphhQIR8nfmZEYYCZMdkYtEoirl4=;
	b=AhQLvlCxjqHGHyc3TKM9+Z3mOf5MIMF1t64tT2zLlW7crCP0q6UyjpspHEgrOrFVvldA
	 3rWCzona9dqoAlETXztW8AVkPkJopcPIQnIIa7VWq9WBE8wyq+a0ljQ+sKQPpkV1hGMzn
	 Y2RBs1umMwuNJfSICVxJdGkUfrFzIUVfTUtAgyUjOc+fDNMlLb3Li8SUR25gg5RSfD74G
	 WNSNyXdE+957DxH44IMFi23/t+PjwIqiIMva3Dg30/YPv65LfZ+siJpN6i1hEAPImfl3b
	 HTwkveJy7tm+z0e9Z6M8gvG8i94Pr9nth2ERSV8Ju7gm7uL0jB3GTNd+YLiwpr57aPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1EiDHWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089C606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I1EiDHWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B81D1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786023;
	bh=aKXk8ExV4Zcvb45DphhQIR8nfmZEYYCZMdkYtEoirl4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=I1EiDHWkyQQIomdXPrBr5vLOY5brlPU/LoWs0CpiVIs5vieHjnTapnXzX2lJcIzRh
	 CEe5O1m24qznCuUc0X2GROp4NBaTVG94+q340mWh4EPNw3AtfIVHNkmBPHST0eX61E
	 fmecF4Cy/KpvhckvOm35ya2dq2PJuPpVSoeJlSPCFcSxGbngs3Ocp8RFBp+x+ycj0/
	 VB+qJqHaxTQEF+5rCMMDNRP23vtM1Sg6Bamsnz5wcf/py9L1LxXV4s+lcLWNTciebY
	 zb2ooOetMepAGSJi8wb22HHCkxrmNJx4yYFCT6k5fq202U2Kvc2lCFZelGgMmBWjQy
	 RgblYTPCAb6xQ==
Message-ID: <sashiko-outbox-215916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] tpm2-sessions: Re-orchestrate tpm2_read_public()
 use
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115233156.1485238-5-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <20261115233156.1485238-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 23:40:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Move TPM handle name resolution out of tpm_buf_append_name(), so that
> callers resolve object names explicitly before constructing HMAC-protected
> commands:
>=20
> 1. Export tpm2_read_public(), so that trusted_tpm2 can resolve handle
>    names, and store non-object handles in big-endian byte order matching
>    the TPM 2.0 handle Name definition.
> 2. Call tpm2_read_public() explicitly in tpm2_seal_trusted(),
>    tpm2_load_cmd(), and tpm2_unseal_cmd() before starting the auth
>    session, and pass the pre-resolved name and size to
>    tpm_buf_append_name().
> 3. Rework tpm_buf_append_name() and tpm_buf_fill_hmac_session() to use
>    the caller-supplied name and size directly.
>=20
> This reduces fallible exits from tpm2_buf_append_name().
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115233156.1485=
238-1-jarkko@kernel.org?part=3D4

