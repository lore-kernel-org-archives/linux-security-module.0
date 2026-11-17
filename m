Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794919710;
	b=u0sh2DY/qNe3oLM6RHtjcCrI9efjhaM2F2BjasOdzhLm7jmATDaYN3AyaqDfvhDg7ylV
	 xQxS9utis/aedJbUO00ecNrc90HheHTZ8Pc2n3BV1sC2wNngC3zy+00QKhUokR0Kmdl9X
	 afUMn/Uz9h5VqAmdmd95kVJVjgo+RZZukKG9IDXcOXecnPuHr4KAUkMghZCcO0+lk08Za
	 hFE7u2b5r/EipX//ml7s56XogQXZEnx/Sl1iN/bu9PJZhhnJdWiHUJn94VSeZgBoUATS4
	 6D4TZ2nDhRxmQCp0miXmdkQ/ZLS9dMVYszn/sHMpO/IdOUD+KI2XSyrOFCGv6sihxMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794919710;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xf+iHlor4VtM/ptNpw1F3TuKJhTc19vcqQ+KhYNiW8s=;
	b=DDt9rTAn9CKbo9BCbtJpzagDzfNpeH6xmdJrA1F4T+5MbSp4QsprGEMAncPxiEgLNpcQ
	 2nwu2EG+8JQicgilUytFg6eEL+EILOcOUMXgbk73n2hscg9ZO2E82lyXh7y73FlpL188o
	 YxaBxz+KdqUDwTTB3mrFcjLrUnfgTivXyIdXrPIy6GUZCpIK+SJg09rQiclz7vTj7z3vK
	 bt/o56Di43uEEJ4eBdMIX9qLcjGJZRleiCWZ4Rl0eXcqhXWiKihNVy8f9PMKLYXja/gCn
	 2b5f8HPdOWK4xsJs0bIZIvOszLUbbpIEP1AEbMkfvckfazkoxK4ovoo4Maa1vmJYVmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPVJlSC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F7606A8A6
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GPVJlSC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC8D1F000C7
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 12:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794919709;
	bh=xf+iHlor4VtM/ptNpw1F3TuKJhTc19vcqQ+KhYNiW8s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GPVJlSC91FZ5cHV0Iy4k4mzScE5EYY3Pqnb0E/BssS06DKkbjSzLl+OmXECdg+xz9
	 FM7N4pDrGVSL0LViBm52NAhbLrjW/k0xMHnW9h+LGmiorI5pFzQALEZJupRCqeQFn+
	 thRu6qjsXs/UfCgJ2am6Bp+IS7kalNHAbJG0ey35NAmbFQ8YO/t5Q6XFZKENU6GSLb
	 +uOOPzzffGEBhZcrU7qOIbQvR2v7XhvRnq3WuDqGhFNFqFDxLcTBkWjMEbpyP2CdCa
	 k56ltHaCuz/D+ZR974vJ1b9q1OUvuv10QVwhjlPSFrlWECW0zFbGkSGDK7ZK2G7TI+
	 pWvclQVYRE7Ow==
Message-ID: <sashiko-outbox-218793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: serialise key instantiation against
 keyctl_chown_key()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117123353.1822-1-enscrpt@pm.me>
References: <20261117123353.1822-1-enscrpt@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:48:29 +0000
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
> test logs and wrote this commit message myself.
>=20
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's own=
er")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123353.1822=
-1-enscrpt@pm.me?part=3D1

