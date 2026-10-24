Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878079;
	b=Jx+vcvjfQEfvCw71h5MTdtm39S1z7mw/c+yuWAyl7AEIamhuDPqfjleewx2PH01qQzU6
	 NqRg16bSq0Vj9/AMp5Z4pELpiMJkpDWvRaelLUgqYI1XJlxwt8ht3F478PoPeDUPd++9o
	 BjY14jnAxrrDh0WBvIwwCoSG0cZuFWduWkGDP5x5Z6+E6g6E2KlQ4sfppP/1DSoR3RGxn
	 jVhwfHQU7DA8pEmWnE+FpSn0tdvLiTB2cAJSooYMFPQrCvjtsqD0R62lQLBJaJ6ACMxZE
	 BoxulMn7cLf/BJ8OUuvc4/VKc995dCI4CFT9KvayofFF7mVc1ym3IKdCAmZ3bFz1VAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ON1QD05m23Va9f6ugEB9I4fdghMs18KnjkqXfQUnQs=;
	b=hwPn0jDYJibdxYCzqqbpwfJgZHzMTaA8W6R+hRmOaZx3BCp3joWSoJr5MEFUCZcgsxhg
	 5YF2oXOhGSUi43mhRkWzWn4SF3rzXAxEweq8d7Gz7REiX9JeXb4Qu8694qFNTeDyHtXUe
	 WGDk2Enb2tXHSlhX6f73+RtHgvgZAnPPy1Op7oi7Ti0Jk4Oj1KmZ1rT5Fd0wYFDNsTzfA
	 AH1X2+PiGwfcqNQLWrLBxGywZxxlYvQJ0jlErnWIPb+CNaaOJVmF1XyThukmg9oT2Aa0P
	 VhpUhNKv70Zsj13S0R8bXtA6VcYWTGFr8DsyD2Vv0wzviZxv7xxdFygXOoikJ/BhjEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7HLU9AX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EC5606A31B
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7HLU9AX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C811F01825
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 21:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878078;
	bh=4ON1QD05m23Va9f6ugEB9I4fdghMs18KnjkqXfQUnQs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O7HLU9AXv9qInoZlATU0neBhTUsS/f+MalNtCvQYbMlScxBUcmRLC88J4p2aS06pC
	 LsD5/7hpMDDlEcnxvTFFvnnjhfrgvd15WdePoY8kRX+Xgvdnm1ZwXjfQK+wUVmJtMD
	 nUAYv5HcD+dKgangZUHDWV4YoGreltl6eJ27SMq3t2IMcWck5v16n5jSU5UePfwVDR
	 K1MptKOlVJhuWJE/OD4mX3gc2vjwZmPqdQYgL2jhv7szz/JVmI/1R57mXPoPdJ/rw6
	 o+whpjVHCBaYWiRddhPztl+iQTa7d/eQIp8AC0Vo9jLBjlOHHQAyEtmn4lA/xwKEVF
	 +GjYx/vzIqHag==
Message-ID: <sashiko-outbox-183893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/3] selftests/landlock: Test
 LANDLOCK_ADD_RULE_CREATED
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261024-landlock-created-rights-v1-3-77c8db3f6bd2@gmail.com>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
 <20261024-landlock-created-rights-v1-3-77c8db3f6bd2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:41:18 +0000
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
- [Medium] selftests/landlock: tautological EINVAL checks in created_rule_i=
nvalid()
--

commit 0bd817b616774ee644b06b2a2368b4843876b252
Author: Farid Zakaria <farid.m.zakaria@gmail.com>

selftests/landlock: Test LANDLOCK_ADD_RULE_CREATED

This commit adds Landlock filesystem selftests covering the
LANDLOCK_ADD_RULE_CREATED flag, including newly created entries, renamed
files, nested domains, independent domains, and invalid rule arguments.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index 7e25a6f6073c0..84980d426436b 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2640,6 +2640,233 @@ TEST_F_FORK(layout1, refer_mount_root_deny)

[ ... ]

> +/*
> + * Checks that LANDLOCK_ADD_RULE_CREATED is rejected on a file, combined=
 with
> + * LANDLOCK_ADD_RULE_QUIET, or with an empty allowed_access.
> + */
> +TEST_F_FORK(layout1, created_rule_invalid)
> +{
> +	const int ruleset_fd =3D create_ruleset(_metadata, ACCESS_CREATED, NULL=
);
> +	struct landlock_path_beneath_attr path_beneath =3D {
> +		.allowed_access =3D ACCESS_RW,
> +	};
> +
> +	path_beneath.parent_fd =3D open(file1_s1d1, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath,
> +					LANDLOCK_ADD_RULE_CREATED));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(0, close(path_beneath.parent_fd));
> +
> +	path_beneath.parent_fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
> +	ASSERT_LE(0, path_beneath.parent_fd);
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath,
> +					LANDLOCK_ADD_RULE_CREATED |
> +						LANDLOCK_ADD_RULE_QUIET));
> +	ASSERT_EQ(EINVAL, errno);

[Severity: Medium]
Do these two checks in created_rule_invalid() actually exercise the
LANDLOCK_ADD_RULE_CREATED validation paths?

In the first check on file1_s1d1, path_beneath.allowed_access is set to
ACCESS_RW, which includes the directory-only right
LANDLOCK_ACCESS_FS_READ_DIR:

tools/testing/selftests/landlock/fs_test.c:
    #define ACCESS_RO ( \
        LANDLOCK_ACCESS_FS_READ_FILE | \
        LANDLOCK_ACCESS_FS_READ_DIR)

    #define ACCESS_RW ( \
        ACCESS_RO | \
        LANDLOCK_ACCESS_FS_WRITE_FILE)

In security/landlock/fs.c:landlock_append_fs_rule(), a rule on a regular
file is rejected with -EINVAL whenever access_rights is not a subset of
ACCESS_FILE:

    if (!d_is_dir(path->dentry) &&
        ((flags & LANDLOCK_ADD_RULE_CREATED) ||
         !access_mask_subset(access_rights, ACCESS_FILE)))
            return -EINVAL;

Because ACCESS_RW is not a subset of ACCESS_FILE, landlock_add_rule() on
file1_s1d1 will return -1 with errno set to EINVAL even without
LANDLOCK_ADD_RULE_CREATED.

In the second check on dir_s1d1, ruleset_fd is created via
create_ruleset(), which leaves quiet_access_fs as 0. In
security/landlock/syscalls.c:add_rule_path_beneath(), passing
LANDLOCK_ADD_RULE_QUIET on a ruleset with quiet_access.fs =3D=3D 0 also
returns -EINVAL:

    if (flags & LANDLOCK_ADD_RULE_QUIET && !ruleset->quiet_access.fs)
            return -EINVAL;

Would it make sense to use file-only access rights (such as
LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_WRITE_FILE) for the
file1_s1d1 check and a ruleset with quiet_access_fs configured for the
LANDLOCK_ADD_RULE_QUIET check so that both calls would succeed if not for
LANDLOCK_ADD_RULE_CREATED?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-landlock-c=
reated-rights-v1-0-77c8db3f6bd2@gmail.com?part=3D3
