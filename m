Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292642;
	b=2k//xO+BrfUqHd2wf2vfVmrhMYnT8qSCP3dQON9oY+bLdGUovDjNKlCGjKWDhz4t9hsL
	 lbWpb8EbwtPyj1wsxQjJvsWXnVCd8HA/rAowb3gKIuH6sarho87jKyt/LINzfZ35D3gc4
	 to9slhQ1JVz9xASMjkkE9rk1O3aIZTLjD9sxafO+9x6fuxe8tofEKfpJc82YaJqnGpaxU
	 9V/DEwlxOuT9QGfAuvkvtf3n20WH+jpxXfUyeanutK8Fl7Tf7nKpXaeODzfaOoC7dJHMu
	 iZme9CisedtHfrjdm+vN03GhgFpCZz3z/ZnUR9/d1v0t7IYilyfusUzaEV/6MrQVIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292642;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=45IOUqTFpPdJzBDUtc2Dyurp6gGtwk6Ani3HgHpt3ek=;
	b=SOLUbylONWP6HvY7ypPC0qAQEXuUSGte+qxBbWfWh8Kk4nC0mha6qffQ049Kl9ZXoXwa
	 b7cg9v5tTyBib/G81eUxcEw+5WPAgGVWaweIXMYj11rFtsQVzfNMVDPDdew0V2gNSC4yF
	 1+QHsjwTVoQvGjUMWPPa6cDXz/9KUsWDI2QoAAHn7CqZBAolLIND8IEsx277wp1HinK4N
	 GlQIShhVORZR3U0XKpqi6+i0J/urt+IW48MX7/Ea0e8WDFb8p5Osi6xEbxEKIyZOort4Y
	 Wv8cE/Vq4VNiczIM7PZUT0GuybLWM/+y2Kbk+1qmHyRfdc/aPBuqQXhduo4z20NRRXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APTnrB0C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CB606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APTnrB0C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429D71F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292641;
	bh=45IOUqTFpPdJzBDUtc2Dyurp6gGtwk6Ani3HgHpt3ek=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=APTnrB0CsOgEsDY4sacQFqLmlhNW+0V8V68tHx4TCz/4NFmfOeCwOTCTACRBQwSJ9
	 VUFA4tS4wbhuIXHZs5cgqCIub/uLZJ5TrcgnIriYMBk7BrjjRZ8DOunACM7cbg2ZrH
	 +cbexzx6MZOqO3R/+zepjvKsKtXQl//zl0FDcyy3ScJ8TsBJpNOzwIj+0L+b2dGPwL
	 AdXzTEjOvWwnDld0gAAhW6vb1OGwtT5p7fJpfTF3iueVz+WTOZku7sXUiJg8VwybV8
	 9e4MWzJ0q/hVEBuJ/BOehNQE0OfK3fGdKWO4W3CfjaTnondzWKsWM6XPpDf65SQEz/
	 WdD06CVEJanlw==
Message-ID: <sashiko-outbox-189683@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] lsm: fix the security_namespace_init()
 kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:50:39 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The kernel-doc claims that the owning user namespace is available via
> ns->ops->owner(ns). But security_namespace_init() is called from
> __ns_common_init() before the namespace has been set up. Apart from
> network namespaces the owning user namespace isn't set at that point so
> ->owner() returns NULL. And for init_net with CONFIG_NET_NS=3Dn ns->ops
> itself is NULL.
>=20
> What a namespace_init hook can rely on is the namespace type and, now
> that it is allocated before the hook is called, the namespace id. So
> document that instead.
>=20
> No functional changes.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D6

