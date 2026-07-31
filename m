Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520042DFF5
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503619; cv=none; b=SefrVvzDZfIkhs2lxI3Gzlp6R0LwBoCoU31FGmUmbrz9CioY0sGAjT37MvhB/3al5/Adw95tmMyHk+zgmPIUhGCcl8Rf2c/FfPVU23k/SMt1dtMHIkgFKy8DG2PbD2JrWhjCPqtuZhv4+5kwLuG4xv1dAS8CT65YXSKr46nVUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503619; c=relaxed/simple;
	bh=FMisi0oYWEwli+KSfCyxkB2rUotGxtxB3TmjcDdqVq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjkXuSejeEveh+CogfQElaE/Vw2/OyGnnJifYWvUxUR/3KRPtB3hxBlURqntcgsDVWvpMvZgnRkOAMfVNDrY/FUes6HD5YtWzyi8zpJ/19nCUx7zs7DQJOle3eR+4bb6YCIdQzBgiv8zQN2PW0dW+NLuaLFz0ralZwpgQxEHEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNjkrzqw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNjkrzqw"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1600d040e4so129498766b.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785503616; x=1786108416; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZEP2QsGUJaVjX2+pWMDS4ZaXrMX6X+QzRSGAzhqS7EY=;
        b=qNjkrzqwG9I89QZwJqos6jaEIovQvT0l+v+DxdjL07Z51Ngabml8oU22H+/KdDXx4t
         PFgjRo0GMp97ivWjSR/BMkH97gawc0HXvRb2iLxzWlfBF65kqhpLJsp9xDv284WZPNCX
         XLnXNAkBqpTD3KgcQlNjgGbJWscaGR6E0MTVGSUW6wvGjnao85nO1wiQ5aNiBRE/fHpK
         FxL4Jbrc4achRQg2nj75X4mlOEjBST3WANh1fk4zaIFiQmVluWuq8xXiox6+KleVWZf2
         Bei3Bxe0VLW8wynN3H902wAmn8ad+lP6ZCbjpEt3CUxTtjMWHOFpbxuYUZuRcZCcX+2P
         7CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785503616; x=1786108416;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZEP2QsGUJaVjX2+pWMDS4ZaXrMX6X+QzRSGAzhqS7EY=;
        b=Wrp/+HnCI1fkya8KMSgjiDdhcun4VGQavRXduKgzvze5XnEYYinhSbgkvZTNDqadW6
         SbMBxoo+0eoirGrOPV4Da9euibNABTmbvwr9AGqcPncTJ63bUO307IYtzcewM2YSUj+p
         H7KTbmDcKDGZjLfDHDkTmBb3BvkXlYUrKgrSv3Kvc3pbCLThtLnzL5BnpdDPYy7AUTUu
         0nq5Wx/jA6RlYwswDKuNFh7Trm/ToE7iAbLy5GOjduBCRK1U8Th8X8Y5QshCIVvB7edD
         NsiH+XdWtEg5eLX483Sw4L4EhhwuhUCnR2Qzr5oHweh30r4cYu9iRJyPzF5BojCxtCIx
         3XrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGCITt9y/aC/UQeqHt2pE1O5ATn5v5ECIwazDnejmS8nw6wqjqBX+MrdGokXtNRWTGP8kbj70Jeli/oqX1+Hv7v4E0p7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTAYCD+XUAhpZhyOUCE2RYx5cliD1ZufA1WCdgMJoE20G3t4n
	UjN0Te1iUuszFiUlCNdJ/q8+AghbhZkhGVy/lRtz1X52fjQCBdN+FBs7gUJUxtko/g==
X-Gm-Gg: AR+sD12h0NCq03ylY1OO/hOBF9tiOQhJzz7cyUBeXFSyeAkpa8d66P7XtpWfoUi2Pt6
	UbPT14SO/xzbo4Rsip3qaUMU8/XvZttplY/qcq+zW9k7YKB4QFaia328iF2TYzRkYCsUA86ruPc
	xiAQFgRTXl4HKfWWcfdtOr7WYEqD814kx4eHgRsZAZ7zkcZOeRlYXgXkFoK3n4vyo554bLZDtEy
	ZDeOPRT1RtlQH9BTbBfoAJ+Q1i0d3uvjtqTCCZX9jfiM3zyHoiruCdVP/thTqdA/E2xZmhkpEpB
	8EJz+XFPKAJQPmBfMGJ0ZGYX2GfCvcI8f3B+C+bG5/CIT0+m1XLBhKf3TzbgUc4gSvZKDbROJhI
	dQNzgPr/rjP4WjrJkcNA6kdhT83+wP0PlYtqQqL0K7PtcH0rewYV81/gj6L0EBgiz1APF7dUODT
	aJ/BXqItZ6e4n5WEQtQnUUtaIpVuXsUz6+84Mycn6WToQqz848MNjT4WkBE7eun8ZCJQtOSFKMk
	ij+uX+O5KR4FY2oacw=
X-Received: by 2002:a17:907:e003:10b0:c16:9dcf:8fcc with SMTP id a640c23a62f3a-c1fd3c9eb6dmr77171266b.20.1785503615215;
        Fri, 31 Jul 2026 06:13:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3ba9:7454:5ca0:a791])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4454472sm146556466b.34.2026.07.31.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 06:13:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 15:13:28 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <amyfeKoKkjsY0T0P@google.com>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
 <20260731.eiNi7aik6cah@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.eiNi7aik6cah@digikod.net>

Hello!

On Fri, Jul 31, 2026 at 01:07:57PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> > Whiteout files are used in the upper layer of an Overlayfs to indicate
> > that the file with this name does not exist in the unified view, even
> > if it is present in one of the lower layer file systems.
> > 
> > For userspace implementations of Overlay file systems (fuse-overlayfs),
> 
> We should name OverlayFS consistently.

Applied.  I kept the spelling the same as on their project pages:
"OverlayFS" and "fuse-overlayfs".


> > whiteout files can be created from userspace as well:
> > 
> > * mknod(2) with S_IFCHR and makedev(0, 0)
> > * renameat2(2) with RENAME_WHITEOUT,
> >   creating the whiteout in the old place of the moved file.
> > 
> > This commit guards whiteout creation in both of these cases with
> > LANDLOCK_ACCESS_FS_MAKE_REG.  Whiteout files are *not* considered
> > character devices and are not bound to a driver.
> > 
> > Before this commit, renameat2(2) with RENAME_WHITEOUT would create a
> > directory entry even when all LANDLOCK_ACCESS_FS_MAKE_* rights are
> > denied.
> > 
> > This does not affect normal renames within layered OverlayFS mounts:
> > When doing a regular rename() on a mounted fuse-overlayfs, it is the
> > fuse-overlayfs daemon that exercises renameat2() with RENAME_WHITEOUT,
> > and only the Landlock domain of that daemon is checked there.
> > 
> > This also adds a Landlock erratum for that case.
> > 
> > Suggested-by: Christian Brauner <brauner@kernel.org>
> > Suggested-by: Mickaël Salaün <mic@digikod.net>
> > Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  include/uapi/linux/landlock.h    |  1 +
> >  security/landlock/errata/abi-1.h | 26 ++++++++++++++++++++++++++
> >  security/landlock/fs.c           | 31 ++++++++++++++++++++++++-------
> >  3 files changed, 51 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > index 7ffe2ef127ee..9c1102ebf06e 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -351,6 +351,7 @@ struct landlock_net_port_attr {
> >   *   device.
> >   * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
> >   * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
> > + *   This also guards the creation of whiteout objects as used in OverlayFS.
> >   * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
> >   *   socket.
> >   * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
> > diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
> > index 3f099555f059..ee43bf53f6e2 100644
> > --- a/security/landlock/errata/abi-1.h
> > +++ b/security/landlock/errata/abi-1.h
> > @@ -22,3 +22,29 @@
> >   * from their original mount points.
> >   */
> >  LANDLOCK_ERRATUM(3)
> > +
> > +/**
> > + * DOC: erratum_4
> > + *
> > + * Erratum 4: Creation of whiteout objects
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + * This fix addresses an issue through which it was possible to create whiteout
> > + * objects, even when all file creation is restricted using Landlock.
> > + *
> > + * With this fix, the creation of whiteout objects is now guarded using
> > + * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
> > + * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is done through
> > + * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which previously
> > + * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
> > + *
> > + * Whiteout objects are special file types used in OverlayFS to mark the absence
> > + * of a file in an upper file system, even when the lower (often read-only) file
> > + * system does have a file with the same name.
> > + *
> > + * Impact:
> > + *
> > + * Without this fix, it was possible to create whiteout files from userspace
> > + * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
> 
> The errata should focus on the change of access rights which are needed
> (and could potentially break some use cases), not to talk about the
> RENAME_WHITEOUT (bypass) fix.  Most fixes don't get a Landlock errata
> bit.  The impact should then be explicit that this is for sandboxed
> programs such as fuse-overlayfs.
> 
> This patch does two things:
> - fix the RENAME_WHITEOUT creating a whitout without being controlled
>   (no errata, just a fix),
> - and repurpose the MAKE_REG to control whitetout creation instead of
>   relying on MAKE_CHAR (which needs an errata because it could break
>   legitimate use cases/policies).

Sounds good -- I reworded the erratum to be only about the mknod(2) case
and clarified the difference between the renameat2(2) and mknod(2) cases
better in the commit description.


> > + */
> > +LANDLOCK_ERRATUM(4)
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index f7e5e4ef9eac..570f9ff21344 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -983,7 +983,8 @@ static int current_check_access_path(const struct path *const path,
> >  	return -EACCES;
> >  }
> 
> #include <linux/kdev_t.h>
> 
> >  
> > -static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
> > +static __attribute_const__ access_mask_t get_mode_access(const umode_t mode,
> > +							 const unsigned int dev)
> 
> const dev_t dev

Thanks, good catch!


> >  {
> >  	switch (mode & S_IFMT) {
> >  	case S_IFLNK:
> > @@ -991,6 +992,9 @@ static __attribute_const__ access_mask_t get_mode_access(const umode_t mode)
> >  	case S_IFDIR:
> >  		return LANDLOCK_ACCESS_FS_MAKE_DIR;
> >  	case S_IFCHR:
> > +		/* Whiteout objects are guarded with MAKE_REG. */
> > +		if (dev == WHITEOUT_DEV)
> 
> This kind of work by luck, but dev should really be dev_t.

Done.


> > +			return LANDLOCK_ACCESS_FS_MAKE_REG;
> >  		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
> >  	case S_IFBLK:
> >  		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
> > @@ -1093,6 +1097,7 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
> >   * @new_dentry: Destination file or directory.
> >   * @removable: Sets to true if it is a rename operation.
> >   * @exchange: Sets to true if it is a rename operation with RENAME_EXCHANGE.
> > + * @whiteout: Sets to true if it is a rename operation with RENAME_WHITEOUT.
> >   *
> >   * Because of its unprivileged constraints, Landlock relies on file hierarchies
> >   * (and not only inodes) to tie access rights to files.  Being able to link or
> > @@ -1140,7 +1145,8 @@ static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
> >  static int current_check_refer_path(struct dentry *const old_dentry,
> >  				    const struct path *const new_dir,
> >  				    struct dentry *const new_dentry,
> > -				    const bool removable, const bool exchange)
> > +				    const bool removable, const bool exchange,
> > +				    const bool whiteout)
> >  {
> >  	const struct landlock_cred_security *const subject =
> >  		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
> > @@ -1160,17 +1166,27 @@ static int current_check_refer_path(struct dentry *const old_dentry,
> >  		if (unlikely(d_is_negative(new_dentry)))
> >  			return -ENOENT;
> >  		access_request_parent1 =
> > -			get_mode_access(d_backing_inode(new_dentry)->i_mode);
> > +			get_mode_access(d_backing_inode(new_dentry)->i_mode,
> > +					d_backing_inode(new_dentry)->i_rdev);
> 
> A new small get_dentry_access(dentry) helper would simplify these calls.

Added.


> >  	} else {
> >  		access_request_parent1 = 0;
> >  	}
> >  	access_request_parent2 =
> > -		get_mode_access(d_backing_inode(old_dentry)->i_mode);
> > +		get_mode_access(d_backing_inode(old_dentry)->i_mode,
> > +				d_backing_inode(old_dentry)->i_rdev);
> >  	if (removable) {
> >  		access_request_parent1 |= maybe_remove(old_dentry);
> >  		access_request_parent2 |= maybe_remove(new_dentry);
> >  	}
> >  
> > +	/*
> > +	 * In case of renameat2(2) with RENAME_WHITEOUT, a whiteout object is
> > +	 * created in the source location, so we require an additional access
> > +	 * right there.
> > +	 */
> > +	if (whiteout)
> > +		access_request_parent1 |= LANDLOCK_ACCESS_FS_MAKE_REG;
> 
> I'm wondering if this would be cleaner (see OverlayFS code):
> access_request_parent1 |= get_mode_access(S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);

Done as well.


> > +
> >  	/* The mount points are the same for old and new paths, cf. EXDEV. */
> >  	if (old_dentry->d_parent == new_dir->dentry) {
> >  		/*
> > @@ -1520,7 +1536,7 @@ static int hook_path_link(struct dentry *const old_dentry,
> >  			  struct dentry *const new_dentry)
> >  {
> >  	return current_check_refer_path(old_dentry, new_dir, new_dentry, false,
> > -					false);
> > +					false, false);
> >  }
> >  
> >  static int hook_path_rename(const struct path *const old_dir,
> > @@ -1531,7 +1547,8 @@ static int hook_path_rename(const struct path *const old_dir,
> >  {
> >  	/* old_dir refers to old_dentry->d_parent and new_dir->mnt */
> >  	return current_check_refer_path(old_dentry, new_dir, new_dentry, true,
> > -					!!(flags & RENAME_EXCHANGE));
> > +					!!(flags & RENAME_EXCHANGE),
> > +					!!(flags & RENAME_WHITEOUT));
> >  }
> >  
> >  static int hook_path_mkdir(const struct path *const dir,
> > @@ -1544,7 +1561,7 @@ static int hook_path_mknod(const struct path *const dir,
> >  			   struct dentry *const dentry, const umode_t mode,
> >  			   const unsigned int dev)
> >  {
> > -	return current_check_access_path(dir, get_mode_access(mode));
> > +	return current_check_access_path(dir, get_mode_access(mode, dev));
> 
> return current_check_access_path(dir, get_mode_access(mode, new_decode_dev(dev)));

Done.


> >  }
> >  
> >  static int hook_path_symlink(const struct path *const dir,
> > -- 
> > 2.55.0.229.g6434b31f56-goog
> > 
> > 

I'll send an updated v5.

—Günther
