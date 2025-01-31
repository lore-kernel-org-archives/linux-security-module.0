Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03591684AC
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738314647; cv=none; b=N95PpG/R8oOdysqEc/owTVlR53j7qyByHAPUyU8twWahy528TvpvoPd4vQeGLte8V/KlgrN4P09kgEm/MGDLB8UZXgxTOAzHsVViRaXbEj+mxZ1ZQNy6xqOgJIbYZKmdjB+bHp5E+osBH+3SCCmSIpB4w4GM9NAXcR/95vkzako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738314647; c=relaxed/simple;
	bh=yLTDBmJhoWCRn7SXUdGiGtxeojJyuXuCCJqVI6LNpOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8NzHbpVdKt6E5Pg5UV4CP2fwvXBhsaQ4OCivAwtkoAJVyxZt0DnmLGIvp/V3CwQ9+BhHn1aVuFIysahTu650kGVolkhXGhmL12a1+b4RhmjRAS0VEpUhNUyU5C47vx2t/kYyNoTRMwW38+Oqj9/A3AWKgVrvJR8RXH883fXBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJG/yD/i; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJG/yD/i"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso447359966b.2
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jan 2025 01:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738314643; x=1738919443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpKezhcgl4aZusxTVmVd7sTk1t/+jIVHJbEYbV/832g=;
        b=iJG/yD/iTbOcR33VeaYxZajniMGXwCTFC8lY7mSDYnmmqHLDyVPzevFYQd5XrXfVW1
         hnqr8Q32DZQqciccFiEP3RzJG0FlMP0l62dXkXsj0Qn0Tmm06nf/xttynBOY8pep9BlS
         zPtMnJq4rB25LxVyepwEMV59u5prySANiaJZ0WKE1Eu0xczkRK55jDj0o3UdfqTwv+GD
         VXFH3qJ4+ldmVHOL+7VUqLlcD6ifm/fdslo7VTlecVdI2Zrk5Q50NOzVREcuoB+Hkdz8
         MdeAi+tMJp9lWoK7+LmIC8twatAirCSXwehRc/sjIMAuE7C4lmTrutqoqoN53mDaKpc1
         Ymnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738314643; x=1738919443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpKezhcgl4aZusxTVmVd7sTk1t/+jIVHJbEYbV/832g=;
        b=hYXjJ5IkNDtE72Y9Zw6Rmwm6foKT/Pywdx48zY7fb1/K9yMDttOY0O/RzZEAmr8cB8
         AxcabYJlnBd1OPOhCQ9oqxuG5HY5/BNC51jLWMTaN0aeMrWBXjOPP1RnPt697hof9qap
         8Vyzm/cmcCgNPWAcTSPDHykFEQmL0p9benqR5ziJBArWiwuqA4LLwdZ7k5NTTAR87cy4
         SMUyYYYWOilPgkmVQ6MooAaZau4jPBOev744MvRjF3d2Ga7Xhs4uX2GufQtuAPoHxeM5
         S8eRr7muHW2wyek24Rzku+V6TSZm+Ea79j52pvOn7614Uw2qQhm1XBmdzaahtVYDSbgC
         D2KA==
X-Forwarded-Encrypted: i=1; AJvYcCWxT4kM7sBkhzTkL/j/20MRr3jrS4wTz3xxjtayabFfudIt998weBMUzgQYkRRYkStLqWSNU/DxsCzZIM0hHRw+1l6Um8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhXQR/XFcLr4pG+J5mx+YWMNFuJLZvOGKCFR1WxkuAmHbWIiB
	2fWSvzldcK4DRM9WGD7pZ0glZaiqXM4ny4A2K1+yhx154y8dSjzTEjbW4TvMSw==
X-Gm-Gg: ASbGncuX0ubkAUdiLj+dE/uNZJmmViotvQzfJgDAV86PkiO16dw2Wv0dTS7Vo3SVXpb
	WV9rH4BnytE33TRDr3tjaC5e3EwEtIamsVK2oAHpdi6zK9t1iWHWG7O/pLlQbW2CgqCszfphcuE
	Hpd47xErg/VvdofKLx9tJBFxf0AQ3yic3ch/CNpMfTlGKM/O4y1QvUHJMNVxJB2OjkjMQNrlN2y
	PZfwaYM/URi3ng3UHt8Q2UNE+DP+DhYYLPVkk55WKGgJClz0k7pjjQCaAhP6gavLbtBJ4K6ofG8
	eg6FyjBeM56xGN9k7q8MCX9FCPM4NE9+5o44yk2d70Xht8YWXazDzQgEwg==
X-Google-Smtp-Source: AGHT+IFWLObVlSGdtheyOMwGYlaU/ktaLTCYEc/HjjF4uEjsvyRwlVSiu7iRpv7fUA98J11iGQsMAg==
X-Received: by 2002:a17:907:2ce3:b0:aa6:6a52:970 with SMTP id a640c23a62f3a-ab6cfcb3b92mr1085842566b.1.1738314642919;
        Fri, 31 Jan 2025 01:10:42 -0800 (PST)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7010f4d2asm52966266b.75.2025.01.31.01.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 01:10:42 -0800 (PST)
Date: Fri, 31 Jan 2025 09:10:38 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v12 bpf-next 4/5] bpf: fs/xattr: Add BPF kfuncs to set
 and remove xattrs
Message-ID: <Z5yTjlAigEKwG1fS@google.com>
References: <20250130213549.3353349-1-song@kernel.org>
 <20250130213549.3353349-5-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130213549.3353349-5-song@kernel.org>

On Thu, Jan 30, 2025 at 01:35:48PM -0800, Song Liu wrote:
> Add the following kfuncs to set and remove xattrs from BPF programs:
> 
>   bpf_set_dentry_xattr
>   bpf_remove_dentry_xattr
>   bpf_set_dentry_xattr_locked
>   bpf_remove_dentry_xattr_locked
> 
> The _locked version of these kfuncs are called from hooks where
> dentry->d_inode is already locked. Instead of requiring the user
> to know which version of the kfuncs to use, the verifier will pick
> the proper kfunc based on the calling hook.

Looks good to me, thank you for working on this!

Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c      | 189 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h |  18 ++++
>  kernel/bpf/verifier.c   |  21 +++++
>  3 files changed, 228 insertions(+)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index db5c8e855517..08412532db1b 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -2,10 +2,12 @@
>  /* Copyright (c) 2024 Google LLC. */
>  
>  #include <linux/bpf.h>
> +#include <linux/bpf_lsm.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
>  #include <linux/dcache.h>
>  #include <linux/fs.h>
> +#include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
> @@ -168,6 +170,160 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
>  
>  __bpf_kfunc_end_defs();
>  
> +static int bpf_xattr_write_permission(const char *name, struct inode *inode)
> +{
> +	if (WARN_ON(!inode))
> +		return -EINVAL;
> +
> +	/* Only allow setting and removing security.bpf. xattrs */
> +	if (!match_security_bpf_prefix(name))
> +		return -EPERM;
> +
> +	return inode_permission(&nop_mnt_idmap, inode, MAY_WRITE);
> +}
> +
> +/**
> + * bpf_set_dentry_xattr_locked - set a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: xattr value
> + * @flags: flags to pass into filesystem operations
> + *
> + * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller already locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */

Should we also make a remark about what `flags` corresponds to
i.e. `flags` which are passed into the *setxattr(2) set of system
calls?

> +int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> +				const struct bpf_dynptr *value_p, int flags)
> +{
> +
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	struct inode *inode = d_inode(dentry);
> +	const void *value;
> +	u32 value_len;
> +	int ret;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = bpf_xattr_write_permission(name__str, inode);
> +	if (ret)
> +		return ret;
> +
> +	ret = __vfs_setxattr(&nop_mnt_idmap, dentry, inode, name__str,
> +			     value, value_len, flags);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);
> +
> +		/* This xattr is set by BPF LSM, so we do not call
> +		 * security_inode_post_setxattr. Otherwise, we would
> +		 * risk deadlocks by calling back to the same kfunc.
> +		 *
> +		 * This is the same as security_inode_setsecurity().
> +		 */
> +	}
> +	return ret;
> +}
> +
> +/**
> + * bpf_remove_dentry_xattr_locked - remove a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + *
> + * Rmove xattr *name__str* of *dentry*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller already locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	ret = bpf_xattr_write_permission(name__str, inode);
> +	if (ret)
> +		return ret;
> +
> +	ret = __vfs_removexattr(&nop_mnt_idmap, dentry, name__str);
> +	if (!ret) {
> +		fsnotify_xattr(dentry);
> +
> +		/* This xattr is removed by BPF LSM, so we do not call
> +		 * security_inode_post_removexattr. Otherwise, we would
> +		 * risk deadlocks by calling back to the same kfunc.
> +		 */
> +	}
> +	return ret;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/**
> + * bpf_set_dentry_xattr - set a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: xattr value
> + * @flags: flags to pass into filesystem operations
> + *
> + * Set xattr *name__str* of *dentry* to the value in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller has not locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
> +				     const struct bpf_dynptr *value_p, int flags)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	inode_lock(inode);
> +	ret = bpf_set_dentry_xattr_locked(dentry, name__str, value_p, flags);
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
> +/**
> + * bpf_remove_dentry_xattr - remove a xattr of a dentry
> + * @dentry: dentry to get xattr from
> + * @name__str: name of the xattr
> + *
> + * Rmove xattr *name__str* of *dentry*.
> + *
> + * For security reasons, only *name__str* with prefix "security.bpf."
> + * is allowed.
> + *
> + * The caller has not locked dentry->d_inode.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	inode_lock(inode);
> +	ret = bpf_remove_dentry_xattr_locked(dentry, name__str);
> +	inode_unlock(inode);
> +	return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
>  BTF_ID_FLAGS(func, bpf_get_task_exe_file,
>  	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
> @@ -175,6 +331,8 @@ BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
> @@ -185,6 +343,37 @@ static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  	return -EACCES;
>  }
>  
> +/* bpf_[set|remove]_dentry_xattr.* hooks have KF_TRUSTED_ARGS and
> + * KF_SLEEPABLE, so they are only available to sleepable hooks with
> + * dentry arguments.
> + *
> + * Setting and removing xattr requires exclusive lock on dentry->d_inode.
> + * Some hooks already locked d_inode, while some hooks have not locked
> + * d_inode. Therefore, we need different kfuncs for different hooks.
> + * Specifically, hooks in the following list (d_inode_locked_hooks)
> + * should call bpf_[set|remove]_dentry_xattr_locked; while other hooks
> + * should call bpf_[set|remove]_dentry_xattr.
> + */
> +BTF_SET_START(d_inode_locked_hooks)
> +BTF_ID(func, bpf_lsm_inode_post_removexattr)
> +BTF_ID(func, bpf_lsm_inode_post_setattr)
> +BTF_ID(func, bpf_lsm_inode_post_setxattr)
> +BTF_ID(func, bpf_lsm_inode_removexattr)
> +BTF_ID(func, bpf_lsm_inode_rmdir)
> +BTF_ID(func, bpf_lsm_inode_setattr)
> +BTF_ID(func, bpf_lsm_inode_setxattr)
> +BTF_ID(func, bpf_lsm_inode_unlink)
> +#ifdef CONFIG_SECURITY_PATH
> +BTF_ID(func, bpf_lsm_path_unlink)
> +BTF_ID(func, bpf_lsm_path_rmdir)
> +#endif /* CONFIG_SECURITY_PATH */
> +BTF_SET_END(d_inode_locked_hooks)
> +
> +bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> +{
> +	return btf_id_set_contains(&d_inode_locked_hooks, prog->aux->attach_btf_id);
> +}
> +
>  static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_fs_kfunc_set_ids,
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index aefcd6564251..643809cc78c3 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -48,6 +48,11 @@ void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func)
>  
>  int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  			     struct bpf_retval_range *range);
> +int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> +				const struct bpf_dynptr *value_p, int flags);
> +int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
> +bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
> +
>  #else /* !CONFIG_BPF_LSM */
>  
>  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> @@ -86,6 +91,19 @@ static inline int bpf_lsm_get_retval_range(const struct bpf_prog *prog,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
> +					      const struct bpf_dynptr *value_p, int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str)
> +{
> +	return -EOPNOTSUPP;
> +}
> +static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_BPF_LSM */
>  
>  #endif /* _LINUX_BPF_LSM_H */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9971c03adfd5..04d1d75d9ff9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11766,6 +11766,8 @@ enum special_kfunc_type {
>  	KF_bpf_iter_num_new,
>  	KF_bpf_iter_num_next,
>  	KF_bpf_iter_num_destroy,
> +	KF_bpf_set_dentry_xattr,
> +	KF_bpf_remove_dentry_xattr,
>  };
>  
>  BTF_SET_START(special_kfunc_set)
> @@ -11795,6 +11797,10 @@ BTF_ID(func, bpf_wq_set_callback_impl)
>  #ifdef CONFIG_CGROUPS
>  BTF_ID(func, bpf_iter_css_task_new)
>  #endif
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID(func, bpf_set_dentry_xattr)
> +BTF_ID(func, bpf_remove_dentry_xattr)
> +#endif
>  BTF_SET_END(special_kfunc_set)
>  
>  BTF_ID_LIST(special_kfunc_list)
> @@ -11844,6 +11850,13 @@ BTF_ID(func, bpf_local_irq_restore)
>  BTF_ID(func, bpf_iter_num_new)
>  BTF_ID(func, bpf_iter_num_next)
>  BTF_ID(func, bpf_iter_num_destroy)
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID(func, bpf_set_dentry_xattr)
> +BTF_ID(func, bpf_remove_dentry_xattr)
> +#else
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +#endif
>  
>  static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
>  {
> @@ -20924,6 +20937,14 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>  		 */
>  		env->seen_direct_write = seen_direct_write;
>  	}
> +
> +	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
> +	    bpf_lsm_has_d_inode_locked(prog))
> +		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
> +
> +	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
> +	    bpf_lsm_has_d_inode_locked(prog))
> +		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
>  }
>  
>  static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
> -- 
> 2.43.5
> 
