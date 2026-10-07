Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38B47D93E
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368592; cv=none; b=NhdUlDi7v/E+k3cOhPAZcVhzHko2kJVB7+AHHw23qE4MKxAzwORAMS98UkijX56tczkkyYwLAh9nB8NVW77JRg16R6QXnAuSn+qFjpKRyHVIPtiQp1aFcoLhxMX7Nmfp8yXTIgMWfMmhMJHxccUjFlwYS94Gag6i910UtIXIS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368592; c=relaxed/simple;
	bh=7LXa9jAIWaJicEpLRNDp2oa9EShQMNavouOLnu8HwHY=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z2t26fghDNpdQasjJDHajgbEPdW1CFb//Tw1rJgWA0bqIJCR5UngVb+iCp3xG/vy/56XpmsP/PjZRAL1ij9mAgEP3SiwbOVuPYNRoK0vw0M2AEH27IB3GuXlKZC+vMjeVoIhwVA1+UfrBJxYD2hHusnrNK0zieC683x8tL2M+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkpPlKNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkpPlKNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619281F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368582;
	bh=uZ7xKmnQCKm8x9X1CiEV8/ykCfkQxlE7KqUe5JID2EE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IkpPlKNGx5L/G8Ttnw0DBxHt2F4vNBFETdBxM57aCbX8w/0gCkw+2JLgA7M3/bX5O
	 w7lDcVMlp/oCIiChPVXbmVVx0p+fKVAnEZw9us8pRivgIOcl5DHQ3i9lL9gDNCLBPI
	 Zoz79705zBcPMmwp9OuEQ3ohofAA+4FqCoEzCnb8mdNobPgBy0wJV2N/aMvXqRMYX1
	 KhI2NRUCrAZRiO9VVT72wjfdpa9x7gtrgb1O4tObipp3E3O9Orj0h0UqzD4BfQTSs1
	 E2jhM8zq9ognGHDVKI7pBzwgmNkfXjTHRS9pI+2rk/FMwIUawiheIVHNDTycfg7J/D
	 CKSiDXEBGb7TA==
Message-ID: <sashiko-outbox-162856@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] selftests/landlock: Add namespace restriction
 tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-6-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-6-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:23:01 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] selftests: Build failure due to missing AT_RECURSIVE macro defin=
ition
- [Low] selftests: Missing clear_cap() for CAP_SYS_CHROOT in combined_cap_n=
s test
- [Low] selftests: is_in_init_user_ns() misidentifies user namespaces in un=
privileged containers
--

commit aa1731ea4300b766831441aec03fce370fdad94e
Author: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

selftests/landlock: Add namespace restriction tests

Add tests covering LANDLOCK_PERMISSION_NAMESPACE_USE (namespace creation
via unshare/clone and namespace entry via setns) and its interaction
with LANDLOCK_PERMISSION_CAPABILITY_USE.

> diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/se=
lftests/landlock/common.h
> --- a/tools/testing/selftests/landlock/common.h
> +++ b/tools/testing/selftests/landlock/common.h
> @@ -130,6 +130,29 @@ static void __maybe_unused clear_ambient_cap(
>  	EXPECT_EQ(0, cap_get_ambient(cap));
>  }
> =20
> +/*
> + * Returns true if the current process is in the initial user namespace.
> + * Compares the readlink targets of /proc/self/ns/user and /proc/1/ns/us=
er.
> + */
> +static bool __maybe_unused is_in_init_user_ns(void)
> +{
[ ... ]
> +	if (self_len !=3D init_len)
> +		return false;
> +
> +	return memcmp(self_buf, init_buf, self_len) =3D=3D 0;
> +}

[Severity: Low]
Is it possible for this check to misidentify the initial user namespace when
running in an unprivileged container?

In a container with its own PID namespace, PID 1 refers to the container's
init, which shares the container's user namespace. This causes the function
to incorrectly return true.

This can result in the test proceeding and attempting host-only operations:

> diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/s=
elftests/landlock/ns_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/landlock/ns_test.c
[ ... ]
> +FIXTURE_SETUP(ns_audit)
> +{
> +	ASSERT_TRUE(is_in_init_user_ns());
> +
> +	disable_caps(_metadata);
> +
> +	set_cap(_metadata, CAP_AUDIT_CONTROL);
> +	self->audit_fd =3D audit_init_with_exe_filter(&self->audit_filter);
> +	EXPECT_LE(0, self->audit_fd);

If the environment is misidentified, audit_init_with_exe_filter() will fail
with a misleading -EPERM error instead of explicitly failing the environment
check or skipping the test cleanly.

[ ... ]
> +TEST(combined_cap_ns)
> +{
[ ... ]
> +	/* CAP_SYS_ADMIN use allowed by capability rule. */
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	EXPECT_EQ(0, sethostname("test", 4));
> +	clear_cap(_metadata, CAP_SYS_ADMIN);
> +
> +	/* CAP_SYS_CHROOT denied (not in allowed capability rules). */
> +	set_cap(_metadata, CAP_SYS_CHROOT);
> +	EXPECT_EQ(-1, chroot("/"));
> +	EXPECT_EQ(EPERM, errno);

[Severity: Low]
Should clear_cap(_metadata, CAP_SYS_CHROOT) be called after this check to
avoid leaving the capability unintentionally active for the remainder of the
test?

[ ... ]
> +TEST_F(ns_mount_fd, open_tree_clone)
> +{
[ ... ]
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	fd =3D sys_open_tree(AT_FDCWD, "/",
> +			   OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC | AT_RECURSIVE);

[Severity: Medium]
Will this fail to compile on older distributions due to a missing
AT_RECURSIVE definition?

sys_open_tree() is called with the AT_RECURSIVE flag, but the file includes
<fcntl.h> instead of the kernel's <linux/fcntl.h>. Older glibc versions do
not define AT_RECURSIVE in their userspace headers.

Without an explicit fallback definition or an inclusion of <linux/fcntl.h>,
compiling these selftests could result in an 'AT_RECURSIVE undeclared' erro=
r.

This also applies to the usage in open_tree_namespace:

> +TEST_F(ns_mount_fd, open_tree_namespace)
> +{
[ ... ]
> +	set_cap(_metadata, CAP_SYS_ADMIN);
> +	fd =3D sys_open_tree(AT_FDCWD, "/",
> +			   OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC |
> +				   AT_RECURSIVE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D5
