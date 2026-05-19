Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5373BD651;
	Tue, 19 May 2026 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227644; cv=none; b=ttbIiYaWh/BGhoe6qfZkpN8pITyiNhIl9JSx2hqHtGlJJvNAHIQTlG0K/ueIJ0gIpGdG85aVEA+5Iy4EpEOMFICA9kcVrtGbezA4Yz9DiBcntP3xGFY4sPiDtmq6gkr2SP9TmsIwGMNTs4gcI3HvB2o4KtBPjKP2MDqirg8BSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227644; c=relaxed/simple;
	bh=0tWJLNQ+MZ26hzgF0J3l2Fa8S9iYnooqNc1vg36VILs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oe6RYh63b96ONI+FgeLBjR91cejySceZP/UpV/GFxitcrhYWDgVM4/DbwHF2LOlwkCEn14eNG0x0eaM5HNI+g91GSIrIzxrYTmKBhazskR56ocivxHbXOrOuMxvtr7pLs34B1YaJ29o2reidI7s93UE1YjEgGkJ+OKjqZdh9euI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfLSK1pT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfLSK1pT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B721F00893;
	Tue, 19 May 2026 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779227643;
	bh=SciKUfKCKaoWQV9O6IeWoRvOPozlfkbawQO9pQj9bMc=;
	h=From:To:Cc:Subject:Date;
	b=UfLSK1pT45Ws7UgmNgZYR6grm6tLdTGFVON29Lv84K+LBSfkg4ezDVnYE6UGhhb8F
	 asyU80AF1vXh+CQx2qoKzVZjQMWRjG4vGk/iLxfSStlGUPRhsZMW+VYx85qbit5b6O
	 Z9no0nfyWpBxc/McW0bPOuCAc0146w/qrd08zKOnDrAzAkVP3K7G5b7F9P6ZttxLgH
	 Yo0qan2DGS8klu/kOGmmw/Xb7DQcQn1ozqiiY/+Qb5sbUgmL7UjewQCbtPWq992edF
	 /U1Fz8iwbqtzAEWS0iQOLM68ukxQHCxZSTsppDbgPeLIMomxlhxgZIcBRLM2w9N7Gx
	 J8zbWC3IKtZ+A==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH] bpf, libbpf: reject non-exclusive metadata maps in the signed loader
Date: Tue, 19 May 2026 23:53:58 +0200
Message-ID: <20260519215358.126364-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
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
fixed offset 32.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h                             |  2 +-
 tools/lib/bpf/gen_loader.c                      | 17 +++++++++++++++++
 .../selftests/bpf/progs/verifier_map_ptr.c      |  2 +-
 3 files changed, 19 insertions(+), 2 deletions(-)

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
index cd5c2543f54d..becfda5b9025 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -601,6 +601,23 @@ static void emit_signature_match(struct bpf_gen *gen)
 			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
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
+	off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
+	if (is_simm16(off)) {
+		emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+		emit(gen, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, off));
+	} else {
+		gen->error = -ERANGE;
+		emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
+	}
 }
 
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e2767d27d8aa..f59e8d8d3b18 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -76,7 +76,7 @@ __naked void bpf_map_ptr_write_rejected(void)
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

