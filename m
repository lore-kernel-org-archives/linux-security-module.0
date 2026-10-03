Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314B9246762
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995914; cv=none; b=JBptvdw/+ZEMF7wvRTqcYAXexBCcsNJeibPT/dDnSWha5QKhQuWbO6KTHyam4PI3fMDdk+hBsil6NxfUaMhJQbPZRJUxPrRAgDfjlTMinLPfZ01PbyutINcimTCrLRW0V0XGhiotUkztQ69FwzRk6DvM2/4GCmGwqzOwtsc/Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995914; c=relaxed/simple;
	bh=gTSCwr7UZQYmIJzpst2rPL/la6RL1Bgg2/FjaRAhPdA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyV03WuY6B9BWctOHj84yt0WH+j0i4/pBKBMOBG74DCJYH58ZeJKao4emNckFH8ZUt7Ty5KfvksEddLk0hOGRTIB0LNUAZs6ujtNR2HH3WZAYkJL+ByqmZAhCYlj7yHXE1ERljru0UY0TTdbw7PXUXJcUf89A4DMFWKeFfLKr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5c62poS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5c62poS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4601F00898
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 02:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790995912;
	bh=fx5i/IaMVS5+R6XZobhx3hviu+CPpJtQXHeuKjGII9w=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=f5c62poSD/x3WXwZUhfQ9yv9UdzyRLlBtSzpyPA5GgwJ/DWRI/O4leBVcaElIUHG9
	 YVCtp4iml/Noe7vZiXeKRaSY8DrPOP/F14D/jUz8Z02A/MkHIZDJL9IFLJ/JPZwlW9
	 XrYxQKrIix5H8CJ7IZ9htAT+rO8l5xRfShqE479rlRDBqhyXOLVfRfZRvGBR/dC5QO
	 BUfzV9CwXNKO6PrNR7as1TNjwrq239mFT4XHrUJ35zXnXoqYxreUtGm5FRMfqhwleL
	 6U482rrSPE+y46ZKI8y9KXvwHaUtAy5wMNsxNKSMMmD9LLDIWxiM3lne/neRnyVamk
	 4nlseGcXSqZFg==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Subject: [PATCH 2/6] ipe: use designated initializers for audit name tables
Date: Fri,  2 Oct 2026 19:51:31 -0700
Message-ID: <20261003025135.3666767-3-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003025135.3666767-1-wufan@kernel.org>
References: <20261003025135.3666767-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The audit name tables are indexed by enum values but initialized
positionally. Adding an enum value in the middle can associate the
following names with the wrong values.

Use designated initializers to bind each name to its enum value.

No functional changes.

Assisted-by: LLM
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/audit.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index 93fb59fbddd6..5b4f24914c74 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -34,34 +34,34 @@
 				    "new_policy_digest=" IPE_AUDIT_HASH_ALG ":"
 
 static const char *const audit_op_names[__IPE_OP_MAX + 1] = {
-	"EXECUTE",
-	"FIRMWARE",
-	"KMODULE",
-	"KEXEC_IMAGE",
-	"KEXEC_INITRAMFS",
-	"POLICY",
-	"X509_CERT",
-	"UNKNOWN",
+	[IPE_OP_EXEC]			= "EXECUTE",
+	[IPE_OP_FIRMWARE]		= "FIRMWARE",
+	[IPE_OP_KERNEL_MODULE]		= "KMODULE",
+	[IPE_OP_KEXEC_IMAGE]		= "KEXEC_IMAGE",
+	[IPE_OP_KEXEC_INITRAMFS]	= "KEXEC_INITRAMFS",
+	[IPE_OP_POLICY]			= "POLICY",
+	[IPE_OP_X509]			= "X509_CERT",
+	[IPE_OP_INVALID]		= "UNKNOWN",
 };
 
 static const char *const audit_hook_names[__IPE_HOOK_MAX] = {
-	"BPRM_CHECK",
-	"BPRM_CREDS_FOR_EXEC",
-	"MMAP",
-	"MPROTECT",
-	"KERNEL_READ",
-	"KERNEL_LOAD",
+	[IPE_HOOK_BPRM_CHECK]		= "BPRM_CHECK",
+	[IPE_HOOK_BPRM_CREDS_FOR_EXEC]	= "BPRM_CREDS_FOR_EXEC",
+	[IPE_HOOK_MMAP]			= "MMAP",
+	[IPE_HOOK_MPROTECT]		= "MPROTECT",
+	[IPE_HOOK_KERNEL_READ]		= "KERNEL_READ",
+	[IPE_HOOK_KERNEL_LOAD]		= "KERNEL_LOAD",
 };
 
 static const char *const audit_prop_names[__IPE_PROP_MAX] = {
-	"boot_verified=FALSE",
-	"boot_verified=TRUE",
-	"dmverity_roothash=",
-	"dmverity_signature=FALSE",
-	"dmverity_signature=TRUE",
-	"fsverity_digest=",
-	"fsverity_signature=FALSE",
-	"fsverity_signature=TRUE",
+	[IPE_PROP_BOOT_VERIFIED_FALSE]	= "boot_verified=FALSE",
+	[IPE_PROP_BOOT_VERIFIED_TRUE]	= "boot_verified=TRUE",
+	[IPE_PROP_DMV_ROOTHASH]		= "dmverity_roothash=",
+	[IPE_PROP_DMV_SIG_FALSE]	= "dmverity_signature=FALSE",
+	[IPE_PROP_DMV_SIG_TRUE]		= "dmverity_signature=TRUE",
+	[IPE_PROP_FSV_DIGEST]		= "fsverity_digest=",
+	[IPE_PROP_FSV_SIG_FALSE]	= "fsverity_signature=FALSE",
+	[IPE_PROP_FSV_SIG_TRUE]		= "fsverity_signature=TRUE",
 };
 
 /**
-- 
2.55.0

