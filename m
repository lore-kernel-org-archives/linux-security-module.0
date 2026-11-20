Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795178036;
	b=idd6KcqmLQcm48uMeAR+7viWYdBzAVp94n3V3TIHwBzx4b4IDeAkU5u2V/sk/dGkPrAG
	 7xQcTuv2mLD2ImaYl1WbBEnxu0/lnbwgrXpasMT3L+8Dk+9JLOnwurGLTuO+Xv77gP9Jo
	 kfdAAUehYfCnKxXIkNiDws0olCNG/mRPXfCnKMGBdb3L5cv0Bu60dvEo/ZCnjFBFhVSsi
	 174mt5g0wd6jm8p7UB06k+8racDPrz3/DBdg/UcrJl7OYnEx9njcnEjqpk/o4GZ7aupac
	 DwaLjkf0JRj7dx8zeorjXKRE9kXKftfOWvt27bIgYgtmBB88EZNVAcXWTDeJ3o+hqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795178036;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3TGP1CqsiBQetpDl5rvHzOu+FWcDuGyVCWJck0OjtEE=;
	b=vUsy0hCZEiAUuuG64YD6Z2yINebjrXNN4N++58j/KGG4PvGBcmmTTw/FkVtsIIyI4enD
	 vctX+LTSpz5gSir+Q8ipDWu8RQ6IMYLUiUa0+eDbogqby8y9qRsMBaViHW88ezl8Rhqay
	 n1C1/7MHKQHL2mqFQ/c4e2DXJaj0vSB0BgqQeiZRtlsKEGQI2+gVQW9BfRCG7JeNNPV0I
	 a90beNiNPcwE47liowcEzZ9T8EefHx9K7a6m3fE3DL6jke41sKp59HeUraBCVdnu4ygBl
	 Bt9SijitMITlOGR0XOv2a9RkK+SGvSDXYLC/KjfvYbWWcGt9N/gD8xxz1s9Q1ylqdpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6CcXLLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9A606A325
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q6CcXLLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755651F000C6
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795178035;
	bh=3TGP1CqsiBQetpDl5rvHzOu+FWcDuGyVCWJck0OjtEE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Q6CcXLLpQ3ezKBeREQu8leIgV1ALKIxlAcJDdT9hEOWD4y0wHPgFLIQ3jaxHMHqjD
	 Wu+wuik+4wYocPbBxPK4N+qX/E+p9BKUERs8kolUThI25pMsDhnGkbLTUBp9yRIkZh
	 509evmTuN/Zfa3AxRoXL2//z16N+1FLMqSZ3K37WB/U6COomMqq5cLZDWr4LA0R7Vw
	 rG4Xpk9j9dNktizniRfpvbW9nejRCyHGcxnDGgMf9wfA4RlY1j1hPIwEhAJjrjz4U1
	 jCZcAhgq5sT3Il3NJcpt4aEDlSCBtG23SCA5pRdDsR8ONBVfKxO1sHSKR3JLdhP4+k
	 mRzLvNLdQPu2w==
Message-ID: <sashiko-outbox-225146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
 <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:33:55 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>=20
>   btrfs_get_tree()
>   -> btrfs_get_tree_subvol()
>      -> mount_subvol()
>         -> mount_subtree()
>=20
> and NFS on every NFSv4 mount and whenever it follows a referral:
>=20
>   nfs4_try_get_tree() / nfs4_get_referral_tree()
>   -> do_nfs4_mount()
>      -> mount_subtree()
> [ ... ]
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.=
com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-work-ns-mo=
unt_subtree-v1-0-06337377f94a@kernel.org?part=3D2

