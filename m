Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177188;
	b=vwHDLF8kYaNVmIUmRweEbOeAj6aPplqGQOgpq5ZW6IuiYFqrbg7sRyiHRVYaYX71iAW8
	 /Yaj9xB4m21isAmtVCCY1hy7snhNY9iTeuCf2s3ayW4dFdvE83iMz7+hBrCBuhGCRQGzy
	 UUNM/HgibLeQfmZqjjDhuNKi7QqRwRu+1NE0fIfPZYKWQGm5knNFnXIrGfmPgUx4s/XQP
	 AV11JGuSRNqgRReEgHzEibNHdM3oZvYpv1IHU2cvldcVQruonV/1xpTiMzEJd8kQxDsFu
	 f6mnF+E7LxHPqZMdXN5bWIsrsdC2WG4eb/c4sej0+IIC1Sc3ZE4+Fj+H7CfUmrdZbQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177188;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gs+YhFCoBHnZOv4LuIMwdM0G4KJHpnh9KcJrGE2LwwQ=;
	b=XiTwQWV2N+ehmE1JeW8vDHxrUy0h7biV1xpB+7EPqEOEk4ymgJcaLw2PvSRS5R7X6d8R
	 22sIy25fbLSld9bVksCXyhzO9B9mLBbUFu9qEhtBEmB4BaVKjR5ojyV4WJ0CDAt4VQuGl
	 mm3bFkd3LTbWSOUh5nLUEbIRMRx68Ykho1Ct5AS5rJHLRJal6DE0Wgmckma8SBezsMxKL
	 LCQ/Wy3IqKD3QRwgRlrBkbg1Lovn3pSZzlSWhPEOrNX1p/vbkFgMtOwc1dqA0yQ+aBdSg
	 YNEBo0CGTwXtROwAm6u8T+qkQRKNlZxPW/GyxNrS6OF/kNEkEeTagRWLhLJpy7kaTmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNGPyvwe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCCD606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LNGPyvwe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3624F1F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793177188;
	bh=gs+YhFCoBHnZOv4LuIMwdM0G4KJHpnh9KcJrGE2LwwQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=LNGPyvweBl7v3hMTtwvCzSC06NZn81xOg3kbelfCUsNqr231sNLl+Rep9ZCOQXpec
	 xwGlWb0UXt8yBKgyf6G5N0fQ7CacmTJvDODXWup/CERg6I3sZJvhNk1Vx7Yq6eSAM6
	 whSN0IAszmkWbv0OhY8BO8Z7fQRmKZ7dGRFlxWtaoMgz0UZTv/NFF0THIne/hFI4hx
	 ronS1bhclX7tDgjRFv1sGRlYM3EJ3dof2EWE10g9+AmBCvDz+T6b0d0EPkgX90aF0z
	 J03Ri8pDg+ITwr3DNJpmpSfkQ+iqmmXbxKoCLkrzuNLO63TLhBmPCXcabsX7zWt2gp
	 kdkQkHp6qGFxg==
Message-ID: <sashiko-outbox-187633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] fs: Introduce task path helpers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-pidfd-get-paths-v4-1-e2a6a47e3c95@black-desk.cn>
References: <20261027-pidfd-get-paths-v4-0-e2a6a47e3c95@black-desk.cn>
 <20261027-pidfd-get-paths-v4-1-e2a6a47e3c95@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 08:46:27 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Chen Linxuan <me@black-desk.cn>
>=20
> Introduce helpers that acquire a referenced struct path for a task's
> executable, root, and working directory. Reuse them for procfs task
> links and AppArmor executable-path handling instead of duplicating file
> and path reference handling at each call site.
>=20
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-pidfd-get-=
paths-v4-0-e2a6a47e3c95@black-desk.cn?part=3D1

