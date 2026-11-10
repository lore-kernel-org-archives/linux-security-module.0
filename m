Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315598;
	b=4uh6IaVeWml3HmsAEA4eJdu9ColqAPxHDqwuJQkK1X4QV3QkU6zqcOkypuIj3YqF3oBc
	 onfyedy1YMrxkpzDTSGGwOiRFGCxbGxpyETGRClLPAMnmUNChAWJ5GjMNcxaNjSCbF3uG
	 eJRFRgWA5Rb1tkbDgzB/kcNe2TSXEYTCtBzOF8kygveXC/QhrnVdMEu2Q/e/+oR37yLpO
	 JCLro2dDodCOHmhdQKexQfqdYWAkSs29KSafyBfK7OpSCFPOzpKj1AXbfOBu4aU1S7YMI
	 1LmbQI18XyjSANBiVj5vQrhYaW5p/D8NryQ0zlMH6mTk2m3XvWRrIToQK3xzZjGk6xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=etRo1AGW53GpJ3t87Sk+S0jDDlIboWUGZMnrrrPgsmQ=;
	b=gWXeMGbYZ6YOgRHxYUHv/3gAtEy8FYqKHMsYkYfLFa4OXvchtsx6KOrGdiGpE/m+NhDU
	 iPRORPbpFfiWcrzmqafETAnRB/+AJf1wDhB+MRLYLzDfqvEid60UBulJ3mBWYEaoPEqdS
	 eIs5F5L522ew6QbavbYXQUQPuvHb8sLuCOqmXJjTc2C3yC8QnXi+W6M/KS57NTdBDwdXI
	 CVfd98mTqTHPFk89VAg5V10sjk61p1HZLh19XsUeywUROAVrbg5dEDxbkYCIjHpHWAJkv
	 H1zttjIuFbmTkPAwffbbc1zKj//5Y8m0zqJ1EIeTV9Gu0verg4KslLzmzJHY4mW4Hgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjEk4R64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12B606E441
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjEk4R64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5781F008A2
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 12:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315598;
	bh=etRo1AGW53GpJ3t87Sk+S0jDDlIboWUGZMnrrrPgsmQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=GjEk4R64f3me/2SNgMXfd1dbvC1lMcK97n5FtOBDX/lNFdOFs30S6RaTguz3/n/vx
	 86QeKOJqOA+28SZsRlBdLI4RHMoZ8fLy6OaftWRpzBvdtH2LFvvw7tTpe6R59iOZmv
	 vc6mnvQGrAJvgRqaV/T6sdgOzWQkinTOhdA6AVacDIeliDA9dxUsn2A5OTC9LFTb9b
	 DcjZherUTmBlWidwOBcrUiPRK4wHwuxMfXNw8Yfh/KWFBRgXrr8hDusOXb9toL4ivx
	 yptZkt/YfBrIYHe/4ubJZAPGa/hThF0C4Fj2OG7EYBXq65nw7nhHVWRUFEHAEezak7
	 6Kixj4EDeiUrQ==
Message-ID: <sashiko-outbox-207065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 1/8] lockdown: Add break in lockdown_write
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261110132818.2231593-2-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-2-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:59:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> After the label is matched successful, any other levels judgements
> are meaningless. Therefore, add break to return early
>=20
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D1

