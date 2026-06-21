Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035DA1D88D7
	for <linux-security-module@vger.kernel.org>; Sun, 21 Jun 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782013955; cv=none; b=pOBfXLSlbgoiQxMRwUa8cpD89uq5ZUZqGCQcw8WTQGXQEj3emWpmmAnq/iZHA36XRjGuptkQPsc0qAbKxBnB7Z01094suMPuMad/CYRIBG9RQyZ/ugsXv6WWQ2e6WI5kZtpejlRZ8jrXq6hvPjKJLp6GLgsEOXTuo2YN+PtZFK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782013955; c=relaxed/simple;
	bh=u2Twoool7AYQ+8RFvgvgOhyaqaD5TkukRJ2q4LlvkZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6Bf6gblaGUdxMd6Bn/lGIdpR/y66pqY+qFak3DHVa/VMAK6xKKbnPo+C34g/lk+YdxrI8OSFXY7wjtl+CX0MBN10YzYUpI369Xrf+pjgRVzi+LSO+v+oGPqH+O0rsHdNLiHbAtfsNe/o6eTFj0DfZ+u8YpbmKf+XPyawi/sfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9j1faud; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9j1faud"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80236b44a1dso10741347b3.0
        for <linux-security-module@vger.kernel.org>; Sat, 20 Jun 2026 20:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782013953; x=1782618753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/pj45pats2Nd+wFJ/6L1QCJ1BMIDi313dyIV0Oc0RI=;
        b=e9j1faud5Fw8PSTbPtlO4WNdVRsW1SBVamZA5+UuNw2E1PQ4FWQw0pdDS+aEcQWL7T
         vMZ4P1Q4lKmg5HKBfHhSusuvfsVW6NgtW9S2z/0kQVEVTd09li2FddSDkpgpALgpAr9F
         NadHXhVRi0G8U50XMPGzV2w5Dk8Ug5pKiHPHkqPcZVtqzcMr+89poZER0ZREoJhJwLAn
         ySObpXOyuDYkrMB5bIPxvix68f1GTw3ER8a/cji8oHe0USKzfFyKdgKi4IVSYjsvW8+5
         kfEOq/War29Z/gxFZsefoIECW57SsgONGMLf3JvfKWQS2/nmUXI065Rqn/gCRRLOnN7B
         QsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782013953; x=1782618753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/pj45pats2Nd+wFJ/6L1QCJ1BMIDi313dyIV0Oc0RI=;
        b=DNMkFsWofDUqr+Hrj9v7GBzRYo3cIuunRW0qSA9uVALD70eKV6Phem3Zb6fFBBiNeX
         Vai7mSWkguhaTlSdcxkd4KOmpgk9z8u53lIIBGywZgnWdkeOYa2r3NqwmWTgf3YQykmM
         kanKtmBGBSVTaMwF8Y4Tf/F9Exs9Yj4NZ5Ege7A2Q4cvEBsiMvXKGV43999TNYbw99ir
         qYlJA0F0ltDYltTyYIlWb7l5+8uoNiux8vTG/MZq+VNuy8yX3shTUUTQ2Lk3TLMWnMPz
         aohYtSni54E0JUPVd75YAyeZQrDLm7j0ki6ux5Vihhh7xgFQKa9dXa/TtJl8WkBfWOjx
         MrCg==
X-Gm-Message-State: AOJu0Yxb5aSs/D68eAr8dgzhdNskRWJnLRtxoF0M9EtNrBqRzcMLa8fx
	S8Ywl6kJ6VcuPngYIecdIOd0v1kjk9xTXbrC/ohv47asXVVgCLrCuvEWZDdt1Q==
X-Gm-Gg: AfdE7cn0fMUxulSxDR5dcvJ5YL4gF0nTwaY/R0CB79Rl6WxqBYTa6zAkmncxmKfvpE6
	lVz9T65T3wQoVFY0jn3bMRRdSANDo/x3bvsAcxf6BlcB38/0CwV9/IBdumCu05ZVezMex1fxCnL
	84iXP7Ieh0m1MGEhQzNAx9+Ye6VI3GMo/fO2L/xzC8LeJgUeghS31uVocCv0unpQKxrkWezQW/K
	cxd/eczk4ADRfpwN6TX7+s8qpYn8Z1M2vhXtGvMwsMbKhuTnRT+TWyOTNnni5kvB+OnjnW0/pmL
	jDmDwp8FtiEFRz6PbS2s7CpTJYoS0oEzj6SuXYdU5D71evRg0xib7hr3ytSAJ/9Y/QHbji4fjAD
	an0vggHRuMoAOXOjUsl6mWdUMGb8gM19FJY3hDCkAE4NjU7/5R9nUyxRCkGibyLg4cXlW0wFkXF
	KZKaHPE8dymeqC9Z2Gwp5Rv62Csp6/02R9Cr5LNnwXftGBlq4MiHf1Ogz8
X-Received: by 2002:a05:690c:9981:b0:7db:a109:f12f with SMTP id 00721157ae682-801313da1b8mr95400627b3.1.1782013952573;
        Sat, 20 Jun 2026 20:52:32 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:2de9:628a:4b2:9b39])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025cf61d36sm17155677b3.11.2026.06.20.20.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 20:52:32 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	mic@digikod.net
Cc: m@maowtm.org,
	gnoack@google.com,
	gnoack3000@gmail.com,
	matthieu@buffet.re,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v9 3/9] landlock: Return inserted rule from landlock_insert_rule()
Date: Sat, 20 Jun 2026 23:52:16 -0400
Message-ID: <20260621035223.2651547-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621035223.2651547-1-utilityemal77@gmail.com>
References: <20260621035223.2651547-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change insert_rule() and landlock_insert_rule() to return the inserted
(or updated) struct landlock_rule pointer instead of an int errno.
Errors are propagated via ERR_PTR().

This gives callers a handle on the resulting rule so a subsequent change
can mutate per-layer flags on it (e.g. to mark ancestor rules created
for no-inherit topology sealing).

No functional change intended.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    Changes since v8:
    - Simplified error propagation with PTR_ERR_OR_ZERO() in
      landlock_append_fs_rule() and landlock_append_net_rule(), replacing
      the open-coded IS_ERR()/PTR_ERR() handling.
    - Rebased onto mic/next (the flags parameter is now u32).

 security/landlock/fs.c      |  6 ++--
 security/landlock/net.c     |  6 ++--
 security/landlock/ruleset.c | 68 ++++++++++++++++++-------------------
 security/landlock/ruleset.h |  7 ++--
 4 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 5b9cc450d614..fd829e06835d 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -369,7 +369,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 			    const struct path *const path,
 			    access_mask_t access_rights, const u32 flags)
 {
-	int err;
+	int err = 0;
+	struct landlock_rule *rule;
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_INODE,
 	};
@@ -388,7 +389,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	if (IS_ERR(id.key.object))
 		return PTR_ERR(id.key.object);
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
+	err = PTR_ERR_OR_ZERO(rule);
 	mutex_unlock(&ruleset->lock);
 	/*
 	 * No need to check for an error because landlock_insert_rule()
diff --git a/security/landlock/net.c b/security/landlock/net.c
index cbff59ec3aba..88b9ffcd11fb 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -23,11 +23,11 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			     const u16 port, access_mask_t access_rights,
 			     const u32 flags)
 {
-	int err;
 	const struct landlock_id id = {
 		.key.data = (__force uintptr_t)htons(port),
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
+	struct landlock_rule *rule;
 
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
@@ -36,10 +36,10 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 			 ~landlock_get_net_access_mask(ruleset, 0);
 
 	mutex_lock(&ruleset->lock);
-	err = landlock_insert_rule(ruleset, id, access_rights, flags);
+	rule = landlock_insert_rule(ruleset, id, access_rights, flags);
 	mutex_unlock(&ruleset->lock);
 
-	return err;
+	return PTR_ERR_OR_ZERO(rule);
 }
 
 static int current_check_access_socket(struct socket *const sock,
diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4dd09ea22c84..b8a35675bcbf 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -203,12 +203,13 @@ static void build_check_ruleset(void)
  * added to @ruleset as new constraints, similarly to a boolean AND between
  * access rights.
  *
- * Return: 0 on success, -errno on failure.
+ * Return: A pointer to the inserted or updated rule, or an ERR_PTR on failure.
  */
-static int insert_rule(struct landlock_ruleset *const ruleset,
-		       const struct landlock_id id,
-		       const struct landlock_layer (*layers)[],
-		       const size_t num_layers)
+static struct landlock_rule *
+insert_rule(struct landlock_ruleset *const ruleset,
+	    const struct landlock_id id,
+	    const struct landlock_layer (*layers)[],
+	    const size_t num_layers)
 {
 	struct rb_node **walker_node;
 	struct rb_node *parent_node = NULL;
@@ -218,14 +219,14 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 	might_sleep();
 	lockdep_assert_held(&ruleset->lock);
 	if (WARN_ON_ONCE(!layers))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	if (is_object_pointer(id.type) && WARN_ON_ONCE(!id.key.object))
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
 	root = get_root(ruleset, id.type);
 	if (IS_ERR(root))
-		return PTR_ERR(root);
+		return ERR_CAST(root);
 
 	walker_node = &root->rb_node;
 	while (*walker_node) {
@@ -243,7 +244,7 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 
 		/* Only a single-level layer should match an existing rule. */
 		if (WARN_ON_ONCE(num_layers != 1))
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 
 		/* If there is a matching rule, updates it. */
 		if ((*layers)[0].level == 0) {
@@ -252,16 +253,16 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 			 * landlock_add_rule(2), i.e. @ruleset is not a domain.
 			 */
 			if (WARN_ON_ONCE(this->num_layers != 1))
-				return -EINVAL;
+				return ERR_PTR(-EINVAL);
 			if (WARN_ON_ONCE(this->layers[0].level != 0))
-				return -EINVAL;
+				return ERR_PTR(-EINVAL);
 			this->layers[0].access |= (*layers)[0].access;
 			this->layers[0].flags.quiet |= (*layers)[0].flags.quiet;
-			return 0;
+			return this;
 		}
 
 		if (WARN_ON_ONCE(this->layers[0].level == 0))
-			return -EINVAL;
+			return ERR_PTR(-EINVAL);
 
 		/*
 		 * Intersects access rights when it is a merge between a
@@ -270,23 +271,23 @@ static int insert_rule(struct landlock_ruleset *const ruleset,
 		new_rule = create_rule(id, &this->layers, this->num_layers,
 				       &(*layers)[0]);
 		if (IS_ERR(new_rule))
-			return PTR_ERR(new_rule);
+			return ERR_CAST(new_rule);
 		rb_replace_node(&this->node, &new_rule->node, root);
 		free_rule(this, id.type);
-		return 0;
+		return new_rule;
 	}
 
 	/* There is no match for @id. */
 	build_check_ruleset();
 	if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
-		return -E2BIG;
+		return ERR_PTR(-E2BIG);
 	new_rule = create_rule(id, layers, num_layers, NULL);
 	if (IS_ERR(new_rule))
-		return PTR_ERR(new_rule);
+		return ERR_CAST(new_rule);
 	rb_link_node(&new_rule->node, parent_node, walker_node);
 	rb_insert_color(&new_rule->node, root);
 	ruleset->num_rules++;
-	return 0;
+	return new_rule;
 }
 
 static void build_check_layer(void)
@@ -305,9 +306,10 @@ static void build_check_layer(void)
 }
 
 /* @ruleset must be locked by the caller. */
-int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
-			 const access_mask_t access, const u32 flags)
+struct landlock_rule *
+landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		     const struct landlock_id id,
+		     const access_mask_t access, const u32 flags)
 {
 	struct landlock_layer layers[] = { {
 		.access = access,
@@ -326,9 +328,8 @@ static int merge_tree(struct landlock_ruleset *const dst,
 		      struct landlock_ruleset *const src,
 		      const enum landlock_key_type key_type)
 {
-	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_rule *walker_rule, *next_rule, *rule;
 	struct rb_root *src_root;
-	int err = 0;
 
 	might_sleep();
 	lockdep_assert_held(&dst->lock);
@@ -358,11 +359,11 @@ static int merge_tree(struct landlock_ruleset *const dst,
 		layers[0].access = walker_rule->layers[0].access;
 		layers[0].flags = walker_rule->layers[0].flags;
 
-		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
-		if (err)
-			return err;
+		rule = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
+		if (IS_ERR(rule))
+			return PTR_ERR(rule);
 	}
-	return err;
+	return 0;
 }
 
 static int merge_ruleset(struct landlock_ruleset *const dst,
@@ -412,9 +413,8 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 			struct landlock_ruleset *const child,
 			const enum landlock_key_type key_type)
 {
-	struct landlock_rule *walker_rule, *next_rule;
+	struct landlock_rule *walker_rule, *next_rule, *rule;
 	struct rb_root *parent_root;
-	int err = 0;
 
 	might_sleep();
 	lockdep_assert_held(&parent->lock);
@@ -432,12 +432,12 @@ static int inherit_tree(struct landlock_ruleset *const parent,
 			.type = key_type,
 		};
 
-		err = insert_rule(child, id, &walker_rule->layers,
-				  walker_rule->num_layers);
-		if (err)
-			return err;
+		rule = insert_rule(child, id, &walker_rule->layers,
+				   walker_rule->num_layers);
+		if (IS_ERR(rule))
+			return PTR_ERR(rule);
 	}
-	return err;
+	return 0;
 }
 
 static int inherit_ruleset(struct landlock_ruleset *const parent,
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61f3c253d5c9..c927bcb82fa3 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -217,9 +217,10 @@ void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset);
 DEFINE_FREE(landlock_put_ruleset, struct landlock_ruleset *,
 	    if (!IS_ERR_OR_NULL(_T)) landlock_put_ruleset(_T))
 
-int landlock_insert_rule(struct landlock_ruleset *const ruleset,
-			 const struct landlock_id id,
-			 const access_mask_t access, const u32 flags);
+struct landlock_rule *
+landlock_insert_rule(struct landlock_ruleset *const ruleset,
+		     const struct landlock_id id,
+		     const access_mask_t access, const u32 flags);
 
 struct landlock_ruleset *
 landlock_merge_ruleset(struct landlock_ruleset *const parent,
-- 
2.54.0

