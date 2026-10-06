Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365F1E9B37;
	Tue,  6 Oct 2026 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249049; cv=none; b=oz07qAx6tYncHAWFsCsZOMVBHDNkO88ME/kqvHAheCLsOAeE1QpPIRcd7uGOoiaFUsVULJnP0opxcIpzsAGAjuR1+mfYA7V/m+VJM6ZOPB9ErF+JC2j6xIftpeu9vbh27MZhTppDoe2XQWEs68imSSrKNFAJEcUle+hPoma4258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249049; c=relaxed/simple;
	bh=c/RtUCRYPmETzjfsYj7e8hDtz1431ghm4uy3PDgTrnU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NRTd0WWxAUG0gRTW5Ko2NN07mRu6OpiYv5I1k4WwVLHo40qMCmzbHtk50Od7Viwrwy3ml8gopyeb+PeQJ7DQntXOxCTywbT6xeKUhEsbrlYH7zRdV2LTAuT907370L91Nh1Evox/80RqiDyl5ZuRNMvBSYRBsoguH+04kfp+2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuBAH+b4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuBAH+b4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDA41F000FF;
	Tue,  6 Oct 2026 01:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249046;
	bh=rGo1pwgoYQeyVbQFtgV0EiNRwQ6onxe693ZW4zp10Ks=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TuBAH+b4um3a4XJaHW95fCzam0OmWE9w8ZSWvRG6TsxLL64Lq7a8cNflCLwFp047b
	 ZI6oVCLk7nkPnPtgxbQBmMs4nMgpDndR+OwLK+kvv5lSse3S7PlRlGsrmrmcatPhRo
	 uQzHibznu1dI3OgCY/iEMKSvoLT4RQQyDQnNMPfnRZ70Yq33qb6JO31RYOt/lovxcO
	 QbYCVfXvZFmivlkV81YM6EeWt1ZVBID5KJgqdOjqjNScgpMfAZaqTa04vS98uOjldV
	 QpCVFpqLbhGVLaWTnsNSQKqoxixqs6SKQ5EzGSlRx1hcEL8d/+UX6SkkHZawT2KFfU
	 Cg37A6ImLgkJg==
Content-Type: multipart/mixed; boundary="===============6402484618830813346=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9af3aa5a53840bc61740e91ae068bf73611b4d6c586a2283e13a4b49bb369181@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-8-utilityemal77@gmail.com>
References: <20261006002020.2890858-8-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 07/12] selftests/bpf: exercise the path ancestor iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:43 +0000 (UTC)

--===============6402484618830813346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: exercise the path ancestor iterator

TL;DR:
- Selftest's ref_count >= 3 may not verify the walk reaches /; early stop or
  bad mount crossing could pass
- Test may not exercise using a position after a later step, as its commit
  message and comment claim

> diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
> new file mode 100644
> index 000000000000..2de79673a13b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
> @@ -0,0 +1,48 @@

[ ... ]

> +	/* suba, base, /tmp, / at least. */
> +	ASSERT_GE(skel->bss->ref_count, 3, "ref_count");
> +	ASSERT_EQ(skel->bss->ref_flags, 0, "ref_flags");

The comment lists four positions (suba, base, /tmp, /), and the commit
message says the test checks "that the iteration reaches the root: the
temporary directory, its parent and / are visited".  Does ref_count >= 3
verify that?

For /tmp/path_ancestors_XXXXXX/a the walk should yield at least four
positions, so a count of exactly 3 would mean the walk stopped before /.
Two cases that would pass this check:

- a broken mount crossing out of a tmpfs /tmp, where the iteration ends at
  the tmpfs root.

- an iteration ended early by the allocation failure path in
  bpf_iter_path_ancestors_next():

    held = kmalloc_obj(*held);
    if (!held) {
        kit->step = -ENOMEM;
        return NULL;
    }

The ref_flags check cannot catch the second case, since
bpf_path_ancestors_pos_flags() is only called from the loop for positions
that were returned, and at that point kit->step is still 0.

Should this be ASSERT_GE(skel->bss->ref_count, 4, "ref_count")?  Should the
program also record bpf_path_ancestors_pos_flags() after the loop ends and
check that the last position was the root, so that "reaches the root" is
actually verified?

The follow-up commit 70352ce0817c ("selftests/bpf: exercise the lockless
path ancestor iterator") keeps the same comment and the same ">= 3" lower
bound (on rcu_count), so this is not tightened later in the series.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
> new file mode 100644
> index 000000000000..af6b777e8bec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
> @@ -0,0 +1,49 @@

[ ... ]

> +	/*
> +	 * Referenced walk: every position comes acquired, so it stays valid
> +	 * for sleepable work and past the step that yielded it.
> +	 */
> +	bpf_iter_path_ancestors_new(&it, (struct path *)dir, 0);
> +	while ((pos = bpf_iter_path_ancestors_next(&it))) {
> +		ref_count++;
> +		ref_flags |= bpf_path_ancestors_pos_flags(&it);
> +		if (ref_count == 2)
> +			second_len = bpf_path_d_path(pos, second_path,
> +						     sizeof(second_path));
> +		bpf_path_put(pos);
> +	}

The commit message says the second position's pathname is resolved "from
the acquired position after the step that yielded it has been taken, so
that the acquired reference is what the sleepable kfunc runs on rather than
the walk's", and the test comment says "The acquired second position, used
after its step was taken."  Does this loop exercise that?

bpf_path_d_path() does not look sleepable.  It is registered without
KF_SLEEPABLE:

    BTF_ID_FLAGS(func, bpf_path_d_path)

Also, bpf_path_d_path(pos, ...) is called before the next
bpf_iter_path_ancestors_next() call.  At that point the walk's own view
still refers to the same position with its own reference, because
bpf_path_ancestors_step() returns &kit->aw.pos and vfs_walk_step_ref() only
drops that reference at the next step:

    dput(aw->pos.dentry);
    aw->pos.dentry = parent;

So during bpf_path_d_path() the position is held by both the acquired copy
and the walk, and the assertion on second_path cannot tell whether the
acquired reference is what keeps it alive.  Choosing ref_count == 2 instead
of the first position makes no difference here.

The commit 8dd2a68fe0e7 ("bpf: add a path ancestor iterator") justifies the
per-position allocation and KF_ACQUIRE with "a position that outlives the
step it came from ... has to be kept alive by the program's reference
rather than by the iterator's".  This test never uses a position after a
later step.

Could the program use a position after the next step, without a loop?  For
example:

    pos1 = bpf_iter_path_ancestors_next(&it);
    pos2 = bpf_iter_path_ancestors_next(&it);
    bpf_path_put(pos2);
    bpf_path_d_path(pos1, ...);
    bpf_path_put(pos1);

Otherwise, could the commit message and the test comment be reworded to
match what is tested?  The follow-up commit 70352ce0817c leaves this check
and comment unchanged.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============6402484618830813346==--
