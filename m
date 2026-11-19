Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795085271;
	b=qMK8d9xBJ2gPP0XRp2Ruu1ol8EC2C7atFfNAIcfdD0UrkMAFkgLcSXXSVPiLCqkgwC0b
	 uvKQMGnVVk5zn2x7eidcZJhnBUjt0zScZnVEJocnMjsRkj0I/qKyfGtbdMlK8MsxP6Ujy
	 /K96feECTcm1FnZHhJHAIX4ykuZVjp0snV7FVhYiIZhiiJSND609DLbQpWSGsBn2ZnYnm
	 V3/7RADMQEyO09PSDqtWzcFwZ8JuivEKHNPm93LxJlCQ0tbrY3PS4HV5HEa1P9EKDoLS2
	 mHzfy6olTfDnxOHWekE1G7qQXmWMAWdxJ56jnEcBMma5ejQ02SXnJaaACrZd6WCgd7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UNycvgivvXo3K6H2PpWllpldfyqyWQqbpj/lkzrqYRc=;
	b=w/Y2w6PZ9+q8NxF6k3Ey5nf35LK3g9yc76TVPCuNskNCmruTypCPBiJio/EzMkQd4vd/
	 eYdwIIxy8hk3vI040XBwIQY5iCSBp0oNa5rCNXlAVWuaiMhJzvemCHQA6dI6+nwd5MtOQ
	 CVRj0vLLyxWQ3bw5AJ4vNjUDiCzKi+v4kG01MxlL3A/W1y+a2hqznld7RNjCRUM4qCVhj
	 7a41kGMxQP0wfVXqU+UqEiA3zgUW5LA0asI8/yKzGC0SCr4+z7dIv6gkkM/SW/4zQLJz7
	 wNcS9tFGA1QC4dq9Uq9ReEoCx/7lc3BZkwugYolhWJuB6sSngZRvmygfITbUTpAGTFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgKeE8tR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142A606A324
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XgKeE8tR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51FE1F000C6
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085270;
	bh=UNycvgivvXo3K6H2PpWllpldfyqyWQqbpj/lkzrqYRc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XgKeE8tRD9EearMzGYvyRL/A8cucYUz2kT/61FnsB/Fo0I2+/HkfWmBBXI/vQSFuZ
	 i0SKppOIzWwq+hu6BGfyiU+qEnMMcff8DjcZqWs3bViNWQzBnsXZZJRniQ9f2KFSwV
	 XBauNfcRWPJLKqHL8jC6cPUQ01dsySQ1LONomQ1pGNyeZs23G9umSj0qCOCe5osK/r
	 KALsr0B+MHgAWM8gdFB9jcovy2Ed2xrL5PA9RZvQDPctg6jwDeZ0S2UTElbf0E4tWu
	 s9kotTZ8II340JKGCknrUMdaTs1NDNcfGvnX2bubu2qYiGc5+UkWQsETqJPVXTjZqT
	 tv/QfH64qtKIQ==
Message-ID: <sashiko-outbox-222984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] selftests/capabilities: add userns capability
 bounding set tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119104208.782900-5-halg@google.com>
References: <20261119104208.782900-1-halg@google.com>
 <20261119104208.782900-5-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 10:47:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add selftests in tools/testing/selftests/capabilities covering:
>=20
> - prctl(PR_CAP_USERNS) argument validation and authorization rules for
>   lowering, clearing, and raising capabilities.
> - Default full capability grants, cap_userns restrictions (including
>   clearing all capabilities), and monotonic inheritance across nested
>   user namespaces.
> - Default retention of capabilities in cap_permitted, and strict
>   enforcement and persistence of SECBIT_CAP_USERNS_STRICT and its lock
>   across user namespace transitions.
> - Credential and cap_userns clamping upon entering a user namespace via
>   setns().
> - Implicit parent-owner capability bounding by the owned namespace's
>   cap_bset (including over descendants) and the caller's userns
>   ceiling, while preserving explicit ancestor capabilities.
> - Ptrace restrictions across PTRACE_ATTACH, PTRACE_TRACEME, and
>   PTRACE_MODE_READ for same-userns peers and owned descendant
>   namespaces, while preserving explicit CAP_SYS_PTRACE.
> - Preservation of dumpable and pdeath_signal when narrowing the userns
>   ceiling and resets when widening it.
> - CapUns reporting in /proc/self/status.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119104208.7829=
00-1-halg@google.com?part=3D4

