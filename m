Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467139;
	b=YXzurLpPHO9BRTnnJjUW0083yZTAgVSxCVLBM9BwzuGN3GsvRrlw+ZnlKZ4jtvoyU7Pe
	 FGz15eOyNYk0TbfWQJCY37FaiRczN8FXvyPtoVZqFlvu626+X2w+hA56Nwj8vaR+ug/hW
	 q9HgM5tHXxw+0JxsGX3cLgrfGmRrDbUcSellyu5Ic29vX0epWe77zQYNYoyJXOOjjZlS9
	 fXm8ZWIoPX7nt/gig5iW/Ynf2I4hT4Ysk3Y86bOfdu4QV9GLmh4v2OUG2KJPHeoqRxQYj
	 u940m8eCEh4dS4hvUQi2r5isOgAe7GYbBm33d1EYCYae8/bIQLO526GmprOvXNqeDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ajWbKJBD6Rf5e1A+nTz6FmTNxnLvgyEevn4dgMXehF0=;
	b=rn4R8NQJDftTeuXqSQSTR4AOHle3oamU7IBlHvK5/TiMhfDIVA5RW+h18NUZQBHYJwbk
	 ficcRZW87G6kYOJQyyD3YiyiMIzoEqsWq3XqXAvrlbU/hScS9WkR/uisRYcRXa8KsOuCD
	 cguVa/Ksw8WzngmQ4QEoKF5ltrAWEnA1uajmnCvo6ml1UdVnZJuUon/d0Y4+xh6WIi21C
	 tPnaKX782IjrzzuvYfTQnmrLyEWTeLhxlz2yuXBnDzeEjUpotJGwqTrtJrn+8HeBb4TS9
	 qgIIgTFwdz1nFy1WqEJONcgv907FrzpKGw6hOf/twQ3t3c1+hMFe/bjgCi1U979F1FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JM5sQtg+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD8606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JM5sQtg+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2371F00A05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467138;
	bh=ajWbKJBD6Rf5e1A+nTz6FmTNxnLvgyEevn4dgMXehF0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JM5sQtg+kmAEbCHxEvZk35AK+8NTYsxPzHhpwarN0cdYetlKUI25YWQ3bv0V3YLWZ
	 RIG5R/WX3JblTWAe7jSQ5DAcF42+iMaMuI2heOi9Z9Zq8NP1DLz1pycmC448anwv1p
	 VyeKffs3VgCiVJ5t7fxVTttJWcKMMUIPJrpiSqUr5PoDtoKa4C1WzdmPPepLqPHvTj
	 wUwdMEv9vxK8cz41DBFSc91iks7zhV/mRfCkzS1Wh7z/LZxSbHASgXP+AaDQFKaja9
	 kSNkZ+a6GuGlPfIjoDUU5GviGNnhvf5WqIs2JVamvjiYDIuCEDfJb9706g07uA2g5o
	 1Sho4OOPbgImQ==
Message-ID: <sashiko-outbox-210568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: reject duplicate fsname= in a policy rule
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112-c3-n204-v1-1-dd9400b9ece8@illinois.edu>
References: <20261112-c3-n204-v1-1-dd9400b9ece8@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:05:37 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Weidong Wang <weidongw@illinois.edu>
>=20
> ima_parse_rule() stores the fsname=3D value with kstrdup() but, unlike
> fsmagic=3D, fs_subtype=3D and the other options, does not check whether t=
he
> rule already has one. A rule that names fsname=3D twice overwrites
> entry->fsname and leaks the first string.
>=20
> Reject the duplicate with -EINVAL, as fs_subtype=3D does. Such a rule used
> to be accepted with the last fsname=3D taking effect; giving the option
> twice was never meaningful, and the other options already reject it.
>=20
> Writing the policy requires CAP_SYS_ADMIN, so the leak is limited to a
> few bytes per malformed rule loaded by a privileged user.
>=20
> The leak was found by an AI code review agent (an LLM-based bug-finding
> tool developed by Zijie Zhao and the submitter) and confirmed on an
> unmodified kernel, without error injection, on x86_64 under QEMU with
> kmemleak: loading 64 rules with a duplicated fsname=3D left 64
> unreferenced objects allocated by kstrdup() in ima_parse_rule() (inlined
> into ima_parse_add_rule()); the same rules with a single fsname=3D left
> none. With this patch the duplicate rules are rejected and kmemleak
> reports nothing; rules with a single fsname=3D are still accepted.
>=20
> The reproducer, fix and changelog were drafted with AI assistance
> (Claude), then reviewed and tested by the submitter.
>=20
> Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the fil=
esystem name")
> Cc: Zijie Zhao <zijie4@illinois.edu>
> Signed-off-by: Weidong Wang <weidongw@illinois.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-c3-n204-v1=
-1-dd9400b9ece8@illinois.edu?part=3D1

