Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456268;
	b=OlqwBxhefbbXURYxWhXvumfXZAbnxp1m50DotKGxLsmb2QFOvA1nuZVwQsg+d836dtiD
	 ioXFKZXZlM4TTZ4M42mCh5CeUNRTht8uEBfYaPBbBZEfoKATA/cVORQtCr79dmNE6D/CD
	 c+zTPL6LgA9ImI9R9y2Kp9ClP3tIPvAy3J8E/gC6kRrL4QQ/2QlmrsAK5Bdh8M6utF0XU
	 6ycpJ4dmh7YLhiNYfHHq9vIbv+f5XCo1UbnquuBXSybg1LQihpMe/U1Np9SJJvEq5MLdl
	 AILR31RSU5NOxMejB1vOxQkQXihBYDs4urJyeZp0r6KuDC/9qoW5fQpHCmCdZ09FZvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456268;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IDRk3pNd3QcfRhtdoqd7jduTLRWYJt/XVi846exZcUM=;
	b=h6rstMF/9VtCc33uzymG9NeXifZ2hZWRaxLhi81ZCCHa+GmHGcDK2x590wEMTMZT1zQZ
	 corb1k0DTO/TQml4lN9BYGivaSPxj6f6Fgbedbb8ZdbmDGZYy7SgJT6899KuZQbTZvTVe
	 gHfMpnrWdU9PaaBg25RxcBnuPN+TxXLIacPPmtwd+7GYSRjEXAOJjKJmwrlIon6tSH2TV
	 BCUe970V86h214Xcd/S32ePw2mKr0hnvk4MbCH/lqeQn127HmsFceUKo8RcbB2VweGRvg
	 q9HHpWrQcEQPykp8CIbVz3ZNukAsmYmkyA8oo+qVa8pKIA6uhi2Rtd4MXYhDOLg4JVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkaNOK9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E5606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkaNOK9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948261F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456267;
	bh=IDRk3pNd3QcfRhtdoqd7jduTLRWYJt/XVi846exZcUM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZkaNOK9w1g4IRW03lfH4ipD00kndQpH8dR01UifzsbX4q5BXXv/q3LcVY6TBqo3hB
	 m0sWm9QQ2PL94jcnk9D5LHINQObkFN1xTxOhftQYNWi9rpDhf1tm6N1b6kTmd40P8j
	 g2amaQMUu4zNZ3Qt2jj79Eg5f8jrDJiU80YvaWjabq2pp4m8UWlo/Da6KglLH5jVuo
	 ArhAciJwa13/Nr9CMPEn9BIm1umZ9RzpIPe9NgP8/Nmgpbyhlf7VcFI7i5YQpWAlNR
	 lD3NUFN/gqiZUvBJ8BrH2xkbChPYEZOO6szZqlmO4Y2PKI07IaBDftt8X/iWPsTdDc
	 pJdapK+66eicw==
Message-ID: <sashiko-outbox-178384@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: mediate AF_UNSPEC socket disconnects
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261020001256.888314-1-shawnq1@163.com>
References: <20261020001256.888314-1-shawnq1@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 00:31:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Hello,
>=20
> aa_inet_connect_perm() returns success immediately for AF_UNSPEC before c=
hecking the active AppArmor profile.  AF_UNSPEC is the socket disconnect op=
eration for TCP and UDP.  A process confined by a profile containing deny n=
etwork can therefore disconnect inherited sockets even though ordinary sock=
et creation and connect calls are denied.
>=20
> HEAD commit:    fe2ec83746e501645709761605c2464a44fd2929
> git tree:       upstream Linux checkout, local branch master
> source version: Linux 7.3.0-rc4-70-gfe2ec83746e50
> compiler:       gcc 11.4.0, GNU ld 2.38 (build details in reproduction no=
tes)
>=20
> console output:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf4=
3c/raw/fab5c58d6f184f5fab88a3a31a80c2b919efecf0/console-output.txt
> reproduction kernel config:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf4=
3c/raw/b9192c97c92fdd3b59089704bad6fbd0a33ccf06/kernel-config.txt
> reproducer:
> https://gist.githubusercontent.com/shaos26/73b057c77b9ea22d5e6813c259dbf4=
3c/raw/92c7dd098a227276fe3daeea45996e2848e66439/poc.c
> [ ... ]
> Impact and prerequisites:
> A confined process that inherits a TCP/UDP socket can bypass the profile'=
s network mediation for disconnect and disrupt that socket.  The finding do=
es not permit socket creation, bind, or arbitrary peer connections; no priv=
ilege escalation is demonstrated.
>=20
> Run the normal connect permission check for the AF_UNSPEC disconnect case:
>=20

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020001256.8883=
14-1-shawnq1@163.com?part=3D1

