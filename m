Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160426;
	b=p/PpAGDqO27NEHdMeoDzO8n2646Z3Qv9rg8GJGvflacX2ceqJh4754DD7yoM4/nCGhtg
	 yG5lk+K7NJmj2jYRS2D1kVu0Ekpuify4u0UDH1XY65Ryrk33yc7A76MRz+qDTo/NqNvM0
	 Gd1QdhqiAe6W/fikimmbo3aTAs0OKr86H+/KjM2uA5TT4nb2mZBRJn7not54NgkYy3p0R
	 2KmHE5NAP+JEudgClMiRdUZjk8qjLkmv5eXz5ET5NwguWk5hksGg2H9t1qjqKa20vnT7C
	 JSdTTu4BWtojsXPkpm656z9SrkY/OSsTpga9jKrbnoM+S7EdK6apRLDE83A3sZRp3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lh3T+WHTeExXx6Ppddvx1YAM7XDzVtsm62uFn2z7Buc=;
	b=4x60LweXhX92HRbcgcEjt7w5/PsWA8wN6LXX0JcohmO356dS5yKU37rEfJr0dbGIZcJa
	 BBzzSSd6WA3tA85X3FVH2zFd3/+Pyw2LaYIBxX33ezlO4misyaZWxcQn8XRQo0c+jXp12
	 xzb/1cSJcO1eF7CRop1FdhN2AOaewie+gjVAbP+Oa8E0hDwJG90Q6if1LpVtKlpTrMxd8
	 OO28xIB+uT6Xe3sWqj8DUkFcgHSju+SnIQZvDWM1XfSZCIVWMiLKxRB1zE6rCJP/dZmlY
	 ws+qvQ0RGiwuBDLahRFy/k3g5dInm2d8MFKfAWwTWf+dlKdrqBgY0ctXcCwPs4GnvGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oD4kEoc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DC606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oD4kEoc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB631F000C6
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795160425;
	bh=lh3T+WHTeExXx6Ppddvx1YAM7XDzVtsm62uFn2z7Buc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oD4kEoc6EtjeHqW+8X2/Ud1P4o7Cr9xYqXuoaLO+Xq+FT1IBJKMnnCe6wuEHqBDfO
	 IDyq31ZQHkYxWAkitxgU5IP73VrKCnd3iQClE7UgVWEGQDlArnYorBqSn4kc5DNKmD
	 ORMuEa2NDzYM+mMfs2x2GmR3bD0nEE+zav5fSvidOu5n2676HcNsfMOeM1e7qOSxCl
	 D3aWiZONPe554MKh48lviNKzsz/2m3gNaalm+osBBgn9awgLIXD3luANfFYVUoSdIg
	 d2NOLKbJ74pWeEQ4JUJw3BEKF9mZyeYY0YO8hhjRO52NHqFYUlUit7+Bd0tHfPLZdu
	 DuXARYhydAxYA==
Message-ID: <sashiko-outbox-224641@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] lsm: put the copy up creds when an LSM hook
 fails
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261120073717.1588080-1-amir73il@gmail.com>
References: <20261120073717.1588080-1-amir73il@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:40:25 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> From: Chris Mason <mason@kernel.org>
>=20
> security_inode_copy_up() leaks a struct cred when one LSM allocates new
> creds for an overlayfs copy up and a later LSM then denies the copy up.
> One such pair is SELinux and a BPF LSM program that denies
> inode_copy_up. Enabling both LSMs and loading the program requires
> root. After that, each denied copy up leaks one struct cred, no matter
> which user triggers it.
>=20
> The hook calls each enabled LSM in turn. SELinux or Smack allocates the
> creds and returns them through a pointer argument of the hook. A later
> LSM can still return an error, and the hook then returns that error with
> the creds still allocated. Its kernel-doc does not say that the caller
> owns them on error, and the only caller, overlayfs, does not put them.
>=20
> Reproduced with SELinux and such a BPF LSM program: 36000 failed opens
> and chmods by an unprivileged user on an overlayfs mount left 36000
> struct cred objects allocated, which kmemleak reported.
>=20
> Fix this by putting the creds in security_inode_copy_up() when the hook
> fails, so the caller gets either creds that it owns or none.
>=20
> Fixes: d8ad8b496184 ("security, overlayfs: provide copy up security hook =
for unioned files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [amir: put the creds in security_inode_copy_up() instead of in overlayfs]
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120073717.1588=
080-1-amir73il@gmail.com?part=3D1

