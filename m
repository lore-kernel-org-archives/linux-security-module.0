Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DE1552EE
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151517; cv=none; b=Gu7X6cj6A3hdjW3B6MH7KBGK5yntw8DCRv7dBIiiDrASKOmxH/vwBPIM+A7F3Z0/x+NS1I/cnQCpqibu4XBvdhyhDWOUqxsEyA+yBU/TJpXKsFEsu52briFtQtC8VlTJC6200tBKk9zycsfLlTaswYuXcGYTUqqxiKua+7LaOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151517; c=relaxed/simple;
	bh=nB1p5KLuTEgISBnTx1U2N4qOiNl2cQ6YNcXs91SG8wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onVX8VgdXxVFuH/FGtR2kKHz3mTKKZrfDjJI8Q27vIXSpgeQhgCLLcNMhQQFJ1IFAliK2AFP6ewmvltFAvaLG8NfkyVx0aqxOh3Q7ux4+yexbVY/QsyAJ8XwMNqATsMzv7agfKkwbYCNxdY7ymu/QzTrUtEypCuv0tDpGrxEsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=x1UgXXEE; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="x1UgXXEE"
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltNf3thsz55v;
	Sat,  9 Nov 2024 12:09:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150546;
	bh=nbg/aLj6FHCqb9wXX9J/lU/Eg6zWse64pnByKrzE0kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1UgXXEECFQp7Zmelx+OHCHnYCRXRtdikKZOYxdGIbSSCglDbhUvBSTjETD5U7kpE
	 S2jp4pgURDMqgSl53ZxpNUVvxUAvYf7sSScoxtWVpM3yiQBTkem0EGL8KY0kGBoHcq
	 q0zM+NpbqI1MZgEEao51qX0MyRE+tEBffv1WTI0k=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltNd6dr0zwn5;
	Sat,  9 Nov 2024 12:09:05 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 1/3] landlock: Refactor filesystem access mask management
Date: Sat,  9 Nov 2024 12:08:54 +0100
Message-ID: <20241109110856.222842-2-mic@digikod.net>
In-Reply-To: <20241109110856.222842-1-mic@digikod.net>
References: <20241109110856.222842-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace get_raw_handled_fs_accesses() with a generic
landlock_merge_access_masks(), and replace get_fs_domain() with a
generic landlock_match_ruleset().  These helpers will also be useful for
other types of access.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241109110856.222842-2-mic@digikod.net
---

Changes since v3:
* Rename landlock_merge_access_masks() to landlock_union_access_masks(),
  suggested by Günther.
* Rename landlock_match_ruleset() to landlock_get_applicable_domain(),
  suggested by Günther.
* Rename the "ruleset" arguments to "domain" for consistency with these
  new helpers.
* Use typeof_member(), suggested by Günther.  Also include kernel.h
  (instead of the new container_of.h to ease backports).

Changes since v2:
* Create a new type union access_masks_all instead of changing struct
  acces_masks.
* Replace get_fs_domain() with an explicit call to
  landlock_match_ruleset().

Changes since v1:
* Rename landlock_filter_access_masks() to landlock_match_ruleset().
* Rename local variables from domain to ruleset to mach helpers'
  semantic.  We'll rename and move these helpers when we'll have a
  dedicated domain struct type.
* Rename the all_fs mask to any_fs.
* Add documentation, as suggested by Günther.
---
 security/landlock/fs.c       | 31 ++++-----------
 security/landlock/ruleset.h  | 73 ++++++++++++++++++++++++++++++++----
 security/landlock/syscalls.c |  2 +-
 3 files changed, 74 insertions(+), 32 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7d79fc8abe21..e31b97a9f175 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -388,38 +388,22 @@ static bool is_nouser_or_private(const struct dentry *dentry)
 		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
 }
 
-static access_mask_t
-get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
-{
-	access_mask_t access_dom = 0;
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
-		access_dom |=
-			landlock_get_raw_fs_access_mask(domain, layer_level);
-	return access_dom;
-}
-
 static access_mask_t
 get_handled_fs_accesses(const struct landlock_ruleset *const domain)
 {
 	/* Handles all initially denied by default access rights. */
-	return get_raw_handled_fs_accesses(domain) |
+	return landlock_union_access_masks(domain).fs |
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
-static const struct landlock_ruleset *
-get_fs_domain(const struct landlock_ruleset *const domain)
-{
-	if (!domain || !get_raw_handled_fs_accesses(domain))
-		return NULL;
-
-	return domain;
-}
+static const struct access_masks any_fs = {
+	.fs = ~0,
+};
 
 static const struct landlock_ruleset *get_current_fs_domain(void)
 {
-	return get_fs_domain(landlock_get_current_domain());
+	return landlock_get_applicable_domain(landlock_get_current_domain(),
+					      any_fs);
 }
 
 /*
@@ -1517,7 +1501,8 @@ static int hook_file_open(struct file *const file)
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_ruleset *const dom =
-		get_fs_domain(landlock_cred(file->f_cred)->domain);
+		landlock_get_applicable_domain(
+			landlock_cred(file->f_cred)->domain, any_fs);
 
 	if (!dom)
 		return 0;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61bdbc550172..698fa3114cf4 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -11,6 +11,7 @@
 
 #include <linux/bitops.h>
 #include <linux/build_bug.h>
+#include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
@@ -47,6 +48,15 @@ struct access_masks {
 	access_mask_t scope : LANDLOCK_NUM_SCOPE;
 };
 
+union access_masks_all {
+	struct access_masks masks;
+	u32 all;
+};
+
+/* Makes sure all fields are covered. */
+static_assert(sizeof(typeof_member(union access_masks_all, masks)) ==
+	      sizeof(typeof_member(union access_masks_all, all)));
+
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
@@ -260,6 +270,60 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
+/**
+ * landlock_union_access_masks - Return all access rights handled in the
+ *				 domain
+ *
+ * @domain: Landlock ruleset (used as a domain)
+ *
+ * Returns: an access_masks result of the OR of all the domain's access masks.
+ */
+static inline struct access_masks
+landlock_union_access_masks(const struct landlock_ruleset *const domain)
+{
+	union access_masks_all matches = {};
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++) {
+		union access_masks_all layer = {
+			.masks = domain->access_masks[layer_level],
+		};
+
+		matches.all |= layer.all;
+	}
+
+	return matches.masks;
+}
+
+/**
+ * landlock_get_applicable_domain - Return @domain if it applies to (handles)
+ *				    the access rights specified in @masks
+ *
+ * @domain: Landlock ruleset (used as a domain)
+ * @masks: access masks
+ *
+ * Returns: @domain if any access rights specified in @masks is handled, or
+ * NULL otherwise.
+ */
+static inline const struct landlock_ruleset *
+landlock_get_applicable_domain(const struct landlock_ruleset *const domain,
+			       const struct access_masks masks)
+{
+	const union access_masks_all masks_all = {
+		.masks = masks,
+	};
+	union access_masks_all merge = {};
+
+	if (!domain)
+		return NULL;
+
+	merge.masks = landlock_union_access_masks(domain);
+	if (merge.all & masks_all.all)
+		return domain;
+
+	return NULL;
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -295,19 +359,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
 	ruleset->access_masks[layer_level].scope |= mask;
 }
 
-static inline access_mask_t
-landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
-				const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].fs;
-}
-
 static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
+	return ruleset->access_masks[layer_level].fs |
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f5a0e7182ec0..c097d356fa45 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -329,7 +329,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
+	mask = ruleset->access_masks[0].fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.47.0

