Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205459;
	b=b0ivgdmzdLVacVMYmpdhlhjVbaj346cekmdj5qJGeDo86V9y5Sn2loZRTrH95qxUMuQG
	 OrNwEeaTd0SJWYQGzax3Va1SoG6NopqnPFJNH1xe/FBlSPvCh5FaaynF+F1WMlc68ijDD
	 tHLo+DGuB3U2DollK9yzyhRC2E/kpr7O7PtcIp3TtiZeF825ul9jGxxHAp2QPudn6GePR
	 Cm5YMC0BZlypPpG4FRVD9QcRDaPkbu4ob0H1T+RnvkSAVMD4uGiO3BUVRB4Ch1W0yIbZr
	 zbpZLA05BdkbEqtDt5a4ZKvArQ3nmJh9m7ejtgUUFryS2xKIeYEIK1TYZ8HV6KRwNxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XeISLuoTPT0sWhoX53jc7PjO+0oIRPcFP42+p3mHYoo=;
	b=n0bRbcMJE9O03GOXoDLlpZV8PZ1+B9JxjAlzT0Z64j6pLC+tXD2ZTkoKndcCkh4zrM+j
	 nnwaS3wvs31pm4Ro4e6yxCe4bPLOFAcCukHUbJ3lnsDEqP3U5b4qDObcyDWQOynPNm0Zt
	 w136fR1AXroH4ezRK1QEkAuT773VlAnALSeTblkbfTpqbR6oai5wasRWr8YTBwr8Jnxj5
	 Qsu+bj5yJmRyzT9vS0MpriK1UIAnqJdy/DK2nvJlYu4sbvnGvkNc+wNFn/lCVItM0Qlc1
	 iNQG31CJbKH8TiOMx2YpgJinWFUiePNPn3xgHZmzx2xJUf2nZY5soKU+GmZYzursO3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC7GQMxa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0366606A326
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC7GQMxa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778EB1F031E0
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205458;
	bh=XeISLuoTPT0sWhoX53jc7PjO+0oIRPcFP42+p3mHYoo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CC7GQMxasdvQcaspRqTUqO/lVinv5sGpLpIBAwcHFehX4l2DjcFEP1OkY+LwjOqnv
	 +hPdH78YfC4Tq8tJZJfUjU3Los2a2Bq3HUWygOuEiXDscc+mNL3hz2ae/ACaybEQvG
	 edOs8PSVgR5nVcDXnqG0q6+8QVsKoIBJcnf+r0oqNYW67i1Df0E3Yilfps73SyuLlC
	 jHnusx97FT/N5jzCqlXByZXJXuiGjsUz2JnkCPXSBywez4X10U0UsnTHGsaM6+OEfS
	 FDe7b5h+dk1SEeKjSrFT+ePb804q7gXDALxvWeJjx0CnAs8XVKQCdmHwwgFK/BOfi6
	 mU13PuHkb6ZbQ==
Message-ID: <sashiko-outbox-188170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] smack: preserve low-integrity labels across file
 copy via whitelist
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <684C81A1C8289709+20261028161521.925644-1-tangpengke@yhkylin.cn>
References: <684C81A1C8289709+20261028161521.925644-1-tangpengke@yhkylin.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:37:38 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] smack: broken exec handling for smk_preserve in smack_bprm_creds_f=
or_exec()
- [High] smack: missing MAY_WRITE check in smack_inode_init_security() for =
smk_preserve
- [High] smack: smk_preserve corrupts inode labels across OverlayFS copy-up
- [Medium] smack: silent allocation failure in smk_preserve_set()
- [Medium] smack: smack_file_open() re-records smk_preserve on O_RDONLY | O=
_CREAT
- [Medium] smack: unimported label rejection and unbounded write in smk_wri=
te_preserve_wl()
--

commit d4423a161be1eb02cab93ddd7185fcd574c8aaf2
Author: Tang Pengke <tangpengke@yhkylin.cn>

smack: preserve low-integrity labels across file copy via whitelist

This commit introduces a configurable whitelist (/smack/preserve-whitelist)=
 of
low-integrity Smack labels that are recorded in a per-task LSM blob when a
process opens a whitelisted regular file read-only, so that the next inode
created by that thread inherits the preserved label instead of the process
label.

> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index fb85356266e53..4982127ce985f 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -53,6 +53,83 @@ static u32 smack_next_secid =3D 10;

[ ... ]

> +void smk_preserve_set(struct smack_known *skp, bool on)
> +{
> +	struct smk_preserve_wl *e, *new =3D NULL;
> +
> +	if (on) {
> +		new =3D kzalloc_obj(*new, GFP_KERNEL);
> +		if (!new)
> +			return;
> +		new->skp =3D skp;
> +	}

[Severity: Medium]
When kzalloc_obj(*new, GFP_KERNEL) fails in smk_preserve_set(), this returns
early without an error code, and smk_write_preserve_wl() in
security/smack/smackfs.c then unconditionally returns count to userspace:

    smk_preserve_set(skp, on);
    kfree(data);
    return count;

Should smk_preserve_set() return an int so that smk_write_preserve_wl() can
propagate -ENOMEM to userspace when the whitelist allocation fails?

[ ... ]

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7fc..094d26c943b52 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -915,6 +915,11 @@ static int smack_bprm_creds_for_exec(struct linux_bi=
nprm *bprm)
>  	struct superblock_smack *sbsp;
>  	int rc;
> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	/* a new program starts with a clean copy record */
> +	smack_task(current)->smk_preserve =3D NULL;
> +#endif

[Severity: High]
Can clearing smack_task(current)->smk_preserve in smack_bprm_creds_for_exec=
()
allow a task to drop its pending preserve record without actually executing=
 a
new program, or leave smk_preserve armed across exec?

In fs/exec.c:bprm_execve(), security_bprm_creds_for_exec() runs before the
bprm->is_check early return and before exec_binprm():

    retval =3D security_bprm_creds_for_exec(bprm);
    if (retval || bprm->is_check)
        goto out;

    retval =3D exec_binprm(bprm);

If a task that has opened a whitelisted low-integrity file calls
execveat(..., AT_EXECVE_CHECK) or invokes execve() on a target that fails in
smack_bprm_creds_for_exec() or exec_binprm(), smk_preserve is cleared on
current even though no exec took place, allowing subsequent file creations =
by
that task to use its trusted process label.

In addition, fs/exec.c:do_open_execat() and open_exec() open the executable
and any interpreter with O_LARGEFILE | O_RDONLY | __FMODE_EXEC. Because
smack_file_open() checks (file->f_flags & O_ACCMODE) =3D=3D O_RDONLY without
excluding __FMODE_EXEC (or file->f_mode & FMODE_EXEC):

1. If do_open_execat() opens a whitelisted file and then fails before
   bprm_execve() (for example, at path_noexec(&file->f_path) on a noexec
   mount), smack_file_open() has already set smk_preserve on the calling ta=
sk.

2. If exec_binprm() opens a script interpreter via open_exec() after
   security_bprm_creds_for_exec() has already run, smack_file_open() will
   record smk_preserve for the newly executed program if the interpreter's
   label is on the whitelist.

Should smack_file_open() ignore FMODE_EXEC opens, and should smk_preserve be
cleared when the exec commits in a bprm_committing_creds or
bprm_committed_creds hook instead of smack_bprm_creds_for_exec()?

>  	isp =3D smack_inode(inode);
>  	if (isp->smk_task =3D=3D NULL || isp->smk_task =3D=3D bsp->smk_task)
>  		return 0;
> @@ -1075,6 +1080,26 @@ static int smack_inode_init_security(struct inode =
*inode, struct inode *dir,
>  		}
>  	}
> =20
> +#ifdef CONFIG_SECURITY_SMACK_COPYWHITELIST
> +	/*
> +	 * If a whitelisted label was recorded on file open, inherit it so
> +	 * the new file keeps the source's (low-integrity) label across the
> +	 * copy.  Transmutation takes precedence: when it applies the record
> +	 * is dropped, otherwise it would leak into a later create in a
> +	 * non-transmutable directory.
> +	 */
> +	if (trans_cred || (trans_rule && smk_inode_transmutable(dir))) {
> +		smack_task(current)->smk_preserve =3D NULL;
> +	} else {
> +		struct smack_known *skp =3D smack_task(current)->smk_preserve;
> +
> +		if (skp !=3D NULL) {
> +			issp->smk_inode =3D skp;
> +			smack_task(current)->smk_preserve =3D NULL;
> +		}
> +	}
> +#endif

[Severity: High]
What happens here when the creating task has MAY_READ access to the
whitelisted label skp, but does not have MAY_WRITE access to skp?

In smack_file_open(), smk_preserve is recorded after checking only MAY_READ=
 on
the source inode. When the task then creates a new file via open(dst,
O_CREAT | O_WRONLY, mode) in a writable non-transmuting directory,
may_o_create() checks MAY_WRITE | MAY_EXEC on the parent directory, and
smack_inode_init_security() assigns issp->smk_inode =3D skp without checking
whether the task has MAY_WRITE access to skp.

Because FMODE_CREATED is set on the struct file, fs/namei.c:do_open() sets
acc_mode =3D 0 before may_open():

    if (file->f_mode & FMODE_CREATED) {
        /* Don't check for write permission, don't truncate */
        open_flag &=3D ~O_TRUNC;
        acc_mode =3D 0;
    }

may_open() then passes only MAY_OPEN to inode_permission(), which
smack_inode_permission() masks out, and smack_file_open() checks only
MAY_READ. Since Smack does not hook file_permission on write(), the task
receives a writable file descriptor and can write arbitrary content to an
inode labeled skp despite policy denying it write access to skp. Meanwhile,
follow-up operations that copy utilities perform on the newly created file
(such as fchmod(), fchown(), futimens(), setxattr(), rename(), or unlink())
check MAY_WRITE against issp->smk_inode and fail with -EACCES.

[Severity: High]
Also in smack_inode_init_security(), how does smk_preserve interact with
OverlayFS copy-up and credential overrides?

When a task with a pending smk_preserve creates a file in an OverlayFS
directory whose parent is still on a lower layer,
ovl_create_object() -> ovl_copy_up() -> ovl_copy_up_workdir() calls
security_inode_copy_up() -> smack_inode_copy_up() and installs copy_up_cred
via override_creds():

    isp =3D smack_inode(d_inode(dentry));
    skp =3D isp->smk_inode;
    tsp->smk_task =3D skp;
    *new =3D new_creds;

smack_inode_copy_up() leaves tsp->smk_transmuted as NULL, so when
ovl_create_temp() creates the upper directory, smack_inode_init_security()
sees trans_cred =3D=3D false, overwrites the copied-up upper directory's la=
bel
with smack_task(current)->smk_preserve, and clears smk_preserve =3D NULL.
Because smack_inode_copy_up_xattr() returns -ECANCELED for XATTR_NAME_SMACK,
the upper directory is permanently relabeled to the low-integrity label, and
when ovl_create_object() then creates the actual target file, smk_preserve =
has
already been consumed so the copied file receives the task's trusted label.

Similarly, if a task with a pending smk_preserve modifies an existing lower
file or directory on OverlayFS (for example via chmod(), truncate(), or
open(O_WRONLY)), the copy-up creation in ovl_copy_up_tmpfile() or
ovl_copy_up_workdir() consumes smk_preserve and relabels the copied-up inod=
e.
Furthermore, ovl_copy_up_file() opens the lower file internally via
ovl_path_open(..., O_LARGEFILE | O_RDONLY), which reaches smack_file_open()
and records smk_preserve on current even though the user only truncated or
opened the file for writing.

>  	if (rc =3D=3D 0)
>  		if (xattr_dupval(xattrs, xattr_count,
>  			    XATTR_SMACK_SUFFIX,
> @@ -2077,6 +2102,39 @@ static int smack_file_open(struct file *file)

[ ... ]

> +	if (!list_empty(&smk_preserve_wl) &&
> +	    (file->f_flags & O_ACCMODE) =3D=3D O_RDONLY &&
> +	    S_ISREG(inode->i_mode)) {
> +		struct smack_known *skp =3D smk_of_inode(inode);
> +
> +		if (smk_preserve_allowed(skp))
> +			smack_task(current)->smk_preserve =3D skp;
> +	}
> +#endif

[Severity: Medium]
If a task with a pending smk_preserve creates a new regular file using
open(path, O_RDONLY | O_CREAT, mode) (or open(path, O_CREAT | O_EXCL, mode),
since O_RDONLY is 0), lookup_open() sets FMODE_CREATED and invokes
smack_inode_init_security(), which labels the new inode with skp and clears
smack_task(current)->smk_preserve =3D NULL.

Later in that same open() syscall, do_open() -> vfs_open() -> do_dentry_ope=
n()
calls security_file_open() -> smack_file_open() on the newly created file.
Because (file->f_flags & O_ACCMODE) =3D=3D O_RDONLY is true and FMODE_CREAT=
ED is
not excluded here, won't smack_file_open() see the newly inherited skp on
inode and immediately set smack_task(current)->smk_preserve =3D skp again,
defeating the one-shot consumption?

> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea99..7a6dc3e2eb812 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c

[ ... ]

> @@ -2777,6 +2780,97 @@ static const struct file_operations smk_ptrace_ops=
 =3D {

[ ... ]

> +static ssize_t smk_write_preserve_wl(struct file *file, const char __use=
r *buf,
> +				     size_t count, loff_t *ppos)
> +{
> +	struct smack_known *skp;
> +	char *data, *label;
> +	bool on =3D true;
> +
> +	if (!smack_privileged(CAP_MAC_ADMIN))
> +		return -EPERM;
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
> +	skp =3D smk_find_entry(label);
> +	if (!skp) {
> +		kfree(data);
> +		return -ENOENT;
> +	}

[Severity: Medium]
When adding a label to /smack/preserve-whitelist (for example at boot befor=
e a
removable filesystem with smackfsdef=3D is mounted or before policy rules
referencing that label are loaded), smk_find_entry(label) returns NULL and
smk_write_preserve_wl() fails with -ENOENT if the label has not already been
imported into smack_known_hash.

Other smackfs label configuration writers such as smk_write_onlycap(),
smk_write_ambient(), smk_write_unconfined(), smk_write_syslog(), and
smk_write_relabel_self() check *ppos !=3D 0, bound count (to SMK_LONGLABEL /
PAGE_SIZE), and call smk_import_entry(label, 0) when adding a label so valid
labels are imported on demand. Should smk_write_preserve_wl() also bound co=
unt
and use smk_import_entry() when on is true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/684C81A1C8289709+20=
261028161521.925644-1-tangpengke@yhkylin.cn?part=3D1
