Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692524;
	b=xnsXVi0f3EVG6Y6XfEmc968AiZVkyIyJcSfwFHWYMeDgLuS5eFsSsfUy3wVw5satf4NY
	 kn9vfb3Nn0Va8rUW+uCLVmIYhXqoVr5LLT/RJ3Gqz9/XRjFa4JwMIUrb+XNwedoZ4C/sj
	 0zX+GqlgresEu7A0os+vXu/8qrSpCLPbZRRhT9PrvbhsNuF8j3VQzdmNUCbfmf2CJt/AV
	 LDLL+C3jZKBdYbbgT88xcmSLytScYddnEkr1FOLZdmd4vFFXUGRhDo/SlHVUFetUMv1Xo
	 QKVFPUX8QcPcOdc9CknBnTCq/TCi3Zsbr9G6vStkk/bv4LPzT3223Eqlg32YeItn3Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bKHWpRlU91D8l+aYd0R+jRxr5tU1AW++y2dyheiIWgg=;
	b=i90HzocLkbFx+DFmohi2BIIaxM+kqb6xGUUFOVCiMd4T8kF0TG1JRiFhPrH1pr5Fv2aW
	 Ta4tlhWpbhlV2KZcjOWv5zJXSMV4xsul5M0mG5vvvkwnDYG+k3zjaSEtB68P4gnm1DWSH
	 tE2HQ1RymASymzJ63dt8+qmyr9l4H2t3Pdf80UNZHDk7Karv7XxQmGUY5L/9vgDPwyTE7
	 b6fGRiKy9SGRqgSsKq97N2tRRy3M6XAbw2fl93UWE7TKlFqg1dQvkVXRzAXz1nGZXmZf7
	 88ZDeoipgUr63e+PI3kHgqbfwmVESJrWmA/aEMTh31r2qk4ShbxD2qRDLy3mN9DogYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReUDPEiQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25360606A324
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ReUDPEiQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A736B1F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692523;
	bh=bKHWpRlU91D8l+aYd0R+jRxr5tU1AW++y2dyheiIWgg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ReUDPEiQH+y9JZPuDCtzaeZgy+GGtuCevohIAuZy3eEUMuOJm09+wOEglHMPQ81rU
	 5B1A1O1zYgp1yrK6bTd1OX00F3cbxtJjnDxtpvEAZjZAoqroGH23QeFX3NST+DWe8U
	 9EJ4xNjMSkAcqukMKNQxLHF971DYkhdR4bO7WSKAsiBkBJRV0GX3qdo5+4OhvvikG/
	 xMbvFXucdg7UBL8/uF9Uo1g3ZeTUEq/dBRNPeBCfSFPwiRB/1xNjXFjZkb2A5ptfZ4
	 Y3eaRUo1+BDIR5ZAGOtTUdv2V9ZJxkDHO9NY9L5cE3GDDsQQKozFQg5zhPuk/8GCo7
	 wILOgLNgtmpsg==
Message-ID: <sashiko-outbox-194775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 6/9] lockdown: drop an unused include and simplify
 secfs init
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103082421.3033195-7-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-7-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 07:55:23 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> linux/export.h is not needed since the file has no EXPORT_SYMBOL() usage.
> Also return the result of securityfs_create_file() directly instead of
> storing it in a temporary dentry.
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D6

