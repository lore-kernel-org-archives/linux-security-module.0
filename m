Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446302;
	b=kYWnSbO8789VZnXnjjXQx83KU0G+WfiFFjOfYGNv6XIxD9SdC74ndBaN3Q4nUYoNROol
	 H5t3y/SvjrF0rgSZA2O0SZ6Yh7UtU/X+cASwHQIAyJjCEvK4DFD3NvAYQ8nzmshY5V8x5
	 xz24ic8I3TJOJoJbVY2DcJyqEjFfxpwoROe5r8vHuKlZoDxsuWUvaVdA483P6VoAiVxUs
	 /oA87k25yqee/nY67zJ71M9Ipe3GGrR5xONXP5U8SFzNd6WizxXJSwC8/XqzEJ1gZqG+D
	 93fq6TT1ZdSgRdA2oxYjVolyKagHCmM2SM4b+m7Hv1O/HBrGIAR9t5Yil1BIkl69mhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wDtqCRJ3x76vS3GfzjB1N8ereTh/VQkEVagSKppHoDQ=;
	b=dy8pU93aVV8IrHzj1dIIF7h5SeZm02elMHIFkDC7L/KCovxGYuzDq0skzBuaeh2UVSU8
	 +H0XBs2kKCxyP/6BlLGj8V1l+s0AHCnrUNmH38SuSji76YCtjUJPunYFVxyw9/5xCW2ba
	 yRrBucNTJ1TSkn0/7lhn/oMXgfRrZo7Xvks2R+VRwpSUAu3E6w5F81otr7b0vo5P6CwUQ
	 JtajMbDvuEllJgYb5XkA/cS/aho/mQ++wn1x205Awacg6KsAshOLjrbqO8NNdV2FWjucL
	 mCceiO/qKMu5FJi0Ae12miwYsJGftMgLXnM+6/mOngd0quMMzKqIO7q467f7jkdD1AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h+fR3sY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63D4606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+fR3sY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D221F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446301;
	bh=wDtqCRJ3x76vS3GfzjB1N8ereTh/VQkEVagSKppHoDQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=h+fR3sY/utO3EITbv16yZMYTo8XscyElwpj2SiLNdM8bJZwNT5TMajNP0R/FqeX3u
	 zHZxIuHEePWQeAJWkj6d0kUf1zfzulIRhe0UeP+gfaICggqPqyazG/YlTf479aFSd0
	 Dl1PMl0rCm4wwMO3LOVvmu8wpMg3yRfwVUN+TWD7jipKqR+HGdYWJR9VxTEzCHMXiQ
	 lQJBVlS0gVvyz+B+KY6VNl1UuVk1fce1Opxneh+mze6jSlIOc0d9bBlgDNRSoJSIks
	 7vzVlZ5NTI8O/mPNiqyO/gC5WEc/RkMGVunvOwUt5vaAC9Ai4jknwdX4JraJ4nYeUv
	 AIZtDkQFcVgmA==
Message-ID: <sashiko-outbox-178274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/4] Documentation: ipe: document the IPE keyring
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-3-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-3-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:45:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> Document the .ipe policy-verification keyring and its additive use
> after the existing trust sources.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-b4-ipe-key=
ring-rfc-v1-0-156f0b93e843@nvidia.com?part=3D3

