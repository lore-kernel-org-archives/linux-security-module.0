Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312306;
	b=jkqgLTXXYoY9oVtaNpxKK9VHKOHSt/ew8y39BjkD+KwKsZEHOoFWtsikBEwh2MuMYaaq
	 Nypyh0LfxcV74nzoyo/zUHTjzx+RO6CvPplrxF98xI4o7ANYoqU9H5qdA9EwdXO8U/9B/
	 UVxsmdzSmX23t9IZH5CttzYZQBWCrQVneB2EWyIKXBfDVNmGGCI8gS2UO83c7VvotOQEz
	 tKq3q093BiEt0cXbIr9Fzx7jfZPdxL+ffSa+RatbHyZ315A6wqSfRKp5u9tzKGGD+itLd
	 /OILm7ZNEN/m/I9yX92vgsPJHUqd4A9XalzA/Xfs5TZ9h3uyZKk5WPjlzs2iC2ZgPSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v5YPM49aNTe7a9LI7foYC+81vU3NuvTOzVPNOmQHTFM=;
	b=NjF6qAD4YkYePlQcaFBuEHY1vPj+f9vAFPNZzX/GSCiPhfI9dYWx/YtiM4odfU4OtElW
	 oQ4o2f1WzbfjjJ+6zMyWt7qJqdcZkdxF6KJJ21Ebh9IUcXYbaW6w9f/I0axvFb0sVL+d2
	 M9LB7aOcY0UHQr7J9RgwvWtNhZut2OnScgCGPKXGGoRXWrPGGOaXK1bAoWdZ3Te1dZtde
	 hs6pN8J/VZVMKJlxb2UZEkNMfXOLg2S1uF4jzAYesh0I8vYY+mAB9A/G86o5IY/TaAcop
	 SBFnPU9BPi3xHrY6C8NRDyZv5MKpNp/lhfFbdxc0yA7XO9lU4gIkEl0O0zxJVNHqzkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdoNRlAZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22A606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdoNRlAZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFF31F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312305;
	bh=v5YPM49aNTe7a9LI7foYC+81vU3NuvTOzVPNOmQHTFM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XdoNRlAZA2ZFil1sOlGOIGFuiQey3krmq/h68uH9RcrwRL7hAn/OSCq3dtnTMtueV
	 7lCNqok+S2FPVQt63OigmLYz5n+A7bWkT4UfrfBBz8jriYRvDoMQG8B+MB1cVmnbDn
	 hXDpzNPa2BRpijNWTdDzXkEon0XcmS40hAdLNOquJ868abHkoLcwBwbPJp8tO+a79Z
	 IZKb60qI2k55ENE9zdYU+F5lruXJao/IHeB/5C+xF8MWV2c3CKYy06TfhtTvT06FG3
	 8WAi+NAZEP3de/iuTzP4vHDDnI9kg2BtyU7wWx+tehoQk+D2qODFDlD0YInxI1GU6v
	 GehfSQY9d380w==
Message-ID: <sashiko-outbox-190062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] net: introduce CLONE_NEWNET_LOOPBACK to auto-enable
 loopback
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-2-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-2-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> New network namespaces start with the loopback interface DOWN by
> default, requiring CAP_NET_ADMIN over the owning user namespace to
> bring it up.
>=20
> To block external network access while preserving the localhost
> networking that many applications expect, sandboxes (such as bwrap,
> nsjail and minijail) commonly create an isolated network namespace
> with only the loopback interface enabled.
>=20
> However, requiring a sandbox to hold CAP_NET_ADMIN in a new user
> namespace solely to bring loopback up conflicts with reducing the
> CAP_NET_ADMIN attack surface.
>=20
> Today, an unprivileged sandbox or sandbox manager must start with
> CAP_NET_ADMIN in its user namespace to be able to bring up loopback,
> [ ... ]
> semantics while allowing unprivileged sandboxes to create an isolated
> network namespace with functional localhost networking without ever
> holding CAP_NET_ADMIN.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D1

