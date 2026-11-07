Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794095019;
	b=T4IA1tyB52fuTE4Q5PTJ6hxgay+3j4QbCmkG42oN/4OLr0ka/jFr6IJAC4P5fhcsm+y3
	 0UoAPbeL+DWFV2DPf8Vl1eFaif9l7pZBVLG0tGf8Fgk5tIFQdxjeGPt31G8YsSc5hHOwC
	 wVqXfJTTM/f2SFkmUVJ7+7bodNRITQ7fjYL3ZmuESwRCbedf3C/jUhuWXsvR5R1b80LXa
	 W9r9Sk07rwqAoV73Z9sEtVQ49mRxPonSzPrBiLCeFEoD+hfP2NQNnzlNCVSjmPHzNUUUq
	 7K2uxVRcLXCS8fVVEjtbgKzEurIPUCPuvhLlsyFsfJy2VlTV98MmhKqIKLpezavmfuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794095019;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dMp0eB38R0Kry5ZDgWTyPiFqDdhNE64cwZDihhe2LYI=;
	b=5itrQ5bTdLbqNy2q8jt3MPCovh4zzXoBGLvjtniGf/yHFO3PYxr6jfOmT8u6+Zsx3d09
	 8vwFMzEj6X0iUIQJcZG8mNTzo5lhYqlDkOLhskduy37rDyPFVgD7YwobHAFwJvacyg+g5
	 evikCKxH/W2WOqBSSr4sfH7oS3n0VEyGt8LbjLkkyFn+Sqnr58eubRIr8U7CWiIrVRROC
	 mfn1tArAWLMkbWFetG2Wt0uwQjD2IIak2GrAIJpte+bFPz0swTYrQHbMp3T4QG7D2loCq
	 nLubLwiGVjuS2bALru1LpKOyRw//4wsvsD3j+Ua1W3Er1Bg5Uz12grZBLavkvfE0SPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TabMbz16;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB718606A335
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TabMbz16
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F39D1F008A3
	for <linux-security-module@vger.kernel.org>; Sat,  7 Nov 2026 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794095018;
	bh=dMp0eB38R0Kry5ZDgWTyPiFqDdhNE64cwZDihhe2LYI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TabMbz16v1CTmiIBaErfdN864Uzj5rTJtVpjrWIrWNEdRfj6HY+/kuw75wmPWF4Pu
	 SLXAktPWN+oPMO1Cp6bdRPxUsmILzvTP4EoFWYZohMnySbuG7IWqsQrM6vdmLhWOnq
	 ueBUCTwQXmsmmAI6obaWpSS+135LbSmtnTANp3/ywEB7j7+lDwrbcxe/NGn14uMrSd
	 YhiTEuyIqCfUWTQmG2J1+GLMajfG8irIwYntihWpn/JL/IIJ2DUT/3BE/2Nec8y38C
	 WEvLye4zMDFvYCiNxe0WaK7E39s0CZTbPK9gXxpVJ5cl3Tb6GZMoykEUir8qma3rzY
	 c92N0hfOgvAeQ==
Message-ID: <sashiko-outbox-203399@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] cipso: unshare headers before recompiling IP
 options in cipso_v4_error()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261106234313.2537882-3-edumazet@kernel.org>
References: <20261106234313.2537882-1-edumazet@kernel.org>
 <20261106234313.2537882-3-edumazet@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 23:43:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> cipso_v4_error() recompiles the IP options of the offending packet with
> __ip_options_compile() before echoing them in an ICMP error.
> __ip_options_compile() updates Record Route and Timestamp options in
> place.
>=20
> cipso_v4_error() is called from the LSM socket receive hooks through
> netlbl_skbuff_err(). ip_rcv_options() unshared the IPv4 header earlier,
> but at socket delivery time the skb can again be a clone sharing its
> data with other skbs, such as the per-socket clones made for raw sockets
> or multicast/broadcast delivery. Writing to the options then modifies
> packet data seen by the other users of the buffer, and a concurrent
> recompilation would hit the same check-then-write race as the one fixed
> in ipv4_send_dest_unreach().
>=20
> Make the header private before recompiling options, as ip_rcv_options()
> already does. If the copy fails, do not send the ICMP error.
>=20
> Fixes: 3da1ed7ac398 ("net: avoid use IPCB in cipso_v4_error")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106234313.2537=
882-1-edumazet@kernel.org?part=3D2

