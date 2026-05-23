Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD07265623
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779566949; cv=none; b=VDB2Mk/Aj7oax6FEPzyYhKzlU3hYeqEHOTXr5QT87vxv9ymNYUzFW5/PtZbaEvvKEAUPLzkyyAFCbybxDBV/w1zBDOP52mIbO0DF6ObQega4PDCA0hFRi9gKylgGafWzigI0e4m/u2kGTo/of6WYbR/jfJ8jYLQbU406ksunc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779566949; c=relaxed/simple;
	bh=kCzTdiryqmaVZhed7tArRmXdjfZAzbe/SWXYBNx3aus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdBcW7W6AF/VsfLSyId/Iau3n0nLVwmFaVIwxDU4EOKzFeaAu0SchKRVHeXdfFVSp/g201aqXBG47z343UFXhZ0YuLRWAxS9nnvU/kQmQImmbipSV1PaKYpWmMdqRlpRZNWIlECbHwdnkBduswtyndGy+B+4ayXQilqi4QIUVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Di1tRQVA; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Di1tRQVA"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-404254ffe8aso7343782fac.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779566946; x=1780171746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krjy6cZPvV0Hqs+EVLQneEAJgIvls/uU4cGYac/FyE4=;
        b=Di1tRQVAj+KXnt7ZhDhDCzlzfvw55GnkCiKqCVNqm2+n+lvZcra/EsG8zPqHDBS3ep
         kBe+XVQrCTbNqmRYSGc2xbtBQcTjKqJ1Hpdpmt8ll6Za0ngsETv9QSWW4tgTDu1pkHXw
         GVENOm2hUn0k0MQ+rHADCKRBERAhoSAEJvtU1YYUZ2AitBpXqNrdDOFqPuREwQSbEc5c
         n7/s5t8VIQSDmU6eezEne0mPS/oVpr3gzt2pAhNszPYgui2VqtJy5xp/jjsJhwPPPCZ3
         HLRUtb00uddLJQd+KJk8Ai4jufP3qw8s8K9uyAkx8E/e4Miwo8rVNvDZ0cVRochCCUiN
         Gq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779566946; x=1780171746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krjy6cZPvV0Hqs+EVLQneEAJgIvls/uU4cGYac/FyE4=;
        b=oFB2MPApebIr31+RLRHYFTr6vrbJ2d8YrmJ0oDN5kEKPeKxNvuBE7NY4tqXLOJ5fAQ
         yYUcOEYg2x7VxFvBx18Ht6aCNVVL8VRyq+c0xbz+VDvOEKUiQD5CIGlvGk8EgacsStOp
         SBIztp2JtuYJQwxc/Wi5SHF47GYA7Y66CSeNBfWVTkBgychQm/yVGZC1nPC0abRNugyN
         N18s+M4YMKq4QrMkC2+QdywM+BhxIMfT9yh+hkdfucliitphZutjD+ptistNrQf0e1P8
         NDT3pXteZVbgLaYIS2uRPTyILM/3if3FSoMxnvhQhgjjbhrGA+A1+Bzuztaaj+Wg07Sr
         VEmw==
X-Gm-Message-State: AOJu0Yw4f8Np/q0sxMtmb9U8dNXvNg2HMTCsiRWsPcGhaE/FDQz0x3Tx
	kyv7nSw+8p9rWEZjxBMjhcN7I28KZf1sH9he99/D8USPTaurGb1yF0faKIctrDHFTCRJ9lwDH7l
	Wnyg=
X-Gm-Gg: Acq92OFQHl8+hVGgs+7+BFcTE+eYs0hg0vHlhgOOXuaZLHfhZ17126PUYZpKO80960K
	igaHznsiWgJNmCglNOo5UrBH+jrX5/+NmT348QkZ/I/+KMh82Io3xVrJIwpraT7Bke9prHXlojc
	ejOsHHaLJj0UARIF5mbFTommEG5HsiOMIDyvtDnXCvvzJjzFel9QnlgUkwh14/X57vo15/tiAfd
	pnnrHr5Ky4fKZN9gmrMd7bX0SfUOATlI5MNWtmeJQ4BcvcinOZ7faFCKVBTorjJeZ4kJXBlJk5f
	H6UYe3ue6DTSOMFzDEGOfBcm5vBGIVSee3nz3AmckNhj59P46Zf8ju0hmQvVjxm6y4jfXHqgSjV
	YINU3tYVb6b7T5AzU/5hZnvTpT6l0e2ECTqwK5Di2YrmlWEWdIYz36dePKUmvEO4gTC3sTAcoTJ
	gmf2C88DOwuILE5iLs6KvTu6iPP/k6AQ==
X-Received: by 2002:a05:6870:31a2:b0:439:afe4:3a66 with SMTP id 586e51a60fabf-43b5bdeff47mr4496807fac.5.1779566946235;
        Sat, 23 May 2026 13:09:06 -0700 (PDT)
Received: from localhost ([108.147.98.113])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad6bsm5732421fac.4.2026.05.23.13.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 13:09:05 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: wufan@kernel.org,
	bboscaccy@linux.microsoft.com
Subject: [RFC PATCH] ipe: support multiple BPF integrity verification LSMs
Date: Sat, 23 May 2026 16:09:00 -0400
Message-ID: <20260523200859.13527-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4200; i=paul@paul-moore.com; h=from:subject; bh=kCzTdiryqmaVZhed7tArRmXdjfZAzbe/SWXYBNx3aus=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqEglcOt6Jiavy5Z993eVkfgRvlveU2/z4hw0lH xdbk5dTl66JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCahIJXAAKCRDqIPLalzeJ c0pWD/9EFhFMB8qU/vNAdIEkPuHiet97At+SEEVKuJ2Ah9+IreFBY1hYFujEfWkoGBO54QuApxc fZ3sSbeIVy9ezzcTsgnMnij+8YFhbzX0+nmiLFbPuZl+dturE4T3l5CnHjOQcoTjSTjQUySyFEc g/EuvhnicOxQXHI8Hy0a8QADhitkZDHPg9+COEurPEflCmJAlXPmYegutvHUZyjmvCK86XuzGVo /lfUFlAPecY0tuVKsyjXoTQNtR3KPzumpQYy2nsGCrnNdqWRrOKyhg+U79akK5mZdzgA4IelOkN Iz2HBoimrRM5R71xbv7qZhtXIk9GhRR9YzQ9mepvk82hjwlHLejn3jQ4AtnYQ9fx+2pjy9SuWLI gj1qFhKC+jFgHTZ9awjlxkwhrudDDJKUpZQxVgyUNJ31GI9jbimLJ3xNZPfRNuduVxihuUJ42jH FfGFkzapDFPoRTBl1yW/Q5632tGKC7ZKCd5GElpfp8Yt9yBq8u+0JqNYkBbY4Ghb6ibzJFK3mwd WrXUei+ujldpfX2fW6mg7p2rOuvdm7kUrhM25jf0cAkVDOzpsPPTuzBgiefPREfq0w1SKYfGW6m JBAC1H96mJ9HsAbmI5Q8Lu/lM7QXRTVpxV8X25mx9fFG7AOhGpbbEaWQ26CVQiK3EElha1Yh/+z J+2hba+un3keVyQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Currently IPE always records the last BPF integrity verification verdict,
which is reasonable with only a single BPF verification LSM, but it
becomes problematic when multiple mechanisms end up submitting BPF
program integrity verdicts.

This patch updates IPE to record all of the received BPF program
integrity verdicts, along with their associated LSM IDs, ultimately using
the "worst" verdict in the policy enforcement engine.  Policy support for
selecting individual integrity verdicts was intentionally omitted from
this patch to keep things simple both from a code and policy developer
perspective, however future work to add selector support should be
trivial.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 14 +++++++-------
 security/ipe/eval.h      |  7 ++++++-
 security/ipe/hooks.c     | 20 +++++++++++++++++---
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 598cd2eb1dcd..6a987a0347a0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -103,13 +103,13 @@ enum lsm_integrity_type {
 
 enum lsm_integrity_verdict {
 	LSM_INT_VERDICT_NONE = 0,
-	LSM_INT_VERDICT_OK,
-	LSM_INT_VERDICT_UNSIGNED,
-	LSM_INT_VERDICT_PARTIALSIG,
-	LSM_INT_VERDICT_UNKNOWNKEY,
-	LSM_INT_VERDICT_UNEXPECTED,
-	LSM_INT_VERDICT_FAULT,
-	LSM_INT_VERDICT_BADSIG,
+	LSM_INT_VERDICT_OK = 1,
+	LSM_INT_VERDICT_UNSIGNED = 2,
+	LSM_INT_VERDICT_PARTIALSIG = 3,
+	LSM_INT_VERDICT_UNKNOWNKEY = 4,
+	LSM_INT_VERDICT_UNEXPECTED = 5,
+	LSM_INT_VERDICT_FAULT = 6,
+	LSM_INT_VERDICT_BADSIG = 7,
 };
 
 /*
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index b061cb5ade27..90c7b66b9ca8 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -8,6 +8,7 @@
 
 #include <linux/file.h>
 #include <linux/types.h>
+#include <linux/lsm_count.h>
 
 #include "policy.h"
 #include "hooks.h"
@@ -39,7 +40,11 @@ struct ipe_inode {
 
 #ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
 struct ipe_bpf_prog {
-	enum lsm_integrity_verdict verdict;
+	struct {
+		const struct lsm_id *lsmid;
+		enum lsm_integrity_verdict verdict;
+	} verdicts[MAX_LSM_COUNT];
+	unsigned int count;
 };
 #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
 
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 9271e129a2cf..143bb2ae2b12 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -9,6 +9,7 @@
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/blk_types.h>
+#include <linux/lsm_count.h>
 
 #include "ipe.h"
 #include "hooks.h"
@@ -355,7 +356,8 @@ int ipe_inode_setintegrity(const struct inode *inode,
  * so that ipe_bpf_prog_load() can later read it for policy evaluation.
  *
  * Return:
- * * %0		- Always succeeds (policy is evaluated in bpf_prog_load)
+ * * %0		- Recorded the verdict (policy is evaluated in bpf_prog_load)
+ * * %-ENOMEM	- Exhausted room for recording verdicts
  */
 int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
 				     union bpf_attr *attr,
@@ -365,8 +367,14 @@ int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
 				     enum lsm_integrity_verdict verdict)
 {
 	struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
+	unsigned int count = blob->count;
 
-	blob->verdict = verdict;
+	if (count == MAX_LSM_COUNT)
+		return -ENOMEM;
+
+	blob->verdicts[count].lsmid = lsmid;
+	blob->verdicts[count].verdict = verdict;
+	blob->count++;
 
 	return 0;
 }
@@ -391,12 +399,18 @@ int ipe_bpf_prog_load(struct bpf_prog *prog,
 		      struct bpf_token *token,
 		      bool kernel)
 {
+	unsigned int iter;
 	struct ipe_bpf_prog *blob = ipe_bpf_prog(prog);
 	struct ipe_eval_ctx ctx = IPE_EVAL_CTX_INIT;
 
 	ctx.op = IPE_OP_BPF_PROG_LOAD;
 	ctx.hook = IPE_HOOK_BPF_PROG_LOAD;
-	ctx.bpf_verdict = blob->verdict;
+	ctx.bpf_verdict = LSM_INT_VERDICT_NONE;
+	for (iter = 0; iter < blob->count; iter++) {
+		/* pick the "wosrt" verdict */
+		if (blob->verdicts[iter].verdict > ctx.bpf_verdict)
+			ctx.bpf_verdict = blob->verdicts[iter].verdict;
+	}
 	ctx.bpf_keyring_id = attr->keyring_id;
 	ctx.bpf_kernel = kernel;
 
-- 
2.54.0

