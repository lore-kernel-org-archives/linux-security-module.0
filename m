Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292517;
	b=YdbSOsYZaMx8x+Kd75XpeHyr4iylsLiMG9uCch5TK/F/Jn8TYt7L0EuejTutdrJxzV/+
	 HLkazD5iextV5qOfSD4WEPnOQ4bglm6LxYJw0d8Y7FC+3vpLdaDtXwuIQ/2GQIXaD51Um
	 3sVbBLfltWJDd2Y8vCRRPUHhA615qUkI8E07OYEYIwgvy7EO0teRvPltiazt2J5HR0v/x
	 +77u89fUNaTjd0xuhlegnJJLpegXJuHd3Xh+d0Zi4Jm6jbVg+XaGhXM2Uq+bW5j9haRXy
	 RZmv5veWgIzRjDuVSJbZDqRB24cJTQ/kSJGxeSfRkacBzk2w+wmar5svgtsU3tPdutg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BrgSUxO0GrfroqPzBqCzMsvLDU+cOKTPz8t1PHxvO5A=;
	b=K3vDE0GDA5KYlNOFsXntugS7UfgiDbnjbJwOasvyCMaVY25ooib4w5Ee68xMFrCvj+fV
	 ztGLkRmaYZydvPSHSDhVx94Bg0OFx8Mh+qEKpqGH0aX2xgYMVhTzacVHheSb9TcO+HiUj
	 U+BBQOgo4pyVd++nqjb4Lw7fUlX0cy/6nZ5Kfvec1LYCyH7frsoqXr4dlRqz0U+HRdQW6
	 tspme25So67Q0td0V8EQ8yDBTNhzCX6IEJaH9rnv/x72/lGX32p19MK9c0N7lL/wPFWOG
	 xprxHptz1d32vxDDrgryZTvSWgSdHHjSb8khEGZwV7gSMvDZPva8HOpbJdePi1zAR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwPdjljU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AD606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwPdjljU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179851F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292517;
	bh=BrgSUxO0GrfroqPzBqCzMsvLDU+cOKTPz8t1PHxvO5A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KwPdjljUs+dWF6O9f2ivc02dExYF11a2XldVn3BmA7Cr1PvVfa2QgInd6yq8DVzFZ
	 +GIsH91JlnZdaE5pT28/IK2X9ebpkRyff3lLWBuZLUhp9KUyrdEmQtUfRqtOEQf80n
	 /VSZA1Y0Z/WEjH6+Boi4c5VbPf7LMK2PdujMJL5+I+Zum/jyYjdkbMknKrDYGAqlKJ
	 nIV64mbnQ/09lRhYB6REuLoCEiG8fY6bYKxQ0uUq3Kqdj0h6nCDScRJBhw/plstTXM
	 vOeKxntPnAeYkBbBpLLvBrColA6P9XR0wSNzX/Ud05HOSO5J2EJ+be/p2omwJo64Qk
	 sZqfj70OJVbtA==
Message-ID: <sashiko-outbox-189678@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] lsm: always call the namespace_free hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:48:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D1

