Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282105;
	b=pmUGB8NSZE1dkya+M7RkOPl1OAnYyyp0iy7as4IRjZbYAJz+Sj1wp4SE3STYI82o66cH
	 6I3tXgnIJ82FC+Z9p00aws1IIefTgYH3ArqT3MBMl5y1IAcXbgAxP6fCBGQQqgb7ksEBl
	 Gtam/4cbVt/xPtbprw0IWAl2L01iqurxKzsQcJbvR2YzikG+IGjqNlCx7P0QuWuk8Lmk1
	 96SgKcvqZQG+gCjwsFksIXlfZ08StckEhhdErDlGZg0VPIbmfqGn17Qd285nup4rgVmnn
	 mzLYlyi2kmd4w2+hgdAPFt4oj+fGVAbPn8gvTOGGsELLRSkUQ2cCZoNJ/wv2aoBkZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5zTZM8GQP2kawea6u5qQ+HokFa52ipTdwNKTX3U4jNE=;
	b=KRH0hO63H7hSQtqqhRA0yLImz1g9+klOYfJ+jc1IgYjclWU7kh4pBwdeyCn35DUoR3gh
	 /4jRCURKAJduoWpSso2uosi6RxDFr//7PgAxUxQf/VRa29meUEXlL9I1ON/tsx0NOGA+3
	 EnhAY9M/D9j9MSbMyHeekTIZ/OwSliVrQh+UiIThTlKb0hUsKs5KLzeNCo1WM0aQrhPWG
	 bRXfALX1RFiah7qho6nVBcv1mSOaZiikeO7XEv4wzpRyHuptmYhDFXyLKV1BOe7UuZW1H
	 c9swH0OzZq898ErhOTpPoUPPP96XCR+mCrIVQ2NZq+xxF8zlkvZ23nKMeCF823ReH6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffuukszw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335F606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffuukszw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AC91F0089F
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 03:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282105;
	bh=5zTZM8GQP2kawea6u5qQ+HokFa52ipTdwNKTX3U4jNE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FfuukszwFrb8d74Db2F7fU2SFlHk/iI2L3B63qze8QXMRt8xcQMVR2QS9PqQM0lbE
	 kG+txZUqHql7LFKAnlQTEMsQgAVqiMiFnMAMcv/74fHLnjZG9lhjJ8MC60Nti6mtzm
	 H9CJaru+w3IjSHUy/MvEml7EjX6FLnrWELsCIDdXuSlu0gmmlTtGt7HR25fAbWapas
	 UB2V15V8NOZ4Ub7mIIbYv4YCyYTnUmrnWP6fiyImF2XvrAKwmq3/2U8c8yQuYHc/t5
	 Qd3lIDRES/V9gd5QJMg8g19oZgMU6pnG2M3ilFCWrmfBZ3P5t7IdfYuO36YXc/nsnb
	 CVIAyNoQEZDhA==
Message-ID: <sashiko-outbox-206135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] lib: Remove assoc_array
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110033738.2495880-4-jarkko@kernel.org>
References: <20261110033738.2495880-1-jarkko@kernel.org>
 <20261110033738.2495880-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:41:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> As assoc_array has no longer in-kernel users, remove assoc_array
> implementation, includes and documentation.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110033738.2495=
880-1-jarkko@kernel.org?part=3D3

