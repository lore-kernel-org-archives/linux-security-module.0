Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695548;
	b=D5le8eY1t/0PTvYsc/LwVJero2Csk++OIR9f/CqF7b6XrbBYHZTHMSTW7bmaA3cSnhPD
	 5Zou/J5eQ7VFAQyxKrBIA5tzU2Vt0VVJCFI/AchU/81hPhfxr40MTc90zomTijWqU5NGq
	 MRbbSJZA0ZrSe+GqoIvllsKsqparfI+DAqmXlGOBdSRrNOBzREAK15bk/QUKrfRkmE0rv
	 UCcVB2v3dFGSNQB9m6/hUwiid+oEDRm2fblpxp74cmtUM8j9YYlWi6lG9hYcPtyEw49uq
	 8X0okqaEi/VsrqC2L175x+bDqm3pn3V0Cr8Xq5MEA8mM8GUTHvbR+erkms6DeUEDhNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jAolMVMcbzwNHIKjhK2rxeanb0dQbS8V2wAT7ZMbs88=;
	b=LS+GUajwXfh1HSMUpFiUQffnn87IWUX9SorDeQ0+RiDpB8774qL6NhzloAOxvWKIuJeb
	 x1bQMv/w1FAOu/MEqtkel7x6otYve1Yr2cpM3G4P8w0ViqW0L3h3NZgHOWKR33pJhKAej
	 Q7TngwTKfHoZ15ICKuKmBML2C2EcN380USs41U2bhmAZ4jeZR3TaeloQJAJGPqEE7ijm5
	 Nd7KGvEbUgcSKhqeDNG/cZ8bOh/rE1pvbtcbZVncHjSpV9lorXV8qtb74pf+L2D3S43pf
	 6NihtIQbo/PBw+vZUBKOEkfJObCwVbAMBdmChMqjUguPloPr7zJl9dUa4/eMb81+OTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEUKjimJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF318606A319
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEUKjimJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDC11F01825
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695547;
	bh=jAolMVMcbzwNHIKjhK2rxeanb0dQbS8V2wAT7ZMbs88=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aEUKjimJ6mmjN2+jWtpbXTsPF6w3pAuFyoqeIbHI1J8JklI1sNPAhkjr/Gguf6UW7
	 zGfZqUNhzioSbXlJs1U8v8WQTPwtMHRICHcTlK1i1RyKFzj8MBn3ki+0mSC51EnK30
	 FNLdKbuDm4zKjmCyQfc8VzNojO7hMbEp9wz2kFyCL4aTm72nKfLNTEKenuLzimIcmd
	 WgjJfFP4r8xc01vELIX6RTiOdao3GuEy8PB3TNOYIuhu+p63hB9nvsyklAvMHGaQPw
	 nPTKdfrC/mq+iRNNr4CzQjznwORcobx+Wxxjz1hH0lh2Z8KPJfuoBVn+DD+1ghlf4w
	 2aAgsM64dEccg==
Message-ID: <sashiko-outbox-181940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] capabilities: limit fscaps to where CAP_SETFCAP
 reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261022-b4-setfcap-userns-v4-4-88aa0ffaa08f@toxicpanda.com>
References: <20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com>
 <20261022-b4-setfcap-userns-v4-4-88aa0ffaa08f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:59:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-b4-setfcap=
-userns-v4-0-88aa0ffaa08f@toxicpanda.com?part=3D4

