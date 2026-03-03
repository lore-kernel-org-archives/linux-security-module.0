Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9099437DE98
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 04:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510772; cv=none; b=AgJtUjl2gOgL5Xa0+/pxU8GRAV45bociSSLqtC1Nj3XCtumDUTQUbvhYFOnwKw5hmmNMPgaLOlFRg7Ut3xEPsSgGs7nU4EzhDNOxi5xD47RLqNTxXp315Le2rPbHfRRtKpEBjop28CM8puFWaDVyOmCQNwkHrRkFXfXdZOPtqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510772; c=relaxed/simple;
	bh=cymcsNAhQ6VwEMffbhSJi1gct8ae2KHWD1Rsix4D6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfBUQc830kdXB17OVCwsiMv3SJE7rH1w/1irA1Wc0g5dTZvs5x5E3T17y3s1VdNDfh+wt7KgOvFfi36KYW3rGvNtmx64gDP7Y9OKA2aFVACLKzCxue+mOE1K0bse6edl5Fi121U8Nxc7eYsaSBsHmUIrTZqjFs2oO/dijoZ1RIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Me4D/Seo; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me4D/Seo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79800183233so70839427b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 20:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772510769; x=1773115569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfcdIfbY8OKid58GzF02zhXzXVs/XE/FUrdvmEEQTWs=;
        b=Me4D/SeoGfZ2lzTW6bJrKXh3Q7G2BDQnxzSfHAJW7Sxp5/ynh49/WkKFs7dDFtRCGY
         GhMicyw3PfXvksPyXcz8JRUmga5neiSbyUmAIJ1hLWuoa9KqHaqTytD+Dvp3e38inBRW
         KqrtYq27d8IS6rL6uI2VWyicNAvxA5JTM4JCe4LoXrHaJtJWpIXGDRec0rZARiLvL1md
         eOF3V5H/PM/vdutB+g7mZbAF9MSUx10NLdkbvzMSFdbCFLUEBIpjW6onya1b+JK6q5Uf
         FEWu3quFcIaXkHmosWTOl30+7vxAVYaZbJ9zAhMR2zupg/CT1Vft8j64ed/8MYkpkgFC
         anfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772510769; x=1773115569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nfcdIfbY8OKid58GzF02zhXzXVs/XE/FUrdvmEEQTWs=;
        b=RMruV2iMtpbRFuad0NcdtIHeFtZrJt9L6iK/MyNjTr6fY00yFgCf/MqYBExm264l0B
         0htSpLnUi0CD4NmrRAUUkQPsPoqvNiW7b4Vr22ZfNCRuFo5p6GQTwdp2KNfRWBgc0UxJ
         vH4VtwZbnKHshZEMlNRTxs7OBtEis2NlQJ6KsuCb9x19sU2Ov2J/aoWf3etz0nWzh6Pu
         5OUiPjmJ6VbBvjGE18NdGq8ofdNpD6oaxkZ+9k6K5pOdh79zYP/8V8T2e4UqaiB7w7iO
         q274HIImvEgyz23ATAqTyCEdcLjE9AhLMMNfYwZPIiYWh/ytozvkafyz2sjGlGZiIWMf
         G2lA==
X-Gm-Message-State: AOJu0YwUj++fyRAD0+o3FrArOMo9qiIOCw19WEPUsLjZb49rAV/iX2yE
	SSodekt5JP0tKPSNJ4bErLp+OP+mRIksxydW7c6YgJ4ROXbfWk8WVoEwQyDcMw==
X-Gm-Gg: ATEYQzxmCOZaDRb5DKpM3F1fl5HvcaFN0KqDzJKHlbFda5+XFtfSgpBFoSMILTVCpeO
	TBx63nUQfvsnsKl61dDfpfD81WhFEq1azRZNNSa26ivHqaGDPOsro3sBdL7cc9sTLlOAyHVVQwQ
	zUjsHqpOcYZfXYUqMl/u3peCSoQRIueWRah2jBg8I+7+3HcM7DCWCDFH9r/5fqPSIYXUZpB1rNE
	X5hzgT25a3I+CstvcnCHCsLpRZJ6cS2ZwUggSYVPl9lb46ZWjiVlzWVoYpaDwllZ5CuKRQuVkyJ
	9BDDWrLe9fWyspx9Ap1wBVZ95YdTbcXhQKsLoF7ILS7ep9hNCx0p7yW2/KezJ7ye8GG5sUt4XhZ
	XRPeVsIQlAOeaAU8qTucslIv1QPz244GRbFrc/6d9dCinKHsDq0jXl9hVLUXJQ6aKHU4V9WxHvK
	5fm4Qg8VCrBvT+XjgLAgAzG9sTU1KweQ0=
X-Received: by 2002:a05:690c:a70e:b0:798:58a8:3e50 with SMTP id 00721157ae682-798bb3434b6mr5126157b3.1.1772510769339;
        Mon, 02 Mar 2026 20:06:09 -0800 (PST)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798ac64fa32sm17460047b3.14.2026.03.02.20.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:06:08 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 2/2] landlock: Refactor path access checks
Date: Mon,  2 Mar 2026 23:05:40 -0500
Message-ID: <20260303040540.3124770-3-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303040540.3124770-1-utilityemal77@gmail.com>
References: <20260303040540.3124770-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct landlock_check to bundle per-check state,
refactor is_access_to_paths_allowed() and its callers,
inline collect_domain_accesses() into current_check_refer_path(),
and reuse current_check_access_path() for same-directory refer checks.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/fs.c | 419 +++++++++++++++++------------------------
 1 file changed, 175 insertions(+), 244 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 180ab149be74..7526414501ed 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -430,6 +430,14 @@ static const struct access_masks any_fs = {
 	.fs = ~0,
 };
 
+struct landlock_check {
+	access_mask_t access_request;
+	access_mask_t access_masked;
+	struct layer_access_masks layer_masks;
+	struct landlock_request request;
+	bool allowed;
+};
+
 /*
  * Returns true iff the child file with the given src_child access rights under
  * src_parent would result in having the same or fewer access rights if it were
@@ -734,28 +742,17 @@ static void test_is_eacces_with_write(struct kunit *const test)
  * @domain: Domain to check against.
  * @path: File hierarchy to walk through.  For refer checks, this would be
  *     the common mountpoint.
- * @access_request_parent1: Accesses to check, once @layer_masks_parent1 is
- *     equal to @layer_masks_parent2 (if any).  This is tied to the unique
- *     requested path for most actions, or the source in case of a refer action
- *     (i.e. rename or link), or the source and destination in case of
- *     RENAME_EXCHANGE.
- * @layer_masks_parent1: Pointer to a matrix of layer masks per access
- *     masks, identifying the layers that forbid a specific access.  Bits from
- *     this matrix can be unset according to the @path walk.  An empty matrix
- *     means that @domain allows all possible Landlock accesses (i.e. not only
- *     those identified by @access_request_parent1).  This matrix can
- *     initially refer to domain layer masks and, when the accesses for the
- *     destination and source are the same, to requested layer masks.
- * @log_request_parent1: Audit request to fill if the related access is denied.
+ * @check_parent1: Accesses and associated metadata to check, once
+ *     @check_parent1.layer_masks is equal to @check_parent2.layer_masks
+ *     (if any).  This is tied to the unique requested path for most actions,
+ *     or the source in case of a refer action (i.e. rename or link), or the
+ *     source and destination in case of RENAME_EXCHANGE.
  * @dentry_child1: Dentry to the initial child of the parent1 path.  This
  *     pointer must be NULL for non-refer actions (i.e. not link nor rename).
- * @access_request_parent2: Similar to @access_request_parent1 but for a
- *     request involving a source and a destination.  This refers to the
- *     destination, except in case of RENAME_EXCHANGE where it also refers to
- *     the source.  Must be set to 0 when using a simple path request.
- * @layer_masks_parent2: Similar to @layer_masks_parent1 but for a refer
- *     action.  This must be NULL otherwise.
- * @log_request_parent2: Audit request to fill if the related access is denied.
+ * @check_parent2: Similar to @check_parent1 but for a request involving a
+ *     source and a destination.  This refers to the destination, except in
+ *     case of RENAME_EXCHANGE where it also refers to the source.  This must
+ *     be NULL when using a simple path request.
  * @dentry_child2: Dentry to the initial child of the parent2 path.  This
  *     pointer is only set for RENAME_EXCHANGE actions and must be NULL
  *     otherwise.
@@ -773,24 +770,24 @@ static void test_is_eacces_with_write(struct kunit *const test)
 static bool
 is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 			   const struct path *const path,
-			   const access_mask_t access_request_parent1,
-			   struct layer_access_masks *layer_masks_parent1,
-			   struct landlock_request *const log_request_parent1,
+			   struct landlock_check *const check_parent1,
 			   struct dentry *const dentry_child1,
-			   const access_mask_t access_request_parent2,
-			   struct layer_access_masks *layer_masks_parent2,
-			   struct landlock_request *const log_request_parent2,
+			   struct landlock_check *const check_parent2,
 			   struct dentry *const dentry_child2)
 {
-	bool allowed_parent1 = false, allowed_parent2 = false, is_dom_check,
-	     child1_is_directory = true, child2_is_directory = true;
+	struct landlock_check *const checks[] = {
+		check_parent1,
+		check_parent2,
+	};
+	struct layer_access_masks layer_masks_child[2] = {};
+	bool is_dom_check, child_is_directory[2] = { true, true };
 	struct path walker_path;
-	access_mask_t access_masked_parent1, access_masked_parent2;
-	struct layer_access_masks _layer_masks_child1, _layer_masks_child2;
-	struct layer_access_masks *layer_masks_child1 = NULL,
-				  *layer_masks_child2 = NULL;
 
-	if (!access_request_parent1 && !access_request_parent2)
+	if (WARN_ON_ONCE(!check_parent1))
+		return false;
+
+	if (!check_parent1->access_request &&
+	    (!check_parent2 || !check_parent2->access_request))
 		return true;
 
 	if (WARN_ON_ONCE(!path))
@@ -799,51 +796,45 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 	if (is_nouser_or_private(path->dentry))
 		return true;
 
-	if (WARN_ON_ONCE(!layer_masks_parent1))
-		return false;
-
-	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
+	check_parent1->allowed =
+		is_layer_masks_allowed(&check_parent1->layer_masks);
+	if (check_parent2)
+		check_parent2->allowed =
+			is_layer_masks_allowed(&check_parent2->layer_masks);
 
-	if (unlikely(layer_masks_parent2)) {
+	if (unlikely(check_parent2)) {
 		if (WARN_ON_ONCE(!dentry_child1))
 			return false;
 
-		allowed_parent2 = is_layer_masks_allowed(layer_masks_parent2);
-
 		/*
 		 * For a double request, first check for potential privilege
 		 * escalation by looking at domain handled accesses (which are
 		 * a superset of the meaningful requested accesses).
 		 */
-		access_masked_parent1 = access_masked_parent2 =
-			landlock_union_access_masks(domain).fs;
+		for (size_t i = 0; i < ARRAY_SIZE(checks); i++)
+			checks[i]->access_masked =
+				landlock_union_access_masks(domain).fs;
 		is_dom_check = true;
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
 			return false;
 		/* For a simple request, only check for requested accesses. */
-		access_masked_parent1 = access_request_parent1;
-		access_masked_parent2 = access_request_parent2;
+		check_parent1->access_masked = check_parent1->access_request;
 		is_dom_check = false;
 	}
 
-	if (unlikely(dentry_child1)) {
-		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-					      &_layer_masks_child1,
-					      LANDLOCK_KEY_INODE))
-			landlock_unmask_layers(find_rule(domain, dentry_child1),
-					       &_layer_masks_child1);
-		layer_masks_child1 = &_layer_masks_child1;
-		child1_is_directory = d_is_dir(dentry_child1);
-	}
-	if (unlikely(dentry_child2)) {
+	for (size_t i = 0; i < ARRAY_SIZE(layer_masks_child); i++) {
+		const struct dentry *const dentry_child =
+			i ? dentry_child2 : dentry_child1;
+
+		if (unlikely(!dentry_child))
+			continue;
 		if (landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-					      &_layer_masks_child2,
+					      &layer_masks_child[i],
 					      LANDLOCK_KEY_INODE))
-			landlock_unmask_layers(find_rule(domain, dentry_child2),
-					       &_layer_masks_child2);
-		layer_masks_child2 = &_layer_masks_child2;
-		child2_is_directory = d_is_dir(dentry_child2);
+			landlock_unmask_layers(find_rule(domain, dentry_child),
+					       &layer_masks_child[i]);
+		child_is_directory[i] = d_is_dir(dentry_child);
 	}
 
 	walker_path = *path;
@@ -869,42 +860,47 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 		 */
 		if (unlikely(is_dom_check &&
 			     no_more_access(
-				     layer_masks_parent1, layer_masks_child1,
-				     child1_is_directory, layer_masks_parent2,
-				     layer_masks_child2,
-				     child2_is_directory))) {
+				     &check_parent1->layer_masks,
+				     dentry_child1 ? &layer_masks_child[0] : NULL,
+				     child_is_directory[0],
+				     check_parent2 ?
+					     &check_parent2->layer_masks :
+					     NULL,
+				     dentry_child2 ? &layer_masks_child[1] : NULL,
+				     child_is_directory[1]))) {
 			/*
 			 * Now, downgrades the remaining checks from domain
 			 * handled accesses to requested accesses.
 			 */
 			is_dom_check = false;
-			access_masked_parent1 = access_request_parent1;
-			access_masked_parent2 = access_request_parent2;
-
-			allowed_parent1 =
-				allowed_parent1 ||
-				scope_to_request(access_masked_parent1,
-						 layer_masks_parent1);
-			allowed_parent2 =
-				allowed_parent2 ||
-				scope_to_request(access_masked_parent2,
-						 layer_masks_parent2);
+			for (size_t i = 0; i < ARRAY_SIZE(checks); i++) {
+				if (!checks[i])
+					continue;
+				checks[i]->access_masked = checks[i]->access_request;
+				checks[i]->allowed =
+					checks[i]->allowed ||
+					scope_to_request(checks[i]->access_masked,
+							 &checks[i]->layer_masks);
+			}
 
 			/* Stops when all accesses are granted. */
-			if (allowed_parent1 && allowed_parent2)
+			if (check_parent1->allowed &&
+			    (!check_parent2 || check_parent2->allowed))
 				break;
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 =
-			allowed_parent1 ||
-			landlock_unmask_layers(rule, layer_masks_parent1);
-		allowed_parent2 =
-			allowed_parent2 ||
-			landlock_unmask_layers(rule, layer_masks_parent2);
+		for (size_t i = 0; i < ARRAY_SIZE(checks); i++) {
+			if (!checks[i])
+				continue;
+			checks[i]->allowed =
+				checks[i]->allowed ||
+				landlock_unmask_layers(rule, &checks[i]->layer_masks);
+		}
 
 		/* Stops when a rule from each layer grants access. */
-		if (allowed_parent1 && allowed_parent2)
+		if (check_parent1->allowed &&
+		    (!check_parent2 || check_parent2->allowed))
 			break;
 		switch (landlock_walk_path_up(&walker_path)) {
 		/*
@@ -913,8 +909,9 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 		 * which is reachable through /proc/<pid>/ns/<namespace>).
 		 */
 		case LANDLOCK_WALK_INTERNAL:
-			allowed_parent1 = true;
-			allowed_parent2 = true;
+			check_parent1->allowed = true;
+			if (check_parent2)
+				check_parent2->allowed = true;
 			break;
 		/*
 		 * Stops at the real root.  Denies access
@@ -931,28 +928,25 @@ is_access_to_paths_allowed(const struct landlock_ruleset *const domain,
 	path_put(&walker_path);
 
 	/*
-	 * Check CONFIG_AUDIT to enable elision of log_request_parent* and
-	 * associated caller's stack variables thanks to dead code elimination.
+	 * Check CONFIG_AUDIT to enable elision of request fields and related
+	 * caller stack usage thanks to dead code elimination.
 	 */
 #ifdef CONFIG_AUDIT
-	if (!allowed_parent1 && log_request_parent1) {
-		log_request_parent1->type = LANDLOCK_REQUEST_FS_ACCESS;
-		log_request_parent1->audit.type = LSM_AUDIT_DATA_PATH;
-		log_request_parent1->audit.u.path = *path;
-		log_request_parent1->access = access_masked_parent1;
-		log_request_parent1->layer_masks = layer_masks_parent1;
-	}
+	for (size_t i = 0; i < 2; i++) {
+		struct landlock_check *const check = checks[i];
+
+		if (!check || check->allowed)
+			continue;
 
-	if (!allowed_parent2 && log_request_parent2) {
-		log_request_parent2->type = LANDLOCK_REQUEST_FS_ACCESS;
-		log_request_parent2->audit.type = LSM_AUDIT_DATA_PATH;
-		log_request_parent2->audit.u.path = *path;
-		log_request_parent2->access = access_masked_parent2;
-		log_request_parent2->layer_masks = layer_masks_parent2;
+		check->request.type = LANDLOCK_REQUEST_FS_ACCESS;
+		check->request.audit.type = LSM_AUDIT_DATA_PATH;
+		check->request.audit.u.path = *path;
+		check->request.access = check->access_masked;
+		check->request.layer_masks = &check->layer_masks;
 	}
 #endif /* CONFIG_AUDIT */
 
-	return allowed_parent1 && allowed_parent2;
+	return check_parent1->allowed && (!check_parent2 || check_parent2->allowed);
 }
 
 static int current_check_access_path(const struct path *const path,
@@ -963,21 +957,22 @@ static int current_check_access_path(const struct path *const path,
 	};
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), masks, NULL);
-	struct layer_access_masks layer_masks;
-	struct landlock_request request = {};
+	struct landlock_check check = {
+		.access_request = access_request,
+	};
 
 	if (!subject)
 		return 0;
 
-	access_request = landlock_init_layer_masks(subject->domain,
-						   access_request, &layer_masks,
-						   LANDLOCK_KEY_INODE);
-	if (is_access_to_paths_allowed(subject->domain, path, access_request,
-				       &layer_masks, &request, NULL, 0, NULL,
+	check.access_request =
+		landlock_init_layer_masks(subject->domain, check.access_request,
+					  &check.layer_masks,
+					  LANDLOCK_KEY_INODE);
+	if (is_access_to_paths_allowed(subject->domain, path, &check, NULL,
 				       NULL, NULL))
 		return 0;
 
-	landlock_log_denial(subject, &request);
+	landlock_log_denial(subject, &check.request);
 	return -EACCES;
 }
 
@@ -1013,77 +1008,6 @@ static access_mask_t maybe_remove(const struct dentry *const dentry)
 				  LANDLOCK_ACCESS_FS_REMOVE_FILE;
 }
 
-/**
- * collect_domain_accesses - Walk through a file path and collect accesses
- *
- * @domain: Domain to check against.
- * @mnt_root: Last directory to check.
- * @dir: Directory to start the walk from.
- * @layer_masks_dom: Where to store the collected accesses.
- *
- * This helper is useful to begin a path walk from the @dir directory to a
- * @mnt_root directory used as a mount point.  This mount point is the common
- * ancestor between the source and the destination of a renamed and linked
- * file.  While walking from @dir to @mnt_root, we record all the domain's
- * allowed accesses in @layer_masks_dom.
- *
- * Because of disconnected directories, this walk may not reach @mnt_dir.  In
- * this case, the walk will continue to @mnt_dir after this call.
- *
- * This is similar to is_access_to_paths_allowed() but much simpler because it
- * only handles walking on the same mount point and only checks one set of
- * accesses.
- *
- * Returns:
- * - true if all the domain access rights are allowed for @dir;
- * - false if the walk reached @mnt_root.
- */
-static bool collect_domain_accesses(const struct landlock_ruleset *const domain,
-				    const struct dentry *const mnt_root,
-				    struct dentry *dir,
-				    struct layer_access_masks *layer_masks_dom)
-{
-	bool ret = false;
-
-	if (WARN_ON_ONCE(!domain || !mnt_root || !dir || !layer_masks_dom))
-		return true;
-	if (is_nouser_or_private(dir))
-		return true;
-
-	if (!landlock_init_layer_masks(domain, LANDLOCK_MASK_ACCESS_FS,
-				       layer_masks_dom, LANDLOCK_KEY_INODE))
-		return true;
-
-	dget(dir);
-	while (true) {
-		struct dentry *parent_dentry;
-
-		/* Gets all layers allowing all domain accesses. */
-		if (landlock_unmask_layers(find_rule(domain, dir),
-					   layer_masks_dom)) {
-			/*
-			 * Stops when all handled accesses are allowed by at
-			 * least one rule in each layer.
-			 */
-			ret = true;
-			break;
-		}
-
-		/*
-		 * Stops at the mount point or the filesystem root for a disconnected
-		 * directory.
-		 */
-		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
-			break;
-
-		parent_dentry = dget_parent(dir);
-		dput(dir);
-		dir = parent_dentry;
-	}
-	dput(dir);
-	return ret;
-}
-
 /**
  * current_check_refer_path - Check if a rename or link action is allowed
  *
@@ -1144,32 +1068,24 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 {
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(current_cred(), any_fs, NULL);
-	bool allow_parent1, allow_parent2;
-	access_mask_t access_request_parent1, access_request_parent2;
 	struct path mnt_dir;
-	struct dentry *old_parent;
-	struct layer_access_masks layer_masks_parent1 = {},
-				  layer_masks_parent2 = {};
-	struct landlock_request request1 = {}, request2 = {};
+	struct path old_parent_path;
+	struct landlock_check checks[2] = {};
 
 	if (!subject)
 		return 0;
 
 	if (unlikely(d_is_negative(old_dentry)))
 		return -ENOENT;
-	if (exchange) {
-		if (unlikely(d_is_negative(new_dentry)))
-			return -ENOENT;
-		access_request_parent1 =
-			get_mode_access(d_backing_inode(new_dentry)->i_mode);
-	} else {
-		access_request_parent1 = 0;
-	}
-	access_request_parent2 =
+	if (exchange && unlikely(d_is_negative(new_dentry)))
+		return -ENOENT;
+	checks[0].access_request =
+		exchange ? get_mode_access(d_backing_inode(new_dentry)->i_mode) : 0;
+	checks[1].access_request =
 		get_mode_access(d_backing_inode(old_dentry)->i_mode);
 	if (removable) {
-		access_request_parent1 |= maybe_remove(old_dentry);
-		access_request_parent2 |= maybe_remove(new_dentry);
+		checks[0].access_request |= maybe_remove(old_dentry);
+		checks[1].access_request |= maybe_remove(new_dentry);
 	}
 
 	/* The mount points are the same for old and new paths, cf. EXDEV. */
@@ -1178,22 +1094,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		 * The LANDLOCK_ACCESS_FS_REFER access right is not required
 		 * for same-directory referer (i.e. no reparenting).
 		 */
-		access_request_parent1 = landlock_init_layer_masks(
-			subject->domain,
-			access_request_parent1 | access_request_parent2,
-			&layer_masks_parent1, LANDLOCK_KEY_INODE);
-		if (is_access_to_paths_allowed(subject->domain, new_dir,
-					       access_request_parent1,
-					       &layer_masks_parent1, &request1,
-					       NULL, 0, NULL, NULL, NULL))
-			return 0;
-
-		landlock_log_denial(subject, &request1);
-		return -EACCES;
+		return current_check_access_path(new_dir,
+			checks[0].access_request | checks[1].access_request);
 	}
 
-	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
-	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
+	checks[0].access_request |= LANDLOCK_ACCESS_FS_REFER;
+	checks[1].access_request |= LANDLOCK_ACCESS_FS_REFER;
 
 	/* Saves the common mount point. */
 	mnt_dir.mnt = new_dir->mnt;
@@ -1202,21 +1108,46 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
+	 * OPEN_TREE_CLONE).  We do not need to path_get(old_parent_path) because
 	 * we keep a reference to old_dentry.
 	 */
-	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
-						      old_dentry->d_parent;
+	old_parent_path.mnt = mnt_dir.mnt;
+	old_parent_path.dentry = unlikely(old_dentry == mnt_dir.dentry) ?
+					 old_dentry :
+					 old_dentry->d_parent;
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
-	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						old_parent,
-						&layer_masks_parent1);
-	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
-						new_dir->dentry,
-						&layer_masks_parent2);
-
-	if (allow_parent1 && allow_parent2)
+	for (size_t i = 0; i < 2; i++) {
+		struct path parent_path = i ? *new_dir : old_parent_path;
+		struct landlock_check *const check = &checks[i];
+
+		if (is_nouser_or_private(parent_path.dentry) ||
+		    !landlock_init_layer_masks(subject->domain,
+					      LANDLOCK_MASK_ACCESS_FS,
+					      &check->layer_masks,
+					      LANDLOCK_KEY_INODE)) {
+			check->allowed = true;
+			continue;
+		}
+		path_get(&parent_path);
+		do {
+			/* Gets all layers allowing all domain accesses. */
+			if (landlock_unmask_layers(find_rule(subject->domain,
+							     parent_path.dentry),
+						   &check->layer_masks)) {
+				/*
+				 * Stops when all handled accesses are
+				 * allowed by at least one rule in each
+				 * layer.
+				 */
+				check->allowed = true;
+				break;
+			}
+		} while (landlock_walk_path_up(&parent_path) ==
+				LANDLOCK_WALK_CONTINUE);
+		path_put(&parent_path);
+	}
+	if (checks[0].allowed && checks[1].allowed)
 		return 0;
 
 	/*
@@ -1226,27 +1157,26 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * destination parent access rights.
 	 */
 	if (is_access_to_paths_allowed(
-		    subject->domain, &mnt_dir, access_request_parent1,
-		    &layer_masks_parent1, &request1, old_dentry,
-		    access_request_parent2, &layer_masks_parent2, &request2,
+		    subject->domain, &mnt_dir, &checks[0], old_dentry,
+		    &checks[1],
 		    exchange ? new_dentry : NULL))
 		return 0;
 
-	if (request1.access) {
-		request1.audit.u.path.dentry = old_parent;
-		landlock_log_denial(subject, &request1);
+	if (checks[0].request.access) {
+		checks[0].request.audit.u.path.dentry = old_parent_path.dentry;
+		landlock_log_denial(subject, &checks[0].request);
 	}
-	if (request2.access) {
-		request2.audit.u.path.dentry = new_dir->dentry;
-		landlock_log_denial(subject, &request2);
+	if (checks[1].request.access) {
+		checks[1].request.audit.u.path.dentry = new_dir->dentry;
+		landlock_log_denial(subject, &checks[1].request);
 	}
 
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including
 	 * renames with RENAME_EXCHANGE.
 	 */
-	if (likely(is_eacces(&layer_masks_parent1, access_request_parent1) ||
-		   is_eacces(&layer_masks_parent2, access_request_parent2)))
+	if (likely(is_eacces(&checks[0].layer_masks, checks[0].access_request) ||
+		   is_eacces(&checks[1].layer_masks, checks[1].access_request)))
 		return -EACCES;
 
 	/*
@@ -1625,12 +1555,11 @@ static bool is_device(const struct file *const file)
 
 static int hook_file_open(struct file *const file)
 {
-	struct layer_access_masks layer_masks = {};
+	struct landlock_check check = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
 	const struct landlock_cred_security *const subject =
 		landlock_get_applicable_subject(file->f_cred, any_fs, NULL);
-	struct landlock_request request = {};
 
 	if (!subject)
 		return 0;
@@ -1651,13 +1580,14 @@ static int hook_file_open(struct file *const file)
 		optional_access |= LANDLOCK_ACCESS_FS_IOCTL_DEV;
 
 	full_access_request = open_access_request | optional_access;
+	check.access_request =
+		landlock_init_layer_masks(subject->domain, full_access_request,
+					  &check.layer_masks,
+					  LANDLOCK_KEY_INODE);
 
 	if (is_access_to_paths_allowed(
-		    subject->domain, &file->f_path,
-		    landlock_init_layer_masks(subject->domain,
-					      full_access_request, &layer_masks,
-					      LANDLOCK_KEY_INODE),
-		    &layer_masks, &request, NULL, 0, NULL, NULL, NULL)) {
+		    subject->domain, &file->f_path, &check, NULL, NULL,
+		    NULL)) {
 		allowed_access = full_access_request;
 	} else {
 		/*
@@ -1666,8 +1596,8 @@ static int hook_file_open(struct file *const file)
 		 * are still unfulfilled in any of the layers.
 		 */
 		allowed_access = full_access_request;
-		for (size_t i = 0; i < ARRAY_SIZE(layer_masks.access); i++)
-			allowed_access &= ~layer_masks.access[i];
+		for (size_t i = 0; i < ARRAY_SIZE(check.layer_masks.access); i++)
+			allowed_access &= ~check.layer_masks.access[i];
 	}
 
 	/*
@@ -1679,15 +1609,16 @@ static int hook_file_open(struct file *const file)
 	landlock_file(file)->allowed_access = allowed_access;
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->deny_masks = landlock_get_deny_masks(
-		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access, &layer_masks);
+		_LANDLOCK_ACCESS_FS_OPTIONAL, optional_access,
+		&check.layer_masks);
 #endif /* CONFIG_AUDIT */
 
 	if (access_mask_subset(open_access_request, allowed_access))
 		return 0;
 
 	/* Sets access to reflect the actual request. */
-	request.access = open_access_request;
-	landlock_log_denial(subject, &request);
+	check.request.access = open_access_request;
+	landlock_log_denial(subject, &check.request);
 	return -EACCES;
 }
 
-- 
2.51.0

