Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292430;
	b=j9COVaWQVEi/5kuqzwotdQe7d6EnMhBRQLeKa3Fg8DGNfq4hOk0k2pH2P/L68hVkCYr0
	 oAiONriikAvasnsnV5bgsKpnxKWe7O9eLkRQv3JRKmWMIgQK84TWTsBSEynoP600kblrx
	 tmtV2CwNN57CrGneFr8X2GJdV7kBwERpTgRL8+c/Q2aBo7IJNVl9JSjYK1jmnINIPRmgM
	 fTLaiq87ey0DdSVfv2MFigkSYx0+RHMHJjdfHrNVOn6lKv1UOD6hLi5HNg0KPDg0egL9Z
	 o7SMcAhLQW33k+A9w/sTtltYv+santf4E86ZdyZP+V8EeNGR9jFyEfsaL+4kjGMEdLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1SQ8QeaoGHczxwWjHxga0PrteZm62kWsKR+gmZKJ92Y=;
	b=3L7S7zbiSQd9MjxyovdeP34/0Hu91WNr9SBIN41A7Rdvu2640obwDxrSCL6QqPGj9DFe
	 aV9tbDVe9aFdqzb3meGoUq1qC+EofZiWKqLcKYkbdqUMvm8BIdL+1nzQfTUL2PTB2QwPo
	 /vy0JsR7hvTrt1c2fIehls5bW1ld5lEb50Gxy051wAQ17+JCPxxI53XUnve9v/G9da0wH
	 zSsVPS4N0czJAokE7tV6s4geGu3fAAjw9MXUPtlW5zaaL4JU1ylY/oJQHX78xfd/g9IhK
	 mGxiBvrUHI23g1eKZPvwSlBRU0SwY1EUmoagur1PyLDSllgNkQfGA21btkaoeEbrOHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gLLuJH1/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31925606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gLLuJH1/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D401F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292429;
	bh=1SQ8QeaoGHczxwWjHxga0PrteZm62kWsKR+gmZKJ92Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gLLuJH1/FCdvahCXy5yV48CA3utzyodrC/I/KpGl0ExDOise+5b3vy1rK7TdGCb2l
	 doFH3xvgVFpvWdt6vmLavq5HKhLukoueXNjlg338pTryQWlAEOrnxzQMLppR3g5211
	 A7u1pE8e14EfamzzwvPXGkTNPd9XyClkAuQ2BFPCLh6rLZoozt5TGlNd5hCo2RMgBz
	 +JIAnkyhxAQNCYCDnPlWo3an/UZIkisUrWhbKuWI9HBVJMXNa1W+m0qwUoCMQglsPP
	 SeI8Rrl9YMNriQK9dfpUhRq9aFiQU+ukl9AgCTYZGDvmEmFJvGiWv5pGoJ3fkNAMg7
	 BWr2xVU7jSXEw==
Message-ID: <sashiko-outbox-189675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] bpf: don't mark namespace_init and
 namespace_free arguments as trusted
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-2-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-2-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:47:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The bpf LSM marks the arguments of all hooks as trusted unless the hook
> is listed in untrusted_lsm_hooks. That list was added in commit
> c0c852dd1876 ("bpf: Do not mark certain LSM hook arguments as trusted")
> for hooks that are called on objects that are only partially set up or
> that are already on their way out. The namespace_init and namespace_free
> hooks are exactly that but they aren't listed.
>=20
> namespace_init is called from __ns_common_init() before the namespace
> has been set up. It isn't in the namespace trees yet and for all types
> but network namespaces even the owning user namespace isn't set yet. If
> any LSM rejects the namespace or if anything after ns_common_init()
> fails the namespace is freed right away without looking at its reference
> count.
>=20
> namespace_free is called from __ns_common_free() when the namespace is
> torn down or when its initialization failed.
>=20
> Currently there's no kfunc that takes a namespace. But once there is
> one, e.g., for namespace local storage, a program could take a reference
> to or create storage on a namespace that is about to be freed. So don't
> mark the arguments of these hooks as trusted. namespace_install is
> called with a reference to a fully set up namespace and stays trusted.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D2

