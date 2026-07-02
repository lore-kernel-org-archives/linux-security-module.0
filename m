Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AEF353A69
	for <linux-security-module@vger.kernel.org>; Thu,  2 Jul 2026 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783018617; cv=none; b=Y5DYmBXtI/j/FsCMh94Oz4gMGyaGhU4d4zsH46KOCQhZb0j8FOLyiwwVynyf23lfIMDvopMrmjt4XalZIKetRISO+NyIj9U0jNBm58US9kX2ExKauHYlWxcgmGQ8uhm4Cm/b1HYfQO+RtzeO09Fawa/vgGEFrYq8EeXSk6IMSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783018617; c=relaxed/simple;
	bh=BJZSNWe1eKwX18Jr7q8wXyiub+GA47eG9NAgEDCB3nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsQ9zSrBcfFKiK+oYJVvijCo2wEZymDx64CyEQf1QGZUUEIvddtiHUxwTsYy70WnbKWEjn0/DPRz9HIqsm6tC5QgLLoRUHndh97Xqp4z1XtSnnDtEZl/w32R2c60s/xfvXosDO516FtcrdFbxJjZ5nb98K+0yC1h0bBjO2hQzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoIOemSY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoIOemSY"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46ed4f66256so1842110f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 02 Jul 2026 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783018613; x=1783623413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CX7nVHkWBuiGfGJJF12IiaJ3vVDqIFPjV+5xgb28ekA=;
        b=SoIOemSY9zoimYQGKIdH8y0NWNZgDX8AfUc68VL+oF3K1ZcPgJhZytMXxUhIh5AWwr
         idBPVmOHTLPW5U6V+ACANcnV23QQJQYTRd6+PAvtCYBr5+44IO8j5kCQyBo2sPfoQvUw
         p3KBuS6b1Vywc/k0Tj8Ch1z47qZXLybFFvuxdqQa7Py3rIsi10J2eVDZeSIwRdlrwjVS
         gQQDOyxVLqCNSVr0HRpx/dNvsWCSDTNKN8lG0QZ33fWUnjnNZ3RbMO9i/Zy02MKngwc4
         /kGmFEPCNRd9/VQ4hSKUnYm/xZlGMAYHVvMCjjxh2PrlOhvtMRgzPHRbP+WWRxDXo119
         VQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783018613; x=1783623413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CX7nVHkWBuiGfGJJF12IiaJ3vVDqIFPjV+5xgb28ekA=;
        b=QPlm681wEAoqCA/1iq4ZPyGYRv5iv00IqgY7NdWr8tRzLrjI87fEugJLW2LSlEH13L
         TtDEJ3LkJgO9hFaisp60A4n2kqi3EkXHVyZB2bGiSARaTzl1gmGrY2TRT/xw16Qw5s3f
         OvRIi43I7Ukmy2l1gLMSQnES1HzrcN20B0f0n+HoPB45kgzDYj2lobD9mzcQlbytQFfL
         mRqmXHb8/iro+SB6ArxO/iU87PDUj3VFM84znCO2ezab+PTqS/NfxsFgSlT11civ6Oih
         zuTBeWw+9ONEpnk0sV4QmugmXJ3jYT1yzwOMpChUNc5JJtMXxAWM+HQdDEedAbY3c1rs
         zWyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4690Ve+cP32h7bPLVe8s0Ah4kozHqm8b6lLqtPfCPXxixuC/ntLBlRCd94YVjvTB01MYUuQ8wPY3R7JS1VYtt1h9UHdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuRxbya0v2ubHc89OjPvFncT8OtfpKogansY+VV7hVj2S3VHb
	IFNilh51PGZx31Rt58L//3vsP2Ejf4LaA8pLd/6KLfbyk8BJ6eXYXlRK
X-Gm-Gg: AfdE7cldstNxlx0foMkLCABZZcQ+Rk2cgDeFZh4lnb/1oOgjh3NgeSMypPmwmDaluoy
	aWiUd4BtaH26raXdyzbcnZb1I+NuHpNd+hvi8aYX6dFafvdUVbZkmCtEMVnH17DECVAsXbgyqRs
	tDDiIOC0bcP0fIV2Bi4vhqQjoPMgyAJJ36QJHA/qMU1A1PkZpLFimFxnc3KLuVfaO2dupcDDV2J
	TSAdBOYY2A6Wm1IOaa9/oiPlDJQo++KkpJy4bj3BkvSMCEuc74rRLQyTlUdwYRgj1Op1cd2FKBG
	oC0OroVPWV7BwB08devnnXl520M1AU6xYNV821J+McFTd6R8tbiUE3lmu7Th0i67Xh08e1HvYq0
	ZI+R1bcXeShB86ERIDjR8lgVd0C9RVPXNUGEqd0hJOadeTP6Kb0JRuIKbIXIszCABhe3vboUlh9
	r+BUxktHiGr3jwSifC6itMAw==
X-Received: by 2002:adf:ea82:0:b0:475:a4ae:e630 with SMTP id ffacd0b85a97d-4775be03177mr9025805f8f.37.1783018613260;
        Thu, 02 Jul 2026 11:56:53 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4a09sm11719540f8f.13.2026.07.02.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:56:52 -0700 (PDT)
Date: Thu, 2 Jul 2026 19:06:49 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com, paul@paul-moore.com,
	bboscaccy@linux.microsoft.com, memxor@gmail.com,
	torvalds@linux-foundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Resolve and cache fd_array objects
 at load time
Message-ID: <aka2yR6IUZMAOUwJ@mail.gmail.com>
References: <20260702143605.252797-1-daniel@iogearbox.net>
 <20260702143605.252797-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702143605.252797-2-daniel@iogearbox.net>

On 26/07/02 04:36PM, Daniel Borkmann wrote:
> The fd_array passed to BPF_PROG_LOAD carries the map and module BTF file
> descriptors a program binds. The verifier reads it more than once during
> a load: process_fd_array() walks it to bind the maps and BTFs, and
> check_and_resolve_insns() and the kfunc BTF resolver later read it again
> to resolve the program's BPF_PSEUDO_MAP_IDX and module kfunc refs.
> 
> For signed BPF, we need these upfront in memory, thus resolve each fd to
> its object once and cache it by fd_array index, then bind that cached
> object for the rest of the load. env->fd_array becomes a small per-slot
> {map, btf} cache rather than a bpfptr_t; every later reference is then
> an in-bounds lookup of an already-resolved object, and an index outside
> the cache is rejected instead of read from user memory:
> 
>   - continuous (fd_array_cnt given): the caller declares the length and
>     every entry is resolved and bound up front (used also by signed loader)
> 
>   - sparse (no fd_array_cnt): left as the legacy path with no fd_array
>     cache; each reference reads its fd from the caller's fd_array and
>     resolves it on the spot. Deduplication in used_maps and the kfunc BTF
>     table keeps this correct, and only unsigned programs use this shape.
> 
> UAPI-wise nothing changes, its just the internals on how BPF processes
> and caches the fd_array favors. Split these into separate helpers for
> continuous versus sparse to make it easier to follow.

Overall looks ok. A few comments below.

> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  22 +++-
>  kernel/bpf/verifier.c        | 209 ++++++++++++++++++++++++++---------
>  2 files changed, 179 insertions(+), 52 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 76b8b7627a10..9f0a4e9a15d7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -898,6 +898,14 @@ struct bpf_scc_info {
>  
>  struct bpf_liveness;
>  
> +struct bpf_fd_array {
> +	union {
> +		struct bpf_map *map;
> +		struct btf *btf;
> +		unsigned long val;
> +	};
> +};
> +
>  /* single container for all structs
>   * one verifier_env per bpf_check() call
>   */
> @@ -989,7 +997,19 @@ struct bpf_verifier_env {
>  	u32 free_list_size;
>  	u32 explored_states_size;
>  	u32 num_backedges;
> -	bpfptr_t fd_array;
> +	/*
> +	 * The program's fd_array comes in two shapes, told apart by whether
> +	 * the caller passed fd_array_cnt. They are mutually exclusive:
> +	 *  - continuous (fd_array_cnt given): ->fd_array holds every entry
> +	 *    resolved to its object up front, indexed by fd_array position,
> +	 *    with ->fd_array_cnt slots; ->fd_array_raw is unused.
> +	 *  - sparse (no fd_array_cnt): ->fd_array is NULL, and entries are
> +	 *    read from ->fd_array_raw (the caller's fd_array) and resolved
> +	 *    lazily on first reference.
> +	 */
> +	struct bpf_fd_array *fd_array;
> +	u32 fd_array_cnt;
> +	bpfptr_t fd_array_raw;
>  
>  	/* bit mask to keep track of whether a register has been accessed
>  	 * since the last time the function state was printed
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 25aea4271cd0..44bb6ce17a1c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2490,6 +2490,79 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
>  	return 0;
>  }
>  
> +#define BPF_FD_SLOT_BTF	1UL
> +
> +static void fd_slot_set_map(struct bpf_fd_array *slot, struct bpf_map *map)
> +{
> +	slot->val = (unsigned long)map;
> +}
> +
> +static void fd_slot_set_btf(struct bpf_fd_array *slot, struct btf *btf)
> +{
> +	slot->val = (unsigned long)btf | BPF_FD_SLOT_BTF;
> +}
> +
> +static struct bpf_map *fd_slot_map(struct bpf_fd_array slot)
> +{
> +	if (slot.val & BPF_FD_SLOT_BTF)
> +		return NULL;
> +	return (struct bpf_map *)slot.val;
> +}
> +
> +static struct btf *fd_slot_btf(struct bpf_fd_array slot)
> +{
> +	if (!(slot.val & BPF_FD_SLOT_BTF))
> +		return NULL;
> +	return (struct btf *)(slot.val & ~BPF_FD_SLOT_BTF);
> +}
> +
> +static struct btf *
> +fd_array_get_btf_continuous(struct bpf_verifier_env *env, u32 idx)
> +{
> +	struct btf *btf;
> +
> +	if (idx >= env->fd_array_cnt) {
> +		verbose(env, "kfunc fd_idx %u out of bounds, fd_array_cnt %u\n",
> +			idx, env->fd_array_cnt);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	btf = fd_slot_btf(env->fd_array[idx]);
> +	if (!btf) {
> +		verbose(env, "kfunc fd_idx %u is not a module BTF\n", idx);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	btf_get(btf);
> +	return btf;
> +}
> +
> +static struct btf *
> +fd_array_get_btf_sparse(struct bpf_verifier_env *env, u32 idx)
> +{
> +	struct btf *btf;
> +	int btf_fd;
> +
> +	if (copy_from_bpfptr_offset(&btf_fd, env->fd_array_raw,
> +				    (size_t)idx * sizeof(btf_fd), sizeof(btf_fd)))
> +		return ERR_PTR(-EFAULT);
> +	btf = btf_get_by_fd(btf_fd);
> +	if (IS_ERR(btf)) {
> +		verbose(env, "invalid module BTF fd specified\n");
> +		return btf;
> +	}
> +	return btf;
> +}
> +
> +static struct btf *fd_array_get_btf(struct bpf_verifier_env *env, u32 idx)
> +{
> +	if (env->fd_array)
> +		return fd_array_get_btf_continuous(env, idx);
> +	if (!bpfptr_is_null(env->fd_array_raw))
> +		return fd_array_get_btf_sparse(env, idx);
> +
> +	verbose(env, "kfunc offset > 0 without fd_array is invalid\n");
> +	return ERR_PTR(-EPROTO);
> +}
> +
>  static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  					 s16 offset)
>  {
> @@ -2498,7 +2571,6 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  	struct bpf_kfunc_btf *b;
>  	struct module *mod;
>  	struct btf *btf;
> -	int btf_fd;
>  
>  	tab = env->prog->aux->kfunc_btf_tab;
>  	b = bsearch(&kf_btf, tab->descs, tab->nr_descs,
> @@ -2509,22 +2581,9 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  			return ERR_PTR(-E2BIG);
>  		}
>  
> -		if (bpfptr_is_null(env->fd_array)) {
> -			verbose(env, "kfunc offset > 0 without fd_array is invalid\n");
> -			return ERR_PTR(-EPROTO);
> -		}
> -
> -		if (copy_from_bpfptr_offset(&btf_fd, env->fd_array,
> -					    offset * sizeof(btf_fd),
> -					    sizeof(btf_fd)))
> -			return ERR_PTR(-EFAULT);
> -
> -		btf = btf_get_by_fd(btf_fd);
> -		if (IS_ERR(btf)) {
> -			verbose(env, "invalid module BTF fd specified\n");
> +		btf = fd_array_get_btf(env, offset);
> +		if (IS_ERR(btf))
>  			return btf;
> -		}
> -
>  		if (!btf_is_module(btf)) {
>  			verbose(env, "BTF fd for kfunc is not a module BTF\n");
>  			btf_put(btf);
> @@ -17911,6 +17970,44 @@ static int add_used_map(struct bpf_verifier_env *env, int fd)
>  	return __add_used_map(env, map);
>  }
>  
> +static int fd_array_get_map_idx_continuous(struct bpf_verifier_env *env, u32 idx)
> +{
> +	struct bpf_map *map;
> +
> +	if (idx >= env->fd_array_cnt) {
> +		verbose(env, "fd_idx %u out of bounds, fd_array_cnt %u\n",
> +			idx, env->fd_array_cnt);
> +		return -EINVAL;
> +	}
> +	map = fd_slot_map(env->fd_array[idx]);
> +	if (!map) {
> +		verbose(env, "fd_idx %u is not a map\n", idx);
> +		return -EINVAL;
> +	}
> +	return __add_used_map(env, map);
> +}
> +
> +static int fd_array_get_map_idx_sparse(struct bpf_verifier_env *env, u32 idx)
> +{
> +	int fd;
> +
> +	if (copy_from_bpfptr_offset(&fd, env->fd_array_raw,
> +				    (size_t)idx * sizeof(fd), sizeof(fd)))
> +		return -EFAULT;
> +	return add_used_map(env, fd);
> +}
> +
> +static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
> +{
> +	if (env->fd_array)
> +		return fd_array_get_map_idx_continuous(env, idx);
> +	if (!bpfptr_is_null(env->fd_array_raw))
> +		return fd_array_get_map_idx_sparse(env, idx);
> +
> +	verbose(env, "fd_idx without fd_array is invalid\n");
> +	return -EPROTO;
> +}
> +
>  static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
>  	u8 class = BPF_CLASS(insn->code);
> @@ -18128,7 +18225,6 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>  			struct bpf_map *map;
>  			int map_idx;
>  			u64 addr;
> -			u32 fd;
>  
>  			if (i == insn_cnt - 1 || insn[1].code != 0 ||
>  			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
> @@ -18180,21 +18276,13 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>  			switch (insn[0].src_reg) {
>  			case BPF_PSEUDO_MAP_IDX_VALUE:
>  			case BPF_PSEUDO_MAP_IDX:
> -				if (bpfptr_is_null(env->fd_array)) {
> -					verbose(env, "fd_idx without fd_array is invalid\n");
> -					return -EPROTO;
> -				}
> -				if (copy_from_bpfptr_offset(&fd, env->fd_array,
> -							    insn[0].imm * sizeof(fd),
> -							    sizeof(fd)))
> -					return -EFAULT;
> +				map_idx = fd_array_get_map_idx(env, insn[0].imm);
>  				break;
>  			default:
> -				fd = insn[0].imm;
> +				map_idx = add_used_map(env, insn[0].imm);
>  				break;
>  			}
>  
> -			map_idx = add_used_map(env, fd);
>  			if (map_idx < 0)
>  				return map_idx;
>  			map = env->used_maps[map_idx];
> @@ -19469,7 +19557,7 @@ struct btf *bpf_get_btf_vmlinux(void)
>   * this case expect that every file descriptor in the array is either a map or
>   * a BTF. Everything else is considered to be trash.
>   */
> -static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, u32 idx, int fd)
>  {
>  	struct bpf_map *map;
>  	struct btf *btf;
> @@ -19481,51 +19569,69 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
>  		err = __add_used_map(env, map);
>  		if (err < 0)
>  			return err;
> +		fd_slot_set_map(&env->fd_array[idx], map);
>  		return 0;
>  	}
>  
>  	btf = __btf_get_by_fd(f);
>  	if (!IS_ERR(btf)) {
>  		btf_get(btf);
> -		return __add_used_btf(env, btf);
> +		err = __add_used_btf(env, btf);
> +		if (err < 0)
> +			return err;
> +		fd_slot_set_btf(&env->fd_array[idx], btf);
> +		return 0;
>  	}
>  
>  	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
>  	return PTR_ERR(map);
>  }
>  
> -static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> +#define MAX_FD_ARRAY_CNT (MAX_USED_MAPS + MAX_KFUNC_BTFS)
> +
> +static int process_fd_array_continuous(struct bpf_verifier_env *env,
> +				       bpfptr_t fd_array, u32 cnt)
>  {
> -	size_t size = sizeof(int);
> -	int ret;
> -	int fd;
> +	int fd, ret;
>  	u32 i;
>  
> -	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> -
> -	/*
> -	 * The only difference between old (no fd_array_cnt is given) and new
> -	 * APIs is that in the latter case the fd_array is expected to be
> -	 * continuous and is scanned for map fds right away
> -	 */
> -	if (!attr->fd_array_cnt)
> -		return 0;
> -
> -	/* Check for integer overflow */
> -	if (attr->fd_array_cnt >= (U32_MAX / size)) {
> -		verbose(env, "fd_array_cnt is too big (%u)\n", attr->fd_array_cnt);
> -		return -EINVAL;
> +	if (cnt > MAX_FD_ARRAY_CNT) {

So, I _think_ I've done the "unlimited" thing because there can be duplicates
in fd_array. The limit is actually tracked by __add_{map_btf} So here we hard
limit on the size of the fd_array itself. (Even without duplicates, this
fd_array can contain, say, MAX_KFUNC_BTFS different maps, which will be in any
case rejected by __add_used_map.)

> +		verbose(env, "fd_array has too many entries (%u, max %u)\n",
> +			cnt, MAX_FD_ARRAY_CNT);
> +		return -E2BIG;
>  	}
>  
> -	for (i = 0; i < attr->fd_array_cnt; i++) {
> -		if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
> +	env->fd_array = kvcalloc(cnt, sizeof(*env->fd_array), GFP_KERNEL);
> +	if (!env->fd_array)
> +		return -ENOMEM;
> +	env->fd_array_cnt = cnt;
> +	for (i = 0; i < cnt; i++) {
> +		if (copy_from_bpfptr_offset(&fd, fd_array,
> +					    (size_t)i * sizeof(fd), sizeof(fd)))
>  			return -EFAULT;
> -
> -		ret = add_fd_from_fd_array(env, fd);
> +		ret = add_fd_from_fd_array(env, i, fd);
>  		if (ret)
>  			return ret;
>  	}
> +	return 0;
> +}
>  
> +static int process_fd_array(struct bpf_verifier_env *env,
> +			    union bpf_attr *attr, bpfptr_t uattr)
> +{
> +	bpfptr_t fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> +
> +	if (bpfptr_is_null(fd_array))
> +		return 0;
> +	/*
> +	 * New API: the caller passes fd_array_cnt and a continuous array that
> +	 * is resolved and bound up front. Legacy API (no fd_array_cnt): keep
> +	 * the caller's array and resolve entries lazily, on first reference.
> +	 */
> +	if (attr->fd_array_cnt)
> +		return process_fd_array_continuous(env, fd_array,
> +						   attr->fd_array_cnt);

Looks like this returns success in case (!fd_array && attr->fd_array_cnt),
which is a misconfiguration and should be rejected.

> +	env->fd_array_raw = fd_array;
>  	return 0;
>  }
>  
> @@ -20027,6 +20133,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	bpf_clear_insn_aux_data(env, 0, env->prog->len);
>  	vfree(env->insn_aux_data);
>  err_free_env:
> +	kvfree(env->fd_array);
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
>  	kvfree(env->scc_info);
> -- 
> 2.43.0
> 
