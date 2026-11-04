Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827316;
	b=gJCfWuOtPmuMxgwloq58N3I55pqqn1iAG+IPobFAGNfR6ZnhZYK3F0zSmWZIe53i5rK7
	 RODp5/ebEavFVTgE/LE0eris/ZEVg3GBs3ixsFfCmEHOCuYOiDQ2zvnHJV4T/N75zVEEw
	 q3hr4ZcI7nmRX9yrQHpNHgWFdDFvmZ2xeXVj5Bl46JFinW6xqSW6msYbAgfQZMMWrrIYt
	 5Y9aUPa7+JAqtjUR9pJkJpW71rLS2Okt0BMyRZGgge58AMbzs29IEQnCw4ox0+ZH+BjyM
	 b0JoXWB4Xqny/sH8/GQd0lFxOOY//qNaIW5OK6Tu8esOcS1TP3o2Yh2A512nbGfrWfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S3ssuj5tdOSU1kgIV2+T1zpwoIRxTkRECkiS8S6AvXk=;
	b=jU11f2fZbPt1CuDVW8eqYRSVaCTOLn5TE1Bj30OkTwCT3R0e5ZwF/kjEOIhszHJT68MG
	 GAu4u1u5URVmvsZiHYFcIG7mJCRhsvcjSZVxI1zsz92RazqyLym6eYcK/DOv2cbAFPfv0
	 PkRb1DyFeV0eKRv5mK6zVl81R3dOvk7QACi4wY2cINtU4eeDIFB0v7f+RjHJZDN0ZDUtl
	 siRd74mhmf6KZJXk8Wl5xwXmkRS+njrBeVgbZE5aF32GzHIBnU//j5p4NTzRICRYCp7Z+
	 RoK3nOePWJ8Repg9U44ypI1ZND/an54qf3norjPFRMR22I7WVcEB0t/SEX0VYs8d22g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foMAtcYo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DB606AC34
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=foMAtcYo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4411F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827315;
	bh=S3ssuj5tdOSU1kgIV2+T1zpwoIRxTkRECkiS8S6AvXk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=foMAtcYomQb+JD7ZFWiPq6gYKrGliXeCHSdLrxcARODIuyuqhtHXoTcLrjhCbEKvq
	 ID/onj+sWMWIIdDpmKhUMKS6mSAlZQKWEeEeOAiD1iUQjns6yOdjmlLBotKb5EoMkM
	 eyFPOiDDVyEtPCWHuCb0KqEIUUGYyTEPdxfh8JdG+4sWMygKnv9tre9IAa9Tql1ibF
	 v2cNkcP6zqMgj30ulvEtsbND05F09RLAzpIZHUZf9LxzH4QvKKzSbJjrulzDzYpbhc
	 9L66fYGF0BS3M6klSBUqncdOz2mOFyBSKB+RZ0zcheBdcAcK1+QpRQHq7WHbk7JY/q
	 sBkR/zizFQMpA==
Message-ID: <sashiko-outbox-198105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/27] selftests/landlock: Use ASSERT for syscall
 failures before errno checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-24-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-24-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:21:55 +0000
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
- [Medium] selftests/landlock: ASSERT_EQ() after PTRACE_ATTACH skips detach=
 and stops peer
--

commit 9f0b61a144fcc6c9f95be698e621be787a64a44b
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Use ASSERT for syscall failures before errno checks

This commit replaces EXPECT_EQ() with ASSERT_EQ() for syscall return value
checks in Landlock selftests so tests abort before checking errno when a
syscall expected to fail unexpectedly succeeds.

> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testi=
ng/selftests/landlock/ptrace_test.c
> index 4fd2b440aa455..ea8e4be6659e9 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -204,7 +204,7 @@ TEST_F(scoped_domains, trace)
>  		if (can_trace_parent) {
>  			EXPECT_EQ(0, ret);
>  		} else {
> -			EXPECT_EQ(-1, ret);
> +			ASSERT_EQ(-1, ret);
>  			EXPECT_EQ(EPERM, errno);
>  		}
>  		if (ret =3D=3D 0) {

[ ... ]

> @@ -276,7 +276,7 @@ TEST_F(scoped_domains, trace)
>  	if (can_trace_child) {
>  		EXPECT_EQ(0, ret);
>  	} else {
> -		EXPECT_EQ(-1, ret);
> +		ASSERT_EQ(-1, ret);
>  		EXPECT_EQ(EPERM, errno);
>  	}

[Severity: Medium]
As reported by Sashiko on v1 [1], in TEST_F(scoped_domains, trace) in
tools/testing/selftests/landlock/ptrace_test.c, if ptrace(PTRACE_ATTACH, ..=
.)
unexpectedly succeeds (ret =3D=3D 0) when can_trace_parent or can_trace_chi=
ld is
false, the target process is sent SIGSTOP by the kernel.

Previously, with EXPECT_EQ(-1, ret), execution continued into the following
cleanup block even on an unexpected attach:

	if (ret =3D=3D 0) {
		ASSERT_EQ(parent, waitpid(parent, &status, 0));
		ASSERT_EQ(1, WIFSTOPPED(status));
		ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
	}

which waited for the stop and detached the tracee cleanly.

With ASSERT_EQ(-1, ret), doesn't an unexpected attach success abort the
tracer before reaching the if (ret =3D=3D 0) block, leaving the tracee in
TASK_STOPPED from the pending SIGSTOP (and causing the parent test process =
to
hang until the kselftest harness timeout when the child attaches to the
parent)?

[1] https://lore.kernel.org/r/20261008142604.39107-26-gnoack3000@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D24
