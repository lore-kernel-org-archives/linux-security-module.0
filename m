Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1103EDE7C
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406179; cv=none; b=jHj4zAKlVjE6p2lWgN7BfBN6Disk8F/5E7a9SjvyLBaDIzyvRoTQC1yRu22hfE4UlD9Qs85vC1ReJpSpb/OMfKJXDldjKGXxpfmftsF1vG4Ku+PR9vpbw61YMU4ws0koA8Rbfo5WMDeHnS4ces2JB0f81E+81/OBCPdvFfXQmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406179; c=relaxed/simple;
	bh=iMzmSmalE80fMM88G2L2HDnQR2B3oAthDZRp///2n4s=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aENnDcIhBdJ9Ps9Da2qy2JN9CnrMtF+4wp7Ry8UiTVa58p5AX9jxFI7Wgq0s3PqiE1ewt+7qO3/knSj7D0o16/nAMUV7paeysiHlQ9E1Iodz7mFiJBXgBM8NHyV/V9q1jYJ0Ohshw4gDu/5AKNYrvcsIDP0P27OaWYjwbz0XyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBBCcT8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBBCcT8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D071F000FF
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406178;
	bh=/VpVuafSjDNwMk5ZPJbM1wiYZCSLdDcfwWfryg1lDPc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fBBCcT8Tgeprg7wD1aOK+VEwWkslPXe1PRCdP5qLcZVe4O0feHbEFSDt5pe7kIuGl
	 lrKPqFlWa2d0vkYHxUaEPSlBIMN53ccY0NjglTL8EagZRSZX09ksblvvjUTQU/lkbp
	 k9CUnWVtqjo9Hzj4TEMoTx07DOlZ8I5R18Y/BCht1H2sIfPQGj60Mq6SOvcaYmWMx5
	 +A7Z79FIAQln/NTJFqdRVkIcekwN02GNjNNuCMTQHKuDnNYTtMlIx5wlug1UzCjTWv
	 hKEpgaaJtiEmezc4z9JPWuaFlSrypFggoKwxc9A7vPk6Z3wyhOA1gOfv3Gew9qUq7o
	 azdyYaBfj4X0A==
Message-ID: <sashiko-outbox-163353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 2/2] apparmor: Fix & Optimize table creation from
 possibly unaligned memory
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007204226.47033-3-artem@trailofbits.com>
References: <20261007204226.47033-1-artem@trailofbits.com>
 <20261007204226.47033-3-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 20:49:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Helge Deller <deller@kernel.org>
>=20
> [ Upstream commit 6fc367bfd4c8886e6b1742aabbd1c0bdc310db3a ]
>=20
> Source blob may come from userspace and might be unaligned.
> Try to optize the copying process by avoiding unaligned memory accesses.
>=20
> - Added Fixes tag
> - Added "Fix &" to description as this doesn't just optimize but fixes
>         a potential unaligned memory access
> Fixes: e6e8bf418850d ("apparmor: fix restricted endian type warnings for =
dfa unpack")
> Signed-off-by: Helge Deller <deller@gmx.de>
> [jj: remove duplicate word "convert" in comment trigger checkpatch warnin=
g]
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007204226.4703=
3-1-artem@trailofbits.com?part=3D2

