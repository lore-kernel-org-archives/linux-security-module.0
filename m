Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673594;
	b=M3WH7pPH1bvDl0tnsNKdD2Mpgoc7TYsM4KgCGM+LCFDMzJg1T0uDIufP2JwD/S68cCJ1
	 /0qe4b7etlU5wPvVqFXDox2dbuBAfnkLYbgy/W+CAkLSgiTFyZb+3fAivlJz2eky+J8Sc
	 gSP80oQq1y9OGLNuAdDOEJNHOfpZiJUutvv7NFnvUyQd44rVPHwC24Eq67uBzzK/TRWM+
	 7X7sOLNR5F9UswZ0ubERF5EiNDAakyTXyOYs87vmiya8Hg3ZhbLmJYk0oB+hHTsQZKoDn
	 AiHHUf29zdZWvzOz3wTOFbz0+Z8IgCcIFpwqugwTF1JD8TBnvdEq1+yffNvnPwdAc+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ugZTuagioKRu7pl/IHOlwTUUVC7z8g9mL/tXBK7RoG4=;
	b=JVZcllSmMmmvghl/ucm1lhZ2UJt5PIt/wr/QQZziotWcM9XQ2YuLJgaD2qJ33V14MzKa
	 gUFBmswIWhHfEElfHmnwhOK5r1eVPL++mqXVsEZGpqtHWGUIie3pTeDH9nAI0QG/xLDDp
	 +oVuLiJ4uk6sGJ7x+0SoQ2wLQx8unATXJ3AZFTlW1ORKoEfMpT/bpqxJAkUAd16ocVFmK
	 mQMOpwuIYKG5W4fR/oXsdwpgidfWlVOc3GyB1Me3tYzMHd6kdsEb6l1HBl24S9Ad4Z7Eu
	 4ai4gawohDkEly/m1VEA984cGpVDSKmF+m0F/85vgdqhg0zut5qBOt+WwwWyibnILsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZMEN8uQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE3606A327
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZMEN8uQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8C71F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673593;
	bh=ugZTuagioKRu7pl/IHOlwTUUVC7z8g9mL/tXBK7RoG4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MZMEN8uQO4ubLlafICLZsdxvcb0NN57Nw1qPot1JYsDxFLuweLj/2qiWObjl8wb8u
	 9SeQ24P6e088GJdydVQwvumho8D1mstwUz1WbhVCdMloUG3wLJL58UslRXYLt/5ZSB
	 YsI2iOuIqzc6mODTictZAfYeKlCd4SWgCWpygPIlvJtaQybMFeLvA5h2hOWg5YOoMd
	 v0TgLE37MFTR6u+iZBGMFaGy59BG7DiY3itsL6VcpqRGeGEbshhtBQ6SqdhGVvwf/t
	 AxmzlQBCk9y1A1FqJVg2eaamxAxYeI0IABf1jI95FcdQ8NoRTl79BEsYm1bLVJEE2E
	 AW77l8sOzAZ+g==
Message-ID: <sashiko-outbox-214748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/6] s390/cert_store: Return an owned reference from
 find_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114161211.376859-3-jarkko@kernel.org>
References: <20261114161211.376859-1-jarkko@kernel.org>
 <20261114161211.376859-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:26:31 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Return an owned reference from find_cs_keyring() so that it will not get
> dropped.
>=20
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114161211.3768=
59-1-jarkko@kernel.org?part=3D2

