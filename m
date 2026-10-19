Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792434244;
	b=xeV47Gx1S/CLgaPfYx7+h5uMjOsgFzSMb6xIlusEx3sPph/yCpgQaKgnwEVO9RjHbYxx
	 tq26lhNPDxD9xivSzFXTUGVU65WvX7BHQzvnVCenOLDcpzwFF1HNGhu3QKCja8LPcBYIg
	 QfbF4xAHLjdClYZY6JaCEgYWXwZAuuar3dyV2867JiGMLcVnNLirastquS/7Cp17G3cYz
	 mrP4TpoFo4Kw81W1Iob5jcDgBThLmkEtRH7dUWL234LvOrl1Rbv3kLUC1HzmV02zU/tsd
	 4ms0VfuNu/2XVDsBgNbjnGNe3PgWKRGTR/51BuhruIErSi+nx7o19d1rHGHw5zitj9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792434244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7rWwbxGI5xslOZFw/SgYbanVgeyPaBZVrBQDa/7zcCA=;
	b=bA2EeN4AMzwuHq0qEpH5JV8cxDh7KAJTBhxkksxJFDptUd8N47qdEAYcG01qU/ApUaT1
	 pK2jeaiPAvdsFrUY//ukMG3qhlVgZ6FZZI5yD6bHQlxxhCNU3bQ8vxxAAd4sGWhmYmGPH
	 0/7aPhpGotldkt+/JAMnlgGEaEWuk2OAZHJhZaXcOm7171PJXeT2TwAq9sUKa6GgCfuFK
	 p9/j6LD5vf32pJUnxvM/jE5c1epWVy0zn+DA1dvJ09fKlNT+FxAglW0Hdg1vPFRQiFgy/
	 v4geAI1WpI6IWsLHf90ai0WK1JT7qk/V2NMMyyVFpMFegjCVWnnbW1sxMPSdZRpQkMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6ZjjGnt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EF606A31B
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6ZjjGnt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3081F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792434243;
	bh=7rWwbxGI5xslOZFw/SgYbanVgeyPaBZVrBQDa/7zcCA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=d6ZjjGntxq+Qx2K+k2tL0X+aI9zsG4qe50HWJ5j5JQdg2PZLu6c+GfoXM6e8uuQkB
	 5bDel85/kT9kHpgMrQbm+zL+yZ2G9xnN6ADACWiYGgwIdKaBTEyIDFhqZk+vgd+t2U
	 mx0c23kvFap9m+RIWXKWpfgRL4pX2ba+hoxMN7vfyewtG0YN0MRMiuIsnFFTg8q+A3
	 mt2U78Oi8zJcUe4HE+9+YPK6Uc1RWvnqysPGE1KIt8SA+ci940jdtzKFO3XvV2+59R
	 DWEkhwDQLOhtEpNsAHJCjl1CY7AEzcOZBGMHYbjraSGFnM+KMyEaAJ4NJJOZSysaJs
	 G57xE83jZ5ZFQ==
Message-ID: <sashiko-outbox-178073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019181732.449591-6-jarkko@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 18:24:03 +0000
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
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019181732.4495=
91-1-jarkko@kernel.org?part=3D5

