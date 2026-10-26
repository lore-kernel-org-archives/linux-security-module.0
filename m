Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029735;
	b=0bkGKFW04IRIWxTAWfxjNrT/K+vYFT4OniXEcrlDm8/cUJe4xTHCzSvsP9uTao2N4XYT
	 B9pGoRy8vOjG5p8XFaeBDLgGI3D4B4fhmVBZh2flGcoPW4Rg5XdO8znp/T9aeUjVLg+a1
	 3QacSYqkqXTA9h/M7mUF59bu49Bx02qI9prNBz/Es6ZDYooWUypfGNJwAVVX57n8f8tYf
	 RKLtS8XBYaeVE1rjqxnm4Rw7u1B3Q04/Y9yS6Wd4x5hmFBPOBeFh+GrZnfcxeSz//YVH0
	 RU9ZJcaNmTSVT5pSE+U1d5rc0nL5BFpDpfdVcCkOnHARqcOOM/ZAQZE/iYBv9NDduHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0GF36OGfSJtQoYB8+IZJVdgivwRCSxapaJEyQNZXnHE=;
	b=eeBEhc2g+GcIf3sb1MQ7B3KQsWcLLSEtzN7Nnz3tBtibpB4FhDuUJwAgC3VJb2H/dFd6
	 bBsUJ4D/hxD4uCZ5A8+kmUjNQjh9uiQAMcgtE7mCsOlBr2xo9rznXWK2P+gDo+VAzIXXd
	 CFifDaBuJB2WLnr4wkKaBzacKJNKeoPQmasgN6zZ7kvxrpE3ID3v8zeSjogPdCcQjwmXm
	 +tX266w2iOThvcF+d4LdOe74XSvvTjARb5HE9w+scoktAIIUqnnEPN0HeRfB7mscYsWP3
	 fxu3QHNkekzjfkTkGbLe3pvyJFSXI687iumCgZYjYVM0YHwGkIcmkFPweq+Q7pkY2sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B90Pu7vY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AC606A327
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B90Pu7vY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B91F01829
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029734;
	bh=0GF36OGfSJtQoYB8+IZJVdgivwRCSxapaJEyQNZXnHE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B90Pu7vYIlmOWvlPAFQG/cXgrfkqy4tqLqT6WInUxJtbya0raB9LdV44Bd2C3mIRg
	 +xK7a/gucS514QanOmx4Ecxsh5kHkD+yu7XGlAeKFmU7MyyG/wiIPLvFZhCBlxMakZ
	 OvSrT+YGRcxs/aotlg+ltLa+dIMATrCebj98RsRzrlJVACGbHBwsfQOXKg32R62XQC
	 4lI3GLD/Xe2F4ibnFYkDhOWNN0/PZH068r1gHwQ2qaJod3hedAVUjl+K1z5J4AQSQI
	 bsV+71XXKnah2cKpcxqlkUgDmlBf+d1stoNWgixnZKJ0haF2+rHeDGxYk5gP/SPX+d
	 iV/ZT407tS2zA==
Message-ID: <sashiko-outbox-185460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v6-1-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-1-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:48:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D1

