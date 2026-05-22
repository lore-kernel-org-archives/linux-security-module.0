Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630C314A90;
	Fri, 22 May 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417182; cv=none; b=gCR7eMX3sfskFp/Gphb5zGktxNFd6PvKPYVpRs/gwe2g0vKS13h0xQaH+7axbQUb17W1wH6v4r/cq1bC0EaTzA9EO2MM/CFk8AZoq2ZFHN1DWXQoq28X+H90GD6lawSxUn7j43dTfJo+i/C74qiPB0gdDRGHHbj+OOOmEk2yh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417182; c=relaxed/simple;
	bh=p2EejZFPodhXXPByF3dUCmXvF8rKVqh5XL1sNIFtYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+SlH/iED2O0YJ116UlJSJjOoBE84/44/BGW0rtV/Hj71X9zBWT7lKPXJTQ9GKbc8FFz/7zcCFjBBsFeX0R7MteRQnLWQRLy1JEt6e3ZG1xsViSHx0OGVJ4tIzfvh9xec6hmqn3IJ6/jIRLuSozxo4VIrYFOkHSggt0td+bUHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl5azNbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl5azNbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B71F000E9;
	Fri, 22 May 2026 02:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417181;
	bh=yR231Tkb+OBtk2SqdwMBE8wveNFu1DueheJzBqg8YVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wl5azNbv5ez/OhhFdt6527PGZ+5KDg7XQaIdfYHWzScYCgtjlEzC3PIDowmHNA4fU
	 t6dzNZJXnBCWaPDdyS+5MjQzxeWIrV6QXwrhq9iJ3YMQJuAwYgQSTY2fyohYEtFUZu
	 BztC6vHDLJltbIutt5gpdPQpHooxgQoH40FLsTNhi8ASv/aThM9gGkpc2KV0flQRMv
	 A5kQ3AGyqIyUrLHJng6rs7TVVjIleWQrRUduqO+Vq9ixgQN9p2J5rihoqbgpZ/hjfL
	 lBzQG1V7+u60Y3R4GL2jOD/n/ZqM4CAssJlMuVlK/KjEpjAWkkzJ544gZp2AuJBh4Q
	 Q/4ocXzVuy/eA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 12/13] ipe: gate post-integrity BPF program loads
Date: Fri, 22 May 2026 04:32:32 +0200
Message-ID: <20260522023234.3778588-13-kpsingh@kernel.org>
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

Register on security_bpf_prog_load_post_integrity and expose a new
IPE op BPF_PROG_LOAD_POST_INTEGRITY. Kept distinct from
BPF_PROG_LOAD so policies need not reason about the same rule
firing at two timings with different verdict states.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 security/ipe/audit.c         | 2 ++
 security/ipe/hooks.c         | 6 ++++++
 security/ipe/hooks.h         | 2 ++
 security/ipe/ipe.c           | 1 +
 security/ipe/policy.h        | 1 +
 security/ipe/policy_parser.c | 1 +
 6 files changed, 13 insertions(+)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index fec98c396d49..bcb3e6c0a310 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -42,6 +42,7 @@ static const char *const audit_op_names[__IPE_OP_MAX + 1] = {
 	"POLICY",
 	"X509_CERT",
 	"BPF_PROG_LOAD",
+	"BPF_PROG_LOAD_POST_INTEGRITY",
 	"UNKNOWN",
 };
 
@@ -53,6 +54,7 @@ static const char *const audit_hook_names[__IPE_HOOK_MAX] = {
 	"KERNEL_READ",
 	"KERNEL_LOAD",
 	"BPF_PROG_LOAD",
+	"BPF_PROG_LOAD_POST_INTEGRITY",
 };
 
 static const char *const audit_prop_names[__IPE_PROP_MAX] = {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index bdc1b634bb08..3f6e260a8787 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -335,6 +335,12 @@ int ipe_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	return ipe_evaluate_event(&ctx);
 }
 
+/**
+ * ipe_bpf_prog_load_post_integrity() - IPE hook for post-integrity verdict.
+ * @prog: The loader BPF program.
+ *
+ * Return: %0 on success, %-EACCES if denied by policy.
+ */
 int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog)
 {
 	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index abdedd436aa8..bd24067705ea 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -20,6 +20,7 @@ enum ipe_hook_type {
 	IPE_HOOK_KERNEL_READ,
 	IPE_HOOK_KERNEL_LOAD,
 	IPE_HOOK_BPF_PROG_LOAD,
+	IPE_HOOK_BPF_PROG_LOAD_POST_INTEGRITY,
 	__IPE_HOOK_MAX
 };
 
@@ -57,6 +58,7 @@ int ipe_inode_setintegrity(const struct inode *inode, enum lsm_integrity_type ty
 #ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
 int ipe_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 		      struct bpf_token *token, bool kernel);
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog);
 #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 17ace9236253..d5e6f339639a 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -62,6 +62,7 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 #ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
 	LSM_HOOK_INIT(bpf_prog_load, ipe_bpf_prog_load),
+	LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_post_integrity),
 #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index eb066750a48b..84b3e69e618d 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -18,6 +18,7 @@ enum ipe_op_type {
 	IPE_OP_POLICY,
 	IPE_OP_X509,
 	IPE_OP_BPF_PROG_LOAD,
+	IPE_OP_BPF_PROG_LOAD_POST_INTEGRITY,
 	__IPE_OP_MAX,
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index c1e374d2ec34..350cc93a1af1 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -238,6 +238,7 @@ static const match_table_t operation_tokens = {
 	{IPE_OP_POLICY,			"op=POLICY"},
 	{IPE_OP_X509,			"op=X509_CERT"},
 	{IPE_OP_BPF_PROG_LOAD,		"op=BPF_PROG_LOAD"},
+	{IPE_OP_BPF_PROG_LOAD_POST_INTEGRITY, "op=BPF_PROG_LOAD_POST_INTEGRITY"},
 	{IPE_OP_INVALID,		NULL}
 };
 
-- 
2.53.0

