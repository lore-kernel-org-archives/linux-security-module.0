Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B8528442
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687498; cv=none; b=p2NslPhxb3V+R8PEdGtCJz/fMIMUqNa8deAr8MLIn9XMYymPTUwObFo2n0rY4YfoEHi31l+/mzRXB0bmlPN4hEHvHfFpqvJLutsHKGh+7JJyo7aXn2UYjAbudzhryR7lfZNsJyZMkJULXFjfg4uQ+TrdbuKzTL+jBmW4+kOVfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687498; c=relaxed/simple;
	bh=cWz/Jad5MMAHHi3+lcSDcKlklSDX1RPv3AWyQ464/nI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gZqiTNhYnQhBC9Dju9B+K2o9grn4Juv2qXgd+BkbdBNfwXeH3uZ22Tdyuij6tjhJoQb92NZFWwDLvG6P/a+FT9Ty2PPKNh0pfSxa+j4GeEvVUCSA/3DcplRSCUyusuWmO3VtKLPh5nW1tMFdk6nRGzLc7zS48SKADI2VZ/PFRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtVexGRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtVexGRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40351F000FF
	for <linux-security-module@vger.kernel.org>; Tue, 29 Sep 2026 13:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790687495;
	bh=q0v4CerJzwc5+HMrbwosTYI95h9QzfpsJPKEz0162UE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YtVexGRwY6eO562zBbMMZ9IqBZoI4NnCrZrxvJi7kJxVUG9peWJCQ4fya5o1B+0kQ
	 bFMWe4sC7i1jh/TRwdJLMhhcpHnLc2c+6Qhbo2vhggdpO00Br3xsSzJQmlmOsifP6E
	 NVwG3sokk3SDPGVAVBCwelmNJKoE1REn9dIp7lemEw2H7kSmbuzTXv6gIZjVeIKnVh
	 urrQI/jjEJpnGzn/SCQJp+m1OIxGKQ3028WAotyRR5Ftv5Lf/5ZpX3V2F/WKx0iAtw
	 uvP16jgcgBZuMdIgRIH+SGAVRT7nkNwK/LRQ3sLW27zh7/06EJLlWmWnBYO673mT82
	 WYVc6hXFfM7gA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] selftests: prctl: add process-wide
 bounding-set drop tests
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260929130200.1638343-4-ruanjinjie@huawei.com>
References: <20260929130200.1638343-1-ruanjinjie@huawei.com>
 <20260929130200.1638343-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:11:35 +0000
Message-Id: <20260929131135.B40351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests: prctl: test fails to verify concurrent thread creatio=
n due to synchronous pthread_join
- [Medium] selftests: prctl: deadlock on drop_cap() error path in conc_test=
_child()
- [Medium] selftests: prctl: uninitialized thread ID passed to pthread_join=
() on pthread_create() failure
- [Medium] selftests: prctl: unmaterialized drop inheritance test is nullif=
ied by syscall before fork
--

commit efe86d5c1a9f1d9daea13c0d844c2621fc972d8d
Author: Jinjie Ruan <ruanjinjie@huawei.com>
Subject: selftests: prctl: add process-wide bounding-set drop tests

This commit adds tests for PR_CAPBSET_DROP_MASK. It covers argument validat=
ion,
permission checking, and process-wide application of the bounding set drop
across sibling threads and forked children.

> diff --git a/tools/testing/selftests/prctl/cap-bset-drop-test.c b/tools/t=
esting/selftests/prctl/cap-bset-drop-test.c
> new file mode 100644
> index 0000000000000..d0432f9b58377
> --- /dev/null
> +++ b/tools/testing/selftests/prctl/cap-bset-drop-test.c

[ ... ]

> +static void *fork_sibling(void *arg)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	(void)arg;
> +
> +	while (!atomic_load(&fork_go))
> +		sched_yield();
> +
> +	if (bset_has(dropped_cap))
> +		atomic_store(&fork_ok, 0);
> +
> +	pid =3D fork();

[Severity: Medium]
Does calling bset_has() here defeat the purpose of the test? bset_has() inv=
okes
prctl(), which is a syscall. Returning to userspace from this syscall forces
pending task work (TIF_NOTIFY_RESUME) to be processed, fully materializing =
the
credentials before fork() occurs. This nullifies the intent of verifying th=
at an
unmaterialized drop is properly inherited by a child thread.

> +	if (pid =3D=3D 0)
> +		_exit(bset_has(dropped_cap) ? 1 : 0);

[ ... ]

> +static void *conc_spawner(void *arg)
> +{
> +	(void)arg;
> +
> +	while (!atomic_load(&conc_stop)) {
> +		pthread_t t;
> +
> +		if (pthread_create(&t, NULL, conc_worker, NULL) =3D=3D 0)
> +			pthread_join(t, NULL);

[Severity: Medium]
Does this synchronous wait serialize thread creation? Calling pthread_join()
immediately after pthread_create() blocks the spawner thread until the spaw=
ned
worker unblocks. As a result, no new threads are actively created during the
capability drop, nullifying the concurrent thread creation test.

> +	}
> +	return NULL;
> +}
> +
> +static int conc_test_child(void)
> +{
> +	pthread_t sp[4];
> +	int i;
> +
> +	atomic_store(&conc_stop, 0);
> +	atomic_store(&conc_dropped, 0);
> +	atomic_store(&conc_bad, 0);
> +
> +	for (i =3D 0; i < 4; i++) {
> +		if (pthread_create(&sp[i], NULL, conc_spawner, NULL))
> +			return CHILD_FAIL;
> +	}
> +
> +	if (drop_cap(dropped_cap)) {
> +		atomic_store(&conc_stop, 1);
> +		for (i =3D 0; i < 4; i++)
> +			pthread_join(sp[i], NULL);
> +		return CHILD_FAIL;
> +	}

[Severity: Medium]
Can this error path lead to an infinite hang? If drop_cap() fails, conc_dro=
pped
is never set to 1. The worker threads will spin infinitely waiting for it to
change. This in turn causes the spawner threads to block infinitely in
pthread_join() waiting for the workers, and the main thread blocks infinite=
ly
here waiting for the spawners.

> +	atomic_store(&conc_dropped, 1);
> +	usleep(20000);

[ ... ]

> +static void *multi_spawner(void *arg)
> +{
> +	(void)arg;
> +
> +	while (!atomic_load(&multi_done)) {
> +		pthread_t t;
> +
> +		if (pthread_create(&t, NULL, multi_reader, NULL) =3D=3D 0)
> +			pthread_join(t, NULL);

[Severity: Medium]
Similar to the issue in conc_spawner(), does this synchronous wait prevent =
the
intended concurrency test? Waiting on the worker prevents thread creation r=
aces
with the concurrent capability drops.

> +	}
> +	return NULL;
> +}

[ ... ]

> +static int multi_drop_test_child(void)
> +{
> +	pthread_t dr[MULTI_DROP], sp[4], late;
> +	int i;

[ ... ]

> +	if (multi_bset_has_any()) /* the calling thread itself */
> +		return CHILD_FAIL;
> +	if (atomic_load(&multi_bad))
> +		return CHILD_FAIL;
> +
> +	pthread_create(&late, NULL, multi_reader, NULL);
> +	pthread_join(late, NULL);

[Severity: Medium]
Is it safe to unconditionally join this thread? If pthread_create() fails, =
late
remains uninitialized. Passing an uninitialized thread ID to pthread_join()
causes undefined behavior and could result in a crash or hang.

> +	if (atomic_load(&multi_bad))
> +		return CHILD_FAIL;
> +
> +	return CHILD_PASS;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929130200.1638=
343-1-ruanjinjie@huawei.com?part=3D3
