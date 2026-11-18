Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013745;
	b=rjwz6aAssTrdOYIWZ2Q711GncA9qtGlptWp1dHZXZyBvBjTx67a7tdPwwBNTJV+55JJp
	 /KCavKZXlfhjSKpnmIcaYawqMr7kJ30GU4f2ofD9dgNFj2tHbT/4ddv5n/NKWEZn+qZoc
	 ntdHyjkC3ylMEwJsl3K6CfUHlDcz2etS6X0YaiUMwe3xVhMszNc+rTNGuZNJBdn1jyCCy
	 7SZEDNf1SMaW0bmfMJICEztApX8cn9Yg4+Ic7W6+mO7920omw0lF7GLylITi6UFQwpCnm
	 Nb8OkjQtypD7mh8+evKbgI3Hk0ZGQ6tMR/IGqdenutKZWAD179nrN8qyZFQcYHevWzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013745;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k7QtvLqJxXhfeLre9j5wHqjvceqLACo7SnkrinWwVw0=;
	b=ohNybxW8VtfpzYcnD1b03W7YpbbkkPn9WDF2FOCK38BdvUCi2NGOXeKNmN34s/42VPYT
	 9VzAL62cqL83rUBdBQOqr8iZEJ3cnV9UlcGMTQnFlXaO0fam8w/DeAgmRXP5eNz3qQVqL
	 mjAMBPjTd8d4iw8F+0ZAeUlta1DAfyhG1zqRW5vVv0Uamn9eT/tZmOYy7uQQymfOUx87U
	 IpubIFosfu/wmZStx9DTFa7hwQlX+S2dgK9WiMpLRNGaahbhzs7uA6siVcvDow03iK6tY
	 nPzpzIg5CDd4sMW/mDI8oXOS88i+DOnavEmTEZZ9mnEyoIqxJPo1Brj/+MxmhQ3FImA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1mT8EgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD17606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1mT8EgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1561F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013745;
	bh=k7QtvLqJxXhfeLre9j5wHqjvceqLACo7SnkrinWwVw0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=X1mT8EgA0LmbheIndmEJzyqt9FDcPSdBDn/Iqi/aLbny2H3v8Je10IPC7Ls9O/OE8
	 CDT9wqua9lkLUNOOSBVu2vOT0j9WFZ7dDtZbOogm8D+dsr2nTCUkXJkTxyoKVRMuyP
	 0/3H+dTWqhS77/Jc4JnMtGZnGAB4U3Go446Y53KZP2l3ezuplU0IPBk23jnikHTfuW
	 0I/P2/H+9VmtmfppqJeEgl5vPPkFaz/p1O4WCeaaDQwhJ1BSttkpxRE8j9xe83Wx5s
	 Hl5PuUTlStV7h2336zzQxJDJVbqyEtHDk8CveIX4JB8WinZg70zdFKjKGAEhrziKJo
	 BvQEEpWZJXkTw==
Message-ID: <sashiko-outbox-221269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] landlock: Fix capability restriction
 documentation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118145217.2551053-7-mic@digikod.net>
References: <20261118145217.2551053-1-mic@digikod.net>
 <20261118145217.2551053-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:55:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Some documented claims about LANDLOCK_PERMISSION_CAPABILITY_USE do not
> hold for every capability check.  Remove them instead of listing their
> exceptions, and stop calling this permission a hook.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Acked-by: Serge Hallyn (AMD) <sergeh@kernel.org>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Fixes: 97c8386f1d74 ("landlock: Enforce capability restrictions")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118145217.2551=
053-1-mic@digikod.net?part=3D6

