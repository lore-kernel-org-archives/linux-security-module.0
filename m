Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB2349CC5;
	Thu, 21 May 2026 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376946; cv=none; b=WN5DL4CtD3bxscRwUcuEPApUF+RxPwUAEieYeMVN7zP+/zO49wsVtjffBOYLBNN19SNDgxb+xKW64JwyImerfl/a3B4m7nZSFNH4gmVSmTCYJsyhX/hFo8JL4SlNHPkPN2VVyVxsoTrDhbF3UL0XcG0flGNPgxn1Ln01Tm6aOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376946; c=relaxed/simple;
	bh=ZW+A5geojVhY9XYQPOmZaZZzPr01sJZSa7u+WMblLsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYH5m9U0hyEbmmDZFiioq8x9bE1D3EQptZQph0Kr25dOhlMebTFoqENmz2N4+BLwjpHFfUSjgQbL9CtDMFWWVcTztkRGbMP8yjFBMJMqOD/jw/LABO9HP5qfVacsmSdaWGpPtVnMjvQHOgDlAON/77m8lJiTf0f39iKXGlfALSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmO0I3lQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmO0I3lQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A1C1F00A3B;
	Thu, 21 May 2026 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376945;
	bh=GBuyomqWaYCSvJwjKMsq/TIYTszizMMxSdlOrlSrPhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmO0I3lQGx8DMkccgIRz7PDhQDzamhKIDcSsonRscI/AK98pc2F5UitSg1w54dO9o
	 kT/daisMcG3SFNNG7P1zX0L/t8Wt2QKhxOMlEPmJt4o+ShU3V21oKCR226hKLREWYo
	 YKnj2EAsuLT8QOhaF0FJRiRs6KtS33U14nR8IZ2JpVEypyue3+I8L/cW04Qk28o/kk
	 L0wGM4afChhv/scfBlogrEmNtlECjmOA89WXDNow/w1pO580Jc4o6Rnhw0BeqFy5Lq
	 x+oPXTy9TTYpKyrTG9VxWbqfzHfVaQr+znrEzrzSbjHMh7jIB3v2rsiy7q34URLeYt
	 JcADK7jvt/wPQ==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 2/2] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
Date: Thu, 21 May 2026 17:22:17 +0200
Message-ID: <20260521152217.2345235-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521152217.2345235-1-kpsingh@kernel.org>
References: <20260521152217.2345235-1-kpsingh@kernel.org>
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
fixed offset 32. Declare excl_prog_sha with __bpf_md_ptr so the
8-byte BPF_LDX_MEM read works on 32-bit kernels.

Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h                              |  2 +-
 tools/lib/bpf/gen_loader.c                       | 16 ++++++++++++++++
 .../selftests/bpf/progs/verifier_map_ptr.c       | 10 ++++++----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd191c5fdb0a..ea9bd24f82c0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -295,6 +295,7 @@ struct bpf_map_owner {
 
 struct bpf_map {
 	u8 sha[SHA256_DIGEST_SIZE];
+	__bpf_md_ptr(char *, excl_prog_sha);
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
index 9478b8f78f26..fee35c26deb8 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -600,6 +600,22 @@ static void emit_signature_match(struct bpf_gen *gen)
 			gen->error = -ERANGE;
 		}
 	}
+
+	/* Reject if the metadata map is not exclusive. Without exclusivity
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
index e2767d27d8aa..baef2e93cb41 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
 	: __clobber_all);
 }
 
-/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
- * into this array is valid. The opts field is now at offset 33.
+/* The first 32 bytes of struct bpf_map are the SHA256 hash; accessing into
+ * this array is valid. excl_prog_sha follows at offset 32 (8 bytes via
+ * __bpf_md_ptr), then ops at offset 40. Reading at offset 41 crosses into
+ * the ops pointer and must be rejected.
  */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
+__msg("cannot access ptr member ops with moff 40 in struct bpf_map with off 41 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
@@ -85,7 +87,7 @@ __naked void read_non_existent_field_rejected(void)
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u32*)(r1 + 33);				\
+	r6 = *(u32*)(r1 + 41);				\
 	r0 = 1;						\
 	exit;						\
 "	:
-- 
2.53.0

