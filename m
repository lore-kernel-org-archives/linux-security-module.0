Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426909;
	b=HrzCglXn706hYN0yVmweA4lPdhTRx9Syndszpqz7gFK/lmadiBrfcq4lJbd9/mDMOm9F
	 0Z5uh4HvSX7MjOS49tL6HwRjXz0sJTqWVVOEfqo7aBN9dpIPuhl0J03dEVtVM+AQHfrd+
	 /aoMBLeM13cqIiQ7Smoi0h/U9cmC9kKc1qtk78BWZRTW8hMnBGaAqe7XXGHtXeUNt3kk5
	 Ovn//JcbEe/FZ3IefDMO6n45gwQ1NgzrAXn1Tcmmk56KiuPKT2NZe7jzZYMOMcj83jK/V
	 r0YyCHYbys2N6Tm7Z7w5qZWuPcpQGm+ZRhwk+iPSlTSb+WYxomrOXOLKZC/hDD2kE4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=C3puqby5QX20NM/88kRO10dbP7E3FOBwMKZnmXUp0e8=;
	b=2j26JrX6E83Zabaz5a9MSuax/JhYPijDkxYAxgDEDXcsXlumC2Qc0MW264aQK81BByIA
	 j2Fi3rNhR9vJGD5rHRiGAOARJmWdc9PiplQ/U/rGrT1HuWV9bZbOrmSXjF3z9V71cBgAL
	 7VgiCV1uG+XpgA96A46VKyBTeUbsFav2Qj/ELPHDchPCLyA73CkPcUzbghgr23N1eqlpm
	 ZqoqB4DIb9CUJ466CHcS2KkI/rF3HNwX3zeGYZ5nVyjVIoa/kqGDxanKiZQPgJCntoO9Q
	 sgOWmWc6KK8DacJ5XMWTHWiExfK8lZKj1n28MQmTqwfztkoE3Lk9mJVeX/dd6joWdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4KLrYF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93069606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4KLrYF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D5C1F000C5
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426909;
	bh=C3puqby5QX20NM/88kRO10dbP7E3FOBwMKZnmXUp0e8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=a4KLrYF9//xOMXH0xOL0S4+tH9YH+kanH9XhwSrjc/HrE0TKaJryoLRSwWTF9x7mz
	 ewf/h/Nzb9ds+ExDYkhg779vNh9X5JqsIN2D5DBwUbEslgXkP/xRJlQtFQM69+u9im
	 hh4qhDt7As0E7BuEKtrd+6+uwXkurn88pj/OGAT1UGAWNNkEmHhzl5IPCmfm5uGwDv
	 ZPo1upNbSdzGj+azdpgLV7R3YOu6TJr9FqGsuaJekH4jq/9rj7VeSs/tQV+E+FiTE8
	 QOOd3Qw4VxDl/ZS9BXLDtwPn/l1vDZuJ7idjBOZELEyDX9c68aF0k3mEbvCViBJ2U5
	 nCGUQXLvXixUQ==
Message-ID: <sashiko-outbox-177869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] KEYS: Reject @datalen values over INT_MAX
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-8-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:21:48 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Protect quota from overflowing by rejecting @datalen values that
> surpass over INT_MAX.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D7

