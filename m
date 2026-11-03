Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675626;
	b=OGT+IWx4bxm09lCJGcgMYFoRAm9qUgFbebjhQ4CiE74LMq/OwAnXlfnc4Jib2PDr0vUU
	 VmIZU9h5xcUXgwo37rdJxKTOPh7PuvRlF1lPkCw+O/DsWeyqFEIeUXVZnhErOco/uDahJ
	 mGdlcLT6qhPqkWyEgBkGOUv2pN1W5fgSxcFUWYxT/HjO+8qCdTA7Qw6QAmBpxAB4jwU3D
	 bJpTbV3sKTfWu978b+E738g/Lf0MXe9CkADZvpa0N8Y2iMGoEoJ3rI+jzw34JXiL1RSQ5
	 LvpxsvnTDpetPV8Fv9TY8hrnJ+v6FwSpIMIN0jAxAIICved7qCGpSFP3ST6eMKGGtjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675626;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zJmUopH03UajIQc9rmpVSCD2HgzM4EcRh/ptrgedtuQ=;
	b=pjzjW8YN9jeBDumeUKnklE0fWDUa7m1ipJPmKVQQKixzpzRhvdZ11ANCkf5ZFKMM/2+0
	 OriGlIXoSipSRVPXCNpMLOsF08RfbnLqaMJTz/EbowTNkg9hhLujXH0qf6vAdLnJfFj1Z
	 zz9kj9/u7HDHkkWS8opp0gineGcB4deFNuLWIUYzuqIZ1zcRooJsOUbOIElm8t0b0Fj8U
	 FRRs5Zv6C/Kjf/Im2fOdxgsxLBdgbGzoB7PH7zu7C7wcRiSySFwcuCZHOb5/c/VcQa8z3
	 g/4/HjsOGPg9XcqqW4L16Bk8FFrX8eTTrTGqGUnngUz+1+01PYX5cVaqRbMNxyw2WmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD6ajepR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87189606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VD6ajepR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5EC1F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 03:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675626;
	bh=zJmUopH03UajIQc9rmpVSCD2HgzM4EcRh/ptrgedtuQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VD6ajepRnG6TYXqX5jKQIPhcEKQN8exjXFoUSUkudSqBK3bS7cjkihgTLrQmT8EWn
	 W/Z+845W8Bu+TBih55Fs+8jrg7gkXkfZn3LbrV2vG00BP18ZCnQNt0fEEIIOTte5TI
	 jPWHuP2RqPFfdNoqrV0/E1XpGEjptB7k3H3Yt4KAwHEJ/Bz3YBJ3RFqrFCgXIUZ8aP
	 f5FpVP/XUqntKsu81TKTbFyBSOjGM8U5LsAJofkkZOn01xrtgB0ll0QYH/YZVkFuVp
	 TJbl3T8Dxpj7epd0G5RTEPT/nu1BMUD14jAhyIsz83P78a8jbNN2M9QoF75wAwywdp
	 PVvxcU/edISSQ==
Message-ID: <sashiko-outbox-194499@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ima: initialize the real inode attributes of the
 iint cache
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103034320.1756673-1-caixinchen1@huawei.com>
References: <20261103034320.1756673-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:13:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_iint_cache objects are allocated with kmem_cache_alloc() from a
> dedicated slab whose constructor only runs once, when the slab is first
> created; the constructor does not run again when a freed object is
> reallocated.  ima_iint_init_always() resets all iint fields except
> real_inode.ino and real_inode.dev, which therefore keep the values of
> the previously freed iint.
>=20
> integrity_inode_attrs_changed() reads those fields in
> process_measurement() to detect changes to the backing file on stacked
> filesystems.  The fields are normally written by
> integrity_inode_attrs_store() from ima_collect_measurement(), but the
> IMA_HASH path sets IMA_HASHED without calling it, so on the next file
> open the stale, uninitialized ino and dev are read.  Depending on the
> residual values, IMA may skip re-evaluating a file whose backing data
> or metadata changed, or needlessly re-evaluate it.
>=20
> At allocation time there are no valid real-inode attributes yet, so
> clear the entire real_inode structure.  On stacked filesystems the
> first comparison against the underlying real inode will then fail until
> ima_collect_measurement() stores the real inode's attributes, which is
> the safe, conservative direction.
>=20
> Fixes: b836c4d29f27 ("ima: detect changes to the backing overlay file")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103034320.1756=
673-1-caixinchen1@huawei.com?part=3D1

