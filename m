Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3114F5E08
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071577; cv=none; b=XPJJyPoekJrMNzJm8Wf2mmiZ3ds+p5E3ahUay9KP2rWwLXgP4Tm9ZXcXUch30c30bGUPohxWIdm2Xjgg5v4Q1jYM8/AGZ9GU0453XqMrk0i6lx2aNdDJNJ5eqaIQsKyGzPeanKe/k1Ven+jbmoGpXqFTFWvX6+pr/QZdSf1M/BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071577; c=relaxed/simple;
	bh=ugvR5jc/SG646C8b/cBwumoFG4JzGWHqOzH1P4LSUWY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqF3eNXL8E+hrRJzKYDJrXJgh9eLSh5z7OBq0klERmiyZMlF4j1gXfnzp+rqrL3gPzQva/z1UzmR4I0TZIiReZbZv1iGSyBU8OcCCKhTQ9tE6wJRcn0n2maJ1jWqG7PtuvAZbNPw5CAKtwZcZg/EropxUieY/PyST9UVqXAwmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6yZBLw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6yZBLw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8C11F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 22 Sep 2026 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071575;
	bh=iyOFtQIdT8jZw+6T9t3tVcEZgsZNeyLLfXJas0qEQIU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=N6yZBLw+vJV9nsLBv6LjHkR5rQHHj1jJDyf9xQG4TLaIGAV+2Yj1E5Pu/S5cpAER4
	 02QtwtLOz4qSz+9mFoJDF/JKP6t451LULp9y3uMue0kfkBO74DMnWRwjGYOl34UN3z
	 nUd7x3TxsILEZ/L45FcwW0zMQWD/6HBpmJt6TSuX6Dtlnp7hv3dMk/JJBKenv4JOTR
	 NQ5S0zu/0bSR2Vqs/J5bGGlobZ62mThoY9y2UxtnYAC1QckI3QGGDTnjmix8ufBe3e
	 AA0yP0Wt9f+6wZguNyLnOKXmtUr8v7aBKTR8frLv625M9bURrkQmLQCVxVnL3banxM
	 jZkqtX1oXaadQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] security: Allow dropping bounding set process-wide
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260922095816.1191799-1-ruanjinjie@huawei.com>
References: <20260922095816.1191799-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:06:14 +0000
Message-Id: <20260922100615.5F8C11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] security: PR_CAPBSET_DROP_MASK fails open on memory allocation=
 failure
- [High] security: unbounded GFP_ATOMIC allocations in cap_bset_drop_process
--

commit 4012a62a02d93ede388203c8691ecc0410b4a911
Author: Jinjie Ruan <ruanjinjie@huawei.com>

security: Allow dropping bounding set process-wide

This commit adds a new prctl, PR_CAPBSET_DROP_MASK, to drop capabilities fr=
om
the bounding set of all threads in a thread group simultaneously. It achiev=
es
this synchronously for the calling thread and queues a task_work item for e=
ach
sibling thread.

> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fec..ae7ce50a81518 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c

[ ... ]

> @@ -1283,6 +1290,123 @@ static int cap_prctl_drop(unsigned long cap)
>  	return commit_creds(new);
>  }
> =20
> +/*
> + * Structure used to queue process-wide bounding set drops via task_work.
> + */
> +struct cap_bset_drop_work {
> +	struct callback_head work;
> +	struct task_struct *task;
> +	kernel_cap_t mask;
> +	struct cap_bset_drop_work *next;
> +};
> +
> +static void cap_bset_drop_work_fn(struct callback_head *work)
> +{
> +	struct cap_bset_drop_work *w =3D container_of(work, struct cap_bset_dro=
p_work, work);
> +	struct cred *new =3D prepare_creds();
> +
> +	if (!new) {
> +		/* Out of memory: bounding set drop failed silently for this thread. */
> +		pr_warn_ratelimited("capability bounding set drop failed for pid %d (%=
s)\n",
> +				    task_pid_nr(current), current->comm);
> +		goto out;
> +	}

[Severity: Critical]
Does this handle memory allocation failures safely?

If prepare_creds() fails, the capability drop is skipped and the target thr=
ead
retains its capabilities. However, the original prctl() caller has already
received a success code and may assume the entire process is successfully
sandboxed.

Should this fail closed (for example, by forcing a SIGKILL) to prevent
bypassing the intended security boundary?

> +
> +	new->cap_bset =3D cap_drop(new->cap_bset, w->mask);
> +	commit_creds(new);
> +
> +out:
> +	put_task_struct(w->task);
> +	kfree(w);
> +}
> +
> +/*
> + * cap_bset_drop_process - Drop capabilities from all threads in the gro=
up.
> + * @mask: Mask of capabilities to drop from the bounding set.
> + *
> + * Drops @mask from the calling thread synchronously, and queues a task_=
work
> + * item for each sibling thread to safely apply the drop in its own cont=
ext.
> + *
> + * The caller must hold CAP_SETPCAP. Thread group must be quiescent to a=
void
> + * racing with concurrent thread creation.
> + *
> + * Returns 0 on success, or -ENOMEM if allocations fail (all-or-nothing).
> + */
> +static int cap_bset_drop_process(kernel_cap_t mask)
> +{
> +	struct cap_bset_drop_work *list =3D NULL, *w, *next;
> +	struct task_struct *thread;
> +	struct cred *new =3D NULL;
> +	int ret =3D 0;
> +
> +	rcu_read_lock();
> +	for_each_thread(current, thread) {
> +		const struct cred *cred;
> +
> +		if (thread =3D=3D current || (thread->flags & PF_EXITING))
> +			continue;
> +
> +		cred =3D __task_cred(thread);
> +		if (cap_isclear(cap_intersect(cred->cap_bset, mask)))
> +			continue;
> +
> +		w =3D kmalloc_obj(*w, GFP_ATOMIC);
> +		if (!w) {
> +			ret =3D -ENOMEM;
> +			break;
> +		}

[Severity: High]
Can this loop exhaust the atomic memory pool?

An unprivileged user could create tens of thousands of threads and then call
prctl(PR_CAPBSET_DROP_MASK). This would execute an unbounded number of
GFP_ATOMIC allocations sequentially inside an RCU read-side critical sectio=
n,
which could deplete emergency memory reserves and cause system instability.

> +
> +		w->task =3D get_task_struct(thread);
> +		w->mask =3D mask;
> +		w->next =3D list;
> +		list =3D w;
> +	}
> +	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922095816.1191=
799-1-ruanjinjie@huawei.com?part=3D1
