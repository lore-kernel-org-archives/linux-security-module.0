Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB63522698;
	Tue, 13 Oct 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913816; cv=none; b=DmCKeI7NxqKky/vUjbpIshdN3P3kOXgE2NvnKhGnrslzS2gXc41EHUci9NtZUbWySc7Pa+T79yo4wVJxReMPo+PKMQ+4sKW3g0PGdKOGg/Co9UZsmdF1um8O5O/q/3A94IO9R8KgeRnPdBL9C+K2Mp5byHTikvPNFweeHhljtdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913816; c=relaxed/simple;
	bh=Ob5hfSVRBDVFo9k7LYylFgt6ZwRA0BvD9bQTXcqDE6A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bEcNpEjyUfso9B6TnIB3w9KMgTlJQVfNYjxxDLC+kgDTf3zHguZSHToMY1S9CdNvxGyHndq0n0Hhs9Y/FZmrKtsjsmBYSoEckR5dOGli0w72S1qZqdMO76+wOu3eoaSY1G5ZzE7rAY9TxLQ6xDHsE5e8TiVPQlJQX0sb1znLAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkS3R4le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkS3R4le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859851F000FF;
	Tue, 13 Oct 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913811;
	bh=/4OBcQphtPzD4TvEvZfIteR9fXjco/MRVw8nWpXqrVw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LkS3R4le+63v5wkxJTVG8Dx4CsBOlu4SrUpA0wXL8a1uk2tJS4QREU/I7idEHhO/0
	 p5V2Tv3xg/A2Cp2LiEcD5aW0d3861PtOd36ZIAPTg0+hTZT8F9VT865HCnDk+9GlIy
	 mxSx0w6SPL4i2ST9O9zahMHJadZobnR02xCvpY/drzH+JQtGB3WApOE1BhAew5gxcZ
	 /6Sk4QTQFT9E+dwM82NSEq5KvZ8onfNKSpEXaa+WieJmy0yf2lKUvJXxAFQhxAn2Sb
	 mp8eDxXHSjsUnrlLb8Uffw3xIUjMRX2LKtcT27GdNG7KuE0eRYQZz/Hx0WysMUCBPv
	 9KXOhYv4YpuEA==
Content-Type: multipart/mixed; boundary="===============3729759909576102404=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <507772738f9dbf7abfad7d2910b6b155517e597dbb076aafb7c9f4bf01e322e7@mail.kernel.org>
In-Reply-To: <20261013164800.2906577-12-utilityemal77@gmail.com>
References: <20261013164800.2906577-12-utilityemal77@gmail.com>
Subject: Re: [PATCH bpf-next v1 11/11] selftests/bpf: exercise the lockless path ancestor iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 13 Oct 2026 17:50:08 +0000 (UTC)

--===============3729759909576102404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: exercise the lockless path ancestor iterator

TL;DR: Commit message and test comment call d_path on the escalated position
"sleepable work", but bpf_path_d_path() doesn't look KF_SLEEPABLE; it likely
needs a trusted pointer. Wording only, no code bug suggested.

>     selftests/bpf: exercise the lockless path ancestor iterator
>
>     Walk the same ancestry four ways and require the position counts to
>     agree: lockless from a non-sleepable program, where the RCU critical
>     section is implicit; lockless under an explicit bpf_rcu_read_lock();
>     referenced; and the hybrid that walks lockless to the second position,
>     hands it over to a referenced iteration, and resumes there - the
>     escalated position therefore being walked twice, once per mode.
>
>     The sleepable work the escalation exists for (d_path on the escalated
>     position) runs on the resumed iteration's first position, after
>     bpf_rcu_read_unlock(), which is the only place a sleepable kfunc can
>     run at all.
>
>     Signed-off-by: Justin Suess <utilityemal77@gmail.com>

The commit message calls d_path on the escalated position "the sleepable
work the escalation exists for".  Is bpf_path_d_path() a sleepable kfunc?

It is registered without KF_SLEEPABLE in fs/bpf_fs_kfuncs.c, unlike
bpf_get_dentry_xattr() right next to it:

    BTF_ID_FLAGS(func, bpf_path_d_path)
    BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)

The reason the test needs the escalated position for d_path looks like trust
rather than sleepability.  bpf_iter_path_ancestors_rcu_new() is
KF_RCU_PROTECTED, so the verifier types the pointer returned by
bpf_iter_path_ancestors_rcu_next() as PTR_TO_BTF_ID | MEM_RCU.
bpf_path_d_path() is not KF_RCU, so it needs a trusted argument and would
reject that pointer.  The previous patch's changelog describes the same
constraint:

> nothing read out of the position may be passed
> to a kfunc demanding a trusted argument.

The comment in the test program has the same framing:

> diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/testing/selftests/bpf/progs/path_ancestors.c
> index 6287f5099a18..3ebf86b23199 100644
> --- a/tools/testing/selftests/bpf/progs/path_ancestors.c
> +++ b/tools/testing/selftests/bpf/progs/path_ancestors.c

[ ... ]

> @@ -70,5 +111,36 @@ int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,

[ ... ]

> +	/*
> +	 * Out of the RCU critical section.  The resumed iteration's first
> +	 * position is the escalated one, kept alive by the reference the
> +	 * iteration hands out, so sleepable work can run on it.
> +	 */
> +	while ((pos = bpf_iter_path_ancestors_next(&it))) {
> +		hybrid_count++;
> +		if (hybrid_count == 3)
> +			escalated_len = bpf_path_d_path(pos, escalated_path,
> +							sizeof(escalated_path));

Beyond the iterator's own bpf_iter_path_ancestors_next() and
bpf_path_put(), does the test run any sleepable work on the escalated
position?

Could the commit message (and this comment) say that d_path needs a
trusted/referenced position, or could the test call a KF_SLEEPABLE kfunc
such as bpf_get_dentry_xattr() on the escalated position so that the
description matches what is checked?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38437592296
--===============3729759909576102404==--
