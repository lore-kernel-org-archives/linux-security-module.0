Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3B6322A;
	Tue,  6 Oct 2026 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249042; cv=none; b=Wdtbct1RgCeo+5rLbxQ+3fmsKcyWsiT/nj4qebtzLw8yrXsq4IliBKE5USmd0BBsvS3yEYhPvlMYbZ/Zf5bYl1akfg1rvvI4hQ1M1PVYPq3FdLzx8hqPDFzGKsTJY4LWKmNW6zMj1m1EEuuCZWMtvVeU95r+nVjfP/uuVePjFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249042; c=relaxed/simple;
	bh=sxnTkqR+vm8SiKyQFUWNEvhaxp47OkwdlFja4qn7fNQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qYhZEV++wXEXYF3vYw7S1zKTD2c9UdWg0+9kHTrAeY/MkZN+2wIIs7a2yFL6ifhxxL7XhCniLvz2KfrrZP0XSXp7k3NIoPDnkoV8LQExwfOb22R06OOpCrTDNdzPpTBI0Ei9ViE9rCN53ORKMKHa3HmQ2mTR+cfHmBArGMduPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gc57P0cF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc57P0cF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539271F000FF;
	Tue,  6 Oct 2026 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249041;
	bh=ZRYXUv5Y0gn/oX3YAGCjiDaA+ZqxyBLvk/z6clYzlfk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gc57P0cF9r7wFk+9n8p2SOQFM1BvdMsDBzISC3iVZ4xeTBhN1dGWQ0C5b9IQbG332
	 mPEGjw0BW1RGfLvilf6A1zUQqMa2LfXDf9G6bRpfgTahsCodl0gxht5gTiw5Mlegiv
	 ImQges7V1rPCjZP00M4v635ISjajsE4QSVwmxprFyhHjIGeoL9/aX/zS3nOqR7hjyM
	 wZJ8rw2mOiMfiAMFLzVqMVJ1kA+UdoRYa3KqnURCQW2kfynEFbqJPiKx5deKiKk/n6
	 B0oWvpe6crHYQqYeS11I5P3DWIWwEZskkIkeRq4hhY8disDIFlWBnEyNABINqTh6z+
	 /wKt//npIyVYw==
Content-Type: multipart/mixed; boundary="===============7971462709617409608=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fbbc96aa0c1136bc3be8eb893db4651f2928f130f47eec2d7d9082207ce27aac@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-13-utilityemal77@gmail.com>
References: <20261006002020.2890858-13-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: exercise the lockless path ancestor iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:38 +0000 (UTC)

--===============7971462709617409608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: exercise the lockless path ancestor iterator

TL;DR: Test issue in path_ancestors selftest: if setxattr() gives EOPNOTSUPP,
the xattr checks are silently dropped and the run reports a full pass. Also a
redundant test_err variable and a stale comment (nits).

> diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
> index 2de79673a13b..ce1ded844c3a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
> +++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c

[ ... ]

> @@ -20,6 +23,12 @@ void test_path_ancestors(void)
>  	if (!ASSERT_OK(mkdir(suba, 0755), "mkdir_a"))
>  		goto out_rm;
>  
> +	/* Read back by the program at the escalated position (== base). */
> +	err = setxattr(base, "user.walk", "hello", 6, 0);
> +	xattr_works = !err;
> +	if (err && errno != EOPNOTSUPP && !ASSERT_OK(err, "setxattr"))
> +		goto out_rm;
> +

[ ... ]

> @@ -31,14 +40,34 @@ void test_path_ancestors(void)

[ ... ]

> +	/* The escalated position is the walk's second one: base. */
> +	ASSERT_STREQ(skel->bss->escalated_path, base, "escalated_path");
> +	ASSERT_EQ(skel->bss->escalated_len, strlen(base) + 1, "escalated_len");
> +	if (xattr_works) {
> +		ASSERT_EQ(skel->bss->xattr_ret, 6, "xattr_len");
> +		ASSERT_STREQ(skel->bss->xattr_value, "hello", "xattr_value");
> +	}
> +

When setxattr() fails with EOPNOTSUPP (for example /tmp on a tmpfs built
without CONFIG_TMPFS_XATTR), xattr_works is false and the xattr_ret and
xattr_value checks are dropped without any message.  test__skip() is not
called either, so the run reports a full pass.

A subsystem pattern flags this as potentially concerning: a test that
skips a capability-dependent check should say why, rather than skipping
silently.

The rest of the test (walk counts, d_path on the escalated position)
still runs, and the program's bpf_get_dentry_xattr() call just returns an
error that nothing looks at, so nothing fails spuriously.  But the xattr
read is one of the two sleepable operations the commit message says the
escalation exists for, and its coverage disappears from the report.

prog_tests/fs_kfuncs.c handles the same errno from setxattr() on /tmp
explicitly:

	if (err && errno == EOPNOTSUPP) {
		printf("%s:SKIP:local fs doesn't support xattr (%d)\n"
		       "To run this test, make sure /tmp filesystem supports xattr.\n",
		       __func__, errno);
		test__skip();
		...
	}

Could this test print a similar note, or run the xattr check as a subtest
that reports itself skipped, when xattr_works is false?

> diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
> index af6b777e8bec..50ce0ce163dd 100644
> --- a/tools/testing/selftests/bpf/progs/path_ancestors.c
> +++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
> @@ -11,29 +11,74 @@ char _license[] SEC("license") = "GPL";

[ ... ]

> +int retry_flags;	/* BPF_PATH_ANCESTORS_RETRY observations */

[ ... ]

> +int escalate_err;	/* bpf_path_ancestors_legitimize() result */
> +int test_err;

[ ... ]

> @@ -45,5 +90,45 @@ int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,

[ ... ]

> +	escalate_err = bpf_path_ancestors_legitimize(&it, &rit);
> +	retry_flags |= bpf_path_ancestors_rcu_pos_flags(&rit);
> +	bpf_iter_path_ancestors_rcu_destroy(&rit);
> +	bpf_rcu_read_unlock();
> +
> +	if (escalate_err)
> +		test_err = 1;

this isn't a bug, but is test_err needed alongside escalate_err?  It is
set in exactly one place, from escalate_err being nonzero:

	if (escalate_err)
		test_err = 1;

and the userspace half asserts both of them are 0 one after the other:

	ASSERT_EQ(skel->bss->test_err, 0, "test_err");
	ASSERT_EQ(skel->bss->escalate_err, 0, "escalate_err");

Could the program keep just escalate_err, which already records the actual
error code, and have the test assert only that?

test_err is also the only new global without a describing comment.

Separately, the retry_flags comment only mentions BPF_PATH_ANCESTORS_RETRY
observations, but at the hybrid escalation point it ORs in the whole
bpf_path_ancestors_rcu_pos_flags() result, not just the RETRY bit.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============7971462709617409608==--
