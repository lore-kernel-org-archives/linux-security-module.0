Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826884;
	b=tcJ18KJddvXacQM0z/tdYoEr7jdZqVyhVMNHMauPeT1VcsCjn6140DVism2HNhiwOjn2
	 89Lfd2IOqe2QnfczQuyN4U2+uY3C3XLvAh91OFUiJh8G6RsKViFZm93Q1uMTJ6UuUuDRw
	 vB3DUIYHw90aZlzou5zs8Wi6RgUgO19MOKhL0x+0TX0Xwz1V8Iq76Pdl2Y0HnG8RdSc84
	 umrTvGLR/SU9IgB5b2kDSrnMZbKFYYWRUNMuG4ljNQpsl6+edboBSQSTQ801+x7O6t/Uc
	 SZT9MFOdYBJ+OGqS1gnbLQBh/R+6PwqZwvLgiCT2gpYV0w4FBy0qqzgR3p5vPMoLJ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OP7QtYWMZh6foSaLm1TNfRfszlnoailq4l4BuFFL3Ec=;
	b=xR8uRuXl/DreDB5r9tOYgDMNt9qSG82MiAGz/GzFFuJVCOSHlJsA5t+HhfjKYX0thpBO
	 bxa7mezev1W4oPHtynSxBpDZqom4rzQOoFZ+fWiCvMk5nN/3HsGt/4ful0L8Ld0yXye+s
	 I67V0ukpFkVcCj3/6jDuaOxWyYcGCyWyg2MoMZ4H3T4g5oIERns8dZ49I7sQsMGjrgto3
	 HJI3nhOVkd5Td7cCfyUl4ZHstzby/vSHWYRLOYmhW7iR/2HmWTHUevHIPopaQg/4eUFBV
	 OmV42SYrO3E88vWsUFQ5Ca+NbGV1/7TV5Z958evcMFQDucQmmEl2GEoXjaYhVXzw4zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E79SgfUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3C6082FC7
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E79SgfUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD561F00919
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826884;
	bh=OP7QtYWMZh6foSaLm1TNfRfszlnoailq4l4BuFFL3Ec=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E79SgfUzV+nCSiUVJ6nHqRqyObtf5rhJwjxUyvPfkZhELg37vQi2BnZn3EEa471/n
	 xlvA+2E8ipZxdj9A0+OA1jnFqGpOAo/NeWrA4IY2KjEr2dsXTtFHumZa3JEV5fuyC6
	 /w+VEWZiAQ3487GTAdyPtXkVmH6VvIxopxgmq9yM2hYqct5gB/bgYdNIe/hMvB/dlU
	 bDP/xuDu6+WrQ/wMZGK7lfj42WLWXGAL4f6oeAiSibdx7zix+S5DRSa6f0jaW/Po3l
	 ZFVtQ7d6+59YjgmIAIP2QGmb+MmrhKHuPKN/R8LppvcdDoLvgM/bZRpwCaybHWu2gJ
	 gabXtU1g9L6wg==
Message-ID: <sashiko-outbox-198069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/27] selftests/landlock: Close leaked file
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-15-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-15-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:43 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Several tests do not close file descriptors they open: the /dev/null FD
> in restrict_self_fd and restrict_self_fd_flags, and the parent's ends
> of the synchronization pipes in various ptrace, audit, signal and
> abstract UNIX socket tests.
>=20
> Close them once they are not needed anymore.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D15

