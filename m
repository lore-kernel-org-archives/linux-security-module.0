Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3BD1FE45E
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jan 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351039; cv=none; b=I67c5O4eIuDKt/totyp5DnKaLIxwHhlXg/8nva6Kzjj1K+KHNz1K5liFXoQLfS4pipIcauD0iP4OZVHU5b/o8hUaPihAg/m0ZGG0pBLbcugZZEF6EMyc8wFhiBvD935EIAI4pWpdr1H2Rb3BbZCGuQC0DshhxPB/+gFsFEl3smU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351039; c=relaxed/simple;
	bh=pbjs421Pky9glSBPHXWUS1xMZ9hfuvzC41AX1/E76bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSai4qIcXcoSi490C9UUA6FpzfgEMCTR7tVegSbpxbO06LsHI6KdhV38+QKmff4k2FBpuv72bYvNbPc0Vk5XxnX/X0EzRlWAGMaWMrpZD2r7PYIv1ihstMzD65ZpQS337LLBsMQRBWQK5rWJ3+jy7h/InnVW4ZhftcmspXlqem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=l6GmoPQ7; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="l6GmoPQ7"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YSsf30x1Bz9s9;
	Wed,  8 Jan 2025 16:43:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736351035;
	bh=f4tHQfJHpRqEk9p+KaoskKp0MCYGZFL6TV5oGOIgc5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6GmoPQ72Us7PhF3owCE6mG8SfAdRnQMjDmn0sWMO/XDhJJIZGxz/ncbJajYcSLvR
	 NJ9WcYHAu9SVZ82q/D+yJC6taeexeZWvHB109XzBgIL7A7fE8BpYQxBOvZnWqSrvzl
	 VQtqUwx+TtKAwsLzkf/0N2Q0CIKvweyuO9ds68uc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YSsf22RwSzLFX;
	Wed,  8 Jan 2025 16:43:54 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 06/30] landlock: Simplify initially denied access rights
Date: Wed,  8 Jan 2025 16:43:14 +0100
Message-ID: <20250108154338.1129069-7-mic@digikod.net>
In-Reply-To: <20250108154338.1129069-1-mic@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Upgrade domain's handled access masks when creating a domain from a
ruleset, instead of converting them at runtime.  This is more consistent
and helps with audit support.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250108154338.1129069-7-mic@digikod.net
---

Changes since v2:
- New patch.
---
 security/landlock/access.h  | 17 ++++++++++++++++-
 security/landlock/fs.c      | 10 +---------
 security/landlock/ruleset.c |  3 ++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index 9ee4b30a87e6..74fd8f399fbd 100644
--- a/security/landlock/access.h
+++ b/security/landlock/access.h
@@ -20,7 +20,8 @@
 /*
  * All access rights that are denied by default whether they are handled or not
  * by a ruleset/layer.  This must be ORed with all ruleset->access_masks[]
- * entries when we need to get the absolute handled access masks.
+ * entries when we need to get the absolute handled access masks, see
+ * landlock_upgrade_handled_access_masks().
  */
 /* clang-format off */
 #define _LANDLOCK_ACCESS_FS_INITIALLY_DENIED ( \
@@ -59,4 +60,18 @@ typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
 
+/* Upgrades with all initially denied by default access rights. */
+static inline struct access_masks
+landlock_upgrade_handled_access_masks(struct access_masks access_masks)
+{
+	/*
+	 * All access rights that are denied by default whether they are
+	 * explicitly handled or not.
+	 */
+	if (access_masks.fs)
+		access_masks.fs |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return access_masks;
+}
+
 #endif /* _SECURITY_LANDLOCK_ACCESS_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 3da5f1945158..9779170d9199 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -389,14 +389,6 @@ static bool is_nouser_or_private(const struct dentry *dentry)
 		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
 }
 
-static access_mask_t
-get_handled_fs_accesses(const struct landlock_ruleset *const domain)
-{
-	/* Handles all initially denied by default access rights. */
-	return landlock_union_access_masks(domain).fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
-}
-
 static const struct access_masks any_fs = {
 	.fs = ~0,
 };
@@ -788,7 +780,7 @@ static bool is_access_to_paths_allowed(
 		 * a superset of the meaningful requested accesses).
 		 */
 		access_masked_parent1 = access_masked_parent2 =
-			get_handled_fs_accesses(domain);
+			landlock_union_access_masks(domain).fs;
 		is_dom_check = true;
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index cae69f2f01d9..dbc528f5f3b7 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -385,7 +385,8 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		err = -EINVAL;
 		goto out_unlock;
 	}
-	dst->access_masks[dst->num_layers - 1] = src->access_masks[0];
+	dst->access_masks[dst->num_layers - 1] =
+		landlock_upgrade_handled_access_masks(src->access_masks[0]);
 
 	/* Merges the @src inode tree. */
 	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
-- 
2.47.1

