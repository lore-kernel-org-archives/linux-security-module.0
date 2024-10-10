Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D901919D880;
	Thu, 10 Oct 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582196; cv=none; b=j21gL1GrCT0jdU4yzy1YMsR4+IaeeyOlf0lUIoAkWpFBZdX3Lp7VpoYr26NCC97t6otrVw3c1Qh3jB0njLSG+twEvXkKlODvMbqfSPYKYXi5uY3tV7fG3Y0l/1ZP1fe8eoub/pqhQn1aWFcCV45AzuHwQYg0/JSp0oNWz0iUl2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582196; c=relaxed/simple;
	bh=5Ral5SCk0zqXFGrByZZ20HawBOKvjeHD46WrEHKarUw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IFNEhnfchlAeaA3vvZia9teEN89ZB8ViMWBbR4Ed7OW/SouZ4m6BDuevVJe8Xwd1i53yLZ7IWpwtS23MrGd9SoKnc25qrje5ijWo8bV6fmI/AaV3nkPfJOdaMLXbOu7AW8ZtuTS3pck3mK7xKTlwe48/1NvyYIlzrAzOd1aVDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AKuV7np7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AKuV7np7"
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 66ABE20DEAB1; Thu, 10 Oct 2024 10:43:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66ABE20DEAB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728582194;
	bh=fg30yrz7Ppq6rRRoSzlGA6z7azUJrniMIn14BcLgHro=;
	h=From:To:Cc:Subject:Date:From;
	b=AKuV7np7mO71AR024I8CS+CWNTItbAnxbHFZLt0I5XFi+viY0RmRkKWtVAnfScfnM
	 pQZMXLiSJ2qGf/WnehSDpX/ocq/+6lTRajLYsvRQr6Vy0oAWPFW1J3gPhBTkl7bzRp
	 gNNzNOX63QBa8dKQmZEubVB9xknbvyvNMsUrXToI=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	jmorris@namei.org,
	paul@paul-moore.com,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v1] ipe: add 'anonymous_memory' property for policy decisions
Date: Thu, 10 Oct 2024 10:42:37 -0700
Message-Id: <1728582157-13884-1-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

Currently, all existing IPE properties evaluate to FALSE for
operations triggered by anonymous memory regions. As a result,
IPE falls back to the policy's default action for such operations.

In policies where the default action is DENY, this behavior blocks
all anonymous memory operations, rendering binaries that rely on
anonymous memory unusable.

This commit introduces a new IPE property, 'anonymous_memory',
which evaluates to TRUE when an operation is triggered by an
anonymous memory region. This allows administrators to explicitly
allow or deny operations involving anonymous memory.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/ipe.rst | 11 +++++++++++
 Documentation/security/ipe.rst        |  9 +++++----
 security/ipe/Kconfig                  | 10 ++++++++++
 security/ipe/audit.c                  |  2 ++
 security/ipe/eval.c                   | 26 ++++++++++++++++++++++++++
 security/ipe/policy.h                 |  2 ++
 security/ipe/policy_parser.c          |  4 ++++
 7 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f93a467db628..356f0dd6e4c3 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -669,6 +669,17 @@ fsverity_signature
 
       fsverity_signature=(TRUE|FALSE)
 
+anonymous_memory
+~~~~~~~~~~~~~~~~
+
+   This property can be used to allow or deny operations triggered by
+   anonymous memory. It evaluates to TRUE when a memory region
+   in the evaluation context is not backed by a file. It is controlled by
+   the ``IPE_PROP_ANONYMOUS_MEMORY`` config option.
+   The format of this property is::
+
+      anonymous_memory=(TRUE|FALSE)
+
 Policy Examples
 ---------------
 
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4a7d953abcdc..1606484241cb 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -385,15 +385,16 @@ Anonymous Memory
 Anonymous memory isn't treated any differently from any other access in IPE.
 When anonymous memory is mapped with ``+X``, it still comes into the ``file_mmap``
 or ``file_mprotect`` hook, but with a ``NULL`` file object. This is submitted to
-the evaluation, like any other file. However, all current trust properties will
-evaluate to false, as they are all file-based and the operation is not
-associated with a file.
+the evaluation, like any other file. However, except the ``anonymous_memory`` property,
+all current trust properties will evaluate to false, as they are all file-based and
+the operation is not associated with a file.
 
 .. WARNING::
 
   This also occurs with the ``kernel_load_data`` hook, when the kernel is
   loading data from a userspace buffer that is not backed by a file. In this
-  scenario all current trust properties will also evaluate to false.
+  scenario, all current trust properties except ``anonymous_memory`` will also evaluate
+  to false.
 
 Securityfs Interface
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index ee6beca5494a..839a554f4e17 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -94,6 +94,16 @@ config IPE_PROP_FS_VERITY_BUILTIN_SIG
 
 	  if unsure, answer Y.
 
+config IPE_PROP_ANONYMOUS_MEMORY
+	bool "Enable support for anonymous memory"
+	default y
+	help
+	  This option enables the 'anonymous_memory' property within IPE
+	  policies. The property evaluates to TRUE when a memory region
+	  in the evaluation context is not backed by a file (i.e., it is
+	  anonymous memory).
+
+	  if unsure, answer Y.
 endmenu
 
 config SECURITY_IPE_KUNIT_TEST
diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f05f0caa4850..ab5217655910 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -59,6 +59,8 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
 	"fsverity_digest=",
 	"fsverity_signature=FALSE",
 	"fsverity_signature=TRUE",
+	"anonymous_memory=FALSE",
+	"anonymous_memory=TRUE",
 };
 
 /**
diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 21439c5be336..e2ab7a8d7d8c 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -265,6 +265,28 @@ static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+static bool evaluate_anonymous_memory_false(const struct ipe_eval_ctx *const ctx)
+{
+	return !ctx->file;
+}
+
+static bool evaluate_anonymous_memory_true(const struct ipe_eval_ctx *const ctx)
+{
+	return !evaluate_anonymous_memory_false(ctx);
+}
+#else
+static bool evaluate_anonymous_memory_false(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+
+static bool evaluate_anonymous_memory_true(const struct ipe_eval_ctx *const ctx)
+{
+	return false;
+}
+#endif /* CONFIG_IPE_PROP_ANONYMOUS_MEMORY */
+
 /**
  * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
@@ -297,6 +319,10 @@ static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
 		return evaluate_fsv_sig_false(ctx);
 	case IPE_PROP_FSV_SIG_TRUE:
 		return evaluate_fsv_sig_true(ctx);
+	case IPE_PROP_ANON_MEM_FALSE:
+		return evaluate_anonymous_memory_false(ctx);
+	case IPE_PROP_ANON_MEM_TRUE:
+		return evaluate_anonymous_memory_true(ctx);
 	default:
 		return false;
 	}
diff --git a/security/ipe/policy.h b/security/ipe/policy.h
index 5bfbdbddeef8..0becc2d2bd33 100644
--- a/security/ipe/policy.h
+++ b/security/ipe/policy.h
@@ -39,6 +39,8 @@ enum ipe_prop_type {
 	IPE_PROP_FSV_DIGEST,
 	IPE_PROP_FSV_SIG_FALSE,
 	IPE_PROP_FSV_SIG_TRUE,
+	IPE_PROP_ANON_MEM_FALSE,
+	IPE_PROP_ANON_MEM_TRUE,
 	__IPE_PROP_MAX
 };
 
diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
index 7f27e39931d6..5c83095e7c37 100644
--- a/security/ipe/policy_parser.c
+++ b/security/ipe/policy_parser.c
@@ -281,6 +281,8 @@ static const match_table_t property_tokens = {
 	{IPE_PROP_FSV_DIGEST,		"fsverity_digest=%s"},
 	{IPE_PROP_FSV_SIG_FALSE,	"fsverity_signature=FALSE"},
 	{IPE_PROP_FSV_SIG_TRUE,		"fsverity_signature=TRUE"},
+	{IPE_PROP_ANON_MEM_FALSE,	"anonymous_memory=FALSE"},
+	{IPE_PROP_ANON_MEM_TRUE,	"anonymous_memory=TRUE"},
 	{IPE_PROP_INVALID,		NULL}
 };
 
@@ -331,6 +333,8 @@ static int parse_property(char *t, struct ipe_rule *r)
 	case IPE_PROP_DMV_SIG_TRUE:
 	case IPE_PROP_FSV_SIG_FALSE:
 	case IPE_PROP_FSV_SIG_TRUE:
+	case IPE_PROP_ANON_MEM_FALSE:
+	case IPE_PROP_ANON_MEM_TRUE:
 		p->type = token;
 		break;
 	default:
-- 
2.46.2

