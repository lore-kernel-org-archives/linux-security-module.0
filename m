Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802592;
	b=i/RdSNt0asZQfI9ar5k2WtrUC4lvp6RMSCKjLT+bRhaRUsHx6a0OFt5K+XKF4fvQoyOB
	 ypzNpxmkgGeTMgVw84Jv7sKALON5/CqZmVbmc8tM1I5pvHT+/LIvUf3h6Aq4gUPp7rhCf
	 L/cUYmkqm7FS6TuVaS1mI8enQYCrsZro3IY8Q8rHIO8PSFeS5lrr+jgwVEqWMJY7xnRya
	 7fT6uTNl2pmcr49M3c3p0Gp3qeKdHvuM5ns3KaesacsVc+nizLCO/s7YsUn74z/FsUuP9
	 r1E6w5o8DToQuoKxspTQQE4xahUzWfUiUSiSrz4EraPKaUr1dx7AJP9MgMZdz4jpWkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0ilVWFxi9WVpNnzRsqaBOTg+OfZ5tNoMsutJK+8d55c=;
	b=OjB6xkLli955sI2pJnh1pepFIiTgP19ViS/5zClB0LiD4tdB2xKnrOIofl4pVT5SrUp1
	 iqEVW7143va79sGeh9z0MtTR5zHIQzU/oHBRhzI7ylcSVs935IqS/30qb9F5/ZiSdP/JH
	 rWv08Ek13Ss9pA2522e65cpEyS0vmKJCE/fIoo30puKIZLj+fS5qnBxSzEOjI9cddQFPM
	 PXzyqDNc/iSa4GRGOnnuTcjfc1oWADfW2+Nn8uc0BjrNqszHjSYLwBRUTlQ1Yds6A1cXm
	 kS+0esZ/l5lf+I3+B6FdW2NdmvE5qs0vvX4qy9G1llkmQZcM0J7zrkWz8bcB1sqSl4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQbk8WPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956CD606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQbk8WPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1A41F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802592;
	bh=0ilVWFxi9WVpNnzRsqaBOTg+OfZ5tNoMsutJK+8d55c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VQbk8WPyMZsm6Muf/DcZKTNjVYULm4S+nHDM4eMtuVFaLsHB2aukUWYQSwszb0DPc
	 dIDNvPpzkLEOO93mG6mvqE0n0SsPHYvaImkkiEAsxern5Q0AQDCrNqAxobkd+LuCL2
	 //9hpPZ19bkwWQ6FAV56002UUlNKoMmBJsXrgLsn7JLNiIoueDW9Xjh3ZunHr+6aCb
	 fac/ew7Af1da68RFHFBwZ+4IF8fT9HQqm0RfTvrtZ55kRLJcSMsoK1fhNlZbausMaz
	 15RlxbS6/OCgxj9fuZSjc+7xzC6lVp7r3u66e/wI8C09hLtrEHTDdbvGOF5Xz38BL1
	 0FovNv3OdCS1g==
Message-ID: <sashiko-outbox-197442@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] cred: gather the rules for acting on a task by
 uid
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-1-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-1-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:29:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A number of operations let one task act on another without any capability,
> because the two belong to the same user: signals, scheduling attributes,
> priorities, resource limits, ptrace and more. Each of them compares the
> ids of the two credentials by hand. There are twelve such places, in six
> flavours that differ in which ids they look at, and nothing says that they
> belong together.
>=20
> That makes them hard to review and hard to change. Nobody can tell from
> one of them whether it differs from its neighbour on purpose. Whoever
> wants to know what an equal uid is good for has to find all twelve, and so
> does whoever has to change it. A place that is overlooked is a hole.
>=20
> Gather the rules in kernel/cred.c, side by side:
>=20
>  rule     of the subject    of the object      euid 0 used for
> [ ... ]
> goes with the operation, remain with the caller.
>=20
> The callers are converted one by one in the patches that follow.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D1

