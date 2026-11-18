Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043717;
	b=N5uN41aQIJ0MbhqtlTNBsspWv/9i+hl3vLLVlhjamDfaOD4ZA9OmY+0Jd+M3Cya4OOif
	 g4zaDG4MG7VUpDWfP9KupjDZNcGPZ/IoOxM3U5nItaowEFnYijU8xnxGocDuEcR+r1cso
	 7rUnG1LYS1/fFVuzsrFjkjNhOe/dsgxTERRJFdpwNMgFAuxBEmjAsBljH+qVMUz/0NAzo
	 bmOQq6YombDNxqcLa92bxFHa7Wot86Q1z6TNAVinGWBuMha/RuzmnBIMnYntxVtvUFO6z
	 dxaVdaljSrAt/JNif3UVriJFNYkrArUx57/vV3zvsfkOj97I8QbJmwaF6YSbsORF21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F+/dq5bMDr1Qk9X1QNnZwwuwwn6jJ4gYLypHwsySwcY=;
	b=Bjs/ZZqYulTeFEznLk8ZZ06UxUKjtSxaZesd7RAZJoh6Cza7mPKPX4jY3DNazlddeanB
	 gAm/eSLm3Nwkps9haHnGhI1d42i+DzFEMVyesVKegK4NSyb0a95NzJijZJxMQVkkQLQoN
	 vkdtekPrFGEkVMYGsJ6nUzxnCrfgb0d4mkX7fYaqliQ5cDhyHnu+ITotbE7AMPcGoHutD
	 81SeYqH9+CeadfZ5QNdfy+EBsf42Sa0P4Ecfqylm0t3Rp3OH7vtuTCCY5acAKe8e56uKH
	 73msnkxAz47jUtWWEIc0dXcADRzZst0lCu3lrQgKw4hYPgmCqTSz2WV/gYkAinYQq5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2EHjrdO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DB606A325
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2EHjrdO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835271F000C4;
	Wed, 18 Nov 2026 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043717;
	bh=F+/dq5bMDr1Qk9X1QNnZwwuwwn6jJ4gYLypHwsySwcY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k2EHjrdOFeLkTioyxvuz2DLyPOHOOKRanzAIL1jkKtcYLFVmA4ztYe02aYf5BxWVd
	 VUELinKB45mjXqRpk1/oxju8SVVYJtkqs1B1CqsRA7IMdtDJef2Pvy554AOQxosmQ5
	 8J9nohPw9nyZ6J1xeQ8hvl1bgjt+oHdm/bKo/nSyOtDPMevQLiubzzPCrP98JLWWPH
	 f/8JP/IRwQBlYmyrHa2aop0cua+dbt0avT6trSsyB0UGx3zaCJPFKK89KXPUAlMv7v
	 wm6U6ZN5cQBbJfPuhvDyVY1y6BFRewpm2ThwbxH/7SKixBIb3PAHGUlSDP0rWRYJCd
	 f4ocfHO29OKgA==
Message-ID: <sashiko-outbox-222160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/13] rootns: Add rootns_kill() system call
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
In-Reply-To: <20261117231352.3816603-7-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:15 +0000
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

commit ea67311730397795196206953e1b7e54d487cc13
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_kill() system call

This commit adds the rootns_kill() system call to walk a root namespace's
PID namespace IDR and deliver a signal to each member thread group.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index 83ab759a31ecd..90a070dbf4a82 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
[ ... ]
> @@ -389,3 +390,67 @@ COMPAT_SYSCALL_DEFINE4(rootns_wait, int, rootnsfd,
>  	return ret;
>  }
>  #endif
> +
> +static int rootns_kill_members(struct rootns *rootns, int sig)
> +{
> +	struct pid_namespace *pid_ns =3D rootns->ns->pid_ns_for_children;

[Severity: High]
Does rootns_kill_members() need to check that the caller's active PID
namespace is an ancestor of pid_ns before delivering signals?

kill_pid(pid, sig, 0) passes SEND_SIG_NOINFO to send_signal_locked():

kernel/signal.c:send_signal_locked() {
    ...
	if (info =3D=3D SEND_SIG_NOINFO) {
		/* Force if sent from an ancestor pid namespace */
		force =3D !task_pid_nr_ns(current, task_active_pid_ns(t));
	}
    ...
}

Without a PID namespace ancestry check (like access_pidfd_pidns() in
sys_pidfd_send_signal()), a holder of rootnsfd in a sibling or disjoint
PID namespace has task_pid_nr_ns(current, task_active_pid_ns(t)) =3D=3D 0.
That sets force =3D true and bypasses SIGNAL_UNKILLABLE in
sig_task_ignored(), allowing a non-ancestor process to kill or stop the
PID namespace init with SIGKILL or SIGSTOP.  A caller in a descendant PID
namespace created inside the rootns can also signal tasks upward in its
ancestor pid_ns, while a caller inside pid_ns itself has force =3D false so
SIGKILL and SIGSTOP are ignored on the rootns init process.

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
Can a concurrent fork() still escape signal delivery in
rootns_kill_members()?

CPU0                              CPU1
copy_process()
  /* queues delayed.node on
   * current->signal->multiprocess
   */
  alloc_pid()
    /* inserts child pid into
     * pid_ns->idr (tasks[] empty)
     */
                                  rootns_kill_members()
                                    idr_for_each_entry(&pid_ns->idr, ...)
                                      /* child pid: pid_task(..., PIDTYPE_T=
GID)
                                       * is NULL -> skipped
                                       */
                                      /* parent pid: kill_pid() passes
                                       * PIDTYPE_TGID
                                       */
                                        __send_signal_locked()
                                          /* type > PIDTYPE_TGID is false;
                                           * delayed.signal not updated
                                           */
  write_lock_irq(&tasklist_lock)
  p->signal->shared_pending.signal =3D
    delayed.signal;
  attach_pid(p, PIDTYPE_TGID)
  attach_pid(p, PIDTYPE_PID)
  write_unlock_irq(&tasklist_lock)
                                  /* child never receives sig */

__send_signal_locked() only records signals into t->signal->multiprocess
for in-flight forks when type > PIDTYPE_TGID, whereas kill_pid() uses
PIDTYPE_TGID.  For any signal that does not make fatal_signal_pending()
true on the parent (such as SIGSTOP, SIGHUP, SIGINT, or a caught or
blocked SIGTERM), the child finishes copy_process() without receiving the
signal.

Because pid_ns->idr is walked without read_lock(&tasklist_lock), a parent
at a higher IDR index can also allocate a lower, already-visited IDR index
for its child (after PID wrap-around or via clone3() set_tid) and finish
attaching the child before the scan reaches the parent, escaping even
SIGKILL.  In addition, copy_process() calls attach_pid(p, PIDTYPE_TGID)
before attach_pid(p, PIDTYPE_PID) under tasklist_lock, so unlocked readers
can see pid_task(pid, PIDTYPE_TGID) !=3D NULL while kill_pid() still sees
pid_task(pid, PIDTYPE_PID) =3D=3D NULL and returns -ESRCH.

Holding read_lock(&tasklist_lock) and signaling via group_send_sig_info()
with PIDTYPE_MAX (as zap_pid_ns_processes() and kill_something_info() do)
would serialize against copy_process() and populate delayed.signal for
ongoing forks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D6
