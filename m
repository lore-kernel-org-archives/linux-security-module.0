Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602664;
	b=ozaTiKhg0nrmlKdShggyqyfe5kUZYHAio/uJ5kILlwQz8JxZ/FqRcVefgl+UEXNh14dp
	 AQLawcXrfVwr2twI+Rk5fXV0ZtZEIFA1pH9Agl0CK3A2EOvbipwmttUe9koi1A9JouzVO
	 xzfAFFL97yEsVGlc5KD4ZiN8CHQ29fWUiJXaOSnlIHcyMOCfKFSqhAtSY0rcZQrEkgNKt
	 3kx2ADt/NvPNuSIPNXk8YVk0X5StZos7DTCdU2FwrPCuF6Q6mupc7j4SSziCtx7FOGO8F
	 ZGn7EdOBQrI+UakbBOZ/vR6Gppunnzn0dIn9c6CNO7tFAdqG5pyyjZSNwAG/iPpm7Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602664;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mmVfJXOhL5/HeCkqPUhS69QX+jV6I7V+lKVxZHxE3FM=;
	b=MHreXgS3dBS/8YupP1df1be5x0IsDbyfoKrYXIh+Xb6u4Prk4c9Y2CC+iqHUMib90jpw
	 26DClq11TFI8vUSW1s28qTyN2+hr9XcXRXfF2kikBNEZaRzpmVBz9e55+JSn58cKXfm+G
	 ssn6DXhs98LmKE0mBfGIl/uxprs0TwZVFx49rRf9pWap01lYWy/yNmGrqrdllpU2nqRcq
	 u91UjnHG7dURPEkF8vuO5rH51WFVMyk2DysmHvUktH6FyU1VUpRqf4VeQb6J5CuFXBJ1e
	 sPDpErf/FmgBELxvXXhJbhCPs1Y6k0X8KgEEDtDuk0D0e9x/jXKTvnFgbDu/JH1AQHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y74LWOxI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA06606A330
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y74LWOxI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637D41F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602664;
	bh=mmVfJXOhL5/HeCkqPUhS69QX+jV6I7V+lKVxZHxE3FM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Y74LWOxIm6g0fVe3ZP1witIFTBnjtq13JhzNPPOjjnjlVThaUgZeGkrMORPA4Bqsg
	 nEM/l/Alk0r46RCKeq+BBVx0RpFuAWBc+FVinW931VSxw63o8S037UAUBOsws/cjVC
	 iyFrpsTCqm2BqcN8iwCiiV2m5yo1lLoLKeH4l7szM4pUMSDxUA0niIgcq70K9jWh5S
	 brPFIxZv7tGdsOmW7S2V7w33XxtEiqd5IqztcTfjH1zH8DRBmgiROby0cE2JRxYloM
	 wFRxNz/oHCSF8F8s6r7vXZztbStP2lRzOyqluy8o5SqgBp9X301s+DW0vmGXbO9RkP
	 hbkRRNVz3ZUNA==
Message-ID: <sashiko-outbox-213675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] selftests/landlock: Test that layering does not
 break refer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-3-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
 <20261113-b4-landlock-refer-nonfs-layer-v3-3-02d7e42bcdfd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:44:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Regression test to exercise that layered Landlock domains do not
> accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
> used to be the case when layering a non-filesystem ruleset with a
> filesystem-enforcing ruleset.  In that case, REFER operations that
> would have been allowed for the individual rulesets would get denied
> when layering the same rulesets.
>=20
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-b4-landloc=
k-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com?part=3D3

