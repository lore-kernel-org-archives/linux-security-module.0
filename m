Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117014;
	b=R33D7F2goNahrYZ20bUNRz+3TLoAG+kxz4Qr0HgZX1f49zjaJUGXfgZvtArPEcDDVADT
	 tQ797hpNlSSJ7yNDupaS7p6wOFAqbDVtjQGoGyKWYCkDQ7p7gX/0+GgJ6TzETe3nELsNM
	 UqBeTWpItYjKeKzCI+OGRfaQkfuajeg+6e2L0/gCdPgInXF8b8UH6lUc9Txd4i1sS16Gk
	 BIzRGYH2ehe5BbC9N7vDrhKoubQBKWfdLLRf81uZAdFPxOv+kFwCy7HMz5vygcxtcDI4s
	 lJzbusUPk+owsgRqVSxS/hYEYFGmqqDpLF3FhEgidDJlLr/6Lg8oOBAmRZDtMCDELYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117014;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VNM+7RVYDMfJcBD0bitBmq9dsNdnP+e2PrcUcBzEF7U=;
	b=d+zW2G+ilCl7jNMtGAZ4fd1/OIW7XQ8qc54RxE9CnsqZ2uKMooAvuENVL+Q2RDl0XpNc
	 YC2C5G2jhH87KcvR95YEDtdIpHaBr8pNRKOGFladeB4XJjpO8osrxqxb/FyBVRI+XaNb8
	 l9ihMLVK1gEd0xPJlUosrPA/LzYE4dpbh441pCi1S6wkl0UEitBLcbOknmsKjXA8/Q+51
	 rtEQjB273ZVsw+aTZH261aKio1ZkpQXKTx0cHSK7hne/DWX0ujHgGhHX/5lA6oPwpPvR1
	 +TdQCr/LBhn4YWAClJg5BOpHcSmb+qTvLAF5p3Bl+GrpaN2L/prWX4s9WzW4NkYPG9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owrSWS1F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADA606A320
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owrSWS1F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C261F000C4;
	Thu, 19 Nov 2026 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117014;
	bh=VNM+7RVYDMfJcBD0bitBmq9dsNdnP+e2PrcUcBzEF7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owrSWS1FsstagbuZ/jERHqlbcvoDtYvMNFddXXZmwRBNjjOa+PdL498x5idmBTC8v
	 yoA7K0aPH6q4N7ZoWFeOCofHW2RDkCjWEj9aQvv4cFbSz61dqNFGcMQmuKQZu4lBq1
	 0q+W5smUlWBitu7XmqR45NoSbC/4g9He7o4Y+q13eL6rxc4ZK5jLVdZaVxNw/XKimS
	 zJiz5y4mpZZ7VZMWU3jyJHn9Hpr3yZTAmwFJ3OP28st9KBK7BDWtOeiGnDeb3S4A34
	 8Ul6+zRWGmczZ9XE0Cc/WVunzqTccCefb9KxG/Szr7pZcXt7Bos9fO3yPglwtaXesR
	 BqIO50JkVd+yQ==
Message-ID: <sashiko-outbox-223947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 05/13] rootns: Add rootns_wait() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Lutomirski" <luto@amacapital.net>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Frederic Weisbecker" <frederic@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "John Johansen" <john.johansen@canonical.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Juri Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Thomas Gleixner" <tglx@kernel.org>, "Valentin
 Schneider" <vschneid@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Vlastimil Babka" <vbabka@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261118193539.240065-6-jarkko@kernel.org>
References: <20261118193539.240065-1-jarkko@kernel.org>
 <20261118193539.240065-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:36:50 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] rootns: unreachable init_pid check and missing -ECHILD in
  rootns_wait_common()
- [Medium] rootns: non-freezable TASK_KILLABLE sleep in
  rootns_wait_common()
--

commit 8a805a3f4fb79d05bf397b0ae4fb7738f0017723
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_wait() system call

This commit adds the rootns_wait() system call and its compat entry point to
wait for a root namespace init process to terminate and collect its exit
status and resource usage.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index c420e36af603f..5582ff010ca53 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
> @@ -305,3 +305,106 @@ SYSCALL_DEFINE1(rootns_create, unsigned int, flags)
> =20
>  	return fd;
>  }
> +
> +/*
> + * Wait for rootns init to exit and report results for the caller.
> + *
> + * Returns caller-visible init TGID on success, 0 for WNOHANG when still
> + * running, and -ECHILD when init pid is not visible in caller pidns.
> + */
> +static long rootns_wait_common(int rootnsfd, unsigned int options,
> +			       int *status, struct rusage *ru)
> +{
> +	CLASS(fd, f)(rootnsfd);
> +	struct pid_namespace *pid_ns =3D task_active_pid_ns(current);
> +	struct rootns *rootns;
> +	long ret;
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +	if (!is_rootns_file(fd_file(f)) || (options & ~WNOHANG))
> +		return -EINVAL;
> +
> +	rootns =3D fd_file(f)->private_data;
> +	if (!(options & WNOHANG)) {
> +		ret =3D wait_event_killable(rootns->waitq,
> +					  READ_ONCE(rootns->state) =3D=3D ROOTNS_DEAD);

[Severity: Medium]
Should rootns_wait_common() use a freezable and interruptible wait such as
wait_event_freezable() instead of wait_event_killable()?

Sleeping in TASK_KILLABLE for the lifetime of a running root namespace
prevents the PM and cgroup v2 freezers from freezing the waiting task (which
causes system suspend or hibernation to time out and fail), blocks non-fatal
signals and job control, and counts every blocked waiter toward the system
load average.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	scoped_guard(spinlock, &rootns->lock) {
> +		if (rootns->state !=3D ROOTNS_DEAD)
> +			return 0;
> +		if (!rootns->init_pid)
> +			return -ECHILD;

[Severity: Medium]
Can the !rootns->init_pid check here ever be reached, and what happens when
rootns_wait() is called before an init process has been started?

The kernel-doc for sys_rootns_wait() states that -ECHILD is returned if init
was never started.  However, rootns->state only reaches ROOTNS_DEAD in
exit_rootns() after copy_rootns() has already populated rootns->init_pid.
When init has not been started (rootns->state =3D=3D ROOTNS_INIT), a call w=
ith
WNOHANG hits the rootns->state !=3D ROOTNS_DEAD check first and returns 0,
while a call without WNOHANG sleeps in wait_event_killable() instead of
returning -ECHILD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118193539.2400=
65-1-jarkko@kernel.org?part=3D5
