Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911838E8CE;
	Fri, 22 May 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486825; cv=none; b=VT6G+fb8hRb1EKD4F0IB0jviJ/EURw3AcLm6ZlupC8jnBK0AamGytu0WfMTGhIc6ueZiXyc3yyfirkjGh7J93oHx0YtPF9lZQ88U0nWMeLXSIzdU3fnaddKCYpcnEj2eNOYDhTUG8Zchk7sQEtWmeKmaQD7YkE8RytrHrRgzbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486825; c=relaxed/simple;
	bh=I6ykDEUBIC0B72gD9oYNeZ2yZWPyBPN5G8SMYadJSro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIQr3RTRE8m4D/3BXX02fdlv2xgiRlDtE5S5xc85u5jjqeOZgbbwekjzvTaGmC+cxets53vKLiC72QR0EOVx/Si8rNc/LkYRD+j09TRmxwE0Q7kJgWtK1rKVS4v1CEjMpIbWQEl+WhjHBvkMlPeQcfYmpaa9X1TT/mE2z1Epz1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN8TtJ6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN8TtJ6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5461F000E9;
	Fri, 22 May 2026 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486824;
	bh=5YYGEiN0sjowrMdoCWjdbsJdljjeWYKqm8mF/bherOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gN8TtJ6FD8y0uhkH9h2/QLDN8GbTCK5rkuwDHx1xsGdBuaf84FyrvHKu37jgA0r7G
	 tG5Ly6dnIf7e7TmKIehMGPc4Km5EiTULkq4kL14f04aeXvMj2vNakzY20/drrEGvRz
	 EVilKYi5SxpRcwNaAvZewI85XGM24gSJbFuwHGvz7Ke0m0GMbjkbNTfhxvCRb4CZbn
	 QN0QgvGO//iKIHRqpDuI0jFwwbHqkknm4ya4eFeBGFGA2nLP0c7UTrvn1m2I8RcVRi
	 jMa2QDLcLXfyKUeQW/R9Ay+JwPPYMvqmIlskJONlvCIbGw+ZPsk0N2SIKfO2J1m7me
	 WnXg6BzU7eV7A==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf v3 2/2] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
Date: Fri, 22 May 2026 23:53:37 +0200
Message-ID: <20260522215337.662271-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522215337.662271-1-kpsingh@kernel.org>
References: <20260522215337.662271-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loader verifies map->sha against the metadata hash in its
instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is called
on the frozen map.

While the map is frozen, the loader must also ensure the map is
exclusive, as, without exclusivity, another BPF program with map access
can mutate the contents afterwards, so the check passes on stale data.

Place excl_prog_sha right after sha[] in struct bpf_map and have
gen_loader bail with -EINVAL when it is NULL, via BPF_PSEUDO_MAP_IDX at
fixed offset 32. The 8-byte read of the pointer field limits this to
64-bit kernels; gen_loader needs target pointer size tracking to emit
the right sized read on 32-bit (follow-up).

Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h                             |  2 +-
 tools/lib/bpf/gen_loader.c                      | 17 +++++++++++++++++
 .../selftests/bpf/progs/verifier_map_ptr.c      |  8 +++++---
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd191c5fdb0a..11bec73db199 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -295,6 +295,7 @@ struct bpf_map_owner {
 
 struct bpf_map {
 	u8 sha[SHA256_DIGEST_SIZE];
+	char *excl_prog_sha;
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY
@@ -335,7 +336,6 @@ struct bpf_map {
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
-	char *excl_prog_sha;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 9478b8f78f26..5077472b9fd2 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -600,6 +600,23 @@ static void emit_signature_match(struct bpf_gen *gen)
 			gen->error = -ERANGE;
 		}
 	}
+
+	/*
+	 * Reject if the metadata map is not exclusive. Without exclusivity
+	 * the cached map->sha[] verified above can be stale: another BPF
+	 * program with map access could have mutated the contents between
+	 * BPF_OBJ_GET_INFO_BY_FD and loader execution.
+	 */
+	emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
+					 0, 0, 0, 0));
+	emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, SHA256_DWORD_SIZE * sizeof(__u64)));
+	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
+	if (is_simm16(off)) {
+		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
+	} else {
+		gen->error = -ERANGE;
+	}
 }
 
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e2767d27d8aa..a89d25ce4f91 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
 	: __clobber_all);
 }
 
-/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
- * into this array is valid. The opts field is now at offset 33.
+/*
+ * The first 32 bytes of struct bpf_map are the SHA256 hash; accessing into
+ * this array is valid. excl_prog_sha follows at offset 32, reading at
+ * offset 33 crosses into the pointer and must be rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
+__msg("cannot access ptr member excl_prog_sha with moff 32 in struct bpf_map with off 33 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
-- 
2.53.0

