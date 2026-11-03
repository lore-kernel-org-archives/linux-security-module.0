Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724201;
	b=WmpvNzHtV9Fomjbx8CZC3E1FNJFwCZ6C2HfUIrx8K+ClKb0ylSOSBR7MryzAooQXgKCz
	 tkLHml5KoIj+WUkFlwpA5+jsMEhadF/muWTS0V3vhudZHSyBxp3ci7vTTp2OoTf9c1qwf
	 fDf0te6H7w+1w+ZtuB9oxEr6wkfSkHw30D/k+hsAI4ruSUwMqWpVrctt3GDYbQuAfAjIr
	 AJ6UGXYhqB3A36hBWC0UWMlKfmcx/qbMCIYow4rFoJa4u+QVm38jGlW2IA4DCuv8HCUR2
	 kfiqhV3ioOcg9nLVcCCbMriot6yb8zK1kk2YO0cQHAij6uP6ZdLuMF/M4kOzmJir1Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NUfPXwqPlXWBn70B69Qq2J7pffH2J1LKRadfMNt1sbY=;
	b=bEzDy5MTbgzh8HqtM44C7qj8U6E5dvKuz54bwODIIavOexM/+VQ1mtwtWfF9I1A4SRxq
	 JW+PNqcdu/qqzEatG4lucplgjPFXUJ5/lNmPs6J7VHzINJ6zwYJnB5lecRonUQ3ruydQl
	 7WC//s+UHOQx/ibMIw4edFm0Ac00XGTNybYaP1Xpvg+jQKkHVkZfVs5j2ytYnhRyAtpXp
	 SUhA6jzrKG4EHbIqznl30c5S2eYxbk6tKF1LHXJt6fhpbonyr300T5VBSGxYtHPHzRRaJ
	 awFqXiIOjhUqbnlgp7+WJG17htrwjmhYxGutTE7iNbx2fMG8b7sg+wMnHR/UZHl3UAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNupgylY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281F606A33B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNupgylY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD11F000C1
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724201;
	bh=NUfPXwqPlXWBn70B69Qq2J7pffH2J1LKRadfMNt1sbY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hNupgylYLsvDOpMOREdTrXo3wUgcAi8gVFwwIj3GBX5smNRpL+2EfM/YD5RaqB9zb
	 mGHxBuhuxo2BaMA3Vh/me9DMYdI5zTcczNYMkzQ1u0TURPckSHTAVrsNj/3RmcSffh
	 J+NLWr63wD0R6oT7IIN/MkjVEgvXZ+C+lZrPV7MPrnZnVuYCPvDk9A00xTSt0Yyd6q
	 VRTQXF4WtIE0sSFf1SaNr1wvv+5GubqBk3dmSRrL5WeRXZFHUNnSoFhi97TKiu1Crv
	 7kRoU2QWGGXc1/bAm0ASID39Rap/tkK4hS9+ayHpG0Hx+kmdq8aHeoemfTgg8uGIK/
	 +nPBTeRg7QHdA==
Message-ID: <sashiko-outbox-195742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests/landlock: fix the regex_escape() error check
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261103163917.641130-1-sashal@kernel.org>
References: <20261103163917.641130-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:43:20 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> regex_escape() returns (char *)-ENOMEM when the buffer is too small, but
> matches_log_fs_extra() checks the returned pointer with "< 0", which is
> never true, and goes on with a bogus cursor. On 32-bit architectures gcc
> also warns about the cast of the pointer in the error return:
>=20
>   fs_test.c:7474:24: warning: cast from pointer to integer of different s=
ize [-Wpointer-to-int-cast]
>=20
> Compare against (char *)-ENOMEM instead.
>=20
> The size left after the escaped path also subtracts the prefix a second
> time, which can make a long path fail with -E2BIG. Compute it from the
> cursor instead.
>=20
> Fixes: 316d06b01130 ("selftests/landlock: Add audit tests for filesystem")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163917.6411=
30-1-sashal@kernel.org?part=3D1

