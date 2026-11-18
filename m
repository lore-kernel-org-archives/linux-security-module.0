Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013911;
	b=p7XU3pereBC/DYRe4OU+jrVRGvbJqDpb1BQIowB6MU2+svMQZpuyzaCWVPxvCRC62au/
	 ZqrKpcjv6KgvwFg6P/kHwW59YMa908t4Y0w5XItUFJIwrzIzogRm0JJ39phT81TsRPlvY
	 g0u9m1eYdsbi258BUI43047zF98OMu72EnJNw0vHntU02ouyyOCP9FsVQ8MXxPHKgXBDN
	 7deTSYOBUJCmd0y6eYZTtieZSFhvtQRmMhOJH6KahqDz4WuGLi/m5Lj8yz5VYME+xrXWg
	 hBPv3mciEEc/Wxrq4CY/ZIH6yOQ0rRddaN4in57DhmnuS964d6mFayQGIT9KnRKLo2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013911;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WOyDYiQxP1lyXOtv2kp/tg9ktpCnTFEtjhidiYABpFI=;
	b=X9wJ55mbCtVEqdGS0GGhBVwUvROT7XYiNwwsSQMkZ85sY8jPY4X4m+neIm14PUQpEE5o
	 Rdd1UxdTc2KuK9DbkZCqM2sPWYnlV1Ney2To3w0JSAPCMkFubStO4LkpXM8F7UT/n0SXp
	 WrP/mnHULX8DVfUYoSgxWecmu8xtY5qSCEbWWWJVwn4BvyIrNviWamPKKoPOl2OJOf94g
	 OVtzuwvvFXPV7w219ottPT4hwbXTXfBl6/pLKy82aZHDO+KCxSKU53Q+xO0dsc6wA60YN
	 cVYJvhAgLc1SssKc8OhDojIGIBpLJxr/TK8FLNasoIafmqZ6x7mSNqly5BKsIgfImCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6FGFASo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1414606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6FGFASo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B20D1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013911;
	bh=WOyDYiQxP1lyXOtv2kp/tg9ktpCnTFEtjhidiYABpFI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=U6FGFASoUqzChE6Fz5/pjdzXOB+w9M2lrW9XbeSIXgxgdCtF/ANmDuC/z1LTIkRSl
	 7Pc56efRbEkYd1p9AThfAiiBWJnAJjqVJ+nLaQ5OaejWKpHCw6LCoDvripi6P3Icn0
	 5kkJOSciGQ1hPluM6ypQCdK/qYC4wcuipAqt0S3tE8P9Ty20QDYs456d+NLbiBoYtJ
	 9fmT5RoEf11EpYlQHNsBdqiGk90UuyY3LcC97O15/YThh+MfHQfBe3NQsB74xNfumS
	 4+5M10nsVkZX4xy5Wjn3J7n/1VLa6je1LlmEDmVoKkX6JAW9j5VtQ1Pt6V17dfCr2C
	 sWbOD1lOUrf1A==
Message-ID: <sashiko-outbox-221274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] selftests/landlock: Test capability checks
 outside the capable hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-6-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:58:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Test the commoncap checks that the previous commits make Landlock
> restrict: mapping below vm.mmap_min_addr (CAP_SYS_RAWIO) and adding
> inheritable capabilities (CAP_SETPCAP).  Each test checks that the
> operation needs the capability, then runs it with the capability in four
> variants: unsandboxed, denied, allowed and unhandled.  The mmap_addr
> tests skip if the architecture rejects the low page before the hook
> (e.g. 32-bit ARM).
>=20
> Audit tests check that these denials are logged, and that the admin
> reserve check and allowed uses are not.  The admin reserve has no
> functional test because it depends on vm.overcommit_memory=3D2, a
> system-wide setting.
>=20
> Add CAP_SETPCAP and CAP_SYS_RAWIO to the capabilities that the tests may
> raise.
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D5

