Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822575;
	b=GoTYC/Z5lAshLnGQx4tDHOfG2+HyYW2fvJddnhn+IKnrWWpIYzhkf/YqBO7H0zQ9Gsu4
	 QvIWvdt0dyCWdfssmVL6BS9peSPxIMxud/ifsd7LfQb7qJ7VTaR6w228RhC+KHKppeCfL
	 Mn9Kf5eAFWMOh7f7ULt9mK/5hU2aXBdcx5+iQHNAnZLLK4mGCU3YTB92CbgMclU1WhQBv
	 tYkn2YCnWLUQLO4whgFGhXcorISgGFLy5b8fPSoJ/UdDjFoYgPLyOSeCEd53/gZCJXu7x
	 qBCA/FIDwIiOb5dCOzitpx2vaEwQm2SoJWU8EjTGqEO7/X1cKKsU8/2sApj4nU5y9Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=amjvCwYSuscAc4Kwim/qentaDvJscTRzh9RpxzTWt5c=;
	b=gxICS1uL/CZYZtlzZwfcum6PInXAxnjG7dSkYfOnfS8YT2Yp9bnnOn8edkhkaYbHBgD5
	 yawiw9efbpkh6KTnk12mI3ZzdzEKy4marAHhhgiU+5SbW5I/FKhQUCDNmvF5vx9+GHVsl
	 RMvOwC5WxFZ9G9itg3nSiJfMSRaCrwIOlCOjEEkgH2CFK1ZBqvbnetY3aANqlEPNV3vsq
	 tEZ2UOBRyrHvxtau2dhBAM0JGQ1QDS404FWDTHvC/3xPaRMdos+O1AjBENrskUJyj8wKF
	 SyPHyVTpuWY/7gzAs177JTQ31jXW2BiTLOo+SEFiWWTjCok8ay2aRe4X3rheCmf3xEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuUfuj63;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFD1606A333
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuUfuj63
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C311F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822575;
	bh=amjvCwYSuscAc4Kwim/qentaDvJscTRzh9RpxzTWt5c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nuUfuj63xccfNdJzXWpXPgRAuOByOQP2TdrdDXDUhvig9CO4n+RuqFYq7GvGwUmRJ
	 o+dEvZFUSz2j2nbn2ozPbQCGqZoagjz0lluhJ2eyEB6jUfWXyM710GkohaHDaekOdb
	 i94RHhGenNmtdhrFaav8nxkpoNcBKRod/x5N14PIz5biOgDAmwhgIETwFMPMIgGLDF
	 xYsdDnRWaF82blx9LKa1UjI7X7ToEwE+pGcK3EKPsbcD2wP8V70VwFPeiTQBcXoD2S
	 AuLVDr3bQdPlbR63ovTdnzxdJkUbNnLto5pf4b7bRhHlM2yF5pNUZG6DD+bpRtwM9d
	 phZzzWqo0qZWA==
Message-ID: <sashiko-outbox-216643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] ipe: handle errors from resolving the real
 inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-8-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:49:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that. The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Instead, leave the block device and inode state of the evaluation
> context unset if the data can't be resolved so the file is evaluated
> without any dm-verity or fs-verity state. IOW, IPE reaches the same
> verdict as today but without looking at the overlayfs inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Suggested-by: Fan Wu <wufan@kernel.org>
> Link: https://lore.kernel.org/all/4e9a39ac-9ad5-49d8-b0c4-09e665504609@ke=
rnel.org
> Acked-by: Fan Wu <wufan@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D8

