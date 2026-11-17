Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910858;
	b=3N8wVWikgryCq/Fo6sTPC2lPBD920aAF/YdFCI+6yCwGDw7wei/2Ile7Now5yO+BGswH
	 33B26azDKjka2MG5yLUfeW4VlpbGyEYl0iYPsgRamNJnzICzntIE45B0kjfT5mKEn5KHR
	 WLHwQwcdlkb1DYYKWdzFQSvO53i2UsLC2f1XyZHaTlsbrnG5QDaoUigoaT/fi2MuzCvan
	 tNT4z9TIo4H/IQ0qG267NJCPM+o0d5xSOeqxutNDaGvPOAhqgoLcaMtqVuhYjafFTvfJs
	 4pRjAzvpqsPAR9gIbSRj7sWqee+BtaoMSyQMVCqArnjd3qZFVXVRNmyQwQbZp9hwmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RTczeQPHN1ZHUM9tmipaB1FYp63sujmRh+ljPpD9t20=;
	b=WIZn7OtcEE/s8hgf8WRPBbkJvZpf4fwhj2QV0jHZJBgav+itZJ2dudM2r46mn6dsvkyL
	 x8zKEYMNFH9Xpmppc+/Y0Zpb5kSaPo2hm6lxaKx0lsEzWuaH6Tg20urbVVuqWYJge9jO2
	 za4vQMwE8eF7z8wkmo2f/PDU5zFpWIQD0bI0p1GRsSvAEdLoYquuW3TStNaTkzOTdVn5m
	 4Z7LsOOQqXdql9Im1ZaR3w7qFmLDGAtDliT5GTRTso3HEZrMryUY+E3r9fmD1AjHFCbbW
	 TiZeU/FX24R2kKOeRIDLMeCHp85g6E6evODJ9xATypaSeszzQmf7iOJNgJTGad18d8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLNHHZMc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2FE606A329
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLNHHZMc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BBD1F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910858;
	bh=RTczeQPHN1ZHUM9tmipaB1FYp63sujmRh+ljPpD9t20=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZLNHHZMcEPT/Yfe7odgGOCqAMQ7apaeCTpdM1whTRRWjHNbRI/3t0BrYtMtcdOxcd
	 PI/Kcx6g8aD1pMxVJC81vglv4kqsJQqYn5Cg3ar7F81Dc2GzD+53DzZNP0LV+bXEvR
	 Te//pTJdI4o6dfTFiZ3Je+NisqxDwbALmewngkHApeLAihgKt48hngCP6tIBe/4IXL
	 iVPa5nso+8cYbrs/B08G6xGKor+1IZ6MhntlJPgUfvNXZKJx1MLG0XocgbiKaZC/I0
	 nAT1BXjE/CjWMRqLIOaPpv9A441YkQkVVS7B98OBkpEmaj6RdAtH7P785gdeRCcctL
	 JpCLOTadXd7SA==
Message-ID: <sashiko-outbox-218595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] selftests/landlock: Test capability checks
 outside the capable hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-6-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:20:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Test the capability checks that commoncap makes from LSM hooks other
> than capable and that the previous commits make Landlock restrict:
> mapping below vm.mmap_min_addr (CAP_SYS_RAWIO) and adding inheritable
> capabilities outside of the permitted set (CAP_SETPCAP).
>=20
> Each test first checks that the operation fails without the capability,
> so that it exercises the capability check, and then checks it with the
> capability effective in four variants: unsandboxed, in a domain that
> denies the capability, in a domain that allows it, and in a domain that
> does not handle capabilities.  The mmap_addr tests map the last page
> below vm.mmap_min_addr, and skip if the architecture rejects it before
> the mmap_addr hook (e.g. 32-bit ARM).
>=20
> Audit tests check that these denials are logged, that the admin reserve
> check is not, and that allowed uses log nothing.  The admin reserve
> check has no functional test: it only has an effect with
> vm.overcommit_memory=3D2, a system-wide setting that a test cannot change
> without racing with other processes.
>=20
> Add CAP_SETPCAP and CAP_SYS_RAWIO to the capabilities that the tests may
> raise, and drop the stale count from the comment of this list.
>=20
> Without the mmap_addr and capset fixes, their denied variants and the
> denial audit test fail.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D5

