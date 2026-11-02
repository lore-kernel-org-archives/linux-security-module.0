Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631986;
	b=euaTgIrwALmBUU+uTHM+sZoQyOs6HUHz1WA62SO53cX8+rTV+D+ChSaXSpulXglrpM2D
	 kEK2TdJThrrdwHENl6HSiznICtDzUWKExn5Oz9EIs8TIcppEhzOzA2hwLL5KSrFcK7WV3
	 OK+aczCf62CFEF+yYJlIzD4w5doidFPuw0jz2cg1tYHrcxksVMRdy2tAEc5nN5pgOm0Yr
	 9m+UeKiyOzi+Lb1arLP7n9pdE57Iz9Z9OFjSMJqBzjNWUfbueerWHVjUL0NHv8+5eDXpp
	 djDVBA7+uEot6bYjKNxgbiCnBDU3FjJjYF8Zldqz5cnaI1vYx81vkb1fe4csvRp4sDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/a30Vf+SagCwyLK/5U9Nmrh9Uh1r/ystun2GMTX+zes=;
	b=W6G9/9AUNSw6YxbdwHNjR29maDDbziO3aLTTP64r2kbu/6So4TngT+svTZPhrl+2t8cU
	 ud1k8pLkxS/sW+ISzZPdwFh7bfZ+oe8W9JIVubTMlIMieSaEHym8R8vWdu/jLryutHfe+
	 0ePBIDDoyrfHfnnJwDrhVEBfBWvo0QKubJqE74+DY6TM7sfiPHUBjO63PsaTg3+sw34uQ
	 vSaUFYSPIn0FVNlOBFAzg0PAHH5md+95FVsR3FyXVTIbl+ZLf3rENkFi+bSzUP7gYvSp0
	 jxSx3WcEfGlxP3LYj6IUp4PDXdMiG5wb6uCw6QD0kUy2kQ21TJPrTYLrOqZdDU9fStQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oifvYLSb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789C60722B5
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oifvYLSb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F471F00A16
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631985;
	bh=/a30Vf+SagCwyLK/5U9Nmrh9Uh1r/ystun2GMTX+zes=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oifvYLSbvsjuTECeZiuJ8lDUROtODICyLQZo76vHd6ujKD8mx5xV5r/N0Bu+wsUyT
	 HPsRsnY4LQn+6d+c1xqumk4ZLnqhi79+rn2/108RgQ62IMI+NXBld7rQ6fcAfhjpYb
	 AN9OuZnMB6YJOzcFIN6p79OSsSmeiRooNxpBVk6VSKacPZXRFxT8o+Dvq5Amy4usbP
	 IHspe1qKGHvT+9hdMnekpsx+TRM+hJ/wUek4M61xnQsw80VivOgK5fbienxFyoFZFO
	 tnHjlnpTHUraM5QMQSoSh4ysbjMGmgqip0wP3R0nsgILVSPGFV6BL8hM5LM1WoZY2a
	 cxnwinKQ83u1w==
Message-ID: <sashiko-outbox-193631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] Landlock: Enforce MAKE_REG for POSIX message
 queue creation
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102144708.920232-3-webprosto@gmail.com>
References: <20261102144708.920232-1-webprosto@gmail.com>
 <20261102144708.920232-3-webprosto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:06:25 +0000
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
- [High] landlock: incompatible hook_inode_create() signature omits mnt_idm=
ap
- [High] landlock: user-triggerable WARN_ON_ONCE() in hook_inode_create()
- [High] landlock: hook_inode_create() breaks VFS create on mounted mqueuefs
- [Low] landlock: unnamed parameter in hook_inode_create() breaks gnu11 bui=
ld
--

commit 8666d4a55fba496ff4bfd048b949b769a8d57ec6
Author: Oxana Kharitonova <webprosto@gmail.com>

Landlock: Enforce MAKE_REG for POSIX message queue creation

This commit adds an inode_create LSM hook in Landlock to enforce
LANDLOCK_ACCESS_FS_MAKE_REG when creating POSIX message queues before the
queue is created in the mqueue filesystem. It also documents the behavior a=
nd
adds selftests for POSIX message queue creation and opening.

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..d5dcb19d5eb19 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
[ ... ]
> @@ -1676,6 +1677,35 @@ static int hook_path_truncate(const struct path *c=
onst path)
>  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>  }
> =20
> +/*
> + * Unlike regular file creation, mq_open(2) calls vfs_mkobj() directly a=
nd
> + * therefore does not trigger the path_mknod hook.  Use the mqueuefs mou=
nt
> + * associated with the current IPC namespace to recover the parent path.
> + */
> +static int hook_inode_create(struct inode *const dir,
> +			     struct dentry *const dentry, const umode_t)

[Severity: High]
Does hook_inode_create() in security/landlock/fs.c have the wrong function
signature for the inode_create LSM hook?

In include/linux/lsm_hook_defs.h, inode_create is declared with four
parameters, starting with const struct mnt_idmap *idmap:

    LSM_HOOK(int, 0, inode_create, const struct mnt_idmap *idmap,
             struct inode *dir, struct dentry *dentry, umode_t mode)

Because hook_inode_create() omits the leading idmap parameter, registering =
it
via LSM_HOOK_INIT(inode_create, hook_inode_create) in landlock_hooks fails =
to
build with -Werror=3Dincompatible-pointer-types when CONFIG_SECURITY_LANDLO=
CK is
enabled (and would cause the mnt_idmap pointer to be passed as dir at
runtime).

[Severity: Low]
Also in hook_inode_create() in security/landlock/fs.c, the trailing
const umode_t parameter omits the parameter name.

Because the kernel builds with -std=3Dgnu11 and supports GCC 8.1 and later,
while unnamed parameters in function definitions are a C23 feature only
supported starting in GCC 11, won't this fail to compile on GCC 8 through 10
with a "parameter name omitted" error?

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

[Severity: High]
Can an unprivileged user trigger this WARN_ON_ONCE() in hook_inode_create()
(and bypass the check) by creating a file on a mounted mqueue filesystem fr=
om
another IPC namespace?

Although mq_open(2) calls vfs_mkobj(), mqueue_dir_inode_operations in
ipc/mqueue.c also defines .create =3D mqueue_create:

    static const struct inode_operations mqueue_dir_inode_operations =3D {
        .lookup =3D simple_lookup,
        .create =3D mqueue_create,
        .unlink =3D mqueue_unlink,
    };

This means VFS creation paths on a mounted mqueue filesystem also reach
security_inode_create() -> hook_inode_create():

    openat(O_CREAT) -> do_filp_open() -> path_openat() -> lookup_open()
      -> may_o_create() -> security_inode_create()

    mknodat(S_IFREG) -> filename_mknodat() -> vfs_create()
      -> security_inode_create()

If a process unshares into a new IPC namespace (for example via
unshare(CLONE_NEWUSER | CLONE_NEWIPC)) while retaining access to a mounted
mqueue filesystem from a previous IPC namespace (such as /dev/mqueue or an
open directory fd), dir->i_sb belongs to the mount's IPC namespace whereas
current->nsproxy->ipc_ns->mq_mnt->mnt_sb belongs to the new IPC namespace.
Calling open() with O_CREAT or mknod() with S_IFREG on that mount will then
cause mnt->mnt_sb !=3D dir->i_sb and fire WARN_ON_ONCE().

> +
> +	parent.mnt =3D mnt;
> +	parent.dentry =3D dentry->d_parent;
> +	return current_check_access_path(&parent, LANDLOCK_ACCESS_FS_MAKE_REG);
> +}

[Severity: High]
When a Landlock-restricted task creates a queue via open(O_CREAT) or
mknod(S_IFREG) on a mounted mqueue filesystem (such as /dev/mqueue), does
constructing parent with ipc_ns->mq_mnt in hook_inode_create() break rules
attached to ancestor directories like /dev or /?

During open(O_CREAT) or mknod(S_IFREG) on /dev/mqueue/q, the VFS first chec=
ks
security_path_mknod() with the real user mount path, which walks up across =
the
/dev/mqueue mountpoint to /dev and / via follow_up() in
is_access_to_paths_allowed():

    jump_up:
        if (walker_path.dentry =3D=3D walker_path.mnt->mnt_root) {
            if (follow_up(&walker_path)) {
                /* Ignores hidden mount points. */
                goto jump_up;
            } else {
                break;
            }
        }

However, may_o_create() and vfs_create() then call security_inode_create() =
->
hook_inode_create(), which replaces the mount with the internal kernel mount
ipc_ns->mq_mnt. Because ipc_ns->mq_mnt is unattached, follow_up() returns
false at mnt_root and stops the walk before reaching /dev or /, causing
current_check_access_path() to deny the creation with -EACCES unless a rule
was added directly on /dev/mqueue itself.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102144708.9202=
32-1-webprosto@gmail.com?part=3D2
