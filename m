Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978592;
	b=1kNXLLZWTINgJBWoHLDhd268bascUaIAFIEptQxv7uXYg0f20Px4ELJILQt1rgf2xnI1
	 zaxokG/SCmZbxsl8Vx+QqLQpgVt3iyS5IwllWVVZVd8yNOeFnrOOInO78Y0HhQGOf8+kG
	 mzhEdGGa7pMJ8vWNar9LSifT5KnM9DLxPw0QeRLBGYQf0CZVHukzF1v+6dd8uYxjha2iu
	 r+cgamT+eZlCNZ0/L5KGTZnFbAzh29FRqVj12/nJeKbezEHZGWjMUthvpUYCocSTFfOSp
	 qdzRRVBJlcb3wmtrMpOx2wTqMX8XaTibAdtcH0eB36fxSkLMtTqf3tOuRSZeOCMTPAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ghFaqqHrnriJElJgqz9O9Vc1cSqEDgRBv8DJ1pP0bDg=;
	b=1t2ZSw+UVzRAtIo0ukDY2Aqb83IAxw6PtubfyhoBYbZaeo0G3M02f0WngUQEeTIWId7D
	 5bHYrqdeCIhTRgsHINVId+IbW5lEyhX9gVu7zMO+SwPMiUH6Kj7z2Mgv/sslK/X1v82YC
	 zLOWfcG9hBlb/5zMFaAVR8KmmtjLiUgG9mjbmmVixLI2lluzSZJK3F5339/RphCGSR3HN
	 n1+f5i6/U4g0QwEYwZnYhv7MPUeksG1lwtK2Dmkv/o7jykd/JOFfC+JdgjkN6wxRlkns2
	 5/dg/7OOdDTGsCEV3p7pky+xsFfm+LHuLMIAo7wBwwzbrdhZcT3806oESxpB8FDU5qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1y2MDfw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF934606A31C
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1y2MDfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1561F000C6;
	Wed, 18 Nov 2026 05:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794978591;
	bh=ghFaqqHrnriJElJgqz9O9Vc1cSqEDgRBv8DJ1pP0bDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1y2MDfwntqzTgEKQnRX4PtKJCdL71HqBycHeN1yvhCLTghs1RtmdchrGfX+/AthP
	 LhRF5TfESSXEoclERPjMYtU3E/Bl9mUYaJkiTzFlWtQI+pT6w3g5Nb5z9h5JzpqxS+
	 n8V9ZIFh5F/gynciQnLHdnejdSQv2V6tjWk89A4KigRYEVo0SsTzym/qN5RXOdl2jh
	 RrlQCuGZaEmRHF/LcwDTdLxzpVb7aR3IIl9FV4zckBuLv/MzlPTHBvKEb22stSLGCQ
	 GoaP5Fw9rQgmHFc5FUP8rmAPipXZVI52hCbSKP7XDkG4CafuJ/oMkC41xIWXF6vPlL
	 z0sSjdfTzauCQ==
Message-ID: <sashiko-outbox-220142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/13] rootns: Add rootns_enter() system call
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
In-Reply-To: <20261117050841.3289652-8-jarkko@kernel.org>
References: <20261117050841.3289652-1-jarkko@kernel.org>
 <20261117050841.3289652-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 05:09:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [Critical] cred: privilege escalation and NNP bypass in
  may_enter_rootns_creds()
- [High] cred: missing dumpability reset in copy_creds() on rootns entry
- [High] rootns: refcount underflow and UAF of rootns via setns() on
  pid_ns
- [High] rootns: sys_rootns_enter() calls kernel_clone() without arch
  fork wrappers
- [Medium] nsproxy: missing timens_commit() in copy_namespaces() on
  rootns entry
- [Medium] fork: stale rootns->root used in copy_fs() after pivot_root()
- [Medium] rootns: rootns_may_setns() rejects setns() to inherited
  rootns namespaces
--

commit 2b3b027946b3cddbb69540b1d520fd1496bf137c
Author: Jarkko Sakkinen <jarkko@kernel.org>

rootns: Add rootns_enter() system call

This commit introduces the rootns_enter() system call to fork a child
process directly into a configured rootns, along with credential checks
and namespace provenance tracking for setns().

> diff --git a/kernel/cred.c b/kernel/cred.c
> index d01df40a9a386..97d334db7758a 100644
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
> +	if (task_no_new_privs(current) || old->user_ns =3D=3D target->user_ns)
> +		return false;
> +
> +	return ns_capable(target->user_ns->parent, CAP_SYS_ADMIN) &&
> +	       ns_capable(target->user_ns->parent, CAP_SETUID) &&
> +	       ns_capable(target->user_ns->parent, CAP_SETGID);
> +}

[Severity: Critical]
Can a process bypass PR_SET_NO_NEW_PRIVS, regain dropped credentials, or
escape an LSM domain through may_enter_rootns_creds()?

When may_enter_rootns_creds() succeeds, copy_creds() replaces the child's
entire struct cred with dup_creds(rootns->cred).  The early return runs
before the task_no_new_privs(current) check and only compares euid, egid,
and cred_cap_issubset(old, target).  For a ROOTNS_USER namespace where
old->euid is target->user_ns->owner, cred_cap_issubset() returns true
even if old dropped capabilities or set PR_SET_NO_NEW_PRIVS, letting the
child gain full capabilities in target->user_ns.

Even in the same user namespace, the early return does not check real,
saved, or fs UIDs/GIDs, group_info, cap_effective, cap_bset, securebits,
or the LSM security blob.  A process that creates a rootns and later
drops real/saved UIDs, clears supplementary groups, drops bounding set
bits, or restricts itself with Landlock can call rootns_enter() to spawn
a child with the original unrestricted rootns->cred.

In the second branch, CAP_SETUID and CAP_SETGID are checked only against
target->user_ns->parent without checking old->user_ns or verifying that
target's UIDs, GIDs, and supplementary groups are mapped into
target->user_ns->parent.  Conversely, when old->user_ns =3D=3D target->user=
_ns,
a caller holding CAP_SYS_ADMIN, CAP_SETUID, and CAP_SETGID in old->user_ns
is rejected if its euid or egid differs from target.

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

[Severity: High]
Does switching credentials to rootns->cred in copy_creds() leave
p->exec_state->dumpable set to TASK_DUMPABLE_OWNER?

In copy_process(), copy_exec_state() copies current->exec_state->dumpable
into p->exec_state before copy_creds() runs.  Unlike commit_creds(),
copy_creds() does not reset dumpable to suid_dumpable when UIDs, GIDs, or
capabilities change.  When a privileged daemon calls rootns_enter() to
fork into a rootns owned by an unprivileged user, processes inside the
target user namespace pass task_still_dumpable() and can ptrace the child
before execve(), reading the daemon's duplicated memory or stealing its
open file descriptors via pidfd_getfd().

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 99e22b3cd213e..5e23d36b7ac3e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
[ ... ]
> @@ -1671,6 +1683,10 @@ static int copy_fs(u64 clone_flags, struct task_st=
ruct *tsk,
>  	tsk->real_fs =3D tsk->fs =3D copy_fs_struct(fs);
>  	if (!tsk->fs)
>  		return -ENOMEM;
> +	if (rootns) {
> +		set_fs_root(tsk->fs, &rootns->root);
> +		set_fs_pwd(tsk->fs, &rootns->root);
> +	}
>  	return 0;
>  }

[Severity: Medium]
If a process inside a running rootns changes the root mount with
pivot_root() or overmounts "/", will subsequent rootns_enter() calls get
a stale root path here?

rootns->root holds the initial mount installed by MOVE_MOUNT_T_ROOTNS_ROOT
and is not updated by pivot_root().  Setting tsk->fs root and pwd to
&rootns->root gives newly entering tasks the old root mount instead of
the current root of rootns->ns->mnt_ns.

> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index a76837b3ee332..0c6407757d896 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -169,13 +169,21 @@ struct nsproxy *create_new_namespaces(u64 flags,
>  /*
>   * called from clone.  This now handles copy for nsproxy and all
>   * namespaces therein.
> + *
> + * Namespaces derived from a rootns member inherit the same rootns domai=
n.
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
Does returning early here without calling timens_commit() leave the child
with the parent's VDSO vvar mappings when entering a rootns in a
different time namespace?

copy_mm() runs before copy_namespaces() and duplicates the caller's vvar
PTEs into tsk->mm.  When old_ns->time_ns differs from rootns->ns->time_ns,
skipping timens_commit() leaves the old vvar mappings in place until
execve(), so vDSO clock_gettime() in the child reads the wrong time
namespace offsets.

> diff --git a/kernel/rootns.c b/kernel/rootns.c
> index f59b2fe9910de..e286c1e753b71 100644
> --- a/kernel/rootns.c
> +++ b/kernel/rootns.c
[ ... ]
> +static atomic64_t rootns_id =3D ATOMIC64_INIT(0);
> +
> +static void rootns_tag_namespaces(struct rootns *c, const struct nsproxy=
 *old)
> +{
> +	struct nsproxy *ns =3D c->ns;
> +
> +	if (c->cred->user_ns !=3D current_user_ns())
> +		c->cred->user_ns->ns.rootns_id =3D c->id;
> +	from_mnt_ns(ns->mnt_ns)->rootns_id =3D c->id;
> +	ns->pid_ns_for_children->ns.rootns_id =3D c->id;
> +	if (ns->uts_ns !=3D old->uts_ns)
> +		ns->uts_ns->ns.rootns_id =3D c->id;
> +	if (ns->ipc_ns !=3D old->ipc_ns)
> +		ns->ipc_ns->ns.rootns_id =3D c->id;
> +	if (ns->cgroup_ns !=3D old->cgroup_ns)
> +		ns->cgroup_ns->ns.rootns_id =3D c->id;
> +	if (ns->net_ns !=3D old->net_ns)
> +		ns->net_ns->ns.rootns_id =3D c->id;
> +}
> +
> +bool rootns_may_setns(struct rootns *rootns, struct ns_common *ns)
> +{
> +	if (!ns)
> +		return false;
> +	if (!rootns || is_current_namespace(ns))
> +		return true;
> +
> +	return ns->rootns_id =3D=3D rootns->id;
> +}

[Severity: Medium]
Does rootns_may_setns() reject intra-rootns setns() back to a namespace
that the rootns inherited at creation time?

rootns_tag_namespaces() only sets c->id on newly created namespaces, so
any namespace inherited from the creator (such as time_ns, or UTS, IPC,
cgroup, net, or user namespaces omitted from rootns_create() flags) keeps
its previous rootns_id.  If a task inside the rootns unshares one of
those namespace types, is_current_namespace(ns) becomes false for the
rootns's initial namespace and ns->rootns_id !=3D rootns->id, causing
setns() back to PID 1's namespace to fail with -EPERM.

> @@ -249,6 +308,7 @@ static struct rootns *create_rootns(unsigned int flag=
s)
>  	c->ns =3D ns;
>  	ns->rootns =3D c;
>  	ns->pid_ns_for_children->rootns =3D c;
> +	rootns_tag_namespaces(c, current->nsproxy);
>  	nsproxy_ns_active_get(ns);
> =20
>  	return c;

[Severity: High]
Can an external task joining ns->pid_ns_for_children via setns() trigger
a refcount underflow and use-after-free on struct rootns?

create_rootns() sets ns->pid_ns_for_children->rootns =3D c without taking a
reference on c, and marks ns->pid_ns_for_children active in the namespace
tree via nsproxy_ns_active_get(ns).  The reference on c that pairs with
exit_rootns()'s put_rootns(c) is only acquired in copy_rootns() when PID 1
is forked through sys_rootns_enter() in state ROOTNS_FORKING:

kernel/rootns.c:copy_rootns() {
	if (likely(!c || READ_ONCE(c->state) !=3D ROOTNS_FORKING))
		return;

	scoped_guard(spinlock, &c->lock) {
		get_rootns(c);
...
}

Because rootns_may_setns() returns true when task_rootns(current) is NULL,
a process outside any rootns can open ns->pid_ns_for_children from nsfs,
call setns(fd, CLONE_NEWPID), and fork() PID 1 with args->rootns =3D=3D NUL=
L.
copy_rootns() then skips get_rootns(c), but when that child exits,
zap_pid_ns_processes() -> exit_rootns() still calls put_rootns(c),
dropping the rootns fd's reference and freeing c while the fd is still
open (or dereferencing a dangling pid_ns->rootns if the fd was already
closed, since put_rootns() does not clear pid_ns->rootns).

> @@ -455,3 +515,85 @@ SYSCALL_DEFINE2(rootns_kill, int, rootnsfd, int, sig)
[ ... ]
> +SYSCALL_DEFINE1(rootns_enter, int, rootnsfd)
> +{
[ ... ]
> +	args.rootns =3D rootns;
> +	ret =3D kernel_clone(&args);

[Severity: High]
Is calling kernel_clone() directly from a regular C syscall safe on
architectures that require fork/clone entry wrappers?

On alpha, m68k, parisc, mips, arc, nios2, and openrisc, fork and clone
syscalls enter through assembly wrappers that allocate a switch_stack or
save callee-saved registers before calling C code, which copy_thread()
then reads from the stack.  On sparc, the wrapper must flush register
windows via synchronize_user_stack(), and copy_thread() checks whether
UREG_G1 is __NR_clone3 to return 0 in the child instead of the parent's
PID.  Calling kernel_clone() from sys_rootns_enter() bypasses those paths
and corrupts the child's register state or return value on those
architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117050841.3289=
652-1-jarkko@kernel.org?part=3D7
