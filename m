Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794666702;
	b=eLhjXTX8ntcDLZmKS3Rv1sedhXuzb4lWOme1rMmiyUismQxD24M9IiL3FpiD57llUIYK
	 39hogAIFLIUniQwul6GVFiW6LU4yDu7LCbfvMUZKsr5IUlmGdNjCcsKsCDmSqqJjyHDNC
	 PsagffHZbqee5EcM8fEX31THqpI+8cky23RpfIz3sl97BB5wUkGE6Ckv1mcmfC17p56CP
	 1WBPDCogchSCTp1OF2xCaumfNV7P6iBj2jUZZBXi712AFGHoYDgMfLkkoUDD+oRZbdZJb
	 kEC13UIlztXBTGJPdUZuJkDXEcvxSnMKGKEMV1c5EwoBTOy4hYI58kmbmzEsa9/mrfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794666702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1mrD6XQ2fVsd7vY1lKTgStQqrsr+Gt1xdHZbzCnook8=;
	b=mysU43+caFam4MWmGmWesU5JADR+Z/4RIUdBylolxALNgYm9gn3KMyZGYnJpQSjQSrdZ
	 IP/rMgIhg4qsMV6d56AXD0wCdBDNPjIALOBP1fOe3rOmOWJ4dEa2QRk73i9G6YM2FKNHJ
	 RxSN12r2lXRFksRAiJCZNV1DNyq0yYwHW8iZMfTa7/2oz8WK7tH5bsqwys0JuMclLMWBe
	 PTonySJlt9SMhEQIrAmpWXEGRht78G/XUvUiru312fPsroslLGB7j3xCIYqxt8LS3B8Vw
	 k/CNopdxsv1MF6ZnAMVR2iORDNKVcVqIW6mIWm6odDk5qT1lQ5SIcE9+eLQQ3HCSUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze4uhecD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE265606A32D
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze4uhecD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBDF1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794666702;
	bh=1mrD6XQ2fVsd7vY1lKTgStQqrsr+Gt1xdHZbzCnook8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ze4uhecD1PBL/JXodZPAl2HQ62Uw3HRMyn3ukh1/jieIJRkSXyQlQF5lIqZkEFK2v
	 2EcrJzsKrmZVFkpynEKCoXLNeqUjENA6GZJ4g6lSNCJNoJUL3ggRY7oAQZdprXsOzo
	 JybrUocF3ra08a/sUWw/dArb+JFOFkDs7sTnvxXu2qK/PA9BiOu1vMR6/0ctzbK/ET
	 yvjHNgU/Rbf+xRDtyqIxOzxSLIk+Wv4KBhs/CxzzdNLAYg3BVE+GGtLMm2wHAkt6Ql
	 dtFzgFXFl7Ci7WJn9lQIsTF1FAe5FelzQ+8izHbJqWuCPvynt/MnVfWRbM7UgGXEZQ
	 JqGCqzX6D15KQ==
Message-ID: <sashiko-outbox-214635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ns: skip namespace_init LSM hook for internal
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114141323.19029-1-zhiqizhangg@gmail.com>
References: <20261114141323.19029-1-zhiqizhangg@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:31:39 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> mount_subtree() allocates a temporary mount namespace while resolving a
> path inside a detached mount.  btrfs mounts use this path on every mount
> (btrfs_get_tree() -> btrfs_get_tree_subvol() -> mount_subvol() ->
> mount_subtree()), as does NFS for referrals.  The namespace is private to
> mount_subtree(): it is never installed in an nsproxy, is not reachable
> from user space, and is freed before mount_subtree() returns.
>=20
> __ns_common_init() calls security_namespace_init() for every namespace,
> which runs the LSM namespace_init hook.  Landlock implements
> LANDLOCK_PERMISSION_NAMESPACE_USE through that hook, so a task in a
> domain that handles the permission, allows every namespace type except
> CLONE_NEWNS, and is otherwise allowed to mount gets -EPERM from a btrfs
> mount.  mount(2) is not covered by the permission and the task never
> acquires a namespace.
>=20
> [ ... ]
> the first domain with this fix.  With the first domain,
> unshare(CLONE_NEWNS) and open_tree(OPEN_TREE_CLONE) remain denied.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114141323.1902=
9-1-zhiqizhangg@gmail.com?part=3D1

