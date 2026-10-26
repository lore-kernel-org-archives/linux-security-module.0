Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030702;
	b=OY6ptiLAMbDphMI//aG3JSqFM7ftc7Mgns9xz1gfYd/cmCi0x+KkRViKzMca8/gPo7yH
	 RN/wFuPHjt6XIlpK1rMU1sayemhsfpRwn11nXaOHmKSL2U3cVdRT109qTOhi98SYTN1pN
	 mWeKwKMOCeeGncgxbLoCEh0ZZQzN2gUqjBcWvq0pRHvawT0pPMP8h1aMJl3Xra84tSeZg
	 eAMZlaayRt3ZKp5Uow0SpY9LhZEE8D4LvApFjUZhVJxs+YuoSayKxeff/p1tTjJi5xqHX
	 /QXL0Qa0I31aqQdbo4Uzdm605ysRig9l9rlq89FNSa00asF680QRTplxylj7U6GHJLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SDibFYlaMp+HhP89Y/QACuwy/6KuEK+hHNZAs2ONPqs=;
	b=l63M2X4tXsoZrnxCKOiY1MUoV01fThHeD4IoSRXt3m9OZajfwjksvkvzreg0yNC2Ea1b
	 1kKexWWFXaALVN2MUHNaJWey+CWT635OsRpf0SpFhRZhixOZ2SQbiV6KJ3VEdBTRge7AV
	 r5rpNfghOpl19FVZ4dad6XkWjVvkZiuFwI/jBRqfvkdbUd42QFzg2HUXf0ihy4tqjM8/I
	 1oldTOvHg1TNUhx9bcEvTWkmB4c7hMqy/q0ATifQPH0qdAJj4HlPIcTCHF9h2m8thJSab
	 mwm9QPsnGc+RPYu4qQwbHsRa6M0MKpriQ99d/TqzRMAcdrjSNTSgFeKmjnycLumlnBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZTEzxJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68075606A320
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZTEzxJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD2C1F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030702;
	bh=SDibFYlaMp+HhP89Y/QACuwy/6KuEK+hHNZAs2ONPqs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lZTEzxJL3nVVRAYU2EyGCH0R3aiKFnGENMUk09WMd3T1n89valshhp3eypfGFZR5p
	 KOCa/x44xWz5gTYfzDSJpvgwzs0TUIIFEIAqzObp7YZclglvoZi5KbzOzPhLZQZkHs
	 u8KaNjXEebY6ig+T2tl7ZoSkFfMSiA8XVWcpV6wqcYQAD7VY4xdOBfUHmSOMAW5UJk
	 01xsZ7+BdDyNAXYTG/BKxYC7P6NvfnjaH3YOhvpwfzrnwKnz9H/HpXBoZnJ5iCIOZy
	 htm+mqFl6sg7dg6Up0twIvN8HC6bLJADscd8kXOucVXrbh2sWESXMyYRs5PxI1JVYd
	 tdS5fihQFHSPw==
Message-ID: <sashiko-outbox-185485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026-b4-setfcap-userns-v6-4-25f10b7ca497@toxicpanda.com>
References: <20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com>
 <20261026-b4-setfcap-userns-v6-4-25f10b7ca497@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:05:01 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-b4-setfcap=
-userns-v6-0-25f10b7ca497@toxicpanda.com?part=3D4

