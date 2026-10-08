Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10B4B8284
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470651; cv=none; b=uLGtPLOShHlcB5GGcONnzFDWVdB+Tp7A6ZfWKJz2x6R1bkOsBWP0kxl7zuvGykCZjfsvcKl/GBBWLVImxzGzzqc//vjTy1pJSif/HGPPLEMLtWGxwnyh+agXNy49APoMUqpsqPGGBlCr385oF/iaMMgFJyYf62sLbCe0uu5DvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470651; c=relaxed/simple;
	bh=gsZQIjL5nxy/Oezo5xM1QnQ52J/8WcMvUkciz1l9syU=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=K8nQH2zHILqKHqh0UqzhNqKDZzz+5CfgM/vv+wiQMh1jMXiSzycyFk1P1VQ/v47RvjbaD9hgiS3ELxNkOAJgDk7NHID5AOea9+hCTmGFdecxZLbL39p8/K0nHiSr2wJgk9RCsd6erPHvPghWujvwAi+Wd1ZQrWzp/kUEoOaihpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF5IpuVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF5IpuVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2631F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470643;
	bh=2qVJMrWpxZBcHqZkw88b3qLMOvLH94PizczDzlQCBOQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hF5IpuVr7dL6L3DnXbpgNZIpTi22+SUtJ25FVOnqTygFUJH+ckH4eP2fPC0P1SvX0
	 sKwNW1pwans/QtCsix2Ep25QoVpDHo8z5Ln4HhF3KMTpWVv+PaXNH354zEUGGV2uLm
	 KwKrDswkCbSeOYFESL33g4qm/j0FGr8DlNX1xXJ3vCBCrLvyC0jRo5u1srYyHJGLh1
	 eS09W7tPpuKIeFR0kICyP3CUQNKQ0c8LU2Vnwdh9nFNmTtek7GDF65tuXG8iXpWITY
	 Uh/KwGfGeRDeHOXH2rwAAnHYqweRsgsaQ0axu9cMGxHJ4FhAueH8ZpS2ign+Tk5OY2
	 InkRW87LoBGwg==
Message-ID: <sashiko-outbox-164322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/27] selftests/landlock: Assert audit initialization
 in fixture setups
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-12-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-12-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:44:03 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: cascading test failures due to skipped teardown on AS=
SERT_LE abort
--

commit 924f6036b77ebee776959fad4d5c2f2f2ab050ad
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Assert audit initialization in fixture setups

This commit replaces EXPECT_* with ASSERT_* macros for audit initialization
in Landlock tests to prevent tests from proceeding with an invalid audit
file descriptor when initialization fails.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 9884ce9917db7..779a7bf477a95 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -7508,7 +7508,7 @@ FIXTURE_SETUP(audit_layout1)
> =20
>  	set_cap(_metadata, CAP_AUDIT_CONTROL);
>  	self->audit_fd =3D audit_init_with_exe_filter(&self->audit_filter);
> -	EXPECT_LE(0, self->audit_fd);
> +	ASSERT_LE(0, self->audit_fd);

[Severity: Medium]
Will this change cause cascading test failures when audit initialization fa=
ils?

When ASSERT_LE fails (for example, if auditd is running), it aborts the
fixture setup immediately. In kselftest_harness, this causes the child proc=
ess
to exit before clearing _metadata->no_teardown.

In the parent process, the teardown wrapper checks
!__atomic_test_and_set(_metadata->no_teardown, __ATOMIC_RELAXED). Because
no_teardown remains true, the parent entirely skips FIXTURE_TEARDOWN_PARENT=
().

Since prepare_layout() created TMP_DIR on the host filesystem prior to the
setup failure, skipping the teardown leaks TMP_DIR.

Subsequent tests that use prepare_layout() will call
create_directory(..., TMP_DIR), which asserts that mkdir(path, 0700) =3D=3D=
 0.
The leftover directory causes mkdir to return -1 with EEXIST, triggering
another assertion failure.

Does the teardown need to be called even if audit_init_with_exe_filter() fa=
ils,
or should we retain EXPECT_LE so the setup completes and no_teardown is cle=
ared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D10
