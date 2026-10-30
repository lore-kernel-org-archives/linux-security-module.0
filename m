Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331435;
	b=NXFQKr37RC3j4Is7aJamDTUCjOYXwpQ/9RgG9Qh53MP1GFdJgDBx52zGqD6KL+CHMvwf
	 /eLuJ+SU8DPjRZ8HPd98kJ9nAxT6ElFG7gS1I6mlnD9F2mainyVZBwLeXW2p6YOk1KlIq
	 8rmViplQpQqgx8LiBX2GDAWezTybrKX8WRj8CeZbl3XEGmrvSfO6ZC0V3LciImmyhF1hv
	 hSbXkne4Y/SKHEJ8RUnek9FoS8yYb2eSCTZO1dC49cJ5A8c92SN3oIdrhFhQXc4G/ppaL
	 QBomfPhGy9iDU9EgxLH7om6p9Zzdmc0VFdMGiuJpNxTVZb/sQO/y5esB7aXxWhL+Law==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q8k2zo140Hj3qal62Y9Ae6dRpxQ5c9Wk0xtmMkbR8eE=;
	b=MWYgIZnZFA/DesOLz4uN/LYnpzVqr0N+/LZmQ9PA+qazKIX6y0KiPdu66Jfle915bM3m
	 TgcwS5/8VjvFVyr1b8dL6Ac9mFvIQp8a7r/HxLKinKAz1yL1I6Gg6DLtEO3XOL3OxniUV
	 foxeI+QYZs9M4eh+2JKRkBsvRO9+J8xNdmowTvnYvGOnX8paPM/I2YDZf+V9FEF7OxmSN
	 yghpkXCrqmDY2+zj4CfJ/Jz4I6pnRMn7XC6Y6Qllp+3zZsIRW3hMn2qTd9rrsfVRSsEQ8
	 ESrHAknhP2U19E9hbX1ysfvMPCELyaBgy6v93j+qxGOTE0rA2oIEYz1tbc6cnPidZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="okQd/M5t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E91606A31A
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okQd/M5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59AE1F000C1
	for <linux-security-module@vger.kernel.org>; Fri, 30 Oct 2026 03:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793331434;
	bh=Q8k2zo140Hj3qal62Y9Ae6dRpxQ5c9Wk0xtmMkbR8eE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=okQd/M5tSxEKIIFfYlBKHtH2s2fLryLivzzRHK9WxLEhN7jr/gICrVmlkf73AJGQB
	 6gQgwRRKOX4iXVYa7HGx2aakODlhy7UVAHEcXFB9el2VuiotxS+GPJG9+YguxdMGFa
	 qphJM1FhwqNCTnfaUR5snEG1r/XgrXLkyzd2xTmd7zqCfosEblotMJz8Z51MDZKmi+
	 7TqtELLJCmzPEAGK37wzXIeiOXeraLft+0gQil5VrC1gdOCX3RMRLUVwT3YFPJ7/Qh
	 ULmPT2r5Psi4IqWIcRqmB6maY2BeOPXH7Z3RJUMPNLaoL4Wg6UpwRZKIjEwtbiUbEP
	 GUkug0FgMDxpg==
Message-ID: <sashiko-outbox-190226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cred: mark the copy in prepare_creds() as a data race
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261030033308.7-1-bbnpreetsingh@gmail.com>
References: <20261030033308.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 03:37:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> prepare_creds() copies the old cred while other tasks may be changing
> its refcount. Mark as data race.
>=20
> Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dee58b040032d8bed63d9
> Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D557fdc985d6ac3831e14
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030033308.7-1-=
bbnpreetsingh@gmail.com?part=3D1

