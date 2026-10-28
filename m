Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157143;
	b=m4zriJBJXxg8kKNMETWPchp5gh4YKHgrgbLuQnNo/ep4c/e0eWlt2VhvsEUQOByFkVDV
	 V6dj3cD4wrZhWJhy8tDUcgLJiFqImEuTEEGdJQU05y2BeZTwjWNG9ociX/MTVuvxVOQvP
	 2/pPSexe4OB30lZxSSLo1vhf3KtRh5ageI+G/jp/wEgq/Ewp4tWkEq6CKk1Yu3R+fp41J
	 qsE8wETrXaIqQ6Xup/ern+jp0zNwnOdDtPyDobQqvWalfZt+OyEcTlTgYLs/dDN2OXTaC
	 vPEyk3536PqrMFt1teHoJd/ueFl9IXVrFWVCW+qa80qXD9zbMwnXTey2MJHRdEiwxcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157143;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ev8VJBGSxLLAorFgb/gLg/6shahuyTCd4fsCfcg3jEg=;
	b=TnzdgcEFI4gC5Rs5jcyrFnyjiY3A82xsN7Q2AwkpgAhH0Fhl01J8lNIllw0Sm80AfkuC
	 LFVhre+kNy2cRQFVoN6XoYyKOKBQ8MbZAfYSiD/6KsnE7wXDnaV6Tq8B8SgpIQASZut4k
	 MB3gaKd9B6iO1qHKN8loS2PBx7X+PnPmYK6mqtyHLx5FOs1e1ZN2pUClittzhIvSeTL+z
	 eHf9tIMmP2f+8z56sEluVl6U3L5eMtTgBhUzQ3O7LMNA/aylPogoouKBSQ+4qn+2LyAHM
	 a2DNDLJMiE2zcW/VkC51j8ghVXEdirDXlGMvyiMVBpxxA+2j84qpdE2fnMl+RtMlWiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEdCCA+l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5E606A329
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 03:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LEdCCA+l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7612C1F01829
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 03:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157142;
	bh=Ev8VJBGSxLLAorFgb/gLg/6shahuyTCd4fsCfcg3jEg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LEdCCA+lTZ396lKBSyseTEzVL3a0bURUlgwPmWe0T4HZEGtrsYf0zCQKQQv1ottup
	 TdDhRYpbzzeEhYHItr2Xv2wlw7VpqWcvSXqoJNK33/K8AdBY2uhS+ECWkXbjsC6G8z
	 pc6CgeN4OmghV/m29JYcHz/QEjvLZrHlOHxQrtdAzpIVMCYYSjcWXEL1o3USRlK/2b
	 5PG2dWF0l5PDT8VvYePjA/hvtaI40dPwUA3cRbDoXS5u0ACWIP94j/K/lAOJ2CUZe0
	 jQmJ63U3VV5prJ+gjQySbJ18lZHIfi4dnfr7fPMPtVGj1phUCc1wte6jOfy4ugHjps
	 8rziBSglgJWMQ==
Message-ID: <sashiko-outbox-187394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261028025306.2063007-1-jarkko@kernel.org>
References: <20261028025306.2063007-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:12:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
>=20
> Resolve the problem by processing in chunks:
>=20
> 1. Declare a static variable key_gc_work, which owns the garbage collecti=
on
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 1024 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeati=
ng
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
> [ ... ]
> - aarch64: chunk max: 235 ms, total time increase: 6%
>=20
> Tests were performed using a laptop with AMD 4650U (Zen 2 uarch) CPU.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025306.2063=
007-1-jarkko@kernel.org?part=3D1

