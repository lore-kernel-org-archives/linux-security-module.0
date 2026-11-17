Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910630;
	b=Z8DkdqgycXbn4bw8iDJNyxIdBfaSroi0IbMSxWfpwGs3vgqbChr/21qLYF3AW25hTYG3
	 /9b/ujR2wWlEHiJPIKw1yxSbLAsjUiGUOqhT6o7tHoNUCQarC1o2fmx8gVyKmgE0n2XXg
	 B7o2QLL39hcIlP9rTSgy+6B0ZbqTsIBNmd/7UKJPR87/0iQIgz4tvqj00Y6lyMgtHbV+3
	 QS0xJVahmD5M2dZmPzFjmcCjlAISRrzTM2ScAqEJEkK+eKyg1hH0fyBdjQRAW5znxX8Ug
	 hfQ1btTCrAxAshll/5ljOb9skRbQGle8LlqDE5eb/vOJ7qcucXy12xZIMYSIpR7NKlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=88moVf/k6LZAEhLRj8NnvP7Y/mrqhih9DGgdZ45nZ5I=;
	b=O+DsSstnTupjSWyEgsstLuNnMwdTrECjpUUgTId8VRXyYYS3/52xTodaWk+pB16crMZb
	 KpPCkz1fOpjuf/JGbNTSY2v5ajC2DK32QEcFtHaOy3FkDoE7MszBJV+79h1+w5+vedbX6
	 gEIDxYgmqotwQvI3nnRhl7o5mkuoW5ZasfdHcV9+Zj6DFKb0Nwe7wC6xOPIaf18f6vpJ/
	 TaecjDaQFDim1GssAzji+t61xZV0RrBd7vdva1dyI6nC9ZwkGyLuRTMQyJIAo6RjtS1UB
	 fbdd/jC+BGDsKiK66hQIKK9y0nFokOad05AEjT5tUH2JfFW919umgDbpiZ3qu8dnNQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozOxGmnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FF606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozOxGmnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27921F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910630;
	bh=88moVf/k6LZAEhLRj8NnvP7Y/mrqhih9DGgdZ45nZ5I=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ozOxGmnIBhv4X0DpqJN4ZPzZ+ooizg3CEPH9Kpu40NyntLsN+pHrPRAR0NLPv407W
	 68FACzzizGCAQrwsHuLK4lTjY18trxnP4V8qYlwHO0sDpgKk00VrbjxSZvJph3/w3c
	 xBVVmpCNgXt3BTD4dpfpazSc4RFEIAq6IOPay9OuG7COLc6hQ0bXIW0zjntrZpBN95
	 qpEY7LU7AxFHGmC6EEaOlnh63h7Ywng5JgWr6sRq5nVeKdzJ2IsV1ojK5kQSxfpLMh
	 3t9gv3+ETM9l9he0R+3+oFnUVBUEUrgUJ7JtTAQDkZsdlgAuFTFq8/KePJ7PsTyzK8
	 vuSPaxqkRq+Hg==
Message-ID: <sashiko-outbox-218584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] landlock: Fix capability restriction
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117101157.2520463-7-mic@digikod.net>
References: <20261117101157.2520463-1-mic@digikod.net>
 <20261117101157.2520463-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:17:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
> hold for every capability check.  Remove them instead of listing their
> exceptions, and call it a permission instead of a hook.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117101157.2520=
463-1-mic@digikod.net?part=3D6

