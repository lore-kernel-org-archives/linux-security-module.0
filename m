Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677173;
	b=z0nImQK2PmGF5kVyJzK7P0gt+a2JK8N631bLQqVXVV176LrbZ+yxKeOIOefSJqnt9qv5
	 zRY3htWA60kesDDxn+pegrVL18PavaDruyTHJ5hoVzyQ3qIlwFNa6O4SoZxeMiizI4X5j
	 ogLhsJENtGw5yNF6OGDMaOywSppcF2XmhEqKvFYkuL2m2uIDYhBb1BA9t7W7hBg2KiJL+
	 lX413H/DVxdxMjuFwyHkTZ8sCPaNtsEBLSvt/ksmwEgoErJwcvzlT+QaNzw2KeQhUAYkn
	 u5MkD0jETFdaHqx3Sy218ptVhWVNTLTibd9EMK0zpZNKa7YGxhOmtwUTRlL1iSIv3FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u4ukNRPQFV7BiBJ+cvRQ2i1xT673HfQTX3b3wmOIXuk=;
	b=otxn5cow+tyT7YuOab0M11V+87jYkP69rNl4y6yWYHbdYDl9b7D/yHcX+xJSS+NoFxO+
	 YT1lLuVWJjR0zAccz+eo8ongGsuzYtJj9K2iLnPywfOvBzdTvOpEqicji4Ibnj7OR6z/b
	 f0uaia/oqrB3U1DN4XIPNgHSJtsmqzedtrEN1YZDx1XCJhOQidJIYAhJ+CSZ2ah6c+v6w
	 nzYN7Xwe/LTXSCQrZjxJ2QAVgn0cAEax3sWdV3CqGRbI6HW/ZLrmezKU+xf4hNnnTEyKr
	 srle48lIZa0wsS3B8Z0e+St2Knzo1+trnmxNQzGKqApJRaFZhQyqzPGTyEoulRcsp3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWFhK9W6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C55606A32D
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FWFhK9W6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7B21F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 03:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793677172;
	bh=u4ukNRPQFV7BiBJ+cvRQ2i1xT673HfQTX3b3wmOIXuk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FWFhK9W6WkmWFQtR1J29qdUj8SJNPFaiD8C/bvK5N0fBJltUi33El1+88bAC6vQu9
	 gZS6bJO/xlMkzvbVPYEoGcjJluPQwhHPQFbWJMAXbdYhd8ZyOX3dEnc2VyRCi/NSOz
	 4+9BphkxPiO91kUG/aNK+4RM3Knb95z+zWzLaa3WX7MnvQuCswGEQ7SD9hcPN0lcv2
	 m3DonQRuzREiDro9pIegPoGKDofA3RD40xkck3mTkH9yJ4O0OVe/GEVt8/7KclmmqX
	 PlwW5gawEMbsw/AAE3VjYaoQBcZXaclRcLyPcj94heLx7PBfXBALWtK9su1Hid2cFU
	 MTazMVp0V5fQw==
Message-ID: <sashiko-outbox-194531@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Protect pkey method checks against type removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103032940.51826-1-0xbeac@gmail.com>
References: <20261103032940.51826-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:39:32 +0000
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
> (925c84e3cc21) and update (aef3a8a4f988) methods.
>=20
> Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops=
 for asymmetric keys [ver #2]")
> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103032940.5182=
6-1-0xbeac@gmail.com?part=3D1

