Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9A1C9EAF
	for <linux-security-module@vger.kernel.org>; Tue,  1 Oct 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791977; cv=none; b=S7JBNSTmdyndocKm4jEIKGgZ7788GZB1zgkugfe1/hxnWwVDiybNsEEb98+csp0HugquQVFVcfpVU/u+Tq1q5owmetT84/NJDhL+dzdYxsfpcn5Z/U5saf2JNt9HKafQw1Ilkz7l4WFnDG0JjrERCZyz7NW23+UdpCBBH2IDWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791977; c=relaxed/simple;
	bh=Ds73trVZs0fczXUktX72hGKMSHVdqqAI8SjucqzT/IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/PpjSmk6AtW4/KKA7RFFiTKrbFsXUJP31Y5/OJozYFg9+FfREhksGvMke22Ta+VEXSI1cxEtir4ojDQwYwkuLY3ICYog/7lUI56hg3i91RADENWeC6LBnCTsIrkRA/hJe8hmuBW86DXiaySQ8bmNyPSO/IAEeTnmYgPSsFzK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=TAqk5L3U; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="TAqk5L3U"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XJ0JW4hGSz1Tn;
	Tue,  1 Oct 2024 16:12:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727791963;
	bh=/a72lL8FE9f7hx3vN+t5LvBvYQYYTjne+FHWmDwjjoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAqk5L3U6bz1jsd5kK98SrxEKaumyBEjDtX5txgiKuxm3GBS8jiEwHLDBiJpengjR
	 bYNFMucwdZWF5ILwt08AGcYmnq42B19cRrbtCEU6axPB3suwnJqtDfrffjZFXgZdDj
	 DvQUMkE5rdG/C95HUG/77sJto9gsPPux4fNKat/Y=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XJ0JW0pnhzS9N;
	Tue,  1 Oct 2024 16:12:43 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/3] landlock: Refactor filesystem access mask management
Date: Tue,  1 Oct 2024 16:12:32 +0200
Message-ID: <20241001141234.397649-2-mic@digikod.net>
In-Reply-To: <20241001141234.397649-1-mic@digikod.net>
References: <20241001141234.397649-1-mic@digikod.net>
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
implementation with a call to the new landlock_filter_access_masks()
helper.  These helpers will also be useful for other types of access.

Replace struct access_masks with union access_masks that includes a new
"all" field to simplify mask filtering.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241001141234.397649-2-mic@digikod.net
---
 security/landlock/fs.c       | 21 ++++-----------
 security/landlock/ruleset.h  | 51 +++++++++++++++++++++++++++---------
 security/landlock/syscalls.c |  2 +-
 3 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7d79fc8abe21..a2ef7d151c81 100644
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
+	const union access_masks all_fs = {
+		.fs = ~0,
+	};
 
-	return domain;
+	return landlock_filter_access_masks(domain, all_fs);
 }
 
 static const struct landlock_ruleset *get_current_fs_domain(void)
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61bdbc550172..a816042ca8f3 100644
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
@@ -260,6 +267,31 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
+static inline union access_masks
+landlock_merge_access_masks(const struct landlock_ruleset *const domain)
+{
+	size_t layer_level;
+	union access_masks matches = {};
+
+	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
+		matches.all |= domain->access_masks[layer_level].all;
+
+	return matches;
+}
+
+static inline const struct landlock_ruleset *
+landlock_filter_access_masks(const struct landlock_ruleset *const domain,
+			     const union access_masks masks)
+{
+	if (!domain)
+		return NULL;
+
+	if (landlock_merge_access_masks(domain).all & masks.all)
+		return domain;
+
+	return NULL;
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -295,19 +327,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
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
2.46.1

