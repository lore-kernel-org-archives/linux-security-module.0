Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426700;
	b=TAiCiGe6lr0Pb4FxfyUprTLsjyjkeOt+0k5Hzp4lEneKxL6TE0RSeOuq2AbdOiAoy94N
	 ybFCG3t4vU+kd0intHoAIbZJC3dwk99W+qfAHa6vXt+GKj3EIjLQAFNLzx+AGFf3mW0KB
	 hzdtrpNLl43AUzpDBv7V1iOWPau+QDGoprGe3FY1G+3UaIJLeN6nNOHgKX0Iz3AMMCMsL
	 1EoGPiivu57OaMcXQuXfXBETMQvdSfH4IBbDG9CdpukhHD1foMqFAuCBz2DGg6qKp9l9u
	 vPg8OWuPDu28wk1t1j43IFSpZW2kHQThRBTBoGEhkEHdV/uhPG1deRUSXUaRb09GuQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HAjgRmT7S3Pc/AnC/r0dJkKEAlPiyyg3eCXQf+84MYM=;
	b=hjyXhF2vQ9zF4luMfcPdyqq5EUte1pZfN3x/rebhdSi8gkybmdo+aQaPyfYlNW9wtB2i
	 g8trI79YhQH+HGyvwfl3Uyc2QOm3tB/XRsQQEhD4nALe4/q+GGUv+JHRA4PZYTHCOODoK
	 rHk2Y7GvOdCzYbLtcHT7a+XlTw9ntHK4urxle5nIxNRopnT3VRRMoLPwS9YOPYZeFM3V9
	 J8Pz9tB1Ugc6eyqjZ82K7uLqV7bYk9ReA7IXVt/k3d3CpER8uGZ8DNJt+4/MXW02cwAP7
	 SnFowxDBZc3QHQGgvDD5zEivYpu56fVZhbWjvmDL9igGYVaN3qbEtptiBJTSUr93iSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeCDGrvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1560A2630
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeCDGrvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D81F0182D
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 16:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792426700;
	bh=HAjgRmT7S3Pc/AnC/r0dJkKEAlPiyyg3eCXQf+84MYM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JeCDGrvOnD3vVlTkjY85Kldod7hmM0iukP6ivOtYfzkZSitEYE7l2i+bwUCo8O3Gj
	 g5ohajHJXNyKBoblglhwfE41BGP5W48lEJmPQ7nI5OGrQJAHq5KqhlxHjAAlOKemAz
	 sdwNY2waDnbkUjJu52+ELWoqS2ps+fWVcVK9WLXGec+5O2zVy+F0Gjp8w+NOi2BiFQ
	 mmjFDfMXjTT67QQMqWb3TP38/hie2ljR84Ojx6TDoCVGuApdJfH1vD04U9ejEcLa6b
	 /qNOQvf5NuKXqz0ihS8BjwqADR7jIC8sURKov+ST2c28QCr0eZAF65KnaU0GttqIm0
	 z7BtHK811o1Kg==
Message-ID: <sashiko-outbox-177859@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] KEYS: Prevent overflow of user->qnbytes in
 key_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-7-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:18:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Add the missing check rejecting resulting byte counts above INT_MAX.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D6

