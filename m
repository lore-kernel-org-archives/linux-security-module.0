Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424245;
	b=aJsqfH2Gz8u05RooDOeMiZHRpdupL1uuS4q9kjSwnv7fEyuyoeHeGdkc+yzRb/lqDfGV
	 toA3SKPFKKrIL48c+U6ZCEUnb0f1qqcfcLo4chO/kvQ8E4cufbDR6U9qzkvy6/QNH06UV
	 nT4+tmNCEbacWMMe/0MSqf3yq3Lu8SaVy5UTTbdtVNUSFw6rAztwIBwpKLtG5AGgCcCzy
	 W/B+N6VB8Rpr4BFeqp9kRM1rmrWoUUj3Nyo6KoWpUM8PGCVeTY3XNfT3FOPp3+8Aqa5i1
	 w8ymVDz6Snjb+yuHl+b3IRmyVGI/zb+XMRdVBtCFfWUq/DziwofTQ+6JUvkEIuLKDHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m7zt9uCahnA0Ca4jsNcALiC9hikN/hMohXFcS8LL5/4=;
	b=3MxhDul7sghIXl7OeP7zBA26m3iuCx5i4p8FrWu6oTwB1RjnZ85uBl2kLxHnXP20nq0G
	 jY6o7KvpOYvU7kqJ2cMQC/yAjjli1EhjeSjMHDNUswUC/74XEm46dE/vir3+AeZJNBbjq
	 yPy2pEvfo4gclt+PJO5L5gdKnXM9QVoUwuWYTlfjHGzJ0GUDNsY8CVzr5mNCrYj7i+dnf
	 7GgPhN97HfMQpDd7VbEV5fleNGoPS9Hn3FNqS6E9bwzBuk7qVRUJ92Len9oNgN63K/f71
	 iNhChNIQQ15do7fov0OQ1NAlBHC1G40KEjHPMS2LHvbbiHbOnvxAt09CjjoPx26k/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9ehMNoK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD460820CB
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9ehMNoK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945271F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424244;
	bh=m7zt9uCahnA0Ca4jsNcALiC9hikN/hMohXFcS8LL5/4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k9ehMNoKZ4khmk/xrpMsrLSf7tOXHrIcCrjTfftrS1DnOckEWV3lxqTIKJXQU4Vaz
	 /HaEiYUSKLEs3DvjN0n+J7zoU+55OEc1yYhBSiFfkOWatTTSU6F0+l7mx4XiPVp0qB
	 xnYhUbJUHgelahbSb5pQG472renEzTbB4ZTdvQ1ZvPu81xCUJ/CEjmkgZqUhejnEJj
	 vOt3cpUIdB2P/iZtotWUmmMaXLbQ1PgEDutjhaxYXC9Y+rDTli01iMHRWcvdHMifip
	 HALdbahQRY04Z06hDBen2dR0I2hTdPO9YwEUC0yfCL3q/J7/ajs+DfCW8kiNi605Lq
	 Ay1K9+Ne+RkXQ==
Message-ID: <sashiko-outbox-177771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/8] KEYS: Change the type of key->quotalen to
 unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-2-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:37:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_alloc() and key_payload_reserve() set key->quotalen with values,
> which can be larger than USHRT_MAX.
>=20
> Change the type from unsigned short to unsigned int.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D1

