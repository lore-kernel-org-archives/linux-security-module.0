Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692949;
	b=iz+U5DAD5bZp+fNeB7QGO56N/fi1BOLPVZ4K2aLf+qyywmpBuV21eoNLk97avuOZ/SwF
	 q8j1cfDDxe0b4Vu62lSSYEdwsaZ/SijZr30ts3fT3C84J8BIr6y+DE4dathiMTb+U3dj7
	 QnsEsip+Yi0JV6u/RqZRn/nZXAXLkcUyvHPOMYcLDmC0u8mTLSU0cpiUHLxeNn+WAxjKf
	 MEgh01sSQ/FGBkj7en2iM+btw9fKZBZgwaBL3YXetcB6DmwCqIqdMqOheIUHS4PuHsCJS
	 HKvAcRcL3eJEDSJKcLN53AbKoPgA5N6LK7kttRNqhXpeeSPsEtQbR3WDAqc9dYV1E5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ZWsCqdDjJbg3flsv8IJitGwbDH28gfBXZy7BM1iDS4=;
	b=ScPdiIJ1kd13yH2wbcdlYM7Zi84Fdsvb8cNn849DxN4qgnN/m2ZIsmmMcphtxVv2wXrn
	 xAUxAXUkg6WrsPLAwrc6uWXTaVa1quidokcXBy+0z3Zy1hgwjhRhpohKHuTaLorrAZ7iZ
	 +LBvLe9SBeuvs2PtJ0/+o5Nj5j/TLXUHX28ors/77t5f+EU4RTibHMGE3wCpfxjE/+ckn
	 +8qfAmPZvecnIbFuZxyEZeYQ7VL9FyOo8UsUdcjWbrK9Ypf/Sa7iha90GkBFT3Zjr5ZzJ
	 uCQ9/6pP1jjKefmVCDI1gK5RhwwIlXpdrgiSnetlo0vQ6o8762+XtWMxk4IVPPEqq3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2QptBLs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16784606A324;
	Tue,  3 Nov 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2QptBLs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FAE1F00919;
	Tue,  3 Nov 2026 08:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692948;
	bh=1ZWsCqdDjJbg3flsv8IJitGwbDH28gfBXZy7BM1iDS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2QptBLsJH60a8oa2qsJ8V4CrGhvq4lm50xanCK1TqCFWwVhCQ8dec2oa2D1hi8fG
	 cfQoOb3CWoipm79DwWymM9Klm1szQniVPj/5B8kv0wBdj7KzN22FvFqmK/VJkKrDHQ
	 9AYyNV6L4snPuCQBC60dkC+4DTKpgDzYEOzWdE2yRAsOGZQPsrJCjzqCvL3CI/BnBv
	 XZuj1tdN/PwJXaJa7V3vHWy+UTN+gW7X5QNxNRiRN7PBxf3kr0wXrB5I/ZZNilfwMq
	 QvP/VVosPcuOCMlFBU318GNu6oJalzzmDQzYC9YRz8CulGy/RWGn1TZKqhDu11JDfW
	 pGuSb9GtSKRjQ==
Message-ID: <sashiko-outbox-194791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH -next 9/9] selftests/lsm: add lockdown securityfs test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cai Xinchen" <caixinchen1@huawei.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261103082421.3033195-10-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-10-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:02:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/lsm: duplicated setup/teardown and double open in lockdow=
n_test.c
--

commit 5cebacd6e5feb5064c2370aa4d99aad209688038
Author: Cai Xinchen <caixinchen1@huawei.com>

selftests/lsm: add lockdown securityfs test

This commit adds a kselftest for the lockdown securityfs interface to
check the read format, reject unknown levels, and verify that an already
locked down kernel rejects the current or a lower level. It also moves
the file reading logic in common.c into a shared read_file() helper.

> diff --git a/tools/testing/selftests/lsm/lockdown_test.c b/tools/testing/=
selftests/lsm/lockdown_test.c
> new file mode 100644
> index 0000000000000..35109833da373
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lockdown_test.c
> @@ -0,0 +1,176 @@

[ ... ]

> +static int write_status(const char *value)
> +{
> +	ssize_t len;
> +	int fd, err;
> +
> +	fd =3D open(LOCKDOWN_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len =3D write(fd, value, strlen(value));
> +	err =3D errno;
> +	close(fd);
> +	if (len < 0) {
> +		errno =3D err;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int status_writable(void)
> +{
> +	int fd;
> +
> +	fd =3D open(LOCKDOWN_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	close(fd);
> +	return 0;
> +}

[ ... ]

> +TEST(lockdown_invalid_write)
> +{
> +	char before[128], after[128];
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno =3D=3D ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
> +	}
> +	if (geteuid() !=3D 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +
> +	errno =3D 0;
> +	ASSERT_EQ(-1, write_status("invalid-level"));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +TEST(lockdown_no_downgrade)
> +{
> +	char before[128], after[128], level[32];
> +	const char *lower;
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno =3D=3D ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
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
> +		SKIP(return, "kernel is not locked down, refusing to escalate");
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
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno =3D=3D ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
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

[Severity: Low]
This isn't a bug, but lockdown_invalid_write, lockdown_no_downgrade, and
lockdown_same_level_rejected duplicate the same initial read_file() and
SKIP() checks, root check, status_writable() check, active level parsing,
and trailing read_file() plus ASSERT_STREQ(before, after) check.

Additionally, in each of those write tests, status_writable() opens
LOCKDOWN_PATH with O_WRONLY and immediately closes it, only for
write_status() to open and close LOCKDOWN_PATH with O_WRONLY a second
time.

Could this use FIXTURE(), FIXTURE_SETUP(), FIXTURE_TEARDOWN(), and
TEST_F() from kselftest_harness.h (or a shared setup/write helper) to
avoid the duplicated prerequisite/post-condition blocks and redundant
file opens?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103082421.3033=
195-1-caixinchen1@huawei.com?part=3D9
