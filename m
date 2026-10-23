Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773885;
	b=yqQmXPPUCuuxbruoOfojZZIUYnaDyiAASuRjzWDe0RB/YiMObilOrelLoEUw9Kpxmulb
	 FZIJymL0wmMuFW2KvNK2ryuMIH0YMoGKMoae2yqgYSkPo2KPWVQUqAwoshLJ9o9RHYRpB
	 8Z3me2+aLmxNbDj40nzflnZy0xN8aD3DXRJxo/rFBVT+KGocEBC6dV6ls8s/radVC7w7g
	 DkxCTs/movGK2Trk3ZBYGcVlnNN3FGVlB2fGRxcsNvlqF4Wm4nOQYeqpa4+czW65W9ysJ
	 IDZma8ii68iovUSH8nNw7hpEohBRJghRMTfK6WoVmYDXXU8+5elMSpwGiQGnnhkexjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lLPl7W3Eb2S9eXa6o03DZiW6A8ocjpIA//f4rObH4mA=;
	b=LBAHnSyecm0468tjTmis1Vb8CyjJ4uQFy+ARedZZULF/dtW5sJPufuDIlSrEkgR7kzKS
	 z3Q3u9op1o30nMHP7/L3mpyzXUnkzVKabPnKVhBcDXBIYqez1aqh1iCTzwCgeykJhXIge
	 jNmf8wqGXiJVK2mudSRGhE+x80I81+T3OYiiGV0KxHRbXWZHsWlU1+c5UHZ7tQdbnnwe/
	 6VMHP7999eWzmOKruGLqn3IwtFgLB5CCseUV0/pLJ6cu0PEGVNHO8Ac6mAKVCUdNdQTn1
	 bvKlXkPSJQmL7okGwgNBY+gCMKKaUm3Xe4cknNPdsYH8iZrQ/EaAhAmTRTuQnsktduQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBn4BeDG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF77606A31D
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YBn4BeDG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71851F01825
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773884;
	bh=lLPl7W3Eb2S9eXa6o03DZiW6A8ocjpIA//f4rObH4mA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YBn4BeDGLBwmFm1wOVJmaaLxrXY61fEmayD5uSTtHkcZthKXPqOZU6VbGSX1bKe7W
	 e68ebl4uuVU0Ec8zaHjauw596v/XYjaetFjLnHg1YhcR+mNFFhMqnHt/q0tZtHjbuy
	 XhBWa2b5Rcv59z916FhlO1qLIF1mgwkUj84fJrZiZR689dqBDDqhl3A4C1BqueemJg
	 aa8viMTS/46PP4pRnqayobH7ulirxkXLtzRumFVgpkWwLi6cCGymQyuJu10+wQ15fS
	 osW0wXGWq4G36AgOQmpvpBEMo7SxVyNTP/jRxB00/px5QoQI5+cNC5Vyv0GM9dXth8
	 YRFFk95cGh6dA==
Message-ID: <sashiko-outbox-182966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261023-b4-setfcap-userns-v5-1-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-1-0620223be951@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:44:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-b4-setfcap=
-userns-v5-0-0620223be951@toxicpanda.com?part=3D1

