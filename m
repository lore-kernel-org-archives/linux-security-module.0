Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751644;
	b=le8BULlzgbBVmgD/76+D7M1P3Hnik8k6QkBwT9fruX2YJYmftvgCqCCtXlVoIM4b9Gdv
	 IAAtonIsyqScClsseZjUzwP+kIc12uJHu5YWV3dCsdyfn6NFd+AX7BSGtLi/mtNktTPyO
	 7tcV9d6MwqNvnPU9RgViB4/ZoheKpC/WSij96yCmfBfoVG3NjJJzKf4jwd4TfmL3WhmYl
	 kEYcDFTkfYlkDzMnn+YAwjWv26BahRNMdAB4OckUlgQvdKMqKNumH14UKfEYwRj59/Qmw
	 rnDIwrxe1iqBaeRSAtmn1WWeuVaf5A0gYhqu+VWeivl1mqqu1XuSl3g41MfgqwQw/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751644;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hCzexzvdunsyGa5GEgbdL5oHPyimwQfxMXbw3/U7MpM=;
	b=oEbpdJMxQaB53YBBS4CxvU4zTNVsGvH1i+OvhqyXs5T1oTxNNDb//qOBYtkhI5w1RWEH
	 onGE8FiENvOq2CCmuX6WWdy/gkmejLnjD33mKRzpTkfNtd8kTuKWn1NmPBpknVmrdzH3k
	 JLFC06+nt9Mxkpw7D/Zv+D7au4kFCotoIcPThngMb9Lo6bLhUgrN9kFfiHzDcc4KFKR3t
	 UPaa5OOLTUxCr5uzzRPwLObr3eklPwcM6u6BvVUjgqBPBL5vLss5RSH+r2Pwbyc88OVoU
	 1JJX5bF8wLl0ucK3ZsGlnHjstnM0R2/z/yLKwitECu34R2yoE+ZAg9fF1CgB5fgar1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkpFfjwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6921606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OkpFfjwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F29B1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751644;
	bh=hCzexzvdunsyGa5GEgbdL5oHPyimwQfxMXbw3/U7MpM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OkpFfjwJURUdMGUlYio4NUhjM0KErfbH5b8cm9oOGaZW0GmY2aStyApjY04CseRek
	 +t01yDYai22KAOUqsU3XkmOc4dcLyJdDIp3hnisM7530E8nNnSdAJA2ZFJk720x4LI
	 b5FpKtcVy1/3BApZ0tCjo2U3/8eECJaSQNeG1Ai44FsSS+YK1oKe+dshwMs894hMV/
	 QOVq8LwG+C++faYZEE0wiqDb1DXkSgdsGa/sayOLkG7ofyjdh6DvWxohTUAKf1cjGH
	 QxBNiqs2jOBBxfbD2f3lTu862EpKKnIp9tsQtmljfQdOVK7o5Rv0wCOXhtCsZD4U7B
	 HoRONzW37pGBQ==
Message-ID: <sashiko-outbox-215562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] ipe: handle errors from resolving the real inode
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-8-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-8-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:07:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> ipe_build_eval_ctx() from d_real_inode() to d_real_data_inode() and deal
> with the error.
>=20
> Currently, if overlayfs fails to resolve the data of a file it hands
> back the overlayfs inode and IPE evaluates the policy against that. The
> overlayfs inode has neither a block device nor any fs-verity state so
> none of the properties of the file hosting the data are visible.
>=20
> Remember the error in the evaluation context and if a policy is loaded
> refuse the operation with -EACCES without looking at the rules. That's
> what IPE returns for every denial and what IMA returns when it can't
> appraise a file. Permissive mode allows it like any other denial and
> without a policy IPE still allows everything.
>=20
> Note that the operation wouldn't necessarily fail on its own. overlayfs
> doesn't verify the data again on mmap() so a file whose data can't be
> resolved could otherwise be mapped executable.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D8

