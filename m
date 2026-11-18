Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978585;
	b=zH0am8esP+ig3XCYGEimOtSlvrDxxn+7wa6BQbRPwqqDNhkKy6VlwTnOpBovLtUJwC/N
	 0jVGSehSy0MIijAuZdkHbkslpsW4t/3DWjhcM550oIQTi6glaKog/KIZoX/8HmXk0IBeT
	 nyv5aR8IGZLuX2sm+Y0OfUoypMg1eT0iJlrvLxfw/PF7wQL5WaQWEJXaM3VXpdKL0DrD5
	 3Je+msIHGvomIcjDwqknr6Gu8LOWR0DbPvVGERFh5ROGul4SvLyAC3Nj5+A6SFKz0fj/X
	 QsRUK7FwbI7IsUvPIuI3tDoMWunXOgdegN63wysn+jsQFmVVrx/hYFjXVxx5tLQWk9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N8ecUXIE9NFI+o21qW2ZRILVB8vvpu2X3KPk366UveA=;
	b=obJw3hwEr8zQw2ggevx7bim9O76QXaHAmd/Pbmpge3k+7sBRhhIgGCHS4sASEkx73Gdh
	 ZgfJgN8ceF7jPRi75u2Q+isbG1RXEJM6azLS8aReixNRtDKoDoTBS7oAeZqMbxqP+E2rL
	 IzSgYkI6q0zkUGg38llPhhKiL/8euBUN2p7FlvSUn6RDzAz9RCWukNGXVj3r3oEMykAdR
	 aFUls31k2rkGlwpDkQsGc95rgOU/ZgFcQY3tGGVxrL2h/xDAoIUVv6FmV5wkMN6gI3Zve
	 V4lCw9pVywcwEC4wulK+/+70R6LIx34I54clo2MkEY+oOlx8MJOlySAftpfcnXlHtNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/xqUGrj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7296606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/xqUGrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5701F000C4;
	Wed, 18 Nov 2026 05:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978584;
	bh=N8ecUXIE9NFI+o21qW2ZRILVB8vvpu2X3KPk366UveA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/xqUGrjkpvyjh9rxGZyESrTZe0TORZlvBjonU+H/UBJFk8D/Zm0EDTrCQdVbSnFF
	 Q43DKXUHgxz4Ta0Z+uPbAkwwdYmqum097ZagvjTjlY7Puxd/giCpIEh0R5sH/CeXgB
	 wgdQtHzHDHVE0mnlV+CQOw2GjD5ZAG/YvN9iAicimqYlQOOnD6CiPzLKT2MYpTuyeq
	 iaR+Mo2y87Fwv2ajL6w1y3ANyDU2FB6fvekv5/y+SOX+oUvYcs93yTc+1jMR4aXPA3
	 2b8Z4WqbqjQ6h7W2NlUp6F1z9xLRje7q7ElsnCrcA3PS2JJN4r30LUhnwFEpzX4W7Z
	 D5/3T3Z2U8kXg==
Message-ID: <sashiko-outbox-220138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 03/13] rootns: Track init lifecycle via
 copy_process() and pid_namespace
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
In-Reply-To: <20261117050841.3289652-4-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] rootns: UAF and refcount imbalance in exit_rootns() via
  unreferenced pid_ns->rootns
- [High] rootns: unreferenced pid_ns->rootns pointer in exit_rootns()
  causes UAF
- [Medium] rootns: copy_rootns() publishes init_pid before
  attach_pid(PIDTYPE_PID)
- [Medium] rootns: missing is_child_reaper() and locked state checks in
  copy_rootns()
--

commit 257575ec869d3f0e55e6c1a6f99ef3b0751d2a44
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Track init lifecycle via copy_process() and pid_namespace

This commit adds rootns lifecycle tracking hooks to copy_process(),
create_new_namespaces(), and zap_pid_ns_processes() to record the
bootstrapped init task's PID and capture its exit status and resource usage
when the PID namespace terminates.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5efceb8d58a78..99e22b3cd213e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -2565,6 +2566,7 @@ __latent_entropy struct task_struct *copy_process(
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);
>  			attach_pid(p, PIDTYPE_SID);
> +			copy_rootns(p, NULL);
>  			__this_cpu_inc(process_counts);
>  		} else {
>  			current->signal->nr_threads++;

[Severity: Medium]
Does calling copy_rootns() before attach_pid(p, PIDTYPE_PID) publish
c->init_pid and ROOTNS_RUNNING before pid->tasks[PIDTYPE_PID] is populated?

CPU0                                    CPU1
copy_process()
  attach_pid(p, PIDTYPE_TGID)
  copy_rootns(p, c)
    spin_lock(&c->lock)
    c->init_pid =3D get_task_pid(p, ...)
    c->state =3D ROOTNS_RUNNING
    spin_unlock(&c->lock)
                                        __rootns_kill()
                                          spin_lock(&c->lock)
                                          pid =3D get_pid(c->init_pid)
                                          spin_unlock(&c->lock)
                                          kill_pid(pid, sig, priv)
                                            ...
                                              pid_task(pid, PIDTYPE_PID)
                                              --> NULL (-ESRCH)
  attach_pid(p, PIDTYPE_PID)

__rootns_kill() does not take tasklist_lock, so if a signal is sent during
this window (for example from rootns_release() when ROOTNS_KILL_ON_CLOSE is
set), kill_pid() fails with -ESRCH and drops the signal, leaving the
container init process running.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index e75d918b93ec5..e3b203322ae23 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
[ ... ]
> @@ -105,3 +106,42 @@ bool is_rootns_file(struct file *file)
>  {
>  	return file->f_op =3D=3D &rootns_fops;
>  }
> +
> +void copy_rootns(struct task_struct *tsk, struct rootns *c)
> +{
> +	if (likely(!c || READ_ONCE(c->state) !=3D ROOTNS_FORKING))
> +		return;
> +
> +	scoped_guard(spinlock, &c->lock) {
> +		get_rootns(c);
> +		WRITE_ONCE(c->init_pid, get_task_pid(tsk, PIDTYPE_TGID));
> +		WRITE_ONCE(c->state, ROOTNS_RUNNING);
> +	}
> +	wake_up_all(&c->waitq);
> +}

[Severity: Medium]
Can copy_rootns() record a non-reaper task as c->init_pid or race with
exit_rootns() to overwrite ROOTNS_DEAD back to ROOTNS_RUNNING?

In commit "rootns: Add rootns_create() system call", create_rootns() sets
ns->pid_ns_for_children->rootns =3D c and marks the PID namespace active in
pid_ns_tree before rootns_enter() is called. A host task with
CAP_SYS_ADMIN can open that PID namespace via open_by_handle_at(), join it
via setns(CLONE_NEWPID), and fork() PID 1 without bootstrapping c. Because
copy_process() calls copy_rootns() for any thread_group_leader(p) rather
than checking is_child_reaper(pid), a later rootns_enter() spawns PID 2 and
commits it as c->init_pid.

Furthermore, copy_rootns() checks c->state =3D=3D ROOTNS_FORKING outside
c->lock without re-checking under the lock:

CPU0                                    CPU1
copy_rootns(tsk, c)
  READ_ONCE(c->state) =3D=3D ROOTNS_FORKING
                                        zap_pid_ns_processes(pid_ns)
                                          exit_rootns(pid_ns, me)
                                            spin_lock(&c->lock)
                                            c->state =3D ROOTNS_DEAD
                                            spin_unlock(&c->lock)
                                            put_rootns(c)
  spin_lock(&c->lock)
  get_rootns(c)
  c->init_pid =3D ...
  c->state =3D ROOTNS_RUNNING  <-- overwrites ROOTNS_DEAD
  spin_unlock(&c->lock)

Checking is_child_reaper(pid) and re-checking c->state =3D=3D ROOTNS_FORKING
under c->lock would prevent both issues.

> +
> +void exit_rootns(struct pid_namespace *pid_ns, struct task_struct *tsk)
> +{
> +	struct rootns *c =3D pid_ns->rootns;
> +	struct task_struct *leader;
> +	struct rusage rusage;
> +	int status;
> +
> +	if (!c)
> +		return;
> +
> +	leader =3D tsk->group_leader;
> +	status =3D (tsk->signal->flags & SIGNAL_GROUP_EXIT) ?
> +		 tsk->signal->group_exit_code : leader->exit_code;
> +	getrusage(leader, RUSAGE_BOTH, &rusage);
> +
> +	scoped_guard(spinlock, &c->lock) {
> +		c->exit_code =3D status;
> +		c->rusage =3D rusage;
> +		WRITE_ONCE(c->state, ROOTNS_DEAD);
> +	}
> +
> +	pid_ns->rootns =3D NULL;
> +	wake_up_poll(&c->waitq, EPOLLHUP);
> +	put_rootns(c);
> +}

[Severity: High]
Can exit_rootns() drop an unheld reference on c when pid_ns was entered
without copy_rootns()?

In commit "rootns: Add rootns_create() system call", create_rootns() sets
ns->pid_ns_for_children->rootns =3D c without taking a reference on c; the
matching get_rootns(c) only happens in copy_rootns() when bootstrapping in
ROOTNS_FORKING state. If a privileged host process enters pid_ns via
open_by_handle_at() and setns(CLONE_NEWPID) and forks a child reaper,
copy_rootns() is called with c =3D=3D NULL and never increments c->usage. W=
hen
that child reaper exits, zap_pid_ns_processes() -> exit_rootns() sees
pid_ns->rootns =3D=3D c and calls put_rootns(c), dropping the open rootns f=
ile
descriptor's own reference and freeing c while the file descriptor is still
open.

[Severity: High]
Can exit_rootns() dereference a dangling pid_ns->rootns pointer after the
rootns file descriptor has been closed?

Because create_rootns() stores an unreferenced c in pid_ns->rootns and
put_rootns() frees c without clearing pid_ns->rootns, any reference that
outlives the rootns file descriptor before rootns_enter() runs leaves
pid_ns->rootns pointing to freed memory. If a process holds an nsfs file
descriptor to pid_ns, closes the rootns file descriptor (freeing c), and
then enters pid_ns via setns(CLONE_NEWPID), forks, and exits,
zap_pid_ns_processes() -> exit_rootns() dereferences the freed c and
double-frees it via put_rootns(c). Assigning pid_ns->rootns =3D get_rootns(=
c)
in copy_rootns() when the bootstrap init task is attached would avoid
storing an unreferenced pointer in create_rootns().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D3
