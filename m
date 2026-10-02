Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18734519A3
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945638; cv=none; b=TKCQukybVqIJ0UniHl8jGSBU/LNxgMuz5WMs3QLR3rvXRBT8KSmz75cOXJbAEs4SgIpiloQKJ3pLfN1uBO/ZFVbFNA8mPVwGePeeCXEFK8IziulBcSjFEdwMDBHEMec3SaHCG02bplt0oGwaDUHakDr3UQUjEV+q1SD5VC7XZeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945638; c=relaxed/simple;
	bh=UCe9/tBFCYSQKCiDTCirjXqxSI1tJR1rTxZxoHoI+u8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SKwHvjyUQRaLvOi2QMhfPCzqcS6H+akknkNaSW+STXvHoVcc9ctgge9Yox+ZxRBKt3HpJ/ihz+9aY7CSfNJXIlESKjOi9Vmm78ZyfSl0sGFollAxxOgZ2/XnypoMSgX6wpIBTPBuXQJkOB8ybqeEbKneHXFvdHZ7SW5ywtznr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3XV40hz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3XV40hz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1321F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945636;
	bh=gAFpNxVFctZZbMchz8S05z5hLYLhzpaOfQAQKMtrgdU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E3XV40hz4KhtTdYiHd97reutP3f4DDbLES+FA27a/6u1HMqJ6xdLx78FefD9GMlL1
	 0154iB9a5H7+/GcbrYU0MQpbtNZLBRMst8gQMmIXdQB6GUTbTWG/7eggeQ9YGdi0+J
	 jOEgjgpZ+P2q5o0z3lO88Cr8lCt8ei3wcl4ZEORFqYGvaP3/JQUwe1gZpTujtD3m3l
	 7x/0we2NRbBkxT9CbXOPgIsrGqjla9Fresp3/Y9HHGh51bbPKOPIuXo6gK2HSym4DF
	 Ag1VI+xdP1Vgi0kUxjmwNSTaix1sRV7+B2yeaLWH1btVZ3bB0V/fjP2OLxanPedwFX
	 1klCEsN+p5GEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/8] selftests/landlock: Add capability restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-7-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-7-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:53:55 +0000
Message-Id: <20261002125356.4C1321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/landlock: host hostname modification in cap_without_nn=
p test failure
--

commit 359c59ecc043d1cac20779ee8cc6bc19e3b8e705
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
selftests/landlock: Add capability restriction tests

This commit adds tests to exercise capability restrictions enforced by
Landlock. It covers various standard capability evaluations, stacking
combinations, and non-standard contexts such as enforcing a domain
without no_new_privs.

> diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/=
selftests/landlock/cap_test.c
> new file mode 100644
> index 0000000000000..8673934aac11e
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/cap_test.c
[ ... ]
> +TEST(cap_without_nnp)
> +{
> +	int ruleset_fd;
> +
> +	disable_caps(_metadata);
> +
> +	ruleset_fd =3D create_cap_ruleset();
> +	ASSERT_LE(0, ruleset_fd);
> +
> +	/* Allow CAP_SYS_CHROOT but not CAP_SYS_ADMIN. */
> +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_CHROOT));
> +
> +	/*
> +	 * Enforce WITHOUT NNP: landlock_restrict_self() succeeds when the
> +	 * caller has CAP_SYS_ADMIN (checked before the new domain takes
> +	 * effect).
> +	 */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> +	EXPECT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * CAP_SYS_ADMIN is still in effective set but Landlock denies it:
> +	 * cap_capable() returns 0, then hook_capable() returns -EPERM.
> +	 */
> +	EXPECT_EQ(-1, sethostname("test", 4));

[Severity: Medium]
Will this modify the host system's hostname if the test fails?

The cap_without_nnp test does not appear to isolate its UTS namespace via
unshare(CLONE_NEWUTS) before verifying the sethostname() restriction. If the
Landlock enforcement does not block the operation during a failing test run,
could the sethostname("test", 4) call succeed and unexpectedly change the
test machine's global hostname?

> +	EXPECT_EQ(EPERM, errno);
> +
> +	/* CAP_SYS_CHROOT is allowed by the rule. */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(0, chroot("/"));
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D6
