Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C255211A23;
	Fri, 10 Jan 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523745; cv=none; b=g72RCZUApEoIT8Z0iA+B5NRcfUeZU+eeQoLF+bFk/i7gCSyLeTTaY5vNtWKFr1N5qClAK2TcGapCsT6y6nbHPHFZCGSEBlH/boamuQOHp+CzLhxcJZHI+JDh1N4+8aQ3RM3++RZGuK26teXmpG/TCmN4ISjSzpLDwlJ5J3cvXY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523745; c=relaxed/simple;
	bh=LQ0YBl+q13C06zP9/2g7pYhm3G+iCWX5vNgo95PdK40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cLBCGCzm5MibuT1sNyLW1o3Mvy7U4XUmo7HWNZz6KODjHtt30Fv+tUFnJUjGNYfhYO039nMKqCzNKIh4z7zkL4fWIUaGs8020MHMQgleIsKedAdGNDLcwAWU4PKoqB58rbQZ72kifm4yH74y19TB+64CtSoxxE9aSwVDkbyrZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0PsX6NG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0PsX6NG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AE9C4CEE3;
	Fri, 10 Jan 2025 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736523744;
	bh=LQ0YBl+q13C06zP9/2g7pYhm3G+iCWX5vNgo95PdK40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=e0PsX6NG9lnwPOZQdAZ3U32975m3CFvLd8zG0vaqgWl5ngvIBFv7jhFUCv+kGTShz
	 ++iraoW0k8IAlk6VGGX8FPveuE2vH3J9VkgbIGlfv/Q0n6p7Th4tLP+HdWmOhBo+p6
	 coM3DlNHTDvNGw4JQCXlLajs3BRwx3O/AMITYIxMDJX/kgVpDgRi+sLqTd7xqwEXQB
	 9SJg0rVX1MUUaazQS4tpXlFGTc8XpOm2dXcELMIgI3oGa3ap/G+vHLjPV9Y6VC+b9r
	 +yn+dO3veY64F0cpy2bS0y5oe6NEk9KQJj0cTFRzjBjK2J0gGAT5trVJ68Exm4pVeQ
	 HYtdEckUZ472w==
Date: Fri, 10 Jan 2025 16:42:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Shervin Oloumi <enlightened@chromium.org>
Cc: mic@digikod.net, viro@zeniv.linux.org.uk, jack@suse.cz, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, gnoack@google.com, 
	shuah@kernel.org, jorgelo@chromium.org, allenwebb@chromium.org
Subject: Re: [PATCH v3 1/2] fs: add loopback/bind mount specific security hook
Message-ID: <20250110-luftverkehr-lagen-e9c26ffc277f@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250110021008.2704246-1-enlightened@chromium.org>
 <CAMb9sTgEjNk4X+FLwpmi56z+LDV=gYOO=qN5AjQSN4Erw-SUaw@mail.gmail.com>

On Thu, Jan 09, 2025 at 06:10:07PM -0800, Shervin Oloumi wrote:
> The main mount security hook (security_sb_mount) is called early in the
> process before the mount type is determined and the arguments are
> validated and converted to the appropriate format. Specifically, the
> source path is surfaced as a string, which is not appropriate for
> checking bind mount requests. For bind mounts the source should be
> validated and passed as a path struct (same as destination), after the
> mount type is determined. This allows the hook users to evaluate the
> mount attributes without the need to perform any validations or
> conversions out of band, which can introduce a TOCTOU race condition.
> 
> The newly introduced hook is invoked only if the security_sb_mount hook
> passes, and only if the MS_BIND flag is detected. The
> do_reconfigure_mnt() case (MS_REMOUNT | MS_BIND) is still handled by the
> existing security_sb_mount() hook. When the new bind mount hook is
> called, the source of the mount has already been successfully converted
> to a path struct using the kernel's kern_path API. This allows LSMs to
> target bind mount requests at the right stage, and evaluate the
> attributes in the right format, based on the type of mount. This bind
> mount hook also signals the existence of MS_REC flag via a boolean.
> 
> This does not affect the functionality of the existing mount security
> hooks, including security_sb_mount. The new hook, can be utilized as a
> supplement to the main hook for further analyzing bind mount requests.
> This means that there is still the option of only using the main hook
> function, if all one wants to do is indiscriminately reject all bind
> mount requests, regardless of the source and destination arguments.
> However, if one needs to evaluate the source and destination of a bind
> mount request before making a decision, this hook function should be
> preferred. Of course, if a bind mount request does not make it past the
> security_sb_mount check, the bind mount hook function is never invoked.
> 
> Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> ---
> 
> Changes since v2:
> - Reword the commit to include how do_reconfigure_mnt() is handled and
>   mention that MS_REC is also surfaced in the hook
> 
> Changes since v1:
> - Indicate whether the mount is recursive in the hook. This can be a
>   factor when deciding if a mount should be allowed
> - Add default capabilities function for the new hook in security.h. This
>   is required for some tests to pass
> - Reword the hook description to be more future proof
> ---
>  fs/namespace.c                |  4 ++++
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  7 +++++++
>  security/security.c           | 18 ++++++++++++++++++
>  4 files changed, 31 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 23e81c2a1e3f..535a1841c200 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
>  	if (err)
>  		return err;
>  
> +	err = security_sb_bindmount(&old_path, path, recurse ? true : false);
> +	if (err)
> +		goto out;
> +
>  	err = -EINVAL;
>  	if (mnt_ns_loop(old_path.dentry))
>  		goto out;
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index eb2937599cb0..94f5a3530b98 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -71,6 +71,8 @@ LSM_HOOK(int, 0, sb_show_options, struct seq_file *m, struct super_block *sb)
>  LSM_HOOK(int, 0, sb_statfs, struct dentry *dentry)
>  LSM_HOOK(int, 0, sb_mount, const char *dev_name, const struct path *path,
>  	 const char *type, unsigned long flags, void *data)
> +LSM_HOOK(int, 0, sb_bindmount, const struct path *old_path,
> +	 const struct path *path, bool recurse)
>  LSM_HOOK(int, 0, sb_umount, struct vfsmount *mnt, int flags)
>  LSM_HOOK(int, 0, sb_pivotroot, const struct path *old_path,
>  	 const struct path *new_path)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cbdba435b798..d4a4c71865e3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -365,6 +365,7 @@ int security_sb_show_options(struct seq_file *m, struct super_block *sb);
>  int security_sb_statfs(struct dentry *dentry);
>  int security_sb_mount(const char *dev_name, const struct path *path,
>  		      const char *type, unsigned long flags, void *data);
> +int security_sb_bindmount(const struct path *old_path, const struct path *path, bool recurse);
>  int security_sb_umount(struct vfsmount *mnt, int flags);
>  int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
>  int security_sb_set_mnt_opts(struct super_block *sb,
> @@ -801,6 +802,12 @@ static inline int security_sb_mount(const char *dev_name, const struct path *pat
>  	return 0;
>  }
>  
> +static inline int security_sb_bindmount(const struct path *old_path,
> +					const struct path *path, bool recurse)
> +{
> +	return 0;
> +}
> +
>  static inline int security_sb_umount(struct vfsmount *mnt, int flags)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index 09664e09fec9..c115d8627e2d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1564,6 +1564,24 @@ int security_sb_mount(const char *dev_name, const struct path *path,
>  	return call_int_hook(sb_mount, dev_name, path, type, flags, data);
>  }
>  
> +/**
> + * security_sb_bindmount() - Loopback/bind mount permission check
> + * @old_path: source of loopback/bind mount
> + * @path: mount point
> + * @recurse: true if recursive (MS_REC)
> + *
> + * Beyond any general mounting hooks, this check is performed on an initial
> + * loopback/bind mount (MS_BIND) with the mount source presented as a path
> + * struct in @old_path.
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_sb_bindmount(const struct path *old_path, const struct path *path,
> +			  bool recurse)
> +{
> +	return call_int_hook(sb_bindmount, old_path, path, recurse);
> +}
> +
>  /**
>   * security_sb_umount() - Check permission for unmounting a filesystem
>   * @mnt: mounted filesystem
> 
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

On Thu, Jan 09, 2025 at 08:14:07PM -0800, Shervin Oloumi wrote:
> On Fri, Jan 3, 2025 at 3:11 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 30-12-24 17:46:31, Shervin Oloumi wrote:
> > > The main mount security hook (security_sb_mount) is called early in the
> > > process before the mount type is determined and the arguments are
> > > validated and converted to the appropriate format. Specifically, the
> > > source path is surfaced as a string, which is not appropriate for
> > > checking bind mount requests. For bind mounts the source should be
> > > validated and passed as a path struct (same as destination), after the
> > > mount type is determined. This allows the hook users to evaluate the
> > > mount attributes without the need to perform any validations or
> > > conversions out of band, which can introduce a TOCTOU race condition.
> > >
> > > The newly introduced hook is invoked only if the security_sb_mount hook
> > > passes, and only if the MS_BIND flag is detected. At this point the
> > > source of the mount has been successfully converted to a path struct
> > > using the kernel's kern_path API. This allows LSMs to target bind mount
> > > requests at the right stage, and evaluate the attributes in the right
> > > format, based on the type of mount.
> > >
> > > This does not affect the functionality of the existing mount security
> > > hooks, including security_sb_mount. The new hook, can be utilized as a
> > > supplement to the main hook for further analyzing bind mount requests.
> > > This means that there is still the option of only using the main hook
> > > function, if all one wants to do is indiscriminately reject all bind
> > > mount requests, regardless of the source and destination arguments.
> > > However, if one needs to evaluate the source and destination of a bind
> > > mount request before making a decision, this hook function should be
> > > preferred. Of course, if a bind mount request does not make it past the
> > > security_sb_mount check, the bind mount hook function is never invoked.
> > >
> > > Signed-off-by: Shervin Oloumi <enlightened@chromium.org>
> >
> > Christian is much more experienced in this area than me but let me share my
> > thoughts before he returns from vacation.
> >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index 23e81c2a1e3f..c902608c9759 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -2765,6 +2765,10 @@ static int do_loopback(struct path *path, const char *old_name,
> > >       if (err)
> > >               return err;
> > >
> > > +     err = security_sb_bindmount(&old_path, path);
> > > +     if (err)
> > > +             goto out;
> > > +
> >
> > So this gets triggered for the legacy mount API path (mount(2) syscall).
> > For the new mount API, I can see open_tree() does not have any security
> > hook. Is that intented? Are you catching equivalent changes done through
> > the new mount API inside security_move_mount() hook?
> 
> I am not very familiar with the new API and when it is used, but LandLock does
> listen to security_move_mount() and it rejects all such requests. It also
> listens to and rejects remount and pivotroot. Are there cases where bind mount
> requests go through open_tree() and this hook is bypassed?

Whether or not Landlock currently blocks security_move_mount()
unconditionally doesn't matter. Introducing this api will have to do it
for the old and the new mount api. First, because we don't implement new
features for the old mount api that aren't also available in the new
mount api. Second, because this asymmetry just begs for bugs when
security_move_mount() isn't blocked anymore.

And third, there seems to be a misconception here.
open_tree(OPEN_TREE_CLONE) gives you an unattached bind-mount.
move_mount() is just sugar on top to attach it to a mount namespace.

But a file descriptor from open_tree(OPEN_TREE_CLONE) can be interacted
with just fine, i.e., read, write, create, shared with other processes.
You could create a bind-mount that is never attached anywhere. So I'm
not sure what security guarantees it would give you to block MS_BIND but
not OPEN_TREE_CLONE.

It should be done for both.

> 
> > Also what caught my eye is that the LSM doesn't care at all whether this is
> > a recursive bind mount (copying all mounts beneath the specified one) or
> > just a normal one (copying only a single mount). Maybe that's fine but it
> > seems a bit counter-intuitive to me as AFAIU it implicitly places a
> > requirement on the policy that if doing some bind mount is forbidden, then
> > doing bind mount of any predecessor must be forbidden as well (otherwise
> > the policy will be inconsistent).
> 
> I need to double check this with Mickaël, but I think it is safe to allow
> recursive bind mounts. If a bind mount was allowed, let's say /A -> /home/B,
> then we already verified that the process did not gain more access (or even
> dropped some access) through the new mount point, e.g. accessing /A/a through
> /home/B/a. So with a recursive bind mount, let's say /home -> /C, once we check
> for privilege escalation as usual, it should be safe to clone any existing sub
> mounts in the new destination. Because if access through B <= A and C <= B then
> access through C <= A. So back to your point, there should never exist an
> illegal bind mount action that can implicitly happen through a legal recursive
> bind mount of its predecessor. Regardless, I think it might be useful to know if
> a mount is recursive for other use cases so I added a boolean for surfacing
> MS_REC in the new patches.

Say /home/hidden is covered by a bind-mount of /dev/null and you're
doing mount --bind /home /somewhere then /home/hidden will be uncovered
(There's cases where the kernel itself fuses mounts together or "locks"
them so things like this cannot happen e.g., when creating an
unprivileged mount namespace.). If your policy blocks unmounting
/home/hidden to protect the underlying file then a non-recursive
bind-mount would be able to circumvent that restriction.
