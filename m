Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790567;
	b=wIIKoj8fmgKl2DEsd9Wf5vgv4sV13zXkC86j1KwVxOInPzHftpupkXFjNgwrQ1g4/8CA
	 qCiZ8QK1g1UMl0ujbpo6oWEELuD6joGfrSZZnBGE0EIpy93Cpyb5EoSVTkKv7bpmvbyYh
	 RNe+JhYkh8KfdcSXtttITaJsu0MIZv9CxAoESS9QgwIKab1okqhlIr0wjAJoKs/ggLAyl
	 lX17fbLHxy+QUphbb3CzXzM3fgAEf9bffYbigkjU0uXxNG4kwhfvBSbZRztla3B2Nl5cV
	 UUyUoWc8lI95k4BMFtv/qtJOvzf3/+3GC3NLcDjIWDixm2SZgGQ0v7VZlSP+K+5zx1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790567;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rqago0Lpxt38A+CoIPw6GPhpH0Kqrf6Bi2Qqwds4qnA=;
	b=rCnt6nUaHWIqEWnDznlP98Qc0CJz+PEQYoTYRF3f6m/NmljUq/VM+3rX7LmHPhTnH007
	 sEQTT5rIkOILEm4CK5HeAkIFXY8a5SZVKYKqy1cVQVe4LWuLgqNnoLmD9lsesycKUpmQ/
	 vearkORY4XF9RFoAyovnpxnP6f7uUePf7uFSP4WBN+7JEOZiF6RoH9SoZamvskLphGBhm
	 1l3oIViB757pnzhJCD4e0Twf3YeUP6eGXhdyJRTZCC9TzflpUdiapDdzi/lVpAyEdXWgK
	 dlCCJ9EeG/D/dAe6FQEQo/nSSwMXzhnb+0IjLmDhHnknYLqoTtVoOaaxU6vrSYas2dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzhEgkpe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF6606A31F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzhEgkpe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C72C1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790567;
	bh=rqago0Lpxt38A+CoIPw6GPhpH0Kqrf6Bi2Qqwds4qnA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dzhEgkpe17YRbWXb4wzGafBCsuuOUWya2ws5LeYtP9IU/RBwpX1fuM4TKDwyFcsrf
	 Ul1d1RLYEwC3uT+0L5l1TDnleBUL09LzV746D8OFU9JjwSByRGZryFkeeMxQstX+bp
	 LywmtxDxvdqjHAcORmJMfPzKr2UEvCkqYj/Wb1GHR9DxxNod2y0M32R2rArid0qVfL
	 vJZ29zjR480MIXAA3hicYXTsyqu07MSX1ua1j/0wGWhOxXeOrA0Tou258Kxusb3GLZ
	 tZlrvGhn8Hud2EvznhjioJnO4FvlKhc0z2F+/fD1bf0eswlqfrsWS3m+69fl0rZKCw
	 XkoADw7vNRQcQ==
Message-ID: <sashiko-outbox-215976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KEYS: trusted: Open code tpm2_buf_append_auth()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116005105.1573016-3-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 00:56:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> tpm2_buf_append_auth() has a single call site and most of its parameters
> are redundant. Open code it to the call site so that less cross-referenci=
ng
> is required while browsing the source code.
>=20
> Reviewed-by: Jonathan McDowell <noodles@earth.li>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116005105.1573=
016-1-jarkko@kernel.org?part=3D2

