Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AC3394497
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850753; cv=none; b=djH0h5w+EkzefQbIHssstn6quXDFgetHdJeB3knX7MLyOjMjBoBnoNpHsjvfoWWxc6fJj3a15YeWjdgaI8DkZfdhfRWetMuayR0OZ6fsVSSihkk0pZ1vXl+3GtbQZFje4Wd5sbmS8TzAxUgMgGrZtKyDcnP0bb6ALn5sdAPxFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850753; c=relaxed/simple;
	bh=duW3HXs47UWH6DIQ6b8McE0/vesOXj3LxEX4wwIrJw8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0v3qaGNcnchlDYq9fP7ANpcL7Gk/sGgf/GBCuY/OyF5VAc5QkAhy/V/zsdPlSYn2AWG5tD+kP41sjnnaOwi8nQ5HAHh9wbscdOQGMcGAzhdVYXu8KQs2CpifBgFlX/lk9ICxgT0d40uEM4l1CqNoSgpY6beyg/xNoS2uKBcM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZgF7FGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZgF7FGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44241F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789850749;
	bh=/Ey+vrpqFrN1Mqf60u98DdI1GeDrDrVUF+yz+nJYEpo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=dZgF7FGKUF85UCBdBNuJPlhncCPO3Ck3o/RhIYc40AfQk1sVx9w9eDO973BTwW0Xd
	 8NVgsRcrkRWRSG/BwlwEHrhku/2CroxB+RSInqFT7PsDztzwXUKjpNcRn/DEL+v19L
	 J6+9eCyknqA82sCGudJ5yAJbalk8ood3qcW7ZosP8CAeuC2reovTXDr8cERbd+AEgj
	 HYLPi32j/PS7pfhtbfvqt7gZvUkoNnFSbuSDxgY+bN0iVd2uqk9bFcOBE1vLuvt73S
	 C1iHqve+R2QjAYEwAhQYu0ap6RdfY8zPRqKumBV7wxW57/U6Odl2YBWtyXeGWhZNEO
	 Wss4TpRGTitbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: reject descriptions exceeding U16_MAX in
 __key_create_or_update()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919203511.2580732-1-benquike@gmail.com>
References: <20260919203511.2580732-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 20:45:49 +0000
Message-Id: <20260919204549.B44241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> struct keyring_index_key stores the key description length in a 16-bit
> field (u16 desc_len), and __key_link_begin() enforces
> BUG_ON(index_key->desc_len =3D=3D 0).
>=20
> While add_key() bounds explicit userspace description strings to
> KEY_MAX_DESC_SIZE (4096), when the userspace description is NULL or
> empty __key_create_or_update() delegates description generation to
> index_key.type->preparse(&prep) on the payload (up to 1 MiB). Key types
> such as "asymmetric" (x509_key_preparse()) construct prep.description
> from the certificate issuer, subject, and hex-encoded serial number,
> which can exceed 65535 bytes.
>=20
> __key_create_or_update() then assigns:
>=20
>         index_key.desc_len =3D strlen(index_key.description);
>=20
> without checking whether the length fits in u16. When
> strlen(index_key.description) is 65536 (0x10000), index_key.desc_len
> truncates to 0 and immediately triggers BUG_ON(index_key->desc_len =3D=3D=
 0)
> in __key_link_begin(). Lengths above 65536 truncate modulo 65536,
> corrupting keyring hash and comparison lengths.
>=20
> Reject empty descriptions or descriptions longer than U16_MAX with
> -EINVAL in __key_create_or_update() and key_alloc().
>=20
> Fixes: 16feef434017 ("KEYS: Consolidate the concept of an 'index key' for=
 key access")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919203511.2580=
732-1-benquike@gmail.com?part=3D1

