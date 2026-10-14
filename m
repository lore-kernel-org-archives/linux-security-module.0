Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F348C41B
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967302; cv=none; b=J+wT+D4Eh+2LrEwmH4SIAKOkiiY+ZtEv3ujW/J8OSuHIkIL/GwKmZYC8AyhyVkE84jl0s7Rz6z6P58ZI1ZzWLEyJ+R+ATms8eOgNnjIpyprKm9MjmyaBxIT38BTiEk6/425fENE5IX8B+JYgMxOd+1C7xXFNT6Fpp+HM+w7ejHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967302; c=relaxed/simple;
	bh=5LZT71aanCKDQxN59iR1Hqs5kv0pIxFAbu19s9KoaEs=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=I1s1etbNv9alesmlBcuOfG1Lmt42B1DTJmD4CFS4gdc4sxb6JMmrRoyl9SB4wbLxoq9VwecA+4f6ow1bQyGgq+thVwVKohDtgzeQXvSvGak6EVCYtXFsyqNVn9LRF9QEj/H3H9RNvZx53jmwPNrDQ4bJxbTWuc9MrNkhpNKPPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgRu+mtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgRu+mtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6AC1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 08:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967299;
	bh=6GtXJwo0bcAEFfgEogPe/GVkxAqgy2/ibSYATFxjXwA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WgRu+mtNg+9pqSZ90zaCczkPPIik2PxRHaapQY7/hKHRV8ytgxJAjm/gOdMgnP4LR
	 89RemNbA/dMedHoEdQBz/HGV31DIg9JujXcsFCdriXunhBdK9YFGLv2vmmKGG83lz/
	 GqjPyGurRB2VBkswRpgJhMLJ7VdpVxBoS6GVh7sSIhWMRl8/1yWtG97wmS6O3dudKL
	 OuR7gxiOz4YqqfKm8REm299Ep5kZyz/tycnUu2p4+i3aDKaN25xLKPH0ZNrIihY6mX
	 tt2A+tkFPtSFGwFvSkeyFLm1G+ixJX6STaD07vX2RZNyolgi/3d9kpR+S1P4q0KcXs
	 RctiyMrKFJzFw==
Message-ID: <sashiko-outbox-171031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/8] selftests/landlock: Add namespace restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014082718.1435842-6-mic@digikod.net>
References: <20261014082718.1435842-1-mic@digikod.net>
 <20261014082718.1435842-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:41:38 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: comment for user_unprivileged variant contradicts kernel=
 behavior and test assertions
--

commit c04f6fe328bef28c5a3925e2b7cac5095784c173
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Add namespace restriction tests

This commit introduces comprehensive tests for the new namespace use
permission in Landlock. It covers namespace creation via unshare and clone,
as well as entry via setns, along with their interactions with capability
restrictions and audit logging.

> diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/s=
elftests/landlock/ns_test.c
> new file mode 100644
> index 0000000000000..f5d4b86edd303
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/ns_test.c
[ ... ]
> +/*
> + * User namespace creation while unprivileged: the process has no capabi=
lities
> + * but unshare(CLONE_NEWUSER) is an unprivileged operation so it still s=
ucceeds.
> + * The Landlock rule allows it.  For setns, the capability check (CAP_SY=
S_ADMIN)
> + * fails first since the process has no capabilities, yielding EPERM.
> + */

[Severity: Low]
Is the documentation for the setns behavior accurate here?

The comment states that the capability check fails first, yielding EPERM.
However, because the test targets the process's own user namespace
(/proc/self/ns/user), userns_install() checks if the target namespace
is the current user namespace and returns -EINVAL before any capability
checks are performed.

The test implementation correctly handles this by forcing the expected
result to EINVAL for user namespace re-entry:

TEST_F(ns_create, setns)
{
        ...
        if (variant->namespace_types =3D=3D CLONE_NEWUSER &&
            !variant->expected_result) {
                expected =3D EINVAL;
        ...

Does the comment need to be updated to match the actual EINVAL expectation
rather than EPERM?

> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(ns_create, user_unprivileged) {
> +	/* clang-format on */
> +	.namespace_types =3D CLONE_NEWUSER,
> +	.is_sandboxed =3D true,
> +	.has_rule =3D true,
> +	.drop_all_caps =3D true,
> +	.expected_result =3D 0,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014082718.1435=
842-1-mic@digikod.net?part=3D5
