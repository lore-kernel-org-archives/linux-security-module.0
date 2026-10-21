Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792616262;
	b=Q3eVaQfMrImTbpnNP956fgpDibs8tbVnxtSka9ORlR96AGLgpe6MiEQUU4s2KlF1wdDi
	 Art5b5il5QFMIOtDs9o9TNpR5j+hJtPVUGweNmwJu+1dltBgLF0M5ehrADQdeu7kqC6uc
	 dui54K+Zb6nn2NYoCoW1DN7+oSqjHr/lOP4aHtA/TblWNpNAO/uS/w4DSsHWVA5/qHYct
	 udXMzJCtvatPhAIdN6rlvqnQR+3lj48o3YRtMIql4TRalsxuorkreL0G6MymmF2TZ0tXt
	 tzsY5+z/LQVyacd0gI+PJjfDDy7xLLDQmIaQ/ylp2JezQZW7ajZdNub3H3biyYL6KLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792616262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=98Pm0MXQ/4tHcJcBVuNymTScO0UPyQxCtLz10+MODck=;
	b=rURgsegk/7+j8ngvuZ1hJbevQMQLq9+iHEEY/MxmKRlIDDZw3udlfLjBKal/ezu5XSnt
	 J2zdFReOs0u2794pzLVWmM+CSarPL+t2y6CkpGRCFDVK749SNLuaix+o7rwmDnjEWtjle
	 AwluMzTovH2+oY5YHEdCEr4iyP3n0JKEwyGZzFxN65Xxh3+2aOKiS508My0BOVghGw5hs
	 2JECdTH2OW71RZ8eElgAWdvV5j8gVZfVmv4BFFTnGlg0agBWzxtt+CiBbkLExuckmy7uG
	 Jhls5jYV4w3OlXINiRPfaidutB012qkH0L6LHGCpmW66Fk0AYup7WOBcXkujAlQhgHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQUBd9ID;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8332606A31B
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQUBd9ID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DFC1F000C1
	for <linux-security-module@vger.kernel.org>; Wed, 21 Oct 2026 20:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616262;
	bh=98Pm0MXQ/4tHcJcBVuNymTScO0UPyQxCtLz10+MODck=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EQUBd9ID1z+vpVhRQA6Uv7J/XMGCkgEabi6tnbbZKcSz0lXowN8HhgK67bYega9mI
	 MuAS3Dg9e+38cFvRQrfk5M9KTDkWn/TYrPAT62qpVZuVPZ6jTvrV8qSfKGhPZcxUbS
	 pSfMov0jFs2ngNARwgQAGB28GthZpfArAt1fIaXuE214fKoVR4FQnFkrs+ak+q5Vwb
	 K8hDrateviEyMRpVBWHh8b3R2FSpSiRGeH2J2iPCDWDFa4VUQj1ouSE5drQab+yJzS
	 meQJ6QLHpYuy5NvL5+dJ0kf6qBmyVSkLCjyS9W0OHeiYou9fcfuYytE28tMFiBt1Cf
	 qsbxCeJlI6sAQ==
Message-ID: <sashiko-outbox-180671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261021-b4-setfcap-userns-v3-3-97c7ed4e43e1@toxicpanda.com>
References: <20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com>
 <20261021-b4-setfcap-userns-v3-3-97c7ed4e43e1@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 20:57:41 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> verify_root_map() looks at the cred that opened the map file: it asks
> whether it has CAP_SETFCAP over the parent, or, for an opener inside the
> namespace, whether the creator had.  Two things are missing.
>=20
> The writer isn't checked.  For every other privileged mapping
> new_idmap_permitted() wants the capability from the opener and from the
> task that calls write(), but a map that consists of the single line
> "0 0 1" takes the unprivileged branch, where only the opener's euid
> counts.  So an open uid_map file is a token for mapping uid 0:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   fd =3D open("/proc/<pid>/uid_map")
>   B gets fd by inheritance
>   or SCM_RIGHTS
>                                     write(fd, "0 0 1")
> [ ... ]
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-b4-setfcap=
-userns-v3-0-97c7ed4e43e1@toxicpanda.com?part=3D3

