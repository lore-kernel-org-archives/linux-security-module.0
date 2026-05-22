Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B343264EB;
	Fri, 22 May 2026 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417170; cv=none; b=DW24kEWUWRan3D4PqZKujt0i3XTFDPvLNW2KHsIka0hUCRyjugHWIICYF8hTeQRyG/y3uYQdXWkbeYCUWEvmRN4GExJd/UkNYyARyuvb26dCFwqBs/WByNOtkbXA+vgytetkpoxWi/LmhY/gDQtqE+p1KZJPrFj6wt3Esv4IO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417170; c=relaxed/simple;
	bh=PlFfUuwCGe+kIlt1RolYeEDg2bBz+EMiantsLscId2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnN8ulIEZPfHyVMkwMhlMQU2DtNbKfZn0Cyz9EOzs3Yi7sJty5pX0ueXv6vV8ehM85jJNiukJOiSuzB1GDQ3tUsCYJkqWZXVk6AJcl1vQw1+8GSktHmLMJ6iEevQGOfKnQ4AGNeCYOjpVBBiMseLk0K6GqNapH9sM4P+dLK9ZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTibrMfc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTibrMfc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03731F000E9;
	Fri, 22 May 2026 02:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417169;
	bh=xeK+I63pViKWos8hiH28ugVloHvC2Vfm4EYo1GkTcOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTibrMfcrEB/SeixaV37LnpR/lGBVlBWHCNmWYQqe4QldUz19ozhz96awGY5uGocH
	 eimFJBVvPpStxaJQ1IRSVtZvKsszZyRobGqGj5Q8GFDJgWDxRVJ2uaF/XumQSi9rnr
	 JyvSYay3flyZOteYxffaDwJ4Tt8XTkXpz9f/AvtSPoQ3FSeFKTlBLmCN/3RAnlB709
	 2zCdiIYtcAxDD1hN7fm6Zo54ApBtj2uAeaE1X+HQSBHIo1NVEgR2axwzoSWPt5gJWv
	 88yQGLj9K9BqYdwkTf3H8q1JXLq/0jIAp+xfzHEFNsBv70s9rpJCdMsahGGHXPD0kr
	 FuinSee/kP0aA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 06/13] bpf: resolve loader-style kfunc CALLs against prog BTF
Date: Fri, 22 May 2026 04:32:26 +0200
Message-ID: <20260522023234.3778588-7-kpsingh@kernel.org>
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

gen_loader-emitted signed loaders cannot bake vmlinux BTF ids into
kfunc CALL imm at sign time. Add a new pseudo
BPF_PSEUDO_KFUNC_CALL_PROG_BTF that gen_loader emits in src_reg, with
imm holding the FUNC type id in the loader's own prog BTF.

In add_subprog_and_kfunc, look the FUNC up by name in vmlinux BTF,
patch imm with the resolved id, and rewrite src_reg back to
BPF_PSEUDO_KFUNC_CALL so downstream passes see a normal kfunc CALL.
Leave standard src_reg calls unchanged.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf_verifier.h   |  6 ++++
 include/uapi/linux/bpf.h       |  5 ++++
 kernel/bpf/verifier.c          | 54 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  5 ++++
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 185b2aa43a42..396b85830996 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -959,6 +959,12 @@ static inline bool bpf_pseudo_kfunc_call(const struct bpf_insn *insn)
 	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL;
 }
 
+static inline bool bpf_pseudo_kfunc_call_prog_btf(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL) &&
+	       insn->src_reg == BPF_PSEUDO_KFUNC_CALL_PROG_BTF;
+}
+
 __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
 				      const char *fmt, va_list args);
 __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..06056e714e8e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1382,6 +1382,11 @@ enum {
  * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the running kernel
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
+/* when bpf_call->src_reg == BPF_PSEUDO_KFUNC_CALL_PROG_BTF,
+ * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the program's
+ * prog BTF. The verifier resolves it to a vmlinux btf_id by name.
+ */
+#define BPF_PSEUDO_KFUNC_CALL_PROG_BTF	3
 
 enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0e45cfa5b34..1b5d06b9d74a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3088,6 +3088,47 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
 	return !!prog->aux->kfunc_tab;
 }
 
+/*
+ * Resolve a gen_loader-emitted kfunc CALL by FUNC name in vmlinux BTF,
+ * then rewrite src_reg back to BPF_PSEUDO_KFUNC_CALL. Caller must have
+ * already filtered for BPF_PSEUDO_KFUNC_CALL_PROG_BTF.
+ */
+static int resolve_loader_kfunc(struct bpf_verifier_env *env,
+				struct bpf_insn *insn, int insn_idx)
+{
+	struct btf *prog_btf = env->prog->aux->btf;
+	const struct btf_type *t;
+	const char *name;
+	s32 vmlinux_id;
+
+	if (!prog_btf || !btf_vmlinux || insn->off) {
+		verbose(env, "kfunc call insn %d: PROG_BTF resolution requires prog BTF and insn->off == 0\n",
+			insn_idx);
+		return -EINVAL;
+	}
+	t = btf_type_by_id(prog_btf, insn->imm);
+	if (!t || !btf_type_is_func(t)) {
+		verbose(env, "kfunc call insn %d: imm %d is not a FUNC in prog BTF\n",
+			insn_idx, insn->imm);
+		return -EINVAL;
+	}
+	name = btf_name_by_offset(prog_btf, t->name_off);
+	if (!name || !name[0]) {
+		verbose(env, "kfunc call insn %d: prog-BTF FUNC has no name\n",
+			insn_idx);
+		return -EINVAL;
+	}
+	vmlinux_id = btf_find_by_name_kind(btf_vmlinux, name, BTF_KIND_FUNC);
+	if (vmlinux_id < 0) {
+		verbose(env, "kfunc call insn %d: %s not found in vmlinux BTF\n",
+			insn_idx, name);
+		return vmlinux_id;
+	}
+	insn->imm = vmlinux_id;
+	insn->src_reg = BPF_PSEUDO_KFUNC_CALL;
+	return 0;
+}
+
 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprog = env->subprog_info;
@@ -3101,7 +3142,8 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn) &&
-		    !bpf_pseudo_kfunc_call(insn))
+		    !bpf_pseudo_kfunc_call(insn) &&
+		    !bpf_pseudo_kfunc_call_prog_btf(insn))
 			continue;
 
 		if (!env->bpf_capable) {
@@ -3109,10 +3151,16 @@ static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
 			return -EPERM;
 		}
 
-		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
+		if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
 			ret = add_subprog(env, i + insn->imm + 1);
-		else
+		} else {
+			if (bpf_pseudo_kfunc_call_prog_btf(insn)) {
+				ret = resolve_loader_kfunc(env, insn, i);
+				if (ret < 0)
+					return ret;
+			}
 			ret = bpf_add_kfunc_call(env, insn->imm, insn->off);
+		}
 
 		if (ret < 0)
 			return ret;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..d4f7f3e0aaa3 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1382,6 +1382,11 @@ enum {
  * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the running kernel
  */
 #define BPF_PSEUDO_KFUNC_CALL	2
+/* when bpf_call->src_reg == BPF_PSEUDO_KFUNC_CALL_PROG_BTF,
+ * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the program's
+ * prog BTF. The verifier resolves it to a vmlinux btf_id by name.
+ */
+#define BPF_PSEUDO_KFUNC_CALL_PROG_BTF	3
 
 enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
-- 
2.53.0

