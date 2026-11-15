Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785818;
	b=d4L9ZDvZU4GJ1BvRS9ntU3NZG3mzp0VAS3m68g3cq1xToETcBnIg1xs150f8E3G16EvR
	 749d8LU0htbWxAjksVDcS5BAqml3h+KIte+hPOLx/tEDZNprWUFnaNSLh5g+FCiQq6zic
	 6PGte863JfIgNu2yugekUIKmbxL2nbDfdUKw8d+1s+Aa9p6UBK5NsE0lJehSLCaeyQfI4
	 LIUyJCaM0tmDnW0hDScbZldjcpf1EZQtL6HOVSDjbA2P9COlxvKc/7Vr1hnrKekXVtIqJ
	 PeR/paxRZizBV4eRoME0HzTM//Jwg3ULCgcWuox35s9lboFplkRLn1BjePVBESmvGwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785818;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=72KgbpZoitRdzva7mcixZWDA0x/pIcjrIkmPkIW0i3A=;
	b=Nlp00EgkZJkzbwXY+ngprgpEwZTLdxyYOZZNGDu6VXml8zCiaqJHnRWYpmSN/6oqJYXT
	 DeleOikr07KtLXB36kHPEyqC4BV0N+oFp5Zs9yUATmYC0NSvk30TyUm/AGsDGKG0UVPZ4
	 /DJKOAyXh5bU6lncGXb3cGD/nrbXLSMtmHc0s1gEhLVpD+incmoX1X4Itn7PiyoHijj7E
	 kqSbg930oi/pzfo/n73anDDYxIEj3n2EPLCoxIFdR5XDImaLbtZtYRK6BKKkU8yWAZiZO
	 OyWxhlOzBTZLz2DTW+JjWY7+Ms6/ZXvV9gv7jGb7bgN6pKKE1M/kalk5/LOvwtN5NpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxG8lz+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF976606A331
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwxG8lz+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4068A1F000C6
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785818;
	bh=72KgbpZoitRdzva7mcixZWDA0x/pIcjrIkmPkIW0i3A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LwxG8lz+voqvrAXZv3NBs2EGYNb7vm9JOtQcjEXDNQZT9J/KA0rtc5wirJt7ErG/K
	 rZ45bi1ipGmyVPIN1a/GxBMQ8VrVwoTWK/UPTJriX3ajYrTrSZIqXzcOKywAifPbDd
	 gTEiZGuUPaKHoPdyFON4MAiwskNMEd61QOEUflS8KYuXKBYzABspxoBCS4abi9qIRX
	 OuWbxuKjg6pl1xNcXkMEybJ8m01VvL73Yx46yokx8viv1XnVj4h180f5/k0gsr2l+d
	 4U2FQyUo0YP6t6HHuh4H1v0N112RtgneaySk5+Z+L1gGfL6W0oFc0zW46IsgEoGQEj
	 qEijqXMTcy5sA==
Message-ID: <sashiko-outbox-215907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KEYS: trusted: Open code tpm2_buf_append_auth()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115233156.1485238-3-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
 <20261115233156.1485238-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 23:36:57 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115233156.1485=
238-1-jarkko@kernel.org?part=3D2

