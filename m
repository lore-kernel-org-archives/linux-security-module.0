Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601972;
	b=NcLudeN1BTe5GBEKWRBZUN+8YVsQ5cmfXH43Z/gYRv6Muzo95jzGQ8tMPnF7Tq/RP8iE
	 NkMhWAjJUV40wY6RWHjekiEImi61NepuKD9zPFgOxi6NnoUKp492u8xyWhjs7ai73LhZy
	 xqm5Z3Z61xsfqCjM2CxL2uFHCvIB+p2KxxFzUcX0s+sF+6TwUuZ+N9SZNv8ynil2b4823
	 PZmRihhFfQ4/c9hHeMTeddXG/ea2FQL3FXM7Th2QvdZGcOx2HVQ+u6fjDrKY0DKqvyt2r
	 pncUGetjFwZsXmDpfQUV9sMgr4v8Xsc6Q7jvGgYcXoK+fd3vdblrsmctzr2LqYkET2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601972;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FNQ1oSKJ8bslAllxZt6WIOq9NworAGbexUqo5ldrtPQ=;
	b=ZTc/JfQ8zjL6xis4nqjUQRrBv32z+EEOn9M0Mpn/SPKzZr7RPELTq/NPJjTzZHJhgOki
	 ukyj7Ql6dN58MxGQIFTYOtA4Zl8DJ/zPslUVVpKj732z1rqIolZpW08uqBHX5izSCzNZ5
	 AoqYsBqNpof2HLObe3AENMw4C23/W72rRvALRQ5QwHUqhKALqLwdoIR9L/eMPs+9KMoLJ
	 sg/ve2Q/ojvD2ARKqY21wErIp6bId5iM3owq0DmBTkWGT06xFyjo4uFp38M3sVN/NnW47
	 10Fw43p6qNg1EmA1zV1fsKA9CEdp36XWCeCSHBBBkLp8q8/O8Dv6acD5hrRwsow59eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUhQoByD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E5F606A32E
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YUhQoByD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A72A1F000C6
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601972;
	bh=FNQ1oSKJ8bslAllxZt6WIOq9NworAGbexUqo5ldrtPQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YUhQoByDytVccSxtyeiXMAdJ2A0XNJW7x+zQvq9re9BiODs/MXc9Gy2TclmyODJ5e
	 F5303uRBmDG2XDSs26ajQhjHFNSy/64whNgEVcuOIQ9AiGaoXjpQmfPhZ//NeQX3ME
	 17MwUPGwUUlvEs2cJFKJLlbo7Kw0A0YezYgyDetJVbhz0Lhd7e5+FilRYbfcO9cBj0
	 x392lbmlGsidOGW/VE1Al6BNo31tzLe67/W7RHSsPWEG5ZtS5a2wnojtjMSIwCOO22
	 rB0wIA1sNbZYBG9t99dhTysTDzChKZhX3XmXVSXr2mdLr41avg4V6FzcgfdoPm8Kwp
	 sgXx0OhiJ4Few==
Message-ID: <sashiko-outbox-213648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-1-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
 <20261113-b4-landlock-refer-nonfs-layer-v3-1-02d7e42bcdfd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:32:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> In landlock_get_fs_access_mask(), only add the
> LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
> handled at all.  This prevents us from accidentally treating
> non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.
>=20
> landlock_get_fs_access_mask() is used when initializing the layer
> masks for doing access right checks, so this bug meant that we
> unintentionally denied "refer" (e.g., link, rename) operations in
> layered cases, where the same operation would have been accepted if
> only either one of the two layers had been enforced.  If the rulesets
> individually allow an operation, the composition of these rulesets
> should also allow it.
>=20
> The bug only manifests as soon as one other layer handles filesystem
> access rights.  Otherwise, Landlock filesystem path walk is guarded by
> an early exit for the case that no filesystem-enforcing layer exists.
>=20
> Reported-by: Dwi Siswanto <me@dw1.io>
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-b4-landloc=
k-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com?part=3D1

