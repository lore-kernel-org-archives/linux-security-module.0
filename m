Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424481;
	b=T2GBYFyq9w9rGhJOOhEuLU1Tho6x2koMgDPe4PwfuW26z1cgi7+eUmtk/qIA876KcSFf
	 drFJ5UX3vhUAj6UkOOmBuIpVgdzj5JMHutr9FSpE5Gc1OF65SjkYgKo+VsezV5cWU8ydQ
	 yA3e8mYuTS/NkDg4llkf4pxIOW3+1Wmgwyutkv9uNy3xONKSz5AIgTKkCBcAVnbv8D7XG
	 T7qHJfpH2pgXtHAaRqiKVxO470Y1J6d0nFmB+cU1nF4q9qCstDwBdXE+XpgUSYVAWtXIr
	 aVta0stv89L8Z2ZeG3sughzAnOz3Ioxx9hyHGZ991OVmcGTQDq0tkDYGlO7H2rYwhgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qZN0N7AlyEKhAQ12sV3uUqokQ5xJiKzqXuDxkbih0Cc=;
	b=KoghI0wS2zUjhFHatyu3uBkrJxO858jcwtk1vqLXy3tNyXbn7/A3yG3RhL/Qtekf6GeW
	 IPn9op2H9QWjCS6AfG0M2RkrvFc0Bdx5hjAck5MPdaExdb9OwtzlAo39cS5ZTkf/vTcOy
	 JhnXdi4tAstaKYuDxayl1jWSWEa4mVPPsiYCyz9VtC2QURdUK3HTlZ8jbXzx2H5+edKiG
	 FvEiYE5nIK8ZEuunez59CMVEvztCFM323ZEB5rasEv3aOAsDQDcPMFnnUGvXk15FwYtt9
	 0DeQEdaoF6YtY8TI42zFUjC0yjoP2M8ucnuaGuQEYaFFFSfDnEW5WIcvK3T9LbozMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mern5wrP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367B6075511
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mern5wrP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E8E1F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424480;
	bh=qZN0N7AlyEKhAQ12sV3uUqokQ5xJiKzqXuDxkbih0Cc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mern5wrP6ZYUhFj4VBXribVv6/zVU9/jixOeOvSQ6PKyhDaLD2x0EXxxzV1El/SYr
	 OxHaf6sVylN6RVxuenbLvBUOPMfY63chtNFR7Afew92MK3ND+6XtbArVXaAVRqMsiY
	 6SFZc8iiA2tjzWyG4A2PvqZJ9TbJacUE9pwDxgAbwA7mv/ykKgIizmNb8B5hFeuSzr
	 6+Cb6sicKEbhFjUionTdOJY3dzz4kw4UBBNrpuU+MnWhX4O9YUywMB2ANp67WEpdT4
	 /c35Mpx+Ln9hDfYodagLNFItqZ/7qVGwk8FZxnMu+IQXBd53Z6Av0eZIoIZ5C1le2w
	 Gq3l91zJKSEjA==
Message-ID: <sashiko-outbox-177779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/8] KEYS: Change the type of key->datalen to
 unsigned int
Reply-To: sashiko-reviews@lists.linux.dev
Cc: =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261019142516.300040-3-jarkko@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
 <20261019142516.300040-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:41:19 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_alloc() and key_payload_reserve() set key->datalen with values,
> which can be larger than USHRT_MAX.
>=20
> Change the type from unsigned short to unsigned int.
>=20
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019142516.3000=
40-1-jarkko@kernel.org?part=3D2

