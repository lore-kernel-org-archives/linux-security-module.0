Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6F3D1CBE;
	Wed,  9 Sep 2026 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986802; cv=none; b=i2CHXWC9mJgoZcLUHF6BY3Wh0qqX+OqfyA0v3InAuIXKyM7kbA8FlvDyYU2z0j0reJukAsqQvDBAHWbO95voyE2kDvPQNNgbXBsD7aDbqSLKBs6QD1YUoX4mPFbCZIccHjSIf9+V4013IsSXh4f+oFXku/5HV1Ucj6+eoNHWoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986802; c=relaxed/simple;
	bh=nZRn9fCvkC+4O2mGzt/GA6svu7iNuR/vC5a2wTRKG78=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DNzo9JM62s/3/Tc453H/vINjRTle45q0QmK4eaBSRI40l3NvYCSHDBdTLCcLXYUQuW4bXAW7o8qV+ddm52iUQNSrFUNcBqT7dyKIf+Ev1S+f7h0eiOIa0GeCQ38vdOx4BKmtzNgWD2twRZi0eQ+JC9U0+bwdJ0X9eL7Cjnuh2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeekvFJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeekvFJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5145A1F00898;
	Wed,  9 Sep 2026 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986789;
	bh=eWJvB9mF6mBLy6y75rpL5jQ+WxpDzb0LWD0qdKP262c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HeekvFJ/vIYWQVyv1eh05GuzFTeDZcbjqeFSAyRAiHQwuvL3cJ4RGHUUfoCARIInk
	 E8oTw2COfKxNrK3uQCp696Hpm8j3Xb0MXqR8dA+lTvY5AwfCXb26pbvIPuop50llGX
	 TLDeTUa4NV6tlhFMRZTPFAUfJBLm7ukR1Qoa8Dj8R0O2c/YzhENsSSTnLsWnqW5UDL
	 YLvLaxnTtpY5/XnimkjNkETQvvR5q0ueS9jwVdLfacU4HQVlbQIOGl88sm8UKMcKDn
	 EvMq/N/YcStTfJuuOWJE/LcqdgP0po68D4xWhtZJp+ZNoZVMsgLT5o/SDPZB8RoIfI
	 bgDTnfGmp9lPw==
Content-Type: multipart/mixed; boundary="===============3806054765969645054=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bfb872ee5fae6215e29bedd01d3a9d4c8f7f38ab6e7b5925b38396b003a3970d@mail.kernel.org>
In-Reply-To: <20260909193719.518517-15-utilityemal77@gmail.com>
References: <20260909193719.518517-15-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 14/15] selftests/bpf: Test the LSM policy object kfuncs with Landlock
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:46:28 +0000 (UTC)

--===============3806054765969645054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
> new file mode 100644
> index 000000000000..f01ae5be8aef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_landlock.c
> @@ -0,0 +1,525 @@

[ ... ]

> +static int setup_env(struct policy_test_env *env)
> +{
> +	env->skel = NULL;
> +	env->ruleset_fd = -1;
> +	strcpy(env->tmp_path, "/tmp/lsm_policy_landlock_XXXXXX");
> +	env->tmp_fd = mkstemp(env->tmp_path);
> +	if (!ASSERT_GE(env->tmp_fd, 0, "mkstemp"))
> +		return -1;
> +
> +	env->ruleset_fd = create_ruleset();
> +	if (env->ruleset_fd < 0) {
> +		if (errno == EOPNOTSUPP || errno == ENOSYS)
> +			test__skip();
                          ^^^^^^^^^^^^

A selftests pattern flags this as potentially concerning: skipping with no
message, so the output carries no hint about which prerequisite is absent.

All five subtests funnel through this path, and both errno values look
classified correctly here - EOPNOTSUPP when Landlock is built but not
listed in CONFIG_LSM or in lsm= at boot, ENOSYS when
CONFIG_SECURITY_LANDLOCK=n.  What is not visible in the output is which of
the two happened; a reader sees five skips and cannot tell a config
ordering problem from the feature not being built at all.

Against that, test__skip() in the bpf framework takes no message argument,
and a bare test__skip() is the usual idiom across prog_tests/, so carrying
a reason means adding a separate print rather than passing one to an
existing API.

Would a one-line print naming the missing prerequisite before test__skip()
be worth adding?

> +		else
> +			ASSERT_GE(env->ruleset_fd, 0,
> +				  "landlock_create_ruleset");
> +		return -1;
> +	}
> +
> +	env->skel = lsm_policy_landlock__open_and_load();
> +	if (!ASSERT_OK_PTR(env->skel, "skel_open_and_load"))
> +		return -1;

[ ... ]

> +/*
> + * Exit codes: 4 = unexpected write outcome, 0 = everything as
> + * expected.
> + */
> +static void format_child_cmd(char *cmd, size_t len, bool expect_write_ok,
> +			     const char *tmp_path)
> +{
> +	if (expect_write_ok)
> +		snprintf(cmd, len, "echo x > %s || exit 4; exit 0", tmp_path);
> +	else
> +		snprintf(cmd, len,
> +			 "if echo x > %s 2>/dev/null; then exit 4; fi; exit 0",
                                        ^^^^^^^^^^^^^

Is the redirect order here inverted?  A shell applies redirections left to
right, so the failure of "> %s" is reported before 2>/dev/null has been
applied, and the diagnostic goes to the inherited fd 2:

    $ sh -c 'if echo x > /nodir123/f 2>/dev/null; then exit 4; fi; exit 0'
    sh: 1: cannot create /nodir123/f: Directory nonexistent

    $ sh -c 'if echo x 2>/dev/null > /nodir123/f; then exit 4; fi; exit 0'
    (no output)

bash behaves the same way, reporting "/nodir123/f: No such file or
directory" for the first form.

Does that message then land in the selftest output?  test_progs.c only
reassigns the stdout FILE*:

tools/testing/selftests/bpf/test_progs.c:stdio_hijack_init() {
    ...
	fflush(stdout);
	fflush(stderr);

	stdout = open_memstream(log_buf, log_cnt);
    ...
}

and never redirects fd 1 or fd 2 themselves, while the writer here is a
forked child that inherited the real fd 2.  So each restricted execution
would print

    sh: 1: cannot create /tmp/lsm_policy_landlock_XXXXXX: Permission denied

which is seven executions across test_restrict_binprm(),
test_restrict_binprm_concurrent() and test_restrict_binprm_trace().  The
child's exit status is still 0, so the assertions are unaffected and this
is stray output rather than a false failure.

Would "echo x 2>/dev/null > %s" do what this was written to do?

> +			 tmp_path);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============3806054765969645054==--
