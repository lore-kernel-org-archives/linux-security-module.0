Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293293E5567;
	Thu, 16 Apr 2026 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360955; cv=none; b=TKplWjlAbaHtdCg8l93DNFJzIReprlOees2b3UUup9kI0bY7vQvBkQR21CtECP2DI+mkLPxyd3vOaUGDsu28t32Q5MT5PUYbp1RWjum1AOuNZ3E87ZsAynMyLC3dZ4ZujOpLHcFOTD6BxGrAMM2tFVDftQXd/5c5T2m7ACtw1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360955; c=relaxed/simple;
	bh=XnyLBCqFRJyuDFZbn4KhVL0zy1rmxX6vqTZjD0dirOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3GPmqNOyie2JPh4mvWZD5lWT/x3OTNULREiFKj6MtlkELXvX09hIswpXJNBGaQb5JHRl0yAs6C2wEFStjXaE0n1tMmZwWQCTBtpf3dVCI+V35gszWN1ukWYTvHB0y+Wl9gDtEshilnUzqb23kIKMSxyPulVEthsirIBaewj6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IpcGBz4G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IpcGBz4G"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CBD420B700D;
	Thu, 16 Apr 2026 10:35:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CBD420B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776360951;
	bh=TwdtsrfxsRA/+y0OpoLeohZiJNI4DAJuRdYf9MqgAQY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IpcGBz4GvNBo0re3ecw8BcjxY1/vmsLcB8HHMghnP5sx6zn2G2F1CS+7oJzIlBCES
	 v6iiXRVoBEI6fk9DvBE1iOljy99SmIrPkf5RWDRmsAH8ZDPDlPtfrGlPqdOm+yrkU7
	 xvy49eNahhYDSZbrcWaxTK1N/Xxgg/pyD6pTjaoY=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	Fan Wu <wufan@kernel.org>,
	Ryan Foster <foster.ryan.r@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 10/10] ipe: Add BPF program load policy enforcement via Hornet integration
Date: Thu, 16 Apr 2026 10:33:31 -0700
Message-ID: <20260416173500.176716-11-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416173500.176716-1-bboscaccy@linux.microsoft.com>
References: <20260416173500.176716-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
to make policy decisions about BPF program loading based on integrity
verdicts provided by the Hornet LSM.

New policy operation:
  op=BPF_PROG_LOAD - Matches BPF program load events

New policy properties:
  bpf_signature=NONE      - No Verdict
  bpf_signature=OK        - Program signature and map hashes verified
  bpf_signature=UNSIGNED  - No signature provided
  bpf_signature=PARTIALSIG - Signature OK but no map hash data
  bpf_signature=UNKNOWNKEY - Cert not trusted
  bpf_signature=UNEXPECTED - An unexpected hash value was encountered
  bpf_signature=FAULT 	   - System error during verification
  bpf_signature=BADSIG    - Signature or map hash verification failed
  bpf_keyring=BUILTIN     - Program was signed using a builtin keyring
  bpf_keyring=SECONDARY   - Program was signed using the secondary keyring
  bpf_keyring=PLATFORM    - Program was signed using the platform keyring
  bpf_kernel=TRUE         - Program originated from kernelspace
  bpf_kernel=FALSE        - Program originated from userspace

These properties map directly to the lsm_integrity_verdict enum values
provided by the Hornet LSM through security_bpf_prog_load_post_integrity.

The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
CONFIG_SECURITY_HORNET.

Example policy for bpf signature enforcement:
 DEFAULT op=BPF_PROG_LOAD action=DENY
 op=BPF_PROG_LOAD is_kernel=TRUE action=ALLOW
 op=BPF_PROG_LOAD bpf_signature=OK action=ALLOW

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 security/ipe/Kconfig         | 14 +++++++
 security/ipe/audit.c         | 15 ++++++++
 security/ipe/eval.c          | 73 +++++++++++++++++++++++++++++++++++-
 security/ipe/eval.h          |  5 +++
 security/ipe/hooks.c         | 37 ++++++++++++++++++
 security/ipe/hooks.h         | 11 ++++++
 security/ipe/ipe.c           |  3 ++
 security/ipe/policy.h        | 14 +++++++
 security/ipe/policy_parser.c | 27 +++++++++++++
 9 files changed, 198 insertions(+), 1 deletion(-)

diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index a110a6cd848b7..4c1d46847582b 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -95,6 +95,20 @@ config IPE_PROP_FS_VERITY_BUILTIN_SIG
 
 	  if unsure, answer Y.
 
+config IPE_PROP_BPF_SIGNATURE
+	bool "Enable support for Hornet BPF program signature verification"
+	depends on SECURITY_HORNET
+	help
+	  This option enables the 'bpf_signature' and 'bpf_keyring'
+	  properties within IPE policies. The 'bpf_signature' property
+	  allows IPE to make policy decisions based on the integrity
+	  verdict provided by the Hornet LSM when a BPF program is loaded.
+	  Verdicts include OK, UNSIGNED, PARTIALSIG, BADSIG, and others.
+	  The 'bpf_keyring' property allows policies to match against the
+	  keyring specified in bpf_attr (BUILTIN, SECONDARY, PLATFORM).
+
+	  If unsure, answer Y.
+
 endmenu
 
 config SECURITY_IPE_KUNIT_TEST
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 3f0deeb549127..251c6ec2f8423 100644
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
@@ -62,6 +64,19 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"fsverity_digest=",
 	"fsverity_signature=FALSE",
 	"fsverity_signature=TRUE",
+	"bpf_signature=NONE",
+	"bpf_signature=OK",
+	"bpf_signature=UNSIGNED",
+	"bpf_signature=PARTIALSIG",
+	"bpf_signature=UNKNOWNKEY",
+	"bpf_signature=UNEXPECTED",
+	"bpf_signature=FAULT",
+	"bpf_signature=BADSIG",
+	"bpf_keyring=BUILTIN",
+	"bpf_keyring=SECONDARY",
+	"bpf_keyring=PLATFORM",
+	"bpf_kernel=FALSE",
+	"bpf_kernel=TRUE",
 };
 
 /**
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 21439c5be3364..9a6d583fea125 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -11,6 +11,7 @@
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
 #include <linux/fsverity.h>
+#include <linux/verification.h>
 
 #include "ipe.h"
 #include "eval.h"
@@ -265,8 +266,52 @@ static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+/**
+ * evaluate_bpf_sig() - Evaluate @ctx against a bpf_signature property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ * @expected: The expected lsm_integrity_verdict to match against.
+ *
+ * Return:
+ * * %true	- The current @ctx matches the expected verdict
+ * * %false	- The current @ctx doesn't match the expected verdict
+ */
+static bool evaluate_bpf_sig(const struct ipe_eval_ctx *const ctx,
+			     enum lsm_integrity_verdict expected)
+{
+	return ctx->bpf_verdict == expected;
+}
+#else
+static bool evaluate_bpf_sig(const struct ipe_eval_ctx *const ctx,
+			     enum lsm_integrity_verdict expected)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+/**
+ * evaluate_bpf_keyring() - Evaluate @ctx against a bpf_keyring property.
+ * @ctx: Supplies a pointer to the context being evaluated.
+ * @expected: The expected keyring_id to match against.
+ *
+ * Return:
+ * * %true	- The current @ctx matches the expected keyring
+ * * %false	- The current @ctx doesn't match the expected keyring
+ */
+static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
+				 s32 expected)
+{
+	return ctx->bpf_keyring_id == expected;
+}
+#else
+static bool evaluate_bpf_keyring(const struct ipe_eval_ctx *const ctx,
+				 s32 expected)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 /**
- * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
  * @p: Supplies a pointer to the property to be evaluated.
  *
@@ -297,6 +342,32 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return evaluate_fsv_sig_false(ctx);
 	case IPE_PROP_FSV_SIG_TRUE:
 		return evaluate_fsv_sig_true(ctx);
+	case IPE_PROP_BPF_SIG_NONE:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_NONE);
+	case IPE_PROP_BPF_SIG_OK:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_OK);
+	case IPE_PROP_BPF_SIG_UNSIGNED:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNSIGNED);
+	case IPE_PROP_BPF_SIG_PARTIALSIG:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_PARTIALSIG);
+	case IPE_PROP_BPF_SIG_UNKNOWNKEY:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNKNOWNKEY);
+	case IPE_PROP_BPF_SIG_UNEXPECTED:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_UNEXPECTED);
+	case IPE_PROP_BPF_SIG_FAULT:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_FAULT);
+	case IPE_PROP_BPF_SIG_BADSIG:
+		return evaluate_bpf_sig(ctx, LSM_INT_VERDICT_BADSIG);
+	case IPE_PROP_BPF_KEYRING_BUILTIN:
+		return evaluate_bpf_keyring(ctx, 0);
+	case IPE_PROP_BPF_KEYRING_SECONDARY:
+		return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERIFY_USE_SECONDARY_KEYRING);
+	case IPE_PROP_BPF_KEYRING_PLATFORM:
+		return evaluate_bpf_keyring(ctx, (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING);
+	case IPE_PROP_BPF_KERNEL_FALSE:
+		return !ctx->bpf_kernel;
+	case IPE_PROP_BPF_KERNEL_TRUE:
+		return ctx->bpf_kernel;
 	default:
 		return false;
 	}
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index fef65a36468cb..1578d83bafc10 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -52,6 +52,11 @@ struct ipe_eval_ctx {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	const struct ipe_inode *ipe_inode;
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	enum lsm_integrity_verdict bpf_verdict;
+	s32 bpf_keyring_id;
+	bool bpf_kernel;
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 enum ipe_match {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 0ae54a880405a..03541e5bb7f60 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -340,3 +340,40 @@ int ipe_inode_setintegrity(const struct inode *inode,
 	return -EINVAL;
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+/**
+ * ipe_bpf_prog_load_post_integrity() - ipe security hook for BPF program load.
+ * @prog: Supplies the BPF program being loaded.
+ * @attr: Supplies the bpf syscall attributes.
+ * @token: Supplies the BPF token, if any.
+ * @kernel: Whether the call originated from the kernel.
+ * @lsmid: Supplies the LSM ID of the integrity provider.
+ * @verdict: Supplies the integrity verdict from the provider (e.g. Hornet).
+ *
+ * This LSM hook is called after an integrity verification LSM (such as Hornet)
+ * has evaluated a BPF program's cryptographic signature. IPE uses the verdict
+ * to make a policy-based allow/deny decision.
+ *
+ * Return:
+ * * %0		- Success
+ * * %-EACCES	- Did not pass IPE policy
+ */
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+				     union bpf_attr *attr,
+				     struct bpf_token *token,
+				     bool kernel,
+				     const struct lsm_id *lsmid,
+				     enum lsm_integrity_verdict verdict)
+{
+	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
+
+	ctx.op = IPE_OP_BPF_PROG_LOAD;
+	ctx.hook = IPE_HOOK_BPF_PROG_LOAD;
+	ctx.bpf_verdict = verdict;
+	ctx.bpf_keyring_id = attr->keyring_id;
+	ctx.bpf_kernel = kernel;
+
+	return ipe_evaluate_event(&ctx);
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 07db373327402..95b74f7899750 100644
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
 
@@ -52,4 +54,13 @@ int ipe_inode_setintegrity(const struct inode *inode, enum lsm_integrity_type ty
 			   const void *value, size_t size);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+				     union bpf_attr *attr,
+				     struct bpf_token *token,
+				     bool kernel,
+				     const struct lsm_id *lsmid,
+				     enum lsm_integrity_verdict verdict);
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b8..6502d4ddc641c 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -60,6 +60,9 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_post_integrity),
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 /**
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 5bfbdbddeef86..748bea92beb19 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -17,6 +17,7 @@ enum ipe_op_type {
 	IPE_OP_KEXEC_INITRAMFS,
 	IPE_OP_POLICY,
 	IPE_OP_X509,
+	IPE_OP_BPF_PROG_LOAD,
 	__IPE_OP_MAX,
 };
 
@@ -39,6 +40,19 @@ enum ipe_prop_type {
 	IPE_PROP_FSV_DIGEST,
 	IPE_PROP_FSV_SIG_FALSE,
 	IPE_PROP_FSV_SIG_TRUE,
+	IPE_PROP_BPF_SIG_NONE,
+	IPE_PROP_BPF_SIG_OK,
+	IPE_PROP_BPF_SIG_UNSIGNED,
+	IPE_PROP_BPF_SIG_PARTIALSIG,
+	IPE_PROP_BPF_SIG_UNKNOWNKEY,
+	IPE_PROP_BPF_SIG_UNEXPECTED,
+	IPE_PROP_BPF_SIG_FAULT,
+	IPE_PROP_BPF_SIG_BADSIG,
+	IPE_PROP_BPF_KEYRING_BUILTIN,
+	IPE_PROP_BPF_KEYRING_SECONDARY,
+	IPE_PROP_BPF_KEYRING_PLATFORM,
+	IPE_PROP_BPF_KERNEL_FALSE,
+	IPE_PROP_BPF_KERNEL_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 6fa5bebf84714..71f63de56616b 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -237,6 +237,7 @@ static const match_table_t operation_tokens = {
 	{IPE_OP_KEXEC_INITRAMFS,	"op=KEXEC_INITRAMFS"},
 	{IPE_OP_POLICY,			"op=POLICY"},
 	{IPE_OP_X509,			"op=X509_CERT"},
+	{IPE_OP_BPF_PROG_LOAD,		"op=BPF_PROG_LOAD"},
 	{IPE_OP_INVALID,		NULL}
 };
 
@@ -281,6 +282,19 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_FSV_DIGEST,		"fsverity_digest=%s"},
 	{IPE_PROP_FSV_SIG_FALSE,	"fsverity_signature=FALSE"},
 	{IPE_PROP_FSV_SIG_TRUE,		"fsverity_signature=TRUE"},
+	{IPE_PROP_BPF_SIG_NONE,		"bpf_signature=NONE"},
+	{IPE_PROP_BPF_SIG_OK,		"bpf_signature=OK"},
+	{IPE_PROP_BPF_SIG_UNSIGNED,	"bpf_signature=UNSIGNED"},
+	{IPE_PROP_BPF_SIG_PARTIALSIG,	"bpf_signature=PARTIALSIG"},
+	{IPE_PROP_BPF_SIG_UNKNOWNKEY,	"bpf_signature=UNKNOWNKEY"},
+	{IPE_PROP_BPF_SIG_UNEXPECTED,	"bpf_signature=UNEXPECTED"},
+	{IPE_PROP_BPF_SIG_FAULT,	"bpf_signature=FAULT"},
+	{IPE_PROP_BPF_SIG_BADSIG,	"bpf_signature=BADSIG"},
+	{IPE_PROP_BPF_KEYRING_BUILTIN,	"bpf_keyring=BUILTIN"},
+	{IPE_PROP_BPF_KEYRING_SECONDARY,	"bpf_keyring=SECONDARY"},
+	{IPE_PROP_BPF_KEYRING_PLATFORM,	"bpf_keyring=PLATFORM"},
+	{IPE_PROP_BPF_KERNEL_FALSE,	"bpf_kernel=FALSE"},
+	{IPE_PROP_BPF_KERNEL_TRUE,	"bpf_kernel=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -331,6 +345,19 @@ static int parse_property(char *t, struct ipe_rule *r)
 	case IPE_PROP_DMV_SIG_TRUE:
 	case IPE_PROP_FSV_SIG_FALSE:
 	case IPE_PROP_FSV_SIG_TRUE:
+	case IPE_PROP_BPF_SIG_NONE:
+	case IPE_PROP_BPF_SIG_OK:
+	case IPE_PROP_BPF_SIG_UNSIGNED:
+	case IPE_PROP_BPF_SIG_PARTIALSIG:
+	case IPE_PROP_BPF_SIG_UNKNOWNKEY:
+	case IPE_PROP_BPF_SIG_UNEXPECTED:
+	case IPE_PROP_BPF_SIG_FAULT:
+	case IPE_PROP_BPF_SIG_BADSIG:
+	case IPE_PROP_BPF_KEYRING_BUILTIN:
+	case IPE_PROP_BPF_KEYRING_SECONDARY:
+	case IPE_PROP_BPF_KEYRING_PLATFORM:
+	case IPE_PROP_BPF_KERNEL_FALSE:
+	case IPE_PROP_BPF_KERNEL_TRUE:
 		p->type = token;
 		break;
 	default:
-- 
2.53.0

