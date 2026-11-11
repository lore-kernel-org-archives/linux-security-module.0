Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373224;
	b=mOqfD+21sCYLHWfz0vcYeAbWNhX5Hnd3Kol5KiVKMFMw4iwAZrgzOy4eOwvYgIhn2fdG
	 +q2aInhpeBL6D9Rb5cYc+vJUqnk+ZGYmgcy1i5vcoaZRBS9VCIBejhAjgoRnkcNSUwAyM
	 8Px3OzdQyTdDIbI5f3YxVfT+msjNHHWSuewTdzEDWeI1BA+UDgZ9dFXeUrcJKlYRXxcqN
	 zz/xKXDE99syafWc2wiBc1kc7XyEtChJ6pcKm79Zu0glBvQGzKpEqd3y9v4tKSYWAdjwf
	 PKw8oofsDoWdpj+YF4epvxlSPXjt0LO2pIY94HwKAi2rec1Iqexdh5QG+CdEDBBTiIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373224;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VYXs9a9pOBLv4vK2kLXRFNTQmrD6okN777TP7GIqJd0=;
	b=mIcp4oS5xr0jgnLJTEiMO99N6qE7l1IowUU7UsrVGwpLFwkaC8tuYBLObGp0Xttx8AKi
	 u8jNCvS7a+2A3u+Nea8p34WJ6cGQYfVFpaCFCf44g6Z4vJRDybqrlXqA9B7TvfeEnvzmB
	 9XCULXSyIFc0qwDFef8GBtvCeewOULKdKfF2i3awNXmELhmqsXs0hlV7ENylr4QZjI3gQ
	 rzWHwuBmZtO8xOK6uqX/+5txdUxBp6dlz4Fd0/8xCt87llXM5yrgPEdzTNbauSYeirWjv
	 ilki7qOevfrdCTAjcTMSMaldNOT034ZkE0ldEO3LBWI2VDJ+3Qip39eqXkOOsoHnWHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrFMzGcf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB284606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrFMzGcf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA201F0089F
	for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794373223;
	bh=VYXs9a9pOBLv4vK2kLXRFNTQmrD6okN777TP7GIqJd0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BrFMzGcfPSzNWr2zsovJRnLomRrCD0nwg5lqj7vTUrWq0/Z6RQfbFrLviROGoGn/b
	 V//h8ZygHSMafAaCKZFujlgO9YyLSvaFdjuectQ2mqpe9xCbLubQgM2M3wRv2PDfxn
	 2fhrHU3KVYPC5Kn1JFFYJgXjyYbJHldtxbMxnhmiaEsBeDSHzD+re31uAqeoyFtQLL
	 1VLlzMC0cZQsThvW+dgcKOktCSUAdHcme6YC0zdBWeRWaZMOz2hXI7DO6HwlCRa9Kk
	 DFsOZC9mp+m+gSwpLup6HH4zI+b5/GGifFn18ayUFNb8OEayso/LzPaLHLislI8z7u
	 hW9NF48O9zq/A==
Message-ID: <sashiko-outbox-208321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/landlock: Test a long executable path
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261111-landlock-long-exe-v1-2-588cfd174a10@samsung.com>
References: <20261111-landlock-long-exe-v1-0-588cfd174a10@samsung.com>
 <20261111-landlock-long-exe-v1-2-588cfd174a10@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:00:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] selftests/landlock: TMP_DIR leak on audit setup failure in
  fs_test [1]
--

commit f00c6c9b2b3886a7e8767a4a9aab53cc1603cea4
Author: Daejun Park <daejun7.park@samsung.com>

selftests/landlock: Test a long executable path

This commit adds two selftests, layout0.long_exe_path and
audit_layout0.long_exe_path, to verify that a task executed from a path
longer than LANDLOCK_PATH_MAX_SIZE can sandbox itself and logs
exe=3D"<too_long>" in audit domain records.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index f725882fa4a78..738a7175d94cb 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c

[ ... ]

> +FIXTURE_SETUP(audit_layout0)
> +{
> +	prepare_layout(_metadata);
> +
> +	/*
> +	 * No executable filter: audit_init_with_exe_filter() would only keep
> +	 * the records of this test binary, and the path of the executed copy
> +	 * is too long for a rule. The test matches its records by PID.
> +	 */
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	self->audit_fd =3D audit_init();
> +	clear_cap(_metadata, CAP_AUDIT_CONTROL);
> +	if (self->audit_fd < 0) {
> +		/*
> +		 * FIXTURE_TEARDOWN_PARENT() is not called when FIXTURE_SETUP()
> +		 * failed, so we need to remove TMP_DIR to avoid cascading
> +		 * errors with the next tests.
> +		 */
> +		cleanup_layout(_metadata);
> +	}
> +	ASSERT_LE(0, self->audit_fd);
> +}

[Severity: Medium]
This problem wasn't introduced by this patch, but do the existing
FIXTURE_SETUP(audit_layout1), FIXTURE_SETUP(audit_quiet_layout1) and
FIXTURE_SETUP(audit_quiet_rename) fixtures leak TMP_DIR [1] in the
same way when audit_init_with_exe_filter() fails?

In those fixtures, prepare_layout() and create_layout1() create TMP_DIR
before calling audit_init_with_exe_filter(), which has no error-path
cleanup:

tools/testing/selftests/landlock/fs_test.c:FIXTURE_SETUP(audit_layout1) {
	prepare_layout(_metadata);

	create_layout1(_metadata);

	set_cap(_metadata, CAP_AUDIT_CONTROL);
	self->audit_fd =3D audit_init_with_exe_filter(&self->audit_filter);
	EXPECT_LE(0, self->audit_fd);
	disable_caps(_metadata);
}

When audit_init_with_exe_filter() returns a negative error (for example
-EEXIST when auditd holds the audit netlink socket), EXPECT_LE() marks the
setup as failed and skips FIXTURE_TEARDOWN_PARENT(), leaving TMP_DIR on the
filesystem and causing subsequent tests to fail in create_directory() with
EEXIST.

[1] https://sashiko.dev/#/bug/linux-e22dd50d-22f3-469c-81cf-fd03bb763237

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-landlock-l=
ong-exe-v1-0-588cfd174a10@samsung.com?part=3D2
