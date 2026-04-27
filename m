Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F22E7635
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283324; cv=none; b=u85OP2Z/KTT1oA4hzCfcET+CVIuhCNq16CBTw+WtmT+QHVC6KsuklYsavi5leKqmDd16ZVlqJbb6q/88+sgBwFFogc7F01flfQFihMWp0f/p8j8NwkrKTp7mXWemY3Myv4IBF4QL3VSAn5/RdZzOuYtk3DVGOXH9FkRJ2ekC2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283324; c=relaxed/simple;
	bh=1jCpQ4U/LBbt8hLPcx+EO8LC1E8zd3L6tD9nT89tjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDVTYkQq3ixK4YOmIVAa0YgGFQyM4v1zTdHsmMcyc4m3PiumXsoQ/v2kJjXo9gOZW7V5rKZrNF0npeJilfriB/+afpMGQpSxC56N4rbgnWXRKfdOh/9xkdPtm9pG5cPuJ3dWU0oIgDcbczXi2vsi3SWpgGxAmd5tXJRA7h2QhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ha2yKR3E; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ha2yKR3E"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-671c5eb7fb0so11818693a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 02:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777283321; x=1777888121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7m7cCjhCnLcfLqjuknfSX6EO5xBaZu0ObzUFgWUkgw=;
        b=Ha2yKR3EBb6zWCTq3antu8XAEmZ2bBzqtDqdEDwmm76CHhaWWl0Qq/gJ+ywLYPtkVR
         La53tJj/z6MRpMnq6GZcb5gVchWrRofQdoT4Ke+mudZSKFC7A3KcQ/dbGdhjgfdtacDI
         7w/e5vAjZhGHTDbPLwX/6HOxkgH+pv2glsqkyjMJJE2sEpETcU9J9DHaE2d0MYIyNv30
         D0IzPFDMskyFM8zwVx2+mPKeE2SctzK7gK5/l3WR7RgNVJxkjQXgHSnoyygPoF07Wt0Y
         n0kEfSIWOM+anZsRcU2JNfdDg0b7ewc9UtaXmqR09lWZHEWfA66lH98yriFxUGpL6+Mv
         eNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777283321; x=1777888121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7m7cCjhCnLcfLqjuknfSX6EO5xBaZu0ObzUFgWUkgw=;
        b=HM6F6KZ5HQHJ55SdUsTXgbCUFje3ZVZkv+/8qdB2qaP32N5WE4Bgpas3sxMxKCvWeE
         6L686owXdHNIEjotXozpZmB304VVYG5xA7ZjuVGHzFDEw4rM2xfOPIKFLBZHFFGQoziw
         ES1+YpALyNzwBCSql/j6l4lgX4MjxW6c3kbDY4VO+/3X+yYoO0ewHiB4a0cZlm3wddU0
         IgUkM0ScpCrHKOHAavaClOiCArs6EuqsD5OJl6e5eGeXyFuNcvzxhp+qsDgEqxVk7cod
         /5mPEJatuaGgfxC+JjtcZisZ8ovx4RYx6eaBm2xUPPtxnqnGTv30r2JOSM08vAfXTNIU
         4E8g==
X-Forwarded-Encrypted: i=1; AFNElJ+NIVF09LNl13eK3f6DSwlG23r/NuLt3YkJcuvoRfx9Dhad0I5ynPGVgJPQfdBoB/o4k7pNiwteFq8pdC31JTJ77F8ao2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/Lu8qwvVocaffF7IWmfU1G8xkLuYxyYKeP56hhDBN0HDnmLP
	hAVD5hT+YyvFyNIM4JQMlwxVqQEZsNzHouG8Ea94gan8auDvEDIUYOhyE2qW8Hagxw==
X-Gm-Gg: AeBDiev5oNz/snwT6oCpuedRk+ZZ4jb56Jl0Id+MDrpGieu87yKARv+vKPa+rdsfEZJ
	ijnXHs5EPyHJ7QjIMIuKxZMpyjCGyugswSdO4tz9PuHihY0etG/0GdbhKkMIxiQhC5xPucIsWk/
	PFQdOAXYsb9cGYPCPJQIswYvHXwuKjAUl3G11HRWVgcYk8RCou4eiZ9L10chx0JadKWbS01Ae4D
	DbXESNCZpxHTXIbQeSF2ynT8iM95LxG5MFnczqda5gX4z+gD5d6n87enuqciBOWV2779E1djnZe
	CEl58F00pyjfmUQqJvm0cjAk28tUDhQzORQjbFMR7JOnoEjhC2HtDRnZR3B65RtwnMw5IOA/CIF
	aWbycC1lv/t4ZJsKlijk9d7ApdNymr0Vuk65istMwRL3K1bfq0+EB1QcqSt6KbNZqo73Bms79Xq
	+5V6AA+lqg0zPCCj5JTVJGv80/yrGxj7j7ZjHLIEZXoeqiA5c2mLNtiEO6e33xC+GR/mEiiZTy3
	5GKCzQyVtXu
X-Received: by 2002:a17:907:cd09:b0:b97:b3bc:f6ba with SMTP id a640c23a62f3a-ba41ac040f5mr2408836466b.39.1777283320301;
        Mon, 27 Apr 2026 02:48:40 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e49sm1112463566b.10.2026.04.27.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:48:39 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:48:36 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>,
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Message-ID: <ae8w9CIG1VrDHUcZ@google.com>
References: <20260427001602.38353-1-dwindsor@gmail.com>
 <20260427001602.38353-2-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427001602.38353-2-dwindsor@gmail.com>

On Sun, Apr 26, 2026 at 08:15:57PM -0400, David Windsor wrote:
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via inode_init_security hook using lsm_get_xattr_slot().
> 
> lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> programs cannot do: hook arguments are not directly writable from BPF.
> To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> value), and the verifier transparently rewrites each call into
> bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> xattr_count are extracted from the hook context, which the verifier
> spills to the stack at program entry since R1 is clobbered during normal
> execution.
> 
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant. We take advantage of this by
> passing the name directly. Because we rely on the hook-specific ctx
> layout, the kfunc is restricted to lsm/inode_init_security.
> 
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> Suggested-by: Song Liu <song@kernel.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c           | 80 +++++++++++++++++++++++++++++++++++-
>  include/linux/bpf_verifier.h |  3 ++
>  kernel/bpf/fixups.c          | 20 +++++++++
>  kernel/bpf/verifier.c        | 54 ++++++++++++++++++++++++
>  security/bpf/hooks.c         |  3 ++
>  5 files changed, 159 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 9d27be058494..5a5951006a3f 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>  
> @@ -353,6 +354,68 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>  
> +/* Called from the verifier fixup of bpf_init_inode_xattr(). */
> +__bpf_kfunc int bpf_init_inode_xattr_impl(struct xattr *xattrs, int *xattr_count,
> +					  const char *name__str,
> +					  const struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	size_t name_len;
> +	void *xattr_value;
> +	struct xattr *xattr;
> +	const void *value;
> +	u32 value_len;
> +
> +	if (!xattrs || !xattr_count || !name__str)
> +		return -EINVAL;
> +
> +	name_len = strlen(name__str);
> +	if (name_len == 0 || name_len > XATTR_NAME_MAX)
> +		return -EINVAL;
> +
> +	value_len = __bpf_dynptr_size(value_ptr);
> +	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
> +		return -EINVAL;
> +
> +	value = __bpf_dynptr_data(value_ptr, value_len);
> +	if (!value)
> +		return -EINVAL;
> +
> +	xattr_value = kmemdup(value, value_len, GFP_ATOMIC);
> +	if (!xattr_value)
> +		return -ENOMEM;
> +
> +	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
> +	if (!xattr) {
> +		kfree(xattr_value);
> +		return -ENOSPC;
> +	}

I think you should also include the following check:

     	if (!match_security_bpf_prefix(name__str))
		return -EPERM;

This will ensure that some namespace isolation is provided and make
the behavior of this initialization based BPF kfunc consistent with
the pre-existing runtime xattr-related modification BPF kfuncs (e.g.,
bpf_set_dentry_xattr()).

> +	xattr->name = name__str;
> +	xattr->value = xattr_value;
> +	xattr->value_len = value_len;
> +
> +	return 0;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs. The verifier rewrites
> + * calls to bpf_init_inode_xattr_impl() with xattrs/xattr_count extracted from
> + * the hook context.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(const char *name__str,
> +				     const struct bpf_dynptr *value_p)
> +{
> +	WARN_ONCE(1, "%s called without verifier fixup\n", __func__);
> +	return -EFAULT;
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> @@ -363,13 +426,28 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr)
> +BTF_ID_FLAGS(func, bpf_init_inode_xattr_impl)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>  
> +BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
> +BTF_ID(func, bpf_lsm_inode_init_security)
> +
> +BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
> +BTF_ID(func, bpf_init_inode_xattr)
> +BTF_ID(func, bpf_init_inode_xattr_impl)
> +
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  {
>  	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> -	    prog->type == BPF_PROG_TYPE_LSM)
> +	    prog->type == BPF_PROG_TYPE_LSM) {
> +		/* bpf_init_inode_xattr[_impl] only attach to inode_init_security. */
> +		if ((kfunc_id == bpf_init_inode_xattr_btf_ids[0] ||
> +		     kfunc_id == bpf_init_inode_xattr_btf_ids[1]) &&
> +		    prog->aux->attach_btf_id != bpf_lsm_inode_init_security_btf_ids[0])
> +			return -EACCES;
>  		return 0;
> +	}
>  	return -EACCES;
>  }
>  
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 101ca6cc5424..e73bb2222c3d 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -682,6 +682,7 @@ struct bpf_insn_aux_data {
>  	 */
>  	u8 fastcall_spills_num:3;
>  	u8 arg_prog:4;
> +	u8 init_inode_xattr_fixup:1;
>  
>  	/* below fields are initialized once */
>  	unsigned int orig_idx; /* original instruction index */
> @@ -903,6 +904,8 @@ struct bpf_verifier_env {
>  	bool bypass_spec_v4;
>  	bool seen_direct_write;
>  	bool seen_exception;
> +	bool needs_ctx_spill;
> +	s16 ctx_stack_off;
>  	struct bpf_insn_aux_data *insn_aux_data; /* array of per-insn state */
>  	const struct bpf_line_info *prev_linfo;
>  	struct bpf_verifier_log log;
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index fba9e8c00878..18d612a9fe29 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -725,6 +725,26 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  		}
>  	}
>  
> +	if (env->needs_ctx_spill) {
> +		if (epilogue_cnt) {
> +			/* gen_epilogue already saved ctx to the stack */
> +			env->ctx_stack_off = -(s16)subprogs[0].stack_depth;
> +		} else {
> +			cnt = 0;
> +			subprogs[0].stack_depth += 8;
> +			env->ctx_stack_off = -(s16)subprogs[0].stack_depth;
> +			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_FP,
> +						      BPF_REG_1,
> +						      env->ctx_stack_off);
> +			insn_buf[cnt++] = env->prog->insnsi[0];
> +			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +			env->prog = new_prog;
> +			delta += cnt - 1;
> +		}
> +	}
> +
>  	if (ops->gen_prologue || env->seen_direct_write) {
>  		if (!ops->gen_prologue) {
>  			verifier_bug(env, "gen_prologue is null");
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03f9e16c2abe..af5753ffb16b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10794,6 +10794,8 @@ enum special_kfunc_type {
>  	KF_bpf_arena_alloc_pages,
>  	KF_bpf_arena_free_pages,
>  	KF_bpf_arena_reserve_pages,
> +	KF_bpf_init_inode_xattr,
> +	KF_bpf_init_inode_xattr_impl,
>  	KF_bpf_session_is_return,
>  	KF_bpf_stream_vprintk,
>  	KF_bpf_stream_print_stack,
> @@ -10882,6 +10884,13 @@ BTF_ID(func, bpf_task_work_schedule_resume)
>  BTF_ID(func, bpf_arena_alloc_pages)
>  BTF_ID(func, bpf_arena_free_pages)
>  BTF_ID(func, bpf_arena_reserve_pages)
> +#ifdef CONFIG_BPF_LSM
> +BTF_ID(func, bpf_init_inode_xattr)
> +BTF_ID(func, bpf_init_inode_xattr_impl)
> +#else
> +BTF_ID_UNUSED
> +BTF_ID_UNUSED
> +#endif
>  BTF_ID(func, bpf_session_is_return)
>  BTF_ID(func, bpf_stream_vprintk)
>  BTF_ID(func, bpf_stream_print_stack)
> @@ -12701,6 +12710,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  	if (err < 0)
>  		return err;
>  
> +	if (meta.func_id == special_kfunc_list[KF_bpf_init_inode_xattr_impl]) {
> +		verbose(env, "bpf_init_inode_xattr_impl is not callable directly\n");
> +		return -EACCES;
> +	}
> +
> +	if (meta.func_id == special_kfunc_list[KF_bpf_init_inode_xattr]) {
> +		if (env->cur_state->curframe != 0) {
> +			verbose(env, "bpf_init_inode_xattr cannot be called from subprograms\n");
> +			return -EINVAL;
> +		}
> +		env->needs_ctx_spill = true;
> +		insn_aux->init_inode_xattr_fixup = true;
> +		err = bpf_add_kfunc_call(env,
> +					 special_kfunc_list[KF_bpf_init_inode_xattr_impl], 0);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	if (is_bpf_rbtree_add_kfunc(meta.func_id)) {
>  		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
>  					 set_rbtree_add_callback_state);
> @@ -19272,6 +19299,33 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>  		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
>  		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
>  		*cnt = 6;
> +	} else if (env->insn_aux_data[insn_idx].init_inode_xattr_fixup) {
> +		struct bpf_kfunc_desc *impl_desc;
> +
> +		impl_desc = find_kfunc_desc(env->prog,
> +					    special_kfunc_list[KF_bpf_init_inode_xattr_impl], 0);
> +		if (!impl_desc) {
> +			verifier_bug(env, "bpf_init_inode_xattr_impl desc not found");
> +			return -EFAULT;
> +		}
> +
> +		/* Rewrite bpf_init_inode_xattr(name, value) to inject xattrs and
> +		 * xattr_count loaded from the saved inode_init_security ctx.
> +		 */
> +		insn_buf[0] = BPF_MOV64_REG(BPF_REG_3, BPF_REG_1);
> +		insn_buf[1] = BPF_MOV64_REG(BPF_REG_4, BPF_REG_2);
> +		insn_buf[2] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_FP,
> +					  env->ctx_stack_off);
> +		insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2,
> +					  3 * sizeof(u64));
> +		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_2,
> +					  4 * sizeof(u64));
> +		insn_buf[5] = *insn;
> +		if (!bpf_jit_supports_far_kfunc_call())
> +			insn_buf[5].imm = BPF_CALL_IMM(impl_desc->addr);
> +		else
> +			insn_buf[5].imm = impl_desc->func_id;
> +		*cnt = 6;
>  	}
>  
>  	if (env->insn_aux_data[insn_idx].arg_prog) {
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index 40efde233f3a..1e61baa821bd 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -28,8 +28,11 @@ static int __init bpf_lsm_init(void)
>  	return 0;
>  }
>  
> +#define BPF_LSM_INODE_INIT_XATTRS 1
> +
>  struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
>  	.lbs_inode = sizeof(struct bpf_storage_blob),
> +	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
>  };
>  
>  DEFINE_LSM(bpf) = {
> -- 
> 2.53.0
> 
