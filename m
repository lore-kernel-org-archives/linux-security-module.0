Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A862F6562;
	Tue,  6 Oct 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249052; cv=none; b=i7r1Fabb/kcn8BUx6MIdPGBllFBMcv2mkNbepSvKBf2OCzhTydOFrV4WJYp4OmiUHFD5HBdHeE+t/tIYz4+e/scqdj1ptLOi6q9KZQlDNZBPBvAJHqIPQGmgofHJThGJhxPikgKJCij6BnzEXj4NjZWxhXMRHZtT5Le3jVlBlio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249052; c=relaxed/simple;
	bh=M8nREO4we0bTOlitpYAOAtVYtoHWqEAlEI74xKaMTzI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FkOCqCecYpi5TKXZCZaajz6EDbPv/iP4Jrjywj2RfurDwqhGo9+EJMqANGZ3ts8RMeX6jxt6jsx5DMw66PyBNPl3xyh7031OAdnwRlDp1qttLoyLk7tpAwpPpxlcdhcpYaz1qpiiXyYEIquwFAdgIJFkjfncoZFM3UVuAnYf39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oudYttVV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oudYttVV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028451F00893;
	Tue,  6 Oct 2026 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249051;
	bh=Ks4/SLJi7j1r1RC4xUxyjq1/MxyLPvGSxuSSl+QcraU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oudYttVVTjCvMwPOy4qUQeeAgxW5Yt06MoRVmEaWGrXvI53I9TZgKER36HEDoTtdL
	 vHm/ED9w49MvZrCTIoNmNgdbbTzF6t0LfmRpaq0D47Pydo5p5wJHWChGCkOfmM94lb
	 Iy0fjguJmljDiYR0ITG9H7j6/2T8l4nM4Fxhb5+sFN4giHuv/MhJOLzClzxjGk9404
	 S8iw5sxOFw/vROZwcWaUx7Tk9y7ryfA/5YwSXsahJ0h1aic8JjNhnjrZK6xWS/+D+1
	 dEVyYXV7ds5LQw3eIMNyw0609Ib/2/AbvX4oS6h1/Eh5t3MXzqisBwE8H2R7kq1ggk
	 l/+kOA1ha4hCw==
Content-Type: multipart/mixed; boundary="===============2458094724882306768=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ea38d86f4c0b9e3a152efb949421d2af3bcc50c03c620780eddc90ef28a9ad51@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-12-utilityemal77@gmail.com>
References: <20261006002020.2890858-12-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 11/12] bpf: add a lockless path ancestor iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:10:47 +0000 (UTC)

--===============2458094724882306768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: add a lockless path ancestor iterator

TL;DR:
- Verifier may give a plain trusted dentry from the lockless path iterator,
  risking use-after-free in sleepable kfuncs after RCU exit
- A failed legitimize may look like a finished walk, hiding a lost race

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 265cb414a08a..9dad65df4267 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c

[ ... ]

> @@ -633,6 +656,79 @@ bpf_path_ancestors_pos_flags(struct bpf_iter_path_ancestors *it__iter)

[ ... ]

> +/*
> + * Unlike the referenced variant, this hands out the walk's own position:
> + * a lockless iteration holds no references to pass on, and the verifier
> + * keeps the whole of it inside one RCU read-side critical section.
> + */
> +__bpf_kfunc struct path *
> +bpf_iter_path_ancestors_rcu_next(struct bpf_iter_path_ancestors_rcu *it)
> +{
> +	return bpf_path_ancestors_step((void *)it);
> +}

The commit message says that "nothing read out of the position may be passed
to a kfunc demanding a trusted argument", and the comment above struct
bpf_iter_path_ancestors says the same.  Does the verifier actually enforce
this?

The position returned by bpf_iter_path_ancestors_rcu_next() is typed
PTR_TO_BTF_ID | MEM_RCU, because check_kfunc_call() adds MEM_RCU to the
iter_next result of a KF_RCU_PROTECTED iterator.  Commit 7ed5aa71ad77 ("bpf:
mark struct path trusted") added:

    BTF_TYPE_SAFE_TRUSTED(struct path) {
            struct dentry *dentry;
    };

In check_ptr_to_btf_access(), the branch taken for
is_trusted_reg(env, reg) || is_rcu_reg(reg) applies type_is_trusted() and
sets PTR_TRUSTED on a safe-trusted field even when the base pointer is only
MEM_RCU.

So loading the dentry field of a lockless position yields a plain
PTR_TRUSTED dentry.  It does not keep MEM_RCU, so
invalidate_rcu_protected_refs() leaves it alone at bpf_rcu_read_unlock().

The safe-trusted rule for struct path assumes the path pins its dentry.  That
holds for the referenced variant, but the lockless walk takes no reference on
the dentry, and an ancestor's lifetime is not tied to the original path once
a concurrent rename moves the descendant.

After the program leaves the RCU read-side section, could a sleepable kfunc
that takes a trusted dentry (the xattr kfuncs in this set, for example) be
handed a dentry that has neither a reference nor RCU protection?

Would it work to keep MEM_RCU on fields loaded from a MEM_RCU struct path
(for example by applying the struct path safe-trusted rule only to trusted
bases), or to avoid exposing struct path as the return type of the lockless
iterator?  A negative selftest showing that such a load is rejected would
also help.

[ ... ]

> + * Return: 0, -%ENOENT if the lockless iteration was not on a position, or
> + * -%ECHILD if it lost the race to acquire one; %BPF_PATH_ANCESTORS_RETRY is
> + * then also flagged, and the program has reached no conclusion about the
> + * ancestry.  @it__uninit is initialized whatever this returns, so a program
> + * need not branch on the result: a walk that could not be escalated simply
> + * yields no position.
> + */
> +__bpf_kfunc int
> +bpf_path_ancestors_legitimize(struct bpf_iter_path_ancestors *it__uninit,
> +			      struct bpf_iter_path_ancestors_rcu *rcu_it__iter)
> +{
> +	struct bpf_path_ancestors_kern *rcu_kit = (void *)rcu_it__iter;
> +	struct bpf_path_ancestors_kern *kit = (void *)it__uninit;
> +
> +	/* A zeroed walk makes destroying the iterator a no-op. */
> +	memset(kit, 0, sizeof(*kit));
> +	kit->step = 1;
> +
> +	/* Drained, or already failed: nothing to hand over. */
> +	if (rcu_kit->step)
> +		return -ENOENT;
> +	if (!vfs_walk_handover(&kit->aw, &rcu_kit->aw)) {
> +		rcu_kit->step = -ECHILD;
> +		return -ECHILD;
> +	}
> +	kit->step = 0;
> +	return 0;
> +}

When the lockless iteration had already failed with -ECHILD, or when
vfs_walk_handover() fails, @it__uninit is left with step == 1.  That is the
same state as a referenced walk that has passed the real root, so
bpf_iter_path_ancestors_next() returns NULL and bpf_path_ancestors_pos_flags()
on that iterator returns 0.

The documented contract of bpf_iter_path_ancestors_next() says NULL comes
"once the walk has passed the real root - or on an allocation failure ...
reported as NOMEM", so a lost race reads as a completed walk.  The kernel-doc
above also tells programs they "need not branch on the result".

Can a policy program that follows that advice and only inspects the resumed
iterator treat a lost race as a finished ancestry walk with no match?
BPF_PATH_ANCESTORS_RETRY is flagged only on the lockless iterator, which has
to be destroyed before the resumed iteration can run.

Would setting kit->step = -ECHILD on the destination in both failure paths
work?  Stepping would still stop (step != 0), the zeroed walk would keep
destroy a no-op, and bpf_path_ancestors_pos_flags() on the resumed iterator
would report BPF_PATH_ANCESTORS_RETRY.

Separately, when the source had already lost a race, the first check returns
-ENOENT rather than -ECHILD, which conflicts with the kernel-doc describing
-ENOENT as "not on a position".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============2458094724882306768==--
