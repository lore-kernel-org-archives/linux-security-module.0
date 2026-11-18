Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043715;
	b=eTS9SfClX2ait7UAq+ICS8PpMmQdv9+xvn1lTQAXKHNyQ1ovxJbbCHV4lZcjV1PH5Bub
	 qt/j+O6zSG4Hq5xKagYWbou7GmH0vTgjeQqPSYdfF1TF4rRWoyVjnTAmPbxjOS/QaIAMS
	 oCC7muNIC0az5Y0Nv4OTZqpSjVoT5+Wv1p2kXmccQtb1eOkOd4VMZs3EPvp1LuXetpDod
	 qrd2k2PTjhhCKNUZ+VdCAS06vnYHVWjruIhemW78AK0UgavnmY1YKWXhpiDXBGAcUNRHS
	 t4C1hIX4aUg8QqqGMznNvXialdnzYAoOnLIqSsM9LZ3C2pKI4KMmW9I59tsSp59SP2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043715;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fXSDPFAH4x0QiTPRoLf3VmlQiasjSs0WRYQmJTXqARc=;
	b=3ca7LNrMgZKlqS6N3I15WUOzrj7GR9U8bHIUruElqmPymhytyMCGdwJog9QkCJpIU/zW
	 lvXk+UHTWDho9oQvAygLHoxm2/PYqAaOQVPy32MfuD8JnxDJVbE5h3251ZQ/QszTTWRri
	 0jgZCLBqrxfIIT3Gigox8jvz5u0K43aTrTsD1gFdzyi6tqFzlOYYzcgUg4/Xe9bpIbWBf
	 SIzn4YHQFtPMLSuUwZDY+r2+blH75ZICGIBIfSDdU3TkwmDJ8fLYUCHBNmiGo9+qNq+ff
	 qL3Lx4AuQUUzZ3npwBWbglC1lJrHW0IX0TH2lX7smpN5zWci4/ndWUWA3sCwTqEwNUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8VnXoMm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F575606A320
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8VnXoMm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC91F000C4;
	Wed, 18 Nov 2026 23:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043715;
	bh=fXSDPFAH4x0QiTPRoLf3VmlQiasjSs0WRYQmJTXqARc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8VnXoMmUpZ7dfVqetpcqXACVQcPx87LNPv04YiG7BqIG14HtJpwuSrXp2wUz2JR3
	 x+TcRSelZr6z/ly9hB8ZWQQR0aIljvHwbkg64wMIc8T2mu9XitffbuSW6MRoI09uiE
	 IeLoqSAoNAxP7lT2pBYHhKkpAppsUJ18DyayMRW5w9AIkJ13RSP3TQPzA0/L0jxHhG
	 Li6q8AaHYwAefBHg++a6Zy9A+1t3tsUcfnkzc+siMPohdjBOq3ifcgrMUvm2pSjMVD
	 jcVrTBs6+Qy1ElrP5oEF2xaXwSJGtBfUjgavDY7orFZCjtJQ3uyXoo4AkJyTDn0Bex
	 8Y4xQXCgywVgQ==
Message-ID: <sashiko-outbox-222159@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/13] rootns: Add rootns_wait() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Andy
 Lutomirski" <luto@amacapital.net>, "Ben Segall" <bsegall@google.com>, "Christian
 Brauner" <brauner@kernel.org>, "David Hildenbrand" <david@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Davidlohr Bueso" <dave@stgolabs.net>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, "Ingo Molnar" <mingo@redhat.com>, "Jan
 Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "John Johansen" <john.johansen@canonical.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Zygmunt
 Krynicki" <zygmunt.krynicki@canonical.com>
In-Reply-To: <20261117231352.3816603-6-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:12 +0000
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
- [Medium] rootns: unreachable init_pid check in rootns_wait_common()
- [Medium] rootns: non-freezable TASK_KILLABLE sleep in
  rootns_wait_common()
--

commit ee16ae2e42910ad7c6f6428120bfc66d7f286658
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_wait() system call

This commit adds the rootns_wait() system call and its compat entry point to
wait on a rootns file descriptor until its init thread group exits and
report its wait status and resource usage.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index caa810b65d0da..83ab759a31ecd 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
[ ... ]
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
Should rootns_wait_common() use wait_event_freezable() instead of
wait_event_killable() here?

Waiters blocked in TASK_KILLABLE for the lifetime of a container are neither
marked TASK_FREEZABLE nor woken by signal_wake_up(), unlike do_wait() which
sleeps in TASK_INTERRUPTIBLE | TASK_FREEZABLE.  While any task is blocked in
rootns_wait(), system suspend and hibernation fail after the PM freezer
timeout, cgroup v2 freezing of the waiter's cgroup hangs, non-fatal signals
and job control cannot interrupt the wait, and each idle waiter inflates the
system load average.

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
Can the !rootns->init_pid check ever be reached when init was never started?

The kernel-doc for sys_rootns_wait() states that it returns -ECHILD if init
was never started, but rootns->state only reaches ROOTNS_DEAD in
exit_rootns() after copy_rootns() has already set rootns->init_pid and
transitioned the state to ROOTNS_RUNNING.  When rootns_wait() is called on a
rootns in ROOTNS_EMPTY or ROOTNS_READY before init is forked, a WNOHANG call
returns 0 at the rootns->state !=3D ROOTNS_DEAD check above, and a blocking
call sleeps indefinitely in wait_event_killable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D5
