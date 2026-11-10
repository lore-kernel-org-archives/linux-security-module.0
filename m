Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317107;
	b=2gFK0bNuHlfQbw48UTKEKAfRPi2upKteM2AlwLZMQg4lNQnIs0DvXUua3ulf0a0sCl8U
	 Vi/Y4ieaWmB4rroptu608p3xgzXxCAZxMLV319pG6vh4a7oZ530XL4UP2QutMb5VvtkoK
	 Qfi+cou3Zoo3qwyu0KMM5kKf1v7GBfKpWu0FDynp1xi8dccZ5gLneOSyvylM7bj946V99
	 NlsLRTkT9g7uqiaHQC5crwkXJBqY99M6XLMCwoFSn5l1zH0+V7MSnTSFchiAc/B2POYFk
	 qAWGkUFYUPVd4COkCslUlSk+xW97lUsvX7ltmhMyOl4yAgIQB4tiQ1nndShcFMH9b2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nwL7oDo/fKRhHSTpx0EARUKGcl/3YU41/DAa+ZbusHY=;
	b=oVTQREfmBOyOYRNrRi+nQl/mKv06t+IHPrbMaNvlVAEerygFMss/EzevHLlnpHeOljs+
	 g9tZ/FHo82lpUFa4iJvudd8oRCiSg7AII9vfpQugnNFgbUW3dLkk182h6M/QNrJpoxcde
	 koMrVCNq1x4A6sfj5Kceeoyl//TGhytCFFSKxJyRmgDMl4vaEdT9ABf9Bbwm2a36mPbpx
	 VmE2kC8qkrzY9JuIF7zaDQiSzG56C/0T+DuwF4mXpUSY8SydMZdLwOIr9cdI5BtmmuTHL
	 DOA7u+DIMf0A7qLyVN5Q2pLg+GHCs5xZe4/+ueoYNMxHZoe6w1BWHyIpmGu031quFLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhlPEkiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067C6606A76D;
	Tue, 10 Nov 2026 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhlPEkiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF91F0089F;
	Tue, 10 Nov 2026 13:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317106;
	bh=nwL7oDo/fKRhHSTpx0EARUKGcl/3YU41/DAa+ZbusHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhlPEkiIeerYxLrkLz8nTi63G88j7o3tc77e1yeNnBHWxEDEQx9QL/7FNnRD7ismC
	 DNB87DSr+U5uxBvq/BG/xjGo7wvjedV4AOupwLqGf/+PFw1FUQ8Nxwyp12OrOO3x1G
	 9ce+a/bje/G+gRVR1oMNTNxxpqZtefE/iemDPfKPQQSxwI2SW7NaWQ02KHEpeQQh9h
	 +lLejiQs7RZ0xwAcB+Zm18oa98B23cYTWO+CnPP/xu7+hy2KPI3Pfcx8/e8PgZMOxX
	 JpS14g9UE86aNnPz2XbzdMYQDP1hAAoMx7y8AnDWjRlBjeCT3s4e8hnQl3U2QSsSPS
	 8Rdg2FhcPlS9g==
Message-ID: <sashiko-outbox-207119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next -v2 8/8] selftests/lsm: add lockdown securityfs
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261110132818.2231593-9-caixinchen1@huawei.com>
References: <20261110132818.2231593-1-caixinchen1@huawei.com>
 <20261110132818.2231593-9-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:25:05 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/lsm: missing $(OUTPUT)/ prefix in run_lockdown_test
  Makefile target
- [Low] selftests/lsm: skipped downgrade test and duplicated setup in
  lockdown_test
--

commit 01625a3d98192538ac4075199b3f0186f4e7ed21
Author: Cai Xinchen <caixinchen1@huawei.com>

selftests/lsm: add lockdown securityfs test

This commit adds an opt-in kselftest for the /sys/kernel/security/lockdown
interface along with a shared read_file() helper in common.c and enables
CONFIG_SECURITY_LOCKDOWN_LSM in the selftest config fragment.

> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftes=
ts/lsm/Makefile
> index 3f80c0bc093de..3be7aa42761ce 100644
> --- a/tools/testing/selftests/lsm/Makefile
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -8,10 +8,18 @@ LOCAL_HDRS +=3D common.h
>  TEST_GEN_PROGS :=3D lsm_get_self_attr_test lsm_list_modules_test \
>  		  lsm_set_self_attr_test
> =20
> +# lockdown_test changes the machine's lockdown level, so do not run it
> +# by default.
> +TEST_GEN_PROGS_EXTENDED :=3D lockdown_test
> +
>  include ../lib.mk
> =20
>  $(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
>  $(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
>  $(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
> +$(OUTPUT)/lockdown_test: lockdown_test.c common.c
> +
> +run_lockdown_test: all
> +	$(call RUN_TESTS, lockdown_test)

[Severity: Medium]
Does run_lockdown_test fail on out-of-tree builds (such as make O=3D... or
make OUTPUT=3D...)?

../lib.mk prefixes TEST_GEN_PROGS_EXTENDED with $(OUTPUT)/ and the build
rule places the binary at $(OUTPUT)/lockdown_test, but run_lockdown_test
passes a bare lockdown_test to RUN_TESTS.  When OUTPUT points to a separate
directory, tools/testing/selftests/kselftest/runner.sh looks for
./lockdown_test in the source directory and fails with "Warning: file
lockdown_test is missing!".  Passing $(OUTPUT)/lockdown_test (or
$(TEST_GEN_PROGS_EXTENDED)) to RUN_TESTS avoids this.

[ ... ]

> diff --git a/tools/testing/selftests/lsm/lockdown_test.c b/tools/testing/=
selftests/lsm/lockdown_test.c
> new file mode 100644
> index 0000000000000..fed050551cff2
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lockdown_test.c

[ ... ]

> +TEST(lockdown_no_downgrade)
> +{
> +	char before[128], after[128], level[32];
> +	const char *lower;
> +	int ret;
> +
> +	ret =3D read_lockdown_status(before, sizeof(before));
> +	if (ret) {
> +		if (ret > 0)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
> +		ASSERT_EQ(0, ret);
> +	}
> +	if (geteuid() !=3D 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
> +
> +	if (!strcmp(level, "confidentiality"))
> +		lower =3D "integrity";
> +	else if (!strcmp(level, "integrity"))
> +		lower =3D "none";
> +	else
> +		SKIP(return, "kernel is not locked down, nothing to downgrade");
> +
> +	errno =3D 0;
> +	ASSERT_EQ(-1, write_status(lower));
> +	ASSERT_EQ(EPERM, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +TEST(lockdown_same_level_rejected)
> +{
> +	char before[128], after[128], level[32];
> +	int ret;
> +
> +	ret =3D read_lockdown_status(before, sizeof(before));
> +	if (ret) {
> +		if (ret > 0)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
> +		ASSERT_EQ(0, ret);
> +	}
> +	if (geteuid() !=3D 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
> +
> +	errno =3D 0;
> +	ASSERT_EQ(-1, write_status(level));
> +	ASSERT_EQ(EPERM, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +/*
> + * This test raises the lockdown level and cannot undo it, so run it las=
t.
> + */
> +TEST(lockdown_upgrade)
> +{
> +	char before[128], after[128], level[32];
> +	const char *next;
> +	int ret;
> +
> +	ret =3D read_lockdown_status(before, sizeof(before));
> +	if (ret) {
> +		if (ret > 0)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		TH_LOG("cannot read %s: %s", LOCKDOWN_PATH, strerror(errno));
> +		ASSERT_EQ(0, ret);
> +	}
> +	if (geteuid() !=3D 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
> +
> +	if (!strcmp(level, "none"))
> +		next =3D "integrity";
> +	else if (!strcmp(level, "integrity"))
> +		next =3D "confidentiality";
> +	else
> +		SKIP(return, "kernel is already at the highest level");
> +
> +	errno =3D 0;
> +	ASSERT_EQ(0, write_status(next));
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_EQ(0, get_active_level(after, level, sizeof(level)));
> +	ASSERT_STREQ(next, level);
> +}

[Severity: Low]
Could lockdown_no_downgrade run after lockdown_upgrade so that a single
invocation of make run_lockdown_test exercises downgrade rejection?

Enabling CONFIG_SECURITY_LOCKDOWN_LSM=3Dy defaults to
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy, so a freshly booted kernel starts at
"none".  With the current test order, lockdown_no_downgrade always skips on
that initial state right before lockdown_upgrade raises the level to
"integrity"; placing lockdown_no_downgrade after lockdown_upgrade leaves the
system in the same final state while testing that downgrading from
"integrity" to "none" fails with EPERM.

Also, the prerequisite checks (read_lockdown_status(), geteuid() !=3D 0,
status_writable(), and get_active_level()) are duplicated across all four
write tests and could be shared via FIXTURE() / FIXTURE_SETUP() or a helper.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132818.2231=
593-1-caixinchen1@huawei.com?part=3D8
