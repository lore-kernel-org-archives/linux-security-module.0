Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790568;
	b=R2m77tMc7szXPL8J48l5LUJDYKBoOYHMLemI+a7pNrihJ4JQHnt6DiCIpyareLjYTzdH
	 aB8Q6DlTM0txYx7/xACvInh2qEePkqY2d0zt05ClHVAxRcxRo2gI9djGLRE/VpCLder04
	 xM6+lRvxZJzefbFxdP+RfWSssOaGmpZq/FfKZ7L7px8EyrpBWZe7umZNCdED6AwFodFfc
	 hWqQEd9BogWVT5IuzKh8/eK9L+ZOriknv0ABvOJSlBXAD/zsa8VVugU6sL6jjwmiC7wEH
	 wrOt4rR4Gt7+8Fb/h6WlfP30IT+Gt09wsQKSrjSuV1P/bin1CGLxOpEgL80mAnyzkWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790568;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1y9QDX6dl4UtXa43zUml694QllETYW6f1TOGLWdQp64=;
	b=lTMU3NYBTbYS0jty0LTfUsLTtHJHIcjJ2MDY/Kw4Y3POeR7quEVirDfnoriS+QpNFw+E
	 HHBg2rr7PVoKsZspk76CjZfLs63wBXVSlcrNBBLzzETNNOLYW6D6SWuplAXuR9/cdI3y4
	 vD+gRqbo+73DuswJ6N8dUWpz2cnz2Km/A+p7+Ii2YhoSlZcEOU4itFYgFXc+/+Lu+nnMI
	 6JaWsSz5h0bmA0ZmkCyHJJmNoyxrIzr2Kla45/X9dkyvbryKE6DETVL9EGmXJrUnVl69L
	 G96Eb/UCrEgKXJOA0n0nvUsP/UnNMQ281VMkoczpyZIl1nJB+RG41KxY128g+K7ZlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlEPJwef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E563606A32F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlEPJwef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F283A1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790568;
	bh=1y9QDX6dl4UtXa43zUml694QllETYW6f1TOGLWdQp64=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OlEPJwefYiutGEQwwFoWSsNV7QFX/Yw/30iWxdfJR0G/LPH+aBVXRcl0c2CfrNXIa
	 RqJKLZsKnuUXboIZ9G7Xi0J0fQ2chs1k80ZFAY3sZTA5LmjqbI0F/OGZh5x5MuS9Ps
	 Ud6Bo6Yw8PHjY//tNDSx3IKvFnW+HedoCQ9UIGEUVczsVRk1eC8TXbllVD7i1zqq+b
	 N9V30iIrjvRtlFJDeKEAIbbD5o6XYF1LBP9Ye+a613himYwgkVFqaiRQqPbv/xMBfi
	 VWi7Zu1ixqK7XC/NtX0p4GIsa5GC5z4vp19rIya9z+f35ngxKwVH11XlR49TmJvg5U
	 aMzNyNfGKJyvA==
Message-ID: <sashiko-outbox-215977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] KEYS: trusted: Remove dead branch from
 tpm2_unseal_cmd
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116005105.1573016-4-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:56:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
> set up either password or HMAC session.
>=20
> Remove the branch in tpm2_unseal_cmd() conditionally setting
> TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
> run-time, and thus does not cause regressions.
>=20
> Reviewed-by: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116005105.1573=
016-1-jarkko@kernel.org?part=3D3

