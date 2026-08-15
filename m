Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611051C5499;
	Sat, 15 Aug 2026 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786796382; cv=none; b=SfRn2il7g2C7W/4uhGH4RUl87voguaTcqg5tjwgYOtO4GYt0S+G6mV+dn2NvBEk8E2pVgRGA5ifWJXQ0rTZfu8qz6XDLoJ1pm/FMocEZ/9zl0LQugO7IuQhx2YhjB+qvzOZm0+OayHXhz0MA7cKr93Q4DqG/FY/QF0t4H4G+68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786796382; c=relaxed/simple;
	bh=1miv0zhuoRnew8VNtiBDS20oYiD49W/W4s47bl+UgFg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mpjswj0ZLhzkZ34C+cBaqhYwpDUFrCuIP4Yf7pm7DavuL+dWn0ttknzWc5FIYerhlFcF4rorlOhXuoKVg7KOdqnW7WKavtV/0YRhvEgNqYQmbiMTjF7rV5nuQfuqcE8p2gOwu7YOZfEReLV357XbxZXlWWk1KIdhqwhZTn8PxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SajgJZbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SajgJZbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93D1F000E9;
	Sat, 15 Aug 2026 12:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786796380;
	bh=bQJBp191S+481hNkbAoL6aYbN0WJu7jzwlCUDZsUusk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SajgJZbR5d4H3uoj3K1p6YJuRT1pTzl1tj/yaE//eyFTBYXdhmZ/wRFvZE1djTn97
	 VPD5VyyUU8/BTsoKJjFysQIS26JcY+vOlT7n4zSpffejfKgy9utB6mOwOs51rupwjS
	 Mm8qzzcpLY9zIdIRYH7rVKivhyACZtHva1ZZ7cWy3xt00mpx9q20/VqLDrRQ/CWyVB
	 4by98bOcq+boJMu3PJiGc3dtxmIzTOZhaRTtgjlXXfwK8uhK8mV/z2Dilr2LZ1CMpy
	 tDSZYJu/OYENqOM+qB9bapXw4JmxcXUMvTKChusTTJ6AdYQew2B93EUS4MwYPEY+Dc
	 LIyqkw9AMGH+A==
Content-Type: multipart/mixed; boundary="===============6946164073483389045=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65c31dc7456f76e4b3012dd8dff3f7e23d136903d5cf997eb9be0662a979c1bc@mail.kernel.org>
In-Reply-To: <20260815112041.1248855-3-utilityemal77@gmail.com>
References: <20260815112041.1248855-3-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_security_locked_down kfunc
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,paul@paul-moore.com,xiujianfeng@huawei.com
Cc: linux-kernel@vger.kernel.org,linux-security-module@vger.kernel.org,bpf@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 15 Aug 2026 12:19:40 +0000 (UTC)

--===============6946164073483389045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The selftest config guarantees the verdicts are stable: the bpf LSM is
> in CONFIG_LSM and the lockdown LSM is not, so the kernel cannot already
> be locked down.

Does the selftest config actually guarantee this? Looking at
tools/testing/selftests/bpf/config, it sets only CONFIG_BPF_LSM=y,
CONFIG_SECURITY=y and CONFIG_SECURITYFS=y. There is no CONFIG_LSM line at
all in that file.

The only CONFIG_LSM in the bpf selftest configs is
tools/testing/selftests/bpf/config.x86_64, which has
CONFIG_LSM="selinux,bpf,integrity". On other arch configs (aarch64,
s390x, riscv64, ppc64el), CONFIG_LSM falls back to the security/Kconfig
default, which does list "lockdown".

What actually prevents the lockdown LSM from being active is that
CONFIG_SECURITY_LOCKDOWN_LSM defaults to n, so the lockdown LSM registers
no hook. This is a weaker guarantee than the changelog states, and only
holds when test_progs is run against the shipped selftest config.

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
> new file mode 100644
> index 000000000000..c836851d8397
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "lsm_kfuncs.skel.h"
> +#include "lsm_kfuncs_fail.skel.h"
> +
> +void test_lsm_kfuncs(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct lsm_kfuncs *skel;
> +
> +	RUN_TESTS(lsm_kfuncs_fail);
> +
> +	skel = lsm_kfuncs__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	if (!ASSERT_OK(lsm_kfuncs__attach(skel), "attach"))
> +		goto out;
> +
> +	if (!ASSERT_OK(bpf_prog_test_run_opts(bpf_program__fd(skel->progs.query),
> +					      &opts), "test_run"))
> +		goto out;
> +	ASSERT_EQ(skel->data->ret_clear, 0, "not locked down");

Can this assertion produce false failures on a kernel that is already
locked down? If CONFIG_SECURITY_LOCKDOWN_LSM=y with lockdown active
(lockdown=integrity/confidentiality, or Secure Boot with
CONFIG_LOCK_DOWN_KERNEL_FORCE_*), security_locked_down() walks every
registered locked_down hook, not just the test's BPF program.

security/lockdown/lockdown.c:
    LSM_HOOK_INIT(locked_down, lockdown_is_locked_down)

would return -EPERM for LOCKDOWN_KEXEC (an integrity-level reason), so
ret_clear becomes -EPERM and the test reports a hard FAIL rather than a
skip.

> +	ASSERT_EQ(skel->data->ret_denied, -EPERM, "locked down");
> +	ASSERT_EQ(skel->data->ret_invalid_low, -EINVAL, "LOCKDOWN_NONE invalid");
> +	ASSERT_EQ(skel->data->ret_invalid_high, -EINVAL, "CONFIDENTIALITY_MAX invalid");
> +out:
> +	lsm_kfuncs__destroy(skel);
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/lsm_kfuncs.c b/tools/testing/selftests/bpf/progs/lsm_kfuncs.c
> new file mode 100644
> index 000000000000..2637b9bc9025
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_kfuncs.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern int bpf_security_locked_down(enum lockdown_reason what) __ksym;
> +
> +/* Reason nothing in the test environment genuinely queries or locks. */
> +#define DENY_REASON LOCKDOWN_HIBERNATION
> +#define ALLOW_REASON LOCKDOWN_KEXEC
> +
> +int ret_clear = 1;
> +int ret_denied = 1;
> +int ret_invalid_low = 1;
> +int ret_invalid_high = 1;
> +
> +SEC("lsm/locked_down")
> +int BPF_PROG(lockdown_hook, enum lockdown_reason what)
> +{
> +	return what == DENY_REASON ? -EPERM : 0;
> +}
> +
> +SEC("syscall")
> +int query(void *ctx)
> +{
> +	ret_clear = bpf_security_locked_down(ALLOW_REASON);

Would it make sense to have the test tolerate or skip when the running
kernel is already locked down? The current approach asserts on global host
state the test does not control. Consider checking if ret_clear != 0 and
skipping with a message, so the test does not produce false regression
signals on distro kernels with lockdown active.

> +	ret_denied = bpf_security_locked_down(DENY_REASON);
> +	ret_invalid_low = bpf_security_locked_down(LOCKDOWN_NONE);
> +	ret_invalid_high = bpf_security_locked_down(LOCKDOWN_CONFIDENTIALITY_MAX);
> +	return 0;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31882515336
--===============6946164073483389045==--
