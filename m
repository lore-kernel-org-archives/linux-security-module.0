Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908129;
	b=Hn3L6+2/82glhI/qm3bF7U0QKy2bCKU4f5dbFRzVY45VUm0pQjZPboThb48xPz1PnmZC
	 LZiPCniucywMivU18BV/+LYbquxsdRL0mLQ4BPcIzrukWhvwQGyEn+aDEPErYhVTujOs2
	 x0HNz4NnDdqvghggiTNJ6RNBtcVTzhdg4DVmpgP04rAn34CzEPAY/9/bKA2DOUO4kTEFY
	 qGix7fAxPHevjEKZJuMFsrk8wDT9xQxRx+5xuPHVV0OPwxJtxu48C625NDXb+7ijl8YXP
	 2kkJk2Cg+0EjxhWG95+/qZaXY9JqfdRIUb9U4dv4+bVKoz7S8obqA7RFS+6/Tbl01nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mEaU8KhDbyznopgCo5YMehmg7lxGOkdUSjTHNpdYXVc=;
	b=J6I+vDk5WxN0MLgdU8zQ0Zc1ZOQOZkjuLZtgV33WjlVezncvCfOrUGWL+4N7ORPgEr4T
	 sCHWdJ5TOwHUmTmlTjGpqvpszh+ZSrEEym3cDw+Pv/85Qlgn+o5Yk0A0gCeLGSN+PQTzU
	 opvQZkaBScBSTTkq+dxP5o5CCAvlblDcUNwZaGGXTHmivGMGMw5E/YZoZOdu52VL6oVmi
	 oG1xDyo4AEm71FtustCwuF+N9BnBmmLx4e+x2wnZzscksvVcuLtM5Kee3yCpEQy44yxV+
	 V7ymn1oDsipE60FoD7jm5K1Hqy10FRz4ph+TXoLeRisUAwluuYFRfRxj8rYeGnxtRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjBfyZwo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C03606D510
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjBfyZwo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2971D1F0089F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 19:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908129;
	bh=mEaU8KhDbyznopgCo5YMehmg7lxGOkdUSjTHNpdYXVc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mjBfyZwoFSPLRS+6UnlG73onKSN7j2FXMNiVY2TN5b5fZx8hbAY0x8jv7spnvu30I
	 q5UiW8fDV9CtjsTpZ95zcKHAfCcMjO44mq5Q7+nDeJAVmnhmoF6VL+VlwnNmSzdPnf
	 iA6kSc1Uv7FoQxCgPFv8KElEigJiKckQapDnkpmO/63FuTFSaDRhoM1aK+ebsiU2eq
	 Xk1/4Bemz1TG7uST5/+/kOWEA+GcZo9nz4j06IOimodGk4D6bs1XTI4iqZXpew9pQ0
	 uyM2fqWwnfT+ZDrSag2lmcGkrztGPYV2bKDP7C9HMbKpbwyqsnsy9/P2mb/qCpMqOa
	 tDu+xGuUSyRqQ==
Message-ID: <sashiko-outbox-199985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105193632.34363-1-0xbeac@gmail.com>
References: <auy1ANMSKTXZb8GE@kernel.org>
 <20261105193632.34363-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:48:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_pkey_params_get() looks up the key, and keyctl_pkey_query(),
> keyctl_pkey_e_d_s() and keyctl_pkey_verify() then dereference
> key->type->asym_* outside key->sem.  A reference keeps the key alive, but
> does not pin the module providing its type.
>=20
> unregister_key_type() calls key_gc_keytype(), which retypes every
> remaining key of the type to key_type_dead under key->sem for writing.
> The pkey paths read key->type again after their checks, so a concurrent
> module unload can turn the checked callback into the NULL key_type_dead
> member and call through a NULL function pointer, e.g.:
>=20
>   KEYCTL_PKEY_SIGN task              Module unload and key GC
>   ------------------------           ------------------------
>   keyctl_pkey_e_d_s()
>     if (!key->type->asym_eds_op)     unregister_key_type()
> [ ... ]
> against type removal").
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuansheng Yang <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193632.3436=
3-1-0xbeac@gmail.com?part=3D1

