Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602984;
	b=lcTksGkuAunQB/75aQgOV0KHqohvCVnxg28WU1C0ThlvtyrFQWsOZ/wPsiXlsmz60kfQ
	 8ibnsFdXf012q6YVDALOs0E/jfIJObX1aWX6QgcvL5v2KAsSZeQeSNDc7zWPiMwxt6VsJ
	 DrOBBUxMjosAZTHruiKnJ0rZh7qzNF6ML1w0L490vZwCW0M4WdBcWva/4rUhswFQEDGHD
	 UDEjB4fV9Ho7PwAB1p2sfBFy0h4bEpGaHM8eNYcDnLpnAJD0K+cU2bePCdxAtG5Jv4yOc
	 DjT6JuW06qFE3Q/GuefuIosMYssR5tshgYpt2a7mGIjBxx48l5WSf2FfpyV/Wcu4hbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x88E0WmVnjnFT81cTWyJ7UW3Ia5B+T6VvAg1kX+aDDw=;
	b=1JDQePATIy17IZTBcs/SNIlvvU+P9YNFMOwWvTA2r85qoFqig2YwQL01zmesdPldxh/i
	 mS1lM7P/pRra+QOyJAueICph7KJoCBjHoR4dLqPsMrChAcU7Ez+zNRoARGRC6yX6N1van
	 St4B0d1pvavd7p2347Nusbc6Vcv73mIpKL/u8/0v8x1hcFQw0iSKs2Qz6ZV4kGe84kN5m
	 JstBgkeri8GjFRh5qA93k7w6XlwWpDx2dbuTLkXFgXvUWwMSMq8P6OQm5hu1UycUGAh4w
	 kpJ6e5d3bAGSMPGpszasBXQ0YGgEOQM0AHjOh5vKqpLuji8fobb/7HhTQzeDIfmlVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1hsOKa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4A606A32E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1hsOKa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B871F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602983;
	bh=x88E0WmVnjnFT81cTWyJ7UW3Ia5B+T6VvAg1kX+aDDw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=K1hsOKa1v2Uy1hxdMCipBy5qkx0SrquCKGu9dce4S0DGwo62+/Wn6X32/JwFMwf4s
	 w9LGpsE8KbdSLwYzP+4xhlT6IszkonA3uls8pvxgGtPBT3xWJYZSG82G8iWMpVHNem
	 Ltt0MXHLSWn6hINUeng9xJgL0Z1mE36y1FSZ180LqHDCbEMX+USucQzzkgrhBPiM/o
	 8w7IVxmpdWlhQz+OBQCARg8hc62TDtTZqPaU/A0gFy6AuiactvpZY4zDnJ+BVJfFlR
	 yJtCPTm9vPrK/RX9c8bN+fVtcfrqFLOcFI7IEZwB96gVEE+LzHjPwBRaCTj8LDB5OS
	 eHsYKDZbclASA==
Message-ID: <sashiko-outbox-213683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] landlock: Clarify implicit handling of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-5-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
 <20261113-b4-landlock-refer-nonfs-layer-v3-5-02d7e42bcdfd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:49:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The LANDLOCK_ACCESS_FS_REFER right is handled implicitly in a ruleset,
> but only if any other filesystem access right is declared as handled
> in the given ruleset.
>=20
> The old documentation was still a remnant from the times when
> filesystem access rights were the only access rights that existed in
> Landlock, but it became misleading when we introduced additional types
> of access rights.
>=20
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-b4-landloc=
k-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com?part=3D5

