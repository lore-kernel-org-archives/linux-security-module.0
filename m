Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588060;
	b=3ouZI30ot/lxR6/hkRwMPoGVeIHLNKSW8P1yhUbgYfEspJC8kt8MKZmOGJzfv7xhQGQq
	 ebsqdSpVX1drQwPPx4GtVFsCS1kRInpNnKUkJjqXUFaBGG+D/sTDSrCosSDjksfOl8gE5
	 /hptW1FzQspicBhhW2hXXpMY3zoy3r6WmdqPxYVNALQgMZTxpH8koEsbSbXhqSMWFK7qy
	 zKJhi71ry+kkxr1CPeFZIr8fAKGM1py7d0X2aKglWZMPr9jBxrAt2J1V9CLcK43XuHCox
	 da2nofpsJIlVpSGOgxIbNL8Wtvh0osEZyfwlc++GaAkHhkmRUkFXvm+/0AszK/OP5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588060;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yIAXWxJsIlTaZ4ZADgAL4IVs6ZtWBiaa/XALWlkb3Js=;
	b=uEkPE+sDZG5xnhK2llAkhGq21E/5U6vt62x8rlkvhPUG3u+qSv85QvJWXRzX8wI4brdQ
	 fo3T5hTGWmzD8Df0icVgiGgiF8BIdpYOjTZxPykQ6O+7hv3ZZxfOz/Q/7+vIC9OxzMOvk
	 B0XDW4rH/bm8g88Yik2m0HQJHx7GPERroEZmivSGKAR3SzwdhIpxzwBC2W73I+gd/BWQO
	 eGpmuEI+hE5NGT4skuKv8qaNuh6IYjd3lVJNUG/6HS7HKRE8xmgzEu0c/ukqIZw7ihj4A
	 Od4hpLuMy0dmpVcXBhJ8hV5X0cKqf43dU7liuvNUkZGIpGNe/uuDGQsM9nLdfJ6H4+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8envqTZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35016071ABE
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H8envqTZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697E91F000C8
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588060;
	bh=yIAXWxJsIlTaZ4ZADgAL4IVs6ZtWBiaa/XALWlkb3Js=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H8envqTZHlyROcE7usfZHr7j+W7N/N8Zwu99W5dFkBNlUvVaAY9hFJwRfSOIOgm/x
	 m+2+l3sba0sqrwlynWm3zg1aGTg4hrYvZO5D5wkMNK/GF4NCiCIoFi2sQVU3c/kX05
	 ijHgT9XhGKhx/WbqrD+68tpyrt9yGUHVvhzO96WPQvICo7/fk9jTFQGCJVmu4RXcjn
	 tigYDPW/Us0sk3DID8kLsTdT28z/G9iRuS45zddUL0JfccNoSNYqAEh1MT5pTUdP+u
	 nLSBfQUk/dc8/ZuKFaVwCfLUgwnB3agoF2GjYRZ/FbxVd/1FVkK3AZ7hjmwiAVcOC1
	 5f+enh6Ehz7ow==
Message-ID: <sashiko-outbox-213218@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] KEYS: Replace assoc_array with rhashtable
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113161836.3587552-3-jarkko@kernel.org>
References: <20261113161836.3587552-1-jarkko@kernel.org>
 <20261113161836.3587552-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:41:00 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161836.3587=
552-1-jarkko@kernel.org?part=3D2

