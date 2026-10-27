Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111945;
	b=ge5clcKKiq/14W5VXi8FVaDKGkjmO7cq+mbqmuqcovUH9IJZZjDj3COcRRTBhXmxMurF
	 LRu4JfFI1zYfA+M6waYoSMmHTW8YsLf8QcbmWTA3doBjqsvWHKMk5QCDT6TKP9v91V5yL
	 RLk812Qt67kM8W2cn0tfnTlwaUAT5O1lS+XAMj3FjzGwg7NMhYU0GXqJ+8j4+PRX0Ro39
	 +00rdQH0w1PGNPcRn7BWKQVbVoizPU/tJJuK60k1NVI8jzJCIt2JVUCQZJwkJsnn9qa1L
	 lr0PzIZ+27ahjC7o5A2NcMwhJRbXHhj3dYRcweMPW3KcXJID+HvHBCAgPeB0Weeb6ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sykSt/uvmjacP8e/eiDj6YuQv6UuyZCdzntr//kb//k=;
	b=5oq/BLvsBHoNmmxSU0bKBrGXgbIjETp3qHb1Fm0HDfNogQ+cD6Fil6k1qr1vj7j5icWE
	 ChLvA+9nRPdUYH+iSo5vWxKRKXYWizx1quUlN+KbB/kISHbb88i+dA1Bgode789xzwTQQ
	 QBytUxsGWoDxZd3w+ukXvRWNzZF/4Xuf+cuo24TvUPtIKIIqLRTZkZ2CmwIwDOmS7AZqJ
	 orEiocSamqHRS59zcNnfJQkQtVALMw7VoV1isnGzF/b0x+YUp79EsUiF09aOUCVur8D2Q
	 FfgUIEwjAAkJrrcTtWhIRRjAbKLaLfgYCFAFJWvFFQkbe02k+aFyk7JFtTgQrWxfIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADT7Gr5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACC606A31A
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADT7Gr5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4B61F031E0
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111944;
	bh=sykSt/uvmjacP8e/eiDj6YuQv6UuyZCdzntr//kb//k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ADT7Gr5JhtzH9SryHfj4Ep/uOpvFl2jcrZNvSmQmUhcjXx9GkzgzS9W1pGcfuWcvd
	 TNzx10UEEYAYe93dlPUMeLSetK+ue32W8exyPh2NnGRPBfuh3NSfSD9sHBjdB5Iifa
	 mSri9wnk1mvt8yYknf1bBaOohNYsG3jckGN2CFxl8vlBWTqu+1LliV6OKSWdS5agkx
	 8bMfoGebdeNzmfYnzSJA4BhK5x3nkk4JnTKRMvOFnYpdVeMN0sCb5fN5ihdtYOr8bT
	 MpiMe9a3WVcbkxg4uKDdcuF+2RAUn9u/hdTX6lfiF4DeLWER7+hz1tUFEGHwTmd7EZ
	 qve49OPpKwteQ==
Message-ID: <sashiko-outbox-186742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-4-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-4-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:39:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> keeps a root process without CAP_SETFCAP from creating a user namespace
> that maps uid 0, in which it could attach capabilities to a file that
> are then honoured outside.  But the map doesn't have to be written by
> that process.  A privileged task can write it from the parent, and the
> file capabilities are not checked against the outside at all:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>                                     unshare(CLONE_NEWUSER)
>                                       ns->setfcap_level =3D 1
>   write "0 0 1" to B's uid_map, gid_map
>     A has CAP_SETFCAP -> allowed
>                                     setxattr(file, "security.capability")
>                                       rootid =3D kuid 0
>   uid 1000 in the initial namespace:
> [ ... ]
> an unprivileged user does in its own namespaces.  The rest gets -EPERM.
>=20
> Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D4

