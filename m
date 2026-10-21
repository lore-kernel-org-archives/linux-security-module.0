Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792617990;
	b=AZAByGYIjspDeQ7Mx0+NPFaCObo6uXkMx7FgSkuLfK9ppGD/61CYwBhpj07KOAqzyH6D
	 phj2KAmqCdPY8FOPpGU6GDN1Fnfh+JRciM8UnFlJ72YWcDBZscVE9FSlZVEhpen9elctq
	 i+YRBD4RBTObpCDULp2rcYD8crSTk6WaoBKmVBQ602j9O88slK9pJCYydoUK2PaZl5gFV
	 Gf47txhu97Zzs0Krx+zO1VQgVqAJ89eu04A2j+C3GXPVr025gyL6/ZT6wiBMdPvjhG0QT
	 nOuYbXogdAb8X3Hc/WrdWcYWX40ewDi4Lvcpi1gCSFlmu4aMsOewR9wl00uyRoyzOhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792617990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VLnuxmwP1TQnLQNTlK9ZQ9NqFY4JmYfIlNRBoFNExOI=;
	b=ufLzrNZuBrTv74jhHRHWoijP3ree1qs4x0veXmdcryv8vZO+OCiEB1JWMoJhSsVmSVbo
	 gkn+yIUJONqvYCx7goxafyyl/x9Dhrc5dYc92HtVk4AxzmS4ap3vRZDQMuptd1omtfZN+
	 Zvya6hdnQ/UMY29badpXB0mpWkRK4yHe7a2BeBE9/kW80zvm2ZM7Zfr6jqEmE0toF8Dad
	 SaqJlbLJ2R8soVs8rGDOZ3hOfbaqC7/1T9th/B4cNv1+5p2E8EWG/IFo2QXQuDojvO13n
	 ZCMyFSKFedX47Yix/jQNAqrI8sbtNGq5RaNHyxWOjhGmTRrivwka78eaUhHaU0XnN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFoAw+9P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA40606A319
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFoAw+9P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4A1F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792617989;
	bh=VLnuxmwP1TQnLQNTlK9ZQ9NqFY4JmYfIlNRBoFNExOI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SFoAw+9Pn6lmxbo8Az5tnDv+naFdoEgkeceFEOYi5APX645miDVvO87Et2urQ44fl
	 MGUApSgR0whIBAb49Ns6KYKT3ai7R+2ShVgDPOwdYNuNxaQBKEZ5UJ4YDi6mqNBcgY
	 mmqB6K9Kt2ygvNoCEfqxXza3npXlzpJQp18akJwSinMnss0bocnZ/KrPviGWRmeDF6
	 7/iQy2pZ2D6/F/5j9dStBH3biocCzS9K3L+HMYAJEGSmO7pwWuXkp5QjLus6ynIMI8
	 WAAoLbwAeeCG6Lkx4lO9ZmB6+aZdRbqP7ZJFDUVb2IFwHt//TXsmm540m8lQ/DUpT4
	 UOoD0NHS2sbOw==
Message-ID: <sashiko-outbox-180697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] ima: audit failure to supply detached data for
 modsig
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021210145.1851396-5-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261021210145.1851396-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261021210145.1851396-5-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 21:26:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_collect_measurement() discards a modsig when detached data cannot be
> supplied, but the reason is lost.=20
>=20
> Return the pkcs7_supply_detached_data() error from ima_collect_modsig()
> and emit a separate failed-modsig audit record. Keep ordinary collection
> errors on their existing audit path so both causes are reported when they
> happen together.
>=20
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021210145.1851=
396-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D2

