Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978590;
	b=LndLyEk8A8LUy3jz545+44ZDqAxxF4yB1tD6axlDg2W9WwWBat/e/OY6hxOvR6Pod4wE
	 KB4kf8uQ2qTtsVf1eEyOxdgUuTpNHT9z1WDDR1GrQgtXgkm17ouBLFYdc+VsObzo8iOqZ
	 ZdsvliqrrzPO9P9cZIZNuLSBN5y3ZmHuxBPdO3m+3sV8zCz1Q/ORuMsYcSyCwyAKlDFx6
	 4T8HhtuHWGLkvqOXmPYKh4GsnW1p/M2CdwFFpv4+6CTUzBYeCkOrhhN3t3/d7IF+bNJri
	 AvqaBXAosxLuaU8XgMER1emdZDLyMpSmY/BcXQV9VGnvgTjTwky/yzrpW1E6VOZSGZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YTkB6IegYKkCKN9TMyQsZjUMGenXx9DRYi/wt9UPTmg=;
	b=g8xa8KGIqGHJEL4RxefIHA8Ejqbc/8sxkYQPzStF2RUkvQW9+Oypj50K1UBsxPlJd7BX
	 GJ369cLC/tmUf7MkQXQn3wLrr7MSfpzKZnq9BWuzxT3RAlSKwRH3z2zhI/hLqZCuI/UHf
	 tpx8XCa1h+3s9t//GOIROV0p6hJEf4asWEPLuVtJNm3fSpLPL3bP6cgW+m5IMgSCOIlvI
	 o6VANDKhGI8ZFxTCr3WDYwx4JvCnULVbtDBn3HKjrLjjuo0Ml0nXyBE2IYYyz1o+xawGb
	 KscU8LXQAGCDIesvPa1IMmbExu+82CRLBuhxSnDd6v1gtuIBLsJc/aOV/g7BsPDYDJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJHnCTFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D44606A325
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJHnCTFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F751F000C4;
	Wed, 18 Nov 2026 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978589;
	bh=YTkB6IegYKkCKN9TMyQsZjUMGenXx9DRYi/wt9UPTmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AJHnCTFZOlT1hBVJ/ns2h3RREYp++TG43Nzlfhh3u26BmU9sAUTT8AOx3CZGOFzSq
	 l0vQ/tQIvCwKAfcAKwEse7RAODQyHQPC1Bhx3a/wp+beqeS0Y95RzBlvrSYt25IZxy
	 NkeRwlwVyJsPik5HkrtdUYn6dML/oB7nn6BxRG/nq2QrqQO1/3QPXAKgaxG64SZw39
	 b1i57klcqPtQoR6zTrdfBlrp2BTGgmuOSyIstpgGbfVBeO+qZBQxh8xKvuoRT/dRw8
	 9G9xhqvr9MI9j6mxByShb79pTTgdw3Iq9MpJvSN4yzcq+hxVkvzsic7XzN2vi47rmn
	 ++sZNGT+a6RdQ==
Message-ID: <sashiko-outbox-220141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/13] rootns: Add rootns_kill() system call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-mm@kvack.org, linux-security-module@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>, "Ben
 Segall" <bsegall@google.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "David Howells" <dhowells@redhat.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, "Dietmar Eggemann" <dietmar.eggemann@arm.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Kees Cook" <kees@kernel.org>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Manfred Spraul" <manfred@colorfullife.com>, "Mel
 Gorman" <mgorman@suse.de>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Neal
 Gompa" <neal@gompa.dev>, "Paul Moore" <paul@paul-moore.com>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Peter Zijlstra" <peterz@infradead.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Serge Hallyn" <sergeh@kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Valentin Schneider" <vschneid@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Vlastimil Babka" <vbabka@kernel.org>
In-Reply-To: <20261117050841.3289652-7-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:47 +0000
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
- [High] rootns: fork() race in rootns_kill_members() missing
  tasklist_lock
- [High] rootns: missing PID namespace ancestry check in
  rootns_kill_members()
--

commit af3e55bb2ee92ebb14699cd9c72b34e3ddb26ffe
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_kill() system call

This commit adds the rootns_kill() system call to walk a root namespace's
PID namespace IDR and send a signal to every member thread group.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index 8a1254db69df7..f59b2fe9910de 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c

[ ... ]

> @@ -390,3 +391,67 @@ COMPAT_SYSCALL_DEFINE4(rootns_wait, int, rootnsfd,
>  	return ret;
>  }
>  #endif
> +
> +static int rootns_kill_members(struct rootns *rootns, int sig)
> +{
> +	struct pid_namespace *pid_ns =3D rootns->ns->pid_ns_for_children;

[Severity: High]
Should rootns_kill_members() verify that the caller's active PID namespace
is equal to or an ancestor of pid_ns before delivering signals?

Without an ancestry check, a caller holding rootnsfd in a sibling or
descendant PID namespace can signal processes outside its PID namespace
hierarchy.  Because kill_pid() passes SEND_SIG_NOINFO to
send_signal_locked():

kernel/signal.c:send_signal_locked() {
    ...
	if (info =3D=3D SEND_SIG_NOINFO) {
		/* Force if sent from an ancestor pid namespace */
		force =3D !task_pid_nr_ns(current, task_active_pid_ns(t));
	}
    ...
}

when current has no PID in task_active_pid_ns(t), send_signal_locked()
treats the signal as coming from an ancestor PID namespace and sets
force =3D true, bypassing SIGNAL_UNKILLABLE and allowing SIGKILL or SIGSTOP
to kill or stop the PID namespace init process.

> +	bool any_success =3D false;
> +	bool any_other =3D false;
> +	bool any_perm =3D false;
> +	int other_err =3D 0;
> +	struct pid *pid;
> +	int nr;
> +
> +	if (READ_ONCE(rootns->state) !=3D ROOTNS_RUNNING)
> +		return -ESRCH;
> +
> +	scoped_guard(rcu) {
> +		idr_for_each_entry(&pid_ns->idr, pid, nr) {
> +			int err;
> +
> +			if (!pid_task(pid, PIDTYPE_TGID))
> +				continue;
> +
> +			err =3D kill_pid(pid, sig, 0);

[Severity: High]
Can a concurrent fork() still escape signals sent by rootns_kill_members()?

CPU0                              CPU1
copy_process()
  hlist_add_head(&delayed.node,
    &current->signal->multiprocess)
  ...
  pid =3D alloc_pid(...)
                                  rootns_kill_members()
                                    idr_for_each_entry(&pid_ns->idr, ...)
                                      /* parent: kill_pid() uses
                                       * PIDTYPE_TGID, so delayed.signal
                                       * is not updated */
                                      kill_pid(parent_pid, SIGTERM, 0)
                                      /* child: not attached yet */
                                      !pid_task(child_pid, PIDTYPE_TGID)
                                        -> continue
  write_lock_irq(&tasklist_lock)
  p->signal->shared_pending.signal =3D
    delayed.signal
  attach_pid(p, PIDTYPE_TGID)
  attach_pid(p, PIDTYPE_PID)
  write_unlock_irq(&tasklist_lock)
                                    /* child escapes SIGTERM */

__send_signal_locked() only records signals in t->signal->multiprocess for
in-flight forks when type > PIDTYPE_TGID, whereas kill_pid() passes
PIDTYPE_TGID.  In addition, because pid_ns->idr is walked without holding
read_lock(&tasklist_lock), a parent at a higher IDR entry can fork and
attach a child at a lower, already-scanned IDR entry (via PID wrap-around
or clone3() set_tid) before the scan reaches the parent, allowing the child
to escape even SIGKILL, or rootns_kill_members() can observe
pid_task(pid, PIDTYPE_TGID) before attach_pid(p, PIDTYPE_PID) completes and
get -ESRCH from kill_pid().

Holding read_lock(&tasklist_lock) during the IDR walk and signaling via
group_send_sig_info(sig, SEND_SIG_NOINFO, task, PIDTYPE_MAX), as
zap_pid_ns_processes() and kill(-1, sig) do, would close these races.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D6
