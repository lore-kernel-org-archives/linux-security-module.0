Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794763747;
	b=RslATYHWV2kCudjvOJHjfqyTG9iNpqovBFzPyq1brzm1HdlitmpYQ4HKZh/zwjA1HxWM
	 8uPEjrv6w+a0uo2fe3w0XL6jhI6fn3eFt9QxVsPAs70kuMDTgvcbNTnzoNG9lofPOwmKP
	 Dz2esdqa6TiCFV1W6OI84kvz4GCIxh/3wDHuBVdmeLveUgPoYaIA5TlfSAQbgqbaF6qQW
	 O6akTqxFBJxC27q7zu+MqEFqlbvUEBd+uv3Nkt8qc8KnKZ2KUdLf8ohAXunIXOfL10wb6
	 Mrq6QADRBrhczuanX+F+3s9nyOTDk8MZiiesUYWZHjy3j68ABavcQZ+nQg7IbMkUfeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794763747;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YB+jn89w+72C0Wp1F5hc5XZkq3Y4Oz5GWklejA1dvL4=;
	b=n2pAgCw68abZSZvI5s3KExDCSCoohLlPj0R5/8KRpQCMP2Xb9lTZre28xmtoP6qJQ0Ni
	 cH9ECoJMulCZdF+FEACRrB0ED8gBi1Q12L1PU+MhBhUW8vdMPoEoHBwgcnSn015HZXghD
	 iP3lOgNBB3d125U9Mu9AB2lk9TuzvbQ+1XPZlKUSnYq3iQrrKMxaQNwrKO0sTIrvUNItn
	 bgSedBU51DtdlNno+aIc8vAH5Z9ETXurrmu1nEODPh3faXuedLvEJFpf1sRcc9tlzRvGd
	 x1BKF9kZD4fbCiFXLqFZaoM2UmfK6Qc1DecY/wJagePq16SnElJWOHOq9FQyO+wA8Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9TLMT14;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88193606A327
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9TLMT14
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94941F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794763747;
	bh=YB+jn89w+72C0Wp1F5hc5XZkq3Y4Oz5GWklejA1dvL4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Z9TLMT14XkTLa+tEq7CNMAG/yeQ1V85YDsGWExSp/lTZynN1YaHDBDEd+WCQrnS06
	 L8VoWuhyZgmfzOrPgB+FIkRqkEOm+FsMvc6oVTSziWT/xxSkpdrKLHAQBBh8t6eSlL
	 IITDyptN3KuNbRVn4ySRkuPX4GZvmbaPU6k1csuytY1GQpAR7PY3lyb+pZoOPB6v83
	 3UHDlxnQ/so9KtSTgyTwlOkVZ/JqlCrnjM+/4DkhRK5qAFMEjhHhhDX89gg1cX9gSE
	 fQGGcvrOj4mAJ1kPb3bmnAeobEwd3SUHqzuaxhT2GCXkZNfDacfL2j6XRmUYh+Qohx
	 9ZDhGZZ/hVY0w==
Message-ID: <sashiko-outbox-215680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] security/landlock: Add KUnit test for mixed valid and
 unknown namespace bits
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-security-module@vger.kernel.org
In-Reply-To: <CANkf1tZeotONOj+uYxE0k3BT_mrZpPyaYDA0vj9zFEbY2zYMrw@mail.gmail.com>
References: <CANkf1tZeotONOj+uYxE0k3BT_mrZpPyaYDA0vj9zFEbY2zYMrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 17:29:06 +0000
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
- [Medium] landlock: test_ns_types_to_bits_mixed() fails on
  !__WARN_FLAGS architectures
- [Low] landlock: weak non-zero check in test_ns_types_to_bits_mixed()
- [Low] landlock: conversational text and duplicated changelog in commit
  message
--

commit b79997e431c689890f9fc8f5cca0b886e3519ebb
Author: Terence White <terrywhite2025@gmail.com>

> security/landlock: Add KUnit test for mixed valid and unknown namespace b=
its
>
> Good evening,
>
> This patch adds a KUnit test case (test_ns_types_to_bits_mixed) to exerci=
se
> landlock_ns_types_to_bits() with a mixed bitmask containing both a valid
> namespace type (CLONE_NEWNS) and an unknown high bit. This verifies that
> the WARN_ON_ONCE truncation guard behaves as expected under
> partial-taint inputs.
>
> Tested locally with all 40 KUnit tests passing successfully.
>
> With kind regards,
>
> Terry White
>
> Add a KUnit test case (test_ns_types_to_bits_mixed) to exercise
> landlock_ns_types_to_bits() with a mixed bitmask containing both
> a valid namespace type (CLONE_NEWNS) and an unknown high bit.
> This ensures the WARN_ON_ONCE truncation guard functions correctly
> under partial-taint inputs.
>
> Signed-off-by: Terry White <terrywhite2025@gmail.com>

[Severity: Low]
This isn't a bug, but the commit message includes conversational email
notes ("Good evening", "Tested locally...", "With kind regards") that
belong below the "---" separator, duplicates the description paragraph,
and has a name mismatch between Author ("Terence White") and Signed-off-by
("Terry White").

> diff --git a/security/landlock/ns.c b/security/landlock/ns.c
> index 06d9784746fe9..d820289423e32 100644
> --- a/security/landlock/ns.c
> +++ b/security/landlock/ns.c
> @@ -217,6 +217,20 @@ static void test_ns_types_to_bits_unknown(struct kun=
it *const test)
>  	}
>  }
> =20
> +static void test_ns_types_to_bits_mixed(struct kunit *const test)
> +{
> +	if (!IS_ENABLED(CONFIG_BUG))
> +		kunit_skip(test, "requires CONFIG_BUG");
> +
> +	/* clang-format off */
> +	kunit_warning_suppress(test) {
> +		/* clang-format on */
> +		KUNIT_EXPECT_NE(test, 0ULL,
> +				landlock_ns_types_to_bits(CLONE_NEWNS | (1ULL << 62)));

[Severity: Low]
Should this assert KUNIT_EXPECT_EQ(test,
landlock_ns_type_to_bit(CLONE_NEWNS), ...) instead of KUNIT_EXPECT_NE(test,
0ULL, ...)?  Checking only for a non-zero return value would still pass if
the unknown bit leaked into the returned mask or if the wrong bit was set.

> +		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +	}
> +}

[Severity: Medium]
Does KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1) fail on architectures
that do not define __WARN_FLAGS, such as ARCH=3Dum (the default for kunit.p=
y)?

On those architectures, WARN_ON_ONCE() in include/asm-generic/bug.h expands
to DO_ONCE_LITE_IF(condition, WARN_ON, 1), which sets its static
__already_done flag before calling into warn_slowpath_fmt() where KUnit
checks kunit_is_suppressed_warning().  Because test_ns_types_to_bits_unknow=
n()
runs earlier in test_cases[] and triggers the single WARN_ON_ONCE() site in
landlock_ns_types_to_bits(), __already_done is already set when
test_ns_types_to_bits_mixed() runs, so the second warning never fires and
the suppressed warning count is 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CANkf1tZeotONOj+uYx=
E0k3BT_mrZpPyaYDA0vj9zFEbY2zYMrw@mail.gmail.com?part=3D1
