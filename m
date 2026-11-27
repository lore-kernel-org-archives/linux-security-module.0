Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762452;
	b=yW0N4WgYH+dytoyPjyzjoH+Qev07OJkXvtW8cCn2qsNZq8Bsm55SoLyZi7lZbrA2iPrR
	 wEc+VS8a6dKcbnVIcVbW9iH/YDwnypGV7os0Gk7H/cPn+EakC9oTNlQUrnfi6eYsFATL3
	 YQWXMaelkTo/flBvpaMVQ7Yalr/zZZkCN5GWxNhJMdhYCe8JlY/0SaEwgDMpVmx9nspl1
	 cfM0MDbB2mCDe/itdv7Qej0SE3Z46zSUfz4f7rwSAXEh4ynJ0IaGTomFvYT951GumcQPu
	 V+dgQ6BGBeyizRsK2DOjfX3Qn/IFlsEI63Ip5vciRZtoGk0jV/pfqVlIMiJD1Y24rrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762452;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KcD0kgpRw+kh1CtE/EA3uhQ7ca266VpSpC2CyL6NN88=;
	b=fYCG2fIuNMPBGdiZuG0EYRUOgCtWDLt1B7C01RQrGhZuN9/xIy0J2D/yaIV8EoK/58RL
	 GfcSkP3LbkHb8aE3oiUDoQumxUdKroz/I9BfPiH1tb5oiK9KkmEcURmLGEGcxCcFhEmc5
	 dAyKJxobsHi00kBalEXsDtewthC7jA0U9smDYna89aSDkiopY67Ski4oakgxNsPpLLGa8
	 JtC10HPGWv+qrNLp0/Lly41SCU+tFEQR8jwH41dyCuI2Z4mqCKUQ/AWYB8/gwRI4tLB7L
	 67fVYgg7Pz4y4EDiqVZMz3WTX1Zgf9YAxqPxt6Zi+xW4sUtvNwTAcjGAH6TXfzH1QGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbLKxK3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C50606A330
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbLKxK3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527391F00935
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762452;
	bh=KcD0kgpRw+kh1CtE/EA3uhQ7ca266VpSpC2CyL6NN88=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XbLKxK3S0DWMMQdHx34lGt+26Wjr0FxinEE8zpQHiDVd03aC7ETIAJGFMhXRo50X3
	 trqbi7wHyRMcwZytMsNks1Wo0qDTmVIgvBHTjk4sQh8YZ7w5nW3uJCXtpSLaZNhLEP
	 rA7g0RK6PXh/H4L0ROeEAjlvMuNiUqTnRRjZlD9hMmcyg1V59dV6dl4BHUuRfdwlqV
	 /PLYDtkG6u7szAReoSboSJcMrtnxe1gUm38ettrWqxyx8F4d3DFa8H6VyT9tz+busa
	 t/woyFEdpU0kARVvkhNFj1NxGOIwEIAN7XQ8/taHBIONdlPfq/TJQNHqRJx19yepNU
	 ihDZ0Yp9XXPhA==
Message-ID: <sashiko-outbox-236773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] ima: initialize the real inode attributes of
 the iint cache
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127072129.2162668-1-caixinchen1@huawei.com>
References: <20261127072129.2162668-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:54:11 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127072129.2162=
668-1-caixinchen1@huawei.com?part=3D1
