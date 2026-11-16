Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822554;
	b=T+ITJbeQ9r3nRROo4yZnxKENSYzGfB/9JRnxAmjtOeHw3pPj5l4HZ7sY0dF/ML3C5jDD
	 hsQkTlBYiBme9zX57etR1f7U+2mfGSc9GW4al6noRHbjZcX+pGrmocaqVuMtYRruvdiz+
	 YgLjFDcSIh1PNM2/Ln/psyECYwzacwiKI/g0mUKMXKEfJ5fZi4J5/51rx215vVFh6fSl5
	 vQjbUa4gw71YtXRgQrIAOuNIl1xvvOyGXy41Ufxx5g8ITpy7G6Gfo9QdamEciLg/j/JcQ
	 X/m2eGF1QkEyBZigaGEZSM540Z7XQwY3QOUz2lo05m4yOIimbs7hvTtx+ukdIkhSTng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822554;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+z8/vyIUyI/P0BvaXu0xqsLRRoitVSV0nmQ54WBbfqQ=;
	b=xb5B0oq9FpDphTKifIHFgZy34LSJldxtLNcBaYQL7FQvG3TYol1QtLJrVnYBZfTmm0yO
	 9mPsgmtEQ1cnZJAH7Hzm6/xaBW9yQTDMOgbqVBEwWzFEPGtSuj4pmuhcyfNQHfXi0uFIP
	 QpcF1sI7S81OZDP77GvmnWsx6/uukXednhZs/KWlQK9UFiFOsh6zkEgHMO2+zk+r4bfS6
	 6W9AZNUQN0FzgeT6Kx8E5MMIdeog4urXT5K0ONTe8VjpuBiPrWRTV7N042F3CMbkTnxuf
	 y25UPrQzshfSfs/XHIuvFltXQmvG97NuMQX4MynrBcpFPWq7aWVv7yKwcp1AahbKmBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0gSjhBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A7606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0gSjhBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2781F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822554;
	bh=+z8/vyIUyI/P0BvaXu0xqsLRRoitVSV0nmQ54WBbfqQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=B0gSjhBoVTalI+reZDGdFYhlUGPl8zNeiJ1E8s0Iw0VcRYF+VMBjxOLqrsMvDAwdB
	 lo1LJBXQyeXHBRogmMCqrK4SIRBUEyZ/SEeJ3C765NNMPxYH751akVxHPN6PKT6V69
	 NLA1ZZMupkhnOkeXovUfWrpvTEx3pABDH0l/8nFvLWuQTjhR4X2E9f4swwN3T4BH/9
	 ruAuRl9BtCldOxnEZlJJDHJ1O9ICh+x0BN7FXKNAzW3gXk1GAiQlY8FdbXoessoJTQ
	 5UUGijTGThdNaIQR+0SxBdmmeksUtVz0Wnx84HlBHlW1GIwXIuj+/VEaCqaKVM3Pmf
	 mpTXlheZTtxTA==
Message-ID: <sashiko-outbox-216641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] selftests/bpf: handle d_real_data_inode()
 errors in bpf_testmod
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-5-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-5-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:49:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> testmod_register_uprobe() from d_real_inode() to d_real_data_inode()
> and drop the path again if the data of /proc/self/exe can't be
> resolved.
>=20
> That's hard to hit in practice because exec opened the file already but
> it is the only modular user and d_real_inode() is going away.
>=20
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D5

