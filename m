Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315938;
	b=2B2JML0n+kI31u+8kH7UOsGYAU7sw9VhZvv4Aok0MDFzmBLypu4tfP9aiU3geG/HBJtC
	 K6CGrlrBkFHIE/AvhEdhBpKFCht3zfqsK5Jy9c0UqJfTwf6yoILwm8nVavhu2NY06R/ZF
	 iR/r9DJLnA2LM1QKHJ/246j9wN0Bo9uVqSVz2l+V9m9SmSvZoNau6CSK4/+H2nTYAjeWJ
	 AUjKY2B7eIY6ytQpGG8qVhBw2rrW3G0qbWBzOrfWwY3SpgvFWt0Ajb0GzN223XLd+xXne
	 E5JCkWi+KMOePuPENT89LJBv4hgzzKqlxTbbMM0PXAsA4BngI7rnD9K46xcidefMISg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OpnFl0VJa0IOjz6ClmCo0IAryffEkF3pMAKxwq8/Kfo=;
	b=q2Gpk4F7p0YCB3eTJtHXkHnynFQC1X0Hd/K+ep1tyh4rx9ThGSMBpA+iFWXGP5H2Tzwg
	 1a2wsGa3PklO5No1OpCYWyb37XCsdlcHALKKqJwzwoXK4BwXEKZau0k/0upa0shedcIhc
	 eEI0p15ZOJsu1oDalt1JxJVGjj6wD4VCP2dV1icIqGE37v5Y8Ey577z+4kxcZFP06OIN3
	 EOw9YSc2fW47RwiiV3mLhM1kZKH8uj3zz1h+FSMr/ev+mAg+N3TSWMKvHB6wzQVoj5dGA
	 54qW6jUU9l5lfTqbXuV2Dvljo1rGeuPWj8QUbt/SEBIrNztVKDn7QQJ48jtNRsHMfgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljuu2YeY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64925606A7D7;
	Tue, 10 Nov 2026 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ljuu2YeY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D3F1F00923;
	Tue, 10 Nov 2026 13:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315938;
	bh=OpnFl0VJa0IOjz6ClmCo0IAryffEkF3pMAKxwq8/Kfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ljuu2YeY+iUFXJfzSJvjHc5ZoQxDs/9BPkOPPMpGiggoB0sCWi7tVJAPPaN74aIBG
	 ij+LiuEXHCy3xzkJ9gAWqANrqoAtv7h6hTfPpas2qAwn2oePfvXTNlsjzAITsXC3GK
	 QzmLUHYXCBZR1WAdpUcokqMTjDVFEUaQr823Z2PFkpbIqb2iL0d6iGitoCyp83jkJB
	 /6urJOiwsk4qKWMePkE7CvqNBmh1iC/8SW/jfIHzSY+Q0iVqdKGCHrVVXQtefiZ8aX
	 PJP7uOjOjHD/7em4qFbk/h5Msu3WsDKWpom1jKt50UOul3psZ8e0FNasKVxE8OwkhC
	 zAeI+4dsT149A==
Message-ID: <sashiko-outbox-207076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 3/8] lockdown: select SECURITYFS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261110132818.2231593-4-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-4-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:05:36 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] lockdown: missing Fixes trailer for commit 000d388ed3bb
--

commit 721e2eb133b0424c2cffa079b553baff1406aa9c
Author: Cai Xinchen <caixinchen1@huawei.com>

> lockdown: select SECURITYFS
>
> The lockdown LSM exposes /sys/kernel/security/lockdown, but it does not
> select SECURITYFS.  If SECURITYFS is disabled, securityfs_create_file()
> returns -ENODEV, lockdown_secfs_init() fails and the LSM framework logs:
>
>   failed LSM lockdown core initcall with errno -19
>
> while the sysfs interface advertised by the Kconfig help text is missing.
>
> Select SECURITYFS like the other LSMs that create securityfs entries
> (AppArmor, SafeSetID, TOMOYO and IMA) already do.
>
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

[Severity: Low]
This fixes the missing SECURITYFS dependency in SECURITY_LOCKDOWN_LSM.
Should this include:

  Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D3
