Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686064;
	b=HLP3CgR+L2Gy/tiBvsxRIRQ0wG/yoiMW8MTd7hkH9GzJt/Qygo+FEpYwDOuCgwTqXUBV
	 axo/drWOhqa+wFXJGi1t/s2MCQHJ12CT0eufCPYvu9avXsPOb4U1cLkUooPwW9oajti+t
	 4oNGp4FlnTYi1xV9jhBwF4PSOmtaTUESuyF0I7ueLestbJq+ZlCSxjcEPX3ke8/T9Hf2z
	 wLw597ZHbXTfNNW4jiQ75GbxNEKH+6clGsMKFV0xiJdjwZzMQKtXgZE0e1saWcN8TdrWq
	 3dvlmXAFayDAjfEcR78EaNYymSlLddmBKm+rm5vDn/f0HplBtzy50Z4mJDF5J3hTi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nM3/tQdskxQSABLKYa/VeF9l0bdPQuBv4iiPwxhRVaY=;
	b=RJuOOgzgr5Ljr3OsQKvBV6SMzarJqdte8OXTG+yhc+DU6ALzDQwji1n/2Ri4Flk8Ws6u
	 5ae/cq6KVYXXRaILpkKoQESIYLfL/S+sUQLYMvA076lh/d2V9wu6H5eqsVlkfB4cFLCo3
	 RhbkG+DrMM4m+YH8jwGXUlSxTkdnIc+feEHZm4FTfuYRaGKiO+a1A+FvKRPByBaslbzwi
	 hn8pdW7V2+pi3lIqGKOYt2YU78B8qJ1RyrRYmu4KHsHS7l5EBDkfLH8FojxN8VWXVLx14
	 1/zyqH2ilZGDLOIJVIl+Ene54gU5U8QxEnSG6ct7hSJGUTQj7BhP35u2l8pGq2TkgLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOLGbBRU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE1606A331
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOLGbBRU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271E31F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794686064;
	bh=nM3/tQdskxQSABLKYa/VeF9l0bdPQuBv4iiPwxhRVaY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SOLGbBRUcgpN9T/JYsZb4vPkltZoGwcmSV+XV4CdebdEr6a7k2gGe+dj4ebxi7Tcn
	 n9xlvJdpzBDpFuT3iHDmxa0VVvkalhXPYI9hIs6wlBhRnwG7byxczQQo5Quc1O5Gmj
	 +MrrIWR/gPBN9MsSKjSawdZDfFSBdlNFH5zhsDjajzLO4FAtSJvT5OEd1cktqVNcOW
	 fSN6KvZaQjemsUkJra6KQexWlzRQafkhF3GB01BCZvSOGMLgPGLrUmXE2dx5ApzcH5
	 miHCI3qF9U5LtDaaRO1ZKqnABKlAFxPuBTOgS6P2UPfOcWgK7Z73wOUTbHIqMdsFpR
	 4MBOoYx/ZHBbA==
Message-ID: <sashiko-outbox-214987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 6/7] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114193631.731615-7-jarkko@kernel.org>
References: <20261114193631.731615-1-jarkko@kernel.org>
 <20261114193631.731615-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 19:54:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The keyrings subsystem is the sole user of assoc_array. It has over 1700
> lines of code, no test suite, and a long history of bugs, with LLMs now
> finding more.
>=20
> This unfortunate outcome has evolved over time by large from the shortage
> of in-kernel callers, time bandwidth and 3rd party contributors.
>=20
> What the keyrings needs is just a generic key-value store, which performs
> well with sparse key sets.
>=20
> Replace struct assoc_array in struct key with struct keyring_index:
>=20
> - keyring_index: holds an rhashtable for direct lookups, an RCU-protected
>   list of keyring_link entries for stable walks, the active link count, a=
nd
>   an rcu_work item for deferred teardown.
> [ ... ]
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114193631.7316=
15-1-jarkko@kernel.org?part=3D6

