Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758917;
	b=XXZHxTS7PAKoqh+Y9glwqSzmkPkj/8NH4aXYc5LlwUaXFm+eSQNEWrCHy+wQ0Xcj8qxP
	 xttngmtSco0z2EoGqG655s21oX5jRq2KysK6gbIVoxccW6UaxqNdAvj371yph7H4yHzun
	 SFL1XuH/mTb88xPt34xVKhGJGdAsp1SXF4pzQQKnzbOf9j1LOBKhmCnUsLYilZ8j6H01T
	 R6lGSth47Ad6fWsj4Rn1LtDkS8CkaBcbmNDLTGT7QLaM9Qkk0uvPaQ4sR03JjEL/rSncJ
	 mghDOqJl7WSR+Id2dgGg6VUuTw1C4FLd0kTvyqIhkuEpS8Og/bcphW3M4W+IX7yCw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758917;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E8CXWtqYt7MJlxuhRX8BVa/5yJCkRhxNBr1pr/b1UL0=;
	b=kSeuAZ37Yy32fLs14ogv6OB0rR7tQXYp3B6hn4OSjSPZuG/ERFLCC2KDyhrnVbVzpGww
	 74UjRcbO4Gl2pmGylY9bsjLIINWosBSzcfZo23rjLGCi+98eRS9u74oy5FcruPfqSY4kr
	 FArLHsIQJ3WqtOL1PItXLqsLVfiIDo+w8t/UuVYJIfWP0JIquMypagugZhYRqFFl5E0/4
	 MhNIUHI63A0+wkUd+M5rQNNU9iU8jVo0alO1NJCGlSPEEgrPFPEDAN1WMLxVaw48TlraI
	 /Kc9FWBWpo/EKOu4RJkc+Krs3B3FUyuKMzHOo0/bxjHwOFxhCoVPNTma1goXulSzgVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP4lrj0s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD19606A320
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DP4lrj0s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D339B1F01825
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 12:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792758917;
	bh=E8CXWtqYt7MJlxuhRX8BVa/5yJCkRhxNBr1pr/b1UL0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=DP4lrj0sflVIqx+YyELEg/ktG8OgbILtWOOWqlJZOcunl5lKCpek6opLuPsKz1XCn
	 Xrl+FrWY9aoawa7UDi5lYs+g/+GSWBLIEU64RKw0N0cwcUjDUHSEUEcqpZ6bPrLLt5
	 uwcSf8jQu5UW0MhqyKkswFNJKslB/0TL0xWqpSpBcCS+HhK3X21wIinrfqubH5ZpdP
	 Hn+C6ycG4mYz/QDM+QTzKUVw/RQKvFGM+/SAkQAMuaXMTpI2g4uf+KTJqnqt0X1BkX
	 br+Fkc5+gVfiyVZGm4cwX19YRfX79NNtaZuUGpfa1TaRHqPP+wh+vd8uA3MfcCHwM+
	 EEBknyFBWPVeg==
Message-ID: <sashiko-outbox-182778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261023120953.1206778-5-jarkko@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:35:16 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023120953.1206=
778-1-jarkko@kernel.org?part=3D4

