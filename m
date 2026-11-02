Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632954;
	b=YNRgYhMXWde/GCsPBhNv1JKjpBpG7ZqusympPjzYOB/g+XtB8V1Bv3C3q5+aUeJMyz16
	 0PlHa3a3BdIP8sdcEQn8AQ2HLWVgiXQkeYiKG0NM1CLfnF5GDy2JpV8+SkUyIri8Bm6EQ
	 rYhYcjFFnNdApKXteydb/1t80o/vNCKNikb2L5iryquRpGNYQ2KoJYoS6mMQadrwj30Vx
	 MNZCwIqd77BWngz+K12ibxiSfjoFbOVkIzmQY6Uvcdq2PpElvV01kOJsEpoS97E3Nql9k
	 BXAa3oK6vCqVHFa3ex/DlGjFsUeJdpiXb1zFWhuXvuBivYNJybjyF/Et9gpTOjXdXeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632954;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ghpxkq4Skg3mUBHamxSj4ym+RFlCOTQsite+G/+1MNU=;
	b=phKJmdSt6+GNDzLuXbdmgbSLRnn/g0DpAnNvp953gz4IivrZeZImEKYehy+nD/oievD9
	 WrD612ZE0lY5k1/IPFdNUjMSmGvDXrfeoVX5fK5SdZUr0uBCV2KjK8gR8Vp1y+WhdWUnb
	 w8e94BJLQ4buGepluEcixbd2Cyohm31FWpkniA637UEV4KPNtfIWBzoN2gVhzK9VLBFHv
	 tG/Vc73U1LDFQCz6wXaC4NJmOXUyxDlRjxXsoZg2chCTVKTNCeD8mxz900qUUdw9i1+aC
	 pEQENlKm21pH0xlgsjQjqs96bSo9dZ24OK/xg5k2Dtl4x3qMLaHeEby56yZFhQksARQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YeNmEW/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9160A5BCF
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeNmEW/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51981F00A16
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632953;
	bh=ghpxkq4Skg3mUBHamxSj4ym+RFlCOTQsite+G/+1MNU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YeNmEW/l2DC6/TQ9cH62O/M8A3/FXIunIAbMtpVyEFyN4jb9EFjs+VIYW2PomvKQ4
	 2kCKuF4RG2jzglVJo/3mxSuhTkvqIeFPqeMZn64pVyv1EWir1G7C5pDKgD0Bj7FKnj
	 LzSZFuPvF25wsVTCstnhsvxlMhMmhEQbiZQlHjHoJxhkDo/0v0ZQm74EEASvBqnpOZ
	 C+n2jXMKnlVM0cOPr+apzweWb4+Jmz+vHERVwRve2Z+Kx6EtdpA8EREJ3DS5qa15kf
	 Utby9LS6RdngZm9kIjNkG5idkZHWeNrRV5BZKPND+e5zulSjGiH418Rei6gGrzvieB
	 LgSFkTMVIrRkw==
Message-ID: <sashiko-outbox-193655@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] samples/landlock: Add POSIX message queue
 scoping to sandboxer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102144708.920232-5-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
 <20261102144708.920232-5-webprosto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:22:33 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] landlock: user-triggerable WARN_ON_ONCE and wrong mount in hook_in=
ode_create()
- [Medium] samples/landlock: commit message example with LL_FS_RW=3D"" deni=
es mq_open()
- [Medium] landlock: hook_inode_unlink() clears object->domain before unlin=
k succeeds
- [Low] landlock: omitted parameter name in hook_inode_create() breaks GCC =
< 11 build
--

commit fb37ae1137756d3c9de1fe75208b0f3f51d1b11c
Author: Oxana Kharitonova <webprosto@gmail.com>

samples/landlock: Add POSIX message queue scoping to sandboxer

This series adds LANDLOCK_ACCESS_FS_MAKE_REG enforcement for POSIX message
queue creation, introduces LANDLOCK_SCOPE_POSIX_MSG_QUEUE in ABI 13, and
updates the Landlock sample sandboxer to support the new scope and audit
quieting option.

>     samples/landlock: Add POSIX message queue scoping to sandboxer
>    =20
>     Add "q" to LL_SCOPED to enable LANDLOCK_SCOPE_POSIX_MSG_QUEUE
>     and "posix_msg_queue" to LL_QUIET_ACCESS to quiet related audit
>     denials. Update the supported ABI version to 13 and disable the
>     new scope when running on older kernels.
>    =20
>     For example, on a kernel supporting Landlock ABI 13:
>    =20
>       LL_FS_RO=3D"/" LL_FS_RW=3D"" LL_SCOPED=3D"q" \
>         ./samples/landlock/sandboxer /bin/sh
>    =20
>     The resulting shell and its children cannot open POSIX message
>     queues created outside their Landlock domain. They can create
>     queues and open queues created within that domain.
>    =20
>     Signed-off-by: Oxana Kharitonova <webprosto@gmail.com>

[Severity: Medium]
Does the example command in the commit message actually allow the shell and
its children to create or open POSIX message queues?

In samples/landlock/sandboxer.c:main(), ruleset_attr.handled_access_fs is
unconditionally initialized to access_fs_rw:

	__u64 access_fs_ro =3D ACCESS_FS_ROUGHLY_READ,
	      access_fs_rw =3D ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;

	struct landlock_ruleset_attr ruleset_attr =3D {
		.handled_access_fs =3D access_fs_rw,

When LL_FS_RW=3D"" is passed, populate_ruleset_fs() returns early without a=
dding
any read-write rules:

	if (num_paths =3D=3D 1 && path_list[0][0] =3D=3D '\0') {
		/*
		 * Allows to not use all possible restrictions (e.g. use
		 * LL_FS_RO without LL_FS_RW).
		 */
		ret =3D 0;
		goto out_free_name;
	}

This leaves LANDLOCK_ACCESS_FS_MAKE_REG and LANDLOCK_ACCESS_FS_WRITE_FILE
handled and denied everywhere. Creating a queue via mq_open() with O_CREAT
invokes hook_inode_create(), which checks LANDLOCK_ACCESS_FS_MAKE_REG on
ipc_ns->mq_mnt and denies creation with EACCES.

In addition, do_mq_open() and hook_inode_create() operate on
current->nsproxy->ipc_ns->mq_mnt, which is an internal SB_KERNMOUNT mount
where path traversal in is_access_to_paths_allowed() stops at mq_mnt->mnt_r=
oot
(follow_up() returns false) and never reaches "/". Because of that,
LL_FS_RO=3D"/" does not grant LANDLOCK_ACCESS_FS_READ_FILE to mq_open() eit=
her;
wouldn't the mqueue filesystem for the current IPC namespace (such as
/dev/mqueue) need to be mounted and included in LL_FS_RW for this example to
work as described?

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..e9c52332dfcde 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
[ ... ]
> +/*
> + * Drop the reference retained by hook_d_instantiate() for a POSIX messa=
ge
> + * queue once its sole name is unlinked.
> + */
> +static int hook_inode_unlink(struct inode *const dir,
> +			     struct dentry *const dentry)
> +{
> +	const struct inode *const inode =3D d_backing_inode(dentry);
> +	struct landlock_domain *domain;
> +	struct landlock_object *object;
> +
> +	if (!landlock_is_posix_mqueue_inode(inode))
> +		return 0;
> +
> +	rcu_read_lock();
> +	object =3D rcu_dereference(landlock_inode(inode)->object);
> +	/* The temporary reference protects against concurrent object release. =
*/
> +	if (!object || !refcount_inc_not_zero(&object->usage)) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +	rcu_read_unlock();
> +
> +	spin_lock(&object->lock);
> +	domain =3D object->domain;
> +	object->domain =3D NULL;
> +	spin_unlock(&object->lock);
> +
> +	/* Drop the temporary reference acquired by refcount_inc_not_zero(). */
> +	landlock_put_object(object);
> +	if (domain) {
> +		landlock_put_domain_deferred(domain);
> +		/* Drops the reference retained by hook_d_instantiate(). */
> +		landlock_put_object(object);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Can clearing object->domain in hook_inode_unlink() strip the creator domain
from a queue before the unlink actually succeeds, or while the queue inode =
is
still alive?

In vfs_unlink(), security_inode_unlink(dir, dentry) is a pre-operation
permission hook invoked before try_break_deleg() and dir->i_op->unlink().
Because Landlock is ordered before SELinux, Smack, AppArmor, and BPF LSM in
CONFIG_LSM, hook_inode_unlink() runs first, sets object->domain =3D NULL, a=
nd
drops the domain and object references retained by hook_d_instantiate().

If a subsequent stacked LSM hook or delegation break fails, vfs_unlink()
aborts and the queue remains linked in mqueuefs with object->domain =3D=3D =
NULL.
Any later mq_open() or open() from the creator's domain with
LANDLOCK_SCOPE_POSIX_MSG_QUEUE enabled will see creator_domain =3D=3D NULL =
in
landlock_check_posix_mqueue_open() and fail with -EPERM. The same -EPERM al=
so
occurs if an unlinked queue with an open file descriptor is reopened by the
creator's domain via /proc/self/fd/<fd>.

Should the domain reference instead be released when the underlying inode is
evicted or released rather than inside the pre-unlink permission hook?

[ ... ]
> +/*
> + * Unlike regular file creation, mq_open(2) calls vfs_mkobj() directly a=
nd
> + * therefore does not trigger the path_mknod hook.  Use the mqueuefs mou=
nt
> + * associated with the current IPC namespace to recover the parent path.
> + */
> +static int hook_inode_create(struct inode *const dir,
> +			     struct dentry *const dentry, const umode_t)

[Severity: Low]
Does omitting the parameter name for const umode_t in hook_inode_create()
break builds with older supported GCC versions?

The kernel compiles C sources with -std=3Dgnu11 and supports GCC >=3D 8.1.0,
whereas unnamed parameters in function definitions are a C23 feature only
supported by GCC 11 and later (older versions fail with "error: parameter n=
ame
omitted").

> +{
> +	struct ipc_namespace *ipc_ns;
> +	struct vfsmount *mnt;
> +	struct path parent;
> +
> +	if (!landlock_is_posix_mqueue_fs(dir))
> +		return 0;
> +
> +	if (!current->nsproxy)
> +		return 0;
> +	ipc_ns =3D current->nsproxy->ipc_ns;
> +	if (!ipc_ns)
> +		return 0;
> +	mnt =3D ipc_ns->mq_mnt;
> +	if (WARN_ON_ONCE(!mnt || mnt->mnt_sb !=3D dir->i_sb))
> +		return 0;
> +
> +	parent.mnt =3D mnt;
> +	parent.dentry =3D dentry->d_parent;
> +	return current_check_access_path(&parent, LANDLOCK_ACCESS_FS_MAKE_REG);
> +}

[Severity: High]
Can hook_inode_create() also be reached via VFS path-based creation on a
mounted mqueue filesystem, triggering the WARN_ON_ONCE() from unprivileged
userspace or checking the wrong mount?

In ipc/mqueue.c, mqueue_dir_inode_operations sets .create =3D mqueue_create=
, so
calling open(..., O_CREAT, ...) or mknod(..., S_IFREG, ...) on a mounted
mqueue filesystem (such as /dev/mqueue, which has mode 01777) calls
security_path_mknod() followed by security_inode_create() ->
hook_inode_create().

This appears to cause two regressions:

1. A mounted mqueue superblock belongs to the ipc_namespace active at mount
time (sb->s_fs_info), which need not match current->nsproxy->ipc_ns. An
unprivileged user can call unshare(CLONE_NEWUSER | CLONE_NEWIPC) while keep=
ing
access to the previous IPC namespace's /dev/mqueue mount and call
open("/dev/mqueue/foo", O_CREAT, 0600). In hook_inode_create(),
current->nsproxy->ipc_ns->mq_mnt->mnt_sb !=3D dir->i_sb, triggering the
WARN_ON_ONCE() and returning 0 without enforcing LANDLOCK_ACCESS_FS_MAKE_RE=
G.

2. Even within the same IPC namespace, if a sandboxed process creates a que=
ue
via open("/dev/mqueue/foo", O_CREAT, 0600) or mknod() and its ruleset grants
LANDLOCK_ACCESS_FS_MAKE_REG on an ancestor directory such as "/" or "/dev"
rather than directly on the /dev/mqueue root inode, hook_path_mknod() succe=
eds
by walking up across the mountpoint via follow_up(). However,
hook_inode_create() then checks parent.mnt =3D ipc_ns->mq_mnt (an internal
SB_KERNMOUNT mount where follow_up() stops at the root) and denies the
creation with -EACCES.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144708.9202=
32-1-webprosto@gmail.com?part=3D4
