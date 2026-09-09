Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224A52E069;
	Wed,  9 Sep 2026 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985813; cv=none; b=qLoy3OosKPsc6MayQ8rfXzwvoRzosZyrO6IkCfgIO5Z3GazLeFtB/Hv3XIHGyJzdze01L7H7vQ0f05XZnOizWys9mRMzRoi16aQ3TD3wvuEMZ0GNYv4TjjiCCeuvNRaLtn1ygH+4yNb5RkZ7szkLHYh5C0KhtD1qV529pBlhVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985813; c=relaxed/simple;
	bh=rvSvi2a6GoLokrwNhBAxWnhkfbHnNCVQFizxTxPkPJ0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XKf5VdrSDCJ1JqmnolGlduIwxsy3hoAmd/8+EtOmljRArDIHHrie0MIj9IUOhNIdQwB+st72j/1MClxix+04RwjKVwbr7LLeisWrbqcYE8t21osNpt1+HBZOJbr5OQ7hzTOFisZFlWPTmT4/4cluijGNaDfsUYJx+HJdmLxkBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx5f+Dnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx5f+Dnu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A811F00898;
	Wed,  9 Sep 2026 20:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985804;
	bh=CsLKGBQjgpG6ZFoeHmOrOaSAKA/qpg7P+mlu9j9MYF8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Xx5f+DnuHeduwHWeJMW3xmxTr8yIDF71FJGJTul0g5Ij5b2denwyqYV7iKlIoxnDR
	 RG4ahXe0CYoK9Hjx/Va3rH6e+BND3CC0F2ADC5o+pHPlrFcRuVk/S0hHjLx/XZeJWg
	 xObcpTEsQ5dWzHqkmXU0L+c0fW/xlURQfPHT0C6zgrXZjSDrjRj/zIkvZ/0NZPHxAD
	 mu4NeNxR562lX5UuzTSwCy2EQrAccbmyqc/bHYsWiMRGmQdE7CEMhtKZMmdphUm05l
	 sg59VgftDJkp0RrSBG2/8jzfOuIsEGMUjuwfm/wr5AiYJlE9M8BM9IclVSd0CQPyw2
	 NAG+MDFmOiPUg==
Content-Type: multipart/mixed; boundary="===============0455932225885287739=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fcb7ad645956b322d672ea3f562de3016df48f28530c9e1f8ddf0259dbff0e59@mail.kernel.org>
In-Reply-To: <20260909193719.518517-10-utilityemal77@gmail.com>
References: <20260909193719.518517-10-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/15] selftests/bpf: Add tests for the LSM policy object kfuncs
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,matt@bobrowski.net,paul@paul-moore.com,mic@digikod.net,viro@zeniv.linux.org.uk,brauner@kernel.org,kees@kernel.org
Cc: casey@schaufler-ca.com,gnoack@google.com,jack@suse.cz,song@kernel.org,yonghong.song@linux.dev,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,m@maowtm.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 20:30:03 +0000 (UTC)

--===============0455932225885287739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
> new file mode 100644
> index 000000000000..9f4ffb5f47be
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
> @@ -0,0 +1,54 @@

[ ... ]

> +static void test_from_fd_null(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
> +	struct lsm_policy_kfuncs *skel;
> +	char tmp_path[] = "/tmp/lsm_policy_kfuncs_XXXXXX";
> +	int tmp_fd, err;
> +
> +	tmp_fd = mkstemp(tmp_path);
> +	if (!ASSERT_GE(tmp_fd, 0, "mkstemp"))
> +		return;
> +
> +	skel = lsm_policy_kfuncs__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> +		goto out_close;
> +	skel->bss->plain_fd = tmp_fd;
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.check_from_fd),
> +				     &opts);
> +	if (!ASSERT_OK(err, "check_from_fd_run") ||
> +	    !ASSERT_OK(opts.retval, "check_from_fd_retval"))
> +		goto out_destroy;
> +
> +	ASSERT_TRUE(skel->bss->got_null_for_bad_fd, "bad_fd_null");
> +	ASSERT_TRUE(skel->bss->got_null_for_plain_fd, "plain_fd_null");
> +	ASSERT_TRUE(skel->bss->got_null_for_bad_flags, "bad_flags_null");
                                                   ^^^^^^^^^^^^^^^^
A subsystem pattern flags this as potentially concerning: the
"bad_flags_null" assertion passes whether or not the kernel honors the
reserved-flags contract.

The fd used for the flags test is the plain temporary file created above,
which no LSM claims. In bpf_lsm_policy_from_fd() (security/bpf_lsm_kfuncs.c)
there are two independent paths to NULL for this input:

    if (flags)
            return NULL;                    /* the check under test */

    lsm_for_each_hook(scall, policy_object_from_fd) {
            err = scall->hl->hook.policy_object_from_fd(fd, &object);
            if (err == -EOPNOTSUPP)
                    continue;
            ...
    }
    return NULL;                    /* unrelated: nobody claims a /tmp file */

Because the /tmp file is claimed by no LSM, the loop falls through to the
trailing return NULL on its own. Delete the if (flags) guard entirely and
"bad_flags_null" still passes. The assertion therefore holds whether or not
the kernel implements the reserved-flags contract that the commit message
claims this test verifies.

The other two arms do discriminate once an LSM implements the hook: for
fd == -1 the owning LSM's policy_object_from_fd() fails with a
non-EOPNOTSUPP error, and for a plain fd the LSM must return -EOPNOTSUPP
rather than claiming the file. Only the flags arm is unconditioned.

A discriminating flags test needs an fd that would resolve successfully
with flags == 0, which by design belongs in the LSM-specific test rather
than here. Could the commit message and comment clarify that the
reserved-flags contract is only partially covered here, or could this test
be deferred to an LSM that provides real policy objects?

> diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
> new file mode 100644
> index 000000000000..04080838aefd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
> @@ -0,0 +1,154 @@

[ ... ]

> +/*
> + * The fd kfunc is exclusive to syscall programs: it must be rejected
> + * in an LSM program, even on an allowed hook.
> + */
> +SEC("lsm.s/bprm_creds_for_exec")
> +__failure __msg("calling kernel function bpf_lsm_policy_from_fd is not allowed")
> +int BPF_PROG(lsm_get, struct linux_binprm *bprm)
          ^^^^^^^^

[ ... ]

> +/*
> + * The enforcement kfunc is exclusive to the sleepable bprm LSM
> + * hooks: it must be rejected in a syscall program.
> + */
> +SEC("syscall")
> +__failure __msg("calling kernel function bpf_lsm_policy_apply_bprm is not allowed")
> +int syscall_restrict(void *ctx)
     ^^^^^^^^^^^^^^^

This isn't a bug, but six of the eight programs in this file are named
after the condition they pin down (tracing_prog, wrong_hook,
nonsleepable_prog, leak_policy, acquire_untrusted, leak_shared_policy),
which makes a RUN_TESTS failure line self-explanatory. The other two are
named after the program type plus an operation that doesn't appear in the
interface: lsm_get and syscall_restrict. There is no 'get' or 'restrict'
kfunc. Would names in the same style as the neighbours - e.g. lsm_from_fd
and syscall_apply_bprm - make the failing subtest easier to place from
the RUN_TESTS output?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34398515657
--===============0455932225885287739==--
