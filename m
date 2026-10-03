Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31273BBA0E
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024285; cv=none; b=EwRmziBHn/4nbj+iJLfc7+t53HpF7K8sQ1YECgFflIYfcyOBFQUJ+vnkvIU/n7TgINbQn/hvY8UKZoioeR9wj332P3XAKPTDYinwzhp7W0wNbwCu3Sk0w9D/Q4UXY4P8z4b9rmJxN7LSoJkge3/zY2zUiZ/h9obGGBS8NzO9uVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024285; c=relaxed/simple;
	bh=y5OeGYinrXzRzq0tBg3sEWgnUdWjcu1pb7qZt2vuNag=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eMxQaqvFvKUgRzKfoKUoelkmkrdeZJu6Ql9KAdhBLYopoxbbnvTx6MAt6Ktif26K3UUMdkscM0i9DpSFM9r2XR8WT7jp7VmVSe+hFR3VsO2R1u7WYpPP8MxYhJiedhqc5C7LnHSX+LepsWUmBwmlvO9NSlc7vL5JPrbO9+BHLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5UGR4yd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5UGR4yd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE661F0089B
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791024283;
	bh=7G6sp4qNmunbstpIVuSaKNXJyOvQNLCuG8jBpsowGAg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=O5UGR4yd4hcnqBcjFxFNEN5lXC1NCGyLlyE+4p7GVC8z11E2gKzm5J6DrjHEj0R2B
	 5Rct9n/XllGr5ypu0k4hWn7KDTz0d4pNvNPP1jcdym7y6Xli0beapXIUngTsCT4dNp
	 dxr5d+lTwvdC64F9rmun7nU3x+NpX5315Kr02GBhw4DEPsglInaODzPGYCMG0w1daf
	 y/LjOu0lhZuSXn5Dn16EbaKnW/uhHdl1cW1m73VAnQXkP5N+Gw7ej0KAsbhN8spzz/
	 H4t6sjQMw6hVKzH1/WoaiR4T8Qsm8AXRWI/mYaTUkxuRFEIwfbQ5oQCQPh5jwpR0Tx
	 5stOPMJxuJbYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/safesetid: test GID policy with
 mismatched real IDs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <899af06e29dd599246082096e27edd51eda1fb27.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com>
 <899af06e29dd599246082096e27edd51eda1fb27.1791023194.git.tjdqudcks0424@naver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 10:44:43 +0000
Message-Id: <20261003104443.9DE661F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: false test failure on older kernels due to strict prc=
tl() check
- [Low] selftests: build failure on older glibc due to SYS_pidfd_open depen=
dency
--

commit dbf0ec68f44394083debd3f938ca7365c6cad4f1
Author: Sung Byeongchan <tjdqudcks0424@naver.com>

selftests/safesetid: test GID policy with mismatched real IDs

This commit adds child-process cases to the SafeSetID selftests that use
mismatched real IDs to properly distinguish the source of a GID policy look=
up.
It verifies that allowed and forbidden transitions are handled correctly us=
ing
both setresgid() and setgroups().

> diff --git a/tools/testing/selftests/safesetid/safesetid-gid-policy-test.=
c b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
> new file mode 100644
> index 0000000000000..873d65627c494
> --- /dev/null
> +++ b/tools/testing/selftests/safesetid/safesetid-gid-policy-test.c
[ ... ]
> +static int check_child_credentials(void)
> +{
[ ... ]
> +	if (effective !=3D expected || permitted !=3D expected || inheritable) {
> +		fprintf(stderr, "child does not hold only CAP_SETGID\n");
> +		return -1;
> +	}
> +	for (i =3D 0; i <=3D CAP_LAST_CAP; i++) {
> +		if (prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET, i, 0, 0) !=3D 0) {

[Severity: Medium]
Will this strict non-zero check cause the test to falsely fail on older
kernels?

If the selftest is compiled with newer kernel headers (where CAP_LAST_CAP is
higher) but executed on an older kernel, prctl(PR_CAP_AMBIENT_IS_SET) will
return -1 (-EINVAL) for newly defined capabilities that the older kernel do=
es
not support.

Since the test checks for !=3D 0 instead of exactly =3D=3D 1 (or explicitly
ignoring -1), the -EINVAL error return is treated as an unexpected ambient
capability.

Could this be updated to check for =3D=3D 1 or ignore -1 to prevent false
failures?

> +			fprintf(stderr, "unexpected ambient capability %d\n", i);
> +			return -1;
> +		}
> +	}
> +	return 0;
> +}
[ ... ]
> +static int run_case(const char *name, enum test_operation operation,
> +		    gid_t target, bool expect_kill)
> +{
> +	struct pollfd pollfd =3D {};
> +	int status;
> +	int pidfd;
> +	pid_t child;
> +
> +	child =3D fork();
> +	if (child < 0) {
> +		perror("fork");
> +		return -1;
> +	}
> +	if (!child)
> +		run_child(operation, target);
> +
> +	pidfd =3D syscall(SYS_pidfd_open, child, 0);

[Severity: Low]
Does this rely on host glibc syscall definitions instead of the kernel-prov=
ided
headers?

Older glibc versions (prior to 2.36) do not define SYS_pidfd_open, which wi=
ll
result in a compilation error when building the selftests on an older host.

Using the kernel-provided __NR_pidfd_open is the standard approach in
selftests to maintain backwards compatibility and independence from the host
libc's system call knowledge. Could __NR_pidfd_open be used here instead?

> +	if (pidfd < 0) {
> +		perror("pidfd_open");
> +		kill(child, SIGKILL);
> +		waitpid(child, &status, 0);
> +		return -1;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791023194.gi=
t.tjdqudcks0424@naver.com?part=3D2
