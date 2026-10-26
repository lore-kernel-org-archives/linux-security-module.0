Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050592;
	b=33Pkpj/hTS5/QpY4pwb+IL0EeeSbiI9YqOHYLsqMjJtZ8j37sE3uwOVozbpUqCSixI1z
	 1H/fDiQBYeQBh50gth6lFmMOONmZB6T6SjJnGnQA9/jGDPMXmTadHulcoM+9P2Om2QeXB
	 kopJudsIAAZznhmhSm6fmNWm6Jwm5H1byVA4e6yP3Tj5imdDgUGZ0I9cSKetHua7dPZwp
	 0skFLtIEMfNXkrGufGGYmcH2raStIKo3YjghC9127jEtPw/JHUG/Ucwi+sdJxmaR0m0jw
	 icT1CYKiSMZQCA1l4tXKkjbTgiM0zoKwx0xV3JQZGr+sB99LIBnJMls0rVrgnPaDNLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OrDuQKpIc75ehwRpxyjXQQgDx+Wf/2bC2h1z1ooFE98=;
	b=Y+rN982AQlXeiJ/5HlUxXdye8k78gOtGoh0AZXZDwGYV0u2wMkyqzHTFh4d6mutkRuIY
	 czMyC1Vopoc1JOTuYG0JPK+j+ubCZUd0QaQTHyuH8nWK//w2MQuxfcXjBIAtFqedS/ql7
	 zvUxK5Y2RWmjIco7aPIXNSsKQV+cH5rEgYZfAjGUthoWnZpe3CGFu6sKfiuaZH8rW1fo9
	 nl9CtGORsJKr45NqbABrH5Z9ECPjlTpzz4A4gAItU2BfYfntQ+TDcJ0MzUv42kruuqMEz
	 U6Ut8adVDDIjMVXVJ1GTidsm6jKnquDx2C8CqTCj+2Hx1zpDU9K/EsJwKIbUIQkp5+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMU9+cTJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4796606A329
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMU9+cTJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5983F1F031F3
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 21:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793050591;
	bh=OrDuQKpIc75ehwRpxyjXQQgDx+Wf/2bC2h1z1ooFE98=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eMU9+cTJMCqEehttCTWLRGtzO0+Fdb/QjZw28H8w+zRZbz7je6Uv5FFOawymSMocS
	 AAigVYxC0AQvRh/xiOv/rd9jdlFbj7j7qXU6LI5pQitGqfEN3Qhm+ScjbMTDf2b6Gi
	 Mw0hRNbbjFom4jnkIpHWdVmAlLnS6TF3AEYP8J/j4ipxkv3/Jd2lJW/8VT0HIy6OqJ
	 BN1LEyw2DNh6iSQtZpyQKtKh81j/rx8ikCmqU/HwPP066yB/mQQOI4rdzIjf/PRUSf
	 U0IILTSwWaRNBFnyd7YftQsqsgXLwuxyiFE87RBcCCc0IKj+5BKSKYic6Xig/aXowf
	 1XS0NRqw6gyuQ==
Message-ID: <sashiko-outbox-185752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/6] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v7-3-bf8a576f7259@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com>
 <20261026-b4-setfcap-userns-v7-3-bf8a576f7259@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:36:30 +0000
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
> of the root user it passes on, now fail with -EPERM.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v7-0-bf8a576f7259@toxicpanda.com?part=3D3

