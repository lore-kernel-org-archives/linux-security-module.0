Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA153264EB;
	Fri, 22 May 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417172; cv=none; b=GRUsDJzEVTzaC8WQ7dS1In6RrpmG1au07hiezAZ+SyXclB6mwuuatLmeaZESE+SwQ2VQ0vEkOdLOadaLyKWl0vdg8UoYE3zR5ZxfiFxcXt0nwaNve8OjZAwh1D4rpRl4P8cC/0w8R7ioMrilpWijNkpo7tkt4c9DXFcxQwCx7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417172; c=relaxed/simple;
	bh=erU/8tEDmBLorCr/gLYwh+1a6E47/HnUXbCuAghMJKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL9HXL7qFoykfN2hdVO/41AxSMjF+AkL6a978dW//FqPRfiyxCCplzCnF9Db68Q5gbhEuMlkGJz+WYNEeXThtgzcMDsMjcf7dCOyCMLDEkVvSoD11D/ftxsiG4XfvfW+/KJtNLdz35xP1r+ESTuluhC51P5keNJIcL/2ymD8ec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ZZHF3E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ZZHF3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD00B1F00A3E;
	Fri, 22 May 2026 02:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417171;
	bh=K5eGdm+V3plg3CclWWFHEn3wF9OtZsVnt8N+v59JMQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P4ZZHF3EreG1QaNy9Qan9S4kvJ6c+2CUxEJoFFP99x3YuPdbu9DEKBAdkdoziJ1Hn
	 i7OXVSr5/OXlb5OwuzWaL6PSYbsNgyublFkH+sTVcoQJHZ4jc2/5WPEHks8+zou3Mv
	 xlDrhhcdTggHxnFF/c5oTf27L26WS1w5+PKGd7fDS4eqgju8ogKUQQz8G9T/16AzQE
	 Juu8K3ooDvcwRqwxIMZrlYeaWQWo/SExQ68Vk8eciSuDHvrpNJ4meN77tsBm3irlys
	 05qble8t6rawGU4JOct8PuHVsApwS9Bqe0MVBFvZWH5LUtIf5UIrO2FOLttGCf29uD
	 hFsL1CmBXTotw==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 07/13] libbpf: generate prog BTF for loader programs
Date: Fri, 22 May 2026 04:32:27 +0200
Message-ID: <20260522023234.3778588-8-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For signed loaders, build a minimal prog BTF containing one FUNC entry
for bpf_loader_verify_metadata with a FUNC_PROTO of primitives (int,
void *) so the bytes are reproducible across build hosts.

In emit_verify_metadata, spill four signed ld_imm64 immediates into
a 32-byte stack buffer and invoke the kfunc once with (map, &buf, 32),
replacing ~24 inline dword comparisons. Expose the serialized BTF on
gen_loader_opts from bpf_gen__finish so bpftool gen can embed it in
the lskel.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |   2 +
 tools/lib/bpf/gen_loader.c       | 127 ++++++++++++++++++++++++-------
 tools/lib/bpf/libbpf.h           |   4 +-
 3 files changed, 105 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 49af4260b8e6..e4aed9e99b56 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -52,6 +52,8 @@ struct bpf_gen {
 	int fd_array;
 	int nr_fd_array;
 	int hash_insn_offset[SHA256_DWORD_SIZE];
+	struct btf *loader_btf;
+	int loader_btf_func_id;
 };
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index fee35c26deb8..48ac25c058e3 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -35,6 +35,7 @@ struct loader_stack {
 	__u32 btf_fd;
 	__u32 inner_map_fd;
 	__u32 prog_fd[MAX_USED_PROGS];
+	__u64 metadata_hash[SHA256_DWORD_SIZE];
 };
 
 #define stack_off(field) \
@@ -109,7 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
-static void emit_signature_match(struct bpf_gen *gen);
+static void emit_verify_metadata(struct bpf_gen *gen);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
@@ -152,8 +153,68 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
-	if (OPTS_GET(gen->opts, gen_hash, false))
-		emit_signature_match(gen);
+	if (OPTS_GET(gen->opts, gen_hash, false)) {
+		int int_id, u32_id, ptr_id, proto_id, err;
+
+		/* Prog BTF built from primitives so the bytes are reproducible
+		 * across build hosts.
+		 */
+		gen->loader_btf = btf__new_empty();
+		if (libbpf_get_error(gen->loader_btf)) {
+			gen->error = -ENOMEM;
+			gen->loader_btf = NULL;
+			return;
+		}
+		if (gen->swapped_endian) {
+			enum btf_endianness target =
+				btf__endianness(gen->loader_btf) == BTF_LITTLE_ENDIAN
+				? BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;
+
+			err = btf__set_endianness(gen->loader_btf, target);
+			if (err) {
+				gen->error = err;
+				return;
+			}
+		}
+		int_id = btf__add_int(gen->loader_btf, "int", 4, BTF_INT_SIGNED);
+		if (int_id < 0) {
+			gen->error = int_id;
+			return;
+		}
+		u32_id = btf__add_int(gen->loader_btf, "u32", 4, 0);
+		if (u32_id < 0) {
+			gen->error = u32_id;
+			return;
+		}
+		ptr_id = btf__add_ptr(gen->loader_btf, 0);
+		if (ptr_id < 0) {
+			gen->error = ptr_id;
+			return;
+		}
+		proto_id = btf__add_func_proto(gen->loader_btf, int_id);
+		if (proto_id < 0) {
+			gen->error = proto_id;
+			return;
+		}
+		err = btf__add_func_param(gen->loader_btf, "map", ptr_id);
+		if (!err)
+			err = btf__add_func_param(gen->loader_btf, "hash", ptr_id);
+		if (!err)
+			err = btf__add_func_param(gen->loader_btf, "hash__sz", u32_id);
+		if (err) {
+			gen->error = err;
+			return;
+		}
+		gen->loader_btf_func_id = btf__add_func(gen->loader_btf,
+							"bpf_loader_verify_metadata",
+							BTF_FUNC_GLOBAL, proto_id);
+		if (gen->loader_btf_func_id < 0) {
+			gen->error = gen->loader_btf_func_id;
+			gen->loader_btf_func_id = 0;
+			return;
+		}
+		emit_verify_metadata(gen);
+	}
 }
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -398,7 +459,7 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 			      blob_fd_array_off(gen, i));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
 	emit(gen, BPF_EXIT_INSN());
-	if (OPTS_GET(gen->opts, gen_hash, false))
+	if (!gen->error && OPTS_GET(gen->opts, gen_hash, false))
 		compute_sha_update_offsets(gen);
 
 	pr_debug("gen: finish %s\n", errstr(gen->error));
@@ -410,6 +471,19 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 		opts->data = gen->data_start;
 		opts->data_sz = gen->data_cur - gen->data_start;
 
+		if (gen->loader_btf) {
+			__u32 btf_sz = 0;
+			const void *btf_data;
+
+			btf_data = btf__raw_data(gen->loader_btf, &btf_sz);
+			if (!btf_data) {
+				gen->error = -ENOMEM;
+				return gen->error;
+			}
+			OPTS_SET(opts, btf, btf_data);
+			OPTS_SET(opts, btf_sz, btf_sz);
+		}
+
 		/* use target endianness for embedded loader */
 		if (gen->swapped_endian) {
 			struct bpf_insn *insn = (struct bpf_insn *)opts->insns;
@@ -426,6 +500,7 @@ void bpf_gen__free(struct bpf_gen *gen)
 {
 	if (!gen)
 		return;
+	btf__free(gen->loader_btf);
 	free(gen->data_start);
 	free(gen->insn_start);
 	free(gen);
@@ -580,39 +655,37 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 		emit_sys_close_stack(gen, stack_off(inner_map_fd));
 }
 
-static void emit_signature_match(struct bpf_gen *gen)
+static void emit_verify_metadata(struct bpf_gen *gen)
 {
 	__s64 off;
 	int i;
 
+	/* arg1: metadata struct bpf_map */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
+					 0, 0, 0, 0));
+
+	/* arg2: hash buffer on our BPF stack, populated from ld_imm64
+	 * immediates patched in by compute_sha_update_offsets() before signing.
+	 */
+	emit(gen, BPF_MOV64_REG(BPF_REG_2, BPF_REG_10));
+	emit(gen, BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, stack_off(metadata_hash)));
 	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
-		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
-						 0, 0, 0, 0));
-		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * sizeof(__u64)));
 		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
 		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
-
-		off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
-		if (is_simm16(off)) {
-			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
-			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
-		} else {
-			gen->error = -ERANGE;
-		}
+		emit(gen, BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3,
+				      i * sizeof(__u64)));
 	}
 
-	/* Reject if the metadata map is not exclusive. Without exclusivity
-	 * the cached map->sha[] verified above can be stale: another BPF
-	 * program with map access could have mutated the contents between
-	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
-	 */
-	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
-					 0, 0, 0, 0));
-	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));
-	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
+	/* arg3: hash length */
+	emit(gen, BPF_MOV64_IMM(BPF_REG_3, SHA256_DWORD_SIZE * sizeof(__u64)));
+
+	emit(gen, BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0,
+			       BPF_PSEUDO_KFUNC_CALL_PROG_BTF, 0,
+			       gen->loader_btf_func_id));
+	emit(gen, BPF_MOV64_REG(BPF_REG_7, BPF_REG_0));
+	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
 	if (is_simm16(off)) {
-		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
-		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
+		emit(gen, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, off));
 	} else {
 		gen->error = -ERANGE;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index bba4e8464396..25906fb695f9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1899,9 +1899,11 @@ struct gen_loader_opts {
 	__u32 data_sz;
 	__u32 insns_sz;
 	bool gen_hash;
+	const void *btf;
+	__u32 btf_sz;
 };
 
-#define gen_loader_opts__last_field gen_hash
+#define gen_loader_opts__last_field btf_sz
 LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
 				      struct gen_loader_opts *opts);
 
-- 
2.53.0

