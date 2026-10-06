Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0515B37C91E
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280643; cv=none; b=UbpZn31Fiu+58e8u/gnhkMYcPu7NHAGiJFDF7rKeqaU0xWEjHGlhYVD5Y9q2lkmWwv6Am4HEdRzM5slkSZajq6KJSttoap5xn7dAC+qMBE+49zeztSIXrxdOY2f6Kd0fTTwd1D03D5LAU2QiwV88dBcqWgUsy2ZOZA0dGfviF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280643; c=relaxed/simple;
	bh=5FvX3R3n4RdU9wFxznbPNeNOZI/GS9a34u0SrJPI0AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHo/NsobH4USKUeSivAw8hs3RIDkeqGABjEXP7nv2pvMJgbUlvifRzdezILF3e6xbM8VU5CNB+xPoUXc4ckzeNlAyNd0ZTHPbBq0+ycGVVYucvF65VJURlGL8libHn/kjEiEaOdKi/sxBvLUekwFe6JKqqKJOtai/O7uMBKaNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZtVuWqox; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZtVuWqox"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hzWrR4sTgz11FR;
	Tue,  6 Oct 2026 11:57:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1791280631;
	bh=ZF+MKPbdq/xFeDXJK7jHWQeOjWVlrjdMKc5KKTcUjl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtVuWqoxufXOtjmhAgOrQEUwevtgNtcGMa3UmuZq5UhjSl/SHNwdnh5rQFetxDPGj
	 YvIYAvuYaaBMVIdT0RMW9ajS3OAqsBBkGBCrDoSvUZ6eXc1ue6HQ/9S5Rg7imxoeBA
	 HrXU2cY4rKSIZuI3A9YT528FVDY2FXTwi2UECeVo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hzWrR0NT2zt5g;
	Tue,  6 Oct 2026 11:57:11 +0200 (CEST)
Date: Tue, 6 Oct 2026 11:57:10 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 6/8] selftests/landlock: Add capability restriction
 tests
Message-ID: <20261006.Aiwohkeel3ee@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-7-mic@digikod.net>
 <20261002125356.4C1321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002125356.4C1321F000FF@smtp.kernel.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 02, 2026 at 12:53:55PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests/landlock: host hostname modification in cap_without_nnp test failure
> --
> 
> commit 359c59ecc043d1cac20779ee8cc6bc19e3b8e705
> Author: Mickaël Salaün <mic@digikod.net>
> selftests/landlock: Add capability restriction tests
> 
> This commit adds tests to exercise capability restrictions enforced by
> Landlock. It covers various standard capability evaluations, stacking
> combinations, and non-standard contexts such as enforcing a domain
> without no_new_privs.
> 
> > diff --git a/tools/testing/selftests/landlock/cap_test.c b/tools/testing/selftests/landlock/cap_test.c
> > new file mode 100644
> > index 0000000000000..8673934aac11e
> > --- /dev/null
> > +++ b/tools/testing/selftests/landlock/cap_test.c
> [ ... ]
> > +TEST(cap_without_nnp)
> > +{
> > +	int ruleset_fd;
> > +
> > +	disable_caps(_metadata);
> > +
> > +	ruleset_fd = create_cap_ruleset();
> > +	ASSERT_LE(0, ruleset_fd);
> > +
> > +	/* Allow CAP_SYS_CHROOT but not CAP_SYS_ADMIN. */
> > +	ASSERT_EQ(0, add_cap_rule(ruleset_fd, CAP_SYS_CHROOT));
> > +
> > +	/*
> > +	 * Enforce WITHOUT NNP: landlock_restrict_self() succeeds when the
> > +	 * caller has CAP_SYS_ADMIN (checked before the new domain takes
> > +	 * effect).
> > +	 */
> > +	set_cap(_metadata, CAP_SYS_ADMIN);
> > +	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
> > +	EXPECT_EQ(0, close(ruleset_fd));
> > +
> > +	/*
> > +	 * CAP_SYS_ADMIN is still in effective set but Landlock denies it:
> > +	 * cap_capable() returns 0, then hook_capable() returns -EPERM.
> > +	 */
> > +	EXPECT_EQ(-1, sethostname("test", 4));
> 
> [Severity: Medium]
> Will this modify the host system's hostname if the test fails?
> 
> The cap_without_nnp test does not appear to isolate its UTS namespace via
> unshare(CLONE_NEWUTS) before verifying the sethostname() restriction. If the
> Landlock enforcement does not block the operation during a failing test run,
> could the sethostname("test", 4) call succeed and unexpectedly change the
> test machine's global hostname?

I'll fix these issues.

> 
> > +	EXPECT_EQ(EPERM, errno);
> > +
> > +	/* CAP_SYS_CHROOT is allowed by the rule. */
> > +	set_cap(_metadata, CAP_SYS_CHROOT);
> > +	EXPECT_EQ(0, chroot("/"));
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002124409.1277970-1-mic@digikod.net?part=6
> 
