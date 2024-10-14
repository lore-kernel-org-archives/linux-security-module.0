Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912931AA7A4
	for <linux-security-module@vger.kernel.org>; Mon, 14 Oct 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910134; cv=none; b=qLji2H+oGUj4qJjh//G7vvb01lIO0oepb1BXQJr8K5CXzP70P7kxeTJQul9zthUPRXSzsRRAI6WKZeugVsxGNeETGsRN7fgJRRNY50swQMkUWkkZdbwEESwQkzqGZB/YaakDu9tFvPEOsSuppT3k6w+vRjJkjmHutocvIgrBcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910134; c=relaxed/simple;
	bh=enkb6G2lnjB4L579GXk8QPkxWPWplD2BA5s4pa++YLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qe6Cdzz/5jvuFJ2LVgnZ4EDI+RHBK2GDt09O30Es7RuRMc3m+zIZN4qxs+rYEBJS27Q9GjqS9p9on0WzGMNB/iMVeR3OmsweEXXqJRYuZvPaOXP3ttCEZRTeHt6P3EeZdUIkKv4/3fM2M0iM745Mo4XI1xt5H2hoi34fFHkWCME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kh3Pz+Hf; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kh3Pz+Hf"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRxqb2F6Mz1yQ;
	Mon, 14 Oct 2024 14:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728910123;
	bh=SkQzv/iyeV13aOPbkZt4ZNsx6KBE4F5GmHXyL67vm8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh3Pz+HfjnboNGv4ahl/fRjcCL6wGVdJBv2Tog39CIRrBr4lKQaIuRL+xeX7KbW3V
	 1y418mkDBL6UyeDwJSW71PWNzQQpRZ4oZRkd9MNMKkU/pQDutwiNGWyj/FjRw8JtWf
	 GLAtfMWPMWvdbC2Qh/TTBODMbl9xjP4vTrQwLQqE=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRxqZ57G1zCTB;
	Mon, 14 Oct 2024 14:48:42 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 1/3] landlock: Refactor filesystem access mask management
Date: Mon, 14 Oct 2024 14:48:33 +0200
Message-ID: <20241014124835.1152246-2-mic@digikod.net>
In-Reply-To: <20241014124835.1152246-1-mic@digikod.net>
References: <20241014124835.1152246-1-mic@digikod.net>
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
landlock_merge_access_masks(), and replace the get_fs_domain()
implementation with a call to the new landlock_match_ruleset() helper.
These helpers will also be useful for other types of access.

Replace struct access_masks with union access_masks that includes a new
"all" field to simplify mask filtering.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241014124835.1152246-2-mic@digikod.net
---

Changes since v1:
* Rename landlock_filter_access_masks() to landlock_match_ruleset().
* Rename local variables from domain to ruleset to mach helpers'
  semantic.  We'll rename and move these helpers when we'll have a
  dedicated domain struct type.
* Rename the all_fs mask to any_fs.
* Add documentation, as suggested by Günther.
---
 security/landlock/fs.c       | 21 +++---------
 security/landlock/ruleset.h  | 66 +++++++++++++++++++++++++++++-------
 security/landlock/syscalls.c |  2 +-
 3 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7d79fc8abe21..5ab770442702 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -388,33 +388,22 @@ static bool is_nouser_or_private(const struct dentry *dentry)
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
+	return landlock_merge_access_masks(domain).fs |
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
 static const struct landlock_ruleset *
 get_fs_domain(const struct landlock_ruleset *const domain)
 {
-	if (!domain || !get_raw_handled_fs_accesses(domain))
-		return NULL;
+	const union access_masks any_fs = {
+		.fs = ~0,
+	};
 
-	return domain;
+	return landlock_match_ruleset(domain, any_fs);
 }
 
 static const struct landlock_ruleset *get_current_fs_domain(void)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61bdbc550172..c62a9c92ed64 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -41,12 +41,19 @@ static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_SCOPE);
 static_assert(sizeof(unsigned long) >= sizeof(access_mask_t));
 
 /* Ruleset access masks. */
-struct access_masks {
-	access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
-	access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
-	access_mask_t scope : LANDLOCK_NUM_SCOPE;
+union access_masks {
+	struct {
+		access_mask_t fs : LANDLOCK_NUM_ACCESS_FS;
+		access_mask_t net : LANDLOCK_NUM_ACCESS_NET;
+		access_mask_t scope : LANDLOCK_NUM_SCOPE;
+	};
+	u32 all;
 };
 
+/* Makes sure all fields are covered. */
+static_assert(sizeof(((union access_masks *)NULL)->all) ==
+	      sizeof(union access_masks));
+
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
@@ -229,7 +236,7 @@ struct landlock_ruleset {
 			 * layers are set once and never changed for the
 			 * lifetime of the ruleset.
 			 */
-			struct access_masks access_masks[];
+			union access_masks access_masks[];
 		};
 	};
 };
@@ -260,6 +267,46 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
+/**
+ * landlock_merge_access_masks - Return the merge of a ruleset's access_masks
+ *
+ * @ruleset: Landlock ruleset (used as a domain)
+ *
+ * Returns: an access_masks result of the OR of all the ruleset's access masks.
+ */
+static inline union access_masks
+landlock_merge_access_masks(const struct landlock_ruleset *const ruleset)
+{
+	size_t layer_level;
+	union access_masks matches = {};
+
+	for (layer_level = 0; layer_level < ruleset->num_layers; layer_level++)
+		matches.all |= ruleset->access_masks[layer_level].all;
+
+	return matches;
+}
+
+/**
+ * landlock_match_ruleset - Return @ruleset if any @masks right matches
+ *
+ * @ruleset: Landlock ruleset (used as a domain)
+ * @masks: access masks
+ *
+ * Returns: @ruleset if @masks matches, or NULL otherwise.
+ */
+static inline const struct landlock_ruleset *
+landlock_match_ruleset(const struct landlock_ruleset *const ruleset,
+		       const union access_masks masks)
+{
+	if (!ruleset)
+		return NULL;
+
+	if (landlock_merge_access_masks(ruleset).all & masks.all)
+		return ruleset;
+
+	return NULL;
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -295,19 +342,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
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

