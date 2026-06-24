Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F702D7DDD;
	Wed, 24 Jun 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311245; cv=none; b=GK7DlCP5ZuF7ByAAAB1tyqERRh3VNW82Pj6b+2h3RQhn7CAsJpjL1zNTTdx2d54f8CSmCOJ51xlIpPsrx6QyhN/2BuQADGxTt/6U8mfaqqAG3q1rUenxsBl6VXgYOzja9N8ownKX8s/t94gJ3FYBnvbEf+bpb20RH5YJiR7wE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311245; c=relaxed/simple;
	bh=S8OV3YQBS1JKGI7IxG325bh8G4Rtqxi0cIBgmXJHE7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciaYi78dyG9iBv2YP3GH98crW/y9utGZ2CtU0ojEsRa9Y10UtskM604KcTZc3MbgAekS5JhNEtb6193n+53YWJhjMu5IV6+Sddpl/peq0eyIA3ws3c3UnmWoIVIk8V5AjUuudxyVcQlZoDS5etFFEiuX5zQmK0wHh8AaQLTdo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=J1Vdvo8t; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="J1Vdvo8t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qkCfQ1oo2FkLLf5KISLjpw1Bftc1Hs9NWUQGr7VOTZU=; b=J1Vdvo8tkWAGh6UKVLa76LKjTB
	qzDQfuGQcAUNgiyDkUwAgINHVZoknb8Zew+Kj8vOMMQV8g5cueXanOsgynyHE14CdX0ohCyrlY4gX
	DOrP66X/lR6tKnUcJgiUNowXrT/ImHBKhLBG5nAiJeFIHBSvOqbhTM6GZTWEz6yG8y+7oUG5K+DIX
	IsdxmayVq03RtltoGJIYUewdRGpttni2TTb/y1vLUuCzvmpIB1Szh1NmboaivQB+AERONlq1TVP/w
	praCGmPS0mP96kbQLglZxXyUNvL/rG8RlWuknToW3bheHTIyZ+S9fPzHLYKcDS+IVlA9jt/V7rUnv
	wKM9q0eg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcOC0-000GHx-1E;
	Wed, 24 Jun 2026 16:03:04 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 2/5] libbpf: Drop in-loader metadata check for load-time verification
Date: Wed, 24 Jun 2026 16:02:58 +0200
Message-ID: <20260624140301.93421-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624140301.93421-1-daniel@iogearbox.net>
References: <20260624140301.93421-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)

The signed gen_loader used to police its own metadata map from within
BPF: emit_signature_match() read the kernel-cached map->sha[] back
through hardcoded struct bpf_map offsets and compared it against a hash
that compute_sha_update_offsets() baked into the signed instructions,
after a BPF_OBJ_GET_INFO_BY_FD round-trip to populate map->sha[].

The kernel now verifies the metadata at BPF_PROG_LOAD time by folding
the frozen contents of the loader's exclusive fd_array maps into the
signature, so the loader no longer checks anything itself. Generated
loaders thus carry no verification logic of their own anymore: Nothing
in the signing chain depends on emitted loader bytecode doing the right
thing.

On the loading side, skel_internal.h now sets fd_array_cnt for a signed
load so the kernel scans fd_array for the exclusive metadata map -
still frozen, as the kernel requires - and the BPF_OBJ_GET_INFO_BY_FD
round-trip to populate map->sha[] is gone. The struct bpf_map layout
BUILD_BUG_ON()s on the kernel side are removed as well: they only
pinned the ABI for the in-BPF read of map->sha[] that is no longer
needed. Note: gen_hash is retained; it still marks a loader as signed
so an untrusted host cannot re-dimension maps or override initial
values now covered by the signature.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/syscall.c             |  5 ---
 tools/lib/bpf/bpf_gen_internal.h |  1 -
 tools/lib/bpf/gen_loader.c       | 76 +++-----------------------------
 tools/lib/bpf/skel_internal.h    | 27 +-----------
 4 files changed, 9 insertions(+), 100 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 026b61d78bdb..3eeeaf62c456 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1599,11 +1599,6 @@ static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_ver
 			goto free_map;
 		}
 
-		/* See libbpf: emit_signature_match() */
-		BUILD_BUG_ON(offsetof(struct bpf_map, excl) != SHA256_DIGEST_SIZE);
-		BUILD_BUG_ON(!__same_type(map->excl, u32));
-		BUILD_BUG_ON(offsetof(struct bpf_map, sha)  != 0);
-		BUILD_BUG_ON(!__same_type(map->sha, u8[SHA256_DIGEST_SIZE]));
 		map->excl = 1;
 	} else if (attr->excl_prog_hash_size) {
 		bpf_log(log, "Invalid excl_prog_hash_size.\n");
diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 49af4260b8e6..042569187752 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -51,7 +51,6 @@ struct bpf_gen {
 	__u32 nr_ksyms;
 	int fd_array;
 	int nr_fd_array;
-	int hash_insn_offset[SHA256_DWORD_SIZE];
 };
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index d79695f01c87..baed23850997 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -111,7 +111,6 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
-static void emit_signature_match(struct bpf_gen *gen);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
@@ -154,8 +153,6 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
-	if (OPTS_GET(gen->opts, gen_hash, false))
-		emit_signature_match(gen);
 }
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -377,8 +374,6 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
 	__emit_sys_close(gen);
 }
 
-static void compute_sha_update_offsets(struct bpf_gen *gen);
-
 int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 {
 	int i;
@@ -408,9 +403,6 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 	if (!gen->error) {
 		struct gen_loader_opts *opts = gen->opts;
 
-		if (OPTS_GET(opts, gen_hash, false))
-			compute_sha_update_offsets(gen);
-
 		opts->insns = gen->insn_start;
 		opts->insns_sz = gen->insn_cur - gen->insn_start;
 		opts->data = gen->data_start;
@@ -460,22 +452,6 @@ void bpf_gen__free(struct bpf_gen *gen)
 	_val;							\
 })
 
-static void compute_sha_update_offsets(struct bpf_gen *gen)
-{
-	__u64 sha[SHA256_DWORD_SIZE];
-	__u64 sha_dw;
-	int i;
-
-	libbpf_sha256(gen->data_start, gen->data_cur - gen->data_start, (__u8 *)sha);
-	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
-		struct bpf_insn *insn =
-			(struct bpf_insn *)(gen->insn_start + gen->hash_insn_offset[i]);
-		sha_dw = tgt_endian(sha[i]);
-		insn[0].imm = (__u32)sha_dw;
-		insn[1].imm = sha_dw >> 32;
-	}
-}
-
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 		       __u32 btf_raw_size)
 {
@@ -557,8 +533,9 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 	 * Conditionally update max_entries from the host-supplied loader
 	 * ctx. This sizes the map at runtime, but for a signed loader
 	 * (gen_hash) it would let an untrusted host re-dimension the
-	 * program's maps after emit_signature_match(), outside what the
-	 * signature attests to. Keep the signer-provided max_entries
+	 * program's maps, outside what the signature attests to: the
+	 * metadata blob is covered by the program signature and verified
+	 * by the kernel at load time. Keep the signer-provided max_entries
 	 * baked into the blob in that case.
 	 */
 	if (map_idx >= 0 && !OPTS_GET(gen->opts, gen_hash, false))
@@ -596,45 +573,6 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 		emit_sys_close_stack(gen, stack_off(inner_map_fd));
 }
 
-static void emit_signature_match(struct bpf_gen *gen)
-{
-	__s64 off;
-	int i;
-
-	/*
-	 * Reject if the metadata map is not exclusive. Without exclusivity
-	 * the cached map->sha[] verified above can be stale: another BPF
-	 * program with map access could have mutated the contents between
-	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
-	 */
-	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
-					 0, 0, 0, 0));
-	emit(gen, BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, SHA256_DIGEST_LENGTH));
-	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
-	if (is_simm16(off)) {
-		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
-		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_2, 1, off));
-	} else {
-		gen->error = -ERANGE;
-	}
-
-	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
-		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
-						 0, 0, 0, 0));
-		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * sizeof(__u64)));
-		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
-		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
-
-		off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
-		if (is_simm16(off)) {
-			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
-			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
-		} else {
-			gen->error = -ERANGE;
-		}
-	}
-}
-
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
 				   enum bpf_attach_type type)
 {
@@ -1211,10 +1149,10 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, int map_idx, void *pvalue,
 	 * }
 	 *
 	 * The runtime initial_value comes from the host-supplied loader
-	 * ctx and would overwrite the blob value after emit_signature_match()
-	 * has already validated map->sha[]. For a signed loader (gen_hash)
-	 * the attested blob value must be authoritative, so skip the override
-	 * and leave the hashed value in place.
+	 * ctx and would overwrite the blob value that the program signature
+	 * covers and the kernel verifies at load time. For a signed loader
+	 * (gen_hash) the attested blob value must be authoritative, so skip
+	 * the override and leave the signed value in place.
 	 */
 	if (!OPTS_GET(gen->opts, gen_hash, false)) {
 		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_6,
diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
index 74503d358bc8..8555ab8af554 100644
--- a/tools/lib/bpf/skel_internal.h
+++ b/tools/lib/bpf/skel_internal.h
@@ -320,25 +320,6 @@ static inline int skel_link_create(int prog_fd, int target_fd,
 	return skel_sys_bpf(BPF_LINK_CREATE, &attr, attr_sz);
 }
 
-static inline int skel_obj_get_info_by_fd(int fd)
-{
-	const size_t attr_sz = offsetofend(union bpf_attr, info);
-	__u8 sha[SHA256_DIGEST_LENGTH];
-	struct bpf_map_info info;
-	__u32 info_len = sizeof(info);
-	union bpf_attr attr;
-
-	memset(&info, 0, sizeof(info));
-	info.hash = (long) &sha;
-	info.hash_size = SHA256_DIGEST_LENGTH;
-
-	memset(&attr, 0, attr_sz);
-	attr.info.bpf_fd = fd;
-	attr.info.info = (long) &info;
-	attr.info.info_len = info_len;
-	return skel_sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
-}
-
 static inline int skel_map_freeze(int fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, map_fd);
@@ -384,12 +365,6 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 		set_err;
 		goto out;
 	}
-	err = skel_obj_get_info_by_fd(map_fd);
-	if (err < 0) {
-		opts->errstr = "failed to fetch obj info";
-		set_err;
-		goto out;
-	}
 #endif
 
 	memset(&attr, 0, prog_load_attr_sz);
@@ -400,6 +375,8 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
 #ifndef __KERNEL__
 	attr.signature = (long) opts->signature;
 	attr.signature_size = opts->signature_sz;
+	if (opts->signature)
+		attr.fd_array_cnt = 1;
 #else
 	if (opts->signature || opts->signature_sz)
 		pr_warn("signatures are not supported from bpf_preload\n");
-- 
2.43.0

