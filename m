Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446423;
	b=R89yxkzJrPppn/hMCn0DPBDSHAoIjI2m2f+7H57M2BGv7vleMPz2BsO0OhO38FmC0J7o
	 VPUun6xKW5OZPmj3semrLIlc6AdOn1Y+I03vp2mOvSODruHu24RZW3bMSKDP3JOmbbN+m
	 Kp+DpbRn2OiOxxmKK0f/5jOWjcP8TXTph/g2e+vS3rEeRWQmvaH+pN0c8ChdB6J93+rB+
	 Rhu7EcGo2KVY9NJdmh/VOjcFwxz1V2E0HXdDxd3CDqknDcYFJiQRGXqe3JUxaHnxkvKBf
	 qt69hhz+PGrztOq5Dp2Z2U/8KtjZ4BJ4bZ74tj6V1yiTuFK1b9UqhHfoVX3PsdBrs6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446423;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l4SHZ/o/LHy+0AtZLh0QUW200KddpN8O26WqeUAKprE=;
	b=Xr9WVmHCYDdPCo9yedWaha3EYEVfOjHqoRTZGENgAETjk+PFla7UpBn9KM65y9TPWkql
	 ykxJdSRTzBDcKRcFvUKDl0EayCxrER1l4C9pXbfOXkyM1k/6bTRwI8hDupsHOhcR4k5Vc
	 ZDFaFAYRi62k5Ze6cO392kIuTz9bfsEPEBBubQMfSdc6LEChg5iZBzNOMWZpcbf5SENYy
	 sei18nJSFS2UkpDOWdfcIm5gIdaml0z+sC4qSd0H04eOkUQM13Q/EArVC58fkL12pBzhr
	 PCXbjSZCQ6WFTrjzeqIeceO36KWpSqLrGjs1eb6wtkrB/jevq6RnbPDfBGKUW3bl82Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1Ck6ufh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E6606A327
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o1Ck6ufh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D761F000C8
	for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2026 21:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446423;
	bh=l4SHZ/o/LHy+0AtZLh0QUW200KddpN8O26WqeUAKprE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=o1Ck6ufhoe5JD9Bi0f9E3W3LE5YJtO25z5hr2OUCKBwpT9RNkZYgNZymgbD/kF+0e
	 ALeBi/UCkfuQdiH47NPwABdaOW33Uf/j7zk8ZO8zOZZqZa0XSPdqxygZz5VTyA3o0n
	 3YqW5zTBWrZH0E9SjIWo2T8GVE/GT0wBo1dagjDirVR4wjhS7Tfn1zGsfz19dmwvGA
	 UqRmY5YFtoH8c6ewTGbZ9cqd2Onr1Rmj0RDiFq5DlnjY3GGi5dz91K1e6BlTyeit/h
	 7xlVCufAXgugqBQId2SmwnNr2Lpe0aKpqCddmm/JKp3qo6LAobB4OK31NRCbilRnNn
	 Y4nwIVWZRTjQQ==
Message-ID: <sashiko-outbox-178275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
 <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:47:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Manuel Huber <manuelh@nvidia.com>
>=20
> Add a dedicated .ipe keyring for IPE policy signature verification,
> modeled after the .dm-verity and .bpf keyring implementations.
>=20
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
>=20
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.
>=20
> A concrete usage scenario could be Kata Containers, which enables
> running Kubernetes pods in ephemeral, headless utility VMs, possibly
> without systemd. The rootfs disk is static and known beforehand, but
> containerd's image layers might be acquired and transported into the
> VM using the erofs snapshotter and dynamic block device attachment
> using dm-verity.
>=20
> Signed-off-by: Manuel Huber <manuelh@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-b4-ipe-key=
ring-rfc-v1-0-156f0b93e843@nvidia.com?part=3D1

