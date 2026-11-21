Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795260379;
	b=M133vVzCgrJt28aSnNzrccyRqe0F1SmgO4lnGKNlE7fCXjB9JE9Itm5d2m1d1zO2dxgV
	 v5ZqLb6193fAUDrpAuLk+HFXAnFc8RXVyt5lBkC4wzwom8Ye6RDmTbMT4Oe5eWr6JI8CP
	 AHgD0PMses12RbPwtGM35m1yQ1y13vmylMmyUqtTEXCmPagQOAt/myEF5KHyXr6eOmh/a
	 h/O5Ivl/sVjJHo1XMUfQcv1Nx8CcBo5lm8G2ixICv3lSeljWpYroFFL3Hg/4ZLH6yh0d5
	 uRSFh6Gml4IbDPzwygCkyzFilKSbmspWY6IkoqZXoCBd2uYHUxQWERpVuvSRNCJhGXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795260379;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Al83ExmFboZI8F/VtrwC9ONocMCKtiId0ncP111tvmc=;
	b=V529opLGJ00MMsx+OIK7uMzI+V3KDTd7DK/IrqoSvIfLUat4NvE8jdKn+G61bCQFEJDy
	 jWbSO/ERx845rQZ4rhZAzyxerfEWUZER9xp5rf+3cpDjsFU9EdiBj/Uwg/b1RrH8wYOUc
	 Dhtwu8BUTE+CGtqhHJAUORIg8HNowcij5S8RM63XIxMKg3pmc6zvyn6ihilmlmXMAGbwz
	 nb96AnaB9PuoGZfvjtbAdB6toTDJEZkzrOqO98FJWZGUDN1HIEyOrkcS5TtAosTYSO7x9
	 gkPAp/uFvDmCwHecHo2mrK7Sun5RcDRuo8IKnyxlq9exAo3EQfHyqE5kFV0ZfDaVM7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onruuKY7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DA606A325
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=onruuKY7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8571F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795260379;
	bh=Al83ExmFboZI8F/VtrwC9ONocMCKtiId0ncP111tvmc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=onruuKY7mCM+3e/eniMbZ7EUTELezPdXEUSePjFpNoUruoocPxK7ldeX1EsTFyY4U
	 88r5j/JnM52gpA9TOieI/iSsIq+yZg+VX6ihiyQJcspGFjhSkjov3ItwxRaoblnjvs
	 fsr4SmKCoofl7xixcDb13vLpAS2cFpVTZK8T69ksSJRQm7LlC8EC69QywM8IVbHF/A
	 sTL+xwJuJjeMvtHGzYn7YuMsjCb4nCOyfgZGuxCTyQtOk6HWnsEgTH2tAjAxkzF7wY
	 3AmYayArPPYWt7bKbHdMHLnTZ6uW6Qh6mvNib8ukNlE5vI+2yZq9pLcpajwd58Zo0j
	 W9FqpQO7CcCTA==
Message-ID: <sashiko-outbox-226977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] keys: serialise key instantiation against
 keyctl_chown_key()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261121111246.3478-1-enscrpt@pm.me>
References: <20261121111246.3478-1-enscrpt@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:26:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> keyctl_chown_key() looks up the target key by calling lookup_user_key()
> with the KEY_LOOKUP_PARTIAL flag. That flag lets a caller with
> CAP_SYS_ADMIN change the UID of an uninstantiated key during construction.
> When the UID changes, keyctl_chown_key() replaces key->user under key->sem
> and drops the old reference with key_user_put().
>=20
> __key_instantiate_and_link() and key_reject_and_link() hold
> key_construction_mutex during instantiation, but neither function takes
> key->sem. Both functions increment key->user->nikeys, and
> __key_instantiate_and_link() also calls key->type->instantiate() without
> holding key->sem. When a key is in quota and its size changes,
> key_payload_reserve() reads key->user seven times without key->sem. Those
> reads include spin_lock_irqsave(&key->user->lock, flags) at the start and
> spin_unlock_irqrestore(&key->user->lock, flags) at the end.
>=20
> [ ... ]
> key_reject_and_link().
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121111246.3478=
-1-enscrpt@pm.me?part=3D1
