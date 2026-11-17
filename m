Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923744;
	b=vCo1BxqZHBKB/n7XSiJTlmqv0n3UgXKP1sepqc0PBRYJVOVSAttzYfockE8y/3Fjdlsy
	 XF+Mw4KTZHwS4z9S+gCMAKS8kIqkwgNu0y7fUShxxPFXKAwk3qVSe21U0Yhj33tZUxmIA
	 Rr2d/zQd1fOVUmfdQogC1dJdOsge1nyBjHvGx8uKRLfrf6d476gftFrdu2Bl0dsKb2F2K
	 lKkNwdK8XJl3eXW3TLlKzXUpeNBuF3ScHSbGH3OIVLbAaeIbBU575pSv8Qba+PB6HGp8i
	 YoTtTj8bSV0fxNjVNVBfce7MIy7miNHVWGwSyW4RK7AVCOuziTY1ccUcfSc1LLPyxMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923744;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=niVdYB4wbPRQ2ZdsM52+vL8om1VHOJ58KAgDPTb/zU4=;
	b=bjmnILceN8NIzkyuOjJwaLD/wikd3BJsIpIsE5ghaBpFqZVhUl72Mig/OxEx1ibnZAB2
	 3qyWQNP9IpbPB1QqRF1qmFBuCOeTLBLU9iB8D0CfqjgU5DeFJOwqfP+5q6mzlBrS6g+1W
	 Dw2G1zULDZzoAUs+KlUSWGcUzHnEj+Zy8EFGfVpRezgIQYhKAJZ8vIh67QsnoqTlfAwzh
	 yPF689Cz10nP7jS8tVwaO++eAfhUyUxYrb4E/uiyp3MLZFHreo4urD/Ft44JYC4EdqLXg
	 TcUt4+EAp4vQMAYtBVOTQhWuyINhzpb8K+aORWJ4m+VBn2B3pGb217pw+0iP3d6lR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIxiCHlS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264B606A32C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIxiCHlS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103C41F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923744;
	bh=niVdYB4wbPRQ2ZdsM52+vL8om1VHOJ58KAgDPTb/zU4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=MIxiCHlS9l6F3FbbAyM2/KqS1sxt1grxwXL3HG/vtN/edueBez3DF9M6ehfN8vgSz
	 3Y+dE37RUzPoWwkV+50rG23jv2dM14PYlCzleRoSlyDSmKgsnlL9EiOpk6UuEIHQds
	 YGnuh9wC/0BFCkI+UmYW818gSizi+2tcx4IMRbS1bNzuvCHcgZaHzD6epZsTingo6V
	 x15cDsDxHdqgfp3MT7Sd09y/sTmKdBSUjK94g+puulUS20eOBETS9SCHzk+xdP7crI
	 gYCocJIQn2eXB72FLEBpiIhVxOCapWz3YWUCG6f+T1mNZksEkY5330mfJ/0qrrhRnn
	 KA8wQg2z1PfAw==
Message-ID: <sashiko-outbox-218908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] apparmor: make the feature tables build without
 kernel headers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117135042.78238-3-maxime.belair@canonical.com>
References: <20261117135042.78238-1-maxime.belair@canonical.com>
 <20261117135042.78238-3-maxime.belair@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:55:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The feature tables are about to be built into a host program, and a
> host program cannot include kernel headers, see commit 541b57e31368
> ("selinux: do not include <linux/*.h> headers from host programs").
>=20
> Move AA_SFS_SIG_MASK next to the signal table, and give the tables
> copies of MAX_OOB_SUPPORTED and VFS_CAP_FLAGS_MASK, which apparmorfs.c
> checks against the originals with static_assert().
>=20
> The content of the features directory does not change.
>=20
> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117135042.7823=
8-1-maxime.belair@canonical.com?part=3D2

