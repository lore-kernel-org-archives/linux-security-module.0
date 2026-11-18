Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020035;
	b=uHThGhqYTmk41MMn/zL1dpjbR6KovlnrWkOuuGeNcPVbw3CT8LHbmJn/bmwxpf+/FEhx
	 vG7GQQs+T6qpYK1IfP/nhOxezEtPnbixZApo0qO2iiC6YK6j+7OTsnA/k6dRHk4YdTUYD
	 92kSiK4Uy/MmjOXOaLTr7JzZqsBm7KNON4T8zhE+Da5MbDL1VQOLBnZi1yrQVqjymUUqm
	 wVehk1vwy2MPOiuAFmKtg5jSIh/tX94Gp5EHa9rM2VZ88Wsv+PMMA+8wqXK418hZ0EZyG
	 aqEdVi1ndptePmhhi8Ws3aHPy0G1uS+V2tAbdm4lYa87DYwuoRhBqee2yhGKvj5XPKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020035;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3HbNwiN9o8kFDj7tIGlGEGCQtggVYfFbLtwpH4WZLOI=;
	b=t52gPTftFE5/7OX9YBFeIYMmsgQbd57g90M0oRpDcokopnKXXA52X3pMwAySdIxj7a0r
	 wBuHg4e99lb+vPB0Ci1zS4MhUlIlac8NRXsL+O0UbW4AHr7PtqLrV4vy07YxSyAUl5j1d
	 +9lKfoLwM+C85gfiwwcSLLn0Eju+Ftv1tMzyoqRX6HUwlQoVOOQXfveEP06HQWLmEtsT8
	 9+tbooT5aIZRImzW2ctRI4417HrxRWuqBe5TRCsbsJzsLmBM5Kpm5594+Z2JekF8wW6sN
	 qskzRXhf539LBrj74ZE+Cj+JWJDQ97SWvioXGi8nd7CHfntWJ7Qoi4g5iTW3kuiyB0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvKLfryg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7A60A2604;
	Wed, 18 Nov 2026 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AvKLfryg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DB61F000C4;
	Wed, 18 Nov 2026 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020035;
	bh=3HbNwiN9o8kFDj7tIGlGEGCQtggVYfFbLtwpH4WZLOI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AvKLfrygCWrtm5Gho40kBLPO0ltdokJiR7O2DDeyw7JcR5KDZ4w7c8szzE2hW5rqP
	 sgE5ipzoxgoXjx0o0DElOD/VmxNe0GGrIky4G6HFCQcqiPs/cvmyE7NZc6g2d8vy9j
	 OSqXVISPOr2sfyEeZZD6f8wcsmyNQweuCUaK8ubdDqCJtJBGk/8yHzOQvpXSzUDI83
	 y9hBJhMHrBF4vz0qtQhkwFuo8kBKtakK/grhUTfxK/AqTZ4vXLFOPPrjdOnA7JEUK2
	 bC54GOzCGiO92dM53jKk132fU+3vawXQZhesaoIsE1ASjdKfFuG6e92vETwys8uDxA
	 uUNGkDBEYBxVw==
Message-ID: <sashiko-outbox-221524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] landlock: Distinguish namespace creation and
 entry denials
Reply-To: sashiko-reviews@lists.linux.dev
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261118163254.2554413-2-mic@digikod.net>
References: <20261118163254.2554413-1-mic@digikod.net>
 <20261118163254.2554413-2-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:34 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Landlock reports denied namespace creation and entry with the same
> internal request type.  Before commit 08471914d6bb ("ns: allocate the
> namespace id before the namespace_init hook"), denied creation carried
> ID zero and could be distinguished from entry by ID alone.  That commit
> moved ID allocation before namespace_init(), so creation now carries the
> ID of an unreachable new namespace while entry carries the existing
> target ID.  Namespace IDs are object context, not operation
> discriminators.
>=20
> Split the request type into creation and entry.  Keep the two namespace
> values together before capability; this renumbers the unreleased
> capability request in raw and typed trace context.  Report
> namespace_op=3Dcreate or namespace_op=3Denter immediately after blockers =
in
> namespace audit records and trace event text.  Placing the operation
> before namespace_type and namespace_id lets consumers establish the
> semantics before interpreting the following namespace context,
> especially whether namespace_id is the creation-time value or identifies
> an existing entry target.
>=20
> Keep namespace.use as the policy blocker: the new value only describes
> the semantic hook context and does not add a policy control.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 15dd86021b57 ("landlock: Enforce namespace use restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118163254.2554=
413-1-mic@digikod.net?part=3D1

