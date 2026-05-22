Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E0313E1B;
	Fri, 22 May 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417181; cv=none; b=QGjqtPxLBMaMiOIoC1cnpcXwx0NdXOxNL/VsxzeUKHGr4C6326gPC3MCdRImBmqIYiRl5rpuidTnSXGDZuUj3aVJT1NfjFQA9YBLxaAbpWB/NEEIRhj5JGvwGOjZIWVoxzkLZgJVlvZB+lHLkK8YCd7l6Hho0q97vrFD8HAaWV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417181; c=relaxed/simple;
	bh=XvoASK5OYfiW6GFbGT6L2qiZLD+w0FyaC2lwNC5IHUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9KzM81HyLRAlQdfo46fiFayxPdMnuknsyp7i4QE9QOj/phDBSU88212cyQdgtSon6IeYVMq3YjkWt4e2QvtJy2OabEY8n+yrx/Sq3AFx3KBJ+QSkzrJPbhD001mSdsuOSxFBsuSlY7Tl1hVog/tGxDpgnuTOP77BcN8Uy+zrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRm2eHmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRm2eHmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFBF1F00A3D;
	Fri, 22 May 2026 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417179;
	bh=CEOXOcpXCYExcXj5TkP3Kop8GBG081n9FOGOFPorm5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRm2eHmL9ehbug2eYMgy57AYhX3k7xsM9UUUcWR2xe0NNMxQEvPENCZEYCACfAGhi
	 QKgLcmObogBfjZWHV9SCWIFq6Uo4QkHrefHayuqMHn6NZvaBwX8Z4X9DvaejAx4iav
	 de0E/50QY9W1ZDiiygGed7U3Nv9iXVHuevWmQQH+57X6ZMhuYaHuIeu4lXeBb8k34n
	 KiaLy3kWuE/tOIzBAzwzKeom7OQ8CDNst1aing4md3eeaeCf8A6L5+3/IjbgPlRpTy
	 nYB8t7deJEOUtuItaPzaQNOsKNzmF+X5f2aqPIDnqZ6A7lEhF+N2VkcpnEaZu5/Yey
	 WsUNci5YwcMHA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 11/13] ipe: add BPF program signature properties
Date: Fri, 22 May 2026 04:32:31 +0200
Message-ID: <20260522023234.3778588-12-kpsingh@kernel.org>
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

Wire IPE to the BPF signing verdict stored in prog->aux->sig before
security_bpf_prog_load fires. Add three properties on a new IPE op
BPF_PROG_LOAD:

  bpf_signature= UNSIGNED | OK | METADATA_VERIFIED
  bpf_keyring=   BUILTIN | SECONDARY | PLATFORM | USER
  bpf_kernel=    TRUE | FALSE

Example policy:

  op=BPF_PROG_LOAD bpf_signature=UNSIGNED action=DENY
  op=BPF_PROG_LOAD bpf_signature=OK action=ALLOW

Gated by CONFIG_IPE_PROP_BPF_SIGNATURE (depends on BPF_SYSCALL).

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 security/ipe/Kconfig         | 14 +++++++++
 security/ipe/audit.c         | 11 +++++++
 security/ipe/eval.c          | 57 ++++++++++++++++++++++++++++++++++++
 security/ipe/eval.h          |  5 ++++
 security/ipe/hooks.c         | 36 +++++++++++++++++++++++
 security/ipe/hooks.h         |  7 +++++
 security/ipe/ipe.c           |  3 ++
 security/ipe/policy.h        | 10 +++++++
 security/ipe/policy_parser.c | 19 ++++++++++++
 9 files changed, 162 insertions(+)

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index a110a6cd848b..204517c60a34 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -13,6 +13,7 @@ menuconfig SECURITY_IPE
 	select IPE_PROP_DM_VERITY_SIGNATURE if DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG
 	select IPE_PROP_FS_VERITY if FS_VERITY
 	select IPE_PROP_FS_VERITY_BUILTIN_SIG if FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
+	select IPE_PROP_BPF_SIGNATURE if BPF_SYSCALL
 	help
 	  This option enables the Integrity Policy Enforcement LSM
 	  allowing users to define a policy to enforce a trust-based access
@@ -95,6 +96,19 @@ config IPE_PROP_FS_VERITY_BUILTIN_SIG
 
 	  if unsure, answer Y.
 
+config IPE_PROP_BPF_SIGNATURE
+	bool "Enable support for BPF program signature verdicts"
+	depends on BPF_SYSCALL
+	help
+	  This option enables the 'bpf_signature', 'bpf_keyring' and
+	  'bpf_kernel' properties within IPE policies. The properties
+	  These allow
+	  policy rules to gate BPF program loads based on the loader's
+	  signature verdict, the keyring used for verification, and
+	  whether the load originated in kernel mode.
+
+	  if unsure, answer Y.
+
 endmenu
 
 config SECURITY_IPE_KUNIT_TEST
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 93fb59fbddd6..fec98c396d49 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -41,6 +41,7 @@ static const char *const audit_op_names[__IPE_OP_MAX + 1] = {
 	"KEXEC_INITRAMFS",
 	"POLICY",
 	"X509_CERT",
+	"BPF_PROG_LOAD",
 	"UNKNOWN",
 };
 
@@ -51,6 +52,7 @@ static const char *const audit_hook_names[__IPE_HOOK_MAX] = {
 	"MPROTECT",
 	"KERNEL_READ",
 	"KERNEL_LOAD",
+	"BPF_PROG_LOAD",
 };
 
 static const char *const audit_prop_names[__IPE_PROP_MAX] = {
@@ -62,6 +64,15 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"fsverity_digest=",
 	"fsverity_signature=FALSE",
 	"fsverity_signature=TRUE",
+	"bpf_signature=UNSIGNED",
+	"bpf_signature=OK",
+	"bpf_signature=METADATA_VERIFIED",
+	"bpf_keyring=BUILTIN",
+	"bpf_keyring=SECONDARY",
+	"bpf_keyring=PLATFORM",
+	"bpf_keyring=USER",
+	"bpf_kernel=FALSE",
+	"bpf_kernel=TRUE",
 };
 
 /**
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 21439c5be336..e4b4e3723fc8 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -11,6 +11,7 @@
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
 #include <linux/fsverity.h>
+#include <linux/bpf.h>
 
 #include "ipe.h"
 #include "eval.h"
@@ -265,6 +266,44 @@ static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+static bool evaluate_bpf_verdict(const struct ipe_eval_ctx *const ctx,
+				 enum bpf_sig_verdict expected)
+{
+	return ctx->bpf_verdict == expected;
+}
+
+static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
+				 enum bpf_sig_keyring expected)
+{
+	return ctx->bpf_keyring == expected;
+}
+
+static bool evaluate_bpf_kernel(const struct ipe_eval_ctx *const ctx,
+				bool expected)
+{
+	return ctx->bpf_kernel == expected;
+}
+#else
+static bool evaluate_bpf_verdict(const struct ipe_eval_ctx *const ctx,
+				 enum bpf_sig_verdict expected)
+{
+	return false;
+}
+
+static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
+				 enum bpf_sig_keyring expected)
+{
+	return false;
+}
+
+static bool evaluate_bpf_kernel(const struct ipe_eval_ctx *const ctx,
+				bool expected)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 /**
  * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
@@ -297,6 +336,24 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return evaluate_fsv_sig_false(ctx);
 	case IPE_PROP_FSV_SIG_TRUE:
 		return evaluate_fsv_sig_true(ctx);
+	case IPE_PROP_BPF_SIG_UNSIGNED:
+		return evaluate_bpf_verdict(ctx, BPF_SIG_UNSIGNED);
+	case IPE_PROP_BPF_SIG_OK:
+		return evaluate_bpf_verdict(ctx, BPF_SIG_OK);
+	case IPE_PROP_BPF_SIG_METADATA_VERIFIED:
+		return evaluate_bpf_verdict(ctx, BPF_SIG_METADATA_VERIFIED);
+	case IPE_PROP_BPF_KEYRING_BUILTIN:
+		return evaluate_bpf_keyring(ctx, BPF_SIG_KEYRING_BUILTIN);
+	case IPE_PROP_BPF_KEYRING_SECONDARY:
+		return evaluate_bpf_keyring(ctx, BPF_SIG_KEYRING_SECONDARY);
+	case IPE_PROP_BPF_KEYRING_PLATFORM:
+		return evaluate_bpf_keyring(ctx, BPF_SIG_KEYRING_PLATFORM);
+	case IPE_PROP_BPF_KEYRING_USER:
+		return evaluate_bpf_keyring(ctx, BPF_SIG_KEYRING_USER);
+	case IPE_PROP_BPF_KERNEL_FALSE:
+		return evaluate_bpf_kernel(ctx, false);
+	case IPE_PROP_BPF_KERNEL_TRUE:
+		return evaluate_bpf_kernel(ctx, true);
 	default:
 		return false;
 	}
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index fef65a36468c..2ddf89695818 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -52,6 +52,11 @@ struct ipe_eval_ctx {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	const struct ipe_inode *ipe_inode;
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	u8 bpf_verdict;		/* enum bpf_sig_verdict */
+	u8 bpf_keyring;		/* enum bpf_sig_keyring */
+	bool bpf_kernel;
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 enum ipe_match {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 0ae54a880405..bdc1b634bb08 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -312,6 +312,42 @@ int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type typ
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+/**
+ * ipe_bpf_prog_load() - IPE hook for BPF program load.
+ * @prog: The BPF program being loaded.
+ * @attr: BPF syscall attributes.
+ * @token: BPF token.
+ * @kernel: Whether the load originated in kernel mode.
+ *
+ * Return: %0 on success, %-EACCES if denied by policy.
+ */
+int ipe_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+		      struct bpf_token *token, bool kernel)
+{
+	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
+
+	ipe_build_eval_ctx(&ctx, NULL, IPE_OP_BPF_PROG_LOAD,
+			   IPE_HOOK_BPF_PROG_LOAD);
+	ctx.bpf_verdict = prog->aux->sig.verdict;
+	ctx.bpf_keyring = prog->aux->sig.keyring;
+	ctx.bpf_kernel = kernel;
+	return ipe_evaluate_event(&ctx);
+}
+
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog)
+{
+	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
+
+	ipe_build_eval_ctx(&ctx, NULL, IPE_OP_BPF_PROG_LOAD_POST_INTEGRITY,
+			   IPE_HOOK_BPF_PROG_LOAD_POST_INTEGRITY);
+	ctx.bpf_verdict = BPF_SIG_METADATA_VERIFIED;
+	ctx.bpf_keyring = prog->aux->sig.keyring;
+	ctx.bpf_kernel = prog->aux->is_kernel;
+	return ipe_evaluate_event(&ctx);
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 /**
  * ipe_inode_setintegrity() - save integrity data from a inode to IPE's LSM blob.
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 07db37332740..abdedd436aa8 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -10,6 +10,7 @@
 #include <linux/security.h>
 #include <linux/blk_types.h>
 #include <linux/fsverity.h>
+#include <linux/bpf.h>
 
 enum ipe_hook_type {
 	IPE_HOOK_BPRM_CHECK = 0,
@@ -18,6 +19,7 @@ enum ipe_hook_type {
 	IPE_HOOK_MPROTECT,
 	IPE_HOOK_KERNEL_READ,
 	IPE_HOOK_KERNEL_LOAD,
+	IPE_HOOK_BPF_PROG_LOAD,
 	__IPE_HOOK_MAX
 };
 
@@ -52,4 +54,9 @@ int ipe_inode_setintegrity(const struct inode *inode, enum lsm_integrity_type ty
 			   const void *value, size_t size);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+int ipe_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+		      struct bpf_token *token, bool kernel);
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b..17ace9236253 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -60,6 +60,9 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	LSM_HOOK_INIT(bpf_prog_load, ipe_bpf_prog_load),
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 /**
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 5bfbdbddeef8..eb066750a48b 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -17,6 +17,7 @@ enum ipe_op_type {
 	IPE_OP_KEXEC_INITRAMFS,
 	IPE_OP_POLICY,
 	IPE_OP_X509,
+	IPE_OP_BPF_PROG_LOAD,
 	__IPE_OP_MAX,
 };
 
@@ -39,6 +40,15 @@ enum ipe_prop_type {
 	IPE_PROP_FSV_DIGEST,
 	IPE_PROP_FSV_SIG_FALSE,
 	IPE_PROP_FSV_SIG_TRUE,
+	IPE_PROP_BPF_SIG_UNSIGNED,
+	IPE_PROP_BPF_SIG_OK,
+	IPE_PROP_BPF_SIG_METADATA_VERIFIED,
+	IPE_PROP_BPF_KEYRING_BUILTIN,
+	IPE_PROP_BPF_KEYRING_SECONDARY,
+	IPE_PROP_BPF_KEYRING_PLATFORM,
+	IPE_PROP_BPF_KEYRING_USER,
+	IPE_PROP_BPF_KERNEL_FALSE,
+	IPE_PROP_BPF_KERNEL_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 6fa5bebf8471..c1e374d2ec34 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -237,6 +237,7 @@ static const match_table_t operation_tokens = {
 	{IPE_OP_KEXEC_INITRAMFS,	"op=KEXEC_INITRAMFS"},
 	{IPE_OP_POLICY,			"op=POLICY"},
 	{IPE_OP_X509,			"op=X509_CERT"},
+	{IPE_OP_BPF_PROG_LOAD,		"op=BPF_PROG_LOAD"},
 	{IPE_OP_INVALID,		NULL}
 };
 
@@ -281,6 +282,15 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_FSV_DIGEST,		"fsverity_digest=%s"},
 	{IPE_PROP_FSV_SIG_FALSE,	"fsverity_signature=FALSE"},
 	{IPE_PROP_FSV_SIG_TRUE,		"fsverity_signature=TRUE"},
+	{IPE_PROP_BPF_SIG_UNSIGNED,	"bpf_signature=UNSIGNED"},
+	{IPE_PROP_BPF_SIG_OK,		"bpf_signature=OK"},
+	{IPE_PROP_BPF_SIG_METADATA_VERIFIED, "bpf_signature=METADATA_VERIFIED"},
+	{IPE_PROP_BPF_KEYRING_BUILTIN,	"bpf_keyring=BUILTIN"},
+	{IPE_PROP_BPF_KEYRING_SECONDARY, "bpf_keyring=SECONDARY"},
+	{IPE_PROP_BPF_KEYRING_PLATFORM,	"bpf_keyring=PLATFORM"},
+	{IPE_PROP_BPF_KEYRING_USER,	"bpf_keyring=USER"},
+	{IPE_PROP_BPF_KERNEL_FALSE,	"bpf_kernel=FALSE"},
+	{IPE_PROP_BPF_KERNEL_TRUE,	"bpf_kernel=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -331,6 +341,15 @@ static int parse_property(char *t, struct ipe_rule *r)
 	case IPE_PROP_DMV_SIG_TRUE:
 	case IPE_PROP_FSV_SIG_FALSE:
 	case IPE_PROP_FSV_SIG_TRUE:
+	case IPE_PROP_BPF_SIG_UNSIGNED:
+	case IPE_PROP_BPF_SIG_OK:
+	case IPE_PROP_BPF_SIG_METADATA_VERIFIED:
+	case IPE_PROP_BPF_KEYRING_BUILTIN:
+	case IPE_PROP_BPF_KEYRING_SECONDARY:
+	case IPE_PROP_BPF_KEYRING_PLATFORM:
+	case IPE_PROP_BPF_KEYRING_USER:
+	case IPE_PROP_BPF_KERNEL_FALSE:
+	case IPE_PROP_BPF_KERNEL_TRUE:
 		p->type = token;
 		break;
 	default:
-- 
2.53.0

