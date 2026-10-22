Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694559;
	b=B7WOtN/1wJtuaudcNJ68ioZnjeNqLAs+Kg39O3PbQHKVasbtbc2mbBM/k9DenFb0szOw
	 4GoXUzYK7vBc59edJYbYwEaXVqTSEguuJwxgjHNmifP7GIS4XMygLhAFVCejrX6lfSRfN
	 n9HvA0bCzAIhJOqCH7F7sPZkmZcJKsTeXAcaChzYDDl6hXyL5IZMSglLWSyMwoP9ati9b
	 jiQ7wwnYBG2yhjqpVp0usHSKwffLH6vIkSEzage8QN3k+eAdFVR98Td/bKz3g3VtPcW5q
	 spMdsbtTevlCcEcDHDqMRnjTmRhs6zkcjuF8w9zHu661gEba/tC0O84pRaV5QQtS74A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nyj3GkoMhiic+1ne7sgnaEV4lxQtt+HF4L6A6pk/d0Q=;
	b=K3x6MDR5INxKiiq+132n5xhXf5DbwfUCPkpjhD49pCtPaBhzi4KOP8uvQnb1EzlAO4LM
	 mAZCqOTlZovXyDiKohy2NeDY6SbjiwaPgWB0W+O8gASV5+aijhhzAPqPmrsOuKyE+kiqG
	 C1l46GsdbNDRHLHqCP3FsEzxHHiSWyVRvxDKm3h1mHbE9hbYIUP1gd49etUWonk52pz6t
	 /eCu4VVOinLmVggLmuxNfBlqxnbOVDwaaS8KXXopXYnxdL7neEQYdz1Kgu85DNBQcEU+S
	 3+l7jkFGaRPg6NUwDrCjm2r4N+byPFseSgvNGZ3jkdg10Mlnmz73c118PwtGWu1O2Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM3b8T94;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABF606A319
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM3b8T94
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B3E1F01825
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694558;
	bh=nyj3GkoMhiic+1ne7sgnaEV4lxQtt+HF4L6A6pk/d0Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jM3b8T94V/yr9La7h9Hr4NFG1an3aA92EXW2+PON5GyE2M4t9ZXLEjLbApnzOGE1B
	 uvaFBAUubBq1yOadiKjxqT8Lo/ee0XaKFLPsKBWnOTe1mmt9j7ZtwlV2I5NKcyQp8s
	 IGbcvFRYWhNBN9T7gtwwKxFrD+otGs8GNFfMD/+lwcrE26kl8YIVsEQWUWYTG6BG3m
	 4ssqaJxp6vM/utUti6vwDCqmFxevguo2BZO7eYPXqXbFhWKCHB/cSMKVf6pQ2prWZd
	 7TlsCOr57d4ePglZZX2WTUkojRTOg/zKI7fTikZqddA6SIs/hIjOBoqjsyhxrcxV7B
	 CT1GpNW//ym8Q==
Message-ID: <sashiko-outbox-181932@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261022-b4-setfcap-userns-v4-1-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
 <20261022-b4-setfcap-userns-v4-1-88aa0ffaa08f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:42:37 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-setfcap=
-userns-v4-0-88aa0ffaa08f@toxicpanda.com?part=3D1

