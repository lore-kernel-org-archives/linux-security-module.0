Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012246;
	b=g0c52LqPxfbJ+km4vOvtXbbYX4/pf1wcIBfg10m+kqwuAPkZ5CjBiDHM7gl/tglXVSlL
	 ujk8LvADGykyqlqD9AjJH9roTdpAR7+sFYSqt+cNiO2Z+4ug8i58W9ZLlogZ/FVHyTaCo
	 AykS4/JC61UIjOs0qt4DEE1ei5J5P47HBLNZTsG8kpTP5rLwR/VCd4DvfXUJKcPNLcK2Z
	 l5vOXCxyu2s8TAiVs8IkPvJtSYzBWcxQhTgh2rUG7gEmAYg5/aahifWSzNkmU5GGPjc6Q
	 DLRhy8CQgMxJqEvZuk0c81+XaPPu3WpG9Z/xO8oLRIUcNMxufZWWpZJ15cQqvQGGWtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3wod+sgSe5AO7Y69Ed0onzp5ruRWZ+rQ/N5b0V7FJ8c=;
	b=Zy3WkuC+N3vscXhe7AttkT59iYCymw0BWfZMF6GswQP9U2W7mASWAdyH6+NJEgdIXDwp
	 yNGdF/lC0M+PWaPNIAosM9TSf/mWpGAHPbHW8YhpvXH9K0cTEPfppKN/yjQIrQnsW2Er5
	 8qMD+9RBkWgZ7mwZmU1W+vzJ2gJTAAIbkg333Vgnn6+PcdKeRpFUiZ2+RWoYyem0RT7QP
	 uT7wTo0EdNsXMnYTn5Zd5jycDtrvbVJ4vroYTcr1REELAVrEblYDxLD9lN4UwDMhunJ+w
	 +651iOhobOBPXC54hA2kYPqS6MwipDC6LlCjweC9Z2fdqEo5DUbqfhzPnlraqWd8N1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaINmaII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5E606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaINmaII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E3F1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012246;
	bh=3wod+sgSe5AO7Y69Ed0onzp5ruRWZ+rQ/N5b0V7FJ8c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gaINmaIIz94BACd8MVwX4jax5SbtJkoMB7VCRYGUDBAeOzYyL5EyCJGCRS2VmZr4R
	 9qG4vPOna4HKKsF8ogFVnb60or92i133pVBtnvKnWt+CvRYvp8vi/c+8wW+Zni74mj
	 iXYaWs0/oLU4oOZOELP+wmpi2kDsi2xDN6OGOE1Ix9ZM97ySRuLIn+MdqXtdWaQfp7
	 13U2pphoIztkqCZFu9oUGLiCDonEjaKiMBmKQy4QWrGBd8yYcfXPX+cajKGRsz2QAT
	 Tq/ScU8cc8OvuPkB0ohknbQ8gCLg13jYj2Db0ukFPxKFHUxD0038gP0XiaZ+S4NoM6
	 KjyhQoclv1lnQ==
Message-ID: <sashiko-outbox-221210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] KEYS: keycrypt: Add the aes256-gcm-stream
 algorithm
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261118141257.627441-1-giometti@enneenne.com>
References: <20261118140421.584086-1-giometti@enneenne.com>
 <20261118141257.627441-1-giometti@enneenne.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:30:45 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> This patch is a proposal on its own: nothing before it needs it, so it
> can be discussed, or left out, apart from the rest.
>=20
> aes256-cbc does not authenticate what it decrypts, and a file or a
> transfer longer than one call cannot be sealed with a single AES-GCM
> invocation without buffering all of it, nor decrypted without
> releasing plaintext before its tag is checked.
>=20
> Add aes256-gcm-stream: the STREAM construction (Hoang, Reyhanitabar,
> Rogaway, Vizar) over AES-256-GCM. A message is split into segments
> of up to 64 KiB, each sealed with its own tag under a subkey derived
> with HKDF-SHA256 from the key and a 16-byte salt drawn at
> KEYCTL_CRYPT_OPEN; the nonce carries the segment's position and a
> last-segment flag, and the counter lives in the kernel, so segments
> can be neither reordered nor dropped from the end unnoticed. The
> segments go through a new ioctl, KEYCRYPT_IOC_SEGMENT, and
> KEYCRYPT_IOC_FINAL reports a stream whose last segment never came.
> A tee or hsm backend draws the salt and keeps the counter in its
> secure side; the sw and optee backends implement it.
>=20
> With it comes its section of the documentation, with a file format
> built on it.
>=20
> No user-space consumer uses it yet.
>=20
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118140421.5840=
86-1-giometti@enneenne.com?part=3D9

