Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519AF2E285C;
	Thu, 23 Oct 2025 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761262651; cv=none; b=Oeox12W/SPsoMMkgA/qoA2eoJMbU3Ivj420mH9BWmimo1rvz7qip/Hq+eulD4qydSUeJ59UG8CmP/OAiKD83TD3vRWbHPuYu5dOjAVBnK1FoJjNjmsvwFSxjxmDyS3MJsvG/f8iyN1LdQokAbPLIrkIt1D5BAZAmkkufuZ8arOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761262651; c=relaxed/simple;
	bh=mjSIB+olvpp7FObVnTvKHPbXxA6lJeMkxi6084AFehU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNFXvMQb7UMzKr1NVbJoGTfpv5puGh3dr563DZug7Rr6Qs9lKbf1WKfw4ZL5NsOy7vKKZRB2xys7kbPyifO5jWF64C5u84cbxPMZGZ9pScrvWB3u26V9/jCioXFV13srjVFLCoaZfv92QQJFx1Ie/jOk9HyzVeWlEZJc3wS9fgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N+RZFlxL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N+RZFlxL"
Received: from ubuntu.. (unknown [131.107.174.57])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0D71C2016031;
	Thu, 23 Oct 2025 16:37:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D71C2016031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761262644;
	bh=cUV6jys3X/iTSDPCZX2fG0GthbKk6WZ9aSQJUJcwURs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+RZFlxL3uHi//KK4nzBSX9JDvZMxDHuqZ5XV5YwzWsia8l1SYgjHroM0Bw8l4A+1
	 Yi+MJO2naa5pAPkeAiy2zUPuHK6jE9CeeZGIcYvlF54/3bKE/Pk2/T2oHZIgLpZdkz
	 u1+U477IRJflIt2W4TSi9jxGfNe6bdrUozFSPzzc=
From: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
To: wufan@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net
Cc: jmorris@namei.org,
	serge@hallyn.com,
	corbet@lwn.net,
	yanzhuhuang@linux.microsoft.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ipe: Add AT_EXECVE_CHECK support for script enforcement
Date: Thu, 23 Oct 2025 23:36:55 +0000
Message-ID: <20251023233656.661344-2-yanzhuhuang@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new ipe_bprm_creds_for_exec() hook that integrates
with the AT_EXECVE_CHECK mechanism. To enable script enforcement,
interpreters need to incorporate the AT_EXECVE_CHECK flag when
calling execveat() on script files before execuation.

When a userspace interpreter calls execveat() with the AT_EXECVE_CHECK
flag, this hook triggers IPE policy evaluation on the script file. The
hook only triggers IPE when bprm->is_check is true, ensuring it's
being called from an AT_EXECVE_CHECK context. It then builds an
evaluation context for an IPE_OP_EXEC operation and invokes IPE policy.
The kernel returns the policy decision to the interpreter, which can
then decide whether to proceed with script execution.

This extends IPE enforcement to indirectly executed scripts, permitting
trusted scripts to execute while denying untrusted ones.

Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
---
 security/ipe/audit.c |  1 +
 security/ipe/hooks.c | 27 +++++++++++++++++++++++++++
 security/ipe/hooks.h |  3 +++
 security/ipe/ipe.c   |  1 +
 4 files changed, 32 insertions(+)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index de5fed62592e..3f0deeb54912 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -46,6 +46,7 @@ static const char *const audit_op_names[__IPE_OP_MAX + 1] = {
 
 static const char *const audit_hook_names[__IPE_HOOK_MAX] = {
 	"BPRM_CHECK",
+	"BPRM_CREDS_FOR_EXEC",
 	"MMAP",
 	"MPROTECT",
 	"KERNEL_READ",
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..32dd99abd4de 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -35,6 +35,33 @@ int ipe_bprm_check_security(struct linux_binprm *bprm)
 	return ipe_evaluate_event(&ctx);
 }
 
+/**
+ * ipe_bprm_creds_for_exec() - ipe security hook function for bprm creds check.
+ * @bprm: Supplies a pointer to a linux_binprm structure to source the file
+ *	  being evaluated.
+ *
+ * This LSM hook is called when userspace signals the kernel to check a file
+ * for execution through the execveat syscall with the AT_EXECVE_CHECK flag.
+ * The hook triggers IPE policy evaluation on the script file and returns
+ * the policy decision to userspace. The userspace program receives the
+ * return code and can decide whether to proceed with script execution.
+ *
+ * Return:
+ * * %0		- Success
+ * * %-EACCES	- Did not pass IPE policy
+ */
+int ipe_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
+
+	if (!bprm->is_check)
+		return 0;
+
+	ipe_build_eval_ctx(&ctx, bprm->file, IPE_OP_EXEC,
+			   IPE_HOOK_BPRM_CREDS_FOR_EXEC);
+	return ipe_evaluate_event(&ctx);
+}
+
 /**
  * ipe_mmap_file() - ipe security hook function for mmap check.
  * @f: File being mmap'd. Can be NULL in the case of anonymous memory.
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 38d4a387d039..07db37332740 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -13,6 +13,7 @@
 
 enum ipe_hook_type {
 	IPE_HOOK_BPRM_CHECK = 0,
+	IPE_HOOK_BPRM_CREDS_FOR_EXEC,
 	IPE_HOOK_MMAP,
 	IPE_HOOK_MPROTECT,
 	IPE_HOOK_KERNEL_READ,
@@ -24,6 +25,8 @@ enum ipe_hook_type {
 
 int ipe_bprm_check_security(struct linux_binprm *bprm);
 
+int ipe_bprm_creds_for_exec(struct linux_binprm *bprm);
+
 int ipe_mmap_file(struct file *f, unsigned long reqprot, unsigned long prot,
 		  unsigned long flags);
 
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 4317134cb0da..845e3fd7a345 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -47,6 +47,7 @@ struct ipe_inode *ipe_inode(const struct inode *inode)
 
 static struct security_hook_list ipe_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
+	LSM_HOOK_INIT(bprm_creds_for_exec, ipe_bprm_creds_for_exec),
 	LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
 	LSM_HOOK_INIT(file_mprotect, ipe_file_mprotect),
 	LSM_HOOK_INIT(kernel_read_file, ipe_kernel_read_file),
-- 
2.43.0

