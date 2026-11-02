Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610395;
	b=aH0uiVYOKex0A36cjiJIJ6JWK2j3QcrmMRp5PsZBHfDslDFFoEcL/OA5qCCWo9lt3qri
	 1obtreGgSqgWW3xXgLPZHGJdWSmHpoL9pSin1+66Qp85JCLCl3RgGyAgJbsCj2ppHAqfG
	 CEE6Q4lCx//jjppTVURUh7nOP3vh1jT94Ld2ad584TIvjuzVyJbcivpOfVwHxOXR3Self
	 CX/GbbW/vcAJ2m0ns+cIqroaoQS0eE+hOVwp5IUhItN76O9Xkp8BJiZF3Rwd2IxngZqJo
	 vTxaJ4dEieaDp6v+D8Paqnmr3h10XsgYJglhbS6tkUaCTkxC9qtnXUbFlpSqabuKEOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y+y0UJ/VFbHvyvcpiEXZxEflf7CaEDVpg1HI1NsgPdM=;
	b=m4P2p+TxXuSzdoacL+Dr8q5ysls5GkzoR97XoK/g4tHczXWRfG3GXLGDXx1It3bUPZRT
	 QSDPttIem2NoFibOoNT+xuMYwPTROprxhUPKFhb0RRVD4AXhXjEyGC7A9SdaVfL/QVJvC
	 is0PoGPQeEevg30gVBNOWYHKz0DtEnROqqvqHhlhdmEVcPs6n/9Ma881P+UxDVmgdMf37
	 LLDAgxpnVLm0MFs4R1xByEf5l2f9NqcpIhFZcBsrsCtO+IJDvpQdorF5oRBaUVO8aVKEv
	 3C56Gw7pyE3r3swOrVw3tUBsvCLH1j6zhFZLfwqlQFGLMiDeo+1XJY8Mctdv6SNMqpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtFE1FWw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BB606A324
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtFE1FWw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F7D1F00919
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793610394;
	bh=Y+y0UJ/VFbHvyvcpiEXZxEflf7CaEDVpg1HI1NsgPdM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jtFE1FWwQXC9uWtYnSYzHT8Y2MZVplNdIKKkzxUR59KaOw4CJ7qpwABjZVSoCH2vA
	 KCX5rBF/2gf2U8nBfHscJPyTEMxaq6LCikw49ocKZKKfkmFQa7b49hRzTrHQDkPxAK
	 iHNmgIoUwKyF4BRkDigECuTf5cxOC0tCvVgLdpVea3r2nGsuTjFCaIqiSNQGkuP752
	 KOJxhaBvWw1IcbXAqrPXtlr/RnrJWnYyc0m+1jdukqFVoldwoPtySdp5Pl609GH6mV
	 GiJHkAS0RBn77moxFKmDZoh5pap7wJHWiH20bJgqzQn/88XC5t9EPcnIkaztdVxr8A
	 swABx2yq1y3nw==
Message-ID: <sashiko-outbox-193154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] smack: preserve low-integrity labels across file
 copy via whitelist
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <E15125BD8A613CBE+20261102083948.205176-1-tangpengke@yhkylin.cn>
References: <E15125BD8A613CBE+20261102083948.205176-1-tangpengke@yhkylin.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 09:06:33 +0000
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
- [Critical] smack: UAF and NULL deref in smack_file_free_security() on fil=
e release
- [High] smack: missing MAY_WRITE check and O_RDWR handling in smack_file_o=
pen()
- [High] smack: OverlayFS copy-up state corruption via smk_copy_up task flag
- [High] smack: ineffective FMODE_EXEC check in smack_file_open() corrupts =
smk_preserve on exec
- [Medium] smack: unlocked write to isp->smk_inode in smk_relabel_on_releas=
e()
- [Medium] smack: flawed source file tracking via smk_preserve_inode on fil=
e free
- [Medium] smack: smk_tskacc() =3D=3D 0 check in smack_inode_init_security(=
) and smack_file_open() breaks bringup/unconfined mode
- [Medium] smack: broken length limit and label parsing in smk_write_preser=
ve_wl()
- [Medium] smack: smk_preserve is not cleared on label transition in do_set=
attr()
--

commit 1679e7f1a74f034307cf0eb6fcf662b9a39ad174
Author: Tang Pengke <tangpengke@yhkylin.cn>

smack: preserve low-integrity labels across file copy via whitelist

This commit introduces a whitelist mechanism under
CONFIG_SECURITY_SMACK_COPYWHITELIST that records a whitelisted Smack label =
on
read-only file opens and applies it to the next file created or overwritten
with O_TRUNC by the same task. The whitelist is managed via
/smack/preserve-whitelist.

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7fc..ff3d0b2f76332 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -953,6 +953,23 @@ static int smack_bprm_creds_for_exec(struct linux_bi=
nprm *bprm)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +/**
> + * smack_bprm_committing_creds - exec is about to commit the new creds
> + * @bprm: the exec information
> + *
> + * Every failure path has been passed at this point, so a pending copy
> + * record is stale.  Clearing it here rather than in the earlier
> + * bprm_creds_for_exec hook matters: that hook also runs for
> + * AT_EXECVE_CHECK and for execs that fail afterwards, and clearing there
> + * would drop the record even though no exec happened.
> + */
> +static void smack_bprm_committing_creds(const struct linux_binprm *bprm)
> +{
> +	smack_task(current)->smk_preserve =3D NULL;
> +}
> +#endif

[Severity: Medium]
While smack_bprm_committing_creds() clears smk_preserve on exec, what happe=
ns
when a task changes its active Smack label without exec via do_setattr() in
security/smack/smack_lsm.c (through smack_setprocattr() on
/proc/self/attr/current or smack_setselfattr())?

Because smk_preserve lives in the per-task blob rather than struct cred,
do_setattr() updates tsp->smk_task and calls commit_creds(new) while leaving
smack_task(current)->smk_preserve and smk_preserve_inode intact across the
domain transition.

If a task running with label L1 opens a whitelisted file W with O_RDONLY
(passing the MAY_READ check for L1) and then transitions to label L2 via
do_setattr() (including unprivileged transitions permitted by
/smack/relabel-self), a subsequent file creation in
smack_inode_init_security() will only check MAY_WRITE for L2 without
verifying that L2 had MAY_READ on W. Similarly, a subsequent O_WRONLY |
O_TRUNC open in smack_file_open() will compare tgt =3D=3D smk_of_task(tsp) =
against
the new label L2 and relabel an L2-owned file with the leftover preserve
record from L1.

Should do_setattr() also clear smk_preserve and smk_preserve_inode (and
should smack_bprm_committing_creds() clear smk_preserve_inode and smk_copy_=
up
as well)?

[ ... ]

> @@ -1075,6 +1128,33 @@ static int smack_inode_init_security(struct inode =
*inode, struct inode *dir,
>  		}
>  	}
> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	/*
> +	 * If a whitelisted label was recorded on file open, inherit it so
> +	 * the new file keeps the source's (low-integrity) label across the
> +	 * copy.  Two cases take precedence, and the record is one-shot so
> +	 * it is dropped either way:
> +	 *
> +	 *  - a copy-up, which must keep the lower label untouched;
> +	 *  - a transmutation, otherwise the record would leak into a later
> +	 *    create in a non-transmutable directory.
> +	 *
> +	 * The record is only inherited when the task may also write the
> +	 * label.  A task that can read skp but not write it must not be
> +	 * able to mint a file carrying skp -- that would be a write into a
> +	 * domain the policy keeps it out of.
> +	 */
> +	if (!copy_up) {
> +		struct smack_known *skp =3D smack_task(current)->smk_preserve;
> +
> +		if (skp !=3D NULL && !transmutes &&
> +		    smk_tskacc(tsp, skp, MAY_WRITE, NULL) =3D=3D 0)
> +			issp->smk_inode =3D skp;
> +		smack_task(current)->smk_preserve =3D NULL;
> +		smack_task(current)->smk_preserve_inode =3D NULL;
> +	}
> +#endif

[Severity: Medium]
Does checking smk_tskacc(tsp, skp, MAY_WRITE, NULL) =3D=3D 0 here in
smack_inode_init_security() (and in the overwrite check in smack_file_open(=
))
break label preservation when CONFIG_SECURITY_SMACK_BRINGUP is enabled?

In security/smack/smack_access.c, smk_access() and smk_tskacc() return
positive values (SMACK_BRINGUP_ALLOW, SMACK_UNCONFINED_SUBJECT, or
SMACK_UNCONFINED_OBJECT) when access is granted via a bringup rule or an
unconfined label, which other hooks normalize to 0 via the smk_bu_* helpers.

When MAY_WRITE is permitted via bringup or unconfined mode, VFS permission
checks succeed, but smk_tskacc(..., MAY_WRITE, NULL) =3D=3D 0 evaluates to =
false
and drops smk_preserve without applying the label. Should these checks test
>=3D 0 or pass the result through a bringup helper?

[ ... ]

> @@ -2077,10 +2157,160 @@ static int smack_file_open(struct file *file)
>  	smk_ad_setfield_u_fs_path(&ad, file->f_path);
>  	rc =3D smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
>  	rc =3D smk_bu_credfile(file->f_cred, file, MAY_READ, rc);
> +	if (rc)
> +		return rc;
> +
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	struct smack_task *stp =3D smack_task(current);
> +

[ ... ]

> +	if (!(file->f_mode & (FMODE_CREATED | FMODE_EXEC)) &&
> +	    !list_empty(&smk_preserve_wl) &&
> +	    (file->f_flags & O_ACCMODE) =3D=3D O_RDONLY &&
> +	    S_ISREG(inode->i_mode)) {
> +		struct smack_known *skp =3D smk_of_inode(inode);
> +
> +		if (smk_preserve_allowed(skp)) {
> +			stp->smk_preserve =3D skp;
> +			stp->smk_preserve_inode =3D inode;
> +		}
> +	}

[Severity: High]
As reported by Sashiko on v3 [1], does testing file->f_mode & FMODE_EXEC in
smack_file_open() actually filter out exec opens?

In fs/exec.c, do_open_execat() sets open_flag =3D O_LARGEFILE | O_RDONLY |
__FMODE_EXEC. However, init_file() initializes f->f_mode using
OPEN_FMODE(flags), which masks with O_ACCMODE (0x3) and strips FMODE_EXEC:

include/linux/fs.h:
    #define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
                                                (flag & __FMODE_NONOTIFY)))

Because file->f_mode & FMODE_EXEC is always 0, opening a whitelisted regular
file via do_open_execat() or open_exec() still sets stp->smk_preserve and
stp->smk_preserve_inode. If a task has an open whitelisted file and invokes
execveat() with AT_EXECVE_CHECK or a failing execve() on a whitelisted file,
do_open_execat() overwrites stp->smk_preserve_inode and then closes the
temporary exec file, causing smack_file_free_security() to clear both
stp->smk_preserve and stp->smk_preserve_inode while the original source file
remains open.

Should this check test file->f_flags & __FMODE_EXEC instead (similar to
AppArmor, Landlock, and TOMOYO)?

> +
> +	/*
> +	 * An overwrite skips inode_init_security(), so hand the record to
> +	 * the file and apply it on release.  O_TRUNC is still set here:
> +	 * do_dentry_open() prunes it only after security_file_open(), and
> +	 * handle_truncate() runs later still.  That is why the
> +	 * file_truncate hook cannot serve instead -- by then the flag is
> +	 * gone and ftruncate(2) is indistinguishable.
> +	 *
> +	 * Only a file carrying the task's own label, or a preservable one,
> +	 * is relabelled; a trusted file keeps its label.
> +	 */
> +	if (stp->smk_preserve !=3D NULL &&
> +	    !(file->f_mode & FMODE_CREATED) &&
> +	    (file->f_flags & O_ACCMODE) =3D=3D O_WRONLY &&
> +	    (file->f_flags & O_TRUNC) &&
> +	    S_ISREG(inode->i_mode)) {
> +		struct smack_known *tgt =3D smk_of_inode(inode);
> +
> +		if ((tgt =3D=3D smk_of_task(tsp) || smk_preserve_allowed(tgt)) &&
> +		    smk_tskacc(tsp, tgt, MAY_WRITE, NULL) =3D=3D 0)
> +			*smack_file_overwrite(file) =3D stp->smk_preserve;
> +		stp->smk_preserve =3D NULL;
> +		stp->smk_preserve_inode =3D NULL;
> +	}
> +#endif
> =20
>  	return rc;
>  }

[Severity: High]
As reported by Sashiko on v3 [2], doesn't the overwrite path in
smack_file_open() check MAY_WRITE against the target label tgt instead of t=
he
preserved label stp->smk_preserve, and miss overwrites opened with O_RDWR |
O_TRUNC?

In smack_inode_init_security(), inheriting skp =3D stp->smk_preserve requir=
es
MAY_WRITE on skp so a task with only MAY_READ on skp cannot mint a file in
that domain. Here in smack_file_open(), smk_tskacc(tsp, tgt, MAY_WRITE, NUL=
L)
checks MAY_WRITE on the target file's existing label tgt (which is trivially
allowed when tgt =3D=3D smk_of_task(tsp)) and never checks MAY_WRITE on
stp->smk_preserve. A task with MAY_READ but not MAY_WRITE on a whitelisted
label skp can open a file carrying skp with O_RDONLY, then open its own file
with O_WRONLY | O_TRUNC, write arbitrary content, and close it to relabel t=
he
file to skp via __vfs_setxattr_noperm().

In addition, checking (file->f_flags & O_ACCMODE) =3D=3D O_WRONLY misses ex=
isting
files overwritten with O_RDWR | O_TRUNC, leaving the overwritten target file
with its old label and leaving stp->smk_preserve armed for a later unrelated
create.

> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +/**
> + * smk_relabel_on_release - give a file the label of what was copied int=
o it
> + * @file: the file being released
> + * @skp: label to apply
> + *
> + * Write the xattr before adopting the label in memory, so a failed write
> + * leaves the inode matching the disk.
> + *
> + * __vfs_setxattr_noperm() skips security_inode_setxattr() on purpose:
> + * vfs_setxattr() would reach smack_inode_setxattr() and demand
> + * CAP_MAC_ADMIN, while the label was already vetted in smack_file_open()
> + * against a narrower rule.
> + */
> +static void smk_relabel_on_release(struct file *file, struct smack_known=
 *skp)
> +{
> +	struct dentry *dentry =3D file->f_path.dentry;
> +	struct inode *inode =3D d_inode(dentry);
> +	struct inode_smack *isp =3D smack_inode(inode);
> +	int rc;
> +
> +	if (isp->smk_inode =3D=3D skp)
> +		return;
> +
> +	/*
> +	 * __vfs_setxattr_noperm() requires the inode lock: filesystems such
> +	 * as UBIFS assert inode_is_locked() in their xattr_set handler.
> +	 * __fput() runs from task_work, so taking the lock here is safe.
> +	 */
> +	inode_lock(inode);
> +	rc =3D __vfs_setxattr_noperm(file_mnt_idmap(file), dentry,
> +				   XATTR_NAME_SMACK,
> +				   skp->smk_known, strlen(skp->smk_known), 0);
> +	inode_unlock(inode);
> +
> +	if (rc =3D=3D 0)
> +		isp->smk_inode =3D skp;
> +}
> +#endif

[Severity: Medium]
In smk_relabel_on_release(), is it safe to assign isp->smk_inode =3D skp af=
ter
calling inode_unlock(inode)?

Inside __vfs_setxattr_noperm(), security_inode_post_setxattr() ->
smack_inode_post_setxattr() (or security_inode_setsecurity() ->
smack_inode_setsecurity()) already updates isp->smk_inode while holding
inode_lock(inode). Writing isp->smk_inode =3D skp again after inode_unlock(=
inode)
races with any concurrent setxattr() or removexattr() that acquires the ino=
de
lock right after it is dropped, potentially leaving isp->smk_inode out of
sync with the on-disk xattr.

> +
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +/**
> + * smack_file_free_security - finish a copy, drop stale records
> + * @file: the file being freed
> + *
> + * Two records can be outstanding:
> + *
> + *  - the overwrite label, kept in the file blob.  Its contents are
> + *    complete and the inode lock is gone, so this is the first safe
> + *    point to write it back;
> + *  - a source record, kept in the task blob, whose source is released
> + *    before any create consumed it.  It is stale; dropping it keeps an
> + *    unrelated later create from inheriting a label it never read.
> + *
> + * The task blob lookup uses current.  fput() normally defers to
> + * task_work on the closing task, which is correct; should it fall back
> + * to ____fput() from a workqueue the lookup misses and the stale record
> + * survives until the next open of a whitelisted file replaces it.  The
> + * overwrite record is unaffected because it lives in the file blob.
> + */
> +static void smack_file_free_security(struct file *file)
> +{
> +	struct inode *inode =3D file_inode(file);
> +	struct smack_task *stp =3D smack_task(current);
> +	struct smack_known *skp =3D *smack_file_overwrite(file);
> +
> +	if (skp !=3D NULL) {
> +		*smack_file_overwrite(file) =3D NULL;
> +		smk_relabel_on_release(file, skp);
> +	}
> +
> +	if (stp->smk_preserve_inode =3D=3D inode) {
> +		stp->smk_preserve =3D NULL;
> +		stp->smk_preserve_inode =3D NULL;
> +	}
> +}
> +#endif

[Severity: Critical]
Can running smk_relabel_on_release() from smack_file_free_security() (via t=
he
file_free_security hook) trigger a NULL pointer dereference or use-after-fr=
ee?

First, in fs/file_table.c:__fput(), the file's write access, dentry
reference, and mount reference are all dropped before file_free() calls
security_file_free() -> smack_file_free_security():

fs/file_table.c:__fput() {
    ...
    put_file_access(file);
    dput(dentry);
    if (unlikely(mode & FMODE_NEED_UNMOUNT))
        dissolve_on_fput(mnt);
    else
        mntput(mnt);
out:
    file_free(file);
}

If the overwritten file was unlinked or renamed over while open, dput(dentr=
y)
drops the last reference to the dentry, clears dentry->d_inode to NULL, cal=
ls
iput(), and frees the dentry before smack_file_free_security() runs.
smk_relabel_on_release() then accesses the freed dentry/mnt and dereferences
d_inode(dentry) =3D=3D NULL. Even when the dentry stays cached, calling
__vfs_setxattr_noperm() after put_file_access() and mntput() performs a
filesystem xattr write after mnt_want_write() protection has already been
released.

Second, in fs/open.c:do_dentry_open(), security_file_open(f) runs before
fsnotify_open_perm_and_set_mode(), break_lease(), and f->f_op->open(). If
smack_file_open() sets *smack_file_overwrite(file) =3D stp->smk_preserve an=
d a
later step in do_dentry_open() fails, the cleanup_all / cleanup_file path
clears f->__f_path.dentry =3D NULL and f->f_inode =3D NULL:

fs/open.c:do_dentry_open() {
    ...
cleanup_file:
    path_put(&f->f_path);
    f->__f_path.mnt =3D NULL;
    f->__f_path.dentry =3D NULL;
    f->f_inode =3D NULL;
    return error;
}

When the caller then frees f via fput_close() -> file_free() ->
security_file_free(), smk_relabel_on_release() reads dentry =3D
file->f_path.dentry (NULL) and crashes at d_inode(dentry). And if do_open()
fails after vfs_open() (for example in handle_truncate()), fput_close() will
relabel the untouched file on disk even though the open failed.

Third, in fs/file_table.c:init_file(), security_file_alloc(f) runs before
f->f_inode =3D NULL is initialized; if another stacked LSM fails in
file_alloc_security, security_file_alloc() calls security_file_free(f) ->
smack_file_free_security(f), which reads uninitialized slab memory via
file_inode(file).

[Severity: Medium]
Also in smack_file_free_security(), doesn't clearing stp->smk_preserve when
stp->smk_preserve_inode =3D=3D inode break copy programs that close the sou=
rce
file before creating the destination file?

When a task calls close(src_fd), fput_close() schedules ____fput via
task_work_add(..., TWA_RESUME), which runs before the close() syscall retur=
ns
to userspace. A process that opens a whitelisted file O_RDONLY, reads its
contents into a buffer, closes src_fd, and then opens the destination file
with O_CREAT | O_WRONLY will have stp->smk_preserve cleared on close(src_fd)
before the destination file is created.

Similarly, if a task opens the same whitelisted inode twice (for example, o=
ne
fd to inspect headers and a second fd to copy) and closes the first fd while
the second remains open, freeing the first struct file matches
stp->smk_preserve_inode =3D=3D inode and clears stp->smk_preserve. Converse=
ly, if
the struct file is duplicated across fork() or dup() and another task drops
the final file reference, stp->smk_preserve_inode is left dangling on the
original task.

[ ... ]

> @@ -5014,6 +5244,15 @@ static int smack_inode_copy_up(struct dentry *dent=
ry, struct cred **new)
>  	isp =3D smack_inode(d_inode(dentry));
>  	skp =3D isp->smk_inode;
>  	tsp->smk_task =3D skp;
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	/*
> +	 * The copy-up creates upper inodes through the normal create
> +	 * path.  Tell smack_inode_init_security() to leave those alone:
> +	 * they must keep the lower label, and a pending copy record
> +	 * would otherwise be consumed by an internal overlayfs create.
> +	 */
> +	smack_task(current)->smk_copy_up =3D true;
> +#endif
>  	*new =3D new_creds;
>  	return 0;
>  }

[Severity: High]
As reported by Sashiko on v3 [3], can tracking OverlayFS copy-up with a
one-shot smk_copy_up boolean in smack_task(current) still corrupt task state
and inode labels?

1. In ovl_copy_up_workdir() and ovl_copy_up_tmpfile(),
ovl_prepare_copy_up_creds() calls security_inode_copy_up() ->
smack_inode_copy_up(), setting smack_task(current)->smk_copy_up =3D true. I=
f a
subsequent step fails before security_inode_init_security() is reached (for
example in another LSM's inode_copy_up hook, ovl_start_creating_temp(),
may_create_dentry(), security_inode_create(), or inode_permission() in
vfs_tmpfile()), smack_inode_init_security() never runs to consume
smk_copy_up. The temporary copy-up creds are reverted, but smk_copy_up
remains true on current, causing the task's next unrelated file or directory
creation to skip both transmutation and smk_preserve handling.

2. When copying up a directory with OverlayFS index=3Don in
ovl_copy_up_workdir(), ovl_create_temp() creates the upper directory (which
consumes smk_copy_up =3D false in smack_copy_up_begin()) and then
ovl_create_index() calls ovl_create_temp() a second time to create the index
entry with smk_copy_up =3D=3D false, consuming current's pending smk_preser=
ve on
the internal index inode. Internal workdir creations that do not call
security_inode_copy_up() (such as ovl_whiteout() and ovl_clear_empty()) also
enter smack_inode_init_security() with smk_copy_up =3D=3D false.

3. In smack_file_open(), the !(file->f_mode & (FMODE_CREATED | FMODE_EXEC))
check does not exclude FMODE_BACKING or internal OverlayFS O_RDONLY opens.
During regular file copy-up, ovl_copy_up_file() and ovl_sync_file() open and
close the lower/upper files with O_RDONLY, which runs smack_file_open() and
smack_file_free_security() and clobbers or clears current's pending
smk_preserve record. Furthermore, creating a file on OverlayFS with O_RDONLY
| O_CREAT consumes smk_preserve in smack_inode_init_security(), and then
ovl_open_realfile() opens the upper backing file via backing_file_open()
(which sets FMODE_BACKING without FMODE_CREATED), re-arming smk_preserve in
smack_file_open().

[ ... ]

> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea99..a726957c434d3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c

[ ... ]

> +static ssize_t smk_write_preserve_wl(struct file *file, const char __use=
r *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	struct smack_known *skp;
> +	char *data, *label;
> +	bool on =3D true;
> +	int rc;
> +
> +	if (!smack_privileged(CAP_MAC_ADMIN))
> +		return -EPERM;
> +
> +	if (*ppos !=3D 0)
> +		return -EINVAL;
> +
> +	if (count =3D=3D 0 || count > SMK_LONGLABEL)
> +		return -EINVAL;
> +
> +	data =3D memdup_user_nul(buf, count);
> +	if (IS_ERR(data))
> +		return PTR_ERR(data);
> +
> +	label =3D strim(data);
> +	if (!label[0]) {
> +		kfree(data);
> +		return -EINVAL;
> +	}
> +
> +	/* A leading '-' removes the label (same convention as revoke-subject).=
 */
> +	if (label[0] =3D=3D '-') {
> +		on =3D false;
> +		label =3D strim(label + 1);
> +		if (!label[0]) {
> +			kfree(data);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * Import the label when adding.  Boot-time policy may name a label
> +	 * that no inode, rule or mount has referenced yet, in which case it
> +	 * is not in smack_known_hash.  Removal only needs the existing entry.
> +	 */
> +	if (on) {
> +		skp =3D smk_import_entry(label, 0);
> +		if (IS_ERR(skp)) {
> +			rc =3D PTR_ERR(skp);
> +			kfree(data);
> +			return rc;
> +		}
> +	} else {
> +		skp =3D smk_find_entry(label);
> +		if (!skp) {
> +			kfree(data);
> +			return -ENOENT;
> +		}
> +	}
> +
> +	rc =3D smk_preserve_set(skp, on);
> +	kfree(data);
> +	return rc ? rc : count;
> +}

[Severity: Medium]
In smk_write_preserve_wl(), does rejecting count > SMK_LONGLABEL before
stripping the '-' prefix prevent removing a maximum-length (255-character)
Smack label when written with a trailing newline?

Adding a 255-character label with a newline uses 256 bytes (SMK_LONGLABEL),
which succeeds, but removing that same label with a leading '-' and trailing
newline requires 257 bytes (SMK_LONGLABEL + 1) and fails with -EINVAL.

Also, when on is true, smk_import_entry(label, 0) calls smk_parse_label_len=
(),
which stops at the first whitespace or invalid character (such as '/', '"',
'\\', or '\'') and returns the prefix length rather than failing. Without
checking that the parsed label length matches strlen(label) (as do_setattr()
does in security/smack/smack_lsm.c), won't writing a string containing an
invalid character or multiple space/newline-separated labels silently
import and whitelist only the truncated prefix while returning count?

[1] https://lore.kernel.org/r/684C81A1C8289709+20261028161521.925644-1-tang=
pengke@yhkylin.cn
[2] https://lore.kernel.org/r/684C81A1C8289709+20261028161521.925644-1-tang=
pengke@yhkylin.cn
[3] https://lore.kernel.org/r/684C81A1C8289709+20261028161521.925644-1-tang=
pengke@yhkylin.cn

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/E15125BD8A613CBE+20=
261102083948.205176-1-tangpengke@yhkylin.cn?part=3D1
