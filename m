Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011050;
	b=y+M30Xvi/B57nKoOVe+a95CqIVFOdsME1XEdFmP1EG00reQXl5l9KSQzSIV+Y84/8RZl
	 mGH7DxFrNLpStYwPC/SXll/HFnoYNV+7m/+xUkeCm1JR0+jrsZ+ElWxmdh+a3YjjITqLG
	 pofhzTTz/f6wJk0jCB/35VubNIh+Wcm1hHPr9guVl/0iYS7jPAr6XOdAvdHYWAR9n3hmq
	 wJocyi8mFG1ukFeeMdfqtSSj/T7kkH0RHTVjvqQVsubFLLaUOTTEp1rfO/Mbew9p9Akf5
	 hDorjGpLVdzSGLTP5Ac+tMbwLU++e3ly4NY4NwS755u80SQ1s/ngllkN7ZeQVKMgwow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011050;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KkDVyGatYm/EXLR+rKS3Bur+LPehQF75xAfLC5VBGiE=;
	b=NApWFfQtvzwV/pohd8ZRaJoD78pgYEZ8T3doG4ss34anIG6pf7vhLbGYUfOZJ9c6XZfK
	 wTTQjr88LGT5/ttg2F9xEKr6FnrQ5V7QiNDAWmRCdyFpAlFjNuNHZy5j/1kpEBkU2IqWY
	 EntWGBdPMDOIjMtLqXMW6Ook74quhnbGRjAiHrQg2Zt5ZD6G4ExA1IesXbJRG43PfITZ9
	 6J8nl+rConlasRIRmEuJWUzJ+2w7pDrJrOsEs4m7Lza3l1kfv/A1Q6Z7X0QRF5d4T/LNX
	 7/w2KHp0HB5z+k4neFNJBRTxbj6kgH0GStQJ2LbTEhMRvxUvQhJx7p+st2PXk3+YiiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO82iVyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42F0606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO82iVyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C091F01828
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 10:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793011049;
	bh=KkDVyGatYm/EXLR+rKS3Bur+LPehQF75xAfLC5VBGiE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mO82iVyCkuhHy7CUzdh5rHMO97ROQpdye7mqajpcWxC0xM9PjR1xDdMvaaVKyV/4W
	 E/m7NPflMnAixtohn8NOYGUVd5qcztMfjUQZmjzAMkT5FD+uxKeJb81boLCmHYxxaw
	 nM2Z67ghLpX6c1jZ/w6eLszVRx5CBKMx8Se5nXNSLbz4nxOS2XBy3RBt7t9+D5HbtE
	 vxT7QMyYzQ9JQUQNp40QhVgJOsBLYIwHef6qh0VVVc5zGcTonPSzm+vQ+4Cic/UmKL
	 K3R2iq83rs+cJxD+7cMCj9zBdWyKSx+j0lKWgxYfNn6J80GcJGDylIAsjUJPpC/xl8
	 eJ/JcWbRsMkUg==
Message-ID: <sashiko-outbox-184971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] lsm: always call the namespace_free hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-work-security-namespace_free-v1-1-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <20261026-work-security-namespace_free-v1-1-ffa3ebbf71bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 10:37:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> security_namespace_free() returns early if ns->ns_security is NULL and
> skips the namespace_free hook. But ns->ns_security is only allocated if
> an LSM requests a namespace blob via lbs_ns and currently no LSM does.
> So the namespace_free hook is never called at all.
>=20
> Landlock only uses namespace_init and namespace_install so it doesn't
> care. But the bpf LSM attaches to every hook and a program attached to
> namespace_free never runs. We want to use it in systemd-nsresourced to
> get notified when a user namespace goes away. Right now it has to kprobe
> retire_userns_sysctls() for that.
>=20
> Note that a bpf program can't work around this. The size of the
> namespace blob is fixed at boot and the bpf LSM doesn't request one.
> And security_namespace_init() allocates the blob before the
> namespace_init hooks are called anyway.
> [ ... ]
>   after:  @init: 200 @free: 200
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-work-secur=
ity-namespace_free-v1-0-ffa3ebbf71bd@kernel.org?part=3D1

