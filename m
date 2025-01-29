Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C452E1E3793;
	Wed, 29 Jan 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738183242; cv=none; b=GF2/NPlJhY6IdMYPW5qjvxUACfS0WEpvByXy7JYG/T5YGNu5Ilnf8hbSmcbRPHZM7eKbocBlDWyiUHqxirCt/b7e6K9M0/JLsptqkO6AnmYGrHTyN3P4GhW/SV7QDqv4DeJ8mdqE/mFo6LPUv+mP/HIUALdj2unNLUa1SaB2LS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738183242; c=relaxed/simple;
	bh=+iGuA4m5n7VaG2pbvt1ixM40vi20HtiXYCsYX92UMrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=US61jG3Lxd+KR55SCHAUU8tab1jFq8EB+XgPYMPLiDB5SCWIakK27Xd8zzElFbCn3iWkBbiT7/mWgfrxrsS9NSE1hfpBLrvl+og+sawUYnnrgfoeXxKnl0VPSKrp++v+japM2JLNcPE6zbwE5toEnrJ4fvFvEzf0S3kQ/P7uZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVXogvjD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVXogvjD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC02C4CEE2;
	Wed, 29 Jan 2025 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738183240;
	bh=+iGuA4m5n7VaG2pbvt1ixM40vi20HtiXYCsYX92UMrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVXogvjDfJl3zZPRq+ZjuAaYmt5NUj0aJTXVyHZqGlfsxXEzd311ko6pdtMHilX9b
	 J8hW6CL99xN+NTHLkDlJAY0Zi7gvOApfyg79ztM78J45yW3vh5sF72maBM5PD2u3u+
	 sz2jVq3ganTkkd24gCUcQRMqwnyoVcX2gZuqeYTRorTLeMqhOoeKA81SXwCe055mP1
	 LwDHUUz/B2UquvWtiDsJCqrnMKWHC9E11j9asDVAkUXsxHuftzxQJE224NlnDVkR3j
	 6gIjnfMjmscbsd9h8MK4dJcV3FnC/xDK+GSyJ0GaetbY+3hrjWYhZ3ow/mkrh6v7Eu
	 LtbejmuoRx2Ow==
From: wufan@kernel.org
To: corbet@lwn.net,
	jmorris@namei.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	akpm@linux-foundation.org
Cc: linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@kernel.org>
Subject: [RFC PATCH v2 2/2] ipe: add 'anonymous_memory' property for policy decisions
Date: Wed, 29 Jan 2025 20:39:32 +0000
Message-Id: <20250129203932.22165-3-wufan@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250129203932.22165-1-wufan@kernel.org>
References: <20250129203932.22165-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Wu <wufan@kernel.org>

Currently, all existing IPE properties evaluate to FALSE for
operations triggered by anonymous memory regions or memfd. As a result,
IPE falls back to the policy's default action for such operations.

In policies where the default action is DENY, this behavior blocks
all anonymous memory related operations, rendering binaries that rely on
anonymous memory, e.g. JIT engine, unusable.

This commit introduces a new IPE property, 'anonymous_memory',
which evaluates to TRUE when an operation is triggered by an
anonymous memory region or memfd. This allows administrators to
explicitly allow or deny operations involving anonymous memory.

Signed-off-by: Fan Wu <wufan@kernel.org>
---
 Documentation/admin-guide/LSM/ipe.rst | 12 ++++++++++
 Documentation/security/ipe.rst        |  9 +++----
 security/ipe/Kconfig                  | 10 ++++++++
 security/ipe/audit.c                  |  2 ++
 security/ipe/eval.c                   | 34 +++++++++++++++++++++++----
 security/ipe/eval.h                   | 13 ++++++----
 security/ipe/hooks.c                  | 12 ++++++++++
 security/ipe/hooks.h                  |  4 ++++
 security/ipe/ipe.c                    |  7 ++++--
 security/ipe/policy.h                 |  2 ++
 security/ipe/policy_parser.c          |  4 ++++
 11 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
index f93a467db628..9de2e72f29d5 100644
--- a/Documentation/admin-guide/LSM/ipe.rst
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -669,6 +669,18 @@ fsverity_signature
 
       fsverity_signature=(TRUE|FALSE)
 
+anonymous_memory
+~~~~~~~~~~~~~~~~
+
+   This property can be used to allow or deny operations triggered by
+   anonymous memory. It evaluates to TRUE when a memory region
+   in the evaluation context is not backed by a physical file or it
+   is from a memory file descriptor. It is controlled by
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
index 3c75bf267da4..77520714e9ab 100644
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
+	  in the evaluation context is not backed by a physical file
+	  or it is from a memory file descriptor.
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
index 21439c5be336..38c7214c9889 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -52,8 +52,8 @@ static void build_ipe_bdev_ctx(struct ipe_eval_ctx *ctx, const struct inode *con
 }
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
-#ifdef CONFIG_IPE_PROP_FS_VERITY
-#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+#if defined(CONFIG_IPE_PROP_FS_VERITY) || defined(CONFIG_IPE_PROP_ANONYMOUS_MEMORY)
+#if defined(CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG) || defined(CONFIG_IPE_PROP_ANONYMOUS_MEMORY)
 static void build_ipe_inode_blob_ctx(struct ipe_eval_ctx *ctx,
 				     const struct inode *const ino)
 {
@@ -64,7 +64,7 @@ static inline void build_ipe_inode_blob_ctx(struct ipe_eval_ctx *ctx,
 					    const struct inode *const ino)
 {
 }
-#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#endif
 
 /**
  * build_ipe_inode_ctx() - Build inode fields of an evaluation context.
@@ -80,7 +80,7 @@ static void build_ipe_inode_ctx(struct ipe_eval_ctx *ctx, const struct inode *co
 static void build_ipe_inode_ctx(struct ipe_eval_ctx *ctx, const struct inode *const ino)
 {
 }
-#endif /* CONFIG_IPE_PROP_FS_VERITY */
+#endif
 
 /**
  * ipe_build_eval_ctx() - Build an ipe evaluation context.
@@ -265,6 +265,28 @@ static bool evaluate_fsv_sig_true(const struct ipe_eval_ctx *const ctx)
 }
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+static bool evaluate_anonymous_memory_false(const struct ipe_eval_ctx *const ctx)
+{
+	return ctx->file && !ctx->ipe_inode->memfd;
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
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index fef65a36468c..83b57d12a778 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -31,11 +31,16 @@ struct ipe_bdev {
 };
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
-#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+#if defined(CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG) || defined(CONFIG_IPE_PROP_ANONYMOUS_MEMORY)
 struct ipe_inode {
+#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	bool fs_verity_signed;
-};
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+	bool memfd;
+#endif /* CONFIG_IPE_PROP_ANONYMOUS_MEMORY */
+};
+#endif
 
 struct ipe_eval_ctx {
 	enum ipe_op_type op;
@@ -49,9 +54,9 @@ struct ipe_eval_ctx {
 #ifdef CONFIG_IPE_PROP_FS_VERITY
 	const struct inode *ino;
 #endif /* CONFIG_IPE_PROP_FS_VERITY */
-#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+#if defined(CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG) || defined(CONFIG_IPE_PROP_ANONYMOUS_MEMORY)
 	const struct ipe_inode *ipe_inode;
-#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#endif
 };
 
 enum ipe_match {
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..ce68f08ce343 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -312,3 +312,15 @@ int ipe_inode_setintegrity(const struct inode *inode,
 	return -EINVAL;
 }
 #endif /* CONFIG_CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+/**
+ * ipe_memfd_created() - Mark the current file as a memfd.
+ * @file: Supplies a pointer to the file structure being created.
+ */
+void ipe_memfd_created(struct file *file)
+{
+	ipe_inode(file->f_inode)->memfd = true;
+}
+#endif /* CONFIG_IPE_PROP_ANONYMOUS_MEMORY */
+
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 38d4a387d039..fa90db65ca88 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -49,4 +49,8 @@ int ipe_inode_setintegrity(const struct inode *inode, enum lsm_integrity_type ty
 			   const void *value, size_t size);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+void ipe_memfd_created(struct file *file);
+#endif /* CONFIG_IPE_PROP_ANONYMOUS_MEMORY */
+
 #endif /* _IPE_HOOKS_H */
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 4317134cb0da..330925b6a48e 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -16,9 +16,9 @@ static struct lsm_blob_sizes ipe_blobs __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_DM_VERITY
 	.lbs_bdev = sizeof(struct ipe_bdev),
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
-#ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
+#if defined(CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG) || defined(CONFIG_IPE_PROP_ANONYMOUS_MEMORY)
 	.lbs_inode = sizeof(struct ipe_inode),
-#endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#endif
 };
 
 static const struct lsm_id ipe_lsmid = {
@@ -59,6 +59,9 @@ static struct security_hook_list ipe_hooks[] __ro_after_init = {
 #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
 	LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
+#ifdef CONFIG_IPE_PROP_ANONYMOUS_MEMORY
+	LSM_HOOK_INIT(memfd_created, ipe_memfd_created),
+#endif /* CONFIG_IPE_PROP_ANONYMOUS_MEMORY */
 };
 
 /**
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
2.47.1

