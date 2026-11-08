Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144248;
	b=WPH2sWl0x6GIji93MbJEK3Q6eNBG13x7kuV+IQXFC6kYoD96m8k6kbzB6/Vl66mGfQ+u
	 o2tOjWVfNjoOKKdTVfudxEnoTDyoSFMEowDBI1uz3LmQhBfgxwiiIbV7QDvdttpP91EcC
	 Wftm8PsPSYDx5g6xj3SAOeUn8VEnUWGPQzaWmmfq88EDzzkSqf1TZGIpwIZf2sFcm/Yho
	 5k6K4o62fquVQHTBX9U19FMi4oogsclXN7TTtoTYouXKVLl4Y1fsy099CxxCKyKT4tJ14
	 TXa1O1qIfKr1Msd1VQuLobcJTJEjHOsLCIvvDFM1U04iSiMIRUcv8x2i5EudNLgx7uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Nu52XaZ6ulYKVGlzf6tYHKEPtHJo3N1G7srfnU8RGI8=;
	b=gnMdhlXRZ06NovZBVKel3jZI3o3z3p2BJ+csQHtPLn/buGtIDPG+q48/9R2vzkCFUQCp
	 sLDDXcfsHikL3I9eqhknVXWj0zJs8eieBqWfRliL0IuqHO5N3BmiHbgEFywHZA/VXrYPt
	 DE/Wyc1PyCAEq5KU2fbTJG16sXSs3nrUofDubmocfyPVYm3brVm1sn56vm/uXXjfpsqcW
	 zL19V0wg798aCBLCfyG5xIg/x/DORRYZo0NNbABT94HFnANb6NIUbR32zVwo0eKEL/jP/
	 aGtnXmAbex6hV1pETWifDqr6dEkPEmqgisCoafCqnvfxCnq2nFN6yTqkAi/usmAk7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyLOzgEV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA1606A31C
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyLOzgEV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AB21F0089F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144248;
	bh=Nu52XaZ6ulYKVGlzf6tYHKEPtHJo3N1G7srfnU8RGI8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TyLOzgEV5yowH8lqWzp3d0XE2Rwk+VQjGn3agGf6+uT2/Sms8+wTU24ZiLo1bXykJ
	 uctD1ao+SJDitBgHqF+7Y60eKAv/z+AEohri+I5Kzg8Ri5TLHUCC2QKsOg7v2XmE7+
	 eSa/wSUvwXR+F0mQgtJmb0jGfl28HEY3vauSH80se3oQzE1/90ZmsmQuBuhuPBU+Ik
	 7OiP73yYQfvSPJwuMitQOTUu9WK4plcaBErZ+EPRN4pR6syKbnjP9FkhdlxRSdfG/V
	 aKPoTU7wZrR2c16QhfkqPEVh0L+4bdAjNqgIdw8H5pHwry0CvtOxdZI0EtGi4yRooL
	 4p5kM5lTvAnxw==
Message-ID: <sashiko-outbox-203776@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: do not let an unmatched key decide the search
 result
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261108131413.12012-2-weiguixiong@bytedance.com>
References: <20261108131413.12012-2-weiguixiong@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:24:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> KEYCTL_SEARCH returns -ENOKEY, -EKEYREVOKED, or -EKEYEXPIRED for the key
> selected by type and description.  keyring_search_iterator() currently
> records revoked or expired state before asking the key type whether the k=
ey
> matches.
>=20
> Direct lookup visits the indexed description, so that ordering normally
> does not matter.  Iterative lookup visits every key of the requested type,
> however.  The in-tree asymmetric id/ex/dn lookups and dns_resolver use th=
is
> mode.  A revoked key with a different description can therefore make
> KEYCTL_SEARCH return -EKEYREVOKED instead of continuing the search.  It c=
an
> also prevent request_key_and_link() from issuing an upcall because that
> path only upcalls after -EAGAIN.  An unmatched expired key similarly
> pollutes searches that do not set KEYRING_SEARCH_SKIP_EXPIRED; the request
> path itself sets that flag.
>=20
> Run the type comparator before recording state errors, so only a key that
> matches the caller's criterion can decide the search result.
>=20
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108131413.1201=
2-2-weiguixiong@bytedance.com?part=3D1

