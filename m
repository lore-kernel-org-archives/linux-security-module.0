Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A444682F
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367826; cv=none; b=mNOmblsldOkPB/io9EioqUjOGuOpoLS1879qS08p6kRuy8F93jQvpn7WbgUe6/C3tkZN2G7U44JdILKaK2HMCWlT04gDgnptXWpUgm8HtIgwVfxmjGSDj3KVN9NfulsDjpeuwTTJqKcbEN6/p66t5u7o6KELthoHVX/Nn4yStWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367826; c=relaxed/simple;
	bh=8Fb1rx4Ij/Jk6mBacSXPRx28GSfE8CVA8t6kPKiwx3o=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W5JZrbjiuMABmeWfJhL+u2n5NfRlTgI0r4K3uFXe99u0QS2J20fvs1AcTFmLqn1FR9y884iFAnV3xAWH7B8yfVaiS+KYcjPqY4FICuuG9gfXkm4uOK7YIGtfIzeTrwV/UfaSfV9TEQeAGaaUWlXujcwNUBh1uJV46TFlJjUb+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kECcyl9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kECcyl9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA141F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367817;
	bh=f87uv+eVW1bzJ3uYzU/B9CDWR7G1dZoxmfL1aL1l2d0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kECcyl9tk3CEl4XdPiPZ8RVT4YkUIYM+SSJ6/m2VI+BUywvLy+8Ee3pIHS6fGLdfh
	 t1KTPYBwHYU4h4pBoZH3Gt/udR06XNBm0JF6hXaP9MDu1mge+IoChgOpV8O+aFTfE5
	 S3kbwCVWpRG28h5ARunhm0KCxmGRtzAcGxbDrt77EjyCHQG9CsoBIJ8dtIPRSx5vyl
	 lysctryy/mnLv91Z3ZxBmCfOvD+gyc6Rav5MnQRhHjE6AhJws78vJxoFgjP0Ooqiqz
	 gCznN+H1FA4iV0iQHi68fSZksYq/WyKlaWoCR1uxyT3NSZpAXjYw2Jf33pCDFLoHx1
	 enr7gyC9X+X6g==
Message-ID: <sashiko-outbox-162841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] landlock: Wrap per-layer access masks in struct
 layer_config
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-3-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:10:16 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The domain layer FAM stores struct access_masks values directly, while a
> ruleset stores the equivalent single mutable value.  Per-category
> permissions need additional per-layer data beyond the handled-access
> bitfields.
>=20
> Introduce struct layer_config as the common value type.  Keeping the
> handled bitfields in its .handled member leaves struct access_masks as a
> lightweight parameter type for functions that only need those bitfields,
> while the complete layer can be snapshotted with one assignment.
>=20
> At this point struct layer_config only wraps the four-byte access_masks,
> so it does not grow the per-domain allocation: the maximum 16-entry FAM
> remains 64 bytes.
>=20
> No functional change.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
> Reviewed-by: Tingmao Wang <m@maowtm.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D2

