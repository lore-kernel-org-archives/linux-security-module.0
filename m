Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292700;
	b=Xanx+xJVKEMjxOu43Vnf9O9hTSAWo2YROLN9G9aOdTo1s4oUtipNrX3Q9OvX4OrC5LwL
	 CSzdHixd0cv7LGbiNYs5ZZ1OzbrJ+nEhWQtvq7uUc3ESD4mGcL49UKQc4DjdFkIAdIoKo
	 vucCgLMgEEHihGqVK/neykNtHJtdaLN2gGIhWXgRA3JNBMuXJatNqY/bBYDaQYT2bRHQd
	 1NE3RxM2RMkd2s3d/Pexi4HmSTs8yMmnOmu2yZ9S5lvlzyjiZTbajUTOD6JK/IoXztzuc
	 q3kgd8tpMg8owGtXxztsJoax6WKJBGA+8Cyp7xCFJKRxHd5jbclb/8iCz8E069lV9Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EQL0pSt7d6hywKYhBcS2ooXsaH0oFWsdM0MVyh7A410=;
	b=b9HmD8tGk2FbJfihTBmcv6Xo6Ruu3FjcD2mTRzs1JMFIbcaKvDfp5HEQfGnCWklyJqvo
	 aA7Gtsu930Sw5A2VkilAlHRjg2dxd/af+W7MuBXk5KrWG2V764M7k7GE3TuiKomlyFWBe
	 aDYUVVmR8GTBl0aPrT88q5tS1p87qYvo1aaPA2zMzlZw9YU3sLTH6T01tsgWCNYJ/NfWy
	 1uG+g5egBtJuOYrhvGY3fjhaQS9yH/avbngxB4sL5kq+DcVCcQwcMIlB/HiAFeNerpPnP
	 vs0Q1iJ8tdqcJM/zOTATniK689S6Y8Qv6+sQjO0eycFJTbbeubLaRP9dlnIi4nWwsDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+yJmkuk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFF606A333
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C+yJmkuk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A95F1F01825
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292699;
	bh=EQL0pSt7d6hywKYhBcS2ooXsaH0oFWsdM0MVyh7A410=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=C+yJmkukF2fLAGmR1e+JRLazsBpZ9E5KmzdUkug+2rHe2OcumrTchKVDXpBoolPlw
	 KhxuPiqPXd5d8iAwbkWQje6twNzCrD9feDvfbmNb3m2kR7UXI5jDQXQjIOlWPXUsdW
	 q10545+JUObYeSkASzF9RSfm0X/HyntvDxb3x1eOgqsfMPbgDdCwOfDBb0uW3wW+Oi
	 OkUjavM5M5TQp8EOShmjvwZfjcvEUp9mi0g8YeytkCi/pmgGoMk5s7iIDUEV4G2367
	 b2m94N03Yzy7uQGM+uhGWMTyf/5M29j+nLYLhQuUlCjY5IU3dCur23WdfaUpnGH8xL
	 Sx/8QCqFohGJA==
Message-ID: <sashiko-outbox-189685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] ns: allocate the namespace id before the
 namespace_init hook
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-4-65591dbba7b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:51:39 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Currently the namespace id is allocated only after __ns_common_init()
> has called the namespace_init LSM hook. Most namespace types allocate it
> in ns_tree_add() right before the namespace is added to the namespace
> trees. So the namespace_init hook always sees an id of zero.
>=20
> The namespace id is the only identifier of a namespace that is never
> recycled. A bpf LSM wants to use it to track a namespace from
> namespace_init until namespace_free, e.g., by using it as the key into a
> map that associates data with the namespace. The inode number doesn't
> work for that as it is quickly recycled.
>=20
> So allocate the id in __ns_common_init() before calling the
> namespace_init hook. Every namespace then has its id by the time it is
> added to the namespace trees. The initial namespaces still get their
> fixed ids, either statically from NS_COMMON_INIT() or for init_net from
> [ ... ]
>   after:  @[set]: 200
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-work-secur=
ity-namespace_free-v2-0-65591dbba7b3@kernel.org?part=3D4

