Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494313;
	b=I8X2fkcHkTLRSV8aNQP6i3MbSkM6COmzguD/IvdoiuVUHEBUFzL0+7Qhk1bZ6MczJ0hl
	 bPOrB1aUezDWqk1n2BN9Ye1dF3MtlS/EKgH/za9bgvg1Hph5MZkKdCrBgk8194U0amlUN
	 7my9JkmyvXGwcv7Af2MaIFjLcDxC0PS76Sw8Ru/83KYqJIlN1O9Z7XJs110/Fxw7P75Ac
	 ZBGZWDFkjZ1nnujp4iYbYVw4wIHHsqvPZrVvoRIjEQW8L0HxB5rQAfp6CH7hbjzB7/Kzq
	 x1REszdM4mvWjEudkfb0cqOG+gCxSDSF8lEYvNsoWFtcheBBg77tOT/uhOk/8NCaUJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494313;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bCzz74gnMFiV9R6me9vBq+7ol9JwoX2OD+ZdF9P650s=;
	b=ruU8gK968HJkplB4QABKfJSGwbNS1g/a830iJ7U+fHNZk9T/EzfHAA3zfYeo/8xQHk4b
	 jxcdVKfBM0ytlx3wiKwtWI2aJ9QmvN3zr8yHbC85Z7nHv+NnsqjX8V3mbH/GJQFe35aIf
	 +XF7i7Xro0xQAa6jGxsGepk5HRFp8Wnd4lIpZAfLKeIbs4RtMSNtf0oMKdKZKd8XiO4aa
	 /1i9um5OrAcOEsKBAgRW5Xtk543jNBtCEhzOYrb4gw5RGt8P+cYldgsE1PszpHH/PhR/T
	 a5HOokCPPck3roY32S5IgLz+h3BgwyuVKkR813V2Kh9B56ZT9mNUQsAphmbi06LrI5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nI9pvnQJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D260A3821
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nI9pvnQJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F351F00A0E
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494312;
	bh=bCzz74gnMFiV9R6me9vBq+7ol9JwoX2OD+ZdF9P650s=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nI9pvnQJMUaPOAGrBNinULO7Le3btoDVUsRBaibrykz5aXU/QDOnNPufwSwgmH7MB
	 VJNbdko1fJm0tBZD2ntYO0q+ciriU1h+eBB80hp59huqpVWA0xiPfNJCWoslH77eAm
	 WEfF86iAvT45601dmQhGZLU9+05V6h9FwbG+CrUIJU4cqGqpkH7PgtbSlXQjEH78Kg
	 yO+mO6nrEi4X0PVfiXpaxt+0NVZ4s47GbfqPSYobcolVhzU4dTvYRb7sxtOddPs4WL
	 gMs2xDQZl2QRnAsxe+b9MhFctCjJTa1qnkxyWJybHUcosGPyaiTql4PY19VMV3UR8g
	 XfyeHv9uhQEeQ==
Message-ID: <sashiko-outbox-211354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: Fix out-of-bounds read in ima_read_policy()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
References: <2e59cc97ad2e6fe5b9b5a5b5988668da29155703.camel@huaweicloud.com>
 <20261112143029.4159022-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:38:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> ima_read_policy() reads the policy file with kernel_read_file_from_path()
> and splits it into rules with strsep(). However, the buffer allocated by
> kernel_read_file_from_path() is exactly the size of the file and is not
> NUL-terminated. If the policy file does not end with a newline, strsep()
> scans past the end of the buffer while looking for the next separator. If
> the file size is a multiple of PAGE_SIZE, the scan reaches the vmalloc
> guard page and the kernel oopses.
>=20
> If the last byte of the policy is not a newline, parse a NUL-terminated
> copy of the buffer obtained with kmemdup_nul() instead, and account for
> the NUL terminator in the remaining size, since ima_parse_add_rule()
> counts it in the length of the last rule.
>=20
> As a side effect, a policy whose last rule is not followed by a newline
> is now loaded, instead of being rejected with -EINVAL due to the
> terminator being counted in the length of the last rule but not in the
> file size.
>=20
> Fixes: 7429b092811f ("ima: load policy using path")
> Reported-by: Fabrice Derepas <fabrice.derepas@canonical.com>
> Closes: https://lore.kernel.org/linux-integrity/20260814085443.1211989-1-=
fabrice.derepas@canonical.com/
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112143029.4159=
022-1-roberto.sassu@huaweicloud.com?part=3D1

