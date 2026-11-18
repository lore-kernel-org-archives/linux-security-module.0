Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043719;
	b=q86pobF9IsUpen3qsTiWcqmzgkOLvKh//PJiG1YfhoNL+7XNsGfVHlRzwBSnZBGEK3lh
	 e5RnJ6Wmv4NOuQqN9YJaOUfxIPDxG3dDcnE9bTjtzwSfp8hK21OxJX+VYlZyA01GpSCLX
	 pcpQvNtXX9bNuIUTl5Qeqn6Fys5RrqqA6Ri7OnoJnO9GEFOGPCkANiDft/uq3pcH+dT55
	 xsX4r6nvAiDumA8fcyps7PTFEwIgX70se65SfjYObq5qX5adCiB4Ba08Pdm8E3+HL21pT
	 GKhkvIU9jDr7pH0HGr1WAw1Jf70PtC5YBR37K0fX1gVl15SzsZulhjTYe9a0oGGqYTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043719;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0UgqqzoOwyVS9t15jclCnf/wvXsyI8B5DG+Zmj+8bS0=;
	b=DWZ066h1jF6Ve6QJHSl1J/vUAUw+Tn60fj1gSvBfn4IokrAWYO9l+tuvWJFGnopUzddF
	 KywyYuI/xenN2HfpeuUCemgQQMjy951QTkA8zklrIjcpmpK8HLUcJ0tDk6hAazmo3AyKO
	 LDN3ApkJVd+/XU25zyL2iOuWbplNJvEWgzALKVPrWEjFw/EWO6MTHgCPpwkR29WuTxAtS
	 j/snbVgeMKNwU6gk40MMUs8VxlDB3Egh9ziBkx1j20CCLxIkL7mpki0GvuXH7jKY5qC5j
	 jFfNb9x1AjBsaEURbPv2ZyiWb+F2Sw08qO34jHv7lM/BlabLgm1dIJApTgHDOhUw0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l6rtjrD/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C36606A32C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l6rtjrD/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36EB1F000C4;
	Wed, 18 Nov 2026 23:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043719;
	bh=0UgqqzoOwyVS9t15jclCnf/wvXsyI8B5DG+Zmj+8bS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6rtjrD/sNF1zdIwQUSlHlBphcfKpLLr4193bBkAHPK8FY68i/X/NfFoBUGNOpPoA
	 LRZQVsoIsRwnMg3sIZTFVhGppe3mCYht1bqttr3Hh38PkHCEzBwNK3H4iHPThgD861
	 h7wo3ALRjMLuVZldJ+lLb168bg0GGE4xToxauIUgu3mT/gHcA2MZnlY3zrlCo0PIoM
	 tr0nMPC5dxQa0ErvFEgseUTfuzwudaq8sQ/ZZ/AxR+IkocvOBLVxw6aER6oqQ3/quo
	 W03kefwR4wQZ1LNVuB736EGIFrbHKq9gLY30K9PPXRlBzuQH6rX2SvNRJhxjkI0gZ4
	 TEUKVe3qGkwIg==
Message-ID: <sashiko-outbox-222161@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 07/13] fork: Support CLONE_INTO_ROOTNS in
 clone3()
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
In-Reply-To: <20261117231352.3816603-8-jarkko@kernel.org>
References: <20261117231352.3816603-1-jarkko@kernel.org>
 <20261117231352.3816603-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:15:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Critical] cred: missing dumpability reset and shared mm on
  CLONE_INTO_ROOTNS
- [Critical] cred: privilege escalation and LSM bypass in
  may_enter_rootns_creds()
- [High] rootns: UAF and refcount underflow on pid_ns->rootns without
  CLONE_INTO_ROOTNS
- [Medium] fork: copy_rootns() sets ROOTNS_RUNNING before
  attach_pid(PIDTYPE_PID)
- [Medium] nsproxy: missing timens_commit() and CLONE_VM check in
  copy_namespaces()
--

commit 32f57f44b3303d6e1266e96415fc759ba100f243
Author: Jarkko Sakkinen <jarkko@kernel.org>

fork: Support CLONE_INTO_ROOTNS in clone3()

This commit adds CLONE_INTO_ROOTNS and struct clone_args.rootns to allow
clone3() to spawn a child process directly into an initialized root
namespace.

> diff --git a/kernel/cred.c b/kernel/cred.c
> index d01df40a9a386..afc91eed26563 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c

[ ... ]

> @@ -251,6 +255,25 @@ struct cred *prepare_exec_creds(void)
>  	return new;
>  }
> =20
> +static bool cred_cap_issubset(const struct cred *set,
> +			      const struct cred *subset);
> +
> +static bool may_enter_rootns_creds(const struct cred *old,
> +				   const struct cred *target)
> +{
> +	if (cred_cap_issubset(old, target) &&
> +	    uid_eq(old->euid, target->euid) &&
> +	    gid_eq(old->egid, target->egid))
> +		return true;
> +
> +	if (old->user_ns =3D=3D target->user_ns)
> +		return false;
> +
> +	return ns_capable(target->user_ns->parent, CAP_SYS_ADMIN) &&
> +	       ns_capable(target->user_ns->parent, CAP_SETUID) &&
> +	       ns_capable(target->user_ns->parent, CAP_SETGID);
> +}

[Severity: Critical]
Can a caller escalate privileges or bypass LSM restrictions when
copy_creds() replaces the child's credentials with dup_creds(rootns->cred)?

dup_creds(rootns->cred) copies all fields of struct cred from rootns->cred,
including uid, suid, fsuid, gid, sgid, fsgid, group_info, cap_bset,
cap_effective, cap_inheritable, cap_ambient, and security (passing
rootns->cred as old to security_prepare_creds()).

In the first branch of may_enter_rootns_creds(), only cap_permitted, euid,
and egid are checked.  A process that creates or inherits a rootns fd and
then drops its real/saved UIDs or GIDs, clears supplementary groups with
setgroups(), drops capabilities from cap_bset or cap_effective, sets
no_new_privs, or confines itself with an LSM such as Landlock still passes
this check and spawns a child with the original unconfined rootns->cred.

In the second branch, when old->user_ns !=3D target->user_ns, only
ns_capable() on target->user_ns->parent is checked, without verifying
cred_cap_issubset(old, target) or checking that target's UIDs, GIDs, and
group_info are mapped into target->user_ns->parent.  If a process with
GLOBAL_ROOT_UID enters a child user namespace whose parent is owned by an
unprivileged user and calls rootns_create(0), the unprivileged owner of
target->user_ns->parent can clone into that rootns and gain
GLOBAL_ROOT_UID.

Conversely, when old->user_ns =3D=3D target->user_ns and old->euid !=3D
target->euid, the early return rejects callers even when they hold
CAP_SYS_ADMIN, CAP_SETUID, and CAP_SETGID in target->user_ns.

> @@ -260,7 +283,8 @@ struct cred *prepare_exec_creds(void)
>   * The new process gets the current process's subjective credentials as =
its
>   * objective and subjective credentials
>   */
> -int copy_creds(struct task_struct *p, u64 clone_flags)
> +int copy_creds(struct task_struct *p, u64 clone_flags,
> +	       struct rootns *rootns)
>  {
>  	struct cred *new;
>  	int ret;
> @@ -283,7 +307,13 @@ int copy_creds(struct task_struct *p, u64 clone_flag=
s)
>  		return 0;
>  	}
> =20
> -	new =3D prepare_creds();
> +	if (rootns) {
> +		if (!may_enter_rootns_creds(current_cred(), rootns->cred))
> +			return -EPERM;
> +		new =3D dup_creds(rootns->cred);
> +	} else {
> +		new =3D prepare_creds();
> +	}
>  	if (!new)
>  		return -ENOMEM;

[Severity: Critical]
Does switching p to rootns->cred leave p->exec_state->dumpable set to
TASK_DUMPABLE_OWNER and allow sharing current->mm across privilege
boundaries?

In copy_process(), copy_exec_state() runs before copy_creds() and copies
current->exec_state (or refcount-shares it when CLONE_VM | CLONE_VFORK is
used).  Unlike commit_creds(), copy_creds() does not reset dumpability to
suid_dumpable when UIDs, GIDs, or capabilities change between
current_cred() and rootns->cred:

kernel/ptrace.c:task_still_dumpable() {
	...
	exec_state =3D task_exec_state_rcu(task);
	if (READ_ONCE(exec_state->dumpable) =3D=3D TASK_DUMPABLE_OWNER)
		return true;
	return ptrace_has_cap(exec_state->user_ns, mode);
}

When a dumpable privileged daemon spawns a child into a less-privileged
rootns, unprivileged tasks in that rootns matching rootns->cred can attach
via ptrace() or access /proc/<pid>/mem and /proc/<pid>/fd/* before the
child calls execve().  Because clone3_args_valid() also allows CLONE_VM |
CLONE_VFORK with CLONE_INTO_ROOTNS, the child shares current->mm with the
parent daemon, allowing tasks in the target rootns to modify the parent
daemon's live memory.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99e22b3cd213e..978605de8428e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c

[ ... ]

> @@ -2566,7 +2583,7 @@ __latent_entropy struct task_struct *copy_process(
>  			attach_pid(p, PIDTYPE_TGID);
>  			attach_pid(p, PIDTYPE_PGID);
>  			attach_pid(p, PIDTYPE_SID);
> -			copy_rootns(p, NULL);
> +			copy_rootns(p, clone_args_rootns(args));
>  			__this_cpu_inc(process_counts);
>  		} else {
>  			current->signal->nr_threads++;

[Severity: High]
Can forking into a rootns PID namespace via setns(CLONE_NEWPID) without
CLONE_INTO_ROOTNS cause a refcount underflow or use-after-free on struct
rootns?

create_rootns() sets ns->pid_ns_for_children->rootns =3D c without taking a
reference on c and activates the namespace in ns_tree, while put_rootns()
frees c without clearing pid_ns_for_children->rootns.  A caller with
CAP_SYS_ADMIN can open an nsfs fd for pid_ns_for_children via
open_by_handle_at(FD_NSFS_ROOT, ...), call setns(pidns_fd, CLONE_NEWPID),
and fork() PID 1 without CLONE_INTO_ROOTNS.  Because clone_args_rootns() is
NULL, copy_rootns() returns early without calling get_rootns(c), but when
that PID 1 exits, zap_pid_ns_processes() -> exit_rootns() still
dereferences pid_ns->rootns and calls put_rootns(c):

kernel/rootns.c:copy_rootns() {
	if (likely(!c || READ_ONCE(c->state) !=3D ROOTNS_FORKING))
		return;

	scoped_guard(spinlock, &c->lock) {
		get_rootns(c);
		WRITE_ONCE(c->init_pid, get_task_pid(tsk, PIDTYPE_TGID));
		WRITE_ONCE(c->state, ROOTNS_RUNNING);
	}
	wake_up_all(&c->waitq);
}

If the rootns fd was already closed, exit_rootns() dereferences freed
memory; if the rootns fd is still open, exit_rootns() drops the fd's
reference and frees c prematurely.

[Severity: Medium]
Can a concurrent rootns_kill() or close() with ROOTNS_KILL_ON_CLOSE miss
the init task because copy_rootns() transitions rootns->state to
ROOTNS_RUNNING before attach_pid(p, PIDTYPE_PID)?

CPU0                              CPU1
copy_process()
  attach_pid(p, PIDTYPE_TGID)
  copy_rootns(p, ...)
    c->init_pid =3D ...
    c->state =3D ROOTNS_RUNNING
                                  SYSCALL_DEFINE2(rootns_kill, ...)
                                    rootns_kill_members()
                                      kill_pid(pid, sig, 0)
                                        pid_task(pid, PIDTYPE_PID)
                                        --> NULL (-ESRCH)
  attach_pid(p, PIDTYPE_PID)

Neither __rootns_kill() nor rootns_kill_members() takes tasklist_lock, so a
signal sent in this window sees ROOTNS_RUNNING and PIDTYPE_TGID attached,
but kill_pid() looks up PIDTYPE_PID and fails with -ESRCH.  Calling
copy_rootns() after attach_pid(p, PIDTYPE_PID) avoids this window.

> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 8a3c6d4e94e2a..78a1e1fb2cfd7 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -166,12 +167,18 @@ struct nsproxy *create_new_namespaces(u64 flags,
>   * called from clone.  This now handles copy for nsproxy and all
>   * namespaces therein.
>   */
> -int copy_namespaces(u64 flags, struct task_struct *tsk)
> +int copy_namespaces(u64 flags, struct task_struct *tsk,
> +		    struct rootns *rootns)
>  {
>  	struct nsproxy *old_ns =3D tsk->nsproxy;
>  	struct user_namespace *user_ns =3D task_cred_xxx(tsk, user_ns);
>  	struct nsproxy *new_ns;
> =20
> +	if (rootns) {
> +		get_nsproxy(rootns->ns);
> +		tsk->nsproxy =3D rootns->ns;
> +		return 0;
> +	}

[Severity: Medium]
Does returning early here skip time namespace VDSO setup when rootns->ns
has a different time namespace from the caller?

In copy_process(), copy_mm() duplicates current->mm (including any faulted
[vvar] mappings for old_ns->time_ns) before copy_namespaces() runs.
Returning early without calling timens_commit() or timens_on_fork() leaves
the child's [vvar] mapping pointing at the parent's time namespace until
execve(), and when CLONE_VM | CLONE_VFORK is used, allows tasks sharing an
mm_struct to have different time namespaces.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117231352.3816=
603-1-jarkko@kernel.org?part=3D7
