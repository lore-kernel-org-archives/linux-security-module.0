Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879603;
	b=E+K904+Tljjq6wDvh7zlQet2qQEqoFKkT9Chkg4Igy26zeuaJnKZBGgMvWO4PN5PHb9k
	 TJSzWXBWHm7B4lE1m4pBIXlzyERQjItcD53VC7kA+McTT1HyGA4XtWO67WXcnLCBR62Vt
	 WwNvEMTyoIvIFZyXG9wbltd1XUq7rmqxhcmFyOIe08qrCtRIFxLudkt7zN5B1+k5EBNOZ
	 qB8SXtlgmijjrltONZYYgGgGwObpHrjsMNsDAOl1JfKoiYA24HBDpvBJnof2tOnZoZI1x
	 EBJLNHDmcjrCBtfrqtvXOM32kyLsnIwsN9nw5m/8jUVJ6u1fOck74s6PCNetW44AGIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LKrseE+2KGcyPyJteMPo+jT68x2OFUPN+O+cpreY9Ak=;
	b=xbKfY4kg4Cc0SF6/bot4YFgLbdTbWHT1zt73hHdLUmOiKLbEfOb8ijZ0A6wYR2EJgI4g
	 nj85FvHR0jmgASzx+uuzZvN/MOO/1kas9fXm8iy68oRSQJIRg+c7lxTEm5luxAaBdkZdg
	 4WQZvXTBMDc02DrY05sZurFjmPV2/pM5x0gWKEKTNrGbqGPCsiOIHTBOURcU3T2wYPCFf
	 NnkgCB0byMgXKeByLlV6v1nWnggQqmTfaeAE8VniHKY1JT0VFIfmRyNWzPTi52UJtiZ2E
	 2t+aCiIKRZ2O9rXo9fLzr+Kb47NwAz7/S9NQHQd746xOPt4URmhBkFoZF5TEiP5tViA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQ62zilG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567F606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQ62zilG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B1C1F01825
	for <linux-security-module@vger.kernel.org>; Sat, 24 Oct 2026 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792879602;
	bh=LKrseE+2KGcyPyJteMPo+jT68x2OFUPN+O+cpreY9Ak=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iQ62zilGQ2QtVH3gAsZpc8qee50ALYZjJZw1pieIEVJwjRJCf/O1vzkzqOWdaqv+L
	 MBNaDkfO0EQGNp/WxOl9gwVkH2+0gRXhenxvfhPzF+6K4Qs/KHK4WCNp+rKYf9OjtP
	 v3I9DYDWUbeGEF8xNjYdoc+Awvm4Q+ebaNSpjBAplSSm4Nt28A9bYXo3Hvi8q/Hx0R
	 rlzKrOVPqucmDO3OmLiLt+YIx5ChpYw4siZbV4ahjROTuKMMg+mxWMPS2a4yj+hJHA
	 9jKUDRzYPwoi7VEIp8Q6ng43zfzp9U3DmVFIbPxkQr5GwtFDEC5c5uIfQ4yQLNUuAK
	 pc+x229KIXSGg==
Message-ID: <sashiko-outbox-183915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] landlock: Add access rights on created files
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261024-landlock-created-rights-v1-2-77c8db3f6bd2@gmail.com>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
 <20261024-landlock-created-rights-v1-2-77c8db3f6bd2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 22:06:42 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] landlock: use-after-free in landlock_unmask_created() during p=
ath walk
- [High] landlock: uninitialized layer_masks read in refer_created()
- [High] landlock: refer_created() mutates state and pins inodes before VFS=
 checks
- [High] landlock: hook_inode_init_security() pins I_NEW inodes without err=
or rollback
- [High] landlock: GFP_KERNEL_ACCOUNT allocation in hook_inode_init_securit=
y()
- [Medium] landlock: grant_created() miscomputes reparented access rights
- [Medium] landlock: missing hook_inode_init_security() calls and unlinked =
inode pinning
--

commit 5e3bc0f81c353fca29a705bd4d2b123bb4da9434
Author: Farid Zakaria <farid.m.zakaria@gmail.com>

landlock: Add access rights on created files

This commit adds the LANDLOCK_ADD_RULE_CREATED flag for
LANDLOCK_RULE_PATH_BENEATH rules on directories so that access rights are
granted on file hierarchies created directly in the directory by tasks in t=
he
domain (or nested domains), and bumps the Landlock ABI version to 13.

> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index 4c0b1f0e1db5d..f8dc771724e14 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c

[ ... ]

> @@ -198,6 +199,166 @@ bool landlock_unmask_layers(const struct landlock_d=
omain *const domain,

[ ... ]

> +bool landlock_unmask_created(const struct landlock_domain *const domain,
> +			     const struct landlock_object *const object,
> +			     struct layer_masks *masks)
> +{
> +	struct landlock_hierarchy *hierarchy =3D domain->hierarchy;
> +
> +	if (!masks)
> +		return true;
> +
> +	if (!READ_ONCE(object->created))
> +		return false;
> +
> +	for (size_t i =3D domain->num_layers; i > 0 && hierarchy;
> +	     i--, hierarchy =3D hierarchy->parent)
> +		masks->layers[i - 1].access &=3D ~get_created(hierarchy, object);
> +
> +	for (size_t i =3D 0; i < ARRAY_SIZE(masks->layers); i++) {
> +		if (masks->layers[i].access)
> +			return false;
> +	}
> +	return true;
> +}

[Severity: Critical]
Can this dereference of object->created in landlock_unmask_created() trigge=
r a
use-after-free or grant access to the wrong inode via slab pointer reuse?

During the sleepable path walks in is_access_to_paths_allowed() and
collect_domain_accesses() in security/landlock/fs.c, get_inode_id() fetches
the raw object pointer without holding rcu_read_lock() or taking a referenc=
e:

security/landlock/fs.c:get_inode_id() {
	...
	id->key.object =3D rcu_access_pointer(
		landlock_inode(d_backing_inode(dentry))->object);
	return !!id->key.object;
}

Previously, id.key.object was never dereferenced and was only compared
numerically against domain->rules.root_inode, which is immutable and pins i=
ts
objects for the lifetime of the domain.

With unmask_layers_created() passing id.key.object to
landlock_unmask_created(), if an inode visited during the path walk has a
landlock_object attached by another ruleset or domain that is concurrently
freed via landlock_put_object() -> kfree_rcu(object, rcu_free), the RCU gra=
ce
period can elapse while the path walk is running. Could READ_ONCE(object->c=
reated)
then read from freed slab memory?

Furthermore, because hierarchy->created is updated at runtime by
landlock_add_created(), if that freed landlock_object slab slot is realloca=
ted
for a newly created inode in this domain and inserted into hierarchy->creat=
ed,
would get_created(hierarchy, object) match the reused pointer address and
grant the created inode's rights to the unrelated inode?

> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 2ab67bcad1983..64a3447254337 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c

[ ... ]

> @@ -1359,8 +1381,130 @@ static int current_check_refer_path(struct dentry=
 *const old_dentry,

[ ... ]

> +static int grant_created(const struct landlock_domain *const domain,
> +			 const struct landlock_rule *const rule,
> +			 struct inode *const inode,
> +			 const struct layer_masks *const src_masks)
> +{
> +	struct landlock_object *object;
> +	int err =3D 0;
> +
> +	object =3D get_inode_object(inode);
> +	if (IS_ERR(object))
> +		return PTR_ERR(object);
> +
> +	for (size_t i =3D 0; i < rule->num_layers && !err; i++) {
> +		const struct landlock_layer *const layer =3D &rule->layers[i];
> +
> +		if (src_masks &&
> +		    (src_masks->layers[layer->level - 1].access & layer->access))
> +			continue;
> +
> +		err =3D landlock_add_created(domain, layer->level - 1, object,
> +					   layer->access);
> +	}
> +	landlock_put_object(object);
> +	return err;
> +}

[Severity: Medium]
When reparenting a file or directory via refer_created(), does grant_create=
d()
drop the entire layer whenever any single bit of layer->access was not gran=
ted
at the source?

In refer_created(), layer_masks (passed as src_masks) holds the access bits
from rule that were unfulfilled at old_path. Checking:

	if (src_masks &&
	    (src_masks->layers[layer->level - 1].access & layer->access))
		continue;

skips the entire layer whenever any bit in layer->access remains unfulfilled
at the source (for instance, when created_attr.allowed_access is set to
ruleset_attr.handled_access_fs as shown in the documentation, but the source
staging directory did not grant LANDLOCK_ACCESS_FS_MAKE_BLOCK or
LANDLOCK_ACCESS_FS_IOCTL_DEV), rather than granting the intersection of rig=
hts
that were already allowed at the source
(layer->access & ~src_masks->layers[layer->level - 1].access).

Also, when old_dentry is not a directory, refer_created() masks
access &=3D ACCESS_FILE before calling landlock_init_layer_masks(), leaving
non-ACCESS_FILE bits zeroed in src_masks, so grant_created() passes the
unmasked layer->access (including directory access rights) to
landlock_add_created(). Should this grant only the fulfilled subset of
applicable rights instead?

> +
> +/*
> + * Grants the access rights of @new_dir's LANDLOCK_ADD_RULE_CREATED rule=
 on
> + * the reparented @old_dentry, for the layers which already granted them=
 at
> + * its source.  This must only be called once the refer action is allowe=
d.
> + */
> +static int refer_created(struct dentry *const old_dentry,
> +			 const struct path *const new_dir)
> +{
> +	const struct landlock_cred_security *const subject =3D
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	/* The mount points are the same for old and new paths, cf. EXDEV. */
> +	const struct path old_path =3D {
> +		.mnt =3D new_dir->mnt,
> +		.dentry =3D old_dentry,
> +	};
> +	const struct landlock_rule *rule;
> +	struct layer_masks layer_masks;
> +	access_mask_t access =3D 0;
> +
> +	if (!subject ||
> +	    RB_EMPTY_ROOT(&subject->domain->rules.root_inode_created) ||
> +	    old_dentry->d_parent =3D=3D new_dir->dentry)
> +		return 0;
> +
> +	rule =3D get_created_rule(subject->domain,
> +				d_backing_inode(new_dir->dentry));
> +	if (!rule)
> +		return 0;
> +
> +	for (size_t i =3D 0; i < rule->num_layers; i++)
> +		access |=3D rule->layers[i].access;
> +
> +	/* Only compares the access rights which make sense for files. */
> +	if (!d_is_dir(old_dentry))
> +		access &=3D ACCESS_FILE;
> +
> +	access =3D landlock_init_layer_masks(subject->domain, access,
> +					   &layer_masks, LANDLOCK_KEY_INODE);
> +	is_access_to_paths_allowed(subject->domain, &old_path, access,
> +				   &layer_masks, NULL, NULL, 0, NULL, NULL,
> +				   NULL);
> +	return grant_created(subject->domain, rule,
> +			     d_backing_inode(old_dentry), &layer_masks);
> +}

[Severity: High]
Can refer_created() pass an uninitialized layer_masks struct on the stack to
grant_created()?

When old_dentry is a non-directory (!d_is_dir(old_dentry)), access is masked
with ACCESS_FILE. If the ruleset handles all ACCESS_FILE rights and the
LANDLOCK_ADD_RULE_CREATED rule on new_dir only grants directory rights (such
as LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_MAKE_REG), access becom=
es
0 after access &=3D ACCESS_FILE.

When access is 0, landlock_init_layer_masks() in security/landlock/domain.c
returns early without initializing layer_masks:

	if (!access_request)
		return 0;

and is_access_to_paths_allowed() in security/landlock/fs.c also returns ear=
ly
without writing to layer_masks:

	if (!access_request_parent1 && !access_request_parent2)
		return true;

Wouldn't grant_created() then read uninitialized stack memory from
src_masks->layers[layer->level - 1].access?

> +
> +/* Inode hooks */
> +
> +static int hook_inode_init_security(struct inode *const inode,
> +				    struct inode *const dir,
> +				    const struct qstr *const qstr,
> +				    struct xattr *const xattrs,
> +				    int *const xattr_count)
> +{
> +	const struct landlock_cred_security *const subject =3D
> +		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> +	const struct landlock_rule *rule;
> +	int err;
> +
> +	if (!subject || !dir ||
> +	    RB_EMPTY_ROOT(&subject->domain->rules.root_inode_created))
> +		return -EOPNOTSUPP;
> +
> +	rule =3D get_created_rule(subject->domain, dir);
> +	if (!rule)
> +		return -EOPNOTSUPP;
> +
> +	/* Landlock does not provide any xattr. */
> +	err =3D grant_created(subject->domain, rule, inode, NULL);
> +	return err ?: -EOPNOTSUPP;
> +}

[Severity: High]
What happens to the newly allocated I_NEW | I_CREATING inode if creation fa=
ils
after hook_inode_init_security() pins it in hierarchy->created?

In hook_inode_init_security(), grant_created() calls get_inode_object(inode)
(which calls ihold(inode), incrementing i_count from 1 to 2) and
landlock_add_created() (which holds a reference to object in
hierarchy->created until the domain hierarchy is freed).

If inode creation subsequently fails =E2=80=94 for example, in grant_create=
d() itself
when layer 0 succeeds and a subsequent layer fails with -ENOMEM, in a later
LSM hook or initxattrs() callback inside security_inode_init_security(), wh=
en
the filesystem fails to add the directory entry (e.g. -ENOSPC, -EDQUOT,
-EMLINK, -ENOMEM), or when vfs_tmpfile() later fails in may_open() or
hook_file_open() =E2=80=94 the filesystem's error path calls discard_new_in=
ode(),
iget_failed(), or iput():

fs/inode.c:discard_new_inode() {
	...
	inode_state_clear(inode, I_NEW);
	inode_wake_up_bit(inode, __I_NEW);
	spin_unlock(&inode->i_lock);
	iput(inode);
}

Because hierarchy->created still holds a reference to the inode, iput(inode)
only drops i_count from 2 to 1 instead of running iput_final() -> evict() ->
remove_inode_hash(). For filesystems that hash new inodes via
insert_inode_locked() before calling security_inode_init_security() (such as
ext2, jfs, gfs2, btrfs, or sysv), doesn't this leave an uninstantiated inode
with I_CREATING set in inode_hashtable until the domain exits, causing
subsequent allocations of the reused on-disk inode number to fail with -EBU=
SY
in insert_inode_locked() or -ESTALE in find_inode_fast()?

[Severity: High]
Is it safe for hook_inode_init_security() to allocate memory with
GFP_KERNEL_ACCOUNT via grant_created()?

Filesystems invoke security_inode_init_security() in the middle of inode
creation while holding internal filesystem transactions, mutexes, glocks, or
locked metadata folios without memalloc_nofs_save() (for example, jfs_creat=
e()
holds a transaction and commit_mutex, f2fs_init_inode_metadata() holds
f2fs_lock_op() and a locked inode folio, btrfs_create_new_inode() holds a
transaction handle, and gfs2_create_inode() holds glocks), which is why
security_inode_init_security() in security/security.c uses GFP_NOFS.

However, hook_inode_init_security() -> grant_created() allocates struct
landlock_object in get_inode_object() -> landlock_create_object() and struct
landlock_created in landlock_add_created() using GFP_KERNEL_ACCOUNT (which
includes __GFP_FS). Can direct reclaim recurse into the filesystem and
deadlock on those held locks or transactions?

[Severity: Medium]
Does relying on hook_inode_init_security() miss filesystems that do not call
security_inode_init_security(), and keep unlinked files' backing storage
allocated until the domain exits?

First, landlock_append_fs_rule() accepts LANDLOCK_ADD_RULE_CREATED on any
directory, but security_inode_init_security() is not called at the VFS laye=
r:
in ext4, ext2, f2fs, jfs, jffs2, and ubifs it is only compiled in when
CONFIG_*_FS_SECURITY=3Dy (where CONFIG_EXT4_FS_SECURITY and
CONFIG_F2FS_FS_SECURITY default to n), and in filesystems without security
xattr support (such as fuse/virtiofs, nfs, 9p, cifs, vfat, exfat, ntfs3, ud=
f,
and nilfs2) it is never called at all. On those filesystems or kernel
configurations, creating a file with open(O_CREAT | O_RDWR) in a
LANDLOCK_ADD_RULE_CREATED directory will never trigger
hook_inode_init_security(), causing the file to be created on disk and then
rejected with -EACCES in hook_file_open().

Second, because landlock_add_created() pins each created inode via ihold() =
in
hierarchy->created until landlock_free_created() runs when the layer's
hierarchy is freed, iput_final() -> evict() cannot run when created files a=
re
unlinked. If a long-lived sandbox or build daemon creates and unlinks tempo=
rary
files in a LANDLOCK_ADD_RULE_CREATED directory, won't their on-disk blocks =
and
tmpfs pages remain allocated until every task in that domain layer exits?

> @@ -1623,7 +1767,8 @@ static int hook_path_link(struct dentry *const old_=
dentry,
>  			  struct dentry *const new_dentry)
>  {
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
> -					false, false);
> +					false, false) ?:
> +		       refer_created(old_dentry, new_dir);
>  }
> =20
>  static int hook_path_rename(const struct path *const old_dir,
> @@ -1632,10 +1777,16 @@ static int hook_path_rename(const struct path *co=
nst old_dir,
>  			    struct dentry *const new_dentry,
>  			    const unsigned int flags)
>  {
> +	int err;
> +
>  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
> -	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
> -					!!(flags & RENAME_EXCHANGE),
> -					!!(flags & RENAME_WHITEOUT));
> +	err =3D current_check_refer_path(old_dentry, new_dir, new_dentry, true,
> +				       !!(flags & RENAME_EXCHANGE),
> +				       !!(flags & RENAME_WHITEOUT));
> +	if (err || (flags & RENAME_EXCHANGE))
> +		return err;
> +
> +	return refer_created(old_dentry, new_dir);
>  }

[Severity: High]
Doesn't calling refer_created() in hook_path_link() and hook_path_rename()
permanently grant access rights and pin the inode in hierarchy->created bef=
ore
the VFS validates or performs the link or rename?

In fs/namei.c, security_path_link() and security_path_rename() run before
vfs_link() and vfs_rename():

fs/namei.c:filename_renameat2() {
	...
	error =3D security_path_rename(&old_path, rd.old_dentry,
				     &new_path, rd.new_dentry, flags);
	if (error)
		goto exit_unlock;

	error =3D vfs_rename(&rd);
	...
}

At the point hook_path_link() and hook_path_rename() run, the VFS has not y=
et
checked DAC permissions (may_create(), may_delete_dentry(),
inode_permission()), file-type constraints (such as S_ISDIR() returning -EP=
ERM
in vfs_link(), or -EISDIR / -ENOTDIR / -ENOTEMPTY in vfs_rename()),
subsequent LSM hooks (security_inode_link(), security_inode_rename()), or t=
he
filesystem's ->link() and ->rename() operations.

If vfs_link() or vfs_rename() fails, refer_created() has already inserted
old_dentry's inode into hierarchy->created and pinned it via ihold(). Could=
 a
sandboxed task issue a link() or rename() that is guaranteed to fail in the
VFS (for example, calling link() on a directory, which fails with -EPERM in
vfs_link(), or renaming onto an incompatible target or DAC-unwritable
directory) to permanently stamp new_dir's LANDLOCK_ADD_RULE_CREATED rights
onto an inode in another directory, and then move that inode into a more
restricted directory while retaining those rights?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-landlock-c=
reated-rights-v1-0-77c8db3f6bd2@gmail.com?part=3D2
