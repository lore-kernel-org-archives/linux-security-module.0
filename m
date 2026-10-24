Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877908;
	b=eDGziVc+/60RFasGCMzd33FoD/R7/a4qZhqiJKg94iNVc4/hQLQ+5wdoTs5H1h02+/Ri
	 eiI7m8knYqIim3hxHxIaMflHMur6lJekENBqU7eJTq5bvrdHG+8VOTr++GR6D0AXtnBk9
	 vKPQr61fdJnRDfOgzwpl84vEUpucjyQdzfDuiNsTllcukeBaGyqsUUrNnaOIhgiUbAUBa
	 wGymOBgzHqjrcH6iFdaKrgF+Q580qudcRa9wsuIrT7LPpQAHAboaDSRjZulKpJ0uDuC8c
	 yJZ5z9tjnsuM7bvysGLhcUMVXMAdu6RLywUgfozcxbcEF+5gn/TBESHolSQVFYVCfkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877908;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jfJp9tPB/U4mQJZhVKW6ol6ZAlugHWs6mZTG9J7kOTE=;
	b=jEkroKGkG9zB7LkcmwiQ7T0q301Rqqw0MYjhiDEOBIeaW7DIj698vcFS00J6bBxSrsAL
	 HIBM1NwDijh3jNSAjIgpFnZ/wdre0EX80SzbhphIbih8fI1wd25DlK38yGmfk0/OmMOkc
	 p8ICoQti2fMfNxlO6p080qykLf39yZX4UgVioYXhPiH2Q/YYSU+I1JA8n3rbwy5vJMzR1
	 24E/19O1rFeHjR+/7QUg1aovm90gv1G6fTx3dsx93EnRE6/80KNP7/og6eetsqpSq4o3F
	 ZzcHplJJzxHwdgOyh92CknhgQ64fZY5xS8LfMOwzIcVr3AVYLgMVRiCERzAkjCX4e0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRFNrszD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9D606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRFNrszD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F82E1F01825
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 21:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792877907;
	bh=jfJp9tPB/U4mQJZhVKW6ol6ZAlugHWs6mZTG9J7kOTE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nRFNrszDQ1zx4F+LqC83mDIvUbMfmtf5Akgb/Z7l5aGxgFTHGs2p1qgpxsZBb329J
	 HyqxYl4DNLaHZ2VT13KmjSL3qahtbKt0E+VTjFJ28BZ8qoiEA5svV/s81SgHctG3WV
	 D5h3630QECVdaCQfd8c/CUGctngYTzINNNbspQcJNRFM+tMY6LPNxA6hq/6R3lV6lz
	 8Pj+6i+b/jkXBzPjX40uf3alOC9Ni4/Oqf0dbY87pfh8wY/q/xriTf2aVHMsGy9Fbp
	 jYZFEmltpw8iX9pvIYVPrioHK3mqQ8XY3Qj/oM4xGLAlKjrK4YW1FuNJa90B/m28W+
	 4UYLFZwomDV2A==
Message-ID: <sashiko-outbox-183890@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] lsm: Call inode_init_security hooks without
 xattrs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261024-landlock-created-rights-v1-1-77c8db3f6bd2@gmail.com>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
 <20261024-landlock-created-rights-v1-1-77c8db3f6bd2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:38:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> security_inode_init_security() returns early when no LSM reserves an
> xattr slot, so the inode_init_security hooks never run on a kernel
> whose LSMs provide no xattr. An LSM can then not use the hook to
> observe inode creation unless some other LSM happens to label inodes.
>=20
> Call the hooks regardless of the reserved xattr count, and only skip
> allocating the xattr array when no slot is reserved. LSMs that write
> xattrs still need a reserved slot, so they are unaffected. Landlock
> uses the hook in the next patch to track the files a sandboxed task
> creates.
>=20
> Assisted-by: LLM
> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-landlock-c=
reated-rights-v1-0-77c8db3f6bd2@gmail.com?part=3D1

