Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075AF1F91C7;
	Tue, 29 Apr 2025 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745961803; cv=none; b=DsEPiRunj9KKKIppZW1sUNUy+CLNZKTeafasw7l1GiUCZ0g1UdppJDXF3u3yrHZh7JSRf+WAE6Qe3ZRT6B10vbZ5AXkPb+GrG7QTQAaOqO1b0dIhG5FKNTeXKj1V1y7SUJNfCaTR9UYkfaHIoyPS1x1rYQ7FWWzHFXA4ej3cEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745961803; c=relaxed/simple;
	bh=fw5XvMz0ZUfe/JFMkeye8tcHG4HQqhn+H7paCWwc2VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HwEBxpRRGaOWnGHg8tqzjPVO46fTju49+JntTWivQHIKHTI5RYUMDAYm5SjFa7hln1F2H1wh2S0GShsQISWOTcTDOqfI0axTcx2mxYC08zmn9n2O2L/iyggXRJ6birlhC6OuMXqtiFJxQgXqr9iaT76Kdr/by5cegVeuwOENvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m9df87Oh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m9df87Oh"
Received: by linux.microsoft.com (Postfix, from userid 1212)
	id AC374204E7C6; Tue, 29 Apr 2025 14:23:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC374204E7C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745961801;
	bh=/igJ7R5xHzUL7qXXfgXOEWBtZowW6TBQz77GIcNubkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9df87Ohk9rW+OBRh/onMgUST0V76q2nQR8giUosO45k7RppscJnImdPvNipBFrEC
	 U3+F/d7dtLaF3YNfeYifsuIztN1jIyyx05CzEvYd0RoLAoklbh0xr9SU+peWM1K2xg
	 wnyLtCKYkmJs5Kknp8dXZ9mGUtIhU0F6kU1tH3C8=
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: wufan@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>
Subject: [RFC PATCH v1 1/1] ipe: add script enforcement with BPRM check
Date: Tue, 29 Apr 2025 14:22:50 -0700
Message-Id: <1745961770-7188-2-git-send-email-jasjivsingh@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com>
References: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

From: jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>

Like direct file execution (e.g. ./script.sh), indirect file execution
(e.g. sh script.sh) needs to be enforce by IPE based on the rules.  
Added a new security_bprm_creds_for_exec() hook to verify the indirect 
file's integrity.

Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
---
 security/ipe/hooks.c | 23 +++++++++++++++++++++++
 security/ipe/hooks.h |  2 ++
 security/ipe/ipe.c   |  1 +
 3 files changed, 26 insertions(+)

diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..12713a0495cf 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -35,6 +35,29 @@ int ipe_bprm_check_security(struct linux_binprm *bprm)
 	return ipe_evaluate_event(&ctx);
 }
 
+/**
+ * ipe_bprm_creds_for_exec() - ipe security hook function for bprm creds check.
+ * @bprm: Supplies a pointer to a linux_binprm structure to source the file
+ *	  being evaluated.
+ *
+ * This LSM hook is called when a script is checked for execution through the
+ * execveat syscall with the AT_EXECVE_CHECK flag.
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
+	ipe_build_eval_ctx(&ctx, bprm->file, IPE_OP_EXEC, IPE_HOOK_BPRM_CHECK);
+	return ipe_evaluate_event(&ctx);
+}
+
 /**
  * ipe_mmap_file() - ipe security hook function for mmap check.
  * @f: File being mmap'd. Can be NULL in the case of anonymous memory.
diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
index 38d4a387d039..1c16a25d806e 100644
--- a/security/ipe/hooks.h
+++ b/security/ipe/hooks.h
@@ -24,6 +24,8 @@ enum ipe_hook_type {
 
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
2.34.1

