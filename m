Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923882;
	b=WKQUfD9P70Zb1279EC47bI7paUn+JR2r7BBM2r8Vuy+S1YisaWbVPIXnUN0IkRbWeQw1
	 53Y7V8cd3TNHaDykRGOUvTBCR5QGQk4bfiqWzQBq4t6E684aUxXO3VJrm+zAltZpvr8IQ
	 L2FdNlyla+q6MvUx/KCdkR4xrMnP8XWgIxPb6TDimZDVpMeuskQ25rsMGLpdWak4beyqn
	 XXrDnp/lTu9rea8tMDywWADfuj5IPWzRo1DLKjY7kMvMFtOwJ+QqvU97ntFh3RX7tnIip
	 RUZ1SbR/SpZoG2o/LFCFdxdc4vSFICSOEQo/58okbpDN3+OwAgOVQCQ1fq3Mk18Y77w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923882;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9oSoDykzyXUrAq/jgQoCPDiO3OkMdwGQhuD9KNPskr4=;
	b=zrqvMhbuZU3BIfQqwM7FzrC18l3ydXkD4OgEI/vsTv/I6OtQw8rSZq7mlMQmq13VOQ3q
	 fZSbTbXLpxhFzvbw4C8RBDda2gWJvnhBTctS2TMPUnY8sLWQZOCeJuohi4N2F8Aq/lJ6l
	 7H+PnfD1ewM/PcebKLrGF11A+Z5cZmChmrR4d7qDD9vekFashdLN90M2DQMBP7dm0/Kdp
	 SHkYhZTkJev4znUCJekTAvlS9Hf5XDpbikkiG8923xHb7AX87PZYLZPZahcNT2Dv+LTVQ
	 /c42lXjCk3WohJuFGk2+/23dhohiIMnpmqhtEKmR0jRoOsGI0FHBop0w9W/ELBtjb8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJCwHEeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35359606A329
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJCwHEeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C381F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923882;
	bh=9oSoDykzyXUrAq/jgQoCPDiO3OkMdwGQhuD9KNPskr4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JJCwHEeWr162F7+Hh0QobKVBXe3hbHwrIkkHtT43lR7CegN7WgMlIvsmp4qB0FriF
	 tGrIq3qYHWLkCmBttvUt50kCu9cz/aJglzJl6p2QcOjPlMmsYtc8yIvP3NrJT9c6UZ
	 qoFJjLr7o0fmpLN0/mjkElvFJUJdm+RakyW+CRm4N0YAnr4dfm6n2xJZ7UxF0GBdm2
	 V1Ssh1oGllRGyk1wI2u5MliCVrYVLCExBHhPNKFeBuHehwcSXwANb4w3MFoFjh2jfu
	 iWYouJXHjNAb/0+uCuQenWTrBWah2DLD32RK9xNsf/m9AsSzqQ5EAyQvKTWYhR67Pc
	 zuVKxE0odz3ww==
Message-ID: <sashiko-outbox-218913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] kbuild: install the AppArmor feature set with the
 modules
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117135042.78238-5-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
 <20261117135042.78238-5-maxime.belair@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:58:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A package hook that compiles the policy for a kernel when it is
> installed only knows the release of that kernel, so the feature set
> has to be in a place that is derived from the release.
>=20
> Install it as $(MODLIB)/apparmor/features with modules_install
>=20
> aa-precompile, which is proposed for the apparmor user space tools,
> reads the file from /lib/modules/<release>/apparmor/features if it
> exists.
>=20
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117135042.7823=
8-1-maxime.belair@canonical.com?part=3D4

