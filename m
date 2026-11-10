Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342644;
	b=SV8WoxVG3Hh++hySEc4DSwqXVU30CpyDMWXhYD+H3tNzNBXdBRyE6vkdqOQoTN6Ow258
	 t4BJLV2hihjSeZBMqBiuKPGR0DSMTXaZ27rg3z9bJnEEDyQwUseNeiXlc2sDYF9qN+F/k
	 YDdRp5fGAsAJ6D9DUeLz7Msw5oXc3wKG54wayigW5qC1VPglwsTjovZFvpko7K3frKcc7
	 E2qJMGI0Hta+v5ZGUAeAdtNEAms4zMt/N+hxpUb99S0HwD7qG3kndtwdfGs5COjDHmLIg
	 cOBWBurmeRWKFgqUCxCqQK38UtSoQyjHOdXVgep3O9efw/GDSSnLkmgW8eE9O5GtbEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uIYZja/8S0wBn+IHQFpIjimM4jUXavrQVCatpjHPzG0=;
	b=mhdKSpKGasW7GKwDn+MLqe6LjSYOxCEW7bEdrVUeLXmEMT52ozf8Q7QFfs01u0pVdLTk
	 Ys4v4WHOwj9eA6dwReL+NDchjbG2yIP+WYF6HrUiNQ4gmWlO+Mz69n+4y0tzg947CNUa4
	 +pu622MVwnWwuouSTNK+/d/LGRskdI4X16CWZjYPlDN66iQsXcE/lQ93nGAkr0UKjkGGv
	 dWNhhLSwcsKES7p/kR6sh9yxKf7DjGY8Zyk7TPM37R2DgCAv9ZwqknWC2GHe5bADniB3i
	 ysPeUJN83/ixzuB1YUGny6BVRr4VZeej7TkekxpgTYUimvsAHQ/N6J0dOyDCBNTWmxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nY+/XHpC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6254606A89E
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY+/XHpC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E31F1F008A1
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342643;
	bh=uIYZja/8S0wBn+IHQFpIjimM4jUXavrQVCatpjHPzG0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nY+/XHpCqZA1KhaldZaTUoq4SuWLJbnzTq8A0CQ6mxPU/ZLpWoQ85m86ep5rCStXq
	 uNTL9RqTrOIo+cKDyNDUKDcaUY5xMCpe76pnOBGpzxCkaHhWJLS03H3w6sxKdXgAJH
	 T2Z7l/6P8Eu69wcHCZYBqF4+pVMAVXTzLjRQkueXiRDDLXmEIWJL4bg6jikKAIV8i/
	 KOp+cuX3h3Qrdew3M748PINxfrNmFzbXzr3Du+ZsoCcWpQY/9lE29qKtNYHT9/N79W
	 g1nZRvzH5rBbovuuUuaUv9RVy2VrBZb4Bdrioc31rsNwbQ+g+UrKykWM5b2FWU+I7d
	 f7j85LkbKG2pQ==
Message-ID: <sashiko-outbox-207710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 2/6] security: kap: add the LSM ID and internal
 headers
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <20261110202246.274-3-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
 <20261110202246.274-3-harisudhan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 20:30:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Reserve an LSM ID for KAP and add the declarations its files share.
>=20
> The ID is the next free value in the target tree. It is provisional
> and is for the LSM maintainers to confirm.
>=20
> Assisted-by: Claude
> Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
> Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
> Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110202246.274-=
1-harisudhan@armoriq.io?part=3D2

