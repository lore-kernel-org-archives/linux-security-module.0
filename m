Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165548;
	b=N9N22Qg7gy+DR3KqAO0pAqW2jXJfxjeipbmtRWO13L6VTMCGQyrlIS4TGlLaqgifmxXd
	 V9/SWmtgXpGpwdQ6EDIKofIXA+lrDO7PxsJ9sCTAR58R8PUUVz+xLdsBGjT7C5wIRJr6G
	 lqtRawuJRfjQkEA9xmsjGN7kcbJSeYrN4edm7luaW+262iTLQuELDRT6TYDXH1iSYkTiK
	 idyGnr4BRqevQ1+aIUg0lfX8kPr9c2aiTRfY4rHLk/X5XkeXbkA6Idf5/7mwcoOmFls3q
	 +mhU5d9MbgK3IltM42+VVt/pN+nvkT9Kn9eZ8rTbVCLMMNvOUzjD4Xmhrjd0R30l38g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NV/yQ+bbys08EWW5BKKubq/IKhYKNF9d2qVqDr2vxDk=;
	b=R5NhF1sYQWZFgFXS4PjcOTp+hIeOCfbPNvgXTbacK2CC45z16ljwAS/Jc8RBipggb42N
	 NS0sw7vit6qSvgTlP2C4zZSPWjJWgm9J6cY0l2+gHJzEU08f+fNr/mRstM1e4BTqUWu1i
	 kIeXSxwCCsMVCUCKerri0Eef8DjdbcM8/EqcOCzRMZxfODw8tfT0hLNDf8YgnpSvVVUzG
	 3Ei/+TMiNFY92wguOSfrvvdY1bnu6Mt79k5WtlEEIlZ8YqKOUZh3skRmj749dwJz+KVuc
	 1eD34DX0qOyusdonbyLeWFUTfdphyDpFqMvbXa6mNhn5905gMCtMy7o9xFWwbvhwReQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxX+GNpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04B606A320
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxX+GNpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943991F0089F;
	Sun,  8 Nov 2026 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165548;
	bh=NV/yQ+bbys08EWW5BKKubq/IKhYKNF9d2qVqDr2vxDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxX+GNppHjNMZegi7HRZWEUzzzGMaI6R78y5+1t4loK6bjfGWOFqiayMx2v5Uoe02
	 tpl6pDaRkYM7ubclLKd88zPysesMg+RO37jlnd4FaXCjODt9zwRKRnaiJFOpikW0/j
	 K+c4coPD3IsTrSJe521w+AgMQx6n4uOgN19spIkSEFmSMLyL3Zo/dHCgd20sbcmk7c
	 +owr88UnWBmhkvlwfvLxlb1YOv+xMXSZhH0sVdWX/erXuLhbxoRRR2KWIfHmuyVRQZ
	 K2Sjkd4pZfDF9rimzTUwq2siaPYCk5wI3gD2C3Xdke7ON2QZhENWFHZqvZrFKaV0nt
	 bLnHEm0kXNQLw==
Message-ID: <sashiko-outbox-203933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after failed
 loads
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:19:07 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When kexec_file_load() fails to install a new image, it can leave the
> global IMA scratch buffer larger than the IMA segment of the current
> image. When that image is executed, ima_update_kexec_buffer() copies
> the larger log past the end of its reserved segment. In a test, KASAN
> reports it as:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>   ...
>   Call Trace:
>    ...
>    __asan_memcpy+0x3b/0x60
>    ima_update_kexec_buffer+0x265/0x280
>    ...
>    blocking_notifier_call_chain+0x88/0xb0
>    kernel_restart_prepare+0x18/0x40
>    kernel_kexec+0xe4/0x130
>=20
> Limit the dump to the smaller value between the scratch size and the
> installed image segment size. Update the IMA mapping only after
> machine_kexec_post_load() succeeds.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108190404.1397=
829-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1

