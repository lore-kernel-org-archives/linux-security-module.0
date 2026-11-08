Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170077;
	b=URDG/weoR31ureatvomZekLSds2riBKCVxRd9JfV8l2WQxA9ksxfamSjkM5H0F1bzNYb
	 vZjK1a46okJxK0q52tINRpMc7dlbdR9FRs9yu7CnernICMfgSSTFOK2Tn/RZm0ONJCuvE
	 AhYfSiV3UNPmYfdqidwKWgHh9dZO6tytF6gYnNw5ZOCyVYrlpsS+/l9tw+ndGNpvaUiXw
	 txW0ZlrIJzsF4L1ISKwU95b/LKESx3nBRPW5KDFJX2XFT/zduEHap00FPfMrhrycLXcCX
	 xvoxBYrnf43Wf3yKs4Z1MEQUmkhNb3akC+Tcd75sMGS377HANhudVZ4PdoxEb+YFk7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170077;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UEkH71RtqHn0k+Vg8B7NO5TU5G1bwUaGPLF37gtPsdQ=;
	b=307Ka7mvNBipZ8VQTXKp+C5M2hzOyuQ4cdujjatea+aD6bCrBI8xcqJhdfKiJEcMJqf2
	 UWuhl90Gq2eu8B+Bc3t8K+4Gvq/rN/oZ4Td/fF4E67v8IQeT+L9YMX6xQzSvMGRxVI64E
	 uH3O4hnJ3yLRjplW3CIzjOnB4woaDTkgS/TVXJ48G/QnQN2GGockVap4q4Z7pq4J7WXRU
	 vxoDBZa3pzYzJLdmH0SNuAL/rZWteNKTsGRwn2v2VqtyFWMKoGovLhSHE+/Dh9IH8usc1
	 a9FcWPP4DrtAdiaZqsVbZMWIt6wW9s5TguXv0LPmljXdZEgjqXyP9jih1C5U7JhwtSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz7YIh6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F1606E008
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz7YIh6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27451F0089F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170077;
	bh=UEkH71RtqHn0k+Vg8B7NO5TU5G1bwUaGPLF37gtPsdQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Nz7YIh6z/KjmBH5CCflImbhh50vJoouhLQJ71mZx/4nNsXx9pxCEcCAVFO9f4quAq
	 NYelQqWKzwO9IDDDCuE959SSXDMvsP6fR9J7nhmHImgt9xoMXeSVX67neIewpLdzfD
	 ZO5YQsmL3s7toglnE+N7MpATP6Ctb0wz/EcfAF5BbOzFIU6QETQDeULPSS2RJhST8o
	 6rKJdJyky9mdissdkgqevFLUEhUxA77KDJlxMxpvXOgMFhck8abwC86wdD7WYj3OPD
	 qCmy/x7xDbotKrGJaReQQAtmo38yKCQ7S5GKTzUj3kn4CjhAqEcK8wcFfm2HYEym9A
	 Eukk/NganEZ9w==
Message-ID: <sashiko-outbox-204019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:34:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-landloc=
k-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com?part=3D1

