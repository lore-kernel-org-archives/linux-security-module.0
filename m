Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312310;
	b=vV+UuIwOqAxsrN/8fR77/rdPeEjODM9TP73v0wOsplISlPaXac+MHebZLl4LqdLrcYCR
	 wQ3gDyXSoYjiWvUkWwEjBv3GruPljcHo+FlxTH8Tjq61FHs1gF3JsIWMhlNoWOJTOTx5D
	 o2O6Rpov3ncB4Xzyzm85BKXNj6isfc9LRH9TuFsdmVgj05sIk9uK5yySv4cJIQVQS1Lnb
	 jK5cEdKQtSbQfdkgl9Ozg5rW+Hc7SM7dSoFeok6POwuJ8drIgwBk/NpWp9YJyPs1bcun2
	 8ujDXIvtxFH3+TDVt9Va8PjNWLgb2nmJ+y1ItYXdiYq34tQhK7ezpvEUCJzEHZTlyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312310;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y8A7L3A/dXdXD6FHbpcyiJBiW/iIF5WyT1pqyR5HpDc=;
	b=nrHtRTr0rSmmKWh2Mz3/r1ZVe+zWgZeTXzrrugqy8/YsDfWVxzrf9IzIlhARY5giRECU
	 zfbuUziRvY0F+5KcSc43rpd/tfLO3ichjHtbf+CiJweG5a8Z5Rx/WnyftKChXNnZsgZtx
	 FyGbaXUyBHLxZ8GFPbCBPG82YfqpelLRs+N37k8VZSVAA2ekb693PNPPd54L+hUNRapCQ
	 zgqolocYS9G3gwdarpIQ/QFU+FIU4BeTUr3U2fLrAUdHbCXM9e6rdz87iwUZxGj98nrut
	 tEhReuHBeTGXe4XXoimV3HC3vvYfH7HjNoeoUHMOjnLY+8MjYoK4ebfmSdq6uOffUqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L24NTga7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFA606A31D
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L24NTga7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC4E1F01824
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 22:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793312310;
	bh=y8A7L3A/dXdXD6FHbpcyiJBiW/iIF5WyT1pqyR5HpDc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=L24NTga7tA/9Z7ip5NBq7c1/1CMKkear3nFkWkrU5QhQjsyBxEo2Ru9o6P5egEPSq
	 Qe7YAj4zHeUVZIrekVWuismiBFDWG/qGAIUzmjq0VWQNDirZUcniyLnt9A347dDC/2
	 0at3iLwg3hynXe3uAN1YkRwf0CZDlrsFovt+TBsmzSJjarvhfaT5hzZboRK+pt6cli
	 FFnbdpCzIvdI/rbz+yHgw666s4Wt7+5I6gQmKFmThpoBB0cl9XHMkZP7j10ufrtTs8
	 0HbhLwXSj2f5YPWf7kb+mf2NfADdohvBWxwXGayOV9ecnDN5TdWMg2TYhKo545D9A8
	 ghg3cvtqOsSkQ==
Message-ID: <sashiko-outbox-190068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] selftests/capabilities: add clone3() tests for
 CLONE_NEWUSER_BSET
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028221705.3915340-8-halg@google.com>
References: <20261028221705.3915340-1-halg@google.com>
 <20261028221705.3915340-8-halg@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 22:18:29 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add tests to userns_bounding_set_test to verify per-namespace
> capability bounding via CLONE_NEWUSER_BSET.
>=20
> Signed-off-by: Hallgrimur H. Gunnarsson <halg@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028221705.3915=
340-1-halg@google.com?part=3D7

