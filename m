Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673784;
	b=LPhl8+B+xvjc5pv9o+8v8BiokEmSQ+6KFpSEt5VDiPeVOEWBBTcAArKbr9VJ7rdgj0oG
	 fbmwcD92FnyaXXTDrAPqphSL/Ffp0EjGzYOrEyqxd6xvW3hE/5FZszbXOpxJS57bMzwVF
	 5lH1vKeeezk0EOsZxOaRiD479V6KL6IEGQH0PvsRgeiR+Dhb71BW8l/pM5NHkbT0YM6tE
	 GFsPjfgdmhnBjrKe1GFkMBAOIxq18BOoq3ttqyOf+lMWV9N0oKsenvPyNBVXLgjIuBmn8
	 X5lg+gzowD3a9+m4Yi+GZ3vmVYgLK9LnVdm55C3ISqVp7+81Y6ir/rEanixeTnGcpHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BkavPVtr2X+HyI2cAgxf1qrL1tbHkM1v5+TxQmZjduA=;
	b=TxaJ8LlovXBTrVOJAPoS1cNV60ej/vuWvYcm1s0dGf383pHM3LpNeCkwWUlP4GdHC60g
	 /J6PYKLoiOasoi+cTnZJuOdaDdpGVV2m89J9fqI+0Ogbghn47qV716a3Lo9+A+Bv8hTcW
	 NV51Ba9tz+qELZKLiaPHz2j6/ozGnlwgLwK2cfwegYNdIxiIqOw/S04SkOojYSY6BJ2yj
	 Drp1QK0X3DUrd3Cyngg/RGoyxExcKXaSbNo6xtha+7Iig4RKw+rAfjydkdTqBS6zOOWlo
	 ++BBHQ+379oJVbfHvHjZJsxBbhZ+pc2UgFyToQKBRaS1TVmEJP5ltF5AinyHlox3DhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mkp12pP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF9606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mkp12pP3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B5F1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673784;
	bh=BkavPVtr2X+HyI2cAgxf1qrL1tbHkM1v5+TxQmZjduA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Mkp12pP3dDfMGkg59hO4RXZLZ9WTkkLJVmDBWdGUMIWEmWTmwJYcvi4Iiet1RrgVW
	 Q3EFietwqNvk210HVva6hijxjRCOpL5RscUXnFu2F/RXINcekNHe93rBsQTMS3QRLg
	 Uv4zAzafhRTeXZnOxoBAoLa0mDO0SZVShesHRGTVipC+9AqkE5goQMNco2qHx1n/dO
	 eppdRWnYzy1b9wTb9W8jE1cz+j/sSDzYBeVxBUAk6Xe02PTlpKkQmXdpB/KyKN1jdr
	 Tpbh6tsDxteKM1b2uNf+GOjizLYkKYmyRrUARqb0qZ+93P7TsikaGYfkD1Pb9jYMEY
	 bV1ELOjYDggNA==
Message-ID: <sashiko-outbox-214751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/6] s390/cert_store: Pin the user session keyring
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114161211.376859-2-jarkko@kernel.org>
References: <20261114161211.376859-1-jarkko@kernel.org>
 <20261114161211.376859-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:29:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The user session keyring stays alive only because the session keyring is
> pinned by current_cred().
>=20
> Pin the reference at:
>=20
> 1. find_cs_keyring()
> 2. cleanup_cs_keys()
> 3. create_cs_keyring()
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.1+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114161211.3768=
59-1-jarkko@kernel.org?part=3D1

