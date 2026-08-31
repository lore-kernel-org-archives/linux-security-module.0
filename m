Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C03F3286;
	Mon, 31 Aug 2026 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178034; cv=none; b=aMM3r629Tus/xFCxvQIXAhJLI1MZ3LZhOZNvMkvXX4iIkt+68/jwILub/Ob2RcOBuWjCqDdIZFNiJnDJbikwPZjjMFrQXzRmzdy4l6fSFZDgCsq7RvOZKQG158LIZt6iwCzakcDXbbPmKK3J9VKjWDjntgi9MUcfOhcKlBbYgrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178034; c=relaxed/simple;
	bh=5wxOEL3j3/PzOyT1mAT3H5nyWhQBgdLu3ua96Tolo1s=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IInf3Kg6CbxQlo1dh1Sgq4RwWbt92PAv0SgZFcRtiTsvnZn5olrma8Q1iM09ANkVSXtOTgLQSWvuSQEHEMhYz41J6zUu6FFXZGPH60GWMqAUBSb6i1o5hM44Xi0+IK5z8I4H5LzfLHAsufONh6TT2ykE1HTnq+Wb+Nn4uUU7fE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWnuXnga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWnuXnga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAD81F000E9;
	Mon, 31 Aug 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178032;
	bh=gqhTV/l7kW1uQEgYnqAPw6g41+yUIWjiVvUP92dcDsE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nWnuXngavMs6j45o/F6ywVfeC0DK+AvPRC+TN8N3J7rwjRbVa99q9/DZJuRusFs+o
	 x37gRntKD71dI6NGnI8D+ZtxJ1I8gUZS8fjcFidTllCaJ9Z1R2C8GEgJoPbioxeWLu
	 caJ0bJyizs4smGInXFFgB83lCisSsFwV0FJCyXwA/vGfwNVLDINhFVUfwcfOtMMMW7
	 m/rJpPjZ76s7Sso1QGg515tK35leiI8DpgbVz4DwpFV96zTgg5DmcxnWpS/7cVkqit
	 k+ETvEQ7gPtOKrSRGlvKpFE3rJ5mcUByoL8X+lkAqRrHFVt4ItuoAxESMMhSugcrjN
	 BE/ZFFoJIu7og==
Content-Type: multipart/mixed; boundary="===============2308554220683685016=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8872f8c265628c401291f2921919eb96e1169eef2a4e5d0b1d8dfb5e80bced6a@mail.kernel.org>
In-Reply-To: <20260831110934.241898-7-a.s.protopopov@gmail.com>
References: <20260831110934.241898-7-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Add tests for the generic netlink BPF hook
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,john.fastabend@gmail.com,brauner@kernel.org,paul@paul-moore.com,torvalds@linux-foundation.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:07:11 +0000 (UTC)

--===============2308554220683685016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Add a few tests for the new generic netlink BPF hook.
> Policies only apply themselves to the "nlctrl" family.
> The following tests are being added:
>   * doit: allow or deny CTRL_CMD_GETFAMILY
>   * dump: allow or deny CTRL_CMD_GETPOLICY, nlmsg_flags |= NLM_F_DUMP
>   * nlmsg_flags: allow or deny a command based on nlmsg_flags
>   * other_family: check that other families still pass

The enumeration lists four subtests but the patch registers five. The
"netns" subtest is missing from this list:

    if (test__start_subtest("doit"))          test_doit(skel, fd);
    if (test__start_subtest("dump"))          test_dump(skel, fd);
    if (test__start_subtest("nlmsg_flags"))   test_nlmsg_flags(skel, fd);
    if (test__start_subtest("other_family"))  test_other_family(skel, fd, other_id);
    if (test__start_subtest("netns"))         test_netns(skel, fd);

The netns subtest is the only one exercising the net argument of
bpf_lsm_genl_family_rcv_msg(), and it introduces target_netns_inum plus
a filter in the BPF program, netns_new()/open_netns(), a second socket,
and the netns_inum() helper - roughly 45 of the 242 added lines. Since
the netns filtering path is the least obvious part of the hook contract,
would it make sense to add a fifth bullet, for example "* netns: deny a
command only inside a target netns, allow it elsewhere"?

> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 08c6e8a4e..6ca0b083a 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -30,6 +30,7 @@ CONFIG_DYNAMIC_FTRACE=y
>  CONFIG_FPROBE=y
>  CONFIG_FUNCTION_TRACER=y

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/genl_lsm.c b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c
> new file mode 100644
> index 000000000..9f866c4c6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/genl_lsm.c

[ ... ]

> +static void test_nlmsg_flags(struct genl_lsm *skel, int fd)
> +{
> +	int err;
> +
> +	/* ensure denying works */
> +	skel->bss->target_cmd = CTRL_CMD_GETFAMILY;
> +	skel->bss->target_flags = NLM_F_REQUEST | NLM_F_DUMP;
> +	skel->bss->allow = false;
> +
> +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
> +	ASSERT_OK(err, "doit_flags_not_matched");
> +
> +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
> +	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
> +
> +	/* now, the other way around */
> +	skel->bss->target_flags = NLM_F_REQUEST;
> +
> +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, true);
> +	ASSERT_OK(err, "doit_flags_not_matched");
> +
> +	err = nlctrl_request(fd, CTRL_CMD_GETFAMILY, false);
> +	ASSERT_EQ(err, -TEST_ERRNO, "deny_dump_flags");
> +}

The second half reuses the assertion tags from the first half, but they
name the opposite case. The dump request gets "doit_flags_not_matched"
and the doit request gets "deny_dump_flags". The test logic is correct
but when test_progs prints only the tag and __func__, a CI failure
reporting "genl_lsm:FAIL:deny_dump_flags" cannot be attributed to either
of the two assertions with that name, and whichever one it is, the tag
names the wrong netlink operation. Would four distinct tags - for example
"deny_dump_flags_matched", "allow_doit_flags_unmatched",
"allow_dump_flags_unmatched", "deny_doit_flags_matched" - remove the
ambiguity?

[ ... ]

> +void test_genl_lsm(void)
> +{
> +	struct genl_lsm *skel = NULL;
> +	int fd = -1;
> +	int err, other_id;
> +
> +	skel = genl_lsm__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "genl_lsm__open_and_load"))
> +		return;
> +
> +	fd = genl_open(0);
> +	if (!ASSERT_OK_FD(fd, "genl_open"))
> +		goto cleanup;
> +
> +	/* do this before attaching our hook, just in case */
> +	other_id = genl_resolve_family(fd, OTHER_FAMILY_NAME);
> +	if (other_id == -ENOENT) {
> +		test__skip();
> +		goto cleanup;
> +	}

A subsystem pattern flags this as potentially concerning: when
CONFIG_ETHTOOL_NETLINK is absent, genl_resolve_family() returns -ENOENT
and the test skips with no printed reason. A reader of the TAP output
sees "#N genl_lsm:SKIP" with nothing indicating the missing prerequisite
was the ethtool genl family, so a silently-skipped test looks identical
to a deliberately-disabled one. All five subtests are skipped this way,
including the four (doit, dump, nlmsg_flags, netns) that do not need
ethtool - only test_other_family() consumes other_id.

This pattern is common in bpf selftests (e.g. aggregate_ret.c:52,
arena_spin_lock.c:57 and :66 all do exactly this), and the config hunk
in this same patch adds CONFIG_ETHTOOL_NETLINK so the skip path should
not be taken in a properly configured CI run. Would a one-line printf
plus optionally deferring the ethtool resolution into test_other_family()
so the other four subtests still run be worth addressing?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/genl_lsm.c b/tools/testing/selftests/bpf/progs/genl_lsm.c
> new file mode 100644
> index 000000000..c4d8b4d23
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/genl_lsm.c

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074
--===============2308554220683685016==--
