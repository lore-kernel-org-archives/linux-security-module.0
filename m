Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169880;
	b=ExJ6cEh+xZ8XJ/B7JURZeCL9WeQuivM0IbGTvNKgOg/Bh4TP3+B6+F55Mfax7qdhvrCe
	 2kYQ4dmwjrhiiEqbFkVX4oTvKGE9YR7Ie9/u4fXQJECGH894OCz/L9F1OdznCCrXFXKq3
	 DfaO+0UXO/k/5rtynwT+ET3eJ5gF2upkrlwV722mb0ChPW70Y8IeXZ5O7J/pPkhMvjW+M
	 LZy7fkDmpJLHKRTJMhQyqGlIQbPXcB+drUSOnIb5MVU0//KNDHHtelU1JLYMKx0KE4wc4
	 9wEpD8QjbGnDoG+ILLBxabWH+ZT6a3D8vU1s1cOELtBEO399eKfRxudcAePWRrqlCLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J8lKBm3S9SnlnQl9xmXOqMfCXLQkViO5kJLvwD2OjQ8=;
	b=V0gTtXPg7lf/2OYlXkzqhEULQiijjGah6uE1JKB1kFxRK4t8WzX5SOV/pdW3zPzqO0QR
	 guLO2s9rg3LHF9piIT+m21o6hTjSLF8JuCTLqt7OGxPPbEcBDCccUrLgtlFArRCFohL8/
	 PI2URncuk/d+nYrNn1vnCXeL3nZapjJQ87mGF5/NXcQGS/Myq93CrkLLscikbr5Tktp1D
	 zz/8dXOLFHpnriCEG8WKVodoS4Szexoi749I9cAp9aZesKeCWu87qGWcZ1JKyGfAWC8cS
	 oQpci0NMN5vYWwXiKG0BPX44FRFrX2ZOYSDeErWiryOPjRC/CkTqfLVAXEPu2Fb3D2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3beyBq5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD0606A33F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m3beyBq5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0B51F0089F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169879;
	bh=J8lKBm3S9SnlnQl9xmXOqMfCXLQkViO5kJLvwD2OjQ8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m3beyBq5Ip6o0cF9do4zC9CmvuE51HPjp0edhZHCBqy2fyqKcv8DXZ/k69NlmaKM5
	 2x2M6hAryVCJpgE34avxoqkCH0VX1IXDGJ877tuNALgl31t+JdutCLtTkD+lyX/Knp
	 gGKPfKhPOoTkQc3KGgv08kIVlVUr64mAB9xlAeXHvD6OdVGrGj5MFPpV60IB0cW0PG
	 Hw4Utqd7IJAQGtT8PVvYc3oX4rNgy8MG4CTyVfvGSjm+vN/eC1EyAy5UGqtsK/2UEU
	 DMHNNrPGGxCujXo7Kb1gRbqUpz3G7tTD1RCGNbVSl7J2xUu2PefQBZWsh5XG9ey6AO
	 611QWOEyvPDNA==
Message-ID: <sashiko-outbox-204017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] selftests/landlock: Test that layering does not
 break refer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-2-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-2-2b405fc1b3aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:31:18 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Regression test to exercise that layered Landlock domains do not
> accidentally deny the LANDLOCK_ACCESS_FS_REFER access right.  This
> used to be the case when layering a non-filesystem ruleset with a
> filesystem-enforcing ruleset.  In that case, REFER operations that
> would have been allowed for the individual rulesets would get denied
> when layering the same rulesets.
>=20
> Link: https://github.com/landlock-lsm/linux/issues/67
> Link: https://github.com/landlock-lsm/go-landlock/issues/66
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-landloc=
k-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com?part=3D2

