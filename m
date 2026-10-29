Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235014;
	b=AV32B+CNQlBX3LEWVY1vhWC+SDIW1yNzvS1LUSnpdmvBtXTfExLZ4Oo8MhoeUkfXcfkX
	 AteGGj7BElwSXoG8yKWlC8YihTBbvaxOeA0K2oO1AHcB3+PBK4zgK3Dbb+Hjx8jWo9OwI
	 QKZsJf9g5vTrGKcj4i/b2mumHjgALzleddI+giYXf7FWWsxXojGXske07Rcood1wHxbbS
	 Rt6B6SGib+L5A8zr1iVTv0TVu7CJkK4KP5kMvMuZT1TmTo2EQES6z0195mu+MT+IYiwp5
	 oseRTcb9m+i/UUTTsJ7NESI//Z+xCcVZ/yB0XN7N7PNRNIfOlKbV+NNnm46VVafb34Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7aW3SNhSUSIi1ysctDRGtYGQ7IkOUSC5skS7sMS7T+E=;
	b=Labk0jSzNW8bRX8aDrFP32b53v7G8EjbqthOa+b6NHd2cQsA16LbVFWH4qqDXPZV8aiI
	 3lOojVAdxHVc91HribNxvNMBkJn5C7dfdYauKurahs38eL8Kbw2zk2EmCgQ1vBfiNPnEj
	 ti6TTXQWqI1XIisiSthqOeZnXpOum3wTMjqKij9H8rJkoBDxfXfRJgdgqn/zsk5bhV7Z5
	 VY9ALBp4EPZpmhJ01v74bvqjCuQ7zlxUC0Glv1uBb0LjaI6t2WKwy90udm3P4jNEfm+C/
	 f9/TNeHeHaZj03pea+jOn2Y4N5Z29vkS8T435zh6vCGr/iiN8dVHKQutPhmd4ihDFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPUCLkDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07B606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPUCLkDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837811F01825;
	Thu, 29 Oct 2026 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235014;
	bh=7aW3SNhSUSIi1ysctDRGtYGQ7IkOUSC5skS7sMS7T+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPUCLkDOxtS+/1irc2z9r7ZSkBhm/ASMPZZZ4gKwIP6wE3LVm7ncUxswU5jlj4hFH
	 rAlXrA4XmXpdFFSWWYUMDDxLuzQN1HolVZ4Uo0w3rPxYV5SyGDHCRm0BOt4wxu5hki
	 BAwnEVDQ5UrcFR+XiMmM5Ee//Ao1bnP1M1ncTo9s2fFoHw+rsD72KRldwrvIxLtZ5q
	 pJtk64N6wHBX81IkOmZwTSFan787hjmkWRqrFCz8TpMuqOs+XgzCOac3yqJsVkKK6I
	 LPrL6bHo8MhzzokG8xSZ7BKuk49XHaSc+AOjzSUC7w4wdjh5dqltmXsYnzv4sF7pUR
	 TT0NFtt4nnQ+A==
Message-ID: <sashiko-outbox-188578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:50:13 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>=20
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
>=20
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> [ ... ]
> build artifacts. Making it possible to use an ephemeral,
> userspace-provided key avoids shipping a static policy-signing private
> key with the guest rootfs.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D1

