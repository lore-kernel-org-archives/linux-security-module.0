Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C544A3F4
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470483; cv=none; b=NpRynOgxYWm5j6G9hdl4RE4hYIYq8ZWcBMYBTk8XoBVtBu7MDC9nugAkqZoR2F4u64pu0ZOETk8g4btJF583oRF3XIQvN1DraNJYQskJoiHzGlq2vVuj7tezGK0kLkUPTBLMKryQiilIFk0GJ/rBFc5H/+orr+A3suxKCF6rDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470483; c=relaxed/simple;
	bh=6bLkz0O6gSLOiER/WR9dxfNtqYkdZE8F+xE/1m8aIYQ=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=G/HjZU2toA+x0u+0tF/VUQaS1DOWjTS0XuoLlSAFjGiT4KSgox4RIjUeKZT4Jh7YRaFBp/gYeisYRLpT6+XzVLlF4QnFeplns7zJlD3b8W1EOj3353kFG0aDOEddBhklkfmS69JpHO0hi5QJcSt1pYk1jOQW1uH5QmV7QXa+c44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmsnExDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmsnExDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E3D1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470481;
	bh=5PELLOqSO/OUmc5+SgaAUqSpezDQRMgYFjtdXRKxhLg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XmsnExDKuOTg5Vi0VBr5LizA0UeR19BdhH51JuV0XCbVyT/r4hx/E7RAxDIWigLq8
	 v/xHp4FfWIhTLucpGiWB2fvyEyJhAgCe5mDTa+qivZ7lpsXcq+JYCvDkQwagqESXO7
	 NYh23iqrFFWoanEy1aHcmSI7qptrByVAAfV7NO4x6WNbjjDLN+RGpZk6TQmIeYhN/w
	 xnm9WmWrwrN9R/ggHV/HA3K07iuA374FxN+mzmW+e2v9s5zTkYb3aLaP/r8tximIEG
	 ZnitTzh/XR8jueM+h0EtJz+ZcnCW1fEQ+KeSVtAuni+5P5bIkOIcWGer1oY9z4MhYm
	 JEbjC9D1rg3mw==
Message-ID: <sashiko-outbox-164318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/27] selftests/landlock: Use ASSERT for syscall
 failures before errno checks
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-26-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-26-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:41:21 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: ASSERT_EQ bypasses ptrace cleanup, causing test hang
--

commit f35a2df1559c7e7b062080b5d4fda3a0df26e0e3
Author: G=C3=BCnther Noack <gnoack3000@gmail.com>

selftests/landlock: Use ASSERT for syscall failures before errno checks

This commit replaces EXPECT* with ASSERT* for syscall failures where
succeeding would result in an undefined errno. This ensures that the
tests abort early rather than checking undefined state.

> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testi=
ng/selftests/landlock/ptrace_test.c
> index 75f6d0dcd9375..2266e2361d923 100644
> --- a/tools/testing/selftests/landlock/ptrace_test.c
> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> @@ -204,7 +204,7 @@ TEST_F(scoped_domains, trace)
>  		if (can_trace_parent) {
>  			EXPECT_EQ(0, ret);
>  		} else {
> -			EXPECT_EQ(-1, ret);
> +			ASSERT_EQ(-1, ret);

[Severity: Medium]
Will this new ASSERT_EQ bypass the ptrace cleanup on unexpected test failur=
es?

If ptrace(PTRACE_ATTACH) unexpectedly succeeds when it is expected to fail,
it sends a SIGSTOP to the tracee.

With the change from EXPECT_EQ(-1, ret) to ASSERT_EQ(-1, ret), an unexpected
success where ret =3D=3D 0 causes the test process to abort immediately.

Does this early abort bypass the subsequent if (ret =3D=3D 0) block that pe=
rforms
waitpid() and ptrace(PTRACE_DETACH) to clean up the stopped tracee?

Because the tracer dies without detaching or waking the tracee, the tracee
remains in a stopped state (SIGSTOP).

If the tracee is the parent test process, could the kselftest harness's
waitpid() block indefinitely, causing the entire test suite to hang instead
of cleanly reporting a failure?

>  			EXPECT_EQ(EPERM, errno);
>  		}
>  		if (ret =3D=3D 0) {
>  			ASSERT_EQ(parent, waitpid(parent, &status, 0));
>  			ASSERT_EQ(1, WIFSTOPPED(status));
>  			ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
>  		}

[ ... ]

> @@ -276,7 +276,7 @@ TEST_F(scoped_domains, trace)
>  	if (can_trace_child) {
>  		EXPECT_EQ(0, ret);
>  	} else {
> -		EXPECT_EQ(-1, ret);
> +		ASSERT_EQ(-1, ret);

[Severity: Medium]
Similarly, if the parent's PTRACE_ATTACH on the child unexpectedly succeeds,
would the parent abort and leave the child stopped and orphaned?

>  		EXPECT_EQ(EPERM, errno);
>  	}
> =20
>  	if (ret =3D=3D 0) {
>  		ASSERT_EQ(child, waitpid(child, &status, 0));
>  		ASSERT_EQ(1, WIFSTOPPED(status));
>  		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D24
