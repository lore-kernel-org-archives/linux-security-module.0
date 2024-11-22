Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B3713D53B
	for <linux-security-module@vger.kernel.org>; Fri, 22 Nov 2024 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286414; cv=none; b=Bl699543JMAuoZKrk870Xm/RgU8IwAxryi8GFEMi4Xi2b1cped/9gRrhYUFcoBnK14iffxYBZUOKoRpWegdSvwUN+KQdwXpit86KEFoFeSRGSN9U9gNiq9a8u3BCG+cb5Bhm0kQjlerpSCMlcIBzLE+SqrGdd1dQZG8jlOXdgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286414; c=relaxed/simple;
	bh=9Fxkj6Lw7DP1eAfNHnWrp7Twfjs6P7rVD5OBZe4cpq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cks/z2FO6ztDG23iVe82scKMzWqUJu1sDaXEZ69YZQkdCwyUGfOmBsFc+fJiVy+x5Kp04k2G1J9Kg8xnA8i6ZoZ/crbDCWyO5x3vpK1YFqwltY7ii7t6UksvgV6cVgrGGtf8hjq+DovGGfIcJDFc2t+KKREiuVJVVQonQd3kcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=q6BM95T0; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="q6BM95T0"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKG6yVGzlKF;
	Fri, 22 Nov 2024 15:34:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286050;
	bh=w3WVR4dmJCr/E++3tly2leydnVO6iM/bONHgj5qQ1yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6BM95T0+P8uMIKRgmgG7gxiJuT4hmcDLlWAlHYvGEL7lgBaMIdIKUH8wkHbEJdK5
	 BlroYM60s3HtzWnhD59eIRDiFFftfL//m0J8IlkjXv2wBX7N2fkQUARVW3O9aXMPf9
	 RPbomBAvJwrMnUAnIG7swAf5t/VavRlx0Iwzqx9o=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKG274Lzm5q;
	Fri, 22 Nov 2024 15:34:10 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
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
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 06/23] landlock: Simplify initially denied access rights
Date: Fri, 22 Nov 2024 15:33:36 +0100
Message-ID: <20241122143353.59367-7-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241122143353.59367-7-mic@digikod.net
---

Changes since v2:
- New patch.
---
 security/landlock/access.h  | 17 ++++++++++++++++-
 security/landlock/fs.c      | 10 +---------
 security/landlock/ruleset.c |  3 ++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/security/landlock/access.h b/security/landlock/access.h
index a64694287d2c..1e302775cc23 100644
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
2.47.0

