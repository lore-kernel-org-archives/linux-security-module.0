Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32E3E5EF7
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496100; cv=none; b=TrR9LtBIq6dUmzfN+QjT6ivNYAyVhzqKI83ShW/09rgCa0bsJYIucbyBYn1ZsUjX27Tx/EA9hUjkBj3+CGKBAFHJIW7WzdAWPophNGKkd9g8eeLLb6zvQEU4WBjkXaklMD0JCbza6Y8thCffl1chjeRyypaodvxfzKHaGUBso70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496100; c=relaxed/simple;
	bh=M8AGo99BLDv00R0i++WeEwoMR+ePFkrWxklOyyyevY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSOPYU5T5FChxFPSOZnt5eVuCSylnBSj+//bNt4WeYel+TqJWpoiWgNSRBB/m8GKqaK/7SNYXzmE541T7cGoZgfRnD8VT//5AiPNu81mejKa+EehiJAbaaBMWobEwkRkjhytlrQZg7IOvY2uqMvSdiy1gj/Lx7OW1GIpsLXUTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=WQg4IaS7; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="WQg4IaS7"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBNb66fqQzmc2;
	Fri, 31 Jul 2026 13:08:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785496082;
	bh=/1C9dykgWRCtzp9jdcIh6c9MJVtvQOCTVbz4hpadbOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQg4IaS7zV3uym3zwydMUOXrxDo1r3HDyUWCFZibqeYlNj5w3Y/Sh6/PFKLenzgzP
	 ez21nLemcZL0QyZvgEKeyB0p4wdQwwySF98QmOu78n84LDyjVsmF/HRmaWOKfxEFfa
	 VOf7/qfUFJrg/DEhl6+bVcaIGLTw+wqChlVPjgrE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hBNb56vVkz7fv;
	Fri, 31 Jul 2026 13:08:01 +0200 (CEST)
Date: Fri, 31 Jul 2026 13:07:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Serge Hallyn <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <20260731.eiNi7aik6cah@digikod.net>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724161004.2360749-3-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> Whiteout files are used in the upper layer of an Overlayfs to indicate
> that the file with this name does not exist in the unified view, even
> if it is present in one of the lower layer file systems.
> 
> For userspace implementations of Overlay file systems (fuse-overlayfs),

We should name OverlayFS consistently.

> whiteout files can be created from userspace as well:
> 
> * mknod(2) with S_IFCHR and makedev(0, 0)
> * renameat2(2) with RENAME_WHITEOUT,
>   creating the whiteout in the old place of the moved file.
> 
> This commit guards whiteout creation in both of these cases with
> LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
> character devices and are not bound to a driver.
> 
> Before this commit, renameat2(2) with RENAME_WHITEOUT would create a
> directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
> denied.
> 
> This does not affect normal renames within layered OverlayFS mounts:
> When doing a regular rename() on a mounted fuse-overlayfs, it is the
> fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
> and only the Landlock domain of that daemon is checked there.
> 
> This also adds a Landlock erratum for that case.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Mickaël Salaün <mic@digikod.net>
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  include/uapi/linux/landlock.h    |  1 +
>  security/landlock/errata/abi-1.h | 26 ++++++++++++++++++++++++++
>  security/landlock/fs.c           | 31 ++++++++++++++++++++++++-------
>  3 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 7ffe2ef127ee..9c1102ebf06e 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -351,6 +351,7 @@ struct landlock_net_port_attr {
>   *   device.
>   * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
>   * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
> + *   This also guards the creation of whiteout objects as used in OverlayFS.
>   * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
>   *   socket.
>   * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
> diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> index 3f099555f059..ee43bf53f6e2 100644
> --- a/security/landlock/errata/abi-1.h
> +++ b/security/landlock/errata/abi-1.h
> @@ -22,3 +22,29 @@
>   * from their original mount points.
>   */
>  LANDLOCK_ERRATUM(3)
> +
> +/**
> + * DOC: erratum_4
> + *
> + * Erratum 4: Creation of whiteout objects
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + * This fix addresses an issue through which it was possible to create whiteout
> + * objects, even when all file creation is restricted using Landlock.
> + *
> + * With this fix, the creation of whiteout objects is now guarded using
> + * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
> + * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is done through
> + * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which previously
> + * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
> + *
> + * Whiteout objects are special file types used in OverlayFS to mark the absence
> + * of a file in an upper file system, even when the lower (often read-only) file
> + * system does have a file with the same name.
> + *
> + * Impact:
> + *
> + * Without this fix, it was possible to create whiteout files from userspace
> + * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.

The errata should focus on the change of access rights which are needed
(and could potentially break some use cases), not to talk about the
RENAME_WHITEOUT (bypass) fix.  Most fixes don't get a Landlock errata
bit.  The impact should then be explicit that this is for sandboxed
programs such as fuse-overlayfs.

This patch does two things:
- fix the RENAME_WHITEOUT creating a whitout without being controlled
  (no errata, just a fix),
- and repurpose the MAKE_REG to control whitetout creation instead of
  relying on MAKE_CHAR (which needs an errata because it could break
  legitimate use cases/policies).


> + */
> +LANDLOCK_ERRATUM(4)
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index f7e5e4ef9eac..570f9ff21344 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -983,7 +983,8 @@ static int current_check_access_path(const struct path *const path,
>  	return -EACCES;
>  }

#include <linux/kdev_t.h>

>  
> -static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
> +static __attribute_const__ access_mask_t get_mode_access(const umode_t mode,
> +							 const unsigned int dev)

const dev_t dev

>  {
>  	switch (mode & S_IFMT) {
>  	case S_IFLNK:
> @@ -991,6 +992,9 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
>  	case S_IFDIR:
>  		return LANDLOCK_ACCESS_FS_MAKE_DIR;
>  	case S_IFCHR:
> +		/* Whiteout objects are guarded with MAKE_REG. */
> +		if (dev == WHITEOUT_DEV)

This kind of work by luck, but dev should really be dev_t.

> +			return LANDLOCK_ACCESS_FS_MAKE_REG;
>  		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
>  	case S_IFBLK:
>  		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
> @@ -1093,6 +1097,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>   * @new_dentry: Destination file or directory.
>   * @removable: Sets to true if it is a rename operation.
>   * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
> + * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
>   *
>   * Because of its unprivileged constraints, Landlock relies on file hierarchies
>   * (and not only inodes) to tie access rights to files.  Being able to link or
> @@ -1140,7 +1145,8 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
>  static int current_check_refer_path(struct dentry *const old_dentry,
>  				    const struct path *const new_dir,
>  				    struct dentry *const new_dentry,
> -				    const bool removable, const bool exchange)
> +				    const bool removable, const bool exchange,
> +				    const bool whiteout)
>  {
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> @@ -1160,17 +1166,27 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  		if (unlikely(d_is_negative(new_dentry)))
>  			return -ENOENT;
>  		access_request_parent1 =
> -			get_mode_access(d_backing_inode(new_dentry)->i_mode);
> +			get_mode_access(d_backing_inode(new_dentry)->i_mode,
> +					d_backing_inode(new_dentry)->i_rdev);

A new small get_dentry_access(dentry) helper would simplify these calls.

>  	} else {
>  		access_request_parent1 = 0;
>  	}
>  	access_request_parent2 =
> -		get_mode_access(d_backing_inode(old_dentry)->i_mode);
> +		get_mode_access(d_backing_inode(old_dentry)->i_mode,
> +				d_backing_inode(old_dentry)->i_rdev);
>  	if (removable) {
>  		access_request_parent1 |= maybe_remove(old_dentry);
>  		access_request_parent2 |= maybe_remove(new_dentry);
>  	}
>  
> +	/*
> +	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
> +	 * created in the source location, so we require an additional access
> +	 * right there.
> +	 */
> +	if (whiteout)
> +		access_request_parent1 |= LANDLOCK_ACCESS_FS_MAKE_REG;

I'm wondering if this would be cleaner (see OverlayFS code):
access_request_parent1 |= get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);


> +
>  	/* The mount points are the same for old and new paths, cf. EXDEV. */
>  	if (old_dentry->d_parent == new_dir->dentry) {
>  		/*
> @@ -1520,7 +1536,7 @@ static int hook_path_link(struct dentry *const old_dentry,
>  			  struct dentry *const new_dentry)
>  {
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
> -					false);
> +					false, false);
>  }
>  
>  static int hook_path_rename(const struct path *const old_dir,
> @@ -1531,7 +1547,8 @@ static int hook_path_rename(const struct path *const old_dir,
>  {
>  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
>  	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
> -					!!(flags & RENAME_EXCHANGE));
> +					!!(flags & RENAME_EXCHANGE),
> +					!!(flags & RENAME_WHITEOUT));
>  }
>  
>  static int hook_path_mkdir(const struct path *const dir,
> @@ -1544,7 +1561,7 @@ static int hook_path_mknod(const struct path *const dir,
>  			   struct dentry *const dentry, const umode_t mode,
>  			   const unsigned int dev)
>  {
> -	return current_check_access_path(dir, get_mode_access(mode));
> +	return current_check_access_path(dir, get_mode_access(mode, dev));

return current_check_access_path(dir, get_mode_access(mode, new_decode_dev(dev)));

>  }
>  
>  static int hook_path_symlink(const struct path *const dir,
> -- 
> 2.55.0.229.g6434b31f56-goog
> 
> 
