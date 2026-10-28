Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195866;
	b=vaeubt6Kg8kkfXJm5EJhfnjVPYJe4PMjwlpo9/b7lHBJ3Mfy+nUQuUPYsXz61CXX00IR
	 6VleDynK1kC3cFJbhNNPxtJegf5M/9exskvBmGYoFfzv0iA+fpBiQcxUuOP2Uo/tytttH
	 SGVjLFxQXEf7o/NXZR5ji135RxRV8NkHaPuMfL12RYBIn3Bs0NVsrgLUrndco1w7Ww7qQ
	 ngrnfYj75fLpE5TkmqSiaoFv3KJdO9LCVSAEJCPHdJeQk1JllfDQA57YreFw/lZP0vQ1T
	 ZGC0jNgrYhO3MUYzy5cZyXWgneEFTuP4Cz5wra0MkxPsxauyms0mW0dJLxRHVuV+u6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195866;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+k5t7nJ4M+oLEceZK0BWiMa1gDvU7UTvR/GUMIRwnGE=;
	b=Acu20XlOg5TRJfwE78dZC4AtPvV0HYTw/AGaqNQtUjLW3HB2D1M4sLXpzcjpPDx26MB3
	 eukJ+nmGtDXSuhDlvnut6iLzu5fPXrN+Qbt/IVPzi6SK63KyFzErLSAqHmAFEfkEMcKNM
	 j+eCfMj0z0qwavDWyzRqb/lPibzzz5w0Fq1ZR5RMyzt1aZC+gZZb8QXS+a5OZjkUT+OlP
	 PK5PaEG0KgMe7pcJL7Epw1b+doAXFssibM8loPKEiLow7RUUoGGWIDvnGjLybZyTYoSD0
	 w+4Uxqtl4klaQbUwktx/EfhlHr7kVPRN0379eaU0aWxAFP1OroVtWXGadCy+hu0pEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Am/1naHX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B3606A31A
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am/1naHX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6332E1F01825
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195865;
	bh=+k5t7nJ4M+oLEceZK0BWiMa1gDvU7UTvR/GUMIRwnGE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Am/1naHXsIPXNhRDBCwLCAlvzzYl4kxdwwnbR85e8LPi+5+f+NuCw3bAKB7fCl0Z/
	 2RjS64Wuc4tfokX0XfXmeSBN+BIO84f6Uzmonjyy7mDtPdgIc8MDgYSFXVcBqaVc9o
	 LG/S730eYdXI9+ybO4vnFonw3TiXE1y51hd+jN28U0yXYA6BFJkxdE+MNx0TWJSWpc
	 QZ64jZyDjZPfWH9FEz/n23crX2RpBTO0nzZnd7ltkfMEOK+fnB3I+HKgM6gN9cPTFR
	 UV0AB4jvwqccv3i/jwDAdIexr6hxdjCtgvggDyNLvc1klDQmkJXBgfgLpOprGZInZv
	 +kuQHdF2FxKqQ==
Message-ID: <sashiko-outbox-187950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/6] security: kap: add the securityfs control
 plane
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261028133335.75899-5-ketan@armoriq.io>
References: <20261028133335.75899-1-ketan@armoriq.io>
 <20261028133335.75899-5-ketan@armoriq.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:57:44 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] security: kap: detached kapfs_mnt breaks d_path() in kap_igroups_g=
et_link()
- [Medium] security: kap: dentry reference leak on control files in kapfs_m=
kdir()
- [Medium] security: kap: missing superblock ops and blocksize in kapfs_fil=
l_super()
- [Medium] security: kap: unbounded PID list growth in kap_bind_pid_locked()
- [Medium] security: kap: silent no-op on newline or NUL writes in kapfs_wr=
ite()
- [Medium] security: kap: unlocked kap_task_state race in kap_ptrace_target=
()
- [Medium] security: kap: CLONE_THREAD bind race in kap_bind_pid_locked()
- [Medium] security: kap: predicate boundary overrun in kap_compile_kind_ar=
ray()
- [Medium] security: kap: short sockaddr stack leak in kap_socket_connect()
--

commit b34e00991514a9c6893e4f407d13e24385bf26ea
Author: Ketan Bhardwaj <ketan@armoriq.io>

security: kap: add the securityfs control plane

This commit adds the securityfs control plane for the Kernel Assurance Plane
under /sys/kernel/security/kap and mounts an internal kapfs filesystem
reached via the igroups symlink to manage per-igroup directories and control
files.

> diff --git a/security/kap/kapfs.c b/security/kap/kapfs.c
> new file mode 100644
> index 0000000000000..36ef1e33a14e1
> --- /dev/null
> +++ b/security/kap/kapfs.c
[ ... ]
> +static int kapfs_show(struct seq_file *m, void *v)
> +{
> +	struct kap_file_ctx *ctx =3D m->private;
> +	struct kap_igroup *igroup =3D ctx->igroup;
> +	struct kap_bound_pid *entry;
> +
> +	spin_lock(&kap_lock);
> +	switch (ctx->kind) {
> +	case KAP_FILE_PROCS:
> +		list_for_each_entry(entry, &igroup->pids, node)
> +			seq_printf(m, "%d\n", entry->pid);
> +		break;

[Severity: Medium]
Does igroup->pids grow without bound and report stale pids here?

When a pid is written to kap.procs in kapfs_write(), an entry is allocated
with kzalloc_obj(*entry, GFP_KERNEL) and appended to igroup->pids in
kap_bind_pid_locked():

security/kap/igroup.c:kap_bind_pid_locked() {
	...
	if (kap_pid_in_igroup_locked(igroup, pid))
		return 0;
	(*entry)->pid =3D pid;
	list_add_tail(&(*entry)->node, &igroup->pids);
	*entry =3D NULL;
	return 0;
}

However, kap_task_free() in security/kap/kap_lsm.c only zeroes the task blob
when a task exits, and rebinding a task to another igroup in
kap_bind_pid_locked() does not remove it from the previous igroup's pids
list:

security/kap/kap_lsm.c:kap_task_free() {
	struct kap_task_state *state =3D kap_task_state(task);

	if (state)
		memset(state, 0, sizeof(*state));
}

As bound processes exit or rebind over the system lifetime, won't the
kap_bound_pid allocations in igroup->pids leak permanently and cause
kapfs_show() to print dead, recycled, or rebound pids?

[ ... ]
> +	case KAP_FILE_EVENTS:
> +		seq_write(m, igroup->events, igroup->events_len);
> +		break;

[Severity: Medium]
Can kapfs_show() expose uninitialized kernel stack bytes through
igroup->events when a bound task calls connect() with a short address lengt=
h?

In security/kap/kap_lsm.c, kap_socket_connect() only verifies that addrlen =
is
at least offsetofend(struct sockaddr, sa_family) (2 bytes) before passing
address to kap_check_current_emit():

security/kap/kap_lsm.c:kap_socket_connect() {
	if (addrlen < offsetofend(struct sockaddr, sa_family) ||
	    address->sa_family =3D=3D AF_UNSPEC || address->sa_family =3D=3D AF_UN=
IX)
		return 0;
	return kap_check_current_emit(KAP_HOOK_SOCKET_CONNECT, address,
				      "net_predicate_denied", "net_allowed");
}

In __sys_connect(), the kernel stack sockaddr_storage buffer is not
zero-initialized, and move_addr_to_kernel() only copies addrlen bytes from
userspace. When kap_object_target() in security/kap/igroup.c formats the
target for igroup->events, it reads sin_addr and sin_port or sin6_addr and
sin6_port without checking addrlen:

security/kap/igroup.c:kap_object_target() {
		if (addr->sa_family =3D=3D AF_INET) {
			const struct sockaddr_in *in =3D object;

			scnprintf(target, target_len, "%pI4:%u",
				  &in->sin_addr, ntohs(in->sin_port));
			return 0;
		}
		if (addr->sa_family =3D=3D AF_INET6) {
			const struct sockaddr_in6 *in6 =3D object;

			scnprintf(target, target_len, "%pI6c:%u",
				  &in6->sin6_addr, ntohs(in6->sin6_port));
			return 0;
		}
}

If a bound task calls connect() with addrlen =3D=3D 2 and sa_family set to
AF_INET or AF_INET6, won't kap_object_target() format uninitialized kernel
stack memory into igroup->events and return it to userspace here?

[ ... ]
> +static ssize_t kapfs_write(struct file *file, const char __user *buf, si=
ze_t len, loff_t *ppos)
> +{
[ ... ]
> +	tmp =3D memdup_user_nul(buf, len);
> +	if (IS_ERR(tmp))
> +		return PTR_ERR(tmp);
> +	kap_trim_newline(tmp);
> +	if (!tmp[0]) {
> +		kfree(tmp);
> +		return len;
> +	}

[Severity: Medium]
Should writing a newline-only string or a NUL-prefixed buffer to a control
file return -EINVAL instead of succeeding as a silent no-op?

Because kapfs_write() returns len whenever tmp[0] is NUL after
kap_trim_newline(tmp), writing "\n" or "\0..." to kap.install, kap.procs,
kap.authority, kap.authority_epoch, kap.expires_at, kap.transition,
kap.mode, kap.default, or kap.lineage_root reports success to userspace
without validating the input or updating any state.

> +
> +	/* Parse, allocate and compile first: kap_lock is a spinlock. */
> +	switch (ctx->kind) {
> +	case KAP_FILE_PROCS:
> +		rc =3D kstrtoint(tmp, 10, &pid);
> +		if (!rc) {
> +			entry =3D kzalloc_obj(*entry, GFP_KERNEL);
> +			if (!entry)
> +				rc =3D -ENOMEM;
> +		}
> +		break;
> +	case KAP_FILE_LINEAGE_ROOT:
> +		if (strlen(tmp) > KAP_MAX_ROOT_LEN)
> +			rc =3D -EINVAL;
> +		break;
> +	case KAP_FILE_INSTALL:
> +		rc =3D kap_install_parse(tmp, &req);
> +		if (!rc)
> +			rc =3D kap_authority_prepare(req.authority, &compiled);
> +		break;
> +	case KAP_FILE_AUTHORITY:
> +		rc =3D kap_authority_prepare(tmp, &compiled);
> +		break;

[Severity: Medium]
When kapfs_write() passes an authority document to kap_authority_prepare(),
can predicates bleed across adjacent objects in kap_compile_kind_array() and
kap_validate_authority_payload()?

In security/kap/igroup.c, both kap_compile_kind_array() and
kap_validate_authority_payload() bound each predicate by scanning backwards
from "kind": to the nearest '{' character and scanning forwards to the next
"kind": substring:

security/kap/igroup.c:kap_compile_kind_array() {
	while ((predicate =3D kap_next_predicate(predicate, end, kind_name))) {
		const char *next =3D strstr(predicate + 1, "\"kind\":");
		const char *predicate_start =3D predicate;
		const char *predicate_end =3D next && next < end ? next : end;
		int rc;

		while (predicate_start > auth && *predicate_start !=3D '{')
			predicate_start--;
		rc =3D kap_compile_array(compiled, set, predicate_start,
				       predicate_end, array_name);
}

If the next predicate places its "allow":[...] or "deny":[...] array before
its "kind":"..." key, that array precedes next and falls inside the previous
predicate's [predicate_start, predicate_end) range. Similarly, if an array
before "kind" contains a '{' character in a path pattern, scanning backwards
for '{' stops inside the string literal rather than at the start of the
predicate object, skipping the array before it.

[ ... ]
> +	spin_lock(&kap_lock);
> +	switch (ctx->kind) {
> +	case KAP_FILE_PROCS:
> +		rc =3D kap_bind_pid_locked(igroup, pid, &entry);
> +		break;

[Severity: Medium]
Can binding a live process via kap_bind_pid_locked() race with concurrent
ptrace checks in kap_ptrace_target() and miss threads being created via
clone(CLONE_THREAD)?

First, kap_bind_pid_locked() mutates each thread's kap_task_state in place
under kap_lock, setting state->active =3D true before writing state->epoch =
and
state->igroup_name:

security/kap/igroup.c:kap_bind_pid_locked() {
	for_each_thread(task, t) {
		struct kap_task_state *state =3D kap_task_state(t);

		if (!state)
			continue;
		state->active =3D true;
		state->epoch =3D igroup->epoch;
		strscpy(state->igroup_name, igroup->name, sizeof(state->igroup_name));
	}
}

In security/kap/kap_lsm.c, kap_ptrace_access_check() and kap_ptrace_traceme=
()
call kap_ptrace_target() without holding kap_lock:

security/kap/kap_lsm.c:kap_ptrace_target() {
	struct kap_task_state *current_state =3D kap_task_state(current);
	struct kap_task_state *child_state =3D kap_task_state(child);

	if (current_state && current_state->active &&
	    child_state && child_state->active &&
	    !strcmp(current_state->igroup_name, child_state->igroup_name) &&
	    current_state->epoch =3D=3D child_state->epoch) {
		strscpy(target, "same-igroup", target_len);
		return;
	}
	if (child_state && child_state->active) {
		scnprintf(target, target_len, "igroup=3D%s", child_state->igroup_name);
		return;
	}
}

Because kap_ptrace_target() reads active, igroup_name, and epoch unlocked,
can it observe state->active =3D=3D true while igroup_name is still empty or
partially written, or while epoch is stale?

Second, in copy_process(), security_task_alloc() -> kap_task_alloc() runs
before copy_process() acquires current->sighand->siglock and links the new
thread onto signal->thread_head:

security/kap/kap_lsm.c:kap_task_alloc() {
	/* Under kap_lock, so a bind running now is copied whole or not at all. */
	spin_lock(&kap_lock);
	if (old && old->active)
		*new =3D *old;
	spin_unlock(&kap_lock);
}

If a thread in the target process is between kap_task_alloc() and
list_add_tail_rcu(&p->thread_node, &p->signal->thread_head) when
kap_bind_pid_locked() iterates for_each_thread(task, t), won't that new
thread be missed by both kap_task_alloc() and for_each_thread() and run
unconfined?

[ ... ]
> +/* Returns NULL on success: the passed dentry is the one instantiated. */
> +static struct dentry *kapfs_mkdir(struct mnt_idmap *idmap, struct inode =
*dir,
> +				  struct dentry *dentry, umode_t mode)
> +{
[ ... ]
> +	for (i =3D 0; i < KAP_FILE_COUNT; i++) {
> +		files[i] =3D d_alloc_name(dentry, kap_file_names[i]);
> +		inodes[i] =3D kapfs_make_inode(dir->i_sb, S_IFREG | kap_file_modes[i]);
[ ... ]
> +	}
[ ... ]
> +	/* Lookups in the new directory wait until its files are all there. */
> +	inode_lock(inode);
> +	kapfs_instantiate(dentry, inode);
> +	igroup->dentry =3D dentry;
> +	for (i =3D 0; i < KAP_FILE_COUNT; i++)
> +		kapfs_instantiate(files[i], inodes[i]);
> +	inode_unlock(inode);
> +	return NULL;

[Severity: Medium]
Does kapfs_mkdir() leak a dentry reference on each of the files[i] dentries?

Each files[i] is allocated via d_alloc_name(dentry, kap_file_names[i]) with
an initial reference count of 1 owned by kapfs_mkdir(). Calling
kapfs_instantiate(files[i], inodes[i]) invokes d_make_persistent(), which
sets DCACHE_PERSISTENT and increments d_lockref.count to 2 via dget_dlock():

fs/dcache.c:d_make_persistent() {
	...
	__d_instantiate(dentry, inode);
	dentry->d_flags |=3D DCACHE_PERSISTENT;
	dget_dlock(dentry);
	if (d_unhashed(dentry))
		__d_rehash(dentry);
	...
}

Unlike the directory dentry passed into kapfs_mkdir(), whose lookup/creation
reference is dropped by the VFS caller after vfs_mkdir() returns, nothing
calls dput(files[i]) after kapfs_instantiate(files[i], inodes[i]), leaving
every control file dentry with an extra reference count of 2 when idle.

[ ... ]
> +static int kapfs_fill_super(struct super_block *sb, struct fs_context *f=
c)
> +{
> +	struct inode *inode;
> +
> +	sb->s_magic =3D KAPFS_MAGIC;
> +	inode =3D kapfs_make_inode(sb, S_IFDIR | 0700);
> +	if (!inode)
> +		return -ENOMEM;
> +	inode->i_op =3D &kapfs_root_inode_ops;
> +	inode->i_fop =3D &simple_dir_operations;
> +	inc_nlink(inode);
> +	sb->s_root =3D d_make_root(inode);
> +	if (!sb->s_root)
> +		return -ENOMEM;
> +	return 0;
> +}

[Severity: Medium]
Should kapfs_fill_super() also initialize sb->s_op, sb->s_blocksize, and
sb->s_blocksize_bits?

Without setting sb->s_op =3D &simple_super_operations, sb->s_op remains at
&default_op where .statfs is NULL, causing statfs() and fstatfs() on paths
under /sys/kernel/security/kap/igroups to fail with -ENOSYS.

In addition, leaving sb->s_blocksize_bits as 0 causes new_inode() to set
inode->i_blkbits =3D 0 on all kapfs inodes, so stat() reports st_blksize =
=3D 1.
Userspace tools using stdio buffered writes sized from st_blksize will then
split writes into 1-byte write() calls, which kapfs_write() rejects with
-EINVAL on multi-byte control files such as kap.install and kap.authority.

[ ... ]
> +static const char *kap_igroups_get_link(struct dentry *dentry,
> +					struct inode *inode,
> +					struct delayed_call *done)
> +{
> +	struct path path;
> +	int rc;
> +
> +	if (!dentry)
> +		return ERR_PTR(-ECHILD);
> +	path.mnt =3D mntget(kapfs_mnt);
> +	path.dentry =3D dget(kapfs_mnt->mnt_root);
> +	rc =3D nd_jump_link(&path);
> +	return ERR_PTR(rc);
> +}

[Severity: High]
Does jumping to the unattached kapfs_mnt via nd_jump_link() break d_path()
resolution in the LSM hooks and allow a confined task to bypass path rules?

In kap_securityfs_init(), kapfs_mnt is created with kern_mount(&kapfs_type),
so it is an internal mount with no parent mount and mnt_ns =3D=3D NULL. Whe=
n a
process traverses /sys/kernel/security/kap/igroups, kap_igroups_get_link()
replaces nd->path with (kapfs_mnt, kapfs_mnt->mnt_root).

When KAP's LSM hooks resolve paths inside kapfs using d_path() in
kap_file_target(), kap_lsm_file_path_alloc(), kap_lsm_path_target(), and
kap_lsm_check_dir_entry():

security/kap/igroup.c:kap_file_target() {
	...
	path =3D d_path(&file->f_path, path_buf, PATH_MAX);
	if (IS_ERR(path))
		rc =3D PTR_ERR(path);
	else
		strscpy(target, path, target_len);
	...
}

d_path() stops at kapfs_mnt->mnt_root and formats paths relative to the root
of kapfs_mnt as "/<igroup>" (for mkdir) and "/<igroup>/<file>" (for open,
read, and write) rather than "/sys/kernel/security/kap/igroups/<igroup>/...=
".

Won't this cause two problems for bound tasks:

1. A bound task with CAP_SYS_ADMIN that is denied "/sys/**" but allowed a
   top-level path such as "/tmp" or "/tmp/**" can call
   mkdir("/sys/kernel/security/kap/igroups/tmp", 0700) (evaluated by
   kap_lsm_check_dir_entry() as "/tmp"), write an unrestricted policy to
   "/sys/kernel/security/kap/igroups/tmp/kap.install" (evaluated as
   "/tmp/kap.install"), and write its own pid to
   "/sys/kernel/security/kap/igroups/tmp/kap.procs" (evaluated as
   "/tmp/kap.procs"), which overwrites state->igroup_name in
   kap_bind_pid_locked() and escapes its confinement?

2. A bound orchestrator task granted "/sys/kernel/security/kap/**" will have
   its accesses to "/sys/kernel/security/kap/igroups/<igroup>/..." evaluated
   as "/<igroup>/..." and rejected with -EACCES, while an igroup named "pro=
c"
   will match kap_path_is_procfs() and be evaluated against procfs rules?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028133335.7589=
9-1-ketan@armoriq.io?part=3D4
