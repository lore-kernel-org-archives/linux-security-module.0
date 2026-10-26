Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011899;
	b=woy1DMwKXFITjN8zf1W435TEtIQQaHeuKwjo2xE2Jn+XNlrZWLuQsNTLOgcYBHz5ZYsp
	 j1s2AWfGncYWQ/rG1QoLq8LRlPMF4DLsHaBFqGT982mUOlgBEq3REFZvvvqS9XEfRVUim
	 cGlffISmrkmd2L/yqA++xJWNfEAIbYIbHWHIKO1TQZuPmJGjU3qEXk1zde0db0QVrBqio
	 AL8m5zohb2yFNCublKLR4MqRakx9w9mgeNuE8KoK8gdAmSe/Uiwd5hkfXe9mhRSM3EOD5
	 z/ya2LOftlk2RtpxQW7X+pGpEMkpGtPhZ9pQM0pEmPLCZ7LuxgLy/Buytd4MuWUUeqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011899;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PXOdamQknw7hJbp1Cw0FkUTPxPaEufIZ1jAnHKyDCnA=;
	b=OYR3aHHL4FjgKe/O5PrEzYHST+WaQ5cpuBOi2lKKCE2YVoksZhjViq+QSgDoLSZtz6O3
	 ut4NmSTNqLiHE9tiSbLltpn/xb5ACF41d4dU9FzjeVC6/gWrdcJwaIZ6YJDbr9qZ5MJkl
	 4cqJ4/Z+XULhfyz607v8Axyu8YzBtC98CC2AWr55yPGinUs3Ne+m4mPs95qBgx5JqLNYf
	 HZWaAkuhdDor0SonRwVhVdS34W3B9xTyld+E3QsuRmDX8uTNippfvtY7RymnRWJ3akLOK
	 otf9NtzJoDet8g874c8LQPbFh1gYOpuY50ANAEkcqrnCRprnjedxMMOFSXnGkBTzWxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLwkkj76;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E5606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLwkkj76
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC51F01828
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011898;
	bh=PXOdamQknw7hJbp1Cw0FkUTPxPaEufIZ1jAnHKyDCnA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dLwkkj76jbkMv1QEUybNBN1891T1Q/vP/b+73Lznolts3J8Oj9RFqqZ0FP4UOJR34
	 JsPMVa8aU3cx1+J9Nfzkver0njPYC1XhkLC7WkhTZmGJaJuOicOQSTA/vCY38fbr1a
	 0QRNccS2yqx09W7AViBgRbV1Phq4dxCkLQS9BQgg0j5MlbNPa2mxuydkMDBclEJTvk
	 n5OdRkVBYTJkdHkHZ4RnQZU2XdZozz0ZTHZQlyrUpm7z4XQ+uSmAtvYhn32N7JZI1K
	 L2wnMEOtrfooYrLko+irr8LaO0p/+WZi0J+lC8h7OIvbOvpXC8vcTb0bMoH/WJr5Sf
	 acKUJiNBKKtoQ==
Message-ID: <sashiko-outbox-185020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] ns: allocate the namespace id before the
 namespace_init hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-5-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-5-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:51:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
>=20
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
>=20
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> [ ... ]
>   after:  @[set]: 200
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D5

