Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761388;
	b=gFXWzEII4wh7/RgKjqCytsFloDrtVAEJMUF/JDaB/Y/jcpVZVG2lnvVMa6TDHIu/GIwV
	 ZI5tpPaW76LAZ6OAQqOc2A1h0TOW4P0YHCt0BxCIFowbNQ8vXeZdDN648HB0XpH2wc1aE
	 ibZ4LteA+BGoW8wTvjopOIigKaajG2qc52hue5S4e5oDeyKPAzMlBwI8LrrAKxrHGIwps
	 Xig+C8ULibrFdDUBTx5CQTT19C0xxf9Rk05xXrhKPMfbHuYztLrYqjcpme8+oHoqordVf
	 19ZHnlQoPjFQwXY5qCFnHwzllCyi54zZwBPFKE43V2X+SXDwwq7D6+dX3b9/kMlzEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ll2HMuwpVdrRwgOci7yY6mO55f1yYtA0PFX1Z6j7QeI=;
	b=VojnBVBD7aSUqaHWoje1//4pjzXaOOJryS6PfuY+8Hz4Y9G98a5LPfjVZFXLU968wIjX
	 uHQaCEWz8yeYcYUgNLm5XseRGgQ0gXNw57xm3HdnExtDbUgTSzTEItoKoCFDYnv2HFLlb
	 gjKpnmxtLjwDHqRHn/xNjN5gE1rYGDSsB8R3jljmK+4p72HfKDZskM2pSsPSZmW7rpwRV
	 RdBh32K91G0+Iqunxii5a6Gr40p05IwFE7VdklFdWSLy5+jImDQQbinUZk00DTiW1orx3
	 IEv7nmvtIG5G3EdWPyNN/PEl2z9aCT/Me44nXcLuL/zvkLWCoPooNyk3TwtrEMgQUXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDVlVRnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA1E606A329
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZDVlVRnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AB31F00A1A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 03:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761387;
	bh=ll2HMuwpVdrRwgOci7yY6mO55f1yYtA0PFX1Z6j7QeI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZDVlVRnLqRyxXPDwaKcohavYXKlBmxyL09OyAbysy9F2bwCWbcCsIJcNyfzuDeyW8
	 6Y+uF5JIFh0go/3/yzyDe+ztb6Rvv9uJkIva9ZrX0jjgeP1HCnHlyYlczR4kF2IsPM
	 2AJs6D1WT8/EWa8kd+Yy2I5GcvSlgV5LwqrTAhDet3PviI96NTqjwybpdTbmqVOFDa
	 18Jub+SLhK+cXwGi2EJ02mryKKZnVEKtNNwWQgtr/wvbs869DFxtt3gtOrEr9BV9nI
	 7nekY03di2pUy6yaCeDOilaHVlt0EWiJag5lT9S2bhRyVG3iVAvdSlOSuz48VPa1Yo
	 ADR8jyk+kJMvQ==
Message-ID: <sashiko-outbox-196571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/11] KEYS: trusted: TEE: Disable sysfs bind
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-8-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Suppress sysfs bind and unbind attributes on trusted_key_driver so that
> userspace cannot unbind the driver and unregister key_type_trusted while
> the trusted module remains loaded.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D7

