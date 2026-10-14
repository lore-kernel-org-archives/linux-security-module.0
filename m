Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDC483BCD
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007132; cv=none; b=QaHncTHsYC7LpESksvJBMfyMUVVHQb9IVgfk64wHmhXFIu8M9Carmtoo7VCA+FUerWCKWOLW1erpjsOWcJuGAXuMORz3eFIBNOd9jonLsrQGALBwMZbPeiYCeMuzTKCdMNRxahy0ivKw4J9GhTayhrhS3VGqxHPZv/GtQUq1mJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007132; c=relaxed/simple;
	bh=7J8Xc/dC/Zkk7YRGvWKtULHxn/PynhaUwW45Cs8Nvww=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=e5CFDu3oynzgpnuYtBpweJVvqWa4vvYEDxz2pHvsHbOZED/GVGuveHeu0Dsz2Jhv5if8w8639a1W92Bw1xfbu77mLcH2sL1Ot8pt1vn0rVRsYOqMSQKyTY9uuWQ7Lt0mtq/0dJ55o1Afl/LPf8LdR2gff3T7SzMesePYjv/8zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTrOTGlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTrOTGlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5285E1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 19:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007129;
	bh=7J8Xc/dC/Zkk7YRGvWKtULHxn/PynhaUwW45Cs8Nvww=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CTrOTGlFLbzjGxSkiyFwEw65m/R6ZHJNiGZcPDEdh/N3myyYNm8pUd6x4ubhthE1r
	 e0TYHb52BFHFOwnWQl+qvl87Lb08XHGWT5N1sc6fxdGg/jfFm1ZdqDBrtCtwiXK2sY
	 udSeVf+XAlKuDZh95pz2XAbAZ/xkUZjMZPAjAq8rEdccyCslDo8JTTd8IRBYbwNyk7
	 WrMLmg97bN0Q+rL8oKPGElnjtmvraQrjJQ33R+Ua0jJwqSJ2uZQnFwLijppLMkyrmX
	 0W2ET9kTzHXPJAxbub0KoyAcBeV9x+UNogBKDjnuBYOyspej5uQPlnTE39Q1wRqkE8
	 CJFcQUfIKJtvQ==
Message-ID: <sashiko-outbox-171810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] apparmor: fix cred UAF caused by
 begin_current_label_crit_section()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014193517.24940-1-artem@trailofbits.com>
References: <20261014193517.24940-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 19:45:28 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Jann Horn <jannh@google.com>
>=20
> [ Upstream commit 3f4ae5fab613dca01d6a2a8210dd832e009fcf47 ]
>=20
> AppArmor's begin_current_label_crit_section() is a scary function called
> from lots of LSM hooks (in particular VFS/socket-related ones) that checks
> if the label referenced by the current creds is marked FLAG_STALE, and if
> so, attempts to use aa_replace_current_label() to replace the creds with =
an
> updated version that uses a new label.
>=20
> The first problem with this is that it would directly lead to UAF of
> `struct cred` if anything in the kernel takes a pointer to the current
> creds and accesses these past a security hook invocation that replaces
> creds, like so:
> ```
> [ ... ]
> Fixes: c75afcd153f6 ("AppArmor: contexts used in attaching policy to syst=
em objects")
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014193517.2494=
0-1-artem@trailofbits.com?part=3D1

