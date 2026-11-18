Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011565;
	b=UwoOhblscGpg+3AqlNBQZVuGye5/rvshuTJkXS9Eib1+/zukFGTWWRXxwI49pX0ao11v
	 lyJHdWZ9yeYORSBCJs6T1wxKZm3wq8MS0DWxDfq4XviAXLdmJ4XKJivD8GaYjlqiKyZh0
	 iP3sC/2/QpSu3+sf6mkec363T7Vja52Kx5MflCICLU/j8psKPZb7dkF7Ui7G8adAmqZgR
	 fFtBjMWAweiEaV9jrvhhiovKfNT/0o0Hrxr7LiWchW7h+WRwCz6D6m+EsW0/SRZ/mrT9S
	 wAihbutnsmGyCjhMcVhyO9M6uu5nxTUC1TsM1vxbD4P3f69eQPJHPy95whOdAZX8aCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VLe2TCRMik8IHizFrISvpU25yZW6J2eIY8nOBfPke3Q=;
	b=rS3/9R5FIenR2R6GiU1P+w0UXOSYvFeS+vT6NTl/ZcRWsjwoIJSfNEYkS9G62Gr3JZ1E
	 3q3Gsb4h7d7FHqQsnDB0QG5VSnulzwEjFfOE6lGUPgMiS3XJ91m3uHmcVpUp5lM/KaiLm
	 DQ6MD++NVa/t6vBBDMT3NHlhcqUFcKDYNNpD+wwGbYIG2DePiTd5kiep5FMyhYhoc1M3v
	 ypDXOAKpfNylRDwuc+0MCrL/kLAJKCeZN1FHtV2yTqozwdfMzr5A4mxR11xEC/JGsZfxj
	 srY2j8YxxPpCFY3O53t8iFwPBw9fVZbmpYNJqjMYPTB97BF/iZ3RN6aPwBbvcT/jOdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOSTHHC7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D10F606A338
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOSTHHC7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C531B1F000C7
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795011564;
	bh=VLe2TCRMik8IHizFrISvpU25yZW6J2eIY8nOBfPke3Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nOSTHHC7ao0mDwgO8cvT3FFYmQ5w3MlH6ySoDl+LSVajNVtGcCEgqKFvVZSj3J5Nj
	 PE9k6a3vF6dqYb5LPJfchvnJr/erfsNFlxqtZhOitcTekl6r0gs9634HesKZlqSMtk
	 Rw09kO8Oyj3oXTaA1XVQoSlFuSgsDu86LOvwL55hyNkMSl4Kxfhws6EoRCwqQ8h0Ki
	 90Fkz151EGZbhShhmmPhxbemgjBCIowRuGjJPhUPKa+1dIUP8oYYzcnbwIwCqu3JcQ
	 ZauQTuCbaSAkslSHWDj0fuVPKNOeNwdv7qHisUzQ0lg3JXTzMSCowalwSLMJMjtfWX
	 X+NQvHnuz+gGA==
Message-ID: <sashiko-outbox-221187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/9] docs: keycrypt: document keycrypt keys
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118140734.601772-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118140734.601772-1-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:19:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Document the keycrypt key type: its model and tiers, what the core
> enforces and what only a tee or hsm backend can guarantee against a
> compromised kernel, the add_key() syntax and the blob, the kernel tier,
> the OP-TEE backend, the operation context and its ioctls, CBC, MAC and
> VERIFY, revocation and permissions, the system policies, why AF_ALG
> and KEYCTL_PKEY_* do not cover this, and the errors.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D4

