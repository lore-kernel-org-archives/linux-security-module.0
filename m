Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466875;
	b=BiaaLzuQYNvxjjlDyOk8v78RxsgDv6ZlX9Bb4neCplJg7J/TRF6CzMSaosJM6AbZCDBm
	 FQ/5B/2icNSlCNaE3Qj3slFbtHcNqyyFRg/gSNBgAitfs+swtP6E95tnXoZJHNS2jMv4k
	 wMju/qpwZeRj/DjUPdjb4n+KouPWYSgNz3/7yFg2XmReEM3OXp1g6QdXLpa40muemuwPY
	 rRgxLIlKIIX/9HsMURQlVzpajA2JQEdHDCcyWoyCqWZWSPrYogr2us4hM5zWqxPAQ2ecA
	 Kz/GdrQtXZeQzYTDAHVHC38wmC261LqyQKIPIJk9B1aeiDqSryhu2nNEr6JEwabhYyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VmYCXkQKeK/n5+56/L/h+bico461SqFiVj3Owracis4=;
	b=kKkYMqs1kDRxqmFOUSGVShs06ac3/9qan0cZMelZZ9PXvPwMHAuLtsOin4xu8e0GN8FA
	 8Pbaox21KnKJvk1t8eYUkjTn016zMdgGPtL9TN5x3lhuaJ0t1SLgu2KxdVg1hi0YMgHex
	 iTl6CaKw7lzkqzLs/JdTabE9cBk2IGAJmW9eb7g5CRVpYu1TnOBDVndZxggunSwZe4hzu
	 kQGcC7SK6mH6wNwSOp0nD6mIKK7tts4YDgEESMyUnl+kEFD9qSYMS+6mFhFDlVA4ATKXK
	 wqLW586s/+aHOmGlZKKaAM91BA0fI8i/2dn6M2AaHegueyCOWN+EqfSzwUqPrLPQEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOHSjJ04;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CF606A336
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOHSjJ04
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615DA1F00A05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794466874;
	bh=VmYCXkQKeK/n5+56/L/h+bico461SqFiVj3Owracis4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=eOHSjJ04vbpiBITZUVRomfwTj0WVRwrwNFE9WrsDjIQxQKUM+5+2fcel6s76Xt4pE
	 jlj5Xe4i6tPDaZcpVGmZHJmLguNPYwPYshqFO8TzwTMBmlxL+9aWcTbnPjd3Crf0C9
	 YF/GouKkdDeNmPEQMsK6NtogmaxGZrQ1In10Ni+PNZKbKW7T60FUJamHTIhZ1SqkX/
	 JGQ9s8sbU3BO7MBFf9GHkvASQ5DfO6csJyBP8INeAqtyTrFCvSMb9UxU/a+BEEAnMy
	 ch7jd6vRpvJp7CyPyU5ivmQ3gR4WnwGmQAwoSDosPUIeIenwoxqQLtGWl3z3tLUd3q
	 8ikwx6JLqlHYA==
Message-ID: <sashiko-outbox-210561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] landlock: Add a test for REFER layer composition
 with network layer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112065203.1066536-2-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112065203.1066536-1-mangosteen922@126.com>
 <20261112065203.1066536-2-mangosteen922@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:01:13 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] selftests/landlock: non-compliant handle pandaWall in
  Signed-off-by
- [Medium] selftests/landlock: ungranted MAKE_REG in
  refer_with_net_layer() fails
- [Low] selftests/landlock: stray blank line removal before
  refer_denied_by_default1
--

commit d4e80b85fa92ac6a7a9cb938ea00f1dbb1f7a137
Author: pandaWall <mangosteen922@126.com>

> landlock: Add a test for REFER layer composition with network layer
>
> Check that stacking a network-only ruleset (i.e. a layer handling no
> filesystem access right) on top of a filesystem ruleset still allows
> different-parent renames and exchanges allowed by the filesystem layer.
> Before the fix, such a layer implicitly handled
> LANDLOCK_ACCESS_FS_REFER and denied these operations with EXDEV.
>
> A single rule on dir_s1d2 is enough: it covers its subdirectory
> dir_s1d3, and grants all the filesystem access rights handled by the
> domain on both parents of the tested renames.
>
> Signed-off-by: pandaWall <mangosteen922@126.com>

[Severity: High]
The Author header and Signed-off-by trailer use a handle ("pandaWall")
rather than a real full name, as required by the Developer's Certificate of
Origin in Documentation/process/submitting-patches.rst.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index f725882fa4a78..94b339252f5db 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2569,7 +2569,6 @@ const struct rule layer_dir_s2d1_execute[] =3D {
>  	},
>  	{},
>  };
> -
>  /*
>   * Tests precedence over renames: denied by default for different parent
>   * directories, *with* a rule matching a parent directory, but not direc=
tly

[Severity: Low]
This isn't a bug, but this hunk removes an unrelated blank line after
layer_dir_s2d1_execute[], and the commit subject prefix should be
"selftests/landlock:" to match other commits touching this file.

> @@ -2612,6 +2611,42 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
>  				layer_dir_s1d1_refer);
>  }
> =20
> +/*
> + * Tests that a layer not handling filesystem access rights does not
> + * implicitly handle LANDLOCK_ACCESS_FS_REFER, which would otherwise deny
> + * different-parent renames and links stacked on top of a filesystem rul=
eset.
> + */
> +TEST_F_FORK(layout1, refer_with_net_layer)
> +{
> +	const struct rule layer_fs[] =3D {
> +		{
> +			.path =3D dir_s1d2,
> +			.access =3D LANDLOCK_ACCESS_FS_REFER,
> +		},
> +		{},
> +	};
> +	const struct landlock_ruleset_attr ruleset_net =3D {
> +		.handled_access_net =3D LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +
> +	/*
> +	 * layer_fs alone: different-parent renames are allowed.  A single
> +	 * rule on dir_s1d2 covers its subdirectory dir_s1d3 as well.
> +	 */
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER |
> +				      LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   layer_fs);
> +	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));

[Severity: Medium]
Does this test fail on the first test_rename() with EACCES?

enforce_fs() makes the domain handle both LANDLOCK_ACCESS_FS_REFER and
LANDLOCK_ACCESS_FS_MAKE_REG, while layer_fs only grants
LANDLOCK_ACCESS_FS_REFER on dir_s1d2.  When reparenting a regular file
across directories, current_check_refer_path() also requires
LANDLOCK_ACCESS_FS_MAKE_REG on the destination parent if the domain handles
it, so test_rename() and test_exchange() return EACCES before the test can
reach the network-layer check.  Either layer_fs[0].access needs to include
LANDLOCK_ACCESS_FS_MAKE_REG, or enforce_fs() should only handle
LANDLOCK_ACCESS_FS_REFER.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112065203.1066=
536-1-mangosteen922@126.com?part=3D2
