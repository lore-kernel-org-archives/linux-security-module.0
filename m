Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99D1EB5C2;
	Wed, 29 Apr 2026 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490108; cv=none; b=GE1RYegXtGG/UWbedJXlZoTJq7Runagio4qQa25/JXBzll8w+0TgGU122TpAcgO+teCEIqd+hDQaSodwdX+H1671BkQJ0nkLiUHxhXrDOmnue6hBsXHzy2Q/dITOJiWrU3hi9pRpv1w0ErxcCPmqS+4ZorXI81Miq7imBEx+vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490108; c=relaxed/simple;
	bh=lgWm2YK1mr9MOc/o7cKo51xJjTAgcFd25zWsMER5Q3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn1PKrNjECp4PkdjVsjkE6tk5xrhttW52m/bXyLP77/j3X8MtPlUU8Ydr2ft19p0tE4E5OXzYLeqr9cTb/kW+2FP1Bhqg7Va6tkCyzBBGgqZZCoXBNqOo5aNT9j+kzXtdgMtaelmTAZOG4QxAJ3ZsI4eNcBFydt/86CNZS/ZBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SqRX84c7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SqRX84c7"
Received: from narnia.corp.microsoft.com (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id D38AF20B7172;
	Wed, 29 Apr 2026 12:15:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D38AF20B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777490105;
	bh=SmavXUd8wxbwobaWFtp0hkIC2iLG4gZhCGYYeb0DHZI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SqRX84c7E0O9zuuy68S0S61EGnPhB0j9bPrQu1T6iu8ZVEe5VndgS9an6e9ccCj5U
	 pL1oT408UcWoewltWiCRRtJ4cQv3ZWjzULbCqgwJPTMSGrjF4CqrGIWu7bBs+tFk3n
	 ioyPnCQo6sG8Iw5eFpDB8rQmGmsOpNLSayFHf0i0=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	"Fan Wu" <wufan@kernel.org>,
	"Ryan Foster" <foster.ryan.r@gmail.com>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"Song Liu" <song@kernel.org>
Subject: [v6 10/10] ipe: Add BPF program load policy enforcement via Hornet integration
Date: Wed, 29 Apr 2026 12:14:15 -0700
Message-ID: <20260429191431.2345448-11-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
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

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 162 +++++++++++++++++++++++++-
 Documentation/security/ipe.rst        |  39 +++++++
 security/ipe/Kconfig                  |  14 +++
 security/ipe/audit.c                  |  15 +++
 security/ipe/eval.c                   |  73 +++++++++++-
 security/ipe/eval.h                   |  11 ++
 security/ipe/hooks.c                  |  63 ++++++++++
 security/ipe/hooks.h                  |  15 +++
 security/ipe/ipe.c                    |  14 +++
 security/ipe/ipe.h                    |   3 +
 security/ipe/policy.h                 |  14 +++
 security/ipe/policy_parser.c          |  27 +++++
 12 files changed, 448 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index a756d81585317..4dfbf0d325a8a 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -559,7 +559,8 @@ policy. Two properties are built-into the policy parser: 'op' and 'action'.
 The other properties are used to restrict immutable security properties
 about the files being evaluated. Currently those properties are:
 '``boot_verified``', '``dmverity_signature``', '``dmverity_roothash``',
-'``fsverity_signature``', '``fsverity_digest``'. A description of all
+'``fsverity_signature``', '``fsverity_digest``', '``bpf_signature``',
+'``bpf_keyring``', '``bpf_kernel``'. A description of all
 properties supported by IPE are listed below:
 
 op
@@ -603,6 +604,14 @@ as the first token. IPE supports the following operations:
       Controls loading IMA certificates through the Kconfigs,
       ``CONFIG_IMA_X509_PATH`` and ``CONFIG_EVM_X509_PATH``.
 
+   ``BPF_PROG_LOAD``:
+
+      Pertains to BPF programs being loaded via the ``bpf()`` syscall.
+      This operation is used in conjunction with the ``bpf_signature``,
+      ``bpf_keyring``, and ``bpf_kernel`` properties to control BPF
+      program loading based on integrity verification provided by the
+      Hornet LSM.
+
 action
 ~~~~~~
 
@@ -713,6 +722,105 @@ fsverity_signature
 
       fsverity_signature=(TRUE|FALSE)
 
+bpf_signature
+~~~~~~~~~~~~~
+
+   This property can be utilized for authorization of BPF program loads based
+   on the integrity verdict provided by the Hornet LSM. When a BPF program is
+   loaded, Hornet performs cryptographic verification of the program's PKCS#7
+   signature (if present) and passes an integrity verdict to IPE via the
+   ``security_bpf_prog_load_post_integrity`` hook. IPE can then allow or deny
+   the load based on the verdict.
+
+   This property depends on ``SECURITY_HORNET`` and is controlled by the
+   ``IPE_PROP_BPF_SIGNATURE`` config option.
+   The format of this property is::
+
+      bpf_signature=(NONE|OK|UNSIGNED|PARTIALSIG|UNKNOWNKEY|UNEXPECTED|FAULT|BADSIG)
+
+   The possible values correspond to the integrity verdicts from Hornet:
+
+      ``NONE``
+
+         No integrity verdict was set (default/uninitialized).
+
+      ``OK``
+
+         The BPF program's signature and all map hashes were successfully
+         verified.
+
+      ``UNSIGNED``
+
+         No signature was provided with the BPF program.
+
+      ``PARTIALSIG``
+
+         The program signature was verified, but no authenticated map hash
+         data was present.
+
+      ``UNKNOWNKEY``
+
+         The signing certificate is not trusted by the specified keyring.
+
+      ``UNEXPECTED``
+
+         An unexpected map hash value was encountered during verification.
+
+      ``FAULT``
+
+         A system error occurred during signature verification.
+
+      ``BADSIG``
+
+         The signature or hash verification failed.
+
+bpf_keyring
+~~~~~~~~~~~~
+
+   This property can be utilized for authorization of BPF program loads based
+   on the keyring specified in the ``bpf_attr`` during the ``BPF_PROG_LOAD``
+   syscall. This allows policies to restrict which keyring must be used for
+   signature verification of BPF programs.
+
+   This property shares the ``IPE_PROP_BPF_SIGNATURE`` config option with
+   ``bpf_signature``.
+   The format of this property is::
+
+      bpf_keyring=(BUILTIN|SECONDARY|PLATFORM)
+
+   The possible values correspond to the system keyrings:
+
+      ``BUILTIN``
+
+         The builtin trusted keyring (``.builtin_trusted_keys``), which
+         contains keys embedded at kernel compile time.
+
+      ``SECONDARY``
+
+         The secondary trusted keyring (``.secondary_trusted_keys``), which
+         includes both builtin trusted keys and keys added at runtime.
+
+      ``PLATFORM``
+
+         The platform keyring (``.platform``), which contains keys provided
+         by the platform firmware (e.g. UEFI db keys).
+
+bpf_kernel
+~~~~~~~~~~
+
+   This property can be utilized for authorization of BPF program loads based
+   on whether the load originated from kernel space or user space. The BPF
+   light skeleton infrastructure performs a secondary kernel-originated program
+   load that will not carry a signature. This property allows policies to
+   permit such kernel-originated loads while still requiring signatures for
+   user-space loads.
+
+   This property shares the ``IPE_PROP_BPF_SIGNATURE`` config option with
+   ``bpf_signature``.
+   The format of this property is::
+
+      bpf_kernel=(TRUE|FALSE)
+
 Policy Examples
 ---------------
 
@@ -788,6 +896,58 @@ Allow execution of a specific fs-verity file
 
    op=EXECUTE fsverity_digest=sha256:fd88f2b8824e197f850bf4c5109bea5cf0ee38104f710843bb72da796ba5af9e action=ALLOW
 
+Allow only signed BPF programs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_Signed_BPF policy_version=0.0.0
+   DEFAULT action=ALLOW
+
+   DEFAULT op=BPF_PROG_LOAD action=DENY
+   op=BPF_PROG_LOAD bpf_kernel=TRUE action=ALLOW
+   op=BPF_PROG_LOAD bpf_signature=OK action=ALLOW
+
+This policy allows all other operations but restricts BPF program loading
+to only programs that either originate from kernel space (e.g. light skeleton
+reloads) or have a valid signature verified by the Hornet LSM. Unsigned or
+improperly signed BPF programs from user space will be denied.
+
+Allow signed BPF programs from a specific keyring
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_BPF_Builtin_Keyring policy_version=0.0.0
+   DEFAULT action=ALLOW
+
+   DEFAULT op=BPF_PROG_LOAD action=DENY
+   op=BPF_PROG_LOAD bpf_kernel=TRUE action=ALLOW
+   op=BPF_PROG_LOAD bpf_signature=OK bpf_keyring=BUILTIN action=ALLOW
+
+This policy further restricts BPF program loading to only accept programs
+whose signatures were verified using the builtin trusted keyring. Programs
+signed against the secondary or platform keyrings will be denied, providing
+tighter control over which signing keys are acceptable.
+
+Allow signed BPF programs with relaxed partial signatures
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name=Allow_BPF_Partial policy_version=0.0.0
+   DEFAULT action=ALLOW
+
+   DEFAULT op=BPF_PROG_LOAD action=DENY
+   op=BPF_PROG_LOAD bpf_kernel=TRUE action=ALLOW
+   op=BPF_PROG_LOAD bpf_signature=OK action=ALLOW
+   op=BPF_PROG_LOAD bpf_signature=PARTIALSIG action=ALLOW
+
+This policy allows BPF programs that have been fully verified (``OK``) as
+well as programs with a valid program signature but without authenticated
+map hash data (``PARTIALSIG``). This can be useful during development or
+for programs that do not use maps.
+
 Additional Information
 ----------------------
 
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4a7d953abcdc3..de8fcf1dc173d 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -412,6 +412,44 @@ a standard securityfs policy tree::
 
 The policy is stored in the ``->i_private`` data of the MyPolicy inode.
 
+BPF/Hornet Integration
+~~~~~~~~~~~~~~~~~~~~~~
+
+IPE integrates with the Hornet LSM to enforce integrity policies on BPF
+program loading. Hornet performs cryptographic verification of BPF program
+signatures (PKCS#7 with authenticated attributes containing map hashes) and
+provides an integrity verdict to IPE via the
+``security_bpf_prog_load_post_integrity`` hook.
+
+The hook flow is:
+
+  1. User space invokes ``BPF_PROG_LOAD`` via the ``bpf()`` syscall.
+  2. Hornet's ``bpf_prog_load_integrity`` hook calls ``hornet_check_program()``
+     to verify the program's signature and map hashes.
+  3. Hornet calls ``security_bpf_prog_load_post_integrity()`` with the
+     resulting ``lsm_integrity_verdict``.
+  4. IPE evaluates the verdict against the active policy's ``BPF_PROG_LOAD``
+     rules and returns ``-EACCES`` if denied.
+
+Three properties are available for BPF policy rules:
+
+  - ``bpf_signature``: Matches against the integrity verdict (OK, UNSIGNED,
+    BADSIG, etc.)
+  - ``bpf_keyring``: Matches against the keyring specified in ``bpf_attr``
+    (BUILTIN, SECONDARY, PLATFORM)
+  - ``bpf_kernel``: Matches whether the load originated from kernel space
+    (TRUE/FALSE). This is important because the BPF light skeleton
+    infrastructure performs a secondary kernel-originated program load that
+    does not carry a signature.
+
+All three properties are gated on ``CONFIG_IPE_PROP_BPF_SIGNATURE`` which
+depends on ``CONFIG_SECURITY_HORNET``.
+
+The evaluation context (``struct ipe_eval_ctx``) carries three BPF-specific
+fields: ``bpf_verdict`` (the integrity verdict enum), ``bpf_keyring_id``
+(the ``s32`` keyring ID from ``bpf_attr``), and ``bpf_kernel`` (bool
+indicating kernel origin).
+
 Tests
 -----
 
@@ -439,6 +477,7 @@ IPE has KUnit Tests for the policy parser. Recommended kunitconfig::
   CONFIG_IPE_PROP_DM_VERITY_SIGNATURE=y
   CONFIG_IPE_PROP_FS_VERITY=y
   CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG=y
+  CONFIG_IPE_PROP_BPF_SIGNATURE=y
   CONFIG_SECURITY_IPE_KUNIT_TEST=y
 
 In addition, IPE has a python based integration
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
index fef65a36468cb..b061cb5ade27e 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -37,6 +37,12 @@ struct ipe_inode {
 };
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+struct ipe_bpf_prog {
+	enum lsm_integrity_verdict verdict;
+};
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 struct ipe_eval_ctx {
 	enum ipe_op_type op;
 	enum ipe_hook_type hook;
@@ -52,6 +58,11 @@ struct ipe_eval_ctx {
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
index 0ae54a880405a..9271e129a2cf2 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -340,3 +340,66 @@ int ipe_inode_setintegrity(const struct inode *inode,
 	return -EINVAL;
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+/**
+ * ipe_bpf_prog_load_post_integrity() - Store integrity verdict in per-prog blob.
+ * @prog: Supplies the BPF program being loaded.
+ * @attr: Supplies the bpf syscall attributes.
+ * @token: Supplies the BPF token, if any.
+ * @kernel: Whether the call originated from the kernel.
+ * @lsmid: Supplies the LSM ID of the integrity provider.
+ * @verdict: Supplies the integrity verdict from the provider (e.g. Hornet).
+ *
+ * This hook stores the integrity verdict in IPE's per-prog security blob
+ * so that ipe_bpf_prog_load() can later read it for policy evaluation.
+ *
+ * Return:
+ * * %0		- Always succeeds (policy is evaluated in bpf_prog_load)
+ */
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+				     union bpf_attr *attr,
+				     struct bpf_token *token,
+				     bool kernel,
+				     const struct lsm_id *lsmid,
+				     enum lsm_integrity_verdict verdict)
+{
+	struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
+
+	blob->verdict = verdict;
+
+	return 0;
+}
+
+/**
+ * ipe_bpf_prog_load() - IPE policy evaluation for BPF program load.
+ * @prog: Supplies the BPF program being loaded.
+ * @attr: Supplies the bpf syscall attributes.
+ * @token: Supplies the BPF token, if any.
+ * @kernel: Whether the call originated from the kernel.
+ *
+ * Reads the integrity verdict previously stored by post_integrity (if any)
+ * and evaluates IPE policy. If no integrity provider ran, the verdict
+ * defaults to LSM_INT_VERDICT_NONE.
+ *
+ * Return:
+ * * %0		- Success
+ * * %-EACCES	- Did not pass IPE policy
+ */
+int ipe_bpf_prog_load(struct bpf_prog *prog,
+		      union bpf_attr *attr,
+		      struct bpf_token *token,
+		      bool kernel)
+{
+	struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
+	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
+
+	ctx.op = IPE_OP_BPF_PROG_LOAD;
+	ctx.hook = IPE_HOOK_BPF_PROG_LOAD;
+	ctx.bpf_verdict = blob->verdict;
+	ctx.bpf_keyring_id = attr->keyring_id;
+	ctx.bpf_kernel = kernel;
+
+	return ipe_evaluate_event(&ctx);
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 07db373327402..8a6d1a459e00c 100644
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
 
@@ -52,4 +54,17 @@ int ipe_inode_setintegrity(const struct inode *inode, enum lsm_integrity_type ty
 			   const void *value, size_t size);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
+				     union bpf_attr *attr,
+				     struct bpf_token *token,
+				     bool kernel,
+				     const struct lsm_id *lsmid,
+				     enum lsm_integrity_verdict verdict);
+int ipe_bpf_prog_load(struct bpf_prog *prog,
+		      union bpf_attr *attr,
+		      struct bpf_token *token,
+		      bool kernel);
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b8..5af13903287fe 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -19,6 +19,9 @@ static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	.lbs_inode = sizeof(struct ipe_inode),
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	.lbs_bpf_prog = sizeof(struct ipe_bpf_prog),
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 static const struct lsm_id ipe_lsmid = {
@@ -45,6 +48,13 @@ struct ipe_inode *ipe_inode(const struct inode *inode)
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+struct ipe_bpf_prog *ipe_bpf_prog(const struct bpf_prog *prog)
+{
+	return prog->aux->security + ipe_blobs.lbs_bpf_prog;
+}
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
 	LSM_HOOK_INIT(bprm_creds_for_exec, ipe_bprm_creds_for_exec),
@@ -60,6 +70,10 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+	LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_post_integrity),
+	LSM_HOOK_INIT(bpf_prog_load, ipe_bpf_prog_load),
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 };
 
 /**
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index 25cfdb8f0c20a..47de32b5bc938 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -22,6 +22,9 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
+struct ipe_bpf_prog *ipe_bpf_prog(const struct bpf_prog *prog);
+#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 
 int ipe_init_securityfs(void);
 
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

