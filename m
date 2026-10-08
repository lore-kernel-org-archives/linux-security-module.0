Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330D3932FC
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470134; cv=none; b=hVfusQEz0uEE0Poj7RoczmUSEfvk35i6HQZ3MPqnYWFIVukaRycDCGw/6JYuFRDQecU9aGPyzDolYRoij7RN6OL+iljMGyR51jT7egJRQfeK2zduyZtL/Gf1I6yXg6WsydZF7NBz4g+2kBo86eOkwI1mKI73YCkY36evLJBppOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470134; c=relaxed/simple;
	bh=lX+Bc+/dahCpo8xNHyKEy3/4xKPxxJTV3OPA3xRb4pI=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YVpABzgrgPicyulTmYWx5xeITqP92mL45KXfK6h+h46n8tALd8SWDGQQ9OOB8IUgRRz4JS78y062f7NRMCi8FvslRnSYPUzJxBk22TrOyA9JABKcfChlJUMbqWdOtcTuYGvOKYFqxA4aiT5+PeeqFgL3xRDPu920D85tVH9/ygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1+8cicO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1+8cicO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC391F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470133;
	bh=xkvqjBVNF2AwXTqqrJnY2h1M++gmrAu7gccWQjSq8DQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=N1+8cicO8K86sgqqVE/8IhzKHfjjJtdoqQnXcJkHWIT/vhLzY1tYmmws83UgEzh+o
	 tmLjwFsVFAQO8f/bInb6cCamZ+FFYHbMGEoFz+x/E0Oj1n7uGs3p7CVEC452a1Zmma
	 ODc9IwL4/T1eLz9vCemVzqduc6PPhoJgjZ0fUUgmhZJDEhCchTbHvkMYpEVp7ry7Sp
	 FT9mumr2t98nqZxlpZfsXg7nsSYvvpdEyAZ1iVi6m2zWVDbTvgUk7K1f4OnPkSUV9z
	 eb88aTb1BLO7BNW4KWmptkiYJTYCgGw2n3wR9bHnd2QdMfqHwEp7sEusO1Vs/j4b3a
	 60dC4WT/dLjZw==
Message-ID: <sashiko-outbox-164304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/27] selftests/landlock: Assert helper results that
 are used afterwards
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-13-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-13-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:35:32 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Some helpers check a result with EXPECT_*() and then use it:
> cap_get_proc() in _init_caps() and _change_cap(), and
> landlock_create_ruleset() in drop_access_rights(), create_domain() and
> create_fs_domain().  On failure they pass NULL or -1 to the next calls,
> which then fail with misleading messages.
>=20
> Use ASSERT_*() for these checks, as create_scoped_domain() already does.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D11

