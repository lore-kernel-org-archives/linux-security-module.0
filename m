Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790730;
	b=STbmX8eUe70n9ighI5p149SUhiBz4B0bBtX19rszomZbJjf66/55n6o+Qm+oSZCP8O8S
	 L68GmBd0JoGs/aEfALw3gATb3pPH0/QP4P/one9ZaJfu3RCT7Vl6tIaA1vbwlGHtvlO7O
	 AbfYT6+5ug7CIzd5fwIwIhcAUtmei+DcGCo0J9z26JJgfv+fk9FrpElOH3jsK+4sIAy8h
	 DB/le03tdiClgPN8BUDLa7obVU0A864jmoiRsmJaZqND7Qz9ycfAHs4jSh2HuuYZYZjW6
	 Ix82SheHpdkX6GoTPZL5xOtDMoguUHF22oSCPmpUgKkg4Oi076PI/Fof9OuLYdQOIvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U/RScAZ8KDc0yMeyX9kfi8VtPcXXky7woGCIgdmMul0=;
	b=1qBUmU0J+TkhiZUWFt1MGizHoYVW+w0cgiJezuifPJkIPO4jLfp3J/oFf5b+ccqgpODh
	 Yr8UPvnk+/sZkQxjQjXiBLWsY0GdwfR/1FEwuseAuhOO9OccHQwQo8hk0ndS0yQCtl3q6
	 e0X0LQBCQaHH1NFGo/qXOiAg1sPYvmWFoNc0nu50UQPc0OQc89eIk2ER+8pfGl65YCeli
	 ciGYTVuinUP/QdqQ/Zmxm06DIvZOKVQPGtyNFn9IbCZa8grLrju6z1XaxVp7DTcPVg+Hn
	 ZS8AcDJwOZoMKSiMubOjRCkcHMnqHFxPYI2JDYLKbys6LdSqzQH9CGTnjZxrapOgHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtL4snQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADD606A323
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NtL4snQE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5A31F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790729;
	bh=U/RScAZ8KDc0yMeyX9kfi8VtPcXXky7woGCIgdmMul0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NtL4snQEpi22DDfliWx1VfvQemSlS0blYF37Xx+bZu3VFBJrvCOJJ7m0DMX92xmR9
	 d0W3266oOuyVzGHBw8zSNgMqkm9/OQ2wQm9xLs7+cmPA7oVmAEmLMEJ34oG0u+Xpn0
	 uRQmV2yAse2TUIz9ttYbO9hceI+ffhw+qYtARP1SOyoQLx3VEdSsFhz53Zmab4A5g/
	 GCO9canfBoXFLHf0Voj1CpSVvJRZDpg547AFcZ4gBGamSZSDz/vNn7KPTGbUylZFE2
	 zT+yTh/b99q6Ep00qzHrY6S8VU4pfcbRf+LTKsxcK6j65aMo5fHOZ6YyPnuHrxLP1a
	 0+LrpkotIYh8Q==
Message-ID: <sashiko-outbox-215981@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] tpm2-sessions: Re-orchestrate tpm2_read_public()
 use
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116005105.1573016-5-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:58:49 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116005105.1573=
016-1-jarkko@kernel.org?part=3D4

