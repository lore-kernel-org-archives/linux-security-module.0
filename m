Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CF321420;
	Tue,  7 Jul 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452670; cv=none; b=hd8AnQ3MI62Puby9ZqxQ547EvMKBTxUpT3HxfjHvAbk1kzUxLI92lCX5/pGxRCO8tcrR7DOaxMmpTOjVP8hjRmcJn8tisJuI+KSW3FMPAcRGJI1CDWv2fuYapLix36FmLd4DiocyOSdR2actcGY7a5xku8r+sJJlFzRr7Xmhe4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452670; c=relaxed/simple;
	bh=hSQdWJS+N0/55cDUdSjCH2m64xaHUPGbS55bFWFO5vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lizQZWCMt9iQzshmee3JgTGXGF6UtfTrGdmXoFaxoXBntC0LNOCIb33nVcqJn8cTLNMGo023L9cHyfOfWCAP3uuSkIS8My6NhOT79LA89A9r3luvj6mckk7tp3nPMvjsNEo8kBUmrluNfwWtvaOgm1iKQCtGkMCZZb7ttFvZszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=hzWqcjKs; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hzWqcjKs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ao/ezOFGarR83cphRufBidamAK9/MpY0+ZnVwLTHT38=; b=hzWqcjKsYr+0bZIrqBxGHTTEgo
	8kQni2zpn3p3l+rmCBhpRMzt1OHUqWt6yNtBiRSYEQgOmIavcn+Vc4PscNzg+2r1g1PCogYteqoTV
	HPwsTrohLpLOxRIgSzTwjUswIWUbOu6qhSnegskfd8l5IvPUTnK4RdyWLFJ+z46wkmWvciw3qO1k6
	sm4u8hn8S2AqxP1ZxSTgNY6yJgasGCFaFy44MsHuYj6/jwc4ynhq3Vg32FL0yalyfNI2C6Uh2Uo5x
	k1UgA5r/oiJRUvc9fZDmbUtspWiCRvE2NH3+EsPnUxKVkygLOCjxkTPLXUL9BlS2+dLe3ES/hIj+L
	kxtDp1+A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whBVa-000LWY-2Z;
	Tue, 07 Jul 2026 21:31:06 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v5 1/8] bpf: Resolve and cache fd_array objects at load time
Date: Tue,  7 Jul 2026 21:30:57 +0200
Message-ID: <20260707193104.350066-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707193104.350066-1-daniel@iogearbox.net>
References: <20260707193104.350066-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28053/Tue Jul  7 08:24:37 2026)

The fd_array passed to BPF_PROG_LOAD carries the map and module BTF file
descriptors a program binds. The verifier reads it more than once during
a load: process_fd_array() walks it to bind the maps and BTFs, and
check_and_resolve_insns() and the kfunc BTF resolver later read it again
to resolve the program's BPF_PSEUDO_MAP_IDX* and module kfunc refs.

For signed BPF, we need these upfront in memory, thus resolve each fd to
its object once and cache it by fd_array index, then bind that cached
object for the rest of the load. env->fd_array becomes a small per-slot
{map, btf} cache rather than a bpfptr_t; every later reference is then
an in-bounds lookup of an already-resolved object, and an index outside
the cache is rejected instead of read from user memory:

  - continuous (fd_array_cnt given): the caller declares the length and
    every entry is resolved and bound up front (used also by the BPF
    signed loader)

  - sparse (no fd_array_cnt): left as the legacy path with no fd_array
    cache; each reference reads its fd from the caller's fd_array and
    resolves it on the spot. Deduplication in used_maps and the kfunc BTF
    table keeps this correct, and only unsigned programs use this shape.

Split these into separate helpers to make it easier to follow.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/linux/bpf_verifier.h |  22 +++-
 kernel/bpf/verifier.c        | 223 +++++++++++++++++++++++++++--------
 2 files changed, 193 insertions(+), 52 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 76b8b7627a10..bb57773cde37 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -898,6 +898,14 @@ struct bpf_scc_info {
 
 struct bpf_liveness;
 
+struct bpf_fd_array {
+	union {
+		struct bpf_map *map;
+		struct btf *btf;
+		unsigned long val;
+	};
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -989,7 +997,19 @@ struct bpf_verifier_env {
 	u32 free_list_size;
 	u32 explored_states_size;
 	u32 num_backedges;
-	bpfptr_t fd_array;
+	/*
+	 * The program's fd_array comes in two shapes, told apart by whether
+	 * the caller passed fd_array_cnt. They are mutually exclusive:
+	 *  - continuous (fd_array_cnt given): ->fd_array holds every entry
+	 *    resolved to its object up front, indexed by fd_array position,
+	 *    with ->fd_array_cnt slots; ->fd_array_raw is unused.
+	 *  - sparse (no fd_array_cnt): ->fd_array is NULL, and entries are
+	 *    read from ->fd_array_raw (the caller's fd_array) and resolved
+	 *    on the spot at each reference.
+	 */
+	struct bpf_fd_array *fd_array;
+	u32 fd_array_cnt;
+	bpfptr_t fd_array_raw;
 
 	/* bit mask to keep track of whether a register has been accessed
 	 * since the last time the function state was printed
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3193b473762b..2e9e65297c70 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2490,6 +2490,79 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 	return 0;
 }
 
+#define BPF_FD_SLOT_BTF	1UL
+
+static void fd_slot_set_map(struct bpf_fd_array *slot, struct bpf_map *map)
+{
+	slot->val = (unsigned long)map;
+}
+
+static void fd_slot_set_btf(struct bpf_fd_array *slot, struct btf *btf)
+{
+	slot->val = (unsigned long)btf | BPF_FD_SLOT_BTF;
+}
+
+static struct bpf_map *fd_slot_map(struct bpf_fd_array slot)
+{
+	if (slot.val & BPF_FD_SLOT_BTF)
+		return NULL;
+	return (struct bpf_map *)slot.val;
+}
+
+static struct btf *fd_slot_btf(struct bpf_fd_array slot)
+{
+	if (!(slot.val & BPF_FD_SLOT_BTF))
+		return NULL;
+	return (struct btf *)(slot.val & ~BPF_FD_SLOT_BTF);
+}
+
+static struct btf *
+fd_array_get_btf_continuous(struct bpf_verifier_env *env, u32 idx)
+{
+	struct btf *btf;
+
+	if (idx >= env->fd_array_cnt) {
+		verbose(env, "kfunc fd_idx %u out of bounds, fd_array_cnt %u\n",
+			idx, env->fd_array_cnt);
+		return ERR_PTR(-EINVAL);
+	}
+	btf = fd_slot_btf(env->fd_array[idx]);
+	if (!btf) {
+		verbose(env, "kfunc fd_idx %u is not a module BTF\n", idx);
+		return ERR_PTR(-EINVAL);
+	}
+	btf_get(btf);
+	return btf;
+}
+
+static struct btf *
+fd_array_get_btf_sparse(struct bpf_verifier_env *env, u32 idx)
+{
+	struct btf *btf;
+	int btf_fd;
+
+	if (copy_from_bpfptr_offset(&btf_fd, env->fd_array_raw,
+				    (size_t)idx * sizeof(btf_fd), sizeof(btf_fd)))
+		return ERR_PTR(-EFAULT);
+	btf = btf_get_by_fd(btf_fd);
+	if (IS_ERR(btf)) {
+		verbose(env, "invalid module BTF fd specified\n");
+		return btf;
+	}
+	return btf;
+}
+
+static struct btf *fd_array_get_btf(struct bpf_verifier_env *env, u32 idx)
+{
+	if (env->fd_array)
+		return fd_array_get_btf_continuous(env, idx);
+	if (!bpfptr_is_null(env->fd_array_raw))
+		return fd_array_get_btf_sparse(env, idx);
+
+	verbose(env, "kfunc offset > 0 without fd_array is invalid\n");
+	return ERR_PTR(-EPROTO);
+}
+
 static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 					 s16 offset)
 {
@@ -2498,7 +2571,6 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 	struct bpf_kfunc_btf *b;
 	struct module *mod;
 	struct btf *btf;
-	int btf_fd;
 
 	tab = env->prog->aux->kfunc_btf_tab;
 	b = bsearch(&kf_btf, tab->descs, tab->nr_descs,
@@ -2509,22 +2581,9 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
 			return ERR_PTR(-E2BIG);
 		}
 
-		if (bpfptr_is_null(env->fd_array)) {
-			verbose(env, "kfunc offset > 0 without fd_array is invalid\n");
-			return ERR_PTR(-EPROTO);
-		}
-
-		if (copy_from_bpfptr_offset(&btf_fd, env->fd_array,
-					    offset * sizeof(btf_fd),
-					    sizeof(btf_fd)))
-			return ERR_PTR(-EFAULT);
-
-		btf = btf_get_by_fd(btf_fd);
-		if (IS_ERR(btf)) {
-			verbose(env, "invalid module BTF fd specified\n");
+		btf = fd_array_get_btf(env, offset);
+		if (IS_ERR(btf))
 			return btf;
-		}
-
 		if (!btf_is_module(btf)) {
 			verbose(env, "BTF fd for kfunc is not a module BTF\n");
 			btf_put(btf);
@@ -17921,6 +17980,44 @@ static int add_used_map(struct bpf_verifier_env *env, int fd)
 	return __add_used_map(env, map);
 }
 
+static int fd_array_get_map_idx_continuous(struct bpf_verifier_env *env, u32 idx)
+{
+	struct bpf_map *map;
+
+	if (idx >= env->fd_array_cnt) {
+		verbose(env, "fd_idx %u out of bounds, fd_array_cnt %u\n",
+			idx, env->fd_array_cnt);
+		return -EINVAL;
+	}
+	map = fd_slot_map(env->fd_array[idx]);
+	if (!map) {
+		verbose(env, "fd_idx %u is not a map\n", idx);
+		return -EINVAL;
+	}
+	return __add_used_map(env, map);
+}
+
+static int fd_array_get_map_idx_sparse(struct bpf_verifier_env *env, u32 idx)
+{
+	int fd;
+
+	if (copy_from_bpfptr_offset(&fd, env->fd_array_raw,
+				    (size_t)idx * sizeof(fd), sizeof(fd)))
+		return -EFAULT;
+	return add_used_map(env, fd);
+}
+
+static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
+{
+	if (env->fd_array)
+		return fd_array_get_map_idx_continuous(env, idx);
+	if (!bpfptr_is_null(env->fd_array_raw))
+		return fd_array_get_map_idx_sparse(env, idx);
+
+	verbose(env, "fd_idx without fd_array is invalid\n");
+	return -EPROTO;
+}
+
 static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	u8 class = BPF_CLASS(insn->code);
@@ -18138,7 +18235,6 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 			struct bpf_map *map;
 			int map_idx;
 			u64 addr;
-			u32 fd;
 
 			if (i == insn_cnt - 1 || insn[1].code != 0 ||
 			    insn[1].dst_reg != 0 || insn[1].src_reg != 0 ||
@@ -18190,21 +18286,13 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
 			switch (insn[0].src_reg) {
 			case BPF_PSEUDO_MAP_IDX_VALUE:
 			case BPF_PSEUDO_MAP_IDX:
-				if (bpfptr_is_null(env->fd_array)) {
-					verbose(env, "fd_idx without fd_array is invalid\n");
-					return -EPROTO;
-				}
-				if (copy_from_bpfptr_offset(&fd, env->fd_array,
-							    insn[0].imm * sizeof(fd),
-							    sizeof(fd)))
-					return -EFAULT;
+				map_idx = fd_array_get_map_idx(env, insn[0].imm);
 				break;
 			default:
-				fd = insn[0].imm;
+				map_idx = add_used_map(env, insn[0].imm);
 				break;
 			}
 
-			map_idx = add_used_map(env, fd);
 			if (map_idx < 0)
 				return map_idx;
 			map = env->used_maps[map_idx];
@@ -19479,7 +19567,7 @@ struct btf *bpf_get_btf_vmlinux(void)
  * this case expect that every file descriptor in the array is either a map or
  * a BTF. Everything else is considered to be trash.
  */
-static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
+static int add_fd_from_fd_array(struct bpf_verifier_env *env, u32 idx, int fd)
 {
 	struct bpf_map *map;
 	struct btf *btf;
@@ -19491,51 +19579,83 @@ static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
 		err = __add_used_map(env, map);
 		if (err < 0)
 			return err;
+		fd_slot_set_map(&env->fd_array[idx], map);
 		return 0;
 	}
 
 	btf = __btf_get_by_fd(f);
 	if (!IS_ERR(btf)) {
 		btf_get(btf);
-		return __add_used_btf(env, btf);
+		err = __add_used_btf(env, btf);
+		if (err < 0)
+			return err;
+		fd_slot_set_btf(&env->fd_array[idx], btf);
+		return 0;
 	}
 
 	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
 	return PTR_ERR(map);
 }
 
-static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
+/*
+ * A continuous fd_array is resolved into an in-memory cache with one slot
+ * per entry. The bound here is deliberately generous and not derived from
+ * the per-program object limits: Duplicate entries /are/ permitted, and
+ * the number of distinct maps and BTFs a program can bind is enforced when
+ * each entry is resolved by __add_used_map() and __add_used_btf().
+ */
+#define MAX_FD_ARRAY_CNT 4096
+
+static int process_fd_array_continuous(struct bpf_verifier_env *env,
+				       bpfptr_t fd_array, u32 cnt)
 {
-	size_t size = sizeof(int);
-	int ret;
-	int fd;
+	int fd, ret;
 	u32 i;
 
-	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
-
-	/*
-	 * The only difference between old (no fd_array_cnt is given) and new
-	 * APIs is that in the latter case the fd_array is expected to be
-	 * continuous and is scanned for map fds right away
-	 */
-	if (!attr->fd_array_cnt)
-		return 0;
-
-	/* Check for integer overflow */
-	if (attr->fd_array_cnt >= (U32_MAX / size)) {
-		verbose(env, "fd_array_cnt is too big (%u)\n", attr->fd_array_cnt);
-		return -EINVAL;
+	if (cnt > MAX_FD_ARRAY_CNT) {
+		verbose(env, "fd_array has too many entries (%u, max %u)\n",
+			cnt, MAX_FD_ARRAY_CNT);
+		return -E2BIG;
 	}
 
-	for (i = 0; i < attr->fd_array_cnt; i++) {
-		if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
+	env->fd_array = kvcalloc(cnt, sizeof(*env->fd_array),
+				 GFP_KERNEL_ACCOUNT);
+	if (!env->fd_array)
+		return -ENOMEM;
+	env->fd_array_cnt = cnt;
+	for (i = 0; i < cnt; i++) {
+		if (copy_from_bpfptr_offset(&fd, fd_array,
+					    (size_t)i * sizeof(fd), sizeof(fd)))
 			return -EFAULT;
-
-		ret = add_fd_from_fd_array(env, fd);
+		ret = add_fd_from_fd_array(env, i, fd);
 		if (ret)
 			return ret;
 	}
+	return 0;
+}
 
+static int process_fd_array(struct bpf_verifier_env *env,
+			    union bpf_attr *attr, bpfptr_t uattr)
+{
+	bpfptr_t fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
+
+	if (bpfptr_is_null(fd_array)) {
+		if (attr->fd_array_cnt) {
+			verbose(env, "fd_array_cnt %u without fd_array is invalid\n",
+				attr->fd_array_cnt);
+			return -EINVAL;
+		}
+		return 0;
+	}
+	/*
+	 * New API: the caller passes fd_array_cnt and a continuous array that
+	 * is resolved and bound up front. Legacy API (no fd_array_cnt): keep
+	 * the caller's array and resolve entries on the spot at each reference.
+	 */
+	if (attr->fd_array_cnt)
+		return process_fd_array_continuous(env, fd_array,
+						   attr->fd_array_cnt);
+	env->fd_array_raw = fd_array;
 	return 0;
 }
 
@@ -20036,6 +20156,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 		mutex_unlock(&bpf_verifier_lock);
 	bpf_clear_insn_aux_data(env, 0, env->prog->len);
 err_free_env:
+	kvfree(env->fd_array);
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
-- 
2.43.0

