Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85534DCF3
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687949; cv=none; b=Br/2F7yKKkONW5VM790N0r9gWBMccbMNSGCV/XjF178tb6WgNzrzSUxI05Jmp7F+ni78slCE44kEoWa0ViuC9WUWicPrNpQuVfNrLA3rX9ZU0C1dShO6y6/2gX9jIvBf3ILxOwfKCKN20A8AjYA1kIy0GRbmkshEZtjA7d78fWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687949; c=relaxed/simple;
	bh=YXpCkIRS6fVhaRpeUhA4lmU88zI8Oy+lvcEXqLPQQq8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c5WAVbf+CYopmebcFovB5V4Z1s4Z3yxwgQDBeLaRJhZFrTsFApOzi/bzWyQcqXvN//FQLtQxMIOQJCnLUT6TllC8062gB/1YSRgfTHh0nueu8yWLuevb5xzOix5giNozfXblyRwX5N2SvG4zulc5PG3W/wPW1pJhn2xRxwrwekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHI5M/kw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHI5M/kw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7AC1F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687948;
	bh=OpIIpjMc85GThQ5SR9qbsXEaQ0+Fm00pb45RrlpBNz4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=cHI5M/kwPpuCLZrD9+E/qmBqXHeqJIh/sYh+PQe8yHI9AvfZcLxNOeEF9RkikWVYz
	 n+TsbHpkQxL8d5mkRhTf3fscDAUdKzaUxWY+D9fKUV+kEtOJWQixbjur2OfqNO5JMt
	 AQTvt6j5LDy6JTndhhzRazw0zHjsxJ3jgn05AQsJLF/jcDpSM92WRlx+VIiuN1MjxI
	 UH32Yn32NzR9kDDbBk37HrpR1jHNSa/wM7M7HamBs6dGBMWntFv2doQVMtta/jom40
	 f6FgIn33WZxuY1uSg3eMAh/TtrfT0acWgIxcNEbTxilFNYz2u0WQphcfKD/oKhapqt
	 ROoJWq7wL1GWA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] security: Add PR_CAPBSET_DROP_MASK for
 process-wide bounding-set drops
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260929130200.1638343-3-ruanjinjie@huawei.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:19:07 +0000
Message-Id: <20260929131907.DA7AC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] userns: PR_CAPBSET_DROP_MASK leaks into new user namespaces
- [High] cred: PR_CAPBSET_DROP_MASK breaks self-containment of struct cred
--

commit fcb774e0491f03726a243dd79d9b587551550d6e
Author: Jinjie Ruan <ruanjinjie@huawei.com>

security: Add PR_CAPBSET_DROP_MASK for process-wide bounding-set drops

This commit introduces a new prctl, PR_CAPBSET_DROP_MASK, to drop bounding =
set
capabilities across an entire thread group simultaneously. It achieves this=
 by
storing a pending drop mask in the signal_struct and dynamically subtracting
it during capability checks.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fec..3bec15d437312 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
[ ... ]
> @@ -30,6 +32,25 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/capability.h>
> =20
> +/**
> + * Effective bounding set of @cred in @task's thread group
> + * @task: task whose thread group's pending drop applies
> + * @cred: credentials to read the bounding set from
> + *
> + * A drop recorded by PR_CAPBSET_DROP_MASK is authoritative on the threa=
d group
> + * and may not have been materialized into every thread's cred yet, so t=
he
> + * effective bounding set is the cred's own set minus the group's pendin=
g drop.
> + */
> +kernel_cap_t cap_bset_effective(const struct task_struct *task,
> +				const struct cred *cred)
> +{
> +	kernel_cap_t pending =3D {
> +		.val =3D atomic64_read(&task->signal->cap_bset_pending),
> +	};
> +
> +	return cap_drop(cred->cap_bset, pending);
> +}

[Severity: High]
Does this dynamic subtraction inadvertently leak parent bounding set drops =
into
new user namespaces?

When a new user namespace is created via clone(CLONE_NEWUSER) or unshare(),
set_cred_user_ns() resets cred->cap_bset to CAP_FULL_SET to ensure the new
namespace starts with full capabilities relative to itself.

However, because cap_bset_effective() dynamically subtracts the pending mask
from task->signal, any pending drops from the parent namespace will still be
applied to the new namespace's credentials. This could permanently restrict
them.

[ ... ]
> @@ -1283,6 +1306,63 @@ static int cap_prctl_drop(unsigned long cap)
>  	return commit_creds(new);
>  }
> =20
> +static int cap_bset_drop_process(kernel_cap_t mask)
> +{
> +	kernel_cap_t pending;
> +	struct cred *new;
> +
> +	new =3D prepare_creds();
> +	if (!new)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Record the drop before committing the caller's cred, so that a
> +	 * thread created from now on is guaranteed to observe it.  Apply the
> +	 * current union, not just this call's mask, to the caller's cred.
> +	 */
> +	spin_lock_irq(&current->sighand->siglock);
> +	atomic64_or(mask.val, &current->signal->cap_bset_pending);

[Severity: High]
Does storing the capability drop outside of struct cred break subsystems th=
at
rely on the immutability and self-containment of saved credentials?

If a thread calls PR_CAPBSET_DROP_MASK, while another thread in the same
group opens an AppArmor-mediated file, that file saves the thread's stale
credential (e.g., in file->f_cred).

AppArmor might then evaluate the bounding set directly from this standalone
credential snapshot (like in is_subset_of_obj_privilege()). By placing the
drop state in signal_struct rather than struct cred, these asynchronous
evaluations will miss the pending drops.

Could this lead to false denials or security bypasses because the capability
evaluations are using stale capabilities?

> +	pending.val =3D atomic64_read(&current->signal->cap_bset_pending);
> +	spin_unlock_irq(&current->sighand->siglock);
> +
> +	new->cap_bset =3D cap_drop(new->cap_bset, pending);
> +	commit_creds(new);
> +
> +	return 0;
> +}
> +
> +/*
> + * Propagate a pending process-wide bounding-set drop to @p, a task being
> + * created by the current thread.  Threads sharing the group read
> + * current->signal->cap_bset_pending directly; a forked child gets its o=
wn
> + * signal_struct and must carry the mask itself.  Called under
> + * current->sighand->siglock, which serializes it with cap_bset_drop_pro=
cess().
> + */
> +void cap_bset_drop_fork(struct task_struct *p)
> +{
> +	kernel_cap_t mask =3D {
> +		.val =3D atomic64_read(&current->signal->cap_bset_pending),
> +	};
> +
> +	if (cap_isclear(mask) || p->signal =3D=3D current->signal)
> +		return;
> +
> +	atomic64_or(mask.val, &p->signal->cap_bset_pending);
> +}

[Severity: High]
Does actively copying the parent's dropped capabilities mask into a newly
created process erase namespace isolation boundaries?

When CLONE_NEWUSER is requested, the child is meant to receive a full
bounding set within its new namespace.

Because cap_bset_drop_fork() copies the parent's pending mask into the
child's signal_struct without clearing it for new user namespaces, those
capability drops will bleed into the child's effective bounding set. This
breaks the isolation guarantees of user namespaces.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929130200.1638=
343-1-ruanjinjie@huawei.com?part=3D2
