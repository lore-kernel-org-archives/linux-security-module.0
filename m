Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673150;
	b=T7PvvmBu7j1AQkZgAbj6rVdxJKNuzkw8Xfk5AQgfEStqv/MQ+olmUIqX6z5Mlgr1eRzn
	 XMdznpxXWaHHUN3HKSD7n6Ok9Y4VbjquUjuWt/WmKcRV02TlZTz24b+wWQFjoDJMKop2B
	 m483YG3gxP2rBdu7cyCFDi8ownLmBbpKIyYVPMPcXM/zgVzty7x3g5TaXpxueKAHS8SsB
	 CZVx8uIlcxlGKWtWjDqD0d9pyXVC0fcYyc4K2jJkAQ2C3zyRFG4lqYpzR4xg4qDFQd9R+
	 VbQbzqz9hJeyV6lJerbbR/6b2uFR6WpHWO6KLdwax1UAU8Bf2iu5cXm/sGS9m3MpWcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673150;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cvDjOI5r6XkyDApBaCCjDsCWbnYQ7zI2r4HqPRoAOS4=;
	b=Kq1jUh9XRNfmBBslwQVT6WIEIf26TIvoDUiv/mzO9QTudfRGH0uFWbJFuVFyHWbG/Jut
	 w33F3Ib/NgVs/yv2971Qg92Y1Pky9AKRlx1t5qw2rnx18ZbK2m/r8yBuoOblJGxUdzW7I
	 ZbUyEC6U6ZFJ3j1qy1IL/VEpNL1lz3wgN7hbA7rF678RZBlFbIgQh6s8OBojKHBy9+c6W
	 PzSlMHrMo10ZtUG5Ho40NrXirDu8Y83sp/jOFKYUUamXhAlnsU9SL3sM5uHuN6jK61d/G
	 RzFR/mFefD+yzP84XVk/oO9N9Hc9bdwH1+xJiIOoaLT82V7MSVVBsFw728v3yGSiO4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNn8Rejj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6675606A880
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNn8Rejj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AD1F000CB
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673150;
	bh=cvDjOI5r6XkyDApBaCCjDsCWbnYQ7zI2r4HqPRoAOS4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZNn8RejjXQTeQ+o0Lw3YXqpqQ0WT4hLZwB59Mc0IYEnfE51AxNHQbxGvoxA7RpTyJ
	 99lbacjm+6rT2hYvUSfrVtjH82Yz4Iv7TuqNP7sG9tuMPMkVNS9cgQi6iX2i1isjda
	 oRnesp87xWFvyj1ogr9caFB6demoCDlo8ZeqsOJkSJz0ZshfgMcBOyzzNM5LiL0v5O
	 UXpHHbtOSeTFMp+KdduWWnqanMn+XJgWL9PevPqPlW2LSc4P9R5rd0Ysdv2TA/UkAm
	 Miemf9fRHqcs4PXtO7jllVMHr6CndZTGLWMb0X3j0tMVb4xo2ZdhEU1l0q3rh3yN7b
	 GuubHavLR2aig==
Message-ID: <sashiko-outbox-214742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/6] KEYS: Introduce keyring_is_empty()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114161211.376859-5-jarkko@kernel.org>
References: <20261114161211.376859-1-jarkko@kernel.org>
 <20261114161211.376859-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:19:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>=20
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Ignat Korchagin <ignat@linux.win>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114161211.3768=
59-1-jarkko@kernel.org?part=3D4

