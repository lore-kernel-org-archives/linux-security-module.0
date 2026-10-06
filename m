Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6033255F2D;
	Tue,  6 Oct 2026 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791249067; cv=none; b=Ilr+H+IfpEmkQZXBem5QI7wU6i3fX6fKiFm5hYyNztMwfA6MUqlHjPU4yyOQXPQZwmA+mOKCVcpwyfoqbW7t7QJNSURwWDiZWKPzOI7EdAWPZ0+oa/i5JsMlSkZe++VESJpY5AFbHF7M3LxyfWXUrCVXGNJvGGs7Zba1ZMYTrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791249067; c=relaxed/simple;
	bh=LKRaFQOvBicTT2RFDOp3j9ryKMJKBSaVKHxbocz+KU4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hC99eVXGtdfDebTe3+73+Z1HPFweha8jsbPC4/ej69hl6EIExnc4G1PXqKu6LTn2alnCuhJyhs+4ZBhyMNUD0GPnHgZn00EGjdwkp9vr1Ek9plzhmC+PD+g7nXnihk/5OiCHUrBs56KkIp2QoTtTE1GCHmrur4d1OkGpuwy4BGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2QVyw5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2QVyw5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761D61F00893;
	Tue,  6 Oct 2026 01:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791249065;
	bh=bfMA/iFmwy3cHVWOvUiQk46Ea7IhcbvJhsN72ftBsW4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m2QVyw5FP/QxI3WWsO8p/CjNedfsveqhzRGUmUTMa3UIvYhuqlLswVsXbiVBtXbRP
	 2OvKRggKK3HBiTflIIUoLUQquEjbiS6pPfLYHHo4ViJCR7oZvAvKna83e9QWd0S7vR
	 40nkwgcRSqTrLFbDYfS1IGRnT+0E1weepSLoBjp8cza91A1MFFPyTPMOHBb9jf9smy
	 DUed7tBctwU62apvMAFOZrq2/12YW7LzJumxGxXqqfCf/ftKzkwbFWWFlozQej6aAl
	 z7NtuJ4LgsFUtMJTvIUZBkjE/GYaO5tiZPqh/X1vxvRqtE1GJbqST1ubz8NmtUrJdI
	 T0puR2R6SUuOg==
Content-Type: multipart/mixed; boundary="===============7270998846011441453=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1762c51b9e6071ebcf194d7f5b870c4ac5b98368e082bfa5fb3659beb911aa85@mail.kernel.org>
In-Reply-To: <20261006002020.2890858-7-utilityemal77@gmail.com>
References: <20261006002020.2890858-7-utilityemal77@gmail.com>
Subject: Re: [RFC PATCH bpf-next 06/12] bpf: add a path ancestor iterator
From: bot+bpf-ci@kernel.org
To: utilityemal77@gmail.com,brauner@kernel.org,viro@zeniv.linux.org.uk,jack@suse.cz,neil@brown.name,mic@digikod.net,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kernel@vger.kernel.org,gnoack@google.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,memxor@gmail.com,jolsa@kernel.org,jlayton@kernel.org,amir73il@gmail.com,mjguzik@gmail.com,shuah@kernel.org,m@maowtm.org,utilityemal77@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  6 Oct 2026 01:11:02 +0000 (UTC)

--===============7270998846011441453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: add a path ancestor iterator

TL;DR:
- Possible use-after-free: dentry loaded from a position stays trusted after
  bpf_path_put()
- Possible i_rwsem deadlock or unlocked xattr change via ancestor dentries
- Commit message wrongly lists some non-sleepable LSM hooks

> bpf: add a path ancestor iterator
>
> Let BPF programs evaluate a path's ancestry with an open-coded iterator
> over the stepwise vfs_walk_ancestors() engine.  The iteration holds a
> reference on its current position, which is what lets a program sleep
> between positions - a dput() of the last reference may - so the kfuncs
> are KF_SLEEPABLE and the iterator is available to sleepable programs
> only.  That covers the LSM hooks a path-based policy attaches to:
> file_open, file_permission, the path_* hooks, mmap_file and bprm_* are
> all in the sleepable allowlist.

Is this description accurate?  sleepable_lsm_hooks in kernel/bpf/bpf_lsm.c,
which bpf_lsm_is_sleepable_hook() checks, does not appear to contain
bpf_lsm_file_permission, bpf_lsm_path_mknod, bpf_lsm_path_chroot or
bpf_lsm_path_post_mknod.

The iterator's bpf_iter_path_ancestors_new(), _next() and _destroy() are
all KF_SLEEPABLE, so programs attached to those hooks cannot use it.
path_mknod is one of the path hooks Landlock enforces on, and the message
presents reproducing Landlock's evaluation as the target.  No later commit
in the series adds these hooks to the allowlist.

Should the sentence be corrected, or should the hooks be added to the
allowlist?

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 08f0847c4970..265cb414a08a 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -13,7 +13,11 @@
>  #include <linux/kernfs.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
> +#include <linux/namei.h>
>  #include <linux/net.h>
> +#include <linux/slab.h>
> +
> +#include "internal.h"
>  #include <linux/xattr.h>

this isn't a bug, but should the local #include "internal.h" (and the blank
line before it) move below #include <linux/xattr.h>, so that the <linux/*.h>
block stays contiguous?

[ ... ]

> @@ -500,6 +504,143 @@ __bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)

[ ... ]

> +__bpf_kfunc struct path *
> +bpf_iter_path_ancestors_next(struct bpf_iter_path_ancestors *it)
> +{
> +	struct bpf_path_ancestors_kern *kit = (void *)it;
> +	struct path *pos = bpf_path_ancestors_step(kit);
> +	struct path *held;
> +
> +	if (!pos)
> +		return NULL;
> +	/*
> +	 * The position must outlive the walk's own view of it, so it gets a
> +	 * reference and a struct path of its own to live in: struct path is
> +	 * a value type, with nothing a BPF reference could be taken on
> +	 * otherwise.  Sleepable, so no atomic allocation.
> +	 */
> +	held = kmalloc_obj(*held);
> +	if (!held) {
> +		kit->step = -ENOMEM;
> +		return NULL;
> +	}
> +	*held = *pos;
> +	path_get(held);
> +	return held;
> +}

Can the dentries reachable through this iterator be handed to
bpf_set_dentry_xattr() or bpf_remove_dentry_xattr() in a way that breaks the
parent-before-child i_rwsem order?

Both kfuncs are in the same kfunc set and both call
inode_lock(d_inode(dentry)).  They stay deadlock-free today because each
hook decides whether a dentry is locked: the trusted dentries a hook exposes
are its own arguments, and specialize_kfunc() swaps in the _locked variants
for the hooks in d_inode_locked_hooks.  A trusted ancestor reachable only
through this iterator is outside that model, because d_parent is not
trusted.

For example, with lsm.s/path_mkdir (sleepable, and not in
d_inode_locked_hooks):

Task A: mkdir("/a/b/c")
  filename_mkdirat() -> filename_create() -> start_dirop()
    inode_lock_nested(/a/b, I_MUTEX_PARENT)
  security_path_mkdir() -> BPF program iterates dir's ancestors
    2nd position = /a -> bpf_set_dentry_xattr(pos->dentry, ...)
      inode_lock(/a)                 <- blocks

Task B: rmdir("/a/b")
  do_rmdir() -> start_dirop()
    inode_lock_nested(/a, I_MUTEX_PARENT)
  vfs_rmdir()
    inode_lock(/a/b)                 <- blocks on Task A

Task A holds /a/b and waits for /a, while Task B holds /a and waits for
/a/b.

The first position (dir itself) already self-deadlocks on the rwsem that
Task A holds.  That case has been reachable as dir->dentry since 7ed5aa71ad77
("bpf: mark struct path trusted"), but ancestors are reachable only through
this commit.  The same thing happens from path_unlink, path_rmdir,
path_symlink, path_link and path_rename, which all run with a parent
directory locked.

In the d_inode_locked_hooks (inode_unlink, inode_rmdir, inode_setxattr,
...), bpf_set_dentry_xattr is rewritten to bpf_set_dentry_xattr_locked.  An
ancestor reached through the iterator (for example starting from
&bpf_get_task_exe_file()->f_path) would then be modified by
__vfs_setxattr() without its i_rwsem held.

No later commit in the series restricts these kfuncs for dentries derived
from the iterator.

[ ... ]

> +__bpf_kfunc void bpf_path_put(struct path *path)
> +{
> +	path_put(path);
> +	kfree(path);
> +}

Can a program keep using a dentry after bpf_path_put() has dropped the
reference of the position it was loaded from?

The commit message gives keeping a position alive as the reason for the
acquire/release pair:

  "a program that saves a position's dentry, or hands one to a sleepable
  kfunc, needs it to outlive the step it came from"

Nothing in the verifier ties a dentry loaded from an acquired position to
that position's reference.  Since 7ed5aa71ad77 ("bpf: mark struct path
trusted") added:

  BTF_TYPE_SAFE_TRUSTED(struct path) {
          struct dentry *dentry;
  }

check_ptr_to_btf_access() turns "d = pos->dentry" into
PTR_TO_BTF_ID | PTR_TRUSTED, and mark_btf_ld_reg() gives d no id and no
parent_id.  release_reference() only invalidates registers where
reg->id == id or reg->parent_id == id, so d is still a trusted dentry after
bpf_path_put(pos).

Before this commit, every struct path a program could reach was a hook
argument or was embedded in a trusted object, and stayed alive for the
whole program.  bpf_iter_path_ancestors_next() is the first source of a
struct path that can be released mid-program.

Example program in a sleepable LSM hook:

  bpf_iter_path_ancestors_new(&it, dir, 0);
  p = bpf_iter_path_ancestors_next(&it);   /* dir */
  bpf_path_put(p);
  p = bpf_iter_path_ancestors_next(&it);   /* an ancestor q */
  d = p->dentry;                           /* trusted, no ref link */
  bpf_path_put(p);
  bpf_iter_path_ancestors_destroy(&it);    /* walk's ref on q dropped */
  bpf_get_dentry_xattr(d, "security.bpf.x", &dynptr);  /* sleepable kfunc */

An ancestor q is pinned only by its child's d_parent reference.  If a
concurrent rename moves that child out of q and q is then rmdir'd, the put
and destroy in the program drop the last reference and the dentry is freed.
__d_free() goes through call_rcu(), and a sleepable program is not in a
normal RCU read-side section.

The later d->d_inode / xattr access is then a use-after-free.
bpf_set_dentry_xattr(d, ...) and the inode reached through d->d_inode
(trusted_or_null) are exposed the same way.

No later commit in the series ties derived pointers to the position's
reference.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37395354107
--===============7270998846011441453==--
