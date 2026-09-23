Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB003909B8;
	Wed, 23 Sep 2026 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133234; cv=none; b=F5JElZN8d/NPXXkczdg5DdPTf6ZOHfVUW4XnlzeFkdvkGfmaq2QKZIrwq/XjW4iKbSzxxsticEH9xSpX0MZpGWqAIDAmQEf3zvwbFQpYoAj5nVsApPkxSYumgdveYxKzKncLGVRWK+QPLu7PONw9hxAGtlhPI2HdraYfZYf6Olw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133234; c=relaxed/simple;
	bh=eQ1YqUTslb5dxOryo6W74H5gHamHrhSV+gWcsOV8LVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOSqmSN0DJnD2EfWnMt7iLSsoHcrUh4BXjlCizEepQ+lVgZgnliUljGBqE/O6R/rb84Dokv3WzWaheDliXy7STn1tWpkDBMOfX4lq+1m2YGFGtXFeVQtkYdj/WnbnuYpwaUv5pSBoPz9MSxrBEKuvzAGnSJuWm6mSA01Ow35mmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyoLf2dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyoLf2dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEFD1F00898;
	Wed, 23 Sep 2026 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790133233;
	bh=unThhJ5PlV7XLz3f6cbDsSTG6/h/IqkEJcR1t8o4uxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyoLf2dPUmzVfxYvTgVVz7oOmsyf/1YgXiSdqvjQWA4YSqJZdGQSJybY698i1WRXt
	 a4pFsyy78z+WFAQ7Q0R0GYMZhoI+2Bwwt5vX5eib2YDm4Ebh7TL9226Bndf3ihGAO4
	 E/rjhTctQ+WdBVA85WjNOb0SGh9uHgDL3f+tlB/Aww2APeVpPjN0tm9Z+XAaVdIgEa
	 RHL6/v5NwQN2mtzzaFsYH0uBriuJVxQtA689B9hdMKuCEk4VvCwVulS0yPz6Np+Vp2
	 ed93mugAS7vejtoKVgauAMwQaqLD4Ox26/Dr9zFcP2yJJXasZ5lgGxwbcvSxhbQT0/
	 Qmo/1k0AGHp2A==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ipe: protect the dm-verity root hash with RCU
Date: Tue, 22 Sep 2026 20:13:49 -0700
Message-ID: <20260923031349.1216431-3-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923031349.1216431-1-wufan@kernel.org>
References: <20260923031349.1216431-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipe_bdev_setintegrity() frees the old root hash when dm-verity publishes
a new one on ->preresume, while policy evaluation can still be
dereferencing it.

Protect the root hash with RCU. The evaluation path already runs under
rcu_read_lock().

Fixes: e155858dd995 ("ipe: add support for dm-verity as a trust provider")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5.5
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/eval.c  | 12 ++++++++----
 security/ipe/eval.h  |  2 +-
 security/ipe/hooks.c | 22 +++++++++++++++++-----
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 21439c5be336..4a7be96c84f0 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -134,10 +134,14 @@ static bool evaluate_boot_verified(const struct ipe_eval_ctx *const ctx)
 static bool evaluate_dmv_roothash(const struct ipe_eval_ctx *const ctx,
 				  struct ipe_prop *p)
 {
-	return !!ctx->ipe_bdev &&
-	       !!ctx->ipe_bdev->root_hash &&
-	       ipe_digest_eval(p->value,
-			       ctx->ipe_bdev->root_hash);
+	const struct digest_info *root_hash;
+
+	if (!ctx->ipe_bdev)
+		return false;
+
+	root_hash = rcu_dereference(ctx->ipe_bdev->root_hash);
+
+	return root_hash && ipe_digest_eval(p->value, root_hash);
 }
 #else
 static bool evaluate_dmv_roothash(const struct ipe_eval_ctx *const ctx,
diff --git a/security/ipe/eval.h b/security/ipe/eval.h
index fef65a36468c..b26d1147d070 100644
--- a/security/ipe/eval.h
+++ b/security/ipe/eval.h
@@ -27,7 +27,7 @@ struct ipe_bdev {
 #ifdef CONFIG_IPE_PROP_DM_VERITY_SIGNATURE
 	bool dm_verity_signed;
 #endif /* CONFIG_IPE_PROP_DM_VERITY_SIGNATURE */
-	struct digest_info *root_hash;
+	struct digest_info __rcu *root_hash;
 };
 #endif /* CONFIG_IPE_PROP_DM_VERITY */
 
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index 0ae54a880405..d878b52ceec8 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -9,6 +9,7 @@
 #include <linux/binfmts.h>
 #include <linux/mman.h>
 #include <linux/blk_types.h>
+#include <linux/rcupdate.h>
 
 #include "ipe.h"
 #include "hooks.h"
@@ -232,7 +233,20 @@ void ipe_bdev_free_security(struct block_device *bdev)
 {
 	struct ipe_bdev *blob = ipe_bdev(bdev);
 
-	ipe_digest_free(blob->root_hash);
+	ipe_digest_free(rcu_access_pointer(blob->root_hash));
+}
+
+static void ipe_set_dmverity_roothash(struct ipe_bdev *blob,
+				      struct digest_info *info)
+{
+	struct digest_info *old;
+
+	/* Protected by device-mapper's md->suspend_lock */
+	old = rcu_replace_pointer(blob->root_hash, info, true);
+	if (old) {
+		synchronize_rcu();
+		ipe_digest_free(old);
+	}
 }
 
 #ifdef CONFIG_IPE_PROP_DM_VERITY_SIGNATURE
@@ -280,8 +294,7 @@ int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type typ
 		return -EINVAL;
 
 	if (!value) {
-		ipe_digest_free(blob->root_hash);
-		blob->root_hash = NULL;
+		ipe_set_dmverity_roothash(blob, NULL);
 
 		return 0;
 	}
@@ -301,8 +314,7 @@ int ipe_bdev_setintegrity(struct block_device *bdev, enum lsm_integrity_type typ
 
 	info->digest_len = digest->digest_len;
 
-	ipe_digest_free(blob->root_hash);
-	blob->root_hash = info;
+	ipe_set_dmverity_roothash(blob, info);
 
 	return 0;
 err:
-- 
2.55.0

