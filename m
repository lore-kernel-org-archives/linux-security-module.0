Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030418;
	b=TKvawjrept2W4x4vfpXy0AlafescMrYz6DyWOrDEtBoPR0ypJAdO+Kh48Tinc80PFd9t
	 8YfuHz87EtiHi/IOOl+1JthKpSbD4EzeqRmfJ4HjQzTE5oERtr5lGpgC/xzBmHErXefw6
	 uHcmFf4vAEZZpwWy2Wg7EfqzHSnMFJEp6hQLpwN1h0+jvnvKi5nmTBIzPlF6ofvQqbDXG
	 wRmUXBrtVlyAPY+QS5eSO64cj5R1240w0TMrjkHQVSKfrYWSCANZK7lPTd8xkDG61rUZK
	 qY3zCaYdr4cRP336rAy6XEWtgzoEtBVXiXWbEjs8W942QkbLo9HtDt7sD+NaMgLKjFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LsmCRbfnBQ/ZT05OCJLlMEhsm1yGCpMkJgnEKCeb36U=;
	b=sg61LoHTbfgJvVAftb3Ow0XEjc4spOd2eF5Dxli1pDBGTdRGbxW2Q3l+VQubToZnaPn2
	 s8qz1qim8QP7kStYD0BGiRfeBxxkSzEITsM7rzaSw/ikVdiC9mOrGVMpuwyC+aGiTuo4x
	 DLJvmYBq+i7gXqPL8LfLxwi04eBCJU+Fmty8g5I6FY5Fuc29gh9NisOKbbkl2sJmKNc8S
	 /084DEmSlV3r8NgPOrxwNi4XTl72JU+tjlAzWVUptbaoQfUIxiicGOgyXEyWgFLWd9rDK
	 TtTQcSGwmxMLUHHYZp+9EJj8+rj9IR6QXLLJDc1/0e3zt5ZK3NimE4MoJtl9NJhoieQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTlHjC1L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42562606A321
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 16:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTlHjC1L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9A51F01828
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 16:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030417;
	bh=LsmCRbfnBQ/ZT05OCJLlMEhsm1yGCpMkJgnEKCeb36U=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CTlHjC1L4tkmUeKbvxU8ZtHYA2mUlnVMwgXwYpA6fZY0ANWZiXEVfjOk17YcIlA3U
	 x8ohE3j/J8lKfP2yiKB6iy68Gl2i8f2jY0xla8pNDVhRkf0XznzbfUu+VwceKsMUqI
	 WJYrvjkpPv545yx1/O7o9pU3N/mPAgg94Kb/9ZsrvSSjPia42b2obAN/yzc5PHTkZF
	 tS7vjWxvAKMysV2f1FGCz46hEBVInkyGcbjwZ+mYAfAjn/93bWbc1K81J+335r/QvH
	 uC7x4j0JvRCjmPu9ePfdmwC6XEzOEy5lNhdzMuN4vLmnvwioww/T3SpSqz4i9IJByG
	 ZW8Meeja822sA==
Message-ID: <sashiko-outbox-185476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] userns: check the opener and the writer before
 mapping uid 0
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v6-3-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-3-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:00:17 +0000
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
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D3

